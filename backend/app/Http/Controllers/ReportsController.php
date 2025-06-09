<?php

namespace App\Http\Controllers;

use App\Models\FavoriteJob;
use App\Models\Application;
use Illuminate\Queue\Jobs\Job;
use Illuminate\Support\Facades\DB;
use App\Models\JobListing;

class ReportsController extends Controller

{

    public function getAdminStats(): \Illuminate\Http\JsonResponse
    {
        $totalApplications = Application::count();
        $totalSeekers = DB::table('users')
            ->join('roles','users.role_id', '=', 'roles.id')
            -> where('roles.name', 'seeker')
            ->count();

        $totalEmployers = DB::table('users')
            ->join('roles','users.role_id', '=', 'roles.id')
            -> where('roles.name', 'employer')
            ->count();

        $hasData = $totalApplications > 0 || $totalSeekers > 0 || $totalEmployers > 0;

        if ($hasData) {
            return response()->json([
                'message' => 'admin statistics fetched successfully',
                'data' => [
                    'totalApplications' => $totalApplications,
                    'totalSeekers' => $totalSeekers,
                    'totalEmployers' => $totalEmployers,
                ]
            ] , 200);
        } else {
            return response()->json([
                'message' => 'no statistics data found',
                'data' => [
                    'totalApplications' => 0,
                    'totalSeekers' => 0,
                    'totalEmployers' => 0,
                ]

            ], 404);
        }

    }

    public function getEmployerStats($employerId): \Illuminate\Http\JsonResponse
    {
        $applicationsReceived = Application::whereHas('job' , function($query) use ($employerId){
            $query->where('employer_id', $employerId);
        })->count();

        $applicationSaved = FavoriteJob::whereHas('job', function ($query) use ($employerId){
            $query->where('employer_id', $employerId);
        })->count();

        $hasData = $applicationsReceived > 0 || $applicationSaved > 0;

        if ($hasData) {
            return response()->json([
                'message' => 'employer statistics fetched successfully',
                'data' =>[
                    'applicationsReceived' => $applicationsReceived,
                    'applicationSaved' => $applicationSaved,
                ]
            ],200);
        } else {
            return response()->json([
                'message' => 'no employer statistics data found',
                'data' => [
                    'applicationsReceived' => 0,
                    'applicationSaved' => 0,
                ]
            ],404);
        }
    }

    public function getAdminBarchartData(): \Illuminate\Http\JsonResponse

    {
        $data = JobListing::select('category', DB::raw('count(*) as total'))
            ->groupBy('category')
            ->get();

        if( $data->isEmpty()){
            return response()->json([
                'message' => 'Bar Chart data fetched successfully',
                'data' => $data
            ],200);
        }else {
            return response()->json([
                'message' => 'No Bar Chart data found',
                'data' => []
            ], 404);

        }
    }

    public function getEmployerLineChartData($id): \Illuminate\Http\JsonResponse

    {
        $data = Application::select(
            DB::raw("MONTH(created_at) as month_number"),
            DB::raw("DATE_FORMAT(created_at , '%M') as month_name"),
            DB::raw('count(*) as total')
        )
            ->whereHas('job' , function ($query) use ($id) {
                $query->where('employer_id', $id);
            })
            ->groupBy(DB::raw("MONTH(created_at), DATE_FORMAT(created_at , '%M')"))
            ->orderBy(DB::raw("MONTH(created_at)"))
            ->get();

        if( $data->isEmpty()){
            return response()->json([
                'message' => 'No Line Chart data found',
                'data' => [
                    'label' => [],
                    'data' => []
                ]

            ],404);
        }

        $labels = $data->pluck('month_name');
        $data = $data->pluck('total');

        return response()->json([
            'message' => 'Line Chart data fetched successfully',
            'data' => [
                'label' => $data->pluck('month_name'),
                'data' => $data->pluck('total')
            ]
        ],200);
    }

}

<?php

namespace App\Http\Controllers;

use App\Models\FavoriteJob;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class FavoriteJobController extends Controller
{

    public function index()
    {
        $jobSeeker = Auth::user()->jobSeeker;

        if (!$jobSeeker) {
            return response()->json(['message' => 'Job seeker not found'], 404);
        }

        $favorites = FavoriteJob::with('job')
            ->where('job_seeker_id', $jobSeeker->id)
            ->latest()
            ->get();

        return response()->json($favorites);
    }

    public function store(Request $request)
    {
        $request->validate([
            'job_id' => 'required|exists:job_listings,id',
        ]);

        $jobSeeker = Auth::user()->jobSeeker;

        if (!$jobSeeker) {
            return response()->json(['message' => 'Job seeker not found'], 404);
        }

        $favorite = FavoriteJob::firstOrCreate([
            'job_seeker_id' => $jobSeeker->id,
            'job_id' => $request->job_id,
        ]);

        return response()->json($favorite, 201);
    }

    public function destroy($jobId)
    {
        $jobSeeker = Auth::user()->jobSeeker;

        if (!$jobSeeker) {
            return response()->json(['message' => 'Job seeker not found'], 404);
        }

        $deleted = FavoriteJob::where('job_seeker_id', $jobSeeker->id)
            ->where('job_id', $jobId)
            ->delete();

        if ($deleted) {
            return response()->json(['message' => 'Deleted successfully']);
        }

        return response()->json(['message' => 'Not found'], 404);
    }
}

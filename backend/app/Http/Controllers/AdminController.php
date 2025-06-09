<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\JobListing;
use App\Models\Application;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller {

    public function allUsers(Request $request)
    {
        $search = $request->input('search');
        $query = User::with('role');
        if ($search) {
            $query->where('name', 'like', '%' . $search . '%');
        }
        $users = $query->get();
        return response()->json($users);
    }
    public function addUser(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'role_id' => 'required|exists:roles,id',
            'location' => 'nullable|string',
            'summary' => 'nullable|string',
            'profile_picture' => 'nullable|string',
        ]);
        $validated['password'] = Hash::make($validated['password']);
        if ($validated['role_id'] == 1) {
            $validated['is_approved'] = true;
        }

        $user = User::create($validated);
        $user->load('role');

        return response()->json([
            'message' => 'User created successfully',
            'user' => $user
        ]);
    }
    public function updateUser(Request $request, $id)
    {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users,email,' . $id,
            'role_id' => 'required|exists:roles,id',
            'location' => 'nullable|string',
            'summary' => 'nullable|string',
            'profile_picture' => 'nullable|string',
        ]);

        $user = User::findOrFail($id);
        $previousRoleId = $user->role_id;

        if ($previousRoleId != $validated['role_id']) {
            if ($previousRoleId == 1 && $validated['role_id'] == 2) {
                $validated['is_approved'] = false;
            } elseif ($previousRoleId == 2 && $validated['role_id'] == 1) {
                $validated['is_approved'] = true;
            }
        }
        $user->update($validated);
        $user->load('role');

        return response()->json([
            'message' => 'User updated successfully',
            'user' => $user
        ]);
    }
    public function deleteUser($id)
    {
        $user = User::findOrFail($id);

        if (auth()->check() && auth()->id() === $user->id) {
            return response()->json([
                'message' => 'You cannot delete your own account'
            ], 403);
        }
        $user->delete();

        return response()->json([
            'message' => 'User deleted successfully'
        ]);
    }
    public function pendingEmployerRequests()
    {
        $pendingEmployers = User::with('role')
            ->where('role_id', 1)
            ->where('is_approved', false)
            ->get();
        return response()->json($pendingEmployers);
    }
    public function approveEmployer($id)
    {
        $user = User::findOrFail($id);
        if ($user->role_id != 1 || $user->is_approved) {
            return response()->json(['message' => 'User is not pending approval'], 400);
        }
        $user->update(['is_approved' => true]);
        return response()->json(['message' => 'Employer approved successfully']);
    }
    public function rejectEmployer($id)
    {
        $user = User::findOrFail($id);
        if ($user->role_id != 1 || $user->is_approved) {
            return response()->json(['message' => 'User is not pending approval'], 400);
        }
        $user->update([
            'role_id' => 2,
        ]);
        return response()->json(['message' => 'Employer request rejected. User converted to Job Seeker']);
    }
    public function jobDemandStats()
    {
        $mostPostedJobs = JobListing::select('title', DB::raw('COUNT(*) as post_count'))
            ->groupBy('title')
            ->orderByDesc('post_count')
            ->take(3)
            ->get();

        return response()->json([
            'most_posted' => $mostPostedJobs
        ]);
    }
    public function allJobListings(Request $request)
    {
        $search = $request->query('search');

        $query = JobListing::with('employer.user')->latest();

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%$search%")
                    ->orWhereHas('employer.user', function ($q2) use ($search) {
                        $q2->where('name', 'like', "%$search%");
                    });
            });
        }
        $jobs = $query->get()->map(function ($job) {
            return [
                'id' => $job->id,
                'title' => $job->title,
                'employer_name' => $job->employer->user->name ?? 'N/A',
                'location' => $job->location,
                'created_at' => $job->created_at->toDateString(),
            ];
        });
        return response()->json($jobs);
    }
    public function deleteJobListing($id)
    {
        $job = JobListing::findOrFail($id);
        $job->delete();

        return response()->json(['message' => 'Job listing deleted successfully']);
    }
    public function userCount()
    {
        $total = User::count();
        return response()->json(['total_users' => $total]);
    }
    public function employerCount()
    {
        $count = User::where('role_id', 1)->count();
        return response()->json(['total_employers' => $count]);
    }
    public function jobSeekerCount()
    {
        $count = User::where('role_id', 2)->count();
        return response()->json(['total_job_seekers' => $count]);
    }
    public function jobListingCount()
    {
        $count = JobListing::count();
        return response()->json(['total_job_listings' => $count]);
    }
    public function acceptedApplicationsCount()
    {
        $count = Application::where('status', 'accepted')->count();
        return response()->json(['accepted_requests' => $count]);
    }
    public function rejectedApplicationsCount()
    {
        $count = Application::where('status', 'rejected')->count();
        return response()->json(['rejected_requests' => $count]);
    }
    public function latestJobListings()
    {
        $jobs = JobListing::latest()
            ->take(7)->get(['id', 'title', 'salary', 'location', 'created_at']);

        return response()->json($jobs);
    }
    public function jobOverviewTable()
    {
        $jobs = JobListing::with('employer.user')
            ->latest()
            ->take(12)
            ->get();
        $transformed = $jobs->map(function ($job) {
            return [
                'id' => $job->id,
                'title' => $job->title,
                'employer' => $job->employer->user->name ?? 'N/A',
                'location' => $job->location,
                'date' => $job->created_at->toDateString(),
            ];
        });

        return response()->json($transformed);
    }
    public function getApplicationsStats()
    {
        $now = time();
        $startDate = date('Y-m-01', strtotime('-5 months', $now));

        $applications = DB::table('applications')
            ->selectRaw('DATE_FORMAT(appliedAt, "%Y-%m") as month, COUNT(*) as total')
            ->whereNotNull('appliedAt')
            ->where('appliedAt', '>=', $startDate)
            ->groupBy('month')
            ->orderBy('month')
            ->pluck('total', 'month');
        $stats = [];
        for ($i = 5; $i >= 0; $i--) {
            $month = date('Y-m', strtotime("-{$i} months", $now));
            $stats[] = [
                'month' => $month,
                'total' => $applications[$month] ?? 0
            ];
        }
        return response()->json($stats);
    }
}

<?php
namespace App\Http\Controllers;
use App\Models\FavoriteJob;
use Illuminate\Http\Request;
use App\Http\Requests\CreateJobListingRequest;
use App\Http\Requests\UpdateJobListingRequest;
use App\Models\Employer;
use App\Models\JobListing;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use App\Models\JobSeeker;

class JobListingController extends Controller
{
    public function getRecommendedJobsForSeeker(Request $request): JsonResponse
    {
        $user = $request->user();

        if (!$user) {
            return response()->json(['error' => 'User not authenticated'], 401);
        }

        $jobSeeker = JobSeeker::where('user_id', $user->id)->first();

        if (!$jobSeeker) {
            return response()->json(['error' => 'Job Seeker not found'], 404);
        }

        if (strtolower($jobSeeker->category) === 'other') {
            $jobs = JobListing::where('isOpened', 1)->get();
        } else {
            $jobs = JobListing::whereRaw('LOWER(category) = ?', [strtolower($jobSeeker->category)])
                ->where('isOpened', 1)
                ->get();
        }

        if ($jobs->isEmpty()) {
            return response()->json(['error' => 'No jobs found'], 404);
        }

        return response()->json($jobs);
    }

    public function search(Request $request): JsonResponse
    {
        $query = $request->input('query');

        if (!$query) {
            return response()->json([]);
        }

        $jobs = JobListing::where('title', 'like', "%$query%")
            ->limit(10)
            ->get(['id', 'title']);

        return response()->json($jobs);
    }

    public function getEmployerByUser(): JsonResponse
    {
        try {
            $userId = Auth::id();
            $employer = Employer::where('user_id', $userId)->firstOrFail();
            return response()->json([
                'id' => $employer->id,
                'name' => $employer->company_name ?? null,
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Employer not found'], 404);
        }
    }

    public function getById($id): JsonResponse
    {
        try {
            $job = JobListing::with('employer')->findOrFail($id);

            return response()->json($job);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Job not found'], 404);
        }
    }

    public function getByEmployer($employerId): JsonResponse
    {
        $jobs = JobListing::with('employer')
            ->where('employer_id', $employerId)
            ->orderBy('created_at', 'desc')
            ->paginate(8);

        return response()->json($jobs);
    }

    public function create(CreateJobListingRequest $request): JsonResponse
    {
        try {
            $data = $request->validated();

            if ($request->hasFile('company_logo')) {
                $data['company_logo'] = $request->file('company_logo')->store('logos', 'public');
            }

            if ($request->hasFile('documents')) {
                $data['documents'] = $request->file('documents')->store('documents', 'public');
            }

            $job = JobListing::create($data);


            return response()->json($job, 201);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to create job', 'details' => $e->getMessage()], 500);
        }
    }

    public function update(UpdateJobListingRequest $request, $id): JsonResponse
    {
        try {
            $job = JobListing::findOrFail($id);
            $data = $request->validated();
            if ($request->hasFile('company_logo')) {
                if ($job->company_logo) {
                    Storage::disk('public')->delete($job->company_logo);
                }
                $data['company_logo'] = $request->file('company_logo')->store('logos', 'public');
            } else {
                $data['company_logo'] = $job->company_logo;
            }
            if ($request->hasFile('documents')) {
                if ($job->documents) {
                    Storage::disk('public')->delete($job->documents);
                }
                $data['documents'] = $request->file('documents')->store('documents', 'public');
            } else {
                $data['documents'] = $job->documents;
            }

            $job->update($data);
            $job->refresh();

            return response()->json($job);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to update job',
                'details' => $e->getMessage()
            ], 500);
        }
    }

    public function updateStatus(Request $request, $id): JsonResponse
    {
        try {
            $job = JobListing::findOrFail($id);
            $request->validate([
                'isOpened' => 'required|boolean',
            ]);
            $job->isOpened = $request->input('isOpened');
            $job->save();
            return response()->json([
                'message' => 'Status updated successfully',
                'job' => $job
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to update status',
                'details' => $e->getMessage()
            ], 500);
        }
    }

    public function delete($id): JsonResponse
    {
        try {
            $job = JobListing::findOrFail($id);
            $job->delete();
            return response()->json(['message' => 'Job deleted successfully']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to delete job'], 500);
        }
    }

    public function getJobFormOptions(): JsonResponse
    {
        return response()->json([
            'experienceOptions' => JobListing::EXPERIENCE_OPTIONS,
            'employmentOptions' => JobListing::EMPLOYMENT_OPTIONS,
            'categoryOptions' => JobListing::CATEGORY_OPTIONS,
        ]);
    }

    public function getJobsByCategory($category): JsonResponse
    {
        $user = auth()->user();
        $jobSeeker = $user ? $user->jobSeeker : null;

        $jobs = JobListing::where('category', $category)->get();

        $favorites = $jobSeeker
            ? FavoriteJob::where('job_seeker_id', $jobSeeker->id)->pluck('job_id')->toArray()
            : [];

        $jobs = $jobs->map(function ($job) use ($favorites) {
            $job->saved = in_array($job->id, $favorites);
            return $job;
        });

        return response()->json($jobs);
    }

    public function advancedSearch(Request $request): JsonResponse
    {
        $query = $request->input('query');

        if (!$query) {
            return response()->json([]);
        }

        $jobs = JobListing::with('employer')
            ->where(function ($q) use ($query) {
                $q->where('title', 'like', "%$query%")
                    ->orWhere('location', 'like', "%$query%")
                    ->orWhere('category', 'like', "%$query%")
                    ->orWhereHas('employer', function ($q2) use ($query) {
                        $q2->where('company_name', 'like', "%$query%");
                    });
            })
            ->get();

        return response()->json($jobs);
    }

}

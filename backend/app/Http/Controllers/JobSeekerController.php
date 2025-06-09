<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class JobSeekerController extends Controller
{
public function uploadResume(Request $request)
{
    $request->validate([
        'resume' => 'required|file|mimes:pdf|max:2048',
    ]);

    $user = auth()->user();

    if (!$user || !$user->jobSeeker) {
        return response()->json(['message' => 'Job Seeker not found.'], 404);
    }

    $path = $request->file('resume')->store('resumes', 'public');
    $user->jobSeeker->resume_path = $path;
    $user->jobSeeker->save();

    return response()->json(['message' => 'Resume uploaded successfully', 'path' => $path]);
}
public function getProfile()
{
    $jobSeeker = auth()->user()->jobSeeker;
    if (!$jobSeeker) {
        return response()->json(['message' => 'Job seeker not found'], 404);
    }

    return response()->json($jobSeeker);
}

}

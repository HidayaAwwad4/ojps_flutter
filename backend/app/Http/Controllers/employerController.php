<?php

namespace App\Http\Controllers;

use http\Client\Request;


use Illuminate\Support\Facades\Validator;


class employerController
{
    public function update(Request $request): \Illuminate\Http\JsonResponse
    {
        $user = auth()->user(); // Get logged-in employer

        // Validate incoming data
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|min:4|max:255',
            'email' => 'required|email|max:255|unique:users,email,' . $user->id,
            'company' => 'nullable|string|max:255',
            'location' => 'nullable|string|max:255',
            'bio' => 'nullable|string|max:1000',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        // Update employer's profile
        $user->update($validator->validated());

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user
        ], 200);
    }


    public function show()
    {
        $user = auth()->user(); // Get the currently authenticated employer

        return response()->json([
            'message' => 'Profile fetched successfully',
            'user' => $user
        ], 200);
    }

}

<?php

namespace App\Http\Requests;

use App\Models\JobListing;
use Illuminate\Foundation\Http\FormRequest;

class CreateJobListingRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'description' => 'required|string',
            'salary' => 'required|numeric',
            'location' => 'required|string|max:255',
            'languages' => 'required|string',
            'schedule' => 'required|string',
            'isOpened' => 'required|boolean',
            'employer_id' => 'required|integer|exists:employers,id',
            'company_logo' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            'experience' => 'required|in:' . implode(',', JobListing::EXPERIENCE_OPTIONS),
            'employment' => 'required|in:' . implode(',', JobListing::EMPLOYMENT_OPTIONS),
            'category' => 'required|in:' . implode(',', JobListing::CATEGORY_OPTIONS),
        ];
    }
}

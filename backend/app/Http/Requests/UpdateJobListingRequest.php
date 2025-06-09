<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\JobListing;

class UpdateJobListingRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => 'sometimes|string|max:255',
            'description' => 'sometimes|string',
            'salary' => 'sometimes|numeric|min:0',
            'location' => 'sometimes|string|max:255',
            'languages' => 'sometimes|string',
            'schedule' => 'sometimes|string|max:255',
            'isOpened' => 'sometimes|boolean',
            'employer_id' => 'sometimes|exists:employers,id',
            'documents' => 'nullable|file|mimes:pdf,doc,docx|max:5120',
            'company_logo' => 'nullable|file|mimes:jpg,jpeg,png|max:5120',
            'experience' => 'sometimes|in:' . implode(',', JobListing::EXPERIENCE_OPTIONS),
            'employment' => 'sometimes|in:' . implode(',', JobListing::EMPLOYMENT_OPTIONS),
            'category' => 'sometimes|in:' . implode(',', JobListing::CATEGORY_OPTIONS),
        ];
    }
}

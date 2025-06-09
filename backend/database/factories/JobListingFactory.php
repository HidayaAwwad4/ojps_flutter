<?php

namespace Database\Factories;

use App\Models\JobListing;
use App\Models\Employer;
use Illuminate\Database\Eloquent\Factories\Factory;

class JobListingFactory extends Factory
{
    protected $model = JobListing::class;

    public function definition(): array
    {
        return [
            'title' => $this->faker->jobTitle,
            'description' => $this->faker->paragraph,
            'salary' => $this->faker->numberBetween(3000, 10000),
            'location' => $this->faker->city,
            'languages' => 'English',
            'schedule' => 'Sunday, Tuesday, Thursday',
            'documents' => null,
            'company_logo' => null,
            'isOpened' => 1,
            'employer_id' => Employer::factory(),
            'category' => $this->faker->randomElement(JobListing::CATEGORY_OPTIONS),
            'experience' => $this->faker->randomElement(JobListing::EXPERIENCE_OPTIONS),
            'employment' => $this->faker->randomElement(JobListing::EMPLOYMENT_OPTIONS),

        ];

    }
}

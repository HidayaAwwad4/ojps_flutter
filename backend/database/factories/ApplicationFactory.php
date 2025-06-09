<?php

namespace Database\Factories;

use App\Models\Application;
use App\Models\JobSeeker;
use App\Models\JobListing;
use Illuminate\Database\Eloquent\Factories\Factory;

class ApplicationFactory extends Factory
{
    protected $model = Application::class;

    public function definition(): array
    {
        return [
            'job_id' => JobListing::inRandomOrder()->first()?->id ?? JobListing::factory(),
            'job_seeker_id' => JobSeeker::inRandomOrder()->first()?->id ?? JobSeeker::factory(),
            'cover_letter' => $this->faker->text(200),
            'appliedAt' => $this->faker->dateTimeBetween('-1 year', 'now'),
        ];
    }
}

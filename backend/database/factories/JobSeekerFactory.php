<?php

namespace Database\Factories;

use App\Models\JobSeeker;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class JobSeekerFactory extends Factory
{
    protected $model = JobSeeker::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'resume_path' => $this->faker->filePath(),
            'experience' => [
                [
                    'company' => $this->faker->company,
                    'role' => $this->faker->jobTitle,
                    'years' => $this->faker->numberBetween(1, 5),
                ],
            ],
            'education' => [
                [
                    'institution' => $this->faker->company,
                    'degree' => $this->faker->word,
                    'year' => $this->faker->year,
                ],
            ],
            'skills' => $this->faker->randomElements(['PHP', 'Laravel', 'JavaScript', 'Angular', 'MySQL'], 3),
        ];
    }
}

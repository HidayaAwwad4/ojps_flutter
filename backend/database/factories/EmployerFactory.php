<?php

namespace Database\Factories;

use App\Models\Employer;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class EmployerFactory extends Factory
{
    protected $model = Employer::class;

    public function definition(): array
    {
        return [
            'user_id' => User::factory()->create(['role_id' => 2, 'is_approved' => true])->id,
            'company_name' => $this->faker->company,
        ];
    }
}

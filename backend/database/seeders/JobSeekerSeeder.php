<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\JobSeeker;

class JobSeekerSeeder extends Seeder
{
    public function run(): void
    {
        JobSeeker::factory()->count(10)->create();
    }
}

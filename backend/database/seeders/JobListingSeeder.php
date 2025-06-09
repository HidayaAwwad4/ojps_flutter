<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\JobListing;

class JobListingSeeder extends Seeder
{
    public function run(): void
    {
        JobListing::factory()->count(10)->create();
    }
}

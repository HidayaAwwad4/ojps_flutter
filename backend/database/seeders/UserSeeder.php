<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        for ($i = 1; $i <= 50; $i++) {
            User::create([
                'name' => 'User ' . $i,
                'email' => 'user' . $i . '@example.com',
                'password' => Hash::make('password123'),
                'role_id' => rand(1, 3),
                'profile_picture' => 'default.png',
                'location' => 'City ' . rand(1, 10),
                'summary' => 'This is a summary for user ' . $i,
            ]);
        }
    }
}

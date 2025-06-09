<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;

class RoleSeeder extends Seeder
{
    public function run(): void
    {
        Role::insert([
            ['id' => 1, 'name' => 'Admin'],
            ['id' => 2, 'name' => 'employer'],
            ['id' => 3, 'name' => 'seeker'],
        ]);
    }
}

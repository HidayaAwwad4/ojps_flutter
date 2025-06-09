<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('job_seekers', function (Blueprint $table) {
            if (DB::connection()->getDriverName() === 'mysql') {
                DB::statement('ALTER TABLE job_seekers MODIFY experience JSON NULL');
                DB::statement('ALTER TABLE job_seekers MODIFY education JSON NULL');
                DB::statement('ALTER TABLE job_seekers MODIFY skills JSON NULL');
            }
        });
        
        DB::table('job_seekers')->whereNull('experience')->update(['experience' => '[]']);
        DB::table('job_seekers')->whereNull('education')->update(['education' => '[]']);
        DB::table('job_seekers')->whereNull('skills')->update(['skills' => '[]']);
    }

    public function down(): void
    {
    }
};
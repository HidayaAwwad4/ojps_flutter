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
            if (Schema::hasColumn('job_seekers', 'experience')) {
                $table->dropColumn('experience');
            }
            if (Schema::hasColumn('job_seekers', 'education')) {
                $table->dropColumn('education');
            }
            if (Schema::hasColumn('job_seekers', 'skills')) {
                $table->dropColumn('skills');
            }
            
            $table->text('experience')->nullable();
            $table->text('education')->nullable();
            $table->text('skills')->nullable();
        });
        
        DB::table('job_seekers')->whereNull('experience')->update(['experience' => '[]']);
        DB::table('job_seekers')->whereNull('education')->update(['education' => '[]']);
        DB::table('job_seekers')->whereNull('skills')->update(['skills' => '[]']);
    }

    public function down(): void
    {
    }
};
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void

        {Schema::create('favorite_jobs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('job_seeker_id')->constrained('job_seekers')->onDelete('cascade');
            $table->foreignId('job_id')->constrained('job_listings')->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('favorite_jobs');
    }
};

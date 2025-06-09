<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('applications', function (Blueprint $table) {
            $table->id();
            $table->integer('job_id');
            $table->integer('job_seeker_id');
            $table->string('cover_letter')->nullable();
            $table->string('status')->default('pending');
            $table->dateTime('appliedAt')->nullable();
            $table->timestamps();
        });
    }
    public function down(): void
    {
        Schema::dropIfExists('applications');
    }
};

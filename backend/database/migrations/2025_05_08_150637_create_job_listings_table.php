<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('job_listings', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description');
            $table->decimal('salary', 10, 2);
            $table->string('location');
            $table->string('category');
            $table->string('languages');
            $table->string('schedule');
            $table->string('experience');
            $table->string('employment');
            $table->string('company_logo')->nullable();
            $table->string('documents')->nullable();
            $table->boolean('isOpened')->default(1);
            $table->foreignId('employer_id')->constrained('employers')->onDelete('cascade');
            $table->timestamps();
        });

    }
    public function down(): void
    {
        Schema::dropIfExists('job_listings');
    }
};

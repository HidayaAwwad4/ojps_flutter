<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class JobSeeker extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'user_id',
        'resume_path',
        'experience',
        'education',
        'skills',
        'category'
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function applications(): HasMany
    {
        return $this->hasMany(Application::class, 'job_seeker_id');
    }

    public function favoriteJobs(): HasMany
    {
        return $this->hasMany(FavoriteJob::class, 'job_seeker_id');
    }
}
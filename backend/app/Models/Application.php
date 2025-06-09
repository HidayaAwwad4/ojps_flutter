<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
class Application extends Model
{
    use HasFactory;
    protected $fillable = [
        'job_id',
        'job_seeker_id',
        'cover_letter',
        'status',
        'appliedAt'
    ];

    public function jobSeeker(): BelongsTo
    {
        return $this->belongsTo(JobSeeker::class, 'job_seeker_id');
    }

    public function job(): BelongsTo
    {
        return $this->belongsTo(JobListing::class);
    }
}


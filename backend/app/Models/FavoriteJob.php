<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class FavoriteJob extends Model
{
    protected $fillable = [
        'job_seeker_id',
        'job_id'
    ];

    public function jobSeeker(): BelongsTo
    {
        return $this->belongsTo(JobSeeker::class, 'job_seeker_id');
    }

    public function job(): BelongsTo
    {
        return $this->belongsTo(JobListing::class, 'job_id');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Support\Facades\Storage;

class JobListing extends Model
{
    use HasFactory;
    const EXPERIENCE_OPTIONS = ['0-1 years', '1-3 years', '3+ years', 'Not required'];
    const EMPLOYMENT_OPTIONS = ['Full-Time', 'Part-Time', 'Remote', 'Contract', 'Internship', 'Temporary', 'Volunteer'];
    const CATEGORY_OPTIONS = ['Marketing', 'Technology', 'Design', 'Sales', 'Cooking', 'Other'];
    protected $fillable = [
        'title',
        'description',
        'salary',
        'location',
        'category',
        'languages',
        'schedule',
        'experience',
        'employment',
        'documents',
        'company_logo',
        'isOpened',
        'employer_id'
    ];


    public function favoriteJobs(): HasMany
    {
        return $this->hasMany(FavoriteJob::class, 'job_id');
    }

    public function employer(): BelongsTo
    {
        return $this->belongsTo(Employer::class, 'employer_id');
    }

    public function getCompanyLogoAttribute($value)
    {
        return $value ? config('app.url') . Storage::url($value) : null;
    }

    public function getDocumentsAttribute($value)
    {
        return $value ? config('app.url') . Storage::url($value) : null;
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class SystemModule extends Model
{
    protected $fillable = [
        'key',
        'label',
        'route',
        'icon',
        'order',
    ];

    public function accessProfiles(): BelongsToMany
    {
        return $this->belongsToMany(
            AccessProfile::class,
            'access_profile_modules',
            'system_module_id',
            'access_profile_id'
        );
    }
}

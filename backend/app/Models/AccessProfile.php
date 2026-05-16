<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class AccessProfile extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'name',
        'description',
        'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    /**
     * Módulos do sistema vinculados a este perfil.
     */
    public function modules(): BelongsToMany
    {
        return $this->belongsToMany(
            SystemModule::class,
            'access_profile_modules',
            'access_profile_id',
            'system_module_id'
        )->orderBy('order');
    }

    /**
     * Usuários que possuem este perfil.
     */
    public function users(): BelongsToMany
    {
        return $this->belongsToMany(
            User::class,
            'user_access_profiles',
            'access_profile_id',
            'user_id'
        );
    }

    /**
     * Retorna todos os módulos (keys) acessíveis por este perfil.
     */
    public function moduleKeys(): array
    {
        return $this->modules->pluck('key')->toArray();
    }
}

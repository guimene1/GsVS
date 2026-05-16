<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;

class User extends Authenticatable implements JWTSubject
{
    use Notifiable;

    protected $fillable = [
        'name',
        'cpf',
        'email',
        'password',
        'phone',
        'role',
        'administrative_unit',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password'          => 'hashed',
    ];

    // ── JWT ───────────────────────────────────────────────────────────────────

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [
            'role' => $this->role,
            'name' => $this->name,
        ];
    }

    // ── Relacionamentos ───────────────────────────────────────────────────────

    /**
     * Perfis de acesso atribuídos ao usuário.
     */
    public function accessProfiles(): BelongsToMany
    {
        return $this->belongsToMany(
            AccessProfile::class,
            'user_access_profiles',
            'user_id',
            'access_profile_id'
        );
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    /**
     * Verifica se o usuário é administrador.
     * Admin tem acesso irrestrito a todos os módulos.
     */
    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

    /**
     * Retorna todos os módulos (keys) que o usuário pode acessar,
     * consolidando todos os perfis atribuídos.
     * Admin retorna ['*'] indicando acesso total.
     */
    public function allowedModules(): array
    {
        if ($this->isAdmin()) {
            return ['*'];
        }

        return $this->accessProfiles()
            ->with('modules')
            ->get()
            ->flatMap(fn($profile) => $profile->modules->pluck('key'))
            ->unique()
            ->values()
            ->toArray();
    }
}

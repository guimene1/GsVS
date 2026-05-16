<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AccessProfile;
use App\Models\SystemModule;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class AccessProfileController extends Controller
{
    // ── Listar ────────────────────────────────────────────────────────────────

    /**
     * GET /api/access-profiles
     * Lista todos os perfis com seus módulos.
     */
    public function index(Request $request): JsonResponse
    {
        $query = AccessProfile::with('modules:id,key,label,route,icon,order');

        // Filtro opcional por status ativo
        if ($request->has('active')) {
            $query->where('is_active', filter_var($request->active, FILTER_VALIDATE_BOOLEAN));
        }

        // Busca por nome
        if ($request->filled('search')) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        $profiles = $query->orderBy('name')->get();

        return response()->json($profiles);
    }

    // ── Criar ─────────────────────────────────────────────────────────────────

    /**
     * POST /api/access-profiles
     * Cria um novo perfil de acesso com os módulos selecionados.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name'        => 'required|string|max:100|unique:access_profiles,name',
            'description' => 'nullable|string|max:255',
            'is_active'   => 'boolean',
            'module_ids'  => 'required|array|min:1',
            'module_ids.*' => [
                'integer',
                Rule::exists('system_modules', 'id'),
            ],
        ], [
            'name.required'        => 'O nome do perfil é obrigatório.',
            'name.unique'          => 'Já existe um perfil com este nome.',
            'module_ids.required'  => 'Selecione ao menos um módulo.',
            'module_ids.min'       => 'Selecione ao menos um módulo.',
            'module_ids.*.exists'  => 'Um ou mais módulos informados são inválidos.',
        ]);

        $profile = DB::transaction(function () use ($validated) {
            $profile = AccessProfile::create([
                'name'        => $validated['name'],
                'description' => $validated['description'] ?? null,
                'is_active'   => $validated['is_active'] ?? true,
            ]);

            $profile->modules()->sync($validated['module_ids']);

            return $profile;
        });

        return response()->json(
            $profile->load('modules:id,key,label,route,icon,order'),
            201
        );
    }

    // ── Exibir ────────────────────────────────────────────────────────────────

    /**
     * GET /api/access-profiles/{id}
     * Retorna um perfil com seus módulos e usuários vinculados.
     */
    public function show(AccessProfile $accessProfile): JsonResponse
    {
        $accessProfile->load([
            'modules:id,key,label,route,icon,order',
            'users:id,name,cpf,email,role',
        ]);

        return response()->json($accessProfile);
    }

    // ── Atualizar ─────────────────────────────────────────────────────────────

    /**
     * PUT /api/access-profiles/{id}
     * Atualiza um perfil e ressincroniza os módulos.
     */
    public function update(Request $request, AccessProfile $accessProfile): JsonResponse
    {
        $validated = $request->validate([
            'name' => [
                'required',
                'string',
                'max:100',
                Rule::unique('access_profiles', 'name')->ignore($accessProfile->id),
            ],
            'description'  => 'nullable|string|max:255',
            'is_active'    => 'boolean',
            'module_ids'   => 'required|array|min:1',
            'module_ids.*' => [
                'integer',
                Rule::exists('system_modules', 'id'),
            ],
        ], [
            'name.required'       => 'O nome do perfil é obrigatório.',
            'name.unique'         => 'Já existe um perfil com este nome.',
            'module_ids.required' => 'Selecione ao menos um módulo.',
            'module_ids.min'      => 'Selecione ao menos um módulo.',
            'module_ids.*.exists' => 'Um ou mais módulos informados são inválidos.',
        ]);

        DB::transaction(function () use ($validated, $accessProfile) {
            $accessProfile->update([
                'name'        => $validated['name'],
                'description' => $validated['description'] ?? null,
                'is_active'   => $validated['is_active'] ?? $accessProfile->is_active,
            ]);

            $accessProfile->modules()->sync($validated['module_ids']);
        });

        return response()->json(
            $accessProfile->fresh()->load('modules:id,key,label,route,icon,order')
        );
    }

    // ── Excluir ───────────────────────────────────────────────────────────────

    /**
     * DELETE /api/access-profiles/{id}
     * Soft-delete do perfil. Remove também os vínculos com usuários.
     */
    public function destroy(AccessProfile $accessProfile): JsonResponse
    {
        // Impede exclusão de perfis com usuários ativos vinculados
        $userCount = $accessProfile->users()->count();
        if ($userCount > 0) {
            return response()->json([
                'message' => "Este perfil está vinculado a {$userCount} usuário(s) e não pode ser excluído. Desvincule os usuários antes de excluir.",
            ], 422);
        }

        DB::transaction(function () use ($accessProfile) {
            $accessProfile->modules()->detach();
            $accessProfile->delete(); // soft delete
        });

        return response()->json(['message' => 'Perfil excluído com sucesso.']);
    }

    // ── Ativar / Desativar ────────────────────────────────────────────────────

    /**
     * PATCH /api/access-profiles/{id}/toggle-active
     * Alterna o status ativo/inativo do perfil.
     */
    public function toggleActive(AccessProfile $accessProfile): JsonResponse
    {
        $accessProfile->update(['is_active' => !$accessProfile->is_active]);

        $status = $accessProfile->is_active ? 'ativado' : 'desativado';

        return response()->json([
            'message'   => "Perfil {$status} com sucesso.",
            'is_active' => $accessProfile->is_active,
        ]);
    }

    // ── Módulos disponíveis ───────────────────────────────────────────────────

    /**
     * GET /api/access-profiles/modules
     * Retorna todos os módulos do sistema disponíveis para seleção.
     */
    public function modules(): JsonResponse
    {
        $modules = SystemModule::orderBy('order')->get();

        return response()->json($modules);
    }
}

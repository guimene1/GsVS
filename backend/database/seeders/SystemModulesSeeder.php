<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SystemModulesSeeder extends Seeder
{
    /**
     * Módulos do sistema GsVS — espelha as rotas definidas no AppRoutes do Flutter.
     * A ordem define a posição na sidebar.
     */
    public function run(): void
    {
        $modules = [
            [
                'key'   => 'dashboard',
                'label' => 'Dashboard',
                'route' => '/dashboard',
                'icon'  => 'dashboard_rounded',
                'order' => 1,
            ],
            [
                'key'   => 'usuarios',
                'label' => 'Usuários',
                'route' => '/usuarios',
                'icon'  => 'people_alt_rounded',
                'order' => 2,
            ],
            [
                'key'   => 'solicitacoes',
                'label' => 'Solicitações',
                'route' => '/solicitacoes',
                'icon'  => 'assignment_rounded',
                'order' => 3,
            ],
            [
                'key'   => 'viagens',
                'label' => 'Viagens',
                'route' => '/viagens',
                'icon'  => 'flight_takeoff_rounded',
                'order' => 4,
            ],
            [
                'key'   => 'veiculos',
                'label' => 'Veículos',
                'route' => '/veiculos',
                'icon'  => 'directions_car_rounded',
                'order' => 5,
            ],
            [
                'key'   => 'motoristas',
                'label' => 'Motoristas',
                'route' => '/motoristas',
                'icon'  => 'person_pin_rounded',
                'order' => 6,
            ],
            [
                'key'   => 'unidades',
                'label' => 'Unidades',
                'route' => '/unidades',
                'icon'  => 'business_rounded',
                'order' => 7,
            ],
            [
                'key'   => 'relatorios',
                'label' => 'Relatórios',
                'route' => '/relatorios',
                'icon'  => 'bar_chart_rounded',
                'order' => 8,
            ],
            [
                'key'   => 'logs',
                'label' => 'Logs do Sistema',
                'route' => '/logs',
                'icon'  => 'receipt_long_rounded',
                'order' => 9,
            ],
            [
                'key'   => 'configuracoes',
                'label' => 'Configurações',
                'route' => '/configuracoes',
                'icon'  => 'settings_rounded',
                'order' => 10,
            ],
        ];

        foreach ($modules as $module) {
            DB::table('system_modules')->updateOrInsert(
                ['key' => $module['key']],
                array_merge($module, [
                    'created_at' => now(),
                    'updated_at' => now(),
                ])
            );
        }

        $this->command->info('✔ Módulos do sistema cadastrados com sucesso.');
    }
}

<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call(SystemModulesSeeder::class);

        User::firstOrCreate(
            ['email' => 'admin@prudentopolis.pr.gov.br'],
            [
                'name'                => 'Administrador',
                'cpf'                 => '000.000.000-00',
                'email'               => 'admin@gmail.com',
                'password'            => Hash::make('Admin@123'),
                'phone'               => '(42) 99999-0000',
                'role'                => 'admin',
                'administrative_unit' => 'TI / Sistemas',
            ]
        );
    }
}
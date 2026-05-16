<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('system_modules', function (Blueprint $table) {
            $table->id();
            $table->string('key')->unique();       // ex: 'usuarios', 'viagens'
            $table->string('label');               // ex: 'Usuários', 'Viagens'
            $table->string('route');               // ex: '/usuarios', '/viagens'
            $table->string('icon')->nullable();    // ex: 'people_alt_rounded'
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('system_modules');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('access_profile_modules', function (Blueprint $table) {
            $table->id();
            $table->foreignId('access_profile_id')
                ->constrained('access_profiles')
                ->cascadeOnDelete();
            $table->foreignId('system_module_id')
                ->constrained('system_modules')
                ->cascadeOnDelete();
            $table->timestamps();

            $table->unique(['access_profile_id', 'system_module_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('access_profile_modules');
    }
};

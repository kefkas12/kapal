<?php

namespace Tests\Feature;

use App\Http\Controllers\T_doc_cargoController;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Testing\TestResponse;
use PDO;
use Tests\TestCase;

class DocCargoClaimOptionsTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        if (! in_array('sqlite', PDO::getAvailableDrivers(), true)) {
            $this->markTestSkipped('Driver PDO SQLite tidak tersedia pada environment ini.');
        }

        $this->assertSame('sqlite', DB::connection()->getDriverName());
        $this->assertSame(':memory:', DB::connection()->getDatabaseName());

        Schema::create('t_master_cable', function (Blueprint $table): void {
            $table->id();
            $table->integer('id_vessel');
            $table->string('no_voyage_gab');
            $table->string('status');
            $table->string('atd_port')->nullable();
            $table->string('ata_port')->nullable();
            $table->string('atd_time')->nullable();
            $table->string('ata_time')->nullable();
        });
        Schema::create('m_grade', function (Blueprint $table): void {
            $table->id();
            $table->string('grade');
            $table->string('price_bbl')->nullable();
        });
        Schema::create('t_doc_cargo', function (Blueprint $table): void {
            $table->id();
            $table->integer('id_cable');
            $table->integer('id_grade')->nullable();
            $table->string('no_voyage_gab');
            $table->string('grade')->nullable();
            $table->string('price_bbl')->nullable();
            $table->string('status');
        });
        Schema::create('t_klaim', function (Blueprint $table): void {
            $table->id();
            $table->string('jenis_klaim');
        });
        Schema::create('t_klaim_detail', function (Blueprint $table): void {
            $table->id();
            $table->integer('id_klaim');
            $table->integer('id_doc_cargo')->nullable();
            $table->integer('id_cable')->nullable();
        });
    }

    public function test_spob_option_contains_route_and_times_for_cable_outside_first_page(): void
    {
        DB::table('t_master_cable')->insert([
            'id' => 863,
            'id_vessel' => 45,
            'no_voyage_gab' => 'AB5FL9/25017/D1',
            'status' => 'APPROVE',
            'atd_port' => 'TG. UBAN',
            'ata_port' => 'JAMBI',
            'atd_time' => '2025-11-06 15:00:00',
            'ata_time' => '2025-11-08 03:00:00',
        ]);
        $newerCables = [];
        for ($index = 1; $index <= 101; $index++) {
            $newerCables[] = [
                'id' => 863 + $index,
                'id_vessel' => 45,
                'no_voyage_gab' => 'AB5FL9/NEW/'.$index,
                'status' => 'APPROVE',
            ];
        }
        DB::table('t_master_cable')->insert($newerCables);
        $this->insertDocCargo();

        $this->fetchClaimOptions()
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.id', 1545)
            ->assertJsonPath('data.0.id_cable', 863)
            ->assertJsonPath('data.0.grade_display', 'B40')
            ->assertJsonPath('data.0.atd_port', 'TG. UBAN')
            ->assertJsonPath('data.0.ata_port', 'JAMBI')
            ->assertJsonPath('data.0.atd_time', '2025-11-06 15:00:00')
            ->assertJsonPath('data.0.ata_time', '2025-11-08 03:00:00');
    }

    public function test_missing_cable_keeps_doc_cargo_with_null_route_fields(): void
    {
        $this->insertDocCargo();

        $this->fetchClaimOptions(false)
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonStructure(['data' => [['atd_port', 'ata_port', 'atd_time', 'ata_time']]])
            ->assertJsonPath('data.0.atd_port', null)
            ->assertJsonPath('data.0.ata_port', null)
            ->assertJsonPath('data.0.atd_time', null)
            ->assertJsonPath('data.0.ata_time', null);
    }

    private function insertDocCargo(): void
    {
        DB::table('t_doc_cargo')->insert([
            'id' => 1545,
            'id_cable' => 863,
            'no_voyage_gab' => 'AB5FL9/25017/D1',
            'grade' => 'B40',
            'status' => 'APPROVE',
        ]);
    }

    private function fetchClaimOptions(bool $filterVessel = true): TestResponse
    {
        $request = Request::create('/api/doc_cargo', 'GET', [
            'id_vessel' => $filterVessel ? 45 : null,
            'status' => 'APPROVE',
            'available_for_klaim' => 1,
            'jenis_klaim' => 'SPOB',
            'per_page' => 1000,
            'sort_by' => 'id',
            'sort_dir' => 'desc',
        ]);

        return TestResponse::fromBaseResponse(app(T_doc_cargoController::class)->index($request));
    }
}

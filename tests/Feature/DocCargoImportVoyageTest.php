<?php

namespace Tests\Feature;

use App\Http\Controllers\T_doc_cargoController;
use App\Models\T_master_cable;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Validation\ValidationException;
use PDO;
use ReflectionMethod;
use Tests\TestCase;

class DocCargoImportVoyageTest extends TestCase
{
    private bool $schemaPrepared = false;

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
            $table->string('no_voyage_gab');
            $table->string('no_voyage_gab_penyesuaian')->nullable();
            $table->string('status_voyage')->nullable();
        });
        $this->schemaPrepared = true;
    }

    protected function tearDown(): void
    {
        if ($this->schemaPrepared) {
            Schema::dropIfExists('t_master_cable');
        }

        parent::tearDown();
    }

    public function test_selects_normal_deviation_and_bunker_without_collapsing_their_shared_base(): void
    {
        $this->insertCable(1, 'AB5FL9/24002/L', 'deviasi', 'AB5FL9/24002/L-D');
        $this->insertCable(2, 'AB5FL9/24002/L', 'bunker', 'AB5FL9/24002/L-B');
        $this->insertCable(3, 'AB5FL9/24002/L');

        $this->assertSame(3, $this->resolveCable('AB5FL9/24002/L')?->id);
        $this->assertSame(1, $this->resolveCable(' ab5fl9/24002/l-d ')?->id);
        $this->assertSame(2, $this->resolveCable('AB5FL9/24002/L-B')?->id);
    }

    public function test_derives_suffix_when_adjusted_voyage_is_missing(): void
    {
        $this->insertCable(1, ' AB5FL9/24002/L ', ' DEVIASI ');
        $this->insertCable(2, 'AB5FL9/24002/L', 'bunker', '');

        $this->assertSame(1, $this->resolveCable('AB5FL9/24002/L-D')?->id);
        $this->assertSame(2, $this->resolveCable('AB5FL9/24002/L-B')?->id);
        $this->assertNull($this->resolveCable('AB5FL9/24002/L'));
    }

    public function test_adjusted_identity_takes_precedence_over_base_and_derived_identity(): void
    {
        $this->insertCable(1, 'AB5FL9/24002/L', 'deviasi', ' CUSTOM/24002/L-D ');

        $this->assertSame(1, $this->resolveCable('custom/24002/l-d')?->id);
        $this->assertNull($this->resolveCable('AB5FL9/24002/L-D'));
        $this->assertNull($this->resolveCable('AB5FL9/24002/L'));
    }

    public function test_missing_special_voyage_does_not_fall_back_to_normal_cable(): void
    {
        $this->insertCable(1, 'AB5FL9/24002/L');

        $this->assertNull($this->resolveCable('AB5FL9/24002/L-D'));
        $this->assertNull($this->resolveCable('AB5FL9/24002/L-B'));
        $this->assertNull($this->resolveCable('MISSING/24002/L'));
    }

    public function test_duplicate_effective_identity_is_rejected(): void
    {
        $this->insertCable(1, 'AB5FL9/24002/L', 'deviasi', 'AB5FL9/24002/L-D');
        $this->insertCable(2, 'ab5fl9/24002/l', 'deviasi');

        $this->expectException(ValidationException::class);

        $this->resolveCable('AB5FL9/24002/L-D');
    }

    public function test_duplicate_normal_identity_is_rejected(): void
    {
        $this->insertCable(1, 'AB5FL9/24002/L');
        $this->insertCable(2, ' ab5fl9/24002/l ');

        $this->expectException(ValidationException::class);

        $this->resolveCable('AB5FL9/24002/L');
    }

    public function test_parser_keeps_normal_deviation_and_bunker_groups_separate_for_same_grade(): void
    {
        $parser = new ReflectionMethod(T_doc_cargoController::class, 'parseDocCargoImportRows');
        $parsed = $parser->invoke(new T_doc_cargoController, [
            ['No Voyage', 'Grade', 'Bill of Lading'],
            ['AB5FL9/24002/L', 'PERTALITE', '100'],
            ['AB5FL9/24002/L-D', 'PERTALITE', '200'],
            ['AB5FL9/24002/L-B', 'PERTALITE', '300'],
        ]);

        $this->assertCount(3, $parsed['groups']);
        $this->assertSame(['100', '200', '300'], array_column(array_column($parsed['groups'], 'fields'), 'bill_of_lading'));
    }

    private function insertCable(int $id, string $voyage, ?string $status = null, ?string $adjustedVoyage = null): void
    {
        DB::table('t_master_cable')->insert([
            'id' => $id,
            'no_voyage_gab' => $voyage,
            'no_voyage_gab_penyesuaian' => $adjustedVoyage,
            'status_voyage' => $status,
        ]);
    }

    private function resolveCable(string $voyage): ?T_master_cable
    {
        $resolver = new ReflectionMethod(T_doc_cargoController::class, 'resolveDocCargoImportCable');

        return $resolver->invoke(new T_doc_cargoController, $voyage);
    }
}

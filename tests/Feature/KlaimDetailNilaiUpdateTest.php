<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Laravel\Sanctum\Sanctum;
use PDO;
use Tests\TestCase;

class KlaimDetailNilaiUpdateTest extends TestCase
{
    private bool $schemaPrepared = false;

    protected function setUp(): void
    {
        parent::setUp();

        if (! in_array('sqlite', PDO::getAvailableDrivers(), true)) {
            $this->markTestSkipped('Driver PDO SQLite tidak tersedia pada environment ini.');
        }

        Schema::create('t_klaim', function (Blueprint $table): void {
            $table->id();
            $table->string('no_klaim_akhir')->nullable();
            $table->string('tgl_klaim_akhir')->nullable();
            $table->string('status');
            $table->timestamps();
        });
        Schema::create('t_klaim_detail', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('id_klaim');
            $table->string('status');
            $table->timestamps();
        });
        Schema::create('t_klaim_detail_nilai', function (Blueprint $table): void {
            $table->id();
            $table->unsignedBigInteger('id_klaim_detail');
            $table->string('sub_jenis', 10);
            $table->string('currency')->nullable();
            $table->string('kurs')->nullable();
            $table->string('val_potensi')->nullable();
            $table->string('val_klaim_awal')->nullable();
            $table->string('val_klaim_akhir')->nullable();
            $table->string('val_klaim_akhir_idr')->nullable();
            $table->string('status');
            $table->unsignedBigInteger('user_id');
            $table->timestamps();
        });
        $this->schemaPrepared = true;

        $user = new User;
        $user->forceFill(['id' => 7, 'name' => 'Tester', 'email' => 'tester@example.com']);
        $user->setRelation('roles', new Collection);
        Sanctum::actingAs($user);

        DB::table('t_klaim')->insert([
            'id' => 333,
            'no_klaim_akhir' => 'FINAL-333',
            'tgl_klaim_akhir' => '2026-07-15',
            'status' => 'OPEN',
        ]);
        DB::table('t_klaim_detail')->insert([
            'id' => 638,
            'id_klaim' => 333,
            'status' => 'OPEN',
        ]);
        DB::table('t_klaim_detail_nilai')->insert([
            [
                'id' => 931,
                'id_klaim_detail' => 638,
                'sub_jenis' => 'SS',
                'currency' => 'USD',
                'kurs' => '16000',
                'val_potensi' => '1144.5',
                'val_klaim_awal' => '100',
                'val_klaim_akhir' => '90',
                'val_klaim_akhir_idr' => '1440000',
                'status' => 'OPEN',
                'user_id' => 1,
            ],
            [
                'id' => 932,
                'id_klaim_detail' => 638,
                'sub_jenis' => 'OB',
                'currency' => 'IDR',
                'kurs' => '1',
                'val_potensi' => '0',
                'val_klaim_awal' => '200',
                'val_klaim_akhir' => '180',
                'val_klaim_akhir_idr' => '180',
                'status' => 'OPEN',
                'user_id' => 1,
            ],
        ]);
    }

    protected function tearDown(): void
    {
        if ($this->schemaPrepared) {
            Schema::dropIfExists('t_klaim_detail_nilai');
            Schema::dropIfExists('t_klaim_detail');
            Schema::dropIfExists('t_klaim');
        }

        parent::tearDown();
    }

    public function test_awal_update_changes_only_selected_nilai_row(): void
    {
        $response = $this->putJson('/api/klaim_detail_nilai/931', [
            'stage' => 'AWAL',
            'val_klaim_awal' => '125.5',
        ]);

        $response->assertOk()->assertJsonPath('data.id', 931);
        $this->assertSame('125.5', DB::table('t_klaim_detail_nilai')->where('id', 931)->value('val_klaim_awal'));
        $this->assertSame('200', DB::table('t_klaim_detail_nilai')->where('id', 932)->value('val_klaim_awal'));
    }

    public function test_akhir_update_changes_only_selected_row_and_calculates_idr(): void
    {
        $response = $this->putJson('/api/klaim_detail_nilai/931', [
            'stage' => 'AKHIR',
            'val_klaim_akhir' => '95',
        ]);

        $response->assertOk()->assertJsonPath('data.id', 931);
        $selected = DB::table('t_klaim_detail_nilai')->where('id', 931)->first();
        $sibling = DB::table('t_klaim_detail_nilai')->where('id', 932)->first();

        $this->assertSame('95', $selected->val_klaim_akhir);
        $this->assertSame('1520000', $selected->val_klaim_akhir_idr);
        $this->assertSame('180', $sibling->val_klaim_akhir);
    }

    public function test_approved_detail_cannot_be_changed(): void
    {
        DB::table('t_klaim_detail')->where('id', 638)->update(['status' => 'APPROVE']);

        $response = $this->putJson('/api/klaim_detail_nilai/931', [
            'stage' => 'AWAL',
            'val_klaim_awal' => '999',
        ]);

        $response->assertUnprocessable()->assertJsonValidationErrors('status');
        $this->assertSame('100', DB::table('t_klaim_detail_nilai')->where('id', 931)->value('val_klaim_awal'));
    }
}

<?php

namespace App\Support;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class KlaimEstimateSyncService
{
    public function syncCable(int $idCable, $oldSpeed, $newSpeed, $oldBunker, $newBunker): int
    {
        $updated = 0;

        $updated += $this->syncRows('SS', $oldSpeed, $newSpeed, function ($query) use ($idCable) {
            $query->where('detail.id_cable', $idCable);
        });

        $updated += $this->syncRows('OB', $oldBunker, $newBunker, function ($query) use ($idCable) {
            $query->where('detail.id_cable', $idCable)
                ->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) != ?', ['SPOB']);
        });

        return $updated;
    }

    public function syncDocCargo(int $idDocCargo, ?int $idCable, $oldPumping, $newPumping, $oldBunker, $newBunker, $oldTransport, $newTransport): int
    {
        $updated = 0;

        $updated += $this->syncRows('SP', $oldPumping, $newPumping, function ($query) use ($idDocCargo, $idCable) {
            $this->whereDocCargoPointer($query, $idDocCargo, $idCable);
        });

        $updated += $this->syncRows('OB', $oldBunker, $newBunker, function ($query) use ($idDocCargo, $idCable) {
            $this->whereDocCargoPointer($query, $idDocCargo, $idCable);
            $query->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) = ?', ['SPOB']);
        });

        $updated += $this->syncRows('TL', $oldTransport, $newTransport, function ($query) use ($idDocCargo, $idCable) {
            $this->whereDocCargoPointer($query, $idDocCargo, $idCable);
        });

        return $updated;
    }

    public function syncOffHire(int $idOffHire, $oldOh, $newOh, $oldBoh, $newBoh): int
    {
        $updated = 0;

        $updated += $this->syncRows('OH', $oldOh, $newOh, function ($query) use ($idOffHire) {
            $this->whereOffHirePointer($query, $idOffHire);
        });

        $updated += $this->syncRows('BOH', $oldBoh, $newBoh, function ($query) use ($idOffHire) {
            $this->whereOffHirePointer($query, $idOffHire);
        });

        return $updated;
    }

    public function syncRedeliveryDelivery(int $idRedeliveryDelivery, $oldBod, $newBod): int
    {
        return $this->syncRows('BOD', $oldBod, $newBod, function ($query) use ($idRedeliveryDelivery) {
            $this->whereRedeliveryPointer($query, $idRedeliveryDelivery);
        });
    }

    private function syncRows(string $subJenis, $oldValue, $newValue, callable $scope): int
    {
        $query = DB::table('t_klaim_detail_nilai as nilai')
            ->join('t_klaim_detail as detail', 'detail.id', '=', 'nilai.id_klaim_detail')
            ->join('t_klaim as klaim', 'klaim.id', '=', 'detail.id_klaim')
            ->whereRaw('UPPER(COALESCE(klaim.status, "")) = ?', ['OPEN'])
            ->whereRaw('UPPER(COALESCE(detail.status, "")) = ?', ['OPEN'])
            ->whereRaw('UPPER(COALESCE(nilai.status, "")) = ?', ['OPEN'])
            ->whereRaw('UPPER(COALESCE(nilai.sub_jenis, "")) = ?', [strtoupper($subJenis)]);

        $scope($query);

        $rows = $query->get(['nilai.id', 'nilai.val_klaim_awal']);
        $updated = 0;

        foreach ($rows as $row) {
            $payload = [
                'val_potensi' => $newValue,
                'updated_at' => now(),
            ];

            if ($this->shouldSyncKlaimAwal($row->val_klaim_awal ?? null, $oldValue)) {
                $payload['val_klaim_awal'] = $newValue;
            }

            DB::table('t_klaim_detail_nilai')
                ->where('id', $row->id)
                ->update($payload);

            $updated++;
        }

        return $updated;
    }

    private function whereDocCargoPointer($query, int $idDocCargo, ?int $idCable): void
    {
        if (Schema::hasColumn('t_klaim_detail', 'id_doc_cargo')) {
            $query->where(function ($sub) use ($idDocCargo, $idCable) {
                $sub->where('detail.id_doc_cargo', $idDocCargo);

                if ($idCable) {
                    $sub->orWhere(function ($legacy) use ($idCable) {
                        $legacy->whereNull('detail.id_doc_cargo')
                            ->where('detail.id_cable', $idCable);
                    });
                }
            });

            return;
        }

        if ($idCable) {
            $query->where('detail.id_cable', $idCable);
        } else {
            $query->whereRaw('1 = 0');
        }
    }

    private function whereOffHirePointer($query, int $idOffHire): void
    {
        if (Schema::hasColumn('t_klaim_detail', 'id_off_hire')) {
            $query->where(function ($sub) use ($idOffHire) {
                $sub->where('detail.id_off_hire', $idOffHire)
                    ->orWhere(function ($legacy) use ($idOffHire) {
                        $legacy->whereNull('detail.id_off_hire')
                            ->where('detail.id_cable', $idOffHire)
                            ->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) IN (?, ?, ?)', ['OH', 'BOH', 'OHBOH']);
                    });
            });

            return;
        }

        $query->where('detail.id_cable', $idOffHire)
            ->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) IN (?, ?, ?)', ['OH', 'BOH', 'OHBOH']);
    }

    private function whereRedeliveryPointer($query, int $idRedeliveryDelivery): void
    {
        if (Schema::hasColumn('t_klaim_detail', 'id_redelivery_delivery')) {
            $query->where(function ($sub) use ($idRedeliveryDelivery) {
                $sub->where('detail.id_redelivery_delivery', $idRedeliveryDelivery)
                    ->orWhere(function ($legacy) use ($idRedeliveryDelivery) {
                        $legacy->whereNull('detail.id_redelivery_delivery')
                            ->where('detail.id_cable', $idRedeliveryDelivery)
                            ->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) = ?', ['BOD']);
                    });
            });

            return;
        }

        $query->where('detail.id_cable', $idRedeliveryDelivery)
            ->whereRaw('UPPER(COALESCE(klaim.jenis_klaim, "")) = ?', ['BOD']);
    }

    private function shouldSyncKlaimAwal($currentValue, $oldEstimate): bool
    {
        if ($this->isBlank($currentValue)) {
            return true;
        }

        $currentNumber = $this->toNumber($currentValue);
        if ($currentNumber !== null && abs($currentNumber) < 0.000001) {
            return true;
        }

        $oldNumber = $this->toNumber($oldEstimate);
        return $currentNumber !== null
            && $oldNumber !== null
            && abs($currentNumber - $oldNumber) < 0.000001;
    }

    private function isBlank($value): bool
    {
        return trim((string) ($value ?? '')) === '';
    }

    private function toNumber($value): ?float
    {
        if ($value === null || $value === '') {
            return null;
        }

        $str = trim((string) $value);
        if ($str === '') {
            return null;
        }

        if (str_contains($str, ',') && str_contains($str, '.')) {
            if (strrpos($str, ',') > strrpos($str, '.')) {
                $str = str_replace('.', '', $str);
                $str = str_replace(',', '.', $str);
            } else {
                $str = str_replace(',', '', $str);
            }
        } elseif (str_contains($str, ',')) {
            $str = str_replace(',', '.', $str);
        }

        $cleaned = preg_replace('/[^0-9.\-]/', '', $str);
        if ($cleaned === null || $cleaned === '' || $cleaned === '-' || $cleaned === '.') {
            return null;
        }

        return (float) $cleaned;
    }
}

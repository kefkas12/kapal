<?php

namespace App\Http\Controllers;

use App\Models\T_klaim_detail;
use App\Models\T_klaim_detail_nilai;
use App\Models\T_klaim;
use App\Models\File_upload;
use App\Models\T_master_cable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_klaim_detailController extends Controller
{
    private function getSubJenisByJenisKlaim(?string $jenisKlaim): array
    {
        $jenis = strtoupper((string) $jenisKlaim);
        return match ($jenis) {
            'SSOB' => ['SS', 'OB'],
            'SPOB' => ['SP', 'OB'],
            'OHBOH' => ['OH', 'BOH'],
            'TL' => ['TL'],
            'BOD' => ['BOD'],
            default => [$jenis !== '' ? $jenis : 'SS'],
        };
    }

    private function parseNilaiItems(Request $request): array
    {
        $raw = $request->input('nilai_items');
        if (is_array($raw)) {
            return $raw;
        }
        if (is_string($raw) && trim($raw) !== '') {
            $decoded = json_decode($raw, true);
            return is_array($decoded) ? $decoded : [];
        }
        return [];
    }

    private function syncNilaiRows(int $klaimDetailId, int $klaimId, Request $request): array
    {
        $klaim = T_klaim::where('id', $klaimId)->first();
        $subJenisDefaults = $this->getSubJenisByJenisKlaim($klaim?->jenis_klaim);
        $nilaiItems = $this->parseNilaiItems($request);
        $idCable = $request->input('id_cable');
        $cable = null;
        if ($idCable) {
            $cable = T_master_cable::where('id', $idCable)->first();
        }

        if (empty($nilaiItems)) {
            $nilaiItems = array_map(fn ($subJenis) => [
                'sub_jenis' => $subJenis,
            ], $subJenisDefaults);
        }

        $existingRows = T_klaim_detail_nilai::where('id_klaim_detail', $klaimDetailId)
            ->get()
            ->keyBy(fn ($row) => strtoupper((string) $row->sub_jenis));

        $keepIds = [];
        $rowsBySubJenis = [];

        foreach ($nilaiItems as $item) {
            $subJenis = strtoupper(trim((string) ($item['sub_jenis'] ?? '')));
            if ($subJenis === '') {
                continue;
            }

            $row = $existingRows->get($subJenis) ?? new T_klaim_detail_nilai();
            $row->id_klaim_detail = $klaimDetailId;
            $row->sub_jenis = $subJenis;
            $row->currency = $item['currency'] ?? $request->input('currency') ?? $klaim?->currency;
            $row->kurs = $item['kurs'] ?? $request->input('kurs');
            $valPotensi = $item['val_potensi'] ?? $request->input('val_potensi');
            if ($subJenis === 'SS' && $cable) {
                $valPotensi = $cable->est_claim_speed;
            } elseif ($subJenis === 'OB' && $cable) {
                $valPotensi = $cable->est_claim_bunker;
            }
            $row->val_potensi = $valPotensi;
            $row->val_klaim_awal = $item['val_klaim_awal'] ?? $request->input('val_klaim_awal');
            $row->val_klaim_akhir = $item['val_klaim_akhir'] ?? $request->input('val_klaim_akhir');
            $row->val_klaim_akhir_idr = $item['val_klaim_akhir_idr'] ?? $request->input('val_klaim_akhir_idr');
            $row->no_tagihan_klaim = $item['no_tagihan_klaim'] ?? $request->input('no_tagihan_klaim');
            $row->no_tagihan_dipotong = $item['no_tagihan_dipotong'] ?? $request->input('no_tagihan_dipotong');
            $row->status = $item['status'] ?? $request->input('status') ?? 'OPEN';
            $row->user_id = Auth::id();
            $row->save();

            $keepIds[] = $row->id;
            $rowsBySubJenis[$subJenis] = $row;
        }

        $toDeleteRows = T_klaim_detail_nilai::where('id_klaim_detail', $klaimDetailId)
            ->when(!empty($keepIds), fn ($q) => $q->whereNotIn('id', $keepIds))
            ->get();

        foreach ($toDeleteRows as $row) {
            $this->deleteFilesByNilaiId((int) $row->id);
            $row->delete();
        }

        return $rowsBySubJenis;
    }

    private function deleteFilesByNilaiId(int $nilaiId): void
    {
        $files = File_upload::where('id_klaim_detail_nilai', $nilaiId)->get();
        foreach ($files as $file) {
            if ($file->nama_file) {
                $disk = Storage::disk('public');
                if ($disk->exists($file->nama_file)) {
                    $disk->delete($file->nama_file);
                }
            }
            $file->delete();
        }
    }

    private function attachFilesToNilaiRows($nilaiRows)
    {
        $nilaiRows = collect($nilaiRows)->values();
        $ids = $nilaiRows->pluck('id')->filter()->values();
        if ($ids->isEmpty()) {
            return $nilaiRows;
        }

        $filesByNilai = File_upload::whereIn('id_klaim_detail_nilai', $ids)
            ->orderBy('id', 'asc')
            ->get()
            ->groupBy('id_klaim_detail_nilai');

        foreach ($nilaiRows as $row) {
            $row->files = collect($filesByNilai->get($row->id, []))->values();
        }

        return $nilaiRows;
    }

    private function storeFilesPerNilai(Request $request, array $rowsBySubJenis): void
    {
        if (empty($rowsBySubJenis)) {
            return;
        }

        $filesBySubJenis = $request->file('files_by_sub_jenis', []);
        if (is_array($filesBySubJenis)) {
            foreach ($filesBySubJenis as $subJenis => $fileList) {
                $sub = strtoupper((string) $subJenis);
                $row = $rowsBySubJenis[$sub] ?? null;
                if (!$row) {
                    continue;
                }
                $list = is_array($fileList) ? $fileList : [$fileList];
                foreach ($list as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/klaim_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_klaim_detail_nilai = $row->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }
        }

        // Backward compatibility: jika frontend lama kirim files[] umum, simpan ke sub-jenis pertama.
        $legacyFiles = $request->file('files', []);
        if ($legacyFiles) {
            $firstRow = collect($rowsBySubJenis)->first();
            if ($firstRow) {
                foreach ($legacyFiles as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/klaim_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_klaim_detail_nilai = $firstRow->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }
        }
    }

    private function attachNilaiItemsToDetails($details)
    {
        $ids = collect($details)->pluck('id')->filter()->values();
        if ($ids->isEmpty()) {
            return $details;
        }

        $nilaiRows = T_klaim_detail_nilai::whereIn('id_klaim_detail', $ids)
            ->orderBy('id', 'asc')
            ->get()
            ->groupBy('id_klaim_detail');

        foreach ($details as $detail) {
            $rows = collect($nilaiRows->get($detail->id, []))->values();
            $detail->nilai_items = $rows;

            $first = $rows->first();
            $detail->val_potensi = $first->val_potensi ?? null;
            $detail->val_klaim_awal = $first->val_klaim_awal ?? null;
            $detail->val_klaim_akhir = $first->val_klaim_akhir ?? null;
            $detail->kurs = $first->kurs ?? null;
            $detail->val_klaim_akhir_idr = $first->val_klaim_akhir_idr ?? null;
            $detail->no_tagihan_klaim = $first->no_tagihan_klaim ?? null;
            $detail->no_tagihan_dipotong = $first->no_tagihan_dipotong ?? null;
        }

        return $details;
    }

    public function index(Request $request)
    {
        $query = T_klaim_detail::query()->select('t_klaim_detail.*');

        $idKlaim = $request->input('id_klaim');
        if (!is_null($idKlaim) && $idKlaim !== '') {
            $query->where('t_klaim_detail.id_klaim', $idKlaim);
        }

        $data = $query->get();
        $data = $this->attachNilaiItemsToDetails($data);

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim_detail berhasil diambil',
            'data'    => $data
        ]);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = T_klaim_detail::query()
            ->where('t_klaim_detail.id', $id)
            ->select('t_klaim_detail.*')
            ->first();

        if ($data) {
            $rows = T_klaim_detail_nilai::where('id_klaim_detail', $data->id)
                ->orderBy('id', 'asc')
                ->get()
                ->values();
            $rows = $this->attachFilesToNilaiRows($rows);
            $data->nilai_items = $rows;

            $first = $rows->first();
            $data->val_potensi = $first->val_potensi ?? null;
            $data->val_klaim_awal = $first->val_klaim_awal ?? null;
            $data->val_klaim_akhir = $first->val_klaim_akhir ?? null;
            $data->kurs = $first->kurs ?? null;
            $data->val_klaim_akhir_idr = $first->val_klaim_akhir_idr ?? null;
            $data->no_tagihan_klaim = $first->no_tagihan_klaim ?? null;
            $data->no_tagihan_dipotong = $first->no_tagihan_dipotong ?? null;
        }

        $nilaiIds = collect($data?->nilai_items ?? [])->pluck('id')->filter()->values();
        $files = $nilaiIds->isEmpty()
            ? collect()
            : File_upload::whereIn('id_klaim_detail_nilai', $nilaiIds)->orderBy('id', 'asc')->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim_detail berhasil diambil',
            'data'    => [
                'detail' => $data,
                'files' => $files,
            ]
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim_detail = new T_klaim_detail();
            $t_klaim_detail->id_klaim = $request->input('id_klaim');
            $t_klaim_detail->id_cable = $request->input('id_cable');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            $rowsBySubJenis = $this->syncNilaiRows($t_klaim_detail->id, (int) $t_klaim_detail->id_klaim, $request);
            $this->storeFilesPerNilai($request, $rowsBySubJenis);

            if ($t_klaim_detail->status === 'CLOSE' && $t_klaim_detail->id_cable) {
                T_master_cable::where('id', $t_klaim_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil ditambah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function edit(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_klaim_detail = T_klaim_detail::where('id', $id)->firstOrFail();
            $t_klaim_detail->id_klaim = $request->input('id_klaim');
            $t_klaim_detail->id_cable = $request->input('id_cable');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            $rowsBySubJenis = $this->syncNilaiRows($t_klaim_detail->id, (int) $t_klaim_detail->id_klaim, $request);
            $this->storeFilesPerNilai($request, $rowsBySubJenis);

            if ($t_klaim_detail->status === 'CLOSE' && $t_klaim_detail->id_cable) {
                T_master_cable::where('id', $t_klaim_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil diubah'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function delete(Request $request)
    {
        $id = $request->route('id');

        try {
            DB::beginTransaction();
            $t_klaim_detail = T_klaim_detail::where('id', $id)->firstOrFail();

            $nilaiRows = T_klaim_detail_nilai::where('id_klaim_detail', $id)->get();
            foreach ($nilaiRows as $row) {
                $this->deleteFilesByNilaiId((int) $row->id);
            }
            T_klaim_detail_nilai::where('id_klaim_detail', $id)->delete();
            $t_klaim_detail->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim_detail berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}

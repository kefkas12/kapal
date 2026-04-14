<?php

namespace App\Http\Controllers;

use App\Models\T_klaim_detail;
use App\Models\T_klaim_detail_nilai;
use App\Models\T_klaim;
use App\Models\File_upload;
use App\Models\T_doc_cargo;
use App\Models\T_master_cable;
use App\Support\FileUploadHelper;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

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

    private function findDocCargoByKlaimContext($idCable, $noVoyageGab): ?T_doc_cargo
    {
        $query = T_doc_cargo::query();

        if (!empty($idCable)) {
            $query->where('id_cable', $idCable);
        } elseif (!empty($noVoyageGab)) {
            $query->where('no_voyage_gab', $noVoyageGab);
        } else {
            return null;
        }

        return $query->orderByDesc('id')->first();
    }

    private function syncNilaiRows(int $klaimDetailId, int $klaimId, Request $request): array
    {
        $klaim = T_klaim::where('id', $klaimId)->first();
        $jenisKlaim = strtoupper((string) $klaim?->jenis_klaim);
        $subJenisDefaults = $this->getSubJenisByJenisKlaim($klaim?->jenis_klaim);
        $nilaiItems = $this->parseNilaiItems($request);
        $idCable = $request->input('id_cable');
        $noVoyageGab = $request->input('no_voyage_gab');

        $cable = null;
        if ($idCable) {
            $cable = T_master_cable::where('id', $idCable)->first();
            $noVoyageGab = $noVoyageGab ?: $cable?->no_voyage_gab;
        }

        $docCargo = $this->findDocCargoByKlaimContext($idCable, $noVoyageGab);

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
            } elseif ($subJenis === 'OB') {
                if ($jenisKlaim === 'SPOB' && $docCargo) {
                    $valPotensi = $docCargo->est_claim_bunker;
                } elseif ($cable) {
                    $valPotensi = $cable->est_claim_bunker;
                }
            } elseif ($subJenis === 'SP' && $docCargo) {
                $valPotensi = $docCargo->est_claim_pumping;
            } elseif ($subJenis === 'TL' && $docCargo) {
                $valPotensi = $docCargo->est_claim_transport ?? $docCargo->est_transport_loss;
            }
            $row->val_potensi = $valPotensi;
            $row->val_klaim_awal = $item['val_klaim_awal'] ?? $request->input('val_klaim_awal');
            $row->val_klaim_akhir = $item['val_klaim_akhir'] ?? $request->input('val_klaim_akhir');
            $row->val_klaim_akhir_idr = $item['val_klaim_akhir_idr'] ?? $request->input('val_klaim_akhir_idr');
            $row->no_tagihan_klaim = $item['no_tagihan_klaim'] ?? $request->input('no_tagihan_klaim');
            $row->no_tagihan_dipotong = $item['no_tagihan_dipotong'] ?? $request->input('no_tagihan_dipotong');
            $row->status = 'OPEN';
            $row->user_id = Auth::id();
            $row->save();

            $keepIds[] = $row->id;
            $rowsBySubJenis[$subJenis] = $row;
        }

        $toDeleteRows = T_klaim_detail_nilai::where('id_klaim_detail', $klaimDetailId)
            ->when(!empty($keepIds), fn ($q) => $q->whereNotIn('id', $keepIds))
            ->get();

        foreach ($toDeleteRows as $row) {
            $row->delete();
        }

        return $rowsBySubJenis;
    }

    private function deleteFilesByKlaimDetailId(int $klaimDetailId): void
    {
        $files = File_upload::where('id_klaim_detail', $klaimDetailId)->get();
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

    private function attachFilesToNilaiRows($nilaiRows, int $klaimDetailId)
    {
        $nilaiRows = collect($nilaiRows)->values();
        if ($nilaiRows->isEmpty()) {
            return $nilaiRows;
        }

        $files = File_upload::where('id_klaim_detail', $klaimDetailId)
            ->orderBy('id', 'asc')
            ->get()
            ->values();

        foreach ($nilaiRows as $row) {
            $row->files = $files;
        }

        return $nilaiRows;
    }

    private function storeFilesPerNilai(Request $request, int $klaimDetailId): void
    {
        $files = [];

        $incomingFiles = $request->file('files', []);
        if (!is_array($incomingFiles)) {
            $incomingFiles = $incomingFiles ? [$incomingFiles] : [];
        }
        $files = array_merge($files, $incomingFiles);

        // Backward compatibility: tetap terima payload lama files_by_sub_jenis[*][]
        $filesBySubJenis = $request->file('files_by_sub_jenis', []);
        if (is_array($filesBySubJenis)) {
            foreach ($filesBySubJenis as $fileList) {
                $list = is_array($fileList) ? $fileList : [$fileList];
                $files = array_merge($files, $list);
            }
        }

        foreach ($files as $file) {
            if (!$file) {
                continue;
            }
            $path = FileUploadHelper::storeWithOriginalName($file, 'uploads/klaim_detail');
            $upload = new File_upload();
            $upload->id_klaim_detail = $klaimDetailId;
            $upload->nama_file = $path;
            $upload->save();
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

    private function hasUploadedFiles($fileValue): bool
    {
        if (is_array($fileValue)) {
            foreach ($fileValue as $f) {
                if ($f) {
                    return true;
                }
            }
            return false;
        }

        return (bool) $fileValue;
    }

    private function hasUploadedFilesBySubJenis($rawFilesBySubJenis): bool
    {
        if (!is_array($rawFilesBySubJenis)) {
            return false;
        }

        foreach ($rawFilesBySubJenis as $fileValue) {
            if ($this->hasUploadedFiles($fileValue)) {
                return true;
            }
        }

        return false;
    }

    private function isKlaimAwal(?T_klaim $klaim): bool
    {
        if (!$klaim) {
            return false;
        }

        return empty($klaim->no_klaim_akhir) && empty($klaim->tgl_klaim_akhir);
    }

    private function validateRequiredFilesOnCreate(Request $request, int $klaimId): void
    {
        $klaim = T_klaim::where('id', $klaimId)->first();
        $requiredSubJenis = $this->getSubJenisByJenisKlaim($klaim?->jenis_klaim);

        $errors = [];
        $hasIncomingFiles = $this->hasUploadedFiles($request->file('files', []))
            || $this->hasUploadedFilesBySubJenis($request->file('files_by_sub_jenis', []));
        if (!empty($requiredSubJenis) && !$hasIncomingFiles) {
            $errors['files'] = 'File upload wajib diisi.';
        }

        if (!empty($errors)) {
            throw ValidationException::withMessages($errors);
        }
    }

    private function validateRequiredFilesOnEdit(Request $request, int $klaimDetailId): void
    {
        $errors = [];
        $hasIncomingFiles = $this->hasUploadedFiles($request->file('files', []))
            || $this->hasUploadedFilesBySubJenis($request->file('files_by_sub_jenis', []));
        $hasExistingFiles = File_upload::where('id_klaim_detail', $klaimDetailId)->exists();
        if (!$hasIncomingFiles && !$hasExistingFiles) {
            $errors['files'] = 'File upload wajib diisi.';
        }

        if (!empty($errors)) {
            throw ValidationException::withMessages($errors);
        }
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
            $rows = $this->attachFilesToNilaiRows($rows, (int) $data->id);
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

        $files = $data?->id
            ? File_upload::where('id_klaim_detail', $data->id)->orderBy('id', 'asc')->get()
            : collect();
        
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
            $idKlaim = (int) $request->input('id_klaim');
            $klaim = $idKlaim > 0 ? T_klaim::where('id', $idKlaim)->first() : null;
            $shouldRequireFiles = $idKlaim > 0 && !$this->isKlaimAwal($klaim);

            if ($shouldRequireFiles) {
                $this->validateRequiredFilesOnCreate($request, $idKlaim);
            }

            $t_klaim_detail = new T_klaim_detail();
            $t_klaim_detail->id_klaim = $idKlaim;
            $t_klaim_detail->id_cable = $request->input('id_cable');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->status = 'OPEN';
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            $this->syncNilaiRows($t_klaim_detail->id, (int) $t_klaim_detail->id_klaim, $request);
            if ($shouldRequireFiles) {
                $this->validateRequiredFilesOnEdit($request, (int) $t_klaim_detail->id);
            }
            $this->storeFilesPerNilai($request, (int) $t_klaim_detail->id);

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
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            $this->syncNilaiRows($t_klaim_detail->id, (int) $t_klaim_detail->id_klaim, $request);
            $this->storeFilesPerNilai($request, (int) $t_klaim_detail->id);

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
            $this->deleteFilesByKlaimDetailId((int) $id);
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

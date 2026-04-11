<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use App\Models\File_upload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\ValidationException;

class M_kontrakController extends Controller
{
    public function index(Request $request)
    {
        $fetchAll = $request->boolean('all', false);
        if ($fetchAll) {
            $data = M_kontrak::get();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil diambil',
                'data'    => $data
            ]);
        }

        $perPage = (int) $request->input('per_page', 10);
        if ($perPage < 1) {
            $perPage = 10;
        }
        if ($perPage > 100) {
            $perPage = 100;
        }

        $query = M_kontrak::query();

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('no_kontrak', 'like', "%{$search}%")
                    ->orWhere('tgl_awal_kontrak', 'like', "%{$search}%")
                    ->orWhere('tgl_akhir_kontrak', 'like', "%{$search}%")
                    ->orWhere('charter_rate', 'like', "%{$search}%")
                    ->orWhere('speed', 'like', "%{$search}%")
                    ->orWhere('me_ballast', 'like', "%{$search}%")
                    ->orWhere('me_laden', 'like', "%{$search}%")
                    ->orWhere('pumping_rate', 'like', "%{$search}%")
                    ->orWhere('discharge', 'like', "%{$search}%")
                    ->orWhere('status', 'like', "%{$search}%");
            });
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('status', $status);
        }

        $idVessel = $request->input('id_vessel');
        if (!is_null($idVessel) && $idVessel !== '') {
            $query->where('id_vessel', $idVessel);
        }

        $allowedSort = ['id', 'no_kontrak', 'tgl_awal_kontrak', 'tgl_akhir_kontrak', 'charter_rate', 'speed', 'me_ballast', 'me_laden', 'pumping_rate', 'discharge', 'status', 'created_at'];
        $sortBy = $request->input('sort_by', 'id');
        if (!in_array($sortBy, $allowedSort, true)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($sortBy, $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data M_kontrak berhasil diambil',
            'data'    => $paginator->items(),
            'meta'    => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ]
        ]);
    }

    public function search(Request $request)
    {
        return $this->index($request);
    }

    public function details(Request $request)
    {
        $id = $request->route('id');

        $data = M_kontrak::query()
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 'm_kontrak.id_vessel')
            ->where('m_kontrak.id', $id)
            ->select('m_kontrak.*', 'm_vessel.kode_vessel')
            ->first();

        $files = File_upload::where('id_kontrak', $id)
            ->orderBy('id', 'asc')
            ->get();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_kontrak berhasil diambil',
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
            $request->validate([
                'id_vessel' => 'required|exists:m_vessel,id',
                'no_kontrak' => 'required|string|unique:m_kontrak,no_kontrak',
                'tgl_awal_kontrak' => 'nullable|date',
                'tgl_akhir_kontrak' => 'nullable|date|after:tgl_awal_kontrak',
            ], [
                'id_vessel.required' => 'Vessel wajib diisi.',
                'id_vessel.exists' => 'Vessel tidak valid.',
                'no_kontrak.required' => 'No Kontrak wajib diisi.',
                'no_kontrak.unique' => 'No Kontrak sudah digunakan.',
                'tgl_akhir_kontrak.after' => 'Tgl akhir kontrak harus lebih besar dari tgl awal kontrak.',
            ]);

            $tglAwalBaru = $request->input('tgl_awal_kontrak');
            if ($tglAwalBaru) {
                $lastKontrak = M_kontrak::where('id_vessel', $request->input('id_vessel'))
                    ->whereNotNull('tgl_akhir_kontrak')
                    ->orderByDesc('tgl_akhir_kontrak')
                    ->orderByDesc('id')
                    ->first();

                if ($lastKontrak && strtotime($tglAwalBaru) <= strtotime((string) $lastKontrak->tgl_akhir_kontrak)) {
                    DB::rollBack();
                    throw ValidationException::withMessages([
                        'tgl_awal_kontrak' => 'Tgl awal kontrak baru harus lebih besar dari tgl akhir kontrak terakhir (' . $lastKontrak->tgl_akhir_kontrak . ').',
                    ]);
                }
            }

            $m_kontrak = new M_kontrak();
            $m_kontrak->id_vessel = $request->input('id_vessel');
            $m_kontrak->no_kontrak = $request->input('no_kontrak');
            $m_kontrak->tgl_awal_kontrak = $request->input('tgl_awal_kontrak');
            $m_kontrak->tgl_akhir_kontrak = $request->input('tgl_akhir_kontrak');
            $m_kontrak->charter_rate = $request->input('charter_rate');
            $m_kontrak->speed = $request->input('speed');
            $m_kontrak->me_ballast = $request->input('me_ballast');
            $m_kontrak->me_laden = $request->input('me_laden');
            $m_kontrak->pumping_rate = $request->input('pumping_rate');
            $m_kontrak->discharge = $request->input('discharge');
            $m_kontrak->status = $request->input('status');
            $m_kontrak->user_id = Auth::id();
            $m_kontrak->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/kontrak', 'public');
                    $upload = new File_upload();
                    $upload->id_kontrak = $m_kontrak->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

            M_kontrak::where('id_vessel', $m_kontrak->id_vessel)
                ->where('id', '!=', $m_kontrak->id)
                ->update(['status' => 'NON ACTIVE']);

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil ditambah',
                'data' => $m_kontrak
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
            $request->validate([
                'no_kontrak' => 'required|string|unique:m_kontrak,no_kontrak,' . $id,
                'tgl_awal_kontrak' => 'nullable|date',
                'tgl_akhir_kontrak' => 'nullable|date|after:tgl_awal_kontrak',
            ], [
                'no_kontrak.required' => 'No Kontrak wajib diisi.',
                'no_kontrak.unique' => 'No Kontrak sudah digunakan.',
                'tgl_akhir_kontrak.after' => 'Tgl akhir kontrak harus lebih besar dari tgl awal kontrak.',
            ]);
            $m_kontrak = M_kontrak::where('id', $id)->firstOrFail();
            $m_kontrak->no_kontrak = $request->input('no_kontrak');
            $m_kontrak->tgl_awal_kontrak = $request->input('tgl_awal_kontrak');
            $m_kontrak->tgl_akhir_kontrak = $request->input('tgl_akhir_kontrak');
            $m_kontrak->charter_rate = $request->input('charter_rate');
            $m_kontrak->speed = $request->input('speed');
            $m_kontrak->me_ballast = $request->input('me_ballast');
            $m_kontrak->me_laden = $request->input('me_laden');
            $m_kontrak->pumping_rate = $request->input('pumping_rate');
            $m_kontrak->discharge = $request->input('discharge');
            $m_kontrak->status = $request->input('status');
            $m_kontrak->user_id = Auth::id();
            $m_kontrak->save();

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/kontrak', 'public');
                    $upload = new File_upload();
                    $upload->id_kontrak = $m_kontrak->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
            }

            if ($m_kontrak->status === 'ACTIVE') {
                M_kontrak::where('id_vessel', $m_kontrak->id_vessel)
                    ->where('id', '!=', $m_kontrak->id)
                    ->update(['status' => 'NON ACTIVE']);
            }
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil diubah'
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
            $m_kontrak = M_kontrak::where('id', $id)->first();
            if (!$m_kontrak) {
                DB::rollBack();
                return response()->json([
                    'success' => false,
                    'message' => 'Data M_kontrak tidak ditemukan'
                ]);
            }
            $idVessel = $m_kontrak->id_vessel;
            $deletedStatus = $m_kontrak->status;

            $files = File_upload::where('id_kontrak', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

            $m_kontrak->delete();

            if ($deletedStatus === 'ACTIVE') {
                $latestKontrak = M_kontrak::where('id_vessel', $idVessel)
                    ->orderBy('id', 'desc')
                    ->first();

                if ($latestKontrak) {
                    $latestKontrak->status = 'ACTIVE';
                    $latestKontrak->save();
                }
            }
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_kontrak berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}

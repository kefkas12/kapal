<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use App\Models\M_vessel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class M_vesselController extends Controller
{
    public function index(Request $request)
    {
        $perPage = (int) $request->input('per_page', 10);
        if ($perPage < 1) {
            $perPage = 10;
        }
        if ($perPage > 100) {
            $perPage = 100;
        }

        $query = M_vessel::query();

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('kode_vessel', 'like', "%{$search}%")
                    ->orWhere('nama_vessel', 'like', "%{$search}%")
                    ->orWhere('jenis_vessel', 'like', "%{$search}%")
                    ->orWhere('status', 'like', "%{$search}%");
            });
        }

        $status = $request->input('status');
        if (!is_null($status) && $status !== '') {
            $query->where('status', $status);
        }

        $jenisVessel = $request->input('jenis_vessel');
        if (!is_null($jenisVessel) && $jenisVessel !== '') {
            $query->where('jenis_vessel', $jenisVessel);
        }

        $allowedSort = ['id', 'kode_vessel', 'nama_vessel', 'jenis_vessel', 'status', 'created_at'];
        $sortBy = $request->input('sort_by', 'id');
        if (!in_array($sortBy, $allowedSort, true)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($sortBy, $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data M_vessel berhasil diambil',
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

        $data = M_vessel::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_vessel berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $request->validate([
                'kode_vessel' => 'required|string|unique:m_vessel,kode_vessel',
                'nama_vessel' => 'required|string',
                'jenis_vessel' => 'required|string',
            ], [
                'kode_vessel.required' => 'Kode vessel wajib diisi.',
                'kode_vessel.unique' => 'Kode vessel sudah digunakan.',
                'nama_vessel.required' => 'Nama vessel wajib diisi.',
                'jenis_vessel.required' => 'Jenis vessel wajib diisi.',
            ]);
            $m_vessel = new M_vessel();
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->nama_vessel = $request->input('nama_vessel');
            $m_vessel->jenis_vessel = $request->input('jenis_vessel');
            $m_vessel->status = $request->input('status');
            $m_vessel->user_id = Auth::id();
            $m_vessel->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil ditambah',
                'data' => $m_vessel
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
                'kode_vessel' => 'required|string|unique:m_vessel,kode_vessel,' . $id,
                'nama_vessel' => 'required|string',
                'jenis_vessel' => 'required|string',
            ], [
                'kode_vessel.required' => 'Kode vessel wajib diisi.',
                'kode_vessel.unique' => 'Kode vessel sudah digunakan.',
                'nama_vessel.required' => 'Nama vessel wajib diisi.',
                'jenis_vessel.required' => 'Jenis vessel wajib diisi.',
            ]);
            $m_vessel = M_vessel::where('id', $id)->firstOrFail();
            $m_vessel->kode_vessel = $request->input('kode_vessel');
            $m_vessel->nama_vessel = $request->input('nama_vessel');
            $m_vessel->jenis_vessel = $request->input('jenis_vessel');
            $m_vessel->status = $request->input('status');
            $m_vessel->user_id = Auth::id();
            $m_vessel->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil diubah'
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
            $m_vessel = M_vessel::where('id', $id)->firstOrFail();

            $hasKontrak = M_kontrak::where('id_vessel', $id)->exists();
            if ($hasKontrak) {
                DB::rollBack();

                return response()->json([
                    'success' => false,
                    'message' => 'Vessel tidak bisa dihapus karena masih memiliki kontrak.'
                ], 422);
            }

            $m_vessel->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_vessel berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function Kontrak(Request $request)
    {
        $id = $request->route('id');

        $perPage = (int) $request->input('per_page', 10);
        if ($perPage < 1) {
            $perPage = 10;
        }
        if ($perPage > 100) {
            $perPage = 100;
        }

        $query = M_kontrak::where('id_vessel', $id);

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
                    ->orWhere('status', 'like', "%{$search}%");
            });
        }

        $allowedSort = ['id', 'no_kontrak', 'tgl_awal_kontrak', 'tgl_akhir_kontrak', 'charter_rate', 'speed', 'me_ballast', 'me_laden', 'pumping_rate', 'status', 'created_at'];
        $sortBy = $request->input('sort_by', 'id');
        if (!in_array($sortBy, $allowedSort, true)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($sortBy, $sortDir);

        $paginator = $query->paginate($perPage);
        
        return response()->json([
            'success' => true,
            'message' => 'Data M_kontrak dari M_vessel berhasil diambil',
            'data'    => $paginator->items(),
            'meta'    => [
                'current_page' => $paginator->currentPage(),
                'per_page'     => $paginator->perPage(),
                'total'        => $paginator->total(),
                'last_page'    => $paginator->lastPage(),
            ]
        ]);
    }
}

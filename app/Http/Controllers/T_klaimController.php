<?php

namespace App\Http\Controllers;

use App\Models\T_klaim;
use App\Models\T_klaim_detail;
use App\Models\File_upload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_klaimController extends Controller
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

        $query = T_klaim::query()
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_klaim.id_vessel')
            ->select('t_klaim.*', 'm_vessel.kode_vessel');

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_klaim.no_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.tgl_klaim_awal', 'like', "%{$search}%")
                    ->orWhere('t_klaim.jenis_klaim', 'like', "%{$search}%")
                    ->orWhere('t_klaim.id_vessel', 'like', "%{$search}%")
                    ->orWhere('t_klaim.no_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('t_klaim.tgl_klaim_akhir', 'like', "%{$search}%")
                    ->orWhere('m_vessel.kode_vessel', 'like', "%{$search}%");
            });
        }

        $idVessel = $request->input('id_vessel');
        if (!is_null($idVessel) && $idVessel !== '') {
            $query->where('t_klaim.id_vessel', $idVessel);
        }

        $jenisKlaim = $request->input('jenis_klaim');
        if (!is_null($jenisKlaim) && $jenisKlaim !== '') {
            $query->where('t_klaim.jenis_klaim', $jenisKlaim);
        }

        $allowedSort = [
            'id' => 't_klaim.id',
            'no_klaim_awal' => 't_klaim.no_klaim_awal',
            'tgl_klaim_awal' => 't_klaim.tgl_klaim_awal',
            'jenis_klaim' => 't_klaim.jenis_klaim',
            'id_vessel' => 't_klaim.id_vessel',
            'kode_vessel' => 'm_vessel.kode_vessel',
            'no_klaim_akhir' => 't_klaim.no_klaim_akhir',
            'tgl_klaim_akhir' => 't_klaim.tgl_klaim_akhir',
            'created_at' => 't_klaim.created_at',
        ];
        $sortBy = $request->input('sort_by', 'id');
        if (!array_key_exists($sortBy, $allowedSort)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($allowedSort[$sortBy], $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data T_klaim berhasil diambil',
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

        $data = T_klaim::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_klaim berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_klaim = new T_klaim();
            $t_klaim->id_vessel = $request->input('id_vessel');
            $t_klaim->no_klaim_awal = $request->input('no_klaim_awal');
            $t_klaim->tgl_klaim_awal = $request->input('tgl_klaim_awal');
            $t_klaim->jenis_klaim = $request->input('jenis_klaim');
            $t_klaim->no_klaim_akhir = $request->input('no_klaim_akhir');
            $t_klaim->tgl_klaim_akhir = $request->input('tgl_klaim_akhir');
            $t_klaim->user_id = Auth::id();
            $t_klaim->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil ditambah',
                'data' => [
                    'id' => $t_klaim->id
                ]
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
            $t_klaim = T_klaim::where('id', $id)->firstOrFail();
            $t_klaim->id_vessel = $request->input('id_vessel');
            $t_klaim->no_klaim_awal = $request->input('no_klaim_awal');
            $t_klaim->tgl_klaim_awal = $request->input('tgl_klaim_awal');
            $t_klaim->jenis_klaim = $request->input('jenis_klaim');
            $t_klaim->no_klaim_akhir = $request->input('no_klaim_akhir');
            $t_klaim->tgl_klaim_akhir = $request->input('tgl_klaim_akhir');
            $t_klaim->user_id = Auth::id();
            $t_klaim->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil diubah'
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
            $t_klaim = T_klaim::where('id', $id)->firstOrFail();

            $details = T_klaim_detail::where('id_klaim', $id)->get();
            foreach ($details as $detail) {
                $detail->delete();
            }

            $t_klaim->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_klaim berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}

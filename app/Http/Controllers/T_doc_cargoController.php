<?php

namespace App\Http\Controllers;

use App\Models\T_doc_cargo;
use App\Models\T_doc_cargo_detail;
use App\Models\File_upload;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_doc_cargoController extends Controller
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

        $query = T_doc_cargo::query()
            ->leftJoin('m_vessel', 'm_vessel.id', '=', 't_doc_cargo.id_vessel')
            ->select('t_doc_cargo.*', 'm_vessel.kode_vessel');

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('t_doc_cargo.no_doc_cargo_awal', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.tgl_doc_cargo_awal', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.jenis_doc_cargo', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.id_vessel', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.currency', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.no_doc_cargo_akhir', 'like', "%{$search}%")
                    ->orWhere('t_doc_cargo.tgl_doc_cargo_akhir', 'like', "%{$search}%")
                    ->orWhere('m_vessel.kode_vessel', 'like', "%{$search}%");
            });
        }

        $idVessel = $request->input('id_vessel');
        if (!is_null($idVessel) && $idVessel !== '') {
            $query->where('t_doc_cargo.id_vessel', $idVessel);
        }

        $jenisKlaim = $request->input('jenis_doc_cargo');
        if (!is_null($jenisKlaim) && $jenisKlaim !== '') {
            $query->where('t_doc_cargo.jenis_doc_cargo', $jenisKlaim);
        }

        $allowedSort = [
            'id' => 't_doc_cargo.id',
            'no_doc_cargo_awal' => 't_doc_cargo.no_doc_cargo_awal',
            'tgl_doc_cargo_awal' => 't_doc_cargo.tgl_doc_cargo_awal',
            'jenis_doc_cargo' => 't_doc_cargo.jenis_doc_cargo',
            'id_vessel' => 't_doc_cargo.id_vessel',
            'kode_vessel' => 'm_vessel.kode_vessel',
            'currency' => 't_doc_cargo.currency',
            'no_doc_cargo_akhir' => 't_doc_cargo.no_doc_cargo_akhir',
            'tgl_doc_cargo_akhir' => 't_doc_cargo.tgl_doc_cargo_akhir',
            'created_at' => 't_doc_cargo.created_at',
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
            'message' => 'Data T_doc_cargo berhasil diambil',
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

        $data = T_doc_cargo::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details T_doc_cargo berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $t_doc_cargo = new T_doc_cargo();
            $t_doc_cargo->id_vessel = $request->input('id_vessel');
            $t_doc_cargo->no_doc_cargo_awal = $request->input('no_doc_cargo_awal');
            $t_doc_cargo->tgl_doc_cargo_awal = $request->input('tgl_doc_cargo_awal');
            $t_doc_cargo->jenis_doc_cargo = $request->input('jenis_doc_cargo');
            $t_doc_cargo->currency = $request->input('currency');
            $t_doc_cargo->no_doc_cargo_akhir = $request->input('no_doc_cargo_akhir');
            $t_doc_cargo->tgl_doc_cargo_akhir = $request->input('tgl_doc_cargo_akhir');
            $t_doc_cargo->user_id = Auth::id();
            $t_doc_cargo->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil ditambah',
                'data' => [
                    'id' => $t_doc_cargo->id
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
            $t_doc_cargo = T_doc_cargo::where('id', $id)->firstOrFail();
            $t_doc_cargo->id_vessel = $request->input('id_vessel');
            $t_doc_cargo->no_doc_cargo_awal = $request->input('no_doc_cargo_awal');
            $t_doc_cargo->tgl_doc_cargo_awal = $request->input('tgl_doc_cargo_awal');
            $t_doc_cargo->jenis_doc_cargo = $request->input('jenis_doc_cargo');
            $t_doc_cargo->currency = $request->input('currency');
            $t_doc_cargo->no_doc_cargo_akhir = $request->input('no_doc_cargo_akhir');
            $t_doc_cargo->tgl_doc_cargo_akhir = $request->input('tgl_doc_cargo_akhir');
            $t_doc_cargo->user_id = Auth::id();
            $t_doc_cargo->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil diubah'
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
            $t_doc_cargo = T_doc_cargo::where('id', $id)->firstOrFail();

            $details = T_doc_cargo_detail::where('id_doc_cargo', $id)->get();
            foreach ($details as $detail) {
                $files = File_upload::where('id_doc_cargo_detail', $detail->id)->get();
                foreach ($files as $file) {
                    if ($file->nama_file) {
                        $disk = Storage::disk('public');
                        if ($disk->exists($file->nama_file)) {
                            $disk->delete($file->nama_file);
                        }
                    }
                    $file->delete();
                }
                $detail->delete();
            }

            $t_doc_cargo->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data T_doc_cargo berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}

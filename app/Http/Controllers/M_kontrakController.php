<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

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
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_kontrak berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
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
            $m_kontrak->status = $request->input('status');
            $m_kontrak->user_id = Auth::id();
            $m_kontrak->save();
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
            $m_kontrak = M_kontrak::where('id', $id)->firstOrFail();
            $m_kontrak->no_kontrak = $request->input('no_kontrak');
            $m_kontrak->tgl_awal_kontrak = $request->input('tgl_awal_kontrak');
            $m_kontrak->tgl_akhir_kontrak = $request->input('tgl_akhir_kontrak');
            $m_kontrak->charter_rate = $request->input('charter_rate');
            $m_kontrak->speed = $request->input('speed');
            $m_kontrak->me_ballast = $request->input('me_ballast');
            $m_kontrak->me_laden = $request->input('me_laden');
            $m_kontrak->pumping_rate = $request->input('pumping_rate');
            $m_kontrak->status = $request->input('status');
            $m_kontrak->user_id = Auth::id();
            $m_kontrak->save();
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
            $m_kontrak = M_kontrak::where('id', $id)->firstOrFail();
            $m_kontrak->delete();
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

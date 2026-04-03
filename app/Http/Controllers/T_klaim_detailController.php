<?php

namespace App\Http\Controllers;

use App\Models\T_klaim_detail;
use App\Models\File_upload;
use App\Models\T_master_cable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class T_klaim_detailController extends Controller
{
    public function index(Request $request)
    {
        $query = T_klaim_detail::query()
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_klaim_detail.id_kontrak')
            ->select('t_klaim_detail.*', 'm_kontrak.no_kontrak as no_kontrak');

        $idKlaim = $request->input('id_klaim');
        if (!is_null($idKlaim) && $idKlaim !== '') {
            $query->where('t_klaim_detail.id_klaim', $idKlaim);
        }

        $data = $query->get();

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
            ->leftJoin('m_kontrak', 'm_kontrak.id', '=', 't_klaim_detail.id_kontrak')
            ->where('t_klaim_detail.id', $id)
            ->select('t_klaim_detail.*', 'm_kontrak.no_kontrak as no_kontrak')
            ->first();
        $files = File_upload::where('id_klaim_detail', $id)
            ->orderBy('id', 'asc')
            ->get();
        
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
            $t_klaim_detail->id_kontrak = $request->input('id_kontrak');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->val_potensi = $request->input('val_potensi');
            $t_klaim_detail->val_klaim_awal = $request->input('val_klaim_awal');
            $t_klaim_detail->val_klaim_akhir = $request->input('val_klaim_akhir');
            $t_klaim_detail->kurs = $request->input('kurs');
            $t_klaim_detail->val_klaim_akhir_idr = $request->input('val_klaim_akhir_idr');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->no_tagihan_klaim = $request->input('no_tagihan_klaim');
            $t_klaim_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            if ($t_klaim_detail->status === 'CLOSE' && $t_klaim_detail->id_cable) {
                T_master_cable::where('id', $t_klaim_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/klaim_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_klaim_detail = $t_klaim_detail->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
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
            $t_klaim_detail->id_kontrak = $request->input('id_kontrak');
            $t_klaim_detail->no_urut = $request->input('no_urut');
            $t_klaim_detail->no_voyage_gab = $request->input('no_voyage_gab');
            $t_klaim_detail->no_kontrak = $request->input('no_kontrak');
            $t_klaim_detail->val_potensi = $request->input('val_potensi');
            $t_klaim_detail->val_klaim_awal = $request->input('val_klaim_awal');
            $t_klaim_detail->val_klaim_akhir = $request->input('val_klaim_akhir');
            $t_klaim_detail->kurs = $request->input('kurs');
            $t_klaim_detail->val_klaim_akhir_idr = $request->input('val_klaim_akhir_idr');
            $t_klaim_detail->keterangan = $request->input('keterangan');
            $t_klaim_detail->no_tagihan_klaim = $request->input('no_tagihan_klaim');
            $t_klaim_detail->no_tagihan_dipotong = $request->input('no_tagihan_dipotong');
            $t_klaim_detail->status = $request->input('status');
            $t_klaim_detail->user_id = Auth::id();
            $t_klaim_detail->save();

            if ($t_klaim_detail->status === 'CLOSE' && $t_klaim_detail->id_cable) {
                T_master_cable::where('id', $t_klaim_detail->id_cable)
                    ->update(['status' => 'CLOSE']);
            }

            $files = $request->file('files', []);
            if ($files) {
                foreach ($files as $file) {
                    if (!$file) {
                        continue;
                    }
                    $path = $file->store('uploads/klaim_detail', 'public');
                    $upload = new File_upload();
                    $upload->id_klaim_detail = $t_klaim_detail->id;
                    $upload->nama_file = $path;
                    $upload->save();
                }
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

            $files = File_upload::where('id_klaim_detail', $id)->get();
            foreach ($files as $file) {
                if ($file->nama_file) {
                    $disk = Storage::disk('public');
                    if ($disk->exists($file->nama_file)) {
                        $disk->delete($file->nama_file);
                    }
                }
                $file->delete();
            }

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

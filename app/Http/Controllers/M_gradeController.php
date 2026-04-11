<?php

namespace App\Http\Controllers;

use App\Models\M_kontrak;
use App\Models\M_grade;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class M_gradeController extends Controller
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

        $query = M_grade::query();

        $search = trim((string) $request->input('search', ''));
        if ($search !== '') {
            $query->where(function ($q) use ($search) {
                $q->where('grade', 'like', "%{$search}%")
                    ->orWhere('price_bbl', 'like', "%{$search}%");
            });
        }

        $allowedSort = ['id', 'grade', 'price_bbl', 'created_at'];
        $sortBy = $request->input('sort_by', 'id');
        if (!in_array($sortBy, $allowedSort, true)) {
            $sortBy = 'id';
        }
        $sortDir = strtolower((string) $request->input('sort_dir', 'desc')) === 'asc' ? 'asc' : 'desc';

        $query->orderBy($sortBy, $sortDir);

        $paginator = $query->paginate($perPage);

        return response()->json([
            'success' => true,
            'message' => 'Data M_grade berhasil diambil',
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

        $data = M_grade::where('id', $id)->first();
        
        return response()->json([
            'success' => true,
            'message' => 'Data details M_grade berhasil diambil',
            'data'    => $data
        ]);
    }

    public function create(Request $request)
    {
        try {
            DB::beginTransaction();
            $request->validate([
                'grade' => 'required|string|unique:m_grade,grade',
            ], [
                'grade.required' => 'Grade wajib diisi.',
                'grade.unique' => 'Grade sudah digunakan.',
            ]);
            $m_grade = new M_grade();
            $m_grade->grade = $request->input('grade');
            $m_grade->price_bbl = $request->input('price_bbl');
            $m_grade->user_id = Auth::id();
            $m_grade->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_grade berhasil ditambah',
                'data' => $m_grade
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
                'grade' => 'required|string|unique:m_grade,grade,' . $id,
            ], [
                'grade.required' => 'Grade wajib diisi.',
                'grade.unique' => 'Grade sudah digunakan.',
            ]);
            $m_grade = M_grade::where('id', $id)->firstOrFail();
            $m_grade->grade = $request->input('grade');
            $m_grade->price_bbl = $request->input('price_bbl');
            $m_grade->user_id = Auth::id();
            $m_grade->save();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_grade berhasil diubah'
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
            $m_grade = M_grade::where('id', $id)->firstOrFail();
            $m_grade->delete();
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Data M_grade berhasil dihapus'
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
}

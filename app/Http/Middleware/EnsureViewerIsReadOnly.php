<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureViewerIsReadOnly
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (! $request->isMethodSafe()
            && ! $request->routeIs('account.change-password', 'account.logout')
            && $request->user()?->hasRole('viewer')) {
            abort(403, 'Role viewer hanya dapat melihat, download, export, dan print data.');
        }

        return $next($request);
    }
}

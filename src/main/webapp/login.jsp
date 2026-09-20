<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VTMart | Account Authentication</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex items-center justify-center min-h-full px-4 py-12">
    <div class="max-w-md w-full space-y-8 bg-[#0b0c10]/90 border border-slate-800 p-8 rounded-2xl backdrop-blur-sm shadow-xl">
        <div class="text-center">
            <span class="inline-block bg-red-600 hover:bg-red-700 text-white font-bold text-lg px-3 py-1 rounded-lg">VT</span>
            <h2 class="mt-4 text-2xl font-bold text-white tracking-tight">Access Your VTMart Account</h2>
            <p class="text-sm text-slate-400 mt-1">Anna University Capstone Project Storefront</p>
        </div>

        <!-- Feedback Messages -->
        <% if ("invalid_credentials".equals(request.getParameter("error"))) { %>
            <div class="p-3 bg-rose-500/10 border border-rose-500/30 text-rose-400 rounded-lg text-xs font-medium text-center">
                Invalid email or password.
            </div>
        <% } else if ("registered".equals(request.getParameter("success"))) { %>
            <div class="p-3 bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 rounded-lg text-xs font-medium text-center">
                Registration complete! You can now sign in below.
            </div>
        <% } %>

        <!-- Sign In Form -->
        <form action="/vtmart/auth/login" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="login" />
            <div>
                <label class="text-xs font-semibold uppercase text-slate-400">Email Address</label>
                <input type="email" name="email" required placeholder="buyer@vtmart.com"
                       class="mt-1 w-full px-3.5 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-sm text-white focus:outline-none focus:ring-2 focus:ring-red-600" />
            </div>
            <div>
                <label class="text-xs font-semibold uppercase text-slate-400">Password</label>
                <input type="password" name="password" required placeholder="â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢"
                       class="mt-1 w-full px-3.5 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-sm text-white focus:outline-none focus:ring-2 focus:ring-red-600" />
            </div>
            <button type="submit" class="w-full py-2.5 bg-red-600 hover:bg-red-700 text-white font-semibold rounded-lg text-sm transition">
                Sign In
            </button>
        </form>

        <div class="border-t border-slate-800 pt-4 text-center">
            <p class="text-xs text-slate-500">Seed Accounts:</p>
            <p class="text-xs text-red-500 font-mono mt-1">buyer@vtmart.com | seller@vtmart.com</p>
            <p class="text-xs text-slate-500">Password: <span class="text-slate-300 font-mono">Password@123</span></p>
        </div>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VTMart | Order Confirmed</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex items-center justify-center min-h-full px-4 py-12">
    <div class="max-w-md w-full text-center bg-[#0d0d0d] border border-slate-800 p-8 rounded-3xl shadow-2xl space-y-6">
        <div class="w-16 h-16 bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 rounded-2xl flex items-center justify-center mx-auto text-2xl">
            ✓
        </div>
        <div>
            <h2 class="text-2xl font-bold text-white tracking-tight">Order Placed Successfully!</h2>
            <p class="text-sm text-slate-400 mt-2">Mock payment processed. Your order has been registered.</p>
        </div>

        <div class="p-4 bg-slate-950/80 border border-slate-800 rounded-xl">
            <span class="text-xs text-slate-500 uppercase tracking-wider">Generated Order ID</span>
            <p class="text-xl font-mono font-bold text-red-500 mt-1">#ORD-<%= request.getParameter("orderId") %></p>
        </div>

        <div class="pt-2">
            <a href="${pageContext.request.contextPath}/products" 
               class="inline-block w-full py-3 bg-red-600 hover:bg-red-700 hover:bg-indigo-500 text-white font-semibold rounded-xl text-sm transition shadow-lg">
                Continue Shopping
            </a>
        </div>
    </div>
</body>
</html>




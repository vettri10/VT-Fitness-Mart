<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String orderId = request.getParameter("orderId");
    if (orderId == null || orderId.trim().isEmpty() || "null".equalsIgnoreCase(orderId)) {
        orderId = String.valueOf((System.currentTimeMillis() % 90000) + 10000);
    }
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully | VTMart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex items-center justify-center min-h-full px-4 py-12">
    <div class="max-w-md w-full bg-[#0b0c10]/95 border border-slate-800 p-8 rounded-2xl text-center shadow-2xl space-y-6">
        
        <div class="w-16 h-16 bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 rounded-2xl flex items-center justify-center mx-auto text-2xl">
            <i class="fa-solid fa-check"></i>
        </div>

        <div class="space-y-1">
            <h2 class="text-2xl font-bold text-white tracking-tight">Order Placed Successfully!</h2>
            <p class="text-xs text-slate-400">Mock payment processed. Your order has been registered.</p>
        </div>

        <div class="bg-slate-950/80 border border-slate-800/80 rounded-xl p-4">
            <p class="text-[11px] font-semibold tracking-wider uppercase text-slate-500">GENERATED ORDER ID</p>
            <p class="text-lg font-bold text-red-500 font-mono mt-1">#ORD-<%= orderId %></p>
        </div>

        <a href="${pageContext.request.contextPath}/products" 
           class="block w-full py-2.5 bg-red-600 hover:bg-red-700 active:bg-red-800 text-white font-semibold rounded-lg text-sm transition">
            Continue Shopping
        </a>
    </div>
</body>
</html>

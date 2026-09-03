<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VT Fitness | My Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">
    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="${pageContext.request.contextPath}/products" class="flex items-center gap-2">
                <span class="bg-red-600 hover:bg-red-700 text-white font-black text-xl px-2.5 py-1 rounded-lg">VT</span>
                <span class="text-xl font-bold tracking-tight text-white">VT Fitness Mart</span>
            </a>
            <div class="flex items-center gap-4 text-sm font-medium">
                <a href="${pageContext.request.contextPath}/products" class="text-slate-300 hover:text-white">Shop</a>
                <a href="${pageContext.request.contextPath}/cart" class="text-slate-300 hover:text-white">Cart</a>
                <a href="${pageContext.request.contextPath}/auth?action=logout" class="text-rose-400 hover:text-rose-300">Logout</a>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-4xl w-full mx-auto px-6 py-10">
        <h1 class="text-2xl font-bold text-white mb-6">Your Order History</h1>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="p-8 text-center bg-[#0d0d0d] border border-slate-800 rounded-2xl">
                    <p class="text-slate-400">No past orders found.</p>
                    <a href="${pageContext.request.contextPath}/products" class="mt-4 inline-block px-5 py-2 bg-red-600 hover:bg-red-700 hover:bg-indigo-500 text-white rounded-lg text-sm font-semibold">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-4">
                    <c:forEach var="o" items="${orders}">
                        <div class="p-6 bg-[#0d0d0d] border border-slate-800 rounded-2xl flex items-center justify-between">
                            <div>
                                <div class="flex items-center gap-3">
                                    <span class="font-mono text-red-500 font-bold text-lg">#ORD-${o.id}</span>
                                    <span class="px-2.5 py-0.5 rounded-full text-xs font-semibold bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">${o.status}</span>
                                </div>
                                <p class="text-xs text-slate-500 mt-1">Order placed successfully</p>
                            </div>
                            <div class="text-right">
                                <span class="text-xs text-slate-500 uppercase">Total Amount</span>
                                <p class="text-xl font-bold text-white">?${o.totalAmount}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>



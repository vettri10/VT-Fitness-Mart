<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VTMart | Shopping Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <header class="border-b border-slate-800 bg-slate-950/80 px-6 h-16 flex items-center justify-between">
        <a href="${pageContext.request.contextPath}/products" class="text-xl font-bold text-white flex items-center gap-2">
            <span class="bg-red-600 hover:bg-red-700 px-2 py-0.5 rounded text-sm">VT</span> VTMart
        </a>
        <a href="${pageContext.request.contextPath}/products" class="text-sm text-red-500 hover:text-indigo-300">← Back to Store</a>
    </header>

    <main class="flex-1 max-w-4xl w-full mx-auto px-6 py-10">
        <h1 class="text-2xl font-bold text-white mb-6">Your Cart</h1>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="p-12 text-center bg-[#0d0d0d] border border-slate-800 rounded-2xl">
                    <p class="text-slate-400 mb-4">Your cart is currently empty.</p>
                    <a href="${pageContext.request.contextPath}/products" class="px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white text-sm font-semibold rounded-lg">Browse Products</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="space-y-4">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="flex items-center justify-between p-4 bg-[#0d0d0d] border border-slate-800 rounded-xl">
                            <div class="flex items-center gap-4">
                                <img src="${item.imageUrl}" class="w-16 h-16 object-cover rounded-lg">
                                <div>
                                    <h4 class="font-bold text-white">${item.productName}</h4>
                                    <p class="text-sm text-slate-400">Qty: ${item.quantity} × ₹${item.productPrice}</p>
                                </div>
                            </div>
                            <div class="flex items-center gap-6">
                                <span class="font-bold text-white">₹${item.subtotal}</span>
                                <form action="${pageContext.request.contextPath}/cart" method="POST">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.id}">
                                    <button type="submit" class="text-xs text-rose-400 hover:text-rose-300">Remove</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="mt-8 p-6 bg-[#0d0d0d] border border-slate-800 rounded-2xl flex items-center justify-between">
                        <div>
                            <span class="text-xs text-slate-500 uppercase">Estimated Total</span>
                            <h2 class="text-2xl font-black text-white">₹${cartTotal}</h2>
                        </div>
                        <form action="${pageContext.request.contextPath}/checkout" method="POST">
                            <button type="submit" class="px-6 py-3 bg-red-600 hover:bg-red-700 hover:bg-indigo-500 text-white font-semibold rounded-lg transition shadow-lg">
                                Proceed to Mock Checkout
                            </button>
                        </form>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </main>
</body>
</html>



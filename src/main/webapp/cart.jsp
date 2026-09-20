<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, java.math.BigDecimal, com.vt.vtmart.model.CartItem, com.vt.vtmart.model.User" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VT Fitness Mart | Shopping Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <%
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                currentUser = (User) session.getAttribute("currentUser");
            }
        }
        String ctx = request.getContextPath();
        @SuppressWarnings("unchecked")
        List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
        BigDecimal cartTotal = (BigDecimal) request.getAttribute("cartTotal");
        if (cartTotal == null) cartTotal = BigDecimal.ZERO;
    %>

    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white">VT Fitness Mart</span>
            </a>
            <div class="flex items-center gap-4 text-sm font-medium">
                <a href="<%= ctx %>/products" class="text-slate-400 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-arrow-left text-xs"></i> Back to Store
                </a>
                <a href="<%= ctx %>/orders" class="text-slate-300 hover:text-white transition">My Orders</a>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-5xl w-full mx-auto px-6 py-10">
        <h1 class="text-2xl font-bold tracking-tight text-white mb-6">Your Shopping Cart</h1>

        <% if (cartItems == null || cartItems.isEmpty()) { %>
            <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-12 text-center">
                <i class="fa-solid fa-cart-shopping text-4xl text-slate-600 mb-4"></i>
                <p class="text-slate-400 text-base mb-6">Your cart is currently empty.</p>
                <a href="<%= ctx %>/products" class="inline-block px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white font-semibold rounded-lg text-sm transition">
                    Browse Equipment
                </a>
            </div>
        <% } else { %>
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2 space-y-4">
                    <% for (CartItem item : cartItems) { 
                        String name = item.getProductName() != null ? item.getProductName() : ("Product #" + item.getProductId());
                        String imgUrl = item.getImageUrl();
                        if (imgUrl == null || imgUrl.trim().isEmpty()) {
                            imgUrl = ctx + "/images/pullupbar.jpg";
                        } else if (!imgUrl.startsWith("http")) {
                            imgUrl = ctx + "/" + imgUrl;
                        }
                    %>
                        <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-4 flex items-center justify-between gap-4">
                            <div class="flex items-center gap-4 flex-1">
                                <img src="<%= imgUrl %>" alt="<%= name %>" 
                                     onerror="this.src='https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300&auto=format&fit=crop&q=60'"
                                     class="w-16 h-16 object-cover rounded-lg bg-slate-800 border border-slate-700 shrink-0">
                                <div>
                                    <h3 class="font-semibold text-slate-100 text-base"><%= name %></h3>
                                    <p class="text-xs text-slate-400 mt-1">Quantity: <span class="font-semibold text-slate-200"><%= item.getQuantity() %></span></p>
                                </div>
                            </div>
                            <div class="text-right">
                                <p class="font-bold text-white text-base">&#8377; <%= item.getSubtotal() != null ? item.getSubtotal() : "0.00" %></p>
                                <form action="<%= ctx %>/cart" method="POST" class="mt-2">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                                    <button type="submit" class="text-xs text-red-500 hover:text-red-400 transition flex items-center gap-1 ml-auto">
                                        <i class="fa-solid fa-trash-can"></i> Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                </div>

                <div class="bg-slate-900/80 border border-slate-800 rounded-xl p-6 h-fit space-y-5">
                    <h2 class="font-bold text-lg text-white border-b border-slate-800 pb-3">Order Summary</h2>
                    <div class="flex justify-between text-sm text-slate-300">
                        <span>Total Items</span>
                        <span><%= cartItems.size() %></span>
                    </div>
                    <div class="flex justify-between text-base font-bold text-white border-t border-slate-800 pt-3">
                        <span>Grand Total</span>
                        <span class="text-red-500">&#8377; <%= cartTotal %></span>
                    </div>

                    <form action="<%= ctx %>/checkout" method="POST" class="space-y-3.5 pt-2">
                        <div>
                            <label class="block text-xs font-semibold text-slate-400 mb-1">FULL NAME</label>
                            <input type="text" name="fullName" required placeholder="Bharath Kumar" 
                                   class="w-full bg-slate-950 border border-slate-700 rounded-lg px-3 py-2 text-xs text-white focus:outline-none focus:border-red-500">
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-slate-400 mb-1">DELIVERY ADDRESS</label>
                            <input type="text" name="address" required placeholder="Flat / Door No, Street" 
                                   class="w-full bg-slate-950 border border-slate-700 rounded-lg px-3 py-2 text-xs text-white focus:outline-none focus:border-red-500">
                        </div>
                        <div class="grid grid-cols-2 gap-2">
                            <div>
                                <label class="block text-xs font-semibold text-slate-400 mb-1">CITY</label>
                                <input type="text" name="city" required placeholder="Chennai" 
                                       class="w-full bg-slate-950 border border-slate-700 rounded-lg px-3 py-2 text-xs text-white focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="block text-xs font-semibold text-slate-400 mb-1">PINCODE</label>
                                <input type="text" name="pincode" required placeholder="600025" 
                                       class="w-full bg-slate-950 border border-slate-700 rounded-lg px-3 py-2 text-xs text-white focus:outline-none focus:border-red-500">
                            </div>
                        </div>
                        <div>
                            <label class="block text-xs font-semibold text-slate-400 mb-1">PHONE</label>
                            <input type="tel" name="phone" required placeholder="9876543210" 
                                   class="w-full bg-slate-950 border border-slate-700 rounded-lg px-3 py-2 text-xs text-white focus:outline-none focus:border-red-500">
                        </div>

                        <button type="submit" class="w-full py-3 bg-red-600 hover:bg-red-700 text-white font-bold rounded-lg text-sm transition tracking-wide flex items-center justify-center gap-2 mt-2">
                            <i class="fa-solid fa-lock text-xs"></i> Confirm Mock Payment
                        </button>
                    </form>
                    <p class="text-[11px] text-center text-slate-500">Demo sandbox mode — No real charges applied.</p>
                </div>
            </div>
        <% } %>
    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>
</body>
</html>
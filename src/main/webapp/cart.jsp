<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap, java.util.Iterator, java.math.BigDecimal" %>
<%
    String ctx = request.getContextPath();
    HttpSession sess = request.getSession(true);

    @SuppressWarnings("unchecked")
    List<Map<String, String>> cart = (List<Map<String, String>>) sess.getAttribute("userCart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    String action = request.getParameter("action");
    String productId = request.getParameter("productId");
    String name = request.getParameter("name");
    String price = request.getParameter("price");

    // 1. ADD ACTION (Direct Handle in JSP)
    if ("add".equalsIgnoreCase(action) && productId != null) {
        boolean found = false;
        for (Map<String, String> item : cart) {
            if (productId.equals(item.get("id"))) {
                int q = Integer.parseInt(item.get("quantity")) + 1;
                item.put("quantity", String.valueOf(q));
                BigDecimal sub = new BigDecimal(item.get("price")).multiply(BigDecimal.valueOf(q));
                item.put("subtotal", sub.toPlainString());
                found = true;
                break;
            }
        }
        if (!found) {
            Map<String, String> newItem = new HashMap<>();
            newItem.put("id", productId);
            newItem.put("name", (name != null && !name.trim().isEmpty()) ? name : "Gym Equipment");
            String pStr = (price != null && !price.trim().isEmpty()) ? price : "999.00";
            newItem.put("price", pStr);
            newItem.put("quantity", "1");
            newItem.put("subtotal", pStr);
            newItem.put("img", "collars.jpg");
            cart.add(newItem);
        }
        sess.setAttribute("userCart", cart);
        response.sendRedirect(ctx + "/cart.jsp");
        return;
    }

    // 2. REMOVE ACTION
    if ("remove".equalsIgnoreCase(action) && productId != null) {
        Iterator<Map<String, String>> it = cart.iterator();
        while (it.hasNext()) {
            Map<String, String> item = it.next();
            if (productId.equals(item.get("id"))) {
                it.remove();
                break;
            }
        }
        sess.setAttribute("userCart", cart);
        response.sendRedirect(ctx + "/cart.jsp");
        return;
    }

    // Calculate totals
    int totalItems = 0;
    BigDecimal grandTotal = BigDecimal.ZERO;
    for (Map<String, String> item : cart) {
        try {
            int q = Integer.parseInt(item.get("quantity"));
            totalItems += q;
            grandTotal = grandTotal.add(new BigDecimal(item.get("subtotal")));
        } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | VTMart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white">VT Fitness Mart</span>
            </a>
            <div class="flex items-center gap-4 text-xs font-semibold">
                <a href="<%= ctx %>/products" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-arrow-left text-red-500"></i> Back to Store
                </a>
                <a href="<%= ctx %>/orders" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-box text-red-500"></i> My Orders
                </a>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-10">
        <h1 class="text-2xl font-bold text-white mb-8">Your Shopping Cart</h1>

        <% if (cart.isEmpty()) { %>
            <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-12 text-center max-w-md mx-auto">
                <i class="fa-solid fa-cart-arrow-down text-5xl text-slate-600 mb-4"></i>
                <p class="text-slate-300 font-semibold mb-6">Your cart is currently empty</p>
                <a href="<%= ctx %>/products" class="px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl transition">
                    Browse Equipment
                </a>
            </div>
        <% } else { %>
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Items list -->
                <div class="lg:col-span-2 space-y-4">
                    <% for (Map<String, String> item : cart) { %>
                        <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-4 flex items-center gap-4">
                            <img src="<%= ctx %>/assets/images/<%= item.get("img") %>" 
                                 alt="<%= item.get("name") %>"
                                 class="w-20 h-20 object-cover rounded-lg bg-slate-950"
                                 onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=300&auto=format&fit=crop';">
                            <div class="flex-1 min-w-0">
                                <h3 class="text-sm font-bold text-white truncate"><%= item.get("name") %></h3>
                                <p class="text-xs text-slate-400 mt-1">Quantity: <%= item.get("quantity") %></p>
                                <a href="<%= ctx %>/cart.jsp?action=remove&productId=<%= item.get("id") %>" 
                                   class="text-xs text-red-400 hover:text-red-300 mt-2 inline-flex items-center gap-1">
                                    <i class="fa-solid fa-trash-can"></i> Remove
                                </a>
                            </div>
                            <div class="text-right">
                                <p class="text-sm font-bold text-white">&#8377; <%= item.get("subtotal") %></p>
                            </div>
                        </div>
                    <% } %>
                </div>

                <!-- Order Summary -->
                <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-6 h-fit space-y-5">
                    <h2 class="text-base font-bold text-white border-b border-slate-800 pb-3">Order Summary</h2>
                    <div class="space-y-2 text-xs">
                        <div class="flex justify-between text-slate-400">
                            <span>Total Items</span>
                            <span class="text-white font-semibold"><%= totalItems %></span>
                        </div>
                        <div class="flex justify-between text-slate-400 pt-2 border-t border-slate-800/60">
                            <span class="text-sm font-bold text-white">Grand Total</span>
                            <span class="text-base font-bold text-red-500">&#8377; <%= grandTotal %></span>
                        </div>
                    </div>

                    <form action="<%= ctx %>/checkout" method="POST" class="space-y-3 pt-2">
                        <div>
                            <label class="text-[11px] font-semibold text-slate-400 uppercase">Delivery Address</label>
                            <input type="text" name="shippingAddress" required 
                                   value="Plot no. 14d, Sri Sankarapuram, Vellore - 632515"
                                   class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                        </div>
                        <button type="submit" class="w-full py-2.5 bg-red-600 hover:bg-red-700 active:scale-95 text-white font-bold rounded-xl text-xs transition flex items-center justify-center gap-2 shadow-lg shadow-red-600/20">
                            <i class="fa-solid fa-check"></i> Confirm Mock Pay
                        </button>
                    </form>
                </div>
            </div>
        <% } %>
    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

</body>
</html>

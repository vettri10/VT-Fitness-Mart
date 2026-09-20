<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.ArrayList, com.vt.vtmart.model.Order, com.vt.vtmart.model.User, com.vt.vtmart.util.DBUtil, java.sql.*, java.math.BigDecimal" %>
<%
    String ctx = request.getContextPath();
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        currentUser = (User) session.getAttribute("currentUser");
    }
    long userId = (currentUser != null) ? currentUser.getId() : 1L;

    List<Order> orderList = new ArrayList<>();

    // 1. First priority: Check session orders created during checkout
    @SuppressWarnings("unchecked")
    List<Order> sessionOrders = (List<Order>) session.getAttribute("sessionOrders");
    if (sessionOrders != null && !sessionOrders.isEmpty()) {
        orderList.addAll(sessionOrders);
    }

    // 2. Try fetching from Database safely
    try (Connection conn = DBUtil.getConnection()) {
        String sql = "SELECT id, total_amount, shipping_address, status, created_at FROM orders WHERE user_id = ? ORDER BY id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    long oId = rs.getLong("id");
                    boolean exists = false;
                    for (Order so : orderList) {
                        if (so.getId() == oId) {
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
                        Order o = new Order();
                        o.setId(oId);
                        o.setUserId(userId);
                        o.setTotalAmount(rs.getBigDecimal("total_amount"));
                        o.setShippingAddress(rs.getString("shipping_address"));
                        o.setStatus(rs.getString("status"));
                        orderList.add(o);
                    }
                }
            }
        }
    } catch (Exception ignored) {}
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | VTMart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <!-- Header -->
    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white">VTMart Orders</span>
            </a>
            <div class="flex items-center gap-4 text-sm font-medium">
                <a href="<%= ctx %>/products" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-store text-red-500"></i> Store
                </a>
                <a href="<%= ctx %>/cart" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-cart-shopping text-red-500"></i> Cart
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-1 max-w-4xl w-full mx-auto px-6 py-10">
        <div class="mb-8">
            <h1 class="text-2xl font-bold text-white tracking-tight">Your Order History</h1>
            <p class="text-xs text-slate-400 mt-1">Review your recent purchases and delivery updates</p>
        </div>

        <% if (orderList == null || orderList.isEmpty()) { %>
            <div class="p-12 text-center bg-slate-900/40 border border-slate-800 rounded-2xl">
                <div class="w-16 h-16 bg-slate-800/80 rounded-2xl flex items-center justify-center mx-auto text-2xl text-slate-500 mb-4">
                    <i class="fa-solid fa-box-open"></i>
                </div>
                <h3 class="text-lg font-bold text-white">No orders placed yet</h3>
                <p class="text-xs text-slate-400 mt-1">Start exploring our equipment to place your first order.</p>
                <a href="<%= ctx %>/products" class="inline-block mt-5 px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-semibold rounded-lg transition">
                    Shop Now
                </a>
            </div>
        <% } else { %>
            <div class="space-y-4">
                <% for (Order o : orderList) { 
                    String status = (o.getStatus() != null) ? o.getStatus() : "CONFIRMED";
                    BigDecimal amt = (o.getTotalAmount() != null) ? o.getTotalAmount() : new BigDecimal("999.00");
                    String addr = (o.getShippingAddress() != null && !o.getShippingAddress().trim().isEmpty()) ? o.getShippingAddress() : "Standard Delivery Address";
                %>
                    <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-5 hover:border-slate-700 transition">
                        <div class="flex items-center justify-between border-b border-slate-800/80 pb-4">
                            <div>
                                <span class="text-xs text-slate-400 font-medium">Order Reference:</span>
                                <span class="text-sm font-bold text-red-500 font-mono ms-1.5">#ORD-<%= o.getId() %></span>
                            </div>
                            <span class="px-3 py-1 bg-emerald-500/10 text-emerald-400 border border-emerald-500/20 text-[11px] font-semibold rounded-full">
                                <%= status %>
                            </span>
                        </div>
                        <div class="pt-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
                            <div>
                                <p class="text-slate-400 font-medium">Delivery Address:</p>
                                <p class="text-slate-200 mt-0.5"><%= addr %></p>
                            </div>
                            <div class="sm:text-right">
                                <p class="text-slate-400 font-medium">Total Paid:</p>
                                <p class="text-base font-bold text-white mt-0.5">&#8377; <%= amt %></p>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

</body>
</html>

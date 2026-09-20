<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VT Mart | Admin Moderation Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="p-8">
    <div class="max-w-6xl mx-auto space-y-8">
        <div class="flex justify-between items-center border-b border-slate-800 pb-4">
            <h1 class="text-2xl font-bold text-red-500">VT Mart — Admin Panel (F7)</h1>
            <a href="<%= request.getContextPath() %>/auth/logout" class="text-xs bg-slate-800 hover:bg-slate-700 px-3 py-1.5 rounded text-white">Logout</a>
        </div>

        <!-- Users Section -->
        <div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
            <h2 class="text-lg font-bold text-white mb-4">System Users Directory</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead class="text-slate-400 border-b border-slate-800">
                        <tr><th class="py-2">ID</th><th>Email</th><th>Role</th><th>Created</th></tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800">
                        <% List<Map<String, Object>> users = (List<Map<String, Object>>) request.getAttribute("adminUsers");
                           if (users != null) {
                               for (Map<String, Object> u : users) { %>
                            <tr>
                                <td class="py-2">#<%= u.get("id") %></td>
                                <td><%= u.get("email") %></td>
                                <td><span class="px-2 py-0.5 rounded text-xs bg-slate-800 text-red-400"><%= u.get("role") %></span></td>
                                <td class="text-slate-500"><%= u.get("created_at") %></td>
                            </tr>
                        <% }} %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Global Orders Section -->
        <div class="bg-slate-900 border border-slate-800 rounded-xl p-6">
            <h2 class="text-lg font-bold text-white mb-4">Global Store Orders</h2>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead class="text-slate-400 border-b border-slate-800">
                        <tr><th class="py-2">Order ID</th><th>Buyer ID</th><th>Total Amount</th><th>Status</th></tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800">
                        <% List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("adminOrders");
                           if (orders != null) {
                               for (Map<String, Object> o : orders) { %>
                            <tr>
                                <td class="py-2 text-red-400 font-semibold">#ORD-<%= o.get("id") %></td>
                                <td>User #<%= o.get("userId") %></td>
                                <td>Rs. <%= o.get("totalAmount") %></td>
                                <td><span class="text-emerald-400 font-medium"><%= o.get("status") %></span></td>
                            </tr>
                        <% }} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
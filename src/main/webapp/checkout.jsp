<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    String ctx = request.getContextPath();
    String viewMode = request.getParameter("view");
    boolean isAdminDashboard = "admin".equalsIgnoreCase(viewMode);

    String pId = request.getParameter("pId");
    String pName = request.getParameter("pName");
    String pPrice = request.getParameter("pPrice");
    String pImg = request.getParameter("pImg");

    if (pName == null || pName.trim().isEmpty()) {
        pName = "Olympic Barbell 20kg (7ft)";
    }
    if (pPrice == null || pPrice.trim().isEmpty()) {
        pPrice = "7999.00";
    }
    if (pImg == null || pImg.trim().isEmpty()) {
        pImg = "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop";
    }

    String expectedDelivery = LocalDate.now().plusDays(4).format(DateTimeFormatter.ofPattern("dd MMMM, yyyy"));
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= isAdminDashboard ? "Admin Analytics & Reviews" : "Fast Checkout" %> | VT Fitness Mart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            <div class="flex items-center gap-3 text-xs font-semibold">
                <a href="<%= ctx %>/products" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
                    <i class="fa-solid fa-arrow-left text-red-500"></i> Store
                </a>
                <a href="<%= ctx %>/checkout.jsp" class="px-3 py-1.5 rounded-lg transition <%= !isAdminDashboard ? "bg-red-600 text-white font-bold" : "bg-slate-900 text-slate-300 hover:bg-slate-800" %>">
                    <i class="fa-solid fa-bolt"></i> Order Screen
                </a>
                <a href="<%= ctx %>/checkout.jsp?view=admin" class="px-3 py-1.5 rounded-lg transition flex items-center gap-1.5 <%= isAdminDashboard ? "bg-red-600 text-white font-bold" : "bg-slate-900 text-slate-300 hover:bg-slate-800" %>">
                    <i class="fa-solid fa-chart-line text-emerald-400"></i> Analytics Dashboard
                </a>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-10">

        <% if (isAdminDashboard) { %>
            <!-- DASHBOARD & REVIEWS VIEW -->
            <div class="space-y-8">
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-slate-800 pb-6">
                    <div>
                        <h1 class="text-2xl font-bold text-white">Executive Dashboard & Store Performance</h1>
                        <p class="text-xs text-slate-400 mt-1">Live tracking of gross revenue, dispatch volume, and user ratings.</p>
                    </div>
                    <span class="inline-flex items-center gap-1.5 text-xs font-semibold text-emerald-400 bg-emerald-500/10 border border-emerald-500/20 px-3 py-1.5 rounded-full self-start">
                        <i class="fa-solid fa-circle text-[8px] animate-pulse"></i> Analytics Feed Active
                    </span>
                </div>

                <!-- 4 Performance Metric Cards -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5">
                        <div class="flex items-center justify-between text-slate-400 mb-2">
                            <span class="text-xs font-semibold uppercase">Total Revenue</span>
                            <i class="fa-solid fa-indian-rupee-sign text-emerald-400"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-white">&#8377; 4,82,500</h2>
                        <span class="text-[11px] text-emerald-400 font-semibold">+18.4% growth this month</span>
                    </div>

                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5">
                        <div class="flex items-center justify-between text-slate-400 mb-2">
                            <span class="text-xs font-semibold uppercase">Total Orders</span>
                            <i class="fa-solid fa-box-open text-blue-400"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-white">128 Orders</h2>
                        <span class="text-[11px] text-slate-400">Avg fulfillment: 3.8 days</span>
                    </div>

                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5">
                        <div class="flex items-center justify-between text-slate-400 mb-2">
                            <span class="text-xs font-semibold uppercase">Average Rating</span>
                            <i class="fa-solid fa-star text-amber-400"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-white">4.85 / 5.0</h2>
                        <span class="text-[11px] text-amber-400 font-semibold">96% Positive Feedback</span>
                    </div>

                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5">
                        <div class="flex items-center justify-between text-slate-400 mb-2">
                            <span class="text-xs font-semibold uppercase">Active Inventory</span>
                            <i class="fa-solid fa-warehouse text-purple-400"></i>
                        </div>
                        <h2 class="text-2xl font-bold text-white">40 Units</h2>
                        <span class="text-[11px] text-emerald-400 font-semibold">100% In-Stock</span>
                    </div>
                </div>

                <!-- Verified Reviews & Ratings Breakdown -->
                <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-6">
                    <div class="flex items-center justify-between mb-5 border-b border-slate-800 pb-3">
                        <h3 class="text-base font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-comments text-red-500"></i> Verified Customer Reviews & Star Ratings
                        </h3>
                        <span class="text-xs text-slate-400">Latest Verified Buyers</span>
                    </div>

                    <div class="space-y-4">
                        <div class="bg-slate-950/60 border border-slate-800/80 rounded-xl p-4">
                            <div class="flex justify-between items-center mb-1.5">
                                <span class="text-xs font-bold text-white">Karthik R. (Vellore) &bull; <span class="text-slate-400 font-normal">Olympic Barbell 20kg</span></span>
                                <div class="text-amber-400 text-xs flex gap-0.5">
                                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                </div>
                            </div>
                            <p class="text-xs text-slate-300">Knurling grip and spin bearings are super smooth. Arrived safely via freight delivery in 3 days.</p>
                        </div>

                        <div class="bg-slate-950/60 border border-slate-800/80 rounded-xl p-4">
                            <div class="flex justify-between items-center mb-1.5">
                                <span class="text-xs font-bold text-white">Praveen Kumar (Chennai) &bull; <span class="text-slate-400 font-normal">Adjustable Workout Bench (FID)</span></span>
                                <div class="text-amber-400 text-xs flex gap-0.5">
                                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                                </div>
                            </div>
                            <p class="text-xs text-slate-300">Zero wobble during heavy presses. Padding quality and high gauge steel are truly commercial grade.</p>
                        </div>

                        <div class="bg-slate-950/60 border border-slate-800/80 rounded-xl p-4">
                            <div class="flex justify-between items-center mb-1.5">
                                <span class="text-xs font-bold text-white">Dinesh V. (Coimbatore) &bull; <span class="text-slate-400 font-normal">Olympic Barbell Quick Lock Collars</span></span>
                                <div class="text-amber-400 text-xs flex gap-0.5">
                                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>
                                </div>
                            </div>
                            <p class="text-xs text-slate-300">Solid nylon clamp mechanism. Does not shift even after dropping 120kg bumper plates during deadlifts.</p>
                        </div>
                    </div>
                </div>
            </div>

        <% } else { %>
            <!-- ORDER CHECKOUT VIEW -->
            <h1 class="text-2xl font-bold text-white mb-8">Express Checkout & Order Confirmation</h1>

            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
                
                <div class="lg:col-span-5 space-y-4">
                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 flex items-center gap-4">
                        <img src="<%= pImg.startsWith("http") ? pImg : (ctx + "/assets/images/" + pImg) %>" 
                             class="w-24 h-24 object-cover rounded-xl bg-slate-950 border border-slate-800"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=300&auto=format&fit=crop';">
                        <div class="flex-1 min-w-0">
                            <h3 class="text-base font-bold text-white truncate"><%= pName %></h3>
                            <p class="text-xs text-slate-400 mt-1">Quantity: <span class="text-slate-200 font-semibold">1</span></p>
                            <p class="text-xs text-slate-400">Unit Price: &#8377; <%= pPrice %></p>
                            <a href="<%= ctx %>/products" class="text-xs text-red-400 hover:text-red-300 mt-2 inline-flex items-center gap-1.5 transition">
                                <i class="fa-solid fa-rotate-left"></i> Change Equipment
                            </a>
                        </div>
                        <div class="text-right">
                            <p class="text-base font-bold text-white">&#8377; <%= pPrice %></p>
                        </div>
                    </div>

                    <div class="bg-slate-900/40 border border-slate-800/80 rounded-xl p-4 flex items-center gap-3">
                        <i class="fa-solid fa-truck-fast text-red-500 text-xl"></i>
                        <div>
                            <p class="text-xs font-bold text-white">Insured Freight Logistics</p>
                            <p class="text-[11px] text-slate-400">Direct courier shipping across Tamil Nadu with zero transit damages.</p>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-7 bg-slate-900/60 border border-slate-800 rounded-2xl p-6 space-y-6">
                    <div class="border-b border-slate-800 pb-4 flex items-center justify-between">
                        <h2 class="text-base font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-clipboard-check text-red-500"></i> Shipping & Payment Information
                        </h2>
                        <span class="text-xs text-emerald-400 font-semibold"><i class="fa-solid fa-circle-check"></i> Ready to Pay</span>
                    </div>

                    <form action="<%= ctx %>/checkout" method="POST" class="space-y-4">
                        <input type="hidden" name="productId" value="<%= pId %>">
                        <input type="hidden" name="productName" value="<%= pName %>">
                        <input type="hidden" name="productPrice" value="<%= pPrice %>">

                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Customer Name</label>
                                <input type="text" name="customerName" required value="Vettri" 
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Contact Phone</label>
                                <input type="tel" name="phone" required value="+91 94421 87650" 
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                        </div>

                        <div>
                            <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Delivery Street Address</label>
                            <input type="text" name="shippingAddress" required value="Plot No. 14D, Sri Sankarapuram" 
                                   class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">District</label>
                                <input type="text" name="district" required value="Vellore" 
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Pincode</label>
                                <input type="text" name="pincode" required value="632515" 
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Expected Delivery</label>
                                <input type="text" name="deliveryDate" readonly value="<%= expectedDelivery %>" 
                                       class="w-full mt-1 bg-slate-900 border border-slate-800 text-red-400 font-semibold rounded-lg px-3 py-2 text-xs cursor-not-allowed">
                            </div>
                        </div>

                        <div>
                            <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider mb-2 block">Payment Method</label>
                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                                <label class="flex items-center gap-2 p-2.5 rounded-lg border border-slate-800 bg-slate-950 hover:border-slate-700 cursor-pointer text-xs">
                                    <input type="radio" name="paymentMethod" value="UPI" checked class="accent-red-600">
                                    <span class="text-slate-200 font-medium">UPI / QR Pay</span>
                                </label>
                                <label class="flex items-center gap-2 p-2.5 rounded-lg border border-slate-800 bg-slate-950 hover:border-slate-700 cursor-pointer text-xs">
                                    <input type="radio" name="paymentMethod" value="Card" class="accent-red-600">
                                    <span class="text-slate-200 font-medium">Debit / Credit Card</span>
                                </label>
                                <label class="flex items-center gap-2 p-2.5 rounded-lg border border-slate-800 bg-slate-950 hover:border-slate-700 cursor-pointer text-xs">
                                    <input type="radio" name="paymentMethod" value="COD" class="accent-red-600">
                                    <span class="text-slate-200 font-medium">Cash on Delivery</span>
                                </label>
                            </div>
                        </div>

                        <div class="pt-4 border-t border-slate-800/80 space-y-2 text-xs">
                            <div class="flex justify-between text-slate-400">
                                <span>Item Subtotal</span>
                                <span class="text-white font-medium">&#8377; <%= pPrice %></span>
                            </div>
                            <div class="flex justify-between text-slate-400">
                                <span>Shipping Charge</span>
                                <span class="text-emerald-400 font-semibold">FREE</span>
                            </div>
                            <div class="flex justify-between text-slate-300 pt-2 border-t border-slate-800 font-bold text-sm">
                                <span>Grand Total</span>
                                <span class="text-red-500 text-base">&#8377; <%= pPrice %></span>
                            </div>
                        </div>

                        <button type="submit" class="w-full py-3 bg-red-600 hover:bg-red-700 active:scale-[0.99] text-white font-bold rounded-xl text-xs transition flex items-center justify-center gap-2 shadow-lg shadow-red-600/25">
                            <i class="fa-solid fa-lock"></i> Confirm Mock Pay
                        </button>
                    </form>
                </div>
            </div>
        <% } %>

    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500 mt-auto">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

</body>
</html>

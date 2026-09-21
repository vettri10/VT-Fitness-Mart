<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    String ctx = request.getContextPath();
    String pId = request.getParameter("pId");
    String pName = request.getParameter("pName");
    String pPrice = request.getParameter("pPrice");
    String pImg = request.getParameter("pImg");

    boolean hasItem = (pId != null && !pId.trim().isEmpty());
    if (pName == null || pName.trim().isEmpty()) {
        pName = "Olympic Barbell 20kg (7ft)";
    }
    if (pPrice == null || pPrice.trim().isEmpty()) {
        pPrice = "7999.00";
    }
    if (pImg == null || pImg.trim().isEmpty()) {
        pImg = "collars.jpg";
    }

    // Auto-calculate delivery date (Current date + 4 business days)
    String expectedDelivery = LocalDate.now().plusDays(4).format(DateTimeFormatter.ofPattern("dd MMMM, yyyy"));
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart & Checkout | VT Fitness Mart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="<%= ctx %>/catalog.jsp" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white">VT Fitness Mart</span>
            </a>
            <div class="flex items-center gap-4 text-xs font-semibold">
                <a href="<%= ctx %>/catalog.jsp" class="text-slate-300 hover:text-white transition flex items-center gap-1.5">
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

        <% if (!hasItem) { %>
            <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-12 text-center max-w-md mx-auto">
                <i class="fa-solid fa-cart-arrow-down text-5xl text-slate-600 mb-4"></i>
                <p class="text-slate-300 font-semibold mb-6">Your cart is currently empty</p>
                <a href="<%= ctx %>/catalog.jsp" class="px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl transition">
                    Browse Equipment
                </a>
            </div>
        <% } else { %>
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
                
                <!-- Left Column: Selected Item Card -->
                <div class="lg:col-span-5 space-y-4">
                    <div class="bg-slate-900/60 border border-slate-800 rounded-2xl p-5 flex items-center gap-4">
                        <img src="<%= ctx %>/assets/images/<%= pImg %>" 
                             class="w-24 h-24 object-cover rounded-xl bg-slate-950 border border-slate-800"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=300&auto=format&fit=crop';">
                        <div class="flex-1 min-w-0">
                            <h3 class="text-base font-bold text-white truncate"><%= pName %></h3>
                            <p class="text-xs text-slate-400 mt-1">Quantity: <span class="text-slate-200 font-semibold">1</span></p>
                            <p class="text-xs text-slate-400">Unit Price: &#8377; <%= pPrice %></p>
                            <a href="<%= ctx %>/cart.jsp" class="text-xs text-red-400 hover:text-red-300 mt-2 inline-flex items-center gap-1.5 transition">
                                <i class="fa-solid fa-trash-can"></i> Remove
                            </a>
                        </div>
                        <div class="text-right">
                            <p class="text-base font-bold text-white">&#8377; <%= pPrice %></p>
                        </div>
                    </div>

                    <!-- Shipping Guarantee Badge -->
                    <div class="bg-slate-900/40 border border-slate-800/80 rounded-xl p-4 flex items-center gap-3">
                        <i class="fa-solid fa-truck-fast text-red-500 text-xl"></i>
                        <div>
                            <p class="text-xs font-bold text-white">Guaranteed Express Delivery</p>
                            <p class="text-[11px] text-slate-400">Ships via verified logistics with insured freight handling.</p>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Detailed Checkout Form & Summary -->
                <div class="lg:col-span-7 bg-slate-900/60 border border-slate-800 rounded-2xl p-6 space-y-6">
                    <div class="border-b border-slate-800 pb-4 flex items-center justify-between">
                        <h2 class="text-base font-bold text-white flex items-center gap-2">
                            <i class="fa-solid fa-clipboard-check text-red-500"></i> Checkout & Delivery Details
                        </h2>
                        <span class="text-xs text-slate-400">Step 2 of 2</span>
                    </div>

                    <form action="<%= ctx %>/checkout" method="POST" class="space-y-4">
                        <input type="hidden" name="productId" value="<%= pId %>">
                        <input type="hidden" name="productName" value="<%= pName %>">
                        <input type="hidden" name="productPrice" value="<%= pPrice %>">

                        <!-- Row 1: Name & Phone -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Full Name</label>
                                <input type="text" name="customerName" required placeholder="e.g. Shesuma" 
                                       value="Shesuma"
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Phone Number</label>
                                <input type="tel" name="phone" required placeholder="+91 98765 43210" 
                                       value="+91 94421 87650"
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                        </div>

                        <!-- Row 2: Street Address -->
                        <div>
                            <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Street Address / Door No.</label>
                            <input type="text" name="shippingAddress" required placeholder="Flat No, Building, Street Area" 
                                   value="Plot No. 14D, Sri Sankarapuram"
                                   class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                        </div>

                        <!-- Row 3: District, Pincode & Delivery Date -->
                        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">District</label>
                                <input type="text" name="district" required placeholder="Vellore" 
                                       value="Vellore"
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Pincode</label>
                                <input type="text" name="pincode" required placeholder="632515" 
                                       value="632515"
                                       class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                            </div>
                            <div>
                                <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wider">Estimated Delivery</label>
                                <input type="text" name="deliveryDate" readonly 
                                       value="<%= expectedDelivery %>"
                                       class="w-full mt-1 bg-slate-900 border border-slate-800 text-red-400 font-semibold rounded-lg px-3 py-2 text-xs cursor-not-allowed">
                            </div>
                        </div>

                        <!-- Row 4: Payment Method Selection -->
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

                        <!-- Pricing Breakdown -->
                        <div class="pt-4 border-t border-slate-800/80 space-y-2 text-xs">
                            <div class="flex justify-between text-slate-400">
                                <span>Subtotal (1 item)</span>
                                <span class="text-white font-medium">&#8377; <%= pPrice %></span>
                            </div>
                            <div class="flex justify-between text-slate-400">
                                <span>Delivery & Heavy Freight</span>
                                <span class="text-emerald-400 font-semibold">FREE</span>
                            </div>
                            <div class="flex justify-between text-slate-300 pt-2 border-t border-slate-800 font-bold text-sm">
                                <span>Grand Total</span>
                                <span class="text-red-500 text-base">&#8377; <%= pPrice %></span>
                            </div>
                        </div>

                        <button type="submit" class="w-full py-3 bg-red-600 hover:bg-red-700 active:scale-[0.99] text-white font-bold rounded-xl text-xs transition flex items-center justify-center gap-2 shadow-lg shadow-red-600/25">
                            <i class="fa-solid fa-lock"></i> Confirm & Place Order (Mock Pay)
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

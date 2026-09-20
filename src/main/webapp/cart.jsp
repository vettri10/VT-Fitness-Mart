<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart | VT Fitness Mart</title>
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

        <!-- Empty Cart -->
        <div id="empty-view" class="hidden bg-slate-900/60 border border-slate-800 rounded-2xl p-12 text-center max-w-md mx-auto">
            <i class="fa-solid fa-cart-arrow-down text-5xl text-slate-600 mb-4"></i>
            <p class="text-slate-300 font-semibold mb-6">Your cart is currently empty.</p>
            <a href="<%= ctx %>/products" class="px-5 py-2.5 bg-red-600 hover:bg-red-700 text-white text-xs font-bold rounded-xl transition">
                Browse Equipment
            </a>
        </div>

        <!-- Loaded Cart -->
        <div id="content-view" class="hidden grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div id="items-box" class="lg:col-span-2 space-y-4"></div>

            <div class="bg-slate-900/60 border border-slate-800 rounded-xl p-6 h-fit space-y-5">
                <h2 class="text-base font-bold text-white border-b border-slate-800 pb-3">Order Summary</h2>
                <div class="space-y-2 text-xs">
                    <div class="flex justify-between text-slate-400">
                        <span>Total Items</span>
                        <span id="txt-items" class="text-white font-semibold">0</span>
                    </div>
                    <div class="flex justify-between text-slate-400 pt-2 border-t border-slate-800/60">
                        <span class="text-sm font-bold text-white">Grand Total</span>
                        <span id="txt-total" class="text-base font-bold text-red-500">&#8377; 0.00</span>
                    </div>
                </div>

                <form action="<%= ctx %>/checkout" method="POST" class="space-y-3 pt-2">
                    <div>
                        <label class="text-[11px] font-semibold text-slate-400 uppercase">Delivery Address</label>
                        <input type="text" name="shippingAddress" required 
                               value="Plot no. 14d, Sri Sankarapuram, Vellore - 632515"
                               class="w-full mt-1 bg-slate-950 border border-slate-800 rounded-lg px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                    </div>
                    <button type="submit" onclick="localStorage.removeItem('vt_cart_items')" class="w-full py-2.5 bg-red-600 hover:bg-red-700 active:scale-95 text-white font-bold rounded-xl text-xs transition flex items-center justify-center gap-2 shadow-lg shadow-red-600/20">
                        <i class="fa-solid fa-check"></i> Confirm Mock Pay
                    </button>
                </form>
            </div>
        </div>
    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

    <script>
        (function() {
            // Read URL Parameters (Servlet bypass)
            const urlParams = new URLSearchParams(window.location.search);
            const action = urlParams.get('action');
            const pId = urlParams.get('productId');
            const pName = urlParams.get('name');
            const pPrice = urlParams.get('price');

            let cart = JSON.parse(localStorage.getItem('vt_cart_items') || '[]');

            // Handle Add from URL parameters
            if (action === 'add' && pId) {
                let existing = cart.find(i => i.id === pId);
                if (existing) {
                    existing.qty = (parseInt(existing.qty) || 1) + 1;
                } else {
                    cart.push({
                        id: pId,
                        name: pName ? decodeURIComponent(pName) : 'Fitness Equipment #' + pId,
                        price: parseFloat(pPrice) || 2799.00,
                        qty: 1,
                        img: 'collars.jpg'
                    });
                }
                localStorage.setItem('vt_cart_items', JSON.stringify(cart));
                // Clean URL
                window.history.replaceState({}, document.title, window.location.pathname);
            }

            // Render
            const emptyView = document.getElementById('empty-view');
            const contentView = document.getElementById('content-view');
            const itemsBox = document.getElementById('items-box');

            if (!cart || cart.length === 0) {
                emptyView.classList.remove('hidden');
                contentView.classList.add('hidden');
                return;
            }

            emptyView.classList.add('hidden');
            contentView.classList.remove('hidden');
            itemsBox.innerHTML = '';

            let totalQty = 0;
            let grandTotal = 0;

            cart.forEach((item, idx) => {
                const sub = item.qty * item.price;
                totalQty += item.qty;
                grandTotal += sub;

                const div = document.createElement('div');
                div.className = 'bg-slate-900/60 border border-slate-800 rounded-xl p-4 flex items-center gap-4';
                div.innerHTML = `
                    <img src="<%= ctx %>/assets/images/\${item.img}" 
                         class="w-20 h-20 object-cover rounded-lg bg-slate-950"
                         onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=300&auto=format&fit=crop';">
                    <div class="flex-1 min-w-0">
                        <h3 class="text-sm font-bold text-white truncate">\${item.name}</h3>
                        <p class="text-xs text-slate-400 mt-1">Quantity: \${item.qty}</p>
                        <button onclick="removeCartItem(\${idx})" class="text-xs text-red-400 hover:text-red-300 mt-2 inline-flex items-center gap-1">
                            <i class="fa-solid fa-trash-can"></i> Remove
                        </button>
                    </div>
                    <div class="text-right">
                        <p class="text-sm font-bold text-white">&#8377; \${sub.toFixed(2)}</p>
                    </div>
                `;
                itemsBox.appendChild(div);
            });

            document.getElementById('txt-items').innerText = totalQty;
            document.getElementById('txt-total').innerText = '₹ ' + grandTotal.toFixed(2);
        })();

        window.removeCartItem = function(idx) {
            let cart = JSON.parse(localStorage.getItem('vt_cart_items') || '[]');
            cart.splice(idx, 1);
            localStorage.setItem('vt_cart_items', JSON.stringify(cart));
            location.reload();
        };
    </script>
</body>
</html>

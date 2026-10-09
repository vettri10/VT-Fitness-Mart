<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map, java.util.ArrayList" %>
<%
    String ctx = request.getContextPath();

    List<Map<String, String>> products = new ArrayList<>();
    
    // 1
    Map<String, String> p1 = new java.util.HashMap<>();
    p1.put("id", "1");
    p1.put("name", "Olympic Barbell 20kg (7ft)");
    p1.put("category", "Free Weights");
    p1.put("price", "7999.00");
    p1.put("rating", "4.9");
    p1.put("reviews", "48");
    p1.put("image", "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop");
    products.add(p1);

    // 2
    Map<String, String> p2 = new java.util.HashMap<>();
    p2.put("id", "2");
    p2.put("name", "Rubber Hex Dumbbell Set 20kg (Pair)");
    p2.put("category", "Free Weights");
    p2.put("price", "4499.00");
    p2.put("rating", "4.8");
    p2.put("reviews", "36");
    p2.put("image", "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?q=80&w=600&auto=format&fit=crop");
    products.add(p2);

    // 3
    Map<String, String> p3 = new java.util.HashMap<>();
    p3.put("id", "3");
    p3.put("name", "Cast Iron Competition Kettlebell 16kg");
    p3.put("category", "Conditioning");
    p3.put("price", "2799.00");
    p3.put("rating", "4.9");
    p3.put("reviews", "52");
    p3.put("image", "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop");
    products.add(p3);

    // 4
    Map<String, String> p4 = new java.util.HashMap<>();
    p4.put("id", "4");
    p4.put("name", "Adjustable Commercial Workout Bench (FID)");
    p4.put("category", "Benches & Racks");
    p4.put("price", "6499.00");
    p4.put("rating", "4.7");
    p4.put("reviews", "29");
    p4.put("image", "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop");
    products.add(p4);

    // 5
    Map<String, String> p5 = new java.util.HashMap<>();
    p5.put("id", "5");
    p5.put("name", "Heavy Duty Power Rack (11 Gauge Steel)");
    p5.put("category", "Benches & Racks");
    p5.put("price", "18999.00");
    p5.put("rating", "5.0");
    p5.put("reviews", "19");
    p5.put("image", "https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=600&auto=format&fit=crop");
    products.add(p5);

    // 6
    Map<String, String> p6 = new java.util.HashMap<>();
    p6.put("id", "6");
    p6.put("name", "Olympic Barbell Quick Lock Collars (Pair)");
    p6.put("category", "Accessories");
    p6.put("price", "799.00");
    p6.put("rating", "4.8");
    p6.put("reviews", "64");
    p6.put("image", "https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?q=80&w=600&auto=format&fit=crop");
    products.add(p6);

    // 7
    Map<String, String> p7 = new java.util.HashMap<>();
    p7.put("id", "7");
    p7.put("name", "Olympic Bumper Weight Plates 20kg (Pair)");
    p7.put("category", "Free Weights");
    p7.put("price", "5999.00");
    p7.put("rating", "4.9");
    p7.put("reviews", "41");
    p7.put("image", "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?q=80&w=600&auto=format&fit=crop");
    products.add(p7);

    // 8
    Map<String, String> p8 = new java.util.HashMap<>();
    p8.put("id", "8");
    p8.put("name", "EZ Curl Barbell 4ft Chrome Finish");
    p8.put("category", "Free Weights");
    p8.put("price", "2499.00");
    p8.put("rating", "4.8");
    p8.put("reviews", "33");
    p8.put("image", "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop");
    products.add(p8);

    // 9
    Map<String, String> p9 = new java.util.HashMap<>();
    p9.put("id", "9");
    p9.put("name", "Heavy Duty Battle Rope 15m (38mm Thick)");
    p9.put("category", "Conditioning");
    p9.put("price", "3299.00");
    p9.put("rating", "4.9");
    p9.put("reviews", "27");
    p9.put("image", "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop");
    products.add(p9);

    // 10
    Map<String, String> p10 = new java.util.HashMap<>();
    p10.put("id", "10");
    p10.put("name", "Commercial Squat Stand & Pull-up Station");
    p10.put("category", "Benches & Racks");
    p10.put("price", "12499.00");
    p10.put("rating", "4.8");
    p10.put("reviews", "15");
    p10.put("image", "https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=600&auto=format&fit=crop");
    products.add(p10);

    // 11
    Map<String, String> p11 = new java.util.HashMap<>();
    p11.put("id", "11");
    p11.put("name", "Cast Iron Kettlebell 24kg (Heavy)");
    p11.put("category", "Conditioning");
    p11.put("price", "3999.00");
    p11.put("rating", "5.0");
    p11.put("reviews", "22");
    p11.put("image", "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop");
    products.add(p11);

    // 12
    Map<String, String> p12 = new java.util.HashMap<>();
    p12.put("id", "12");
    p12.put("name", "Leather Weightlifting Belt & Wrist Wraps");
    p12.put("category", "Accessories");
    p12.put("price", "1499.00");
    p12.put("rating", "4.9");
    p12.put("reviews", "58");
    p12.put("image", "https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?q=80&w=600&auto=format&fit=crop");
    products.add(p12);
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Store Catalog | VT Fitness Mart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full relative">

    <!-- Toast Notification -->
    <div id="cartToast" class="fixed top-20 right-6 z-50 transform translate-y-[-100px] opacity-0 transition duration-300 pointer-events-none bg-slate-900 border border-emerald-500/40 text-emerald-400 px-4 py-3 rounded-xl shadow-2xl flex items-center gap-3 text-xs">
        <i class="fa-solid fa-circle-check text-base"></i>
        <span id="toastMsg" class="font-semibold text-slate-200">Equipment added to cart!</span>
    </div>

    <!-- Header Navigation -->
    <header class="sticky top-0 z-40 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white">VT Fitness Mart</span>
            </a>
            
            <div class="flex items-center gap-3 text-xs font-semibold">
                <a href="<%= ctx %>/products" class="px-3 py-1.5 rounded-lg bg-red-600 text-white font-bold transition">
                    <i class="fa-solid fa-store"></i> Catalog
                </a>
                <a href="<%= ctx %>/cart.jsp" class="px-3 py-1.5 rounded-lg bg-slate-900 text-slate-300 hover:bg-slate-800 border border-slate-800 transition flex items-center gap-2">
                    <i class="fa-solid fa-cart-shopping text-red-500"></i> Cart
                    <span id="cartCountBadge" class="bg-red-600 text-white text-[10px] font-bold px-1.5 py-0.2 rounded-full">0</span>
                </a>
                <a href="<%= ctx %>/cart.jsp?view=admin" class="px-3 py-1.5 rounded-lg bg-slate-900 text-slate-300 hover:bg-slate-800 border border-slate-800 transition flex items-center gap-1.5">
                    <i class="fa-solid fa-chart-line text-emerald-400"></i> Dashboard
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-8">
        
        <!-- Hero Section -->
        <div class="mb-10 text-center sm:text-left flex flex-col sm:flex-row items-center justify-between gap-6 border-b border-slate-800 pb-8">
            <div>
                <span class="text-xs font-bold text-red-500 uppercase tracking-widest bg-red-500/10 px-3 py-1 rounded-full border border-red-500/20">
                    Commercial Grade Steel & Heavy Gym Gear
                </span>
                <h1 class="text-3xl sm:text-4xl font-extrabold text-white mt-3">VT Fitness Equipment Vault</h1>
                <p class="text-xs sm:text-sm text-slate-400 mt-2 max-w-2xl">
                    Engineered for high-volume commercial training and home gyms across Tamil Nadu. All items dispatched with zero-damage insured freight courier.
                </p>
            </div>
            
            <div class="flex gap-3">
                <a href="<%= ctx %>/cart.jsp?view=admin" class="px-4 py-2.5 bg-slate-900 hover:bg-slate-800 border border-slate-800 text-xs font-bold text-slate-200 rounded-xl transition flex items-center gap-2">
                    <i class="fa-solid fa-chart-pie text-emerald-400"></i> View Store Analytics
                </a>
            </div>
        </div>

        <!-- Product Grid (12 Items) -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            <% for (Map<String, String> prod : products) { %>
                <div class="bg-slate-900/60 border border-slate-800 hover:border-slate-700 rounded-2xl overflow-hidden transition flex flex-col justify-between group">
                    <div class="relative overflow-hidden aspect-video bg-slate-950">
                        <img src="<%= prod.get("image") %>" 
                             alt="<%= prod.get("name") %>" 
                             class="w-full h-full object-cover group-hover:scale-105 transition duration-300"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop';">
                        <span class="absolute top-3 left-3 bg-slate-950/80 backdrop-blur-md text-[10px] font-bold text-slate-300 px-2.5 py-1 rounded-lg border border-slate-800">
                            <%= prod.get("category") %>
                        </span>
                    </div>

                    <div class="p-4 flex-1 flex flex-col justify-between">
                        <div>
                            <div class="flex items-center justify-between mb-1.5 text-xs">
                                <div class="text-amber-400 flex items-center gap-1 font-bold">
                                    <i class="fa-solid fa-star text-[11px]"></i>
                                    <span><%= prod.get("rating") %></span>
                                    <span class="text-slate-500 font-normal">(<%= prod.get("reviews") %>)</span>
                                </div>
                                <span class="text-emerald-400 text-[10px] font-bold bg-emerald-500/10 px-2 py-0.5 rounded">In Stock</span>
                            </div>
                            <h3 class="text-sm font-bold text-white group-hover:text-red-400 transition line-clamp-1"><%= prod.get("name") %></h3>
                            <p class="text-base font-extrabold text-white mt-2">&#8377; <%= prod.get("price") %></p>
                        </div>

                        <!-- Buttons: Add to Cart & Buy Now -->
                        <div class="mt-4 pt-3 border-t border-slate-800/80 grid grid-cols-2 gap-2">
                            <button onclick="addToCart('<%= prod.get("name").replace("'", "\\'") %>', '<%= prod.get("price") %>')"
                                    class="py-2 bg-slate-800 hover:bg-slate-700 active:scale-95 text-slate-200 font-semibold rounded-xl text-xs transition flex items-center justify-center gap-1.5 border border-slate-700">
                                <i class="fa-solid fa-cart-plus text-red-500"></i> Add to Cart
                            </button>
                            <a href="<%= ctx %>/cart.jsp?pId=<%= prod.get("id") %>&pName=<%= java.net.URLEncoder.encode(prod.get("name"), "UTF-8") %>&pPrice=<%= prod.get("price") %>&pImg=<%= java.net.URLEncoder.encode(prod.get("image"), "UTF-8") %>" 
                               class="py-2 bg-red-600 hover:bg-red-700 active:scale-95 text-white font-bold rounded-xl text-xs transition flex items-center justify-center gap-1 shadow-md shadow-red-600/20">
                                <i class="fa-solid fa-bolt text-[11px]"></i> Buy Now
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

    </main>

    <!-- ================= ZUPTO FRIENDLY AI ASSISTANT WIDGET ================= -->
    <div class="fixed bottom-6 right-6 z-50">
        <!-- Floating Toggle Button -->
        <button id="zuptoToggleBtn" onclick="toggleZupto()" 
                class="flex items-center gap-2.5 px-4 py-3 bg-gradient-to-r from-red-600 to-rose-600 hover:from-red-500 hover:to-rose-500 text-white font-bold rounded-full shadow-2xl shadow-red-600/40 border border-red-400/30 transition transform hover:scale-105 active:scale-95 text-xs">
            <span class="relative flex h-2.5 w-2.5">
                <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
                <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-400"></span>
            </span>
            <i class="fa-solid fa-robot text-sm"></i>
            <span>Ask Zupto AI 🔥</span>
        </button>

        <!-- Zupto Chat Window -->
        <div id="zuptoChatWindow" class="hidden absolute bottom-14 right-0 w-80 sm:w-96 bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl overflow-hidden flex flex-col">
            <!-- Header -->
            <div class="bg-gradient-to-r from-slate-950 via-slate-900 to-red-950/60 p-3.5 border-b border-slate-800 flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                    <div class="w-8 h-8 rounded-full bg-red-600/20 border border-red-500/40 flex items-center justify-center text-red-500 font-bold text-xs">
                        <i class="fa-solid fa-bolt"></i>
                    </div>
                    <div>
                        <h4 class="text-xs font-bold text-white flex items-center gap-1.5">
                            Zupto AI Gym Partner
                            <span class="bg-emerald-500/20 text-emerald-400 text-[9px] font-semibold px-1.5 py-0.2 rounded">Active Bro</span>
                        </h4>
                        <p class="text-[10px] text-slate-400">VT Mart Friendly Fitness Coach</p>
                    </div>
                </div>
                <button onclick="toggleZupto()" class="text-slate-400 hover:text-white text-sm p-1">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>

            <!-- Messages Area -->
            <div id="zuptoMessages" class="p-4 h-64 overflow-y-auto space-y-3 text-xs">
                <div class="bg-slate-950 border border-slate-800/80 rounded-xl p-3 text-slate-300">
                    <p class="font-semibold text-red-400 mb-1">Enna thala, vanakkam! 💪</p>
                    <p>Naan dhaan unga **Zupto AI partner**. Gym setup pannanuma, workout tips venuma, illa nalla equipment budget-la thedureengala? Enkitta edhu venaalum kelunga bro, tharamana gear pick panni tharren!</p>
                </div>
            </div>

            <!-- Quick Suggestions -->
            <div class="px-3 py-2 bg-slate-950/60 border-t border-slate-800/60 flex gap-1.5 overflow-x-auto text-[10px]">
                <button onclick="sendQuickPrompt('Home gym setup under 10k sollu bro')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    🏋️ Home Gym &lt; ₹10k
                </button>
                <button onclick="sendQuickPrompt('Deadlift and squat-ku nalla barbell sollu')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    💪 Best Barbell
                </button>
                <button onclick="sendQuickPrompt('Weight loss and belly fat reduce panna enna gear venum?')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    🔥 Fat Loss Gear
                </button>
                <button onclick="sendQuickPrompt('Beginner workout split sollu thala')" class="whitespace-nowrap px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 rounded-full border border-slate-700">
                    🎯 Workout Plan
                </button>
            </div>

            <!-- Input Bar -->
            <div class="p-2.5 bg-slate-950 border-t border-slate-800 flex gap-2">
                <input type="text" id="zuptoInput" placeholder="Kelu bro, enna venum gym gear pathi..." 
                       onkeydown="if(event.key==='Enter') sendZuptoMsg()"
                       class="flex-1 bg-slate-900 border border-slate-800 rounded-xl px-3 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                <button onclick="sendZuptoMsg()" class="px-3 py-2 bg-red-600 hover:bg-red-700 text-white rounded-xl text-xs transition">
                    <i class="fa-solid fa-paper-plane"></i>
                </button>
            </div>
        </div>
    </div>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500 mt-auto">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

    <script>
        let cartItems = 0;

        function addToCart(name, price) {
            cartItems++;
            const badge = document.getElementById('cartCountBadge');
            badge.innerText = cartItems;
            badge.classList.add('animate-bounce');
            setTimeout(() => badge.classList.remove('animate-bounce'), 600);

            // Show Toast
            const toast = document.getElementById('cartToast');
            document.getElementById('toastMsg').innerText = name + ' added to cart!';
            toast.classList.remove('translate-y-[-100px]', 'opacity-0');
            toast.classList.add('translate-y-0', 'opacity-100');

            setTimeout(() => {
                toast.classList.remove('translate-y-0', 'opacity-100');
                toast.classList.add('translate-y-[-100px]', 'opacity-0');
            }, 2500);
        }

        function toggleZupto() {
            const win = document.getElementById('zuptoChatWindow');
            if (win) win.classList.toggle('hidden');
        }

        function sendQuickPrompt(promptText) {
            document.getElementById('zuptoInput').value = promptText;
            sendZuptoMsg();
        }

        function sendZuptoMsg() {
            const input = document.getElementById('zuptoInput');
            const txt = input.value.trim();
            if (!txt) return;

            const box = document.getElementById('zuptoMessages');
            
            const uDiv = document.createElement('div');
            uDiv.className = 'bg-red-600/20 border border-red-500/30 rounded-xl p-2.5 text-slate-100 ml-6 text-right';
            uDiv.innerText = txt;
            box.appendChild(uDiv);
            input.value = '';
            box.scrollTop = box.scrollHeight;

            setTimeout(() => {
                let reply = "";
                const lower = txt.toLowerCase();

                if (lower.includes("10k") || lower.includes("home gym") || lower.includes("budget")) {
                    reply = "Mass bro! 10k budget-la neat-aa oru full-body setup potturalam:<br><br>"
                          + "• <b>Cast Iron Kettlebell 16kg</b> (₹2,799) - Core & Cardio-kku sema.<br>"
                          + "• <b>Rubber Hex Dumbbell Set 20kg</b> (₹4,499) - Arms & Chest blasting.<br>"
                          + "• <b>Quick Lock Barbell Collars</b> (₹799) - Safety first machan!<br><br>"
                          + "👉 <i>Mothama ₹8,097 dhaan varudhu bro, mitha panathula protein powder vaangikalam! Insured shipping VT Mart-la free!</i>";
                } else if (lower.includes("barbell") || lower.includes("deadlift") || lower.includes("squat")) {
                    reply = "Heavy deadlift and squat adikka poringala thala? Appo kandippa <b>Olympic Barbell 20kg (7ft)</b> dhaan best pick!<br><br>"
                          + "🔥 1500 lbs load capacity, needle bearing spin romba smooth-aa irukkum, knurling grip kaaila slip aagave aagadhu. Commercial gym standard piece bro idhu!";
                } else if (lower.includes("fat loss") || lower.includes("belly") || lower.includes("cardio") || lower.includes("weight loss")) {
                    reply = "Weight loss and fat burn panna HIIT dhaan king machan! 🔥<br><br>"
                          + "Treadmill-la verum nadakradha vida, namma store-la irukkura <b>Kettlebell swings (16kg)</b> & <b>Battle Ropes</b> pottu 20 mins circuit training pannunga, calorie burn double-aa aagum. Along with high-protein diet, weight rocket speed-la korayum!";
                } else if (lower.includes("workout plan") || lower.includes("split") || lower.includes("beginner")) {
                    reply = "Sema bro! Beginners-kku <b>Push-Pull-Legs (PPL)</b> split dhaan mass:<br><br>"
                          + "• <b>Day 1:</b> Chest, Shoulder, Triceps (Bench Press, Dumbbell Fly)<br>"
                          + "• <b>Day 2:</b> Back, Biceps (Barbell Rows, Pull-ups, Curls)<br>"
                          + "• <b>Day 3:</b> Legs & Core (Squats, Kettlebell Lunges)<br>"
                          + "Consistency dhaan mukkiyam thala, daily 45 mins dedicate pannunga!";
                } else if (lower.includes("protein") || lower.includes("diet") || lower.includes("creatine")) {
                    reply = "Fitness-la 70% diet dhaan bro! Body weight-ku 1.6g to 2g protein per kg eduthukonga. Post-workout-la whey protein or egg whites, daily 3-5g creatine edutha strength and muscle fullness verithanama irukkum! 🥛";
                } else {
                    reply = "Purinjiduchu bro! Ungalukku romba durable-aa, commercial 11-gauge steel build gear dhaan namma VT Fitness Mart-la irukku. Catalog check pannitu cart-la podunga, 3 days-la Tamil Nadu full-aa freight logistics moolama safe-aa deliver panniduvom! 💥";
                }

                const bDiv = document.createElement('div');
                bDiv.className = 'bg-slate-950 border border-slate-800/80 rounded-xl p-3 text-slate-300';
                bDiv.innerHTML = "<p class='font-bold text-red-400 mb-1 flex items-center gap-1.5'><i class='fa-solid fa-bolt'></i> Zupto Bhai Solren:</p>" + reply;
                box.appendChild(bDiv);
                box.scrollTop = box.scrollHeight;
            }, 500);
        }
    </script>
</body>
</html>

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
            <% for (Map<String, String> prod :
                
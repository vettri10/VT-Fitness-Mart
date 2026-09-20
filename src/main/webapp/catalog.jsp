<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap" %>
<%
    String ctx = request.getContextPath();
    Object currentUser = session.getAttribute("user");
    if (currentUser == null) {
        currentUser = session.getAttribute("currentUser");
    }

    String selectedCategory = request.getParameter("category");
    String selectedKeyword = request.getParameter("keyword");

    // 40 Products as pure Maps (No constructor or method dependency)
    List<Map<String, String>> fullCatalog = new ArrayList<>();

    String[][] rawProducts = {
        // Free Weights (10)
        {"1", "Cast Iron Kettlebell 16kg", "Ergonomic wide grip textured kettlebell for crossfit swings.", "2799.00", "Free Weights", "collars.jpg"},
        {"2", "Olympic Barbell 20kg (7ft)", "High-tensile steel barbell with 1500lb capacity and needle bearings.", "7999.00", "Free Weights", "collars.jpg"},
        {"3", "Rubber Hex Dumbbell Set (20kg)", "Durable cast iron hex dumbbells with ergonomic chrome handles.", "4499.00", "Free Weights", "collars.jpg"},
        {"4", "Cast Iron Dumbbell Pair (10kg)", "Heavy-duty textured grip dumbbells for upper body workout.", "1899.00", "Free Weights", "collars.jpg"},
        {"5", "Cast Iron Dumbbell Pair (15kg)", "Solid weight iron dumbbells designed for strength training.", "2799.00", "Free Weights", "collars.jpg"},
        {"6", "Olympic Bumper Plates (5kg Pair)", "High density solid rubber bumper plates with steel inserts.", "1499.00", "Free Weights", "collars.jpg"},
        {"7", "Olympic Bumper Plates (10kg Pair)", "Standard Olympic size bumper plates built for heavy deadlifts.", "2699.00", "Free Weights", "collars.jpg"},
        {"8", "Olympic Bumper Plates (20kg Pair)", "Competition grade heavy rubber plates for squat and bench.", "4999.00", "Free Weights", "collars.jpg"},
        {"9", "EZ Curl Barbell (1.2m)", "Ergonomic curved bar to minimize wrist fatigue during curls.", "2499.00", "Free Weights", "collars.jpg"},
        {"10", "Hex Trap Barbell", "Specialized shrug and deadlift bar for balanced lifting.", "5999.00", "Free Weights", "collars.jpg"},

        // Benches (10)
        {"11", "Adjustable Workout Bench (FID)", "Multi-angle flat, incline, and decline workout bench.", "6499.00", "Benches", "bench.jpg"},
        {"12", "Heavy-Duty Flat Utility Bench", "Thick high-density padded foam flat bench with sturdy frame.", "3499.00", "Benches", "bench.jpg"},
        {"13", "Commercial Olympic Incline Bench", "Heavy gauge steel frame bench equipped with Olympic bar catchers.", "14999.00", "Benches", "bench.jpg"},
        {"14", "Commercial Olympic Decline Bench", "Reinforced decline bench targeting lower pectoral muscle development.", "14499.00", "Benches", "bench.jpg"},
        {"15", "Seated Preacher Arm Curl Bench", "Ergonomic armrest angle designed for strict isolated bicep curls.", "6999.00", "Benches", "bench.jpg"},
        {"16", "Hyperextension Roman Chair Bench", "Reinforced lower back and core developer bench station.", "5999.00", "Benches", "bench.jpg"},
        {"17", "Sissy Squat Machine Bench", "Compact deep squat station isolating quad and knee stability.", "5499.00", "Benches", "bench.jpg"},
        {"18", "Multi-Angle Foldable Ab Bench", "Space-saving abdominal crunch and sit-up decline bench.", "4299.00", "Benches", "bench.jpg"},
        {"19", "Competition Olympic Flat Press Bench", "Wide-stance powerlifting competition flat press bench.", "15999.00", "Benches", "bench.jpg"},
        {"20", "Adjustable Preacher & Hyperextension Combo", "Dual function compact bench for biceps and lower lumbar support.", "8499.00", "Benches", "bench.jpg"},

        // Machines (10)
        {"21", "Heavy-Duty Power Rack Cage", "Solid steel power cage with safety spotters and pull-up bar.", "24999.00", "Machines", "bench.jpg"},
        {"22", "Commercial Motorized Treadmill", "3.5 HP AC motor treadmill with auto-incline and shock absorbers.", "54999.00", "Machines", "bench.jpg"},
        {"23", "Cable Crossover Functional Trainer", "Dual weight-stack cable pulleys for unlimited exercise freedom.", "64999.00", "Machines", "pullupbar.jpg"},
        {"24", "Plate-Loaded Lat Pulldown Station", "High-low dual cable pulley system for back lat workouts.", "28999.00", "Machines", "pullupbar.jpg"},
        {"25", "Seated Cable Row Machine", "Heavy-duty commercial row station with anti-slip footplate.", "27499.00", "Machines", "pullupbar.jpg"},
        {"26", "45-Degree Leg Press & Hack Squat", "Smooth roller carriage commercial leg press with safety locks.", "58999.00", "Machines", "bench.jpg"},
        {"27", "Seated Leg Extension Machine", "Pin-select weight stack machine isolating quadriceps muscles.", "24999.00", "Machines", "bench.jpg"},
        {"28", "Prone Leg Curl Machine", "Ergonomic lying hamstring curl machine with contoured pads.", "24999.00", "Machines", "bench.jpg"},
        {"29", "Commercial Smith Machine System", "Linear bearing ultra-smooth vertical bar track with safety catches.", "41999.00", "Machines", "bench.jpg"},
        {"30", "Air Resistance Assault Bike", "High-intensity interval cardio trainer with heavy-duty fan.", "21999.00", "Machines", "pullupbar.jpg"},

        // Accessories (10)
        {"31", "Resistance Bands Set (5 Levels)", "Premium latex exercise loop bands with handles and door anchor.", "999.00", "Accessories", "rings.jpg"},
        {"32", "Olympic Barbell Quick Lock Collars", "High-impact nylon resin collars with quick release clamp.", "499.00", "Accessories", "collars.jpg"},
        {"33", "Gymnastic Wooden Rings with Straps", "Solid birch wood rings with 15ft heavy duty numbered straps.", "1699.00", "Accessories", "rings.jpg"},
        {"34", "Wall-Mounted Multi-Grip Pull-Up Bar", "Laser-cut heavy steel pull up station with foam grips.", "2299.00", "Accessories", "pullupbar.jpg"},
        {"35", "Heavy-Duty Battle Rope (15m)", "Poly-dacron conditioning rope with heat shrink handles.", "3499.00", "Accessories", "collars.jpg"},
        {"36", "10mm Leather Weightlifting Belt", "Top-grain genuine leather belt with heavy alloy buckle.", "1999.00", "Accessories", "collars.jpg"},
        {"37", "Neoprene Padded Lifting Wrist Straps", "Cotton webbed wrist support straps for heavy deadlifts.", "449.00", "Accessories", "collars.jpg"},
        {"38", "High-Density Foam Roller", "Deep tissue muscle recovery roller for mobility workouts.", "799.00", "Accessories", "collars.jpg"},
        {"39", "Kettlebell Wrist Guards Pair", "Padded shock-absorbing wrist sleeves for kettlebell cleans.", "599.00", "Accessories", "collars.jpg"},
        {"40", "Gym Chalk Ball & Container", "Refillable magnesium carbonate chalk ball for sweat-free grip.", "399.00", "Accessories", "collars.jpg"}
    };

    for (String[] raw : rawProducts) {
        Map<String, String> item = new HashMap<>();
        item.put("id", raw[0]);
        item.put("name", raw[1]);
        item.put("desc", raw[2]);
        item.put("price", raw[3]);
        item.put("category", raw[4]);
        item.put("img", raw[5]);
        fullCatalog.add(item);
    }

    // Filter Logic
    List<Map<String, String>> displayList = new ArrayList<>();
    boolean hasCategory = selectedCategory != null && !selectedCategory.trim().isEmpty() && !"All".equalsIgnoreCase(selectedCategory.trim());
    boolean hasKeyword = selectedKeyword != null && !selectedKeyword.trim().isEmpty();

    String kw = hasKeyword ? selectedKeyword.trim().toLowerCase() : "";
    String cat = hasCategory ? selectedCategory.trim().toLowerCase() : "";

    for (Map<String, String> p : fullCatalog) {
        boolean matchCat = !hasCategory || p.get("category").toLowerCase().equals(cat);
        boolean matchKw = !hasKeyword || (p.get("name").toLowerCase().contains(kw) || p.get("desc").toLowerCase().contains(kw));
        if (matchCat && matchKw) {
            displayList.add(p);
        }
    }
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VT Fitness Mart | Premium Gym Equipment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between gap-4">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-black text-xl px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white hidden sm:inline">VT Fitness Mart</span>
            </a>

            <form action="<%= ctx %>/products" method="GET" class="flex-1 max-w-md mx-4">
                <div class="relative flex items-center">
                    <input type="text" name="keyword" value="<%= selectedKeyword != null ? selectedKeyword : "" %>"
                           placeholder="Search products..." 
                           class="w-full bg-slate-900 border border-slate-800 rounded-lg pl-4 pr-20 py-2 text-xs text-slate-200 focus:outline-none focus:border-red-500">
                    <button type="submit" class="absolute right-1 px-3 py-1 bg-red-600 hover:bg-red-700 text-white text-xs font-semibold rounded-md transition">
                        Search
                    </button>
                </div>
            </form>

            <div class="flex items-center gap-4 text-xs font-semibold">
                <a href="<%= ctx %>/cart" class="flex items-center gap-1 text-slate-300 hover:text-white transition">
                    <i class="fa-solid fa-cart-shopping text-red-500"></i> Cart
                </a>
                <a href="<%= ctx %>/orders" class="flex items-center gap-1 text-slate-300 hover:text-white transition">
                    <i class="fa-solid fa-box text-red-500"></i> My Orders
                </a>
                <% if (currentUser != null) { %>
                    <span class="text-slate-400 hidden md:inline">Account Active</span>
                    <a href="<%= ctx %>/auth/logout" class="text-red-400 hover:text-red-300 transition">Logout</a>
                <% } else { %>
                    <a href="<%= ctx %>/auth/login.jsp" class="px-3 py-1.5 bg-slate-800 hover:bg-slate-700 text-white rounded-lg transition">Sign In</a>
                <% } %>
            </div>
        </div>
    </header>

    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-8">

        <div class="flex items-center gap-2 overflow-x-auto pb-4 mb-8 text-xs font-semibold scrollbar-none">
            <a href="<%= ctx %>/products" 
               class="px-4 py-2 rounded-lg transition <%= (selectedCategory == null || "All".equalsIgnoreCase(selectedCategory)) ? "bg-red-600 text-white" : "bg-slate-900 text-slate-400 hover:bg-slate-800" %>">
               All Equipment (<%= fullCatalog.size() %>)
            </a>
            <a href="<%= ctx %>/products?category=Machines" 
               class="px-4 py-2 rounded-lg transition <%= "Machines".equalsIgnoreCase(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 text-slate-400 hover:bg-slate-800" %>">
               Machines
            </a>
            <a href="<%= ctx %>/products?category=Free+Weights" 
               class="px-4 py-2 rounded-lg transition <%= "Free Weights".equalsIgnoreCase(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 text-slate-400 hover:bg-slate-800" %>">
               Free Weights
            </a>
            <a href="<%= ctx %>/products?category=Benches" 
               class="px-4 py-2 rounded-lg transition <%= "Benches".equalsIgnoreCase(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 text-slate-400 hover:bg-slate-800" %>">
               Benches
            </a>
            <a href="<%= ctx %>/products?category=Accessories" 
               class="px-4 py-2 rounded-lg transition <%= "Accessories".equalsIgnoreCase(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 text-slate-400 hover:bg-slate-800" %>">
               Accessories
            </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <% for (Map<String, String> p : displayList) { 
                String imgName = p.get("img");
            %>
                <div class="bg-slate-900/60 border border-slate-800 rounded-2xl overflow-hidden hover:border-slate-700 transition flex flex-col group">
                    <div class="h-52 bg-slate-950 relative overflow-hidden flex items-center justify-center p-2">
                        <img src="<%= ctx %>/assets/images/<%= imgName %>" 
                             alt="<%= p.get("name") %>" 
                             class="w-full h-full object-cover object-center group-hover:scale-105 transition duration-300"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop';">
                    </div>
                    <div class="p-5 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-[10px] font-bold tracking-wider uppercase text-red-500 font-mono"><%= p.get("category") %></span>
                            <h3 class="text-base font-bold text-white mt-1 group-hover:text-red-400 transition line-clamp-1"><%= p.get("name") %></h3>
                            <p class="text-xs text-slate-400 mt-1 line-clamp-2 leading-relaxed"><%= p.get("desc") %></p>
                        </div>
                        <div class="pt-5 mt-4 border-t border-slate-800/80 flex items-center justify-between">
                            <div>
                                <span class="text-lg font-bold text-white">&#8377; <%= p.get("price") %></span>
                            </div>
                            <a href="<%= ctx %>/cart?action=add&productId=<%= p.get("id") %>" 
                               class="px-4 py-2 bg-red-600 hover:bg-red-700 active:scale-95 text-white font-semibold rounded-lg text-xs transition flex items-center gap-1.5 shadow-lg shadow-red-600/20">
                                <i class="fa-solid fa-cart-plus"></i> Add to Cart
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>

    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

</body>
</html>

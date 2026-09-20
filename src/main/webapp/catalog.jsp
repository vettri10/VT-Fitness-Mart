<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.math.BigDecimal, com.vt.vtmart.model.Product, com.vt.vtmart.model.User" %>
<%
    String ctx = request.getContextPath();
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) {
        currentUser = (User) session.getAttribute("currentUser");
    }

    String selectedCategory = request.getParameter("category");
    String selectedKeyword = request.getParameter("keyword");

    // Static 40 Fitness Products Catalog
    List<Product> fullCatalog = new ArrayList<>();
    long id = 1;

    // --- FREE WEIGHTS (10 items) ---
    fullCatalog.add(new Product(id++, "Cast Iron Kettlebell 16kg", "Ergonomic wide grip textured kettlebell for crossfit swings.", new BigDecimal("2799.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Olympic Barbell 20kg (7ft)", "High-tensile steel barbell with 1500lb capacity and needle bearings.", new BigDecimal("7999.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Rubber Hex Dumbbell Set (20kg)", "Durable cast iron hex dumbbells with ergonomic chrome handles.", new BigDecimal("4499.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Cast Iron Dumbbell Pair (10kg)", "Heavy-duty textured grip dumbbells for upper body workout.", new BigDecimal("1899.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Cast Iron Dumbbell Pair (15kg)", "Solid weight iron dumbbells designed for strength training.", new BigDecimal("2799.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Olympic Bumper Plates (5kg Pair)", "High density solid rubber bumper plates with steel inserts.", new BigDecimal("1499.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Olympic Bumper Plates (10kg Pair)", "Standard Olympic size bumper plates built for heavy deadlifts.", new BigDecimal("2699.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Olympic Bumper Plates (20kg Pair)", "Competition grade heavy rubber plates for squat and bench.", new BigDecimal("4999.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "EZ Curl Barbell (1.2m)", "Ergonomic curved bar to minimize wrist fatigue during curls.", new BigDecimal("2499.00"), "Free Weights", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Hex Trap Barbell", "Specialized shrug and deadlift bar for balanced lifting.", new BigDecimal("5999.00"), "Free Weights", "collars.jpg"));

    // --- BENCHES (10 items) ---
    fullCatalog.add(new Product(id++, "Adjustable Workout Bench (FID)", "Multi-angle flat, incline, and decline workout bench.", new BigDecimal("6499.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Heavy-Duty Flat Utility Bench", "Thick high-density padded foam flat bench with sturdy frame.", new BigDecimal("3499.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Commercial Olympic Incline Bench", "Heavy gauge steel frame bench equipped with Olympic bar catchers.", new BigDecimal("14999.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Commercial Olympic Decline Bench", "Reinforced decline bench targeting lower pectoral muscle development.", new BigDecimal("14499.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Seated Preacher Arm Curl Bench", "Ergonomic armrest angle designed for strict isolated bicep curls.", new BigDecimal("6999.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Hyperextension Roman Chair Bench", "Reinforced lower back and core developer bench station.", new BigDecimal("5999.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Sissy Squat Machine Bench", "Compact deep squat station isolating quad and knee stability.", new BigDecimal("5499.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Multi-Angle Foldable Ab Bench", "Space-saving abdominal crunch and sit-up decline bench.", new BigDecimal("4299.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Competition Olympic Flat Press Bench", "Wide-stance powerlifting competition flat press bench.", new BigDecimal("15999.00"), "Benches", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Adjustable Preacher & Hyperextension Combo", "Dual function compact bench for biceps and lower lumbar support.", new BigDecimal("8499.00"), "Benches", "bench.jpg"));

    // --- MACHINES (10 items) ---
    fullCatalog.add(new Product(id++, "Heavy-Duty Power Rack Cage", "Solid steel power cage with safety spotters and pull-up bar.", new BigDecimal("24999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Commercial Motorized Treadmill", "3.5 HP AC motor treadmill with auto-incline and shock absorbers.", new BigDecimal("54999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Cable Crossover Functional Trainer", "Dual weight-stack cable pulleys for unlimited exercise freedom.", new BigDecimal("64999.00"), "Machines", "pullupbar.jpg"));
    fullCatalog.add(new Product(id++, "Plate-Loaded Lat Pulldown Station", "High-low dual cable pulley system for back lat workouts.", new BigDecimal("28999.00"), "Machines", "pullupbar.jpg"));
    fullCatalog.add(new Product(id++, "Seated Cable Row Machine", "Heavy-duty commercial row station with anti-slip footplate.", new BigDecimal("27499.00"), "Machines", "pullupbar.jpg"));
    fullCatalog.add(new Product(id++, "45-Degree Leg Press & Hack Squat", "Smooth roller carriage commercial leg press with safety locks.", new BigDecimal("58999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Seated Leg Extension Machine", "Pin-select weight stack machine isolating quadriceps muscles.", new BigDecimal("24999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Prone Leg Curl Machine", "Ergonomic lying hamstring curl machine with contoured pads.", new BigDecimal("24999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Commercial Smith Machine System", "Linear bearing ultra-smooth vertical bar track with safety catches.", new BigDecimal("41999.00"), "Machines", "bench.jpg"));
    fullCatalog.add(new Product(id++, "Air Resistance Assault Bike", "High-intensity interval cardio trainer with heavy-duty fan.", new BigDecimal("21999.00"), "Machines", "pullupbar.jpg"));

    // --- ACCESSORIES (10 items) ---
    fullCatalog.add(new Product(id++, "Resistance Bands Set (5 Levels)", "Premium latex exercise loop bands with handles and door anchor.", new BigDecimal("999.00"), "Accessories", "rings.jpg"));
    fullCatalog.add(new Product(id++, "Olympic Barbell Quick Lock Collars", "High-impact nylon resin collars with quick release clamp.", new BigDecimal("499.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Gymnastic Wooden Rings with Straps", "Solid birch wood rings with 15ft heavy duty numbered straps.", new BigDecimal("1699.00"), "Accessories", "rings.jpg"));
    fullCatalog.add(new Product(id++, "Wall-Mounted Multi-Grip Pull-Up Bar", "Laser-cut heavy steel pull up station with foam grips.", new BigDecimal("2299.00"), "Accessories", "pullupbar.jpg"));
    fullCatalog.add(new Product(id++, "Heavy-Duty Battle Rope (15m)", "Poly-dacron conditioning rope with heat shrink handles.", new BigDecimal("3499.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "10mm Leather Weightlifting Belt", "Top-grain genuine leather belt with heavy alloy buckle.", new BigDecimal("1999.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Neoprene Padded Lifting Wrist Straps", "Cotton webbed wrist support straps for heavy deadlifts.", new BigDecimal("449.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "High-Density Foam Roller", "Deep tissue muscle recovery roller for mobility workouts.", new BigDecimal("799.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Kettlebell Wrist Guards Pair", "Padded shock-absorbing wrist sleeves for kettlebell cleans.", new BigDecimal("599.00"), "Accessories", "collars.jpg"));
    fullCatalog.add(new Product(id++, "Gym Chalk Ball & Container", "Refillable magnesium carbonate chalk ball for sweat-free grip.", new BigDecimal("399.00"), "Accessories", "collars.jpg"));

    // Filter Logic
    List<Product> displayList = new ArrayList<>();
    boolean hasCategory = selectedCategory != null && !selectedCategory.trim().isEmpty() && !"All".equalsIgnoreCase(selectedCategory.trim());
    boolean hasKeyword = selectedKeyword != null && !selectedKeyword.trim().isEmpty();

    String kw = hasKeyword ? selectedKeyword.trim().toLowerCase() : "";
    String cat = hasCategory ? selectedCategory.trim().toLowerCase() : "";

    for (Product p : fullCatalog) {
        boolean matchCat = !hasCategory || (p.getCategory() != null && p.getCategory().toLowerCase().equals(cat));
        boolean matchKw = !hasKeyword || ((p.getName() != null && p.getName().toLowerCase().contains(kw)) ||
                                          (p.getDescription() != null && p.getDescription().toLowerCase().contains(kw)));
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

    <!-- Header Navigation -->
    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between gap-4">
            <a href="<%= ctx %>/products" class="flex items-center gap-2">
                <span class="bg-red-600 text-white font-black text-xl px-2.5 py-0.5 rounded">VT</span>
                <span class="font-bold text-lg tracking-tight text-white hidden sm:inline">VT Fitness Mart</span>
            </a>

            <!-- Search Bar -->
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

            <!-- Nav Links -->
            <div class="flex items-center gap-4 text-xs font-semibold">
                <a href="<%= ctx %>/cart" class="flex items-center gap-1 text-slate-300 hover:text-white transition">
                    <i class="fa-solid fa-cart-shopping text-red-500"></i> Cart
                </a>
                <a href="<%= ctx %>/orders" class="flex items-center gap-1 text-slate-300 hover:text-white transition">
                    <i class="fa-solid fa-box text-red-500"></i> My Orders
                </a>
                <% if (currentUser != null) { %>
                    <span class="text-slate-400 hidden md:inline">Hi, <%= currentUser.getFullName() != null ? currentUser.getFullName() : "User" %></span>
                    <a href="<%= ctx %>/auth/logout" class="text-red-400 hover:text-red-300 transition">Logout</a>
                <% } else { %>
                    <a href="<%= ctx %>/auth/login.jsp" class="px-3 py-1.5 bg-slate-800 hover:bg-slate-700 text-white rounded-lg transition">Sign In</a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Main Container -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-8">

        <!-- Category Filters -->
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

        <!-- Product Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <% for (Product p : displayList) { 
                String imgName = p.getImageUrl() != null ? p.getImageUrl() : "bench.jpg";
            %>
                <div class="bg-slate-900/60 border border-slate-800 rounded-2xl overflow-hidden hover:border-slate-700 transition flex flex-col group">
                    <div class="h-52 bg-slate-950 relative overflow-hidden flex items-center justify-center p-2">
                        <img src="<%= ctx %>/assets/images/<%= imgName %>" 
                             alt="<%= p.getName() %>" 
                             class="w-full h-full object-cover object-center group-hover:scale-105 transition duration-300"
                             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop';">
                    </div>
                    <div class="p-5 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-[10px] font-bold tracking-wider uppercase text-red-500 font-mono"><%= p.getCategory() %></span>
                            <h3 class="text-base font-bold text-white mt-1 group-hover:text-red-400 transition line-clamp-1"><%= p.getName() %></h3>
                            <p class="text-xs text-slate-400 mt-1 line-clamp-2 leading-relaxed"><%= p.getDescription() %></p>
                        </div>
                        <div class="pt-5 mt-4 border-t border-slate-800/80 flex items-center justify-between">
                            <div>
                                <span class="text-lg font-bold text-white">&#8377; <%= p.getPrice() %></span>
                            </div>
                            <a href="<%= ctx %>/cart?action=add&productId=<%= p.getId() %>" 
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

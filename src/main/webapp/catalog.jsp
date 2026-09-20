<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, com.vt.vtmart.model.Product, com.vt.vtmart.model.User" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VT Fitness | Pro Gym Storefront</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <%
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                currentUser = (User) session.getAttribute("currentUser");
            }
        }
        String selectedCategory = (String) request.getAttribute("selectedCategory");
        String selectedKeyword = (String) request.getAttribute("selectedKeyword");
        if (selectedKeyword == null) selectedKeyword = "";
        
        @SuppressWarnings("unchecked")
        List<Product> catalog = (List<Product>) request.getAttribute("catalog");
        String ctx = request.getContextPath();
        long cacheBust = System.currentTimeMillis();
    %>

    <!-- Global Header -->
    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <a href="<%= ctx %>/products" class="flex items-center gap-2">
                    <span class="bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded">VT</span>
                    <span class="font-bold text-lg tracking-tight text-white">VT Fitness Mart</span>
                </a>
            </div>

            <!-- Search Bar -->
            <div class="flex-1 max-w-md mx-8">
                <form action="<%= ctx %>/products" method="GET" class="relative flex items-center">
                    <input type="text" name="keyword" value="<%= selectedKeyword %>" placeholder="Search products..."
                           class="w-full bg-slate-900 border border-slate-800 text-sm rounded-lg pl-3 pr-20 py-2 text-slate-200 focus:outline-none focus:border-red-600 transition">
                    <button type="submit" class="absolute right-1 px-3 py-1 bg-slate-800 hover:bg-slate-700 text-xs font-semibold rounded text-slate-300 transition">
                        Search
                    </button>
                </form>
            </div>

            <!-- Navigation Links -->
            <div class="flex items-center gap-5 text-sm font-medium">
                <a href="<%= ctx %>/cart" class="text-slate-300 hover:text-white transition flex items-center">
                    <i class="fa-solid fa-cart-shopping me-1.5 text-red-500"></i>Cart
                </a>

                <% if (currentUser != null) { %>
                    <span class="text-slate-400">Hi, <strong class="text-slate-200"><%= currentUser.getName() != null ? currentUser.getName() : "Customer" %></strong></span>
                    <a href="<%= ctx %>/orders" class="text-slate-300 hover:text-white transition flex items-center">
                        <i class="fa-solid fa-receipt me-1.5 text-red-500"></i>My Orders
                    </a>
                    <a href="<%= ctx %>/auth/login" class="text-slate-400 hover:text-red-400 transition">
                        Logout
                    </a>
                <% } else { %>
                    <a href="<%= ctx %>/auth/login.jsp" class="text-red-500 hover:text-red-400 transition">
                        Sign In
                    </a>
                <% } %>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-8">
        <!-- Categories Filter -->
        <div class="flex items-center gap-2 mb-8 overflow-x-auto pb-2">
            <a href="<%= ctx %>/products" class="px-4 py-1.5 rounded-lg text-xs font-semibold <%= (selectedCategory == null || selectedCategory.trim().isEmpty()) ? "bg-red-600 text-white" : "bg-slate-900 border border-slate-800 text-slate-400 hover:text-white" %> transition">All Equipment</a>
            <a href="<%= ctx %>/products?category=Machines" class="px-4 py-1.5 rounded-lg text-xs font-semibold <%= "Machines".equals(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 border border-slate-800 text-slate-400 hover:text-white" %> transition">Machines</a>
            <a href="<%= ctx %>/products?category=Free+Weights" class="px-4 py-1.5 rounded-lg text-xs font-semibold <%= "Free Weights".equals(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 border border-slate-800 text-slate-400 hover:text-white" %> transition">Free Weights</a>
            <a href="<%= ctx %>/products?category=Benches" class="px-4 py-1.5 rounded-lg text-xs font-semibold <%= "Benches".equals(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 border border-slate-800 text-slate-400 hover:text-white" %> transition">Benches</a>
            <a href="<%= ctx %>/products?category=Accessories" class="px-4 py-1.5 rounded-lg text-xs font-semibold <%= "Accessories".equals(selectedCategory) ? "bg-red-600 text-white" : "bg-slate-900 border border-slate-800 text-slate-400 hover:text-white" %> transition">Accessories</a>
        </div>

        <!-- Product Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <% if (catalog != null && !catalog.isEmpty()) { 
                for (Product product : catalog) { 
                    String pName = product.getName() != null ? product.getName().toLowerCase() : "";
                    String imgFile = "collars.jpg";

                    if (pName.contains("collar")) {
                        imgFile = "collars.jpg";
                    } else if (pName.contains("bench") || pName.contains("squat") || pName.contains("sissy")) {
                        imgFile = "bench.jpg";
                    } else if (pName.contains("ring")) {
                        imgFile = "rings.jpg";
                    } else if (product.getImageUrl() != null && !product.getImageUrl().trim().isEmpty()) {
                        String rawImg = product.getImageUrl().trim();
                        if (rawImg.startsWith("http")) {
                            imgFile = rawImg;
                        } else {
                            imgFile = rawImg.replaceFirst("^/+", "").replaceFirst("^images/", "");
                        }
                    }

                    String finalImgSrc = imgFile.startsWith("http") ? imgFile : (ctx + "/images/" + imgFile + "?v=" + cacheBust);
            %>
                    <div class="bg-slate-900/60 border border-slate-800 rounded-xl overflow-hidden flex flex-col justify-between hover:border-slate-700 transition">
                        <div class="h-48 bg-slate-950 flex items-center justify-center overflow-hidden">
                            <img src="<%= finalImgSrc %>" alt="<%= product.getName() %>" class="w-full h-full object-cover">
                        </div>
                        <div class="p-5 flex-1 flex flex-col justify-between">
                            <div>
                                <span class="text-[10px] font-bold tracking-wider uppercase text-red-500"><%= product.getCategory() %></span>
                                <h3 class="font-bold text-slate-100 text-lg mt-1"><%= product.getName() %></h3>
                                <p class="text-xs text-slate-400 mt-2 line-clamp-2"><%= product.getDescription() %></p>
                            </div>
                            <div class="mt-6 flex items-center justify-between">
                                <span class="text-lg font-bold text-white">&#8377; <%= product.getPrice() %></span>
                                <form action="<%= ctx %>/cart" method="POST">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg text-xs font-semibold transition">
                                        Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
            <%  } 
            } else { %>
                <div class="col-span-full py-12 text-center text-slate-400">
                    <p class="text-base">No products found in this category.</p>
                </div>
            <% } %>
        </div>
    </main>

    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart - Anna University Capstone Project
    </footer>

</body>
</html>
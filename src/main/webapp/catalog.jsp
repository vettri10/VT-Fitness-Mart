<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VT Fitness | Pro Gym Storefront</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex flex-col min-h-full">

    <!-- Global Header -->
    <header class="sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800">
        <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <a href="${pageContext.request.contextPath}/products" class="flex items-center gap-2">
                    <span class="bg-red-600 hover:bg-red-700 text-white font-black text-xl px-2.5 py-1 rounded-lg tracking-wider">VT</span>
                    <span class="text-xl font-bold tracking-tight text-white">VT Fitness Mart</span>
                </a>
            </div>

            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/products" method="GET" class="flex items-center w-96 gap-2">
                <input type="text" name="keyword" value="${selectedKeyword}" placeholder="Search products..." 
                       class="w-full px-4 py-2 bg-[#0d0d0d] border border-slate-800 rounded-lg text-sm text-slate-100 placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-red-600" />
                <button type="submit" class="px-4 py-2 bg-[#171717] hover:bg-slate-700 text-sm font-medium rounded-lg text-white transition-colors">
                    Search
                </button>
            </form>

            <!-- Navigation Actions -->
            <div class="flex items-center gap-4 text-sm font-medium">
                <a href="${pageContext.request.contextPath}/cart" class="relative text-slate-300 hover:text-white flex items-center gap-1">
                    🛒 Cart
                </a>
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <span class="text-slate-400">Hi, <strong class="text-slate-100">${sessionScope.currentUser.name}</strong></span>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/logout" class="text-slate-300 hover:text-white">Sign In</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-1 max-w-7xl w-full mx-auto px-6 py-8">
        
        <div class="flex items-center gap-3 mb-8 overflow-x-auto pb-2">
            <a href="${pageContext.request.contextPath}/products" 
               class="px-4 py-2 rounded-full text-xs font-semibold ${empty selectedCategory ? 'bg-red-600 hover:bg-red-700 text-white' : 'bg-[#0d0d0d] text-slate-400 hover:bg-[#171717]'}">All Equipment</a>
            <a href="${pageContext.request.contextPath}/products?category=Machines" 
               class="px-4 py-2 rounded-full text-xs font-semibold ${selectedCategory eq 'Machines' ? 'bg-red-600 hover:bg-red-700 text-white' : 'bg-[#0d0d0d] text-slate-400 hover:bg-[#171717]'}">Machines</a>
            <a href="${pageContext.request.contextPath}/products?category=Free Weights" 
               class="px-4 py-2 rounded-full text-xs font-semibold ${selectedCategory eq 'Free Weights' ? 'bg-red-600 hover:bg-red-700 text-white' : 'bg-[#0d0d0d] text-slate-400 hover:bg-[#171717]'}">Free Weights</a>
            <a href="${pageContext.request.contextPath}/products?category=Benches" 
               class="px-4 py-2 rounded-full text-xs font-semibold ${selectedCategory eq 'Benches' ? 'bg-red-600 hover:bg-red-700 text-white' : 'bg-[#0d0d0d] text-slate-400 hover:bg-[#171717]'}">Benches</a>
            <a href="${pageContext.request.contextPath}/products?category=Accessories" 
               class="px-4 py-2 rounded-full text-xs font-semibold ${selectedCategory eq 'Accessories' ? 'bg-red-600 hover:bg-red-700 text-white' : 'bg-[#0d0d0d] text-slate-400 hover:bg-[#171717]'}">Accessories</a>
        </div>

        <!-- Product Cards Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach var="item" items="${catalog}">
                <div class="bg-[#0d0d0d] border border-slate-800 rounded-2xl overflow-hidden flex flex-col hover:border-red-600/30 transition">
                    <div class="aspect-video w-full overflow-hidden bg-slate-950">
                        <img src="${item.imageUrl}" alt="${item.name}" class="w-full h-full object-cover">
                    </div>
                    <div class="p-6 flex-1 flex flex-col justify-between">
                        <div>
                            <span class="text-xs font-semibold uppercase tracking-wider text-red-500">${item.category}</span>
                            <h3 class="text-lg font-bold text-white mt-1">${item.name}</h3>
                            <p class="text-slate-400 text-sm mt-2 line-clamp-2">${item.description}</p>
                        </div>
                        <div class="mt-6 flex items-center justify-between pt-4 border-t border-slate-800">
                            <div>
                                <span class="text-xs text-slate-500">Price</span>
                                <p class="text-xl font-black text-white">₹${item.price}</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/cart" method="POST">
                                <input type="hidden" name="action" value="add" />
                                <input type="hidden" name="productId" value="${item.id}" />
                                <button type="submit" class="px-4 py-2 bg-red-600 hover:bg-red-700 hover:bg-indigo-500 text-white text-sm font-semibold rounded-lg shadow transition">
                                    Add to Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <!-- Footer -->
    <footer class="border-t border-slate-800 py-6 text-center text-xs text-slate-500">
        &copy; 2026 VT Fitness Mart Capstone Project | Anna University R2025.
    </footer>
</body>
</html>




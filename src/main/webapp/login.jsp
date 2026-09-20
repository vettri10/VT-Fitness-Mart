<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vt.vtmart.model.User" %>
<%
    // Direct JSP Server-Side Handler (Zero Servlet Dependency)
    String reqMethod = request.getMethod();
    String quick = request.getParameter("quick");

    if ("POST".equalsIgnoreCase(reqMethod) || quick != null) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isAuthenticated = false;
        String role = "BUYER";
        String userName = "Buyer Demo";

        if ("buyer".equalsIgnoreCase(quick) || ("buyer@vtmart.com".equalsIgnoreCase(email) && "Password@123".equals(password))) {
            isAuthenticated = true;
            userName = "Buyer Demo";
            role = "BUYER";
        } else if ("seller".equalsIgnoreCase(quick) || ("seller@vtmart.com".equalsIgnoreCase(email) && "Password@123".equals(password))) {
            isAuthenticated = true;
            userName = "Seller Demo";
            role = "SELLER";
        }

        if (isAuthenticated) {
            User user = new User();
            user.setId(1L);
            user.setName(userName);
            user.setEmail(email != null ? email : (role.equals("BUYER") ? "buyer@vtmart.com" : "seller@vtmart.com"));
            user.setRole(role);

            session.setAttribute("user", user);
            session.setAttribute("currentUser", user);

            response.sendRedirect(request.getContextPath() + "/products");
            return;
        } else {
            response.sendRedirect(request.getRequestURI() + "?error=invalid_credentials");
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-950 text-slate-100">
<head>
    <meta charset="UTF-8">
    <title>VTMart | Account Authentication</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>
</head>
<body class="flex items-center justify-center min-h-full px-4 py-12">
    <div class="max-w-md w-full space-y-6 bg-[#0b0c10]/90 border border-slate-800 p-8 rounded-2xl backdrop-blur-sm shadow-xl">
        <div class="text-center">
            <span class="inline-block bg-red-600 hover:bg-red-700 text-white font-bold text-lg px-3 py-1 rounded-lg">VT</span>
            <h2 class="mt-4 text-2xl font-bold text-white tracking-tight">Access Your VTMart Account</h2>
            <p class="text-sm text-slate-400 mt-1">Anna University Capstone Project Storefront</p>
        </div>

        <% if ("invalid_credentials".equals(request.getParameter("error"))) { %>
            <div class="p-3 bg-rose-500/10 border border-rose-500/30 text-rose-400 rounded-lg text-xs font-medium text-center">
                Invalid email or password.
            </div>
        <% } %>

        <!-- Traditional Form Submission pointing directly to this JSP -->
        <form action="<%= request.getRequestURI() %>" method="POST" class="space-y-4">
            <div>
                <label class="text-xs font-semibold uppercase text-slate-400">Email Address</label>
                <input type="email" name="email" required placeholder="buyer@vtmart.com"
                       class="mt-1 w-full px-3.5 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-sm text-white focus:outline-none focus:ring-2 focus:ring-red-600" />
            </div>
            <div>
                <label class="text-xs font-semibold uppercase text-slate-400">Password</label>
                <input type="password" name="password" required placeholder="••••••••"
                       class="mt-1 w-full px-3.5 py-2.5 bg-slate-950 border border-slate-800 rounded-lg text-sm text-white focus:outline-none focus:ring-2 focus:ring-red-600" />
            </div>
            <button type="submit"
                    class="w-full py-2.5 bg-red-600 hover:bg-red-700 text-white font-semibold rounded-lg text-sm transition cursor-pointer">
                Sign In
            </button>
        </form>

        <div class="relative flex py-1 items-center">
            <div class="flex-grow border-t border-slate-800"></div>
            <span class="flex-shrink mx-3 text-xs text-slate-500 uppercase">Or One-Click</span>
            <div class="flex-grow border-t border-slate-800"></div>
        </div>

        <!-- Direct Link Option -->
        <a href="<%= request.getRequestURI() %>?quick=buyer"
           class="block w-full text-center py-2 bg-slate-900 hover:bg-slate-800 text-slate-300 font-medium rounded-lg text-xs border border-slate-700 transition">
            ⚡ Instant Demo Buyer Login
        </a>

        <div class="border-t border-slate-800 pt-3 text-center">
            <p class="text-xs text-slate-500">Seed Accounts:</p>
            <p class="text-xs text-red-500 font-mono mt-0.5">buyer@vtmart.com | seller@vtmart.com</p>
            <p class="text-xs text-slate-500">Password: <span class="text-slate-300 font-mono">Password@123</span></p>
        </div>
    </div>
</body>
</html>

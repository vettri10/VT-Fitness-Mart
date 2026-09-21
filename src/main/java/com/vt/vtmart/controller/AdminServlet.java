package com.vt.vtmart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin", "/admin/dashboard", "/dashboard"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String ctx = request.getContextPath();

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en' class='h-full bg-slate-950 text-slate-100'>");
            out.println("<head>");
            out.println("  <meta charset='UTF-8'>");
            out.println("  <meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("  <title>Admin Dashboard & Analytics | VT Fitness Mart</title>");
            out.println("  <script src='https://cdn.tailwindcss.com'></script>");
            out.println("  <link href='https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap' rel='stylesheet'>");
            out.println("  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css'>");
            out.println("  <style>body { font-family: 'Plus Jakarta Sans', sans-serif; }</style>");
            out.println("</head>");
            out.println("<body class='flex flex-col min-h-full'>");

            // Header
            out.println("  <header class='sticky top-0 z-50 backdrop-blur-md bg-slate-950/80 border-b border-slate-800'>");
            out.println("    <div class='max-w-7xl mx-auto px-6 h-16 flex items-center justify-between'>");
            out.println("      <a href='" + ctx + "/products' class='flex items-center gap-2'>");
            out.println("        <span class='bg-red-600 text-white font-bold text-lg px-2.5 py-0.5 rounded'>VT</span>");
            out.println("        <span class='font-bold text-lg tracking-tight text-white'>VT Mart Operations & Analytics</span>");
            out.println("      </a>");
            out.println("      <a href='" + ctx + "/products' class='text-xs font-semibold text-slate-300 hover:text-white flex items-center gap-1.5 transition'>");
            out.println("        <i class='fa-solid fa-arrow-left text-red-500'></i> Back to Store");
            out.println("      </a>");
            out.println("    </div>");
            out.println("  </header>");

            // Content
            out.println("  <main class='flex-1 max-w-7xl w-full mx-auto px-6 py-8 space-y-8'>");
            out.println("    <div class='flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 border-b border-slate-800 pb-6'>");
            out.println("      <div>");
            out.println("        <h1 class='text-2xl font-bold text-white'>Executive Dashboard & Store Performance</h1>");
            out.println("        <p class='text-xs text-slate-400 mt-1'>Real-time tracking of revenue, order volume, and customer feedback metrics.</p>");
            out.println("      </div>");
            out.println("      <span class='inline-flex items-center gap-1.5 text-xs font-semibold text-emerald-400 bg-emerald-500/10 border border-emerald-500/20 px-3 py-1.5 rounded-full self-start'>");
            out.println("        <i class='fa-solid fa-circle text-[8px] animate-pulse'></i> Analytics Service Active");
            out.println("      </span>");
            out.println("    </div>");

            // 4 Metrics Grid
            out.println("    <div class='grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5'>");
            out.println("      <div class='bg-slate-900/60 border border-slate-800 rounded-2xl p-5'>");
            out.println("        <div class='flex items-center justify-between text-slate-400 mb-2'><span class='text-xs font-semibold uppercase'>Total Gross Revenue</span><i class='fa-solid fa-indian-rupee-sign text-emerald-400'></i></div>");
            out.println("        <h2 class='text-2xl font-bold text-white'>&#8377; 4,82,500</h2>");
            out.println("        <span class='text-[11px] text-emerald-400 font-semibold'>+18.4% growth this month</span>");
            out.println("      </div>");
            out.println("      <div class='bg-slate-900/60 border border-slate-800 rounded-2xl p-5'>");
            out.println("        <div class='flex items-center justify-between text-slate-400 mb-2'><span class='text-xs font-semibold uppercase'>Total Delivered</span><i class='fa-solid fa-box-open text-blue-400'></i></div>");
            out.println("        <h2 class='text-2xl font-bold text-white'>128 Orders</h2>");
            out.println("        <span class='text-[11px] text-slate-400'>Average fulfillment: 3.8 days</span>");
            out.println("      </div>");
            out.println("      <div class='bg-slate-900/60 border border-slate-800 rounded-2xl p-5'>");
            out.println("        <div class='flex items-center justify-between text-slate-400 mb-2'><span class='text-xs font-semibold uppercase'>Overall Rating</span><i class='fa-solid fa-star text-amber-400'></i></div>");
            out.println("        <h2 class='text-2xl font-bold text-white'>4.85 / 5.0</h2>");
            out.println("        <span class='text-[11px] text-amber-400 font-semibold'>Based on 320+ customer ratings</span>");
            out.println("      </div>");
            out.println("      <div class='bg-slate-900/60 border border-slate-800 rounded-2xl p-5'>");
            out.println("        <div class='flex items-center justify-between text-slate-400 mb-2'><span class='text-xs font-semibold uppercase'>Catalog Inventory</span><i class='fa-solid fa-warehouse text-purple-400'></i></div>");
            out.println("        <h2 class='text-2xl font-bold text-white'>40 Products</h2>");
            out.println("        <span class='text-[11px] text-emerald-400 font-semibold'>4 Categories: 100% In-Stock</span>");
            out.println("      </div>");
            out.println("    </div>");

            // Customer Reviews Feed
            out.println("    <div class='bg-slate-900/60 border border-slate-800 rounded-2xl p-6'>");
            out.println("      <div class='flex items-center justify-between mb-5 border-b border-slate-800 pb-3'>");
            out.println("        <h3 class='text-base font-bold text-white flex items-center gap-2'><i class='fa-solid fa-comments text-red-500'></i> Verified Customer Reviews & Ratings</h3>");
            out.println("        <span class='text-xs text-slate-400'>98.2% Positive Feed</span>");
            out.println("      </div>");
            out.println("      <div class='space-y-4'>");
            out.println("        <div class='bg-slate-950/60 border border-slate-800/80 rounded-xl p-4'>");
            out.println("          <div class='flex justify-between items-center mb-1.5'>");
            out.println("            <span class='text-xs font-bold text-white'>Karthik R. (Vellore) &bull; <span class='text-slate-400 font-normal'>Olympic Barbell 20kg</span></span>");
            out.println("            <div class='text-amber-400 text-xs'><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i></div>");
            out.println("          </div>");
            out.println("          <p class='text-xs text-slate-300'>Knurling grip and spin are super smooth. Arrived safely via freight delivery in 3 days.</p>");
            out.println("        </div>");
            out.println("        <div class='bg-slate-950/60 border border-slate-800/80 rounded-xl p-4'>");
            out.println("          <div class='flex justify-between items-center mb-1.5'>");
            out.println("            <span class='text-xs font-bold text-white'>Praveen Kumar (Chennai) &bull; <span class='text-slate-400 font-normal'>Adjustable FID Bench</span></span>");
            out.println("            <div class='text-amber-400 text-xs'><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i></div>");
            out.println("          </div>");
            out.println("          <p class='text-xs text-slate-300'>Zero wobble during heavy presses. Padding quality and steel gauge are commercial grade.</p>");
            out.println("        </div>");
            out.println("        <div class='bg-slate-950/60 border border-slate-800/80 rounded-xl p-4'>");
            out.println("          <div class='flex justify-between items-center mb-1.5'>");
            out.println("            <span class='text-xs font-bold text-white'>Dinesh V. (Coimbatore) &bull; <span class='text-slate-400 font-normal'>Quick Lock Collars</span></span>");
            out.println("            <div class='text-amber-400 text-xs'><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star'></i><i class='fa-solid fa-star-half-stroke'></i></div>");
            out.println("          </div>");
            out.println("          <p class='text-xs text-slate-300'>Solid nylon clamp mechanism. Does not shift even after dropping 100kg deadlifts.</p>");
            out.println("        </div>");
            out.println("      </div>");
            out.println("    </div>");
            out.println("  </main>");

            out.println("  <footer class='border-t border-slate-800 py-6 text-center text-xs text-slate-500 mt-auto'>");
            out.println("    &copy; 2026 VT Fitness Mart - Anna University Capstone Project");
            out.println("  </footer>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}

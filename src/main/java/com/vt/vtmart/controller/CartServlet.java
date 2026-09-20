package com.vt.vtmart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        String action = req.getParameter("action");

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) session.getAttribute("sessionCartMap");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        if ("add".equalsIgnoreCase(action)) {
            String pIdStr = req.getParameter("productId");
            String pName = req.getParameter("name");
            String pPrice = req.getParameter("price");

            long productId = 1L;
            try {
                if (pIdStr != null) productId = Long.parseLong(pIdStr);
            } catch (Exception ignored) {}

            if (pName == null || pName.trim().isEmpty()) {
                pName = "Gym Equipment #" + productId;
            }

            BigDecimal price = new BigDecimal("999.00");
            try {
                if (pPrice != null) price = new BigDecimal(pPrice.trim());
            } catch (Exception ignored) {}

            boolean found = false;
            for (Map<String, Object> item : cartItems) {
                long id = (Long) item.get("id");
                if (id == productId) {
                    int qty = (Integer) item.get("quantity") + 1;
                    item.put("quantity", qty);
                    item.put("subtotal", price.multiply(BigDecimal.valueOf(qty)));
                    found = true;
                    break;
                }
            }

            if (!found) {
                Map<String, Object> newItem = new HashMap<>();
                newItem.put("id", productId);
                newItem.put("name", pName);
                newItem.put("price", price);
                newItem.put("quantity", 1);
                newItem.put("subtotal", price);
                newItem.put("image", "collars.jpg");
                cartItems.add(newItem);
            }

            session.setAttribute("sessionCartMap", cartItems);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("remove".equalsIgnoreCase(action)) {
            String pIdStr = req.getParameter("productId");
            long productId = -1L;
            try {
                if (pIdStr != null) productId = Long.parseLong(pIdStr);
            } catch (Exception ignored) {}

            Iterator<Map<String, Object>> it = cartItems.iterator();
            while (it.hasNext()) {
                Map<String, Object> item = it.next();
                if ((Long) item.get("id") == productId) {
                    it.remove();
                    break;
                }
            }
            session.setAttribute("sessionCartMap", cartItems);
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.setAttribute("cartItemsList", cartItems);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

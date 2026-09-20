package com.vt.vtmart.controller;

import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.model.User;
import com.vt.vtmart.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null && session != null) {
            user = (User) session.getAttribute("currentUser");
        }

        long userId = (user != null) ? user.getId() : 1L;
        List<CartItem> cartItems = new ArrayList<>();
        BigDecimal cartTotal = BigDecimal.ZERO;

        String query = "SELECT c.id, c.product_id, c.quantity, p.name, p.price " +
                       "FROM cart_items c " +
                       "JOIN products p ON c.product_id = p.id " +
                       "WHERE c.user_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setProductName(rs.getString("name"));
                    item.setQuantity(rs.getInt("quantity"));
                    
                    BigDecimal price = rs.getBigDecimal("price");
                    if (price == null) price = BigDecimal.ZERO;
                    item.setPrice(price);

                    BigDecimal subtotal = price.multiply(BigDecimal.valueOf(item.getQuantity()));
                    item.setSubtotal(subtotal);
                    cartTotal = cartTotal.add(subtotal);

                    cartItems.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartTotal", cartTotal);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null && session != null) {
            user = (User) session.getAttribute("currentUser");
        }
        long userId = (user != null) ? user.getId() : 1L;

        if ("remove".equalsIgnoreCase(action)) {
            String cartItemIdStr = req.getParameter("cartItemId");
            if (cartItemIdStr != null && !cartItemIdStr.trim().isEmpty()) {
                long cartItemId = Long.parseLong(cartItemIdStr.trim());
                try (Connection conn = DBUtil.getConnection();
                     PreparedStatement ps = conn.prepareStatement("DELETE FROM cart_items WHERE id = ?")) {
                    ps.setLong(1, cartItemId);
                    ps.executeUpdate();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            String productIdStr = req.getParameter("productId");
            String quantityStr = req.getParameter("quantity");
            long productId = (productIdStr != null && !productIdStr.trim().isEmpty()) ? Long.parseLong(productIdStr.trim()) : 1L;
            int quantity = (quantityStr != null && !quantityStr.trim().isEmpty()) ? Integer.parseInt(quantityStr.trim()) : 1;

            String checkSql = "SELECT id, quantity FROM cart_items WHERE user_id = ? AND product_id = ?";
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setLong(1, userId);
                psCheck.setLong(2, productId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        long cartItemId = rs.getLong("id");
                        int newQty = rs.getInt("quantity") + quantity;
                        try (PreparedStatement psUpdate = conn.prepareStatement("UPDATE cart_items SET quantity = ? WHERE id = ?")) {
                            psUpdate.setInt(1, newQty);
                            psUpdate.setLong(2, cartItemId);
                            psUpdate.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement psInsert = conn.prepareStatement("INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)")) {
                            psInsert.setLong(1, userId);
                            psInsert.setLong(2, productId);
                            psInsert.setInt(3, quantity);
                            psInsert.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
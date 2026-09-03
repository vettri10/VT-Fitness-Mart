package com.vt.vtmart.dao;

import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.model.Order;
import com.vt.vtmart.util.DBUtil;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public Long createOrder(Long userId, List<CartItem> cartItems, BigDecimal totalAmount) {
        String insertOrderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'CONFIRMED')";
        String insertItemSql = "INSERT INTO order_items (order_id, product_id, price_at_purchase, quantity) VALUES (?, ?, ?, ?)";
        String updateStockSql = "UPDATE products SET stock_qty = stock_qty - ? WHERE id = ? AND stock_qty >= ?";
        String clearCartSql = "DELETE FROM cart_items WHERE user_id = ?";

        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Begin ACID Transaction

            Long orderId = null;

            // 1. Insert Master Order record
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setLong(1, userId);
                psOrder.setBigDecimal(2, totalAmount);
                psOrder.executeUpdate();

                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getLong(1);
                    } else {
                        throw new SQLException("Failed to retrieve generated order ID.");
                    }
                }
            }

            // 2. Insert Order Items and decrement stock
            try (PreparedStatement psItem = conn.prepareStatement(insertItemSql);
                 PreparedStatement psStock = conn.prepareStatement(updateStockSql)) {

                for (CartItem item : cartItems) {
                    psItem.setLong(1, orderId);
                    psItem.setLong(2, item.getProductId());
                    psItem.setBigDecimal(3, item.getProductPrice());
                    psItem.setInt(4, item.getQuantity());
                    psItem.addBatch();

                    psStock.setInt(1, item.getQuantity());
                    psStock.setLong(2, item.getProductId());
                    psStock.setInt(3, item.getQuantity());
                    int updatedRows = psStock.executeUpdate();
                    if (updatedRows == 0) {
                        throw new SQLException("Insufficient stock for product ID: " + item.getProductId());
                    }
                }
                psItem.executeBatch();
            }

            // 3. Clear User Cart
            try (PreparedStatement psCart = conn.prepareStatement(clearCartSql)) {
                psCart.setLong(1, userId);
                psCart.executeUpdate();
            }

            conn.commit(); // Transaction Success
            return orderId;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Checkout transaction failed: " + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // New method for Order History
    public List<Order> findByUserId(Long userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order o = new Order();
                    o.setId(rs.getLong("id"));
                    o.setUserId(rs.getLong("user_id"));
                    o.setTotalAmount(rs.getBigDecimal("total_amount"));
                    o.setStatus(rs.getString("status"));
                    orders.add(o);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}

package com.vt.vtmart.dao;

import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<CartItem> getCartByUser(Long userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity, p.name, p.price, p.image_url " +
                     "FROM cart_items c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setUserId(rs.getLong("user_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("name"));
                    item.setProductPrice(rs.getBigDecimal("price"));
                    item.setImageUrl(rs.getString("image_url"));
                    list.add(item);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching cart items", e);
        }
        return list;
    }

    public void addToCart(Long userId, Long productId, int qty) {
        String sql = "MERGE INTO cart_items (user_id, product_id, quantity) KEY(user_id, product_id) " +
                     "VALUES (?, ?, COALESCE((SELECT quantity FROM cart_items WHERE user_id = ? AND product_id = ?), 0) + ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, productId);
            ps.setLong(3, userId);
            ps.setLong(4, productId);
            ps.setInt(5, qty);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding to cart", e);
        }
    }

    public void removeFromCart(Long userId, Long cartItemId) {
        String sql = "DELETE FROM cart_items WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, cartItemId);
            ps.setLong(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error removing cart item", e);
        }
    }

    public void clearCart(Long userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error clearing cart", e);
        }
    }
}
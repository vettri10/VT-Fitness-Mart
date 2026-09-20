package com.vt.vtmart.dao;

import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.util.DBUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<CartItem> getCartByUser(long userId) {
        List<CartItem> items = new ArrayList<>();
        String sql = "SELECT c.id, c.user_id, c.product_id, c.quantity, p.name, p.price, p.image_url " +
                     "FROM cart_items c JOIN products p ON c.product_id = p.id WHERE c.user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getLong("id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setProductName(rs.getString("name"));
                    item.setQuantity(rs.getInt("quantity"));
                    BigDecimal price = rs.getBigDecimal("price");
                    item.setPrice(price != null ? price : BigDecimal.ZERO);
                    item.setSubtotal(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                    items.add(item);
                }
            }
        } catch (Exception e) {
            System.out.println("CartDAO DB fallback triggered: " + e.getMessage());
        }
        return items;
    }

    public void clearCart(long userId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM cart_items WHERE user_id = ?")) {
            ps.setLong(1, userId);
            ps.executeUpdate();
        } catch (Exception ignored) {}
    }
}

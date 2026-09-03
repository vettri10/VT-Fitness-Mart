package com.vt.vtmart.dao;

import com.vt.vtmart.model.Product;
import com.vt.vtmart.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> searchProducts(String category, String keyword) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT id, seller_id, name, description, category, price, stock_qty, image_url, created_at FROM products WHERE stock_qty > 0 ");
        List<Object> params = new ArrayList<>();

        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("all")) {
            sql.append("AND category = ? ");
            params.add(category.trim());
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(name) LIKE ? OR LOWER(description) LIKE ?) ");
            String term = "%" + keyword.trim().toLowerCase() + "%";
            params.add(term);
            params.add(term);
        }

        sql.append("ORDER BY id DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product p = new Product();
                    p.setId(rs.getLong("id"));
                    p.setSellerId(rs.getLong("seller_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setCategory(rs.getString("category"));
                    p.setPrice(rs.getBigDecimal("price"));
                    p.setStockQty(rs.getInt("stock_qty"));
                    p.setImageUrl(rs.getString("image_url"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    products.add(p);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error executing product search query", e);
        }
        return products;
    }
}
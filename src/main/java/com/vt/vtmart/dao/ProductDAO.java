package com.vt.vtmart.dao;

import com.vt.vtmart.model.Product;
import com.vt.vtmart.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    private static synchronized void ensureProductsTableExists(Connection conn) {
        try (Statement stmt = conn.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100) UNIQUE NOT NULL, " +
                    "password_hash VARCHAR(255) NOT NULL, " +
                    "role VARCHAR(20) DEFAULT 'BUYER', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");

            try (ResultSet rsUser = stmt.executeQuery("SELECT COUNT(*) FROM users")) {
                if (rsUser.next() && rsUser.getInt(1) == 0) {
                    stmt.execute("INSERT INTO users (id, name, email, password_hash, role) VALUES " +
                            "(1, 'Admin Coach', 'admin@vtmart.com', 'admin123', 'ADMIN'), " +
                            "(2, 'Pro Fitness Seller', 'seller@vtmart.com', 'seller123', 'SELLER');");
                }
            }

            stmt.execute("CREATE TABLE IF NOT EXISTS products (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "seller_id INT, " +
                    "name VARCHAR(150) NOT NULL, " +
                    "description TEXT, " +
                    "category VARCHAR(50), " +
                    "price DECIMAL(10, 2) NOT NULL, " +
                    "stock_qty INT NOT NULL, " +
                    "image_url VARCHAR(500), " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");

            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM products")) {
                if (rs.next() && rs.getInt(1) == 0) {
                    stmt.execute("INSERT INTO products (id, seller_id, name, description, category, price, stock_qty, image_url) VALUES " +
                            "(1, 2, 'Rubber Hex Dumbbell Set (20kg)', 'Durable cast iron hex dumbbells with ergonomic chrome handles.', 'Free Weights', 4499.00, 25, 'https://images.unsplash.com/photo-1638805981949-3a152e93d8b5?w=800'), " +
                            "(2, 2, 'Commercial Motorized Treadmill', '3.5 HP AC motor treadmill with auto-incline and shock absorption.', 'Machines', 54999.00, 5, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=800'), " +
                            "(3, 2, 'Olympic Barbell 20kg (7ft)', 'High-tensile steel barbell with 1500lb capacity and needle bearings.', 'Free Weights', 7999.00, 15, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800'), " +
                            "(4, 2, 'Heavy-Duty Power Rack Cage', 'Solid steel power cage with safety spotters and multi-grip pull-up bar.', 'Machines', 24999.00, 8, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800'), " +
                            "(5, 2, 'Adjustable Workout Bench (FID)', 'Multi-angle Flat, Incline, and Decline workout bench.', 'Benches', 6499.00, 20, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=800'), " +
                            "(6, 2, 'Resistance Bands Set (5 Levels)', 'Premium latex exercise loop bands with handles and door anchor.', 'Accessories', 999.00, 40, 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800'), " +
                            "(7, 2, 'Cast Iron Kettlebell 16kg', 'Ergonomic wide grip textured kettlebell for crossfit swings.', 'Free Weights', 2799.00, 30, 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800');");
                }
            }
        } catch (Exception e) {
            System.err.println("Error initializing tables: " + e.getMessage());
            e.printStackTrace();
        }
    }

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

        try (Connection conn = DBUtil.getConnection()) {
            ensureProductsTableExists(conn);

            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
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
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error executing product search query", e);
        }
        return products;
    }
}

package com.vt.vtmart.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("VTMart: Initializing Database on Tomcat Startup...");
        try (Connection conn = DBUtil.getConnection(); Statement stmt = conn.createStatement()) {
            
            stmt.execute("CREATE TABLE IF NOT EXISTS users (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(100) NOT NULL, " +
                    "email VARCHAR(100) UNIQUE NOT NULL, " +
                    "password_hash VARCHAR(255) NOT NULL, " +
                    "role VARCHAR(20) DEFAULT 'BUYER', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");

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

            stmt.execute("CREATE TABLE IF NOT EXISTS cart_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "quantity INT DEFAULT 1, " +
                    "FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE, " +
                    "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE);");

            stmt.execute("CREATE TABLE IF NOT EXISTS orders (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "total_amount DECIMAL(10, 2) NOT NULL, " +
                    "shipping_address TEXT DEFAULT 'Standard Express Delivery Address', " +
                    "status VARCHAR(30) DEFAULT 'PENDING', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (user_id) REFERENCES orders(id) ON DELETE CASCADE);");

            stmt.execute("CREATE TABLE IF NOT EXISTS order_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "order_id INT NOT NULL, " +
                    "product_id INT NOT NULL, " +
                    "quantity INT NOT NULL, " +
                    "price_at_purchase DECIMAL(10, 2) NOT NULL, " +
                    "FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE, " +
                    "FOREIGN KEY (product_id) REFERENCES products(id));");

            // Seed if products table is empty
            var rs = stmt.executeQuery("SELECT COUNT(*) FROM products");
            if (rs.next() && rs.getInt(1) == 0) {
                stmt.execute("INSERT INTO users (id, name, email, password_hash, role) VALUES " +
                        "(1, 'Admin Coach', 'admin@vtmart.com', 'admin123', 'ADMIN'), " +
                        "(2, 'Pro Fitness Seller', 'seller@vtmart.com', 'seller123', 'SELLER'), " +
                        "(3, 'Test Buyer', 'buyer@vtmart.com', 'Password@123', 'BUYER');");

                stmt.execute("INSERT INTO products (id, seller_id, name, description, category, price, stock_qty, image_url) VALUES " +
                        "(1, 2, 'Rubber Hex Dumbbell Set (20kg)', 'Durable cast iron hex dumbbells with ergonomic chrome handles.', 'Free Weights', 4499.00, 25, 'https://images.unsplash.com/photo-1638805981949-3a152e93d8b5?w=800'), " +
                        "(2, 2, 'Commercial Motorized Treadmill', '3.5 HP AC motor treadmill with auto-incline and shock absorption.', 'Machines', 54999.00, 5, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=800'), " +
                        "(3, 2, 'Olympic Barbell 20kg (7ft)', 'High-tensile steel barbell with 1500lb capacity and needle bearings.', 'Free Weights', 7999.00, 15, 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800'), " +
                        "(4, 2, 'Heavy-Duty Power Rack Cage', 'Solid steel power cage with safety spotters and multi-grip pull-up bar.', 'Machines', 24999.00, 8, 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800'), " +
                        "(5, 2, 'Adjustable Workout Bench (FID)', 'Multi-angle Flat, Incline, and Decline workout bench.', 'Benches', 6499.00, 20, 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=800'), " +
                        "(6, 2, 'Resistance Bands Set (5 Levels)', 'Premium latex exercise loop bands with handles and door anchor.', 'Accessories', 999.00, 40, 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=800'), " +
                        "(7, 2, 'Cast Iron Kettlebell 16kg', 'Ergonomic wide grip textured kettlebell for conditioning.', 'Free Weights', 2799.00, 30, 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800');");
                System.out.println("VTMart: Tables and Products seeded successfully!");
            }
        } catch (Exception e) {
            System.err.println("VTMart Init Error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DBUtil.closePool();
    }
}

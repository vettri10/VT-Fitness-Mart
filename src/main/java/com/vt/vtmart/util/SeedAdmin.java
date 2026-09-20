package com.vt.vtmart.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SeedAdmin {
    public static void main(String[] args) {
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO users (email, password, role) VALUES ('admin@vtmart.com', 'Password123', 'ADMIN') " +
                         "ON DUPLICATE KEY UPDATE password = 'Password123', role = 'ADMIN'";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.executeUpdate();
                System.out.println(">>> SUCCESS: Admin account created/updated (admin@vtmart.com / Password123)");
            }

            try (PreparedStatement ps = conn.prepareStatement("SELECT id, email, role FROM users");
                 ResultSet rs = ps.executeQuery()) {
                System.out.println("--- Current Users in DB ---");
                while (rs.next()) {
                    System.out.println("User: " + rs.getLong("id") + " | " + rs.getString("email") + " | " + rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
package com.vt.vtmart.controller;

import com.vt.vtmart.model.User;
import com.vt.vtmart.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null && session != null) {
            user = (User) session.getAttribute("user");
        }

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp?error=unauthorized");
            return;
        }

        List<Map<String, Object>> userList = new ArrayList<>();
        List<Map<String, Object>> orderList = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            // Fetch Users
            try (PreparedStatement ps = conn.prepareStatement("SELECT id, email, role, created_at FROM users ORDER BY id DESC");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> u = new HashMap<>();
                    u.put("id", rs.getLong("id"));
                    u.put("email", rs.getString("email"));
                    u.put("role", rs.getString("role"));
                    u.put("created_at", rs.getTimestamp("created_at"));
                    userList.add(u);
                }
            }

            // Fetch Global Orders
            try (PreparedStatement ps = conn.prepareStatement("SELECT id, user_id, total_amount, status, created_at FROM orders ORDER BY id DESC");
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> o = new HashMap<>();
                    o.put("id", rs.getLong("id"));
                    o.put("userId", rs.getLong("user_id"));
                    o.put("totalAmount", rs.getBigDecimal("total_amount"));
                    o.put("status", rs.getString("status"));
                    o.put("createdAt", rs.getTimestamp("created_at"));
                    orderList.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("adminUsers", userList);
        req.setAttribute("adminOrders", orderList);
        req.getRequestDispatcher("/admin.jsp").forward(req, resp);
    }
}
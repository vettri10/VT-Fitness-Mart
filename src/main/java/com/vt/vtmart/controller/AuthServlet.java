package com.vt.vtmart.controller;

import com.vt.vtmart.model.User;
import com.vt.vtmart.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(urlPatterns = {"/auth/login", "/login"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equalsIgnoreCase(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/auth/login?error=invalid_credentials");
            return;
        }

        email = email.trim();
        password = password.trim();

        // 1. Instant fallback: Database slow-aa irundhalum login udane aagidum
        if (("buyer@vtmart.com".equalsIgnoreCase(email) || "seller@vtmart.com".equalsIgnoreCase(email)) 
                && "Password@123".equals(password)) {
            User user = new User();
            user.setId(1L);
            user.setName("buyer@vtmart.com".equalsIgnoreCase(email) ? "Buyer Demo" : "Seller Demo");
            user.setEmail(email);
            user.setRole("buyer@vtmart.com".equalsIgnoreCase(email) ? "BUYER" : "SELLER");

            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("currentUser", user);

            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        // 2. Regular Database check
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT id, name, email, password_hash, role FROM users WHERE LOWER(email) = LOWER(?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String storedPassword = rs.getString("password_hash");
                        if (storedPassword.equals(password)) {
                            User user = new User();
                            user.setId(rs.getLong("id"));
                            user.setName(rs.getString("name"));
                            user.setEmail(rs.getString("email"));
                            user.setRole(rs.getString("role"));

                            HttpSession session = req.getSession(true);
                            session.setAttribute("user", user);
                            session.setAttribute("currentUser", user);

                            resp.sendRedirect(req.getContextPath() + "/products");
                            return;
                        }
                    }
                }
            }
            resp.sendRedirect(req.getContextPath() + "/auth/login?error=invalid_credentials");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/auth/login?error=server_error");
        }
    }
}

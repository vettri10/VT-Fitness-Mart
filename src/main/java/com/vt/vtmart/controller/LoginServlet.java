package com.vt.vtmart.controller;

import com.vt.vtmart.dao.UserDAO;
import com.vt.vtmart.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String action = req.getParameter("action");

        if (uri.endsWith("/logout") || "logout".equalsIgnoreCase(action) || req.getParameter("logout") != null) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
            return;
        }

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Optional<User> userOpt = userDAO.findByEmail(email);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                if (password != null && password.equals(user.getPasswordHash())) {
                    HttpSession session = req.getSession(true);
                    session.setAttribute("user", user);
                    session.setAttribute("currentUser", user);
                    resp.sendRedirect(req.getContextPath() + "/products");
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("error", "Invalid Credentials");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
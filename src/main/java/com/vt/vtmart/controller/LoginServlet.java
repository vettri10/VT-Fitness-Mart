package com.vt.vtmart.controller;

import com.vt.vtmart.dao.UserDAO;
import com.vt.vtmart.model.User;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
            return;
        }

        Optional<User> userOpt = userDAO.findByEmail(email.trim());

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if ((user.getPasswordHash() != null && (user.getPasswordHash().equals(password) || (user.getPasswordHash().startsWith("$2") && org.mindrot.jbcrypt.BCrypt.checkpw(password, user.getPasswordHash()))))) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("currentUser", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("role", user.getRole());
                session.setAttribute("userName", user.getName());
                
                resp.sendRedirect(req.getContextPath() + "/products");
                return;
            }
        }

        req.setAttribute("error", "Invalid email or password.");
        req.getRequestDispatcher("/auth/login.jsp").forward(req, resp);
    }
}



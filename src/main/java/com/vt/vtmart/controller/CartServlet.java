package com.vt.vtmart.controller;

import com.vt.vtmart.dao.CartDAO;
import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private final CartDAO cartDAO = new CartDAO();

    private User getAuthenticatedUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) return null;
        
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            user = (User) session.getAttribute("user");
        }
        return user;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getAuthenticatedUser(req);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp?error=unauthorized");
            return;
        }

        List<CartItem> items = cartDAO.getCartByUser(user.getId());
        BigDecimal total = items.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        req.setAttribute("cartItems", items);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = getAuthenticatedUser(req);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp?error=unauthorized");
            return;
        }

        String action = req.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            Long productId = Long.parseLong(req.getParameter("productId"));
            cartDAO.addToCart(user.getId(), productId, 1);
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("remove".equalsIgnoreCase(action)) {
            Long cartItemId = Long.parseLong(req.getParameter("cartItemId"));
            cartDAO.removeFromCart(user.getId(), cartItemId);
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}

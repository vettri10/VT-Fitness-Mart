package com.vt.vtmart.controller;

import com.vt.vtmart.dao.CartDAO;
import com.vt.vtmart.dao.OrderDAO;
import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        List<CartItem> items = cartDAO.getCartByUser(user.getId());
        if (items == null || items.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            BigDecimal price = (item.getProductPrice() != null) ? item.getProductPrice() : BigDecimal.ZERO;
            total = total.add(price.multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        Long orderId = orderDAO.createOrder(user.getId(), items, total);

        response.sendRedirect(request.getContextPath() + "/order_success.jsp?orderId=" + orderId);
    }
}
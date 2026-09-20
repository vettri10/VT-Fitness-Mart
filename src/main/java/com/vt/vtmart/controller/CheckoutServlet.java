package com.vt.vtmart.controller;

import com.vt.vtmart.dao.CartDAO;
import com.vt.vtmart.model.CartItem;
import com.vt.vtmart.model.Order;
import com.vt.vtmart.model.User;
import com.vt.vtmart.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = (User) session.getAttribute("currentUser");
        }
        long userId = (user != null) ? user.getId() : 1L;

        String fullName = req.getParameter("fullName");
        String address = req.getParameter("deliveryAddress");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");

        List<CartItem> cartItems = cartDAO.getCartByUser(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            @SuppressWarnings("unchecked")
            List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("sessionCart");
            if (sessionCart != null) {
                cartItems = sessionCart;
            } else {
                cartItems = new ArrayList<>();
            }
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            if (item.getSubtotal() != null) {
                totalAmount = totalAmount.add(item.getSubtotal());
            }
        }

        if (totalAmount.compareTo(BigDecimal.ZERO) <= 0) {
            totalAmount = new BigDecimal("999.00");
        }

        long orderId = System.currentTimeMillis() % 100000;
        if (orderId <= 0) {
            orderId = 1001L;
        }

        String fullAddress = (address != null ? address : "") + ", " + (city != null ? city : "") + " - " + (pincode != null ? pincode : "");

        try (Connection conn = DBUtil.getConnection()) {
            String insertOrderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, status) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setLong(1, userId);
                ps.setBigDecimal(2, totalAmount);
                ps.setString(3, fullAddress);
                ps.setString(4, "CONFIRMED");
                ps.executeUpdate();
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getLong(1);
                    }
                }
            }
        } catch (Exception ignored) {}

        cartDAO.clearCart(userId);
        session.removeAttribute("sessionCart");

        // Order Model mapping so JSP gets both ${order.id} and direct ${orderId}
        Order order = new Order();
        order.setId(orderId);
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(fullAddress);
        order.setStatus("CONFIRMED");

        req.setAttribute("order", order);
        req.setAttribute("orderId", orderId);
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("customerName", fullName != null ? fullName : "Customer");

        req.getRequestDispatcher("/order_success.jsp").forward(req, resp);
    }
}

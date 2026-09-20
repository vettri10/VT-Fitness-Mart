package com.vt.vtmart.controller;

import com.vt.vtmart.dao.OrderDAO;
import com.vt.vtmart.model.Order;
import com.vt.vtmart.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({"/orders", "/checkout"})
public class OrderServlet extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Long userId = getUserIdFromSession(session);

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        List<Order> orders = orderDAO.findByUserId(userId);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Long userId = getUserIdFromSession(session);

        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String fullName = req.getParameter("fullName");
        String address = req.getParameter("address");
        String city = req.getParameter("city");
        String pincode = req.getParameter("pincode");
        String phone = req.getParameter("phone");

        String shippingAddress = (fullName != null ? fullName : "") + ", " +
                                (address != null ? address : "") + ", " +
                                (city != null ? city : "") + " - " +
                                (pincode != null ? pincode : "") + 
                                (phone != null ? " (Ph: " + phone + ")" : "");

        try {
            resp.sendRedirect(req.getContextPath() + "/order_success.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/cart.jsp?error=failed");
        }
    }

    private Long getUserIdFromSession(HttpSession session) {
        if (session == null) {
            return null;
        }

        Object uidObj = session.getAttribute("userId");
        if (uidObj instanceof Long) {
            return (Long) uidObj;
        } else if (uidObj instanceof Integer) {
            return ((Integer) uidObj).longValue();
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = (User) session.getAttribute("currentUser");
        }

        if (user != null && user.getId() != null) {
            return ((Number) user.getId()).longValue();
        }

        return null;
    }
}
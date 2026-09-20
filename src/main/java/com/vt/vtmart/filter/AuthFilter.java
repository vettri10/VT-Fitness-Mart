package com.vt.vtmart.filter;

import com.vt.vtmart.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/cart/*", "/checkout/*", "/orders/*", "/seller/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Fallback checking: checks both "user" and "currentUser" to prevent null session drops
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("user");
            if (currentUser == null) {
                currentUser = (User) session.getAttribute("currentUser");
            }
        }
        
        String path = req.getRequestURI();

        if (currentUser == null) {
            res.sendRedirect(req.getContextPath() + "/auth/login.jsp?error=unauthorized");
            return;
        }

        // Role-Based Access Control
        if (path.contains("/seller/") && !"SELLER".equalsIgnoreCase(currentUser.getRole()) && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Seller role required.");
            return;
        }

        if (path.contains("/admin/") && !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Admin privileges required.");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
package com.vt.vtmart.filter;

import com.vt.vtmart.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(true);

        // Session illana automatic-aa demo user set pannidum
        if (session.getAttribute("user") == null) {
            User demoUser = new User();
            demoUser.setId(1L);
            demoUser.setName("Buyer Demo");
            demoUser.setEmail("buyer@vtmart.com");
            demoUser.setRole("BUYER");

            session.setAttribute("user", demoUser);
            session.setAttribute("currentUser", demoUser);
        }

        // Direct-aa access pass pannidum, yaarayum login page-ku thalladhu
        chain.doFilter(request, response);
    }
}

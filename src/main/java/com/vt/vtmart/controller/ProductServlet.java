package com.vt.vtmart.controller;

import com.vt.vtmart.dao.ProductDAO;
import com.vt.vtmart.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", ""})
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String category = req.getParameter("category");
        String keyword = req.getParameter("keyword");

        List<Product> catalog = productDAO.searchProducts(category, keyword);
        
        req.setAttribute("catalog", catalog);
        req.setAttribute("selectedCategory", category);
        req.setAttribute("selectedKeyword", keyword);

        req.getRequestDispatcher("/catalog.jsp").forward(req, resp);
    }
}

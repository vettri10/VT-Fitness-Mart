package com.vt.vtmart.controller;

import com.vt.vtmart.dao.ProductDAO;
import com.vt.vtmart.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String category = req.getParameter("category");
        String keyword = req.getParameter("keyword");

        // Fetch all products from DAO
        List<Product> all = productDAO.getAllProducts();
        List<Product> catalog = new ArrayList<>();

        boolean filterCat = category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category.trim());
        boolean filterKey = keyword != null && !keyword.trim().isEmpty();

        String kw = filterKey ? keyword.trim().toLowerCase() : "";
        String cat = filterCat ? category.trim().toLowerCase() : "";

        if (all != null) {
            for (Product p : all) {
                boolean matchesCat = !filterCat || (p.getCategory() != null && p.getCategory().toLowerCase().equals(cat));
                boolean matchesKey = !filterKey || ((p.getName() != null && p.getName().toLowerCase().contains(kw)) ||
                                                    (p.getDescription() != null && p.getDescription().toLowerCase().contains(kw)));

                if (matchesCat && matchesKey) {
                    catalog.add(p);
                }
            }
        }
        
        req.setAttribute("catalog", catalog);
        req.setAttribute("selectedCategory", category);
        req.setAttribute("selectedKeyword", keyword);

        req.getRequestDispatcher("/catalog.jsp").forward(req, resp);
    }
}

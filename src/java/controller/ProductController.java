/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ICategoryDAO;
import dal.IProductDAO;
import dal.IUserDAO;
import dal.imp.CategoryDAO;
import dal.imp.ProductDAO;
import dal.imp.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import model.Category;
import model.Product;
import model.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author DELL
 */
@WebServlet(name="ProductController", urlPatterns={"/product","/productDetail"})
public class ProductController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  IProductDAO productDAO = new ProductDAO(); 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
    }else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        }else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
protected void getFilteredSortedPagedProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy các tham số lọc từ request
        String[] selectedCategories = request.getParameterValues("categories");
        String[] selectedBrands = request.getParameterValues("brands");
        double minPrice = request.getParameter("minPrice") != null ? Double.parseDouble(request.getParameter("minPrice")) : 0;
        double maxPrice = request.getParameter("maxPrice") != null ? Double.parseDouble(request.getParameter("maxPrice")) : Double.MAX_VALUE;
        if (selectedCategories == null) {
            selectedCategories = new String[0];
        }
        if (selectedBrands == null) {
            selectedBrands = new String[0];
        }
        // Lấy các tham số phân trang và sắp xếp
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int productsPerPage = 9;
        int offset = (page - 1) * productsPerPage;
        String sortOption = request.getParameter("sortOption") != null ? request.getParameter("sortOption") : "default";
        String orderBy = getOrderByClause(sortOption);  

        // Lấy danh sách sản phẩm với các điều kiện
        List<Product> products = productDAO.getProductsByPage(offset, productsPerPage, orderBy, selectedCategories, selectedBrands, minPrice, maxPrice);
        int totalProducts = productDAO.getTotalProducts(selectedCategories, selectedBrands, minPrice, maxPrice);
        int totalPages = (int) Math.ceil(totalProducts / (double) productsPerPage);

        // Set attributes và forward đến JSP
        request.setAttribute("listProducts", products);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("selectedOption", sortOption);
        request.setAttribute("categories", selectedCategories);
        request.setAttribute("brands", selectedBrands);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }

    private String getOrderByClause(String sortOption) {
        switch (sortOption) {
            case "priceDesc":
                return "SalePrice DESC";
            case "priceAsc":
                return "SalePrice ASC";
            case "saleDesc":
                return "p.Sale DESC";
            case "saleAsc":
                return "p.Sale ASC";
            default:
                return "p.ProductID";
        }
    }
      private void productDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        String category = request.getParameter("category");
        List<Product> productRelative = productDAO.getRelativeProducts(category);
        request.setAttribute("product", product);
        request.setAttribute("productRelative", productRelative);
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
    }
    }
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

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


@WebServlet(name = "ProductController", urlPatterns = {"/product", "/home", "/search","/productDetail"})
@MultipartConfig
public class ProductController extends HttpServlet {

    IProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/home")) {
            getSaleProducts(request, response);
        } else if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
        } else if (request.getServletPath().equals("/search")) {
            search(request, response);
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }

    protected void getSaleProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> listSale = productDAO.getSaleProducts();
        request.setAttribute("listSaleProducts", listSale);
        request.getRequestDispatcher("home.jsp").forward(request, response);
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

    protected void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String category = request.getParameter("category"); // Lấy category từ request

        // Lấy danh sách sản phẩm phù hợp với từ khóa tìm kiếm và category (nếu có)
        List<Product> products = productDAO.searchProducts(query, category);

        // Đưa danh sách sản phẩm vào request scope
        request.setAttribute("listProducts", products);

        // Chuyển hướng đến store.jsp để hiển thị kết quả
        request.getRequestDispatcher("store.jsp").forward(request, response);
    }

   

    private void productDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        int totalSold = productDAO.getTotalProductSold(productId); // Lấy số lượng đã bán
        String category = request.getParameter("category");
        List<Product> productRelative = productDAO.getRelativeProducts(category);
        request.setAttribute("product", product);
        request.setAttribute("totalSold", totalSold); // Truyền totalSold vào request
        request.setAttribute("productRelative", productRelative);
        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/home")) {
            getSaleProducts(request, response);
        } else if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
        } else if (request.getServletPath().equals("/search")) {
            search(request, response);
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }

}

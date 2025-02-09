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


@WebServlet(name = "ProductController", urlPatterns = {"/product", "/home", "/search", "/list", "/add", "/edit", "/update",
    "/deleteProduct", "/trash", "/restore", "/deleteTrash", "/productDetail", "/deleteMultipleProducts", "/productAction", "/sortProduct"})
@MultipartConfig
public class ProductController extends HttpServlet {

    IProductDAO productDAO = new ProductDAO();
    private static final String IMAGE_UPLOAD_DIR = "C:\\java&netbeans\\JavaWeb\\ShoesShop\\web\\img"; // Đường dẫn thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/home")) {
            getSaleProducts(request, response);
        } else if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
        } else if (request.getServletPath().equals("/search")) {
            search(request, response);
        } else if (request.getServletPath().equals("/list")) {
            getAllProduct(request, response);
        } else if (request.getServletPath().equals("/add")) {
            addProduct(request, response);
        } else if (request.getServletPath().equals("/edit")) {
            showEditForm(request, response);
        } else if (request.getServletPath().equals("/update")) {
            editProduct(request, response);
        } else if (request.getServletPath().equals("/deleteProduct")) {
            deleteProduct(request, response);
        } else if (request.getServletPath().equals("/trash")) {
            showTrash(request, response);
        } else if (request.getServletPath().equals("/restore")) {
            restoreProduct(request, response);
        } else if (request.getServletPath().equals("/deleteTrash")) {
            deleteTrash(request, response);
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else if (request.getServletPath().equals("/deleteMultipleProducts")) {
            deleteMultipleProducts(request, response);
        } else if (request.getServletPath().equals("/productAction")) {
            getAction(request, response);
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

    protected void getAllProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Product> list = productDAO.getAllProducts();
        User user = (User) session.getAttribute("user");

//        if (user == null || !user.getRole().equals("Admin")) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        request.setAttribute("list", list);
        request.getRequestDispatcher("productList.jsp").forward(request, response);
    }

    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String saleParam = request.getParameter("sale");
        int sale = 0; // Giá trị mặc định
        if (saleParam != null && !saleParam.isEmpty()) {
            sale = Integer.parseInt(saleParam);
        }
        int stock = Integer.parseInt(request.getParameter("stock"));
        String category = request.getParameter("category");
        String otherCategory = request.getParameter("otherCategory");

        // Nếu chọn "Khác", sử dụng giá trị nhập vào
        if ("Khác".equals(category) && otherCategory != null && !otherCategory.isEmpty()) {
            category = otherCategory; // Thay đổi danh mục thành giá trị nhập vào
        }
        String brand = request.getParameter("brand");

        // Xử lý ảnh
        Collection<Part> fileParts = request.getParts(); // Lấy tất cả các tệp được tải lên
        List<String> imageUrls = new ArrayList<>();

        for (Part filePart : fileParts) {
            if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + ".jpg"; // Tên tệp hình ảnh duy nhất
                File imageFile = new File(IMAGE_UPLOAD_DIR, fileName);
                filePart.write(imageFile.getAbsolutePath());
                String imageUrl = "./img/" + fileName;

                // Thêm vào danh sách ảnh
                imageUrls.add(imageUrl);
            }
        }

        // Tạo và lưu sản phẩm
        Product newProduct = new Product();
        newProduct.setProductName(productName);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setStock(stock);
        newProduct.setCategoryName(category); // Ghi danh mục sản phẩm
        // Lưu ảnh chính và ảnh chi tiết
        if (!imageUrls.isEmpty()) {
            newProduct.setImageURL(imageUrls.get(0)); // Ảnh chính là ảnh đầu tiên
            newProduct.setImageURLDetail(imageUrls.subList(1, imageUrls.size())); // Ảnh chi tiết là các ảnh còn lại
        }
        newProduct.setSale(sale);
        newProduct.setBrand(brand);
        productDAO.addProduct(newProduct);
        response.sendRedirect("/ShoesStoreWed/list");
    }

    protected void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int productId = Integer.parseInt(idParam);
        Product existingProduct = productDAO.getProductById(productId);
        request.setAttribute("product", existingProduct);
        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
    }

    protected void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int sale = Integer.parseInt(request.getParameter("sale"));
        String salePriceParam = request.getParameter("salePrice");
        double salePrice = 0;
        if (salePriceParam != null && !salePriceParam.isEmpty()) {
            salePrice = Double.parseDouble(salePriceParam);
        }
        int stock = Integer.parseInt(request.getParameter("stock"));
        String category = request.getParameter("category");
        String otherCategory = request.getParameter("otherCategory");

        // Nếu chọn "Khác", sử dụng giá trị nhập vào
        if ("Khác".equals(category) && otherCategory != null && !otherCategory.isEmpty()) {
            category = otherCategory; // Thay đổi danh mục thành giá trị nhập vào
        }
        String brand = request.getParameter("brand");

        // Xử lý ảnh
        Collection<Part> fileParts = request.getParts(); // Lấy tất cả các tệp được tải lên
        List<String> imageUrls = new ArrayList<>();

        for (Part filePart : fileParts) {
            if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + ".jpg"; // Tên tệp hình ảnh duy nhất
                File imageFile = new File(IMAGE_UPLOAD_DIR, fileName);
                filePart.write(imageFile.getAbsolutePath());
                String imageUrl = "./img/" + fileName;

                // Thêm vào danh sách ảnh
                imageUrls.add(imageUrl);
            }
        }

        // Lấy thông tin ảnh cũ
        Product existingProduct = productDAO.getProductById(productId);
        String imageUrl = existingProduct.getImageURL();
        List<String> imageURLDetail = existingProduct.getImageURLDetail();

        // Nếu có ảnh mới, cập nhật ảnh chính và ảnh chi tiết
        if (!imageUrls.isEmpty()) {
            // Xóa các ảnh cũ
            deleteImages(existingProduct);

            // Cập nhật ảnh mới
            imageUrl = imageUrls.get(0); // Ảnh chính là ảnh đầu tiên
            imageURLDetail = imageUrls.subList(1, imageUrls.size()); // Ảnh chi tiết là các ảnh còn lại
        }

        // Tạo đối tượng Product mới với thông tin đã cập nhật
        Product newProduct = new Product();
        newProduct.setProductID(productId);
        newProduct.setProductName(productName);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setSale(sale);
        newProduct.setSalePrice(salePrice);
        newProduct.setStock(stock);
        newProduct.setCategoryName(category); // Ghi danh mục sản phẩm
        newProduct.setBrand(brand);
        newProduct.setImageURL(imageUrl); // Cập nhật ảnh chính
        newProduct.setImageURLDetail(imageURLDetail); // Cập nhật ảnh chi tiết

        // Cập nhật sản phẩm trong database
        productDAO.updateProduct(newProduct);

        // Chuyển hướng về trang danh sách sản phẩm sau khi cập nhật thành công
        response.sendRedirect("list");
    }

// Phương thức để xóa các ảnh cũ của sản phẩm
    private void deleteImages(Product product) {
        // Xóa ảnh chính nếu tồn tại
        if (product.getImageURL() != null) {
            File mainImageFile = new File(IMAGE_UPLOAD_DIR, product.getImageURL().substring(6)); // Bỏ phần "./img/" trong đường dẫn
            if (mainImageFile.exists()) {
                mainImageFile.delete();
            }
        }

        // Xóa ảnh chi tiết nếu có
        if (product.getImageURLDetail() != null) {
            for (String detailImageUrl : product.getImageURLDetail()) {
                File detailImageFile = new File(IMAGE_UPLOAD_DIR, detailImageUrl.substring(6)); // Bỏ phần "./img/" trong đường dẫn
                if (detailImageFile.exists()) {
                    detailImageFile.delete();
                }
            }
        }
    }

    protected void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteProduct(productId); // Chuyển sản phẩm vào thùng rác
        response.sendRedirect("list");
    }

    protected void deleteMultipleProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] productIds = request.getParameterValues("productIds");
        if (productIds != null) {
            for (String idStr : productIds) {
                int productId = Integer.parseInt(idStr);
                productDAO.deleteProduct(productId); // Xóa từng sản phẩm
            }
        }
        response.sendRedirect("list"); // Điều hướng lại trang danh sách sản phẩm sau khi xóa
    }

    protected void deleteTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        productDAO.deleteTrash(productId); // Chuyển sản phẩm vào thùng rác
        response.sendRedirect("trash");
    }

    protected void deleteMultiTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] selectedProducts = request.getParameterValues("selectedProducts");

        if (selectedProducts != null) {
            for (String productIdStr : selectedProducts) {
                int productId = Integer.parseInt(productIdStr);
                productDAO.deleteTrash(productId);
            }
        }
        response.sendRedirect("trash");
    }

    protected void restoreProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        productDAO.restoreProduct(productId); // Khôi phục sản phẩm từ thùng rác
        response.sendRedirect("trash");
    }

    protected void restoreMultiple(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] selectedProducts = request.getParameterValues("selectedProducts");
        if (selectedProducts != null) {
            for (String id : selectedProducts) {
                int productId = Integer.parseInt(id);
                productDAO.restoreProduct(productId); // Khôi phục từng sản phẩm từ thùng rác
            }
        }
        response.sendRedirect("trash");
    }

    private void showTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> deletedProducts = productDAO.getDeletedProducts();
        request.setAttribute("listDeletedProducts", deletedProducts);
        request.getRequestDispatcher("trash.jsp").forward(request, response);
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

    protected void getAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("deleteMultiple".equals(action)) {
            deleteMultiTrash(request, response);
        } else if ("restoreMultiple".equals(action)) {
            restoreMultiple(request, response);
        }
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
        } else if (request.getServletPath().equals("/list")) {
            getAllProduct(request, response);
        } else if (request.getServletPath().equals("/add")) {
            addProduct(request, response);
        } else if (request.getServletPath().equals("/edit")) {
            showEditForm(request, response);
        } else if (request.getServletPath().equals("/update")) {
            editProduct(request, response);
        } else if (request.getServletPath().equals("/deleteProduct")) {
            deleteProduct(request, response);
        } else if (request.getServletPath().equals("/trash")) {
            showTrash(request, response);
        } else if (request.getServletPath().equals("/restore")) {
            restoreProduct(request, response);
        } else if (request.getServletPath().equals("/deleteTrash")) {
            deleteTrash(request, response);
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else if (request.getServletPath().equals("/deleteMultipleProducts")) {
            deleteMultipleProducts(request, response);
        } else if (request.getServletPath().equals("/productAction")) {
            getAction(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }

}

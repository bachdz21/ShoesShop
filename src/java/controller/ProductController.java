package controller;

import dal.ICategoryDAO;
import dal.IProductDAO;
import dal.IUserDAO;
import dal.imp.CategoryDAO;
import dal.imp.ProductDAO;
import dal.imp.ReviewDAO;
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
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;
import model.Product;
import model.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import model.Category;
import model.ProductVariant;
import model.Review;

@WebServlet(name = "ProductController", urlPatterns = {"/product", "/home", "/search", "/list", "/add", "/edit", "/update",
    "/deleteProduct", "/trash", "/restore", "/deleteTrash", "/productDetail", "/deleteMultipleProducts", "/productAction", "/sortProduct",
    "/updateDisplayedCategories", "/searchAdmin"})
@MultipartConfig
public class ProductController extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();
    IProductDAO productDAO = new ProductDAO();
    ICategoryDAO categoryDAO = new CategoryDAO();
    
    private static final String IMAGE_UPLOAD_DIR = "C:\\Users\\nvhoa\\OneDrive\\Documents\\GitHub\\ShoesShop\\web\\img"; // Đường dẫn thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/home")) {
            getHomeProducts(request, response);
        } else if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
        } else if (request.getServletPath().equals("/search")) {
            search(request, response);
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
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else if (request.getServletPath().equals("/deleteMultipleProducts")) {
            deleteMultipleProducts(request, response);
        } else if (request.getServletPath().equals("/productAction")) {
            getAction(request, response);
        } else if (request.getServletPath().equals("/updateDisplayedCategories")) {
            updateDisplayedCategories(request, response);
        } else if (request.getServletPath().equals("/list")) {
            filterProductList(request, response);      
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void getHomeProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đồng bộ SelectedCategories với Categories
        categoryDAO.syncSelectedCategories();

        // Lấy danh sách sản phẩm đang giảm giá
        List<Product> listSale = productDAO.getSaleProducts();

        // Lấy danh sách danh mục được chọn hiển thị
        List<Category> displayedCategories = categoryDAO.getDisplayedCategories();

        // Lấy tất cả danh mục để hiển thị trong modal (dành cho Staff)
        List<Category> allCategories = categoryDAO.getAllCategories();

        // Tạo một Map để lưu danh sách sản phẩm bán chạy nhất theo từng danh mục
        Map<String, List<Product>> mostSoldProductsByCategory = new HashMap<>();
        for (Category category : displayedCategories) {
            List<Product> mostSoldProducts = productDAO.getMostSoldProducts(category.getCategoryName());
            mostSoldProductsByCategory.put(category.getCategoryName(), mostSoldProducts);
        }

        // Đặt các thuộc tính vào request
        request.setAttribute("listSaleProducts", listSale);
        request.setAttribute("categories", displayedCategories);
        request.setAttribute("mostSoldProductsByCategory", mostSoldProductsByCategory);
        request.setAttribute("allCategories", allCategories);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
    
    protected void showUpdateDisplayedCategoriesForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("user") != null && 
            "Staff".equals(((User) request.getSession().getAttribute("user")).getRole())) {
            List<Category> allCategories = categoryDAO.getAllCategories();
            List<Category> displayedCategories = categoryDAO.getDisplayedCategories();
            request.setAttribute("allCategories", allCategories);
            request.setAttribute("displayedCategories", displayedCategories);
            request.getRequestDispatcher("updateDisplayedCategories.jsp").forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
    
    protected void updateDisplayedCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("user") != null && 
            "Staff".equals(((User) request.getSession().getAttribute("user")).getRole())) {
            String[] selectedCategories = request.getParameterValues("selectedCategories");
            List<Integer> selectedCategoryIds = new ArrayList<>();
            if (selectedCategories != null) {
                for (String id : selectedCategories) {
                    selectedCategoryIds.add(Integer.parseInt(id));
                }
            }
            categoryDAO.updateDisplayedCategories(selectedCategoryIds);
            response.sendRedirect("home");
        } else {
            response.sendRedirect("home");
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
        List<Category> listCategories = categoryDAO.getAllCategories();
        // Set attributes và forward đến JSP
        request.setAttribute("listProducts", products);
        request.setAttribute("listCategories", listCategories);
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

    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String priceParam = request.getParameter("price");
        String saleParam = request.getParameter("sale");
        String stockParam = request.getParameter("stock");
        String category = request.getParameter("category");
        String otherCategory = request.getParameter("otherCategory");
        String brand = request.getParameter("brand");

        // Kiểm tra input không được để trống
        if (productName == null || productName.trim().isEmpty() ||
            priceParam == null || priceParam.trim().isEmpty() ||
            stockParam == null || stockParam.trim().isEmpty() ||
            brand == null || brand.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin sản phẩm.");
            request.getRequestDispatcher("/addProduct2.jsp").forward(request, response);
            return;
        }

        try {
            double price = Double.parseDouble(priceParam);
            int stock = Integer.parseInt(stockParam);
            int sale = (saleParam != null && !saleParam.isEmpty()) ? Integer.parseInt(saleParam) : 0;

            // Kiểm tra số không được âm
            if (price < 0 || stock < 0 || sale < 0) {
                request.setAttribute("error", "Giá, số lượng và giảm giá không được là số âm.");
                request.getRequestDispatcher("/addProduct2.jsp").forward(request, response);
                return;
            }

            // Kiểm tra sale không vượt quá 100
            if (sale > 100) {
                request.setAttribute("error", "Giảm giá không được vượt quá 100%.");
                request.getRequestDispatcher("/addProduct2.jsp").forward(request, response);
                return;
            }

            // Nếu chọn "Khác", sử dụng giá trị nhập vào
            if ("Khác".equals(category) && otherCategory != null && !otherCategory.trim().isEmpty()) {
                category = otherCategory;
            }

            // Xử lý ảnh
            Collection<Part> fileParts = request.getParts();
            List<String> imageUrls = new ArrayList<>();

            for (Part filePart : fileParts) {
                if (filePart.getName().equals("images") && filePart.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + ".jpg";
                    File imageFile = new File(IMAGE_UPLOAD_DIR, fileName);
                    filePart.write(imageFile.getAbsolutePath());
                    String imageUrl = "./img/" + fileName;
                    imageUrls.add(imageUrl);
                }
            }

            // Tạo và lưu sản phẩm
            Product newProduct = new Product();
            newProduct.setProductName(productName);
            newProduct.setDescription(description);
            newProduct.setPrice(price);
            newProduct.setStock(stock);
            newProduct.setCategoryName(category);
            newProduct.setSale(sale);
            newProduct.setBrand(brand);

            // Lưu ảnh chính và ảnh chi tiết
            if (!imageUrls.isEmpty()) {
                newProduct.setImageURL(imageUrls.get(0)); // Ảnh chính
                newProduct.setImageURLDetail(imageUrls.subList(1, imageUrls.size())); // Ảnh chi tiết
            }

            productDAO.addProduct(newProduct);
            response.sendRedirect("./list");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập số hợp lệ cho giá, số lượng và giảm giá.");
            request.getRequestDispatcher("/addProduct2.jsp").forward(request, response);
        }
    }


    protected void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int productId = Integer.parseInt(idParam);
        Product existingProduct = productDAO.getProductById(productId);
        request.setAttribute("product", existingProduct);
        request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
    }

    protected void editProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate the product first
        if (!validateProduct(request, response)) {
            // If validation fails, forward back to the edit form with error messages
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("updateProduct.jsp").forward(request, response);
            return;
        }

        // If validation passes, proceed with updating the product
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
        if ("Other".equals(category) && otherCategory != null && !otherCategory.isEmpty()) {
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
            imageURLDetail = imageUrls.size() > 1 ? imageUrls.subList(1, imageUrls.size()) : new ArrayList<>(); // Ảnh chi tiết là các ảnh còn lại
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
    
    private boolean validateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String price = request.getParameter("price");
        String sale = request.getParameter("sale");
        String stock = request.getParameter("stock");
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String otherCategory = request.getParameter("otherCategory");

        boolean isValid = true;
        String errorMessage = "";

        // Validate ProductName (not empty)
        if (productName == null || productName.trim().isEmpty()) {
            errorMessage += "Tên sản phẩm không được để trống.<br>";
            isValid = false;
        }

        // Validate Price (not empty, numeric, and non-negative)
        if (price == null || price.trim().isEmpty()) {
            errorMessage += "Giá không được để trống.<br>";
            isValid = false;
        } else {
            try {
                double priceValue = Double.parseDouble(price);
                if (priceValue < 0) {
                    errorMessage += "Giá không được là số âm.<br>";
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage += "Giá phải là số.<br>";
                isValid = false;
            }
        }

        // Validate Sale (not empty, numeric, between 0 and 100)
        if (sale == null || sale.trim().isEmpty()) {
            // If sale is empty, set default value to 0
            request.setAttribute("sale", "0");
        } else {
            try {
                int saleValue = Integer.parseInt(sale);
                if (saleValue < 0) {
                    errorMessage += "Phần trăm giảm giá không được là số âm.<br>";
                    isValid = false;
                } else if (saleValue > 100) {
                    errorMessage += "Phần trăm giảm giá không được vượt quá 100%.<br>";
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage += "Phần trăm giảm giá phải là số.<br>";
                isValid = false;
            }
        }

        // Validate Stock (not empty, numeric, and non-negative)
        if (stock == null || stock.trim().isEmpty()) {
            errorMessage += "Số lượng không được để trống.<br>";
            isValid = false;
        } else {
            try {
                int stockValue = Integer.parseInt(stock);
                if (stockValue < 0) {
                    errorMessage += "Số lượng không được là số âm.<br>";
                    isValid = false;
                }
            } catch (NumberFormatException e) {
                errorMessage += "Số lượng phải là số nguyên.<br>";
                isValid = false;
            }
        }

        // Validate Category (not empty)
        if (category == null || category.trim().isEmpty()) {
            errorMessage += "Danh mục không được để trống.<br>";
            isValid = false;
        } else if ("Other".equals(category) && (otherCategory == null || otherCategory.trim().isEmpty())) {
            errorMessage += "Vui lòng nhập danh mục khác.<br>";
            isValid = false;
        }

        // Validate Brand (not empty)
        if (brand == null || brand.trim().isEmpty()) {
            errorMessage += "Thương hiệu không được để trống.<br>";
            isValid = false;
        }

        // If validation fails, set error message and return false
        if (!isValid) {
            request.setAttribute("error", errorMessage);
        }

        return isValid;
    }

// Phương thức để xóa các ảnh cũ của sản phẩm
    private void deleteImages(Product product) {
        // Xóa ảnh chính nếu tồn tại
        if (product.getImageURL() != null) {
            Path mainImagePath = Paths.get(IMAGE_UPLOAD_DIR, product.getImageURL().substring(6)); // Bỏ phần "./img/" trong đường dẫn
            try {
                Files.deleteIfExists(mainImagePath);
            } catch (IOException e) {
                e.printStackTrace(); // Hoặc log lỗi phù hợp
            }
        }

        // Xóa ảnh chi tiết nếu có
        if (product.getImageURLDetail() != null) {
            for (String detailImageUrl : product.getImageURLDetail()) {
                Path detailImagePath = Paths.get(IMAGE_UPLOAD_DIR, detailImageUrl.substring(6)); // Bỏ phần "./img/" trong đường dẫn
                try {
                    Files.deleteIfExists(detailImagePath); // Xóa file nếu tồn tại
                } catch (IOException e) {
                    System.err.println("Không thể xóa file: " + detailImagePath + " - " + e.getMessage());
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

    private ProductDAO productDAO2 = new ProductDAO();

    protected void showTrash(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 10;
        String category = request.getParameter("category");
        String brand = request.getParameter("brand");
        String search = request.getParameter("search");

        category = (category != null && !category.trim().isEmpty()) ? category : null;
        brand = (brand != null && !brand.trim().isEmpty()) ? brand : null;
        search = (search != null && !search.trim().isEmpty()) ? search : null;

        int totalProducts = productDAO2.countProductsByTable("DeletedProducts", category, brand, search);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalProducts == 0) page = 1;
        else if (page > totalPages) page = totalPages;

        int offset = (page - 1) * pageSize;
        String[] categories = category != null ? new String[]{category} : new String[0];
        String[] brands = brand != null ? new String[]{brand} : new String[0];

        List<Product> deletedProducts = productDAO2.getDeletedProducts();

        request.setAttribute("listDeletedProducts", deletedProducts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("categories", productDAO2.getAllCategories());
        request.setAttribute("brands", productDAO2.getAllBrands());

        System.out.println("Page: " + page + ", Total Deleted Products: " + totalProducts + ", Products on page: " + deletedProducts.size());
        request.getRequestDispatcher("trash.jsp").forward(request, response);
    }

    private void productDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        int totalSold = productDAO.getTotalProductSold(productId);
        String category = request.getParameter("category");
        List<Product> productRelative = productDAO.getRelativeProducts(category);
        List<Review> reviews = reviewDAO.getReviewsByProductID(productId);
        List<Integer> ratings = productDAO.getProductRatings(productId);
        List<Integer> ratingLevels = Arrays.asList(5, 4, 3, 2, 1);
        Collections.reverse(ratings);

        // Lấy danh sách variants
        List<ProductVariant> productVariants = productDAO.getProductVariantsByProductId(productId); // Thêm phương thức này vào IProductDAO
        request.setAttribute("productVariants", productVariants);
        
        // Gửi dữ liệu về JSP
        request.setAttribute("product", product);
        request.setAttribute("totalSold", totalSold);
        request.setAttribute("productRelative", productRelative);
        request.setAttribute("ratings", ratings);
        request.setAttribute("ratingLevels", ratingLevels);
        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher("productDetail.jsp").forward(request, response);
    }

    protected void getAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("restoreMultiple".equals(action)) {
            restoreMultiple(request, response);
        }
    }
    
    
    protected void filterProductList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            ProductDAO productDAO = new ProductDAO();
            int page = 1;
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int pageSize = 10;
            String category = request.getParameter("category");
            String brand = request.getParameter("brand");
            String search = request.getParameter("search");

            category = (category != null && !category.trim().isEmpty()) ? category : null;
            brand = (brand != null && !brand.trim().isEmpty()) ? brand : null;
            search = (search != null && !search.trim().isEmpty()) ? search : null;

            int totalProducts = productDAO.countProductsByTable("Products", category, brand, search);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalProducts == 0) page = 1;
            else if (page > totalPages) page = totalPages;

            int offset = (page - 1) * pageSize;
            String[] categories = category != null ? new String[]{category} : new String[0];
            String[] brands = brand != null ? new String[]{brand} : new String[0];

            List<Product> products = productDAO.searchProductsByTable("Products", offset, pageSize, categories, brands, search);

            request.setAttribute("list", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("categories", productDAO.getAllCategories());
            request.setAttribute("brands", productDAO.getAllBrands());

            System.out.println("Page: " + page + ", Total Products: " + totalProducts + ", Products on page: " + products.size());
            request.getRequestDispatcher("productList2.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/home")) {
            getHomeProducts(request, response);
        } else if (request.getServletPath().equals("/product")) {
            getFilteredSortedPagedProducts(request, response);
        } else if (request.getServletPath().equals("/search")) {
            search(request, response);
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
        } else if (request.getServletPath().equals("/productDetail")) {
            productDetail(request, response);
        } else if (request.getServletPath().equals("/deleteMultipleProducts")) {
            deleteMultipleProducts(request, response);
        } else if (request.getServletPath().equals("/productAction")) {
            getAction(request, response);
        } else if (request.getServletPath().equals("/updateDisplayedCategories")) {
            updateDisplayedCategories(request, response);
        } else if (request.getServletPath().equals("/list")) {
            filterProductList(request, response);  
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

}
package controller;

import dal.ICartDAO;
import dal.IProductDAO;
import dal.imp.CartDAO;
import dal.imp.ProductDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import model.Product;

@WebServlet(name = "CartController", urlPatterns = {"/cart", "/addCart", "/addCartQuick", "/cartItem", "/deleteCartItem", "/trashCart",
    "/deleteCartItemTrash", "/restoreCartItem", "/updateQuantity", "/addCartQuickFromWishlist"})
public class CartController extends HttpServlet {

    ICartDAO cartDAO = new CartDAO();
    IProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/addCart")) {
            addCart(request, response);
        } else if (request.getServletPath().equals("/cartItem")) {
            getCartItem(request, response);
        } else if (request.getServletPath().equals("/deleteCartItem")) {
            deleteCartItems(request, response);
        } else if (request.getServletPath().equals("/trashCart")) {
            getCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/deleteCartItemTrash")) {
            deleteCartItemsTrash(request, response);
        } else if (request.getServletPath().equals("/restoreCartItem")) {
            restoreCartItems(request, response);
        } else if (request.getServletPath().equals("/addCartQuick")) {
            addCartQuick(request, response);
        } else if (request.getServletPath().equals("/addCartQuickFromWishlist")) {
            addCartQuickFromWishlist(request, response);
        } else if (request.getServletPath().equals("/updateQuantity")) {
            updateQuantity(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    // Phương thức gộp để xóa một hoặc nhiều sản phẩm từ CartItems
    protected void deleteCartItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();
        List<Integer> productIds = new ArrayList<>();

        // Kiểm tra xem request có phải từ AJAX (xóa nhiều) hay từ link (xóa một)
        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            // Xử lý xóa nhiều sản phẩm qua AJAX
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(jsonBuilder.toString(), JsonObject.class);
            JsonArray productIdsArray = jsonObject.getAsJsonArray("productIds");
            for (JsonElement element : productIdsArray) {
                productIds.add(element.getAsInt());
            }
        } else {
            // Xử lý xóa một sản phẩm qua link
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                productIds.add(Integer.parseInt(productIdStr));
            }
        }

        if (productIds.isEmpty()) {
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : "cartItem");
            return;
        }

        cartDAO.deleteMultipleCartItems(userId, productIds);

        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);

        if (contentType != null && contentType.contains("application/json")) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null && !referer.isEmpty() ? referer : "cartItem");
        }
    }

    // Phương thức gộp để xóa một hoặc nhiều sản phẩm từ CartItemsTrash
    protected void deleteCartItemsTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();
        List<Integer> productIds = new ArrayList<>();

        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(jsonBuilder.toString(), JsonObject.class);
            JsonArray productIdsArray = jsonObject.getAsJsonArray("productIds");
            for (JsonElement element : productIdsArray) {
                productIds.add(element.getAsInt());
            }
        } else {
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                productIds.add(Integer.parseInt(productIdStr));
            }
        }

        if (productIds.isEmpty()) {
            response.sendRedirect("trashCart");
            return;
        }

        cartDAO.deleteMultipleTrashCartItems(userId, productIds);

        if (contentType != null && contentType.contains("application/json")) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendRedirect("trashCart");
        }
    }

    // Phương thức gộp để khôi phục một hoặc nhiều sản phẩm từ CartItemsTrash
    protected void restoreCartItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserId();
        List<Integer> productIds = new ArrayList<>();

        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }

            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(jsonBuilder.toString(), JsonObject.class);
            JsonArray productIdsArray = jsonObject.getAsJsonArray("productIds");
            for (JsonElement element : productIdsArray) {
                productIds.add(element.getAsInt());
            }
        } else {
            String productIdStr = request.getParameter("productId");
            if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                productIds.add(Integer.parseInt(productIdStr));
            }
        }

        if (productIds.isEmpty()) {
            response.sendRedirect("trashCart");
            return;
        }

        cartDAO.restoreMultipleCartItemsTrash(userId, productIds);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);

        if (contentType != null && contentType.contains("application/json")) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendRedirect("trashCart");
        }
    }

    protected void getCartItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        List<CartItem> listCartItem = cartDAO.getCartItems(userId);
        System.out.println("Fetched " + listCartItem.size() + " items for UserID: " + userId);
        if (listCartItem.isEmpty()) {
            System.out.println("No items found in cart for UserID: " + userId);
        } else {
            for (CartItem item : listCartItem) {
                System.out.println("CartItem: ProductID=" + item.getProduct().getProductID()
                        + ", Size=" + item.getSize() + ", Color=" + item.getColor());
            }
        }
        request.setAttribute("listCartItem", listCartItem);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    protected void getCartItemTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        List<CartItem> listCartItemTrash = cartDAO.getCartItemsTrash(userId);
        request.setAttribute("listCartItemTrash", listCartItemTrash);
        request.getRequestDispatcher("trashCartItem.jsp").forward(request, response);
    }

    protected void addCartQuick(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productID"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        response.setContentType("text/plain");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            response.getWriter().write("Please login to add to cart");
            return;
        }

        int userId = user.getUserId();
        cartDAO.addCartItem(userId, productId, 1);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);

        response.setStatus(HttpServletResponse.SC_OK); // 200
        response.getWriter().write("Added to cart successfully");
    }

    protected void addCartQuickFromWishlist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        cartDAO.addCartItem(userId, productId, quantity);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        response.sendRedirect("getWishlist");
    }

    protected void addCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String category = request.getParameter("category");
//        String selectedSize = request.getParameter("selectedSize");
//        String selectedColor = request.getParameter("selectedColor");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
//        cartDAO.addCartItemWithVariant(userId, productId, quantity, selectedSize, selectedColor);
        cartDAO.addCartItem(userId, productId, quantity);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        request.getRequestDispatcher("productDetail?id="+productId+"&category="+category).forward(request, response);
    }

    public void updateCartInSession(HttpServletRequest request, List<CartItem> updatedCart) {
        HttpSession session = request.getSession();
        session.setAttribute("cart", updatedCart);
    }

    protected void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        int productId = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Lấy thông tin sản phẩm để kiểm tra stock
        Product product = productDAO.getProductById(productId);
        if (product == null || quantity > product.getStock()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Trả về lỗi nếu số lượng vượt quá stock
            response.getWriter().write("Số lượng yêu cầu vượt quá tồn kho (" + product.getStock() + ").");
            return;
        }

        // Nếu số lượng hợp lệ, tiến hành cập nhật
        cartDAO.updateQuantityInCart(userId, productId, quantity);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (request.getServletPath().equals("/addCart")) {
            addCart(request, response);
        } else if (request.getServletPath().equals("/cartItem")) {
            getCartItem(request, response);
        } else if (request.getServletPath().equals("/deleteCartItem")) {
            deleteCartItems(request, response);
        } else if (request.getServletPath().equals("/trashCart")) {
            getCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/deleteCartItemTrash")) {
            deleteCartItemsTrash(request, response);
        } else if (request.getServletPath().equals("/restoreCartItem")) {
            restoreCartItems(request, response);
        } else if (request.getServletPath().equals("/addCartQuick")) {
            addCartQuick(request, response);
        } else if (request.getServletPath().equals("/addCartQuickFromWishlist")) {
            addCartQuickFromWishlist(request, response);
        } else if (request.getServletPath().equals("/updateQuantity")) {
            updateQuantity(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
}

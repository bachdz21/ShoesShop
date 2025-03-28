/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ICartDAO;
import dal.IProductDAO;
import dal.imp.CartDAO;
import dal.imp.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.CartItem;
import model.Product;
import model.User;

/**
 *
 * @author nguye
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart", "/addCart", "/addCartQuick", "/cartItem", "/deleteCartItem", "/trashCart",
    "/deleteCartItemTrash", "/restoreCartItem", "/updateQuantity"})
public class CartController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
            deleteCartItem(request, response);
        } else if (request.getServletPath().equals("/trashCart")) {
            getCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/deleteCartItemTrash")) {
            deleteCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/restoreCartItem")) {
            restoreProduct(request, response);
        } else if (request.getServletPath().equals("/addCartQuick")) {
            addCartQuick(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
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
                System.out.println("CartItem: ProductID=" + item.getProduct().getProductID() + 
                                   ", Size=" + item.getSize() + ", Color=" + item.getColor());
            }
        }
        request.setAttribute("listCartItem", listCartItem);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    protected void getCartItemTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
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
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        cartDAO.addCartItem(userId, productId, quantity);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        response.sendRedirect("cart");
    }

    protected void addCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String selectedSize = request.getParameter("selectedSize");
        String selectedColor = request.getParameter("selectedColor");        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        cartDAO.addCartItemWithVariant(userId, productId, quantity, selectedSize, selectedColor);
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        request.getRequestDispatcher("cartItem").forward(request, response);
    }

    protected void deleteCartItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String productIdStr = request.getParameter("productId");

        // Kiểm tra productId có hợp lệ không
        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getHeader("Referer")); // Trả về trang trước
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            int userId = user.getUserId();
            cartDAO.deleteCartItem(userId, productId);

            List<CartItem> updatedCart = cartDAO.getCartItems(userId);
            updateCartInSession(request, updatedCart);

            // Trả về trang trước khi gửi request
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("cartItem"); // Nếu không có referer, về giỏ hàng mặc định
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("cartItem");
        }
    }

    protected void deleteCartItemTrash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        cartDAO.deleteTrashCartItem(userId, productId);
        response.sendRedirect("trashCart"); // Chuyển hướng đến trang giỏ hàng sau khi xóa
    }

    protected void restoreProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        int productId = Integer.parseInt(request.getParameter("productId"));
        cartDAO.restoreCartItemTrash(userId, productId); // Khôi phục sản phẩm từ thùng rác
        List<CartItem> updatedCart = cartDAO.getCartItems(userId);
        updateCartInSession(request, updatedCart);
        response.sendRedirect("trashCart");
    }

    public void updateCartInSession(HttpServletRequest request, List<CartItem> updatedCart) {
        HttpSession session = request.getSession();
        session.setAttribute("cart", updatedCart);
    }

    protected void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        // Thêm sản phẩm vào giỏ hàng
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Gọi phương thức DAO để cập nhật quantity trong CartItems
        cartDAO.updateQuantityInCart(userId, productID, quantity); // userID có thể lấy từ session
        response.setStatus(HttpServletResponse.SC_OK);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/addCart")) {
            addCart(request, response);
        } else if (request.getServletPath().equals("/cartItem")) {
            getCartItem(request, response);
        } else if (request.getServletPath().equals("/deleteCartItem")) {
            deleteCartItem(request, response);
        } else if (request.getServletPath().equals("/trashCart")) {
            getCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/deleteCartItemTrash")) {
            deleteCartItemTrash(request, response);
        } else if (request.getServletPath().equals("/restoreCartItem")) {
            restoreProduct(request, response);
        } else if (request.getServletPath().equals("/addCartQuick")) {
            addCartQuick(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

}

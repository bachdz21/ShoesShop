package controller;

import dal.imp.CartDAO;
import dal.imp.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.CartItem;
import model.Order;
import model.Product;
import model.User;

@WebServlet(name = "Order", urlPatterns = {"/order", "/checkout", "/getOrderItem", "/getCartItemUpdateQuantity",
    "/getOrderByUserID", "/getAllOrders", "/updateStatus", "/getDetailOrders"})
public class OrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/checkout")) {
            checkout(request, response);
        } else if (request.getServletPath().equals("/getOrderItem")) {
            getCartItem(request, response);
        } else if (request.getServletPath().equals("/getCartItemUpdateQuantity")) {
            getCartItemUpdateQuantity(request, response);
        } else if (request.getServletPath().equals("/getOrderByUserID")) {
            getOrderByUserID(request, response);
        } else if (request.getServletPath().equals("/getAllOrders")) {
            getAllOrders(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void checkout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        String fullName = request.getParameter("full-name");
        String email = request.getParameter("email");
        String paymentMethod = request.getParameter("payment");
        String shippingAddress = request.getParameter("address");
        String phoneNumber = request.getParameter("tel");
        String note = request.getParameter("note");
        int orderId = orderDAO.checkout(userId, fullName, email, phoneNumber, shippingAddress, paymentMethod, note);
        String orderCode = orderDAO.getOrderCodeByOrderID(orderId);
        List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
        session.setAttribute("cart", cartItems);
        if (orderId > 0) {
            request.setAttribute("orderCode", orderCode);
            request.getRequestDispatcher("orderSuccess.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Checkout failed.");
        }
    }

    protected void getCartItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        List<CartItem> listCartItem = cartDAO.getCartItems(userId);
        request.setAttribute("listCartItem", listCartItem);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    protected void getCartItemUpdateQuantity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        String[] productID = request.getParameterValues("productID");
        if (productID != null) {
            for (int i = 0; i < productID.length; i++) {
                int quantity = Integer.parseInt(request.getParameter("amount" + productID[i]));
                cartDAO.updateQuantityInCart(userId, Integer.parseInt(productID[i]), quantity);
            }
        }
        List<CartItem> listCartItem = cartDAO.getCartItems(userId);
        session.setAttribute("cart", listCartItem);
        request.setAttribute("listCartItem", listCartItem);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    protected void getOrderByUserID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("allOrderList.jsp").forward(request, response);
    }
    
    protected void getAllOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        List<Order> allOrders = orderDAO.getAllOrders();
        request.setAttribute("orders", allOrders);
        request.getRequestDispatcher("allOrderList.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/checkout")) {
            checkout(request, response);
        } else if (request.getServletPath().equals("/getOrderItem")) {
            getCartItem(request, response);
        } else if (request.getServletPath().equals("/getCartItemUpdateQuantity")) {
            getCartItemUpdateQuantity(request, response);
        } else if (request.getServletPath().equals("/getOrderByUserID")) {
            getOrderByUserID(request, response);
        } else if (request.getServletPath().equals("/getAllOrders")) {
            getAllOrders(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
}

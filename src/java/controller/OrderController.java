package controller;

import com.google.gson.Gson;
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
    "/getOrderByUserID", "/getAllOrders", "/updateStatus", "/getDetailOrders", "/getProductsByOrderID"})
public class OrderController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();
    private static final long serialVersionUID = 1L;

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
        } else if (request.getServletPath().equals("/getProductsByOrderID")) {
            getProductsByOrderID(request, response);
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

    protected void getProductsByOrderID(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra quyền truy cập người dùng
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN); // HTTP 403 - Forbidden
            response.getWriter().write("{\"error\":\"Quyền truy cập không hợp lệ\"}");
            return;
        }

        try {
            // Lấy orderID từ request
            String orderIDStr = request.getParameter("orderID");
            if (orderIDStr == null || orderIDStr.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // HTTP 400 - Bad Request
                response.getWriter().write("{\"error\":\"Mã đơn hàng là bắt buộc\"}");
                return;
            }

            int orderID = Integer.parseInt(orderIDStr);

            // Truy vấn các sản phẩm trong đơn hàng từ DAO (giả sử bạn đã có phương thức getProductsByOrderID)
            List<Product> productInOrder = orderDAO.getProductsByOrderID(orderID);

            if (productInOrder == null || productInOrder.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // HTTP 404 - Not Found
                response.getWriter().write("{\"error\":\"Không tìm thấy sản phẩm cho Mã đơn hàng này\"}");
                return;
            }

            // Giả sử bạn muốn trả về tất cả các sản phẩm trong đơn hàng dưới dạng danh sách
            Gson gson = new Gson();
            String json = gson.toJson(productInOrder); // Chuyển danh sách sản phẩm thành JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // HTTP 400 - Bad Request
            response.getWriter().write("{\"error\":\"Định dạng Mã đơn hàng không hợp lệ\"}");
        } catch (Exception e) {
            // Log lỗi và trả về lỗi server
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // HTTP 500 - Internal Server Error
            response.getWriter().write("{\"error\":\"Đã xảy ra lỗi khi xử lý yêu cầu của bạn\"}");
        }
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
        } else if (request.getServletPath().equals("/getProductsByOrderID")) {
            getProductsByOrderID(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ICartDAO;
import dal.IProductDAO;
import dal.IUserDAO;
import dal.imp.CartDAO;
import dal.imp.EmailService;
import dal.imp.OrderDAO;
import dal.imp.ProductDAO;
import dal.imp.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;
import model.CartItem;
import model.User;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.File;
import java.util.ArrayList;
import java.util.Properties;
import model.Order;
import utils.Encryption;

/**
 *
 * @author nguye
 */
@WebServlet(name = "UserController", urlPatterns = {"/user", "/login", "/register", "/logout", "/delete", "/forgotPassword",
    "/resetPassword", "/userProfile", "/updateProfile", "/changePassword", "/confirmLink"})

public class UserController extends HttpServlet {

    ICartDAO cartDAO = new CartDAO();
    IProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();
    Encryption e = new Encryption();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/login")) {
            getLogin(request, response);
        } else if (request.getServletPath().equals("/register")) {
            getRegister(request, response);
        } else if (request.getServletPath().equals("/logout")) {
            getLogout(request, response);
        } else if (request.getServletPath().equals("/user")) {
            getUsers(request, response);
        } else if (request.getServletPath().equals("/delete")) {
            getDelete(request, response);
        } else if (request.getServletPath().equals("/forgotPassword")) {
            forgotPassword(request, response);
        } else if (request.getServletPath().equals("/resetPassword")) {
            resetPassword(request, response);
        } else if (request.getServletPath().equals("/userProfile")) {
            userProfile(request, response);
        } else if (request.getServletPath().equals("/updateProfile")) {
            updateProfile(request, response);
        } else if (request.getServletPath().equals("/changePassword")) {
            changePassword(request, response);
        } else if (request.getServletPath().equals("/confirmLink")) {
            confirmLink(request, response);
        } else {
            request.getRequestDispatcher("/ProjectPRJ301/home").forward(request, response);
        }

    }

    protected void getUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IUserDAO u = new UserDAO();
        List<User> list = u.getAllUsers();
        request.setAttribute("listUsers", list);
        request.getRequestDispatcher("index.jsp").forward(request, response);
//        HttpSession s1 = request.getSession();
//        s1.setAttribute("listUsersSendedBySession", list);
//        response.sendRedirect("index.jsp");
    }

    protected void getLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IUserDAO userDAO = new UserDAO();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        User user = userDAO.login(username, e.getMd5(password));
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            // Lấy thông tin giỏ hàng của người dùng từ database và lưu vào session
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
            session.setAttribute("cart", cartItems);
            // Nếu người dùng chọn "Ghi nhớ đăng nhập"
            if ("on".equals(remember)) {
                Cookie usernameCookie = new Cookie("username", username);
                Cookie passwordCookie = new Cookie("password", password); // Lưu ý: Không nên lưu mật khẩu thô
                usernameCookie.setMaxAge(60 * 60 * 24 * 7); // Lưu trong 7 ngày
                passwordCookie.setMaxAge(60 * 60 * 24 * 7);
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            } else {
                // Xóa cookie nếu không chọn ghi nhớ
                Cookie usernameCookie = new Cookie("username", null);
                Cookie passwordCookie = new Cookie("password", null);
                usernameCookie.setMaxAge(0);
                passwordCookie.setMaxAge(0);
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
            }

            request.getRequestDispatcher("/home").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void getLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy phiên hiện tại và xóa thông tin người dùng
        HttpSession session = request.getSession();
        session.invalidate(); // Xóa phiên
        // Chuyển hướng về trang đăng nhập
        response.sendRedirect("/ProjectPRJ301/home");
    }

    protected void getRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
        IUserDAO userDAO = new UserDAO();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()
                || fullname == null || fullname.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phonenumber == null || phonenumber.trim().isEmpty()) {
            request.setAttribute("error", "Không Được Để Trống");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!password.equalsIgnoreCase(confirmPassword)) {
            request.setAttribute("error", "Nhập Lại Mật Khẩu Không Đúng");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu username hoặc email đã tồn tại
        User existingUser = userDAO.getUserByUsername(username);
        if (existingUser != null) {
            request.setAttribute("error", "Username already exists. Please choose another.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng User mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(e.getMd5(password));  // Có thể mã hóa mật khẩu trước khi lưu
        newUser.setFullName(fullname);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phonenumber);
        // Lưu người dùng mới vào database
        userDAO.addUser(newUser);

        // Lưu thông tin người dùng vào session và chuyển hướng đến trang chủ
        HttpSession session = request.getSession();
        session.setAttribute("user", newUser);
        response.sendRedirect("home");

    }

    protected void getDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        try {
            UserDAO d = new UserDAO();
//            d.deleteUserByUsername(username);
            // Chuyển hướng đến danh sách người dùng sau khi xóa
            response.sendRedirect("user");
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
    }

    protected void forgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        IUserDAO u = new UserDAO();
        // Lấy email người dùng từ form quên mật khẩu
        String userEmail = request.getParameter("email");

        // Kiểm tra email trong database (giả sử bạn đã có hàm kiểm tra email trong UserDAO)
        boolean emailExists = u.checkEmailExists(userEmail);
        if (!emailExists) {
            // Nếu email không tồn tại, chuyển hướng hoặc thông báo lỗi
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Tạo mã xác nhận hoặc link đặt lại mật khẩu
        String resetCode = generateResetCode();
        String resetLink = "http://localhost:8080/ProjectPRJ301/confirmLink?code=" + resetCode;

        // Lưu mã xác nhận vào database (cần implement)
        u.saveResetCode(userEmail, resetCode);

        // Gửi email cho người dùng
        String subject = "Yêu cầu đặt lại mật khẩu";
        String messageText = "Để đặt lại mật khẩu của bạn, vui lòng nhấp vào liên kết sau: " + resetLink;
        EmailService.sendEmail(userEmail, subject, messageText);

        // Thông báo người dùng rằng email đã được gửi
        request.setAttribute("message", "Mã đặt lại mật khẩu đã được gửi tới email của bạn.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Hàm để tạo mã xác nhận ngẫu nhiên
    private String generateResetCode() {
        // Tạo mã xác nhận (có thể dùng UUID hoặc ngẫu nhiên số)
        return java.util.UUID.randomUUID().toString();
    }

    protected void confirmLink(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resetCode = request.getParameter("code");
        request.setAttribute("code", resetCode);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    protected void resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resetCode = request.getParameter("code");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mã reset có hợp lệ không
        IUserDAO u = new UserDAO();

        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp. Vui lòng thử lại.");
            request.setAttribute("code", resetCode);
            request.getRequestDispatcher("confirmLink").forward(request, response);
        }

        // Cập nhật mật khẩu
        u.updatePassword(resetCode, e.getMd5(newPassword));

        // Thông báo thành công và chuyển hướng đến trang đăng nhập
        request.setAttribute("message", "Mật khẩu đã được đặt lại thành công.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void userProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        IUserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        User u = userDAO.getUserById(userId); // Gọi hàm để lấy thông tin người dùng

        //Xử lý địa chỉ
        if (u.getAddress() != null) {
            String[] addressElements = u.getAddress().split(", ");
            String addressDetail = addressElements[0];
            String ward = addressElements[1];
            String district = addressElements[2];
            String city = addressElements[3];
            List<String> address = new ArrayList<>();
            address.add(addressElements[0]);
            address.add(addressElements[1]);
            address.add(addressElements[2]);
            address.add(addressElements[3]);
            request.setAttribute("address", address);
        }

        //Thông tin đơn hàng
        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());

        //Gửi dữ liệu
        request.setAttribute("user", u);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response); // Chuyển hướng đến trang JSP
    }

    protected void updateAvatar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request

    }

    protected void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        IUserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        //Xử lý address

        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String addressDetail = request.getParameter("addressDetail");
        // Kết hợp các trường địa chỉ lại thành một chuỗi
        String address = addressDetail + ", " + ward + ", " + district + ", " + city;

        User u = new User(); // Gọi hàm để lấy thông tin người dùng
        u.setUserId(userId);
        u.setFullName(fullName);
        u.setEmail(email);
        u.setPhoneNumber(phoneNumber);
        u.setAddress(address);
        userDAO.updateUser(u);
        request.getRequestDispatcher("userProfile").forward(request, response); // Chuyển hướng đến trang JSP
    }

    protected void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        IUserDAO userDAO = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmNewPassword");
        String message = "";

        // Kiểm tra mật khẩu hiện tại
        if (!user.getPassword().equals(e.getMd5(password))) {
            message = "Mật khẩu hiện tại không chính xác.";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "Mật khẩu mới và xác nhận không khớp.";

        } else if (newPassword.equals(password)) {
            message = "Mật khẩu mới và mật khẩu cũ phải khác nhau.";
        } else {
            userDAO.changePassword(userId, e.getMd5(newPassword)); // Cập nhật mật khẩu mới
            message = "Đổi mật khẩu thành công.";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("userProfile").forward(request, response); // Chuyển về trang JSP với thông báo
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/login")) {
            getLogin(request, response);
        } else if (request.getServletPath().equals("/register")) {
            getRegister(request, response);
        } else if (request.getServletPath().equals("/logout")) {
            getLogout(request, response);
        } else if (request.getServletPath().equals("/user")) {
            getUsers(request, response);
        } else if (request.getServletPath().equals("/delete")) {
            getDelete(request, response);
        } else if (request.getServletPath().equals("/forgotPassword")) {
            forgotPassword(request, response);
        } else if (request.getServletPath().equals("/resetPassword")) {
            resetPassword(request, response);
        } else if (request.getServletPath().equals("/userProfile")) {
            userProfile(request, response);
        } else if (request.getServletPath().equals("/updateProfile")) {
            updateProfile(request, response);
        } else if (request.getServletPath().equals("/changePassword")) {
            changePassword(request, response);
        } else if (request.getServletPath().equals("/confirmLink")) {
            confirmLink(request, response);
        } else {
            request.getRequestDispatcher("/ProjectPRJ301/home").forward(request, response);
        }
    }

}

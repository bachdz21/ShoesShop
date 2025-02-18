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
@WebServlet(name = "UserController", urlPatterns = {"/user", "/login", "/register", "/logout"})

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
        response.sendRedirect("./home");
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
        } else {
            request.getRequestDispatcher("/ProjectPRJ301/home").forward(request, response);
        }
    }

}

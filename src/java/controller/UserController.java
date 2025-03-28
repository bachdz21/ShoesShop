/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ICartDAO;
import dal.IUserDAO;
import dal.IWishlistDAO;
import dal.imp.CartDAO;
import dal.imp.EmailService;
import dal.imp.OrderDAO;
import dal.imp.ReviewDAO;
import dal.imp.UserDAO;
import dal.imp.WishlistDAO;
import jakarta.mail.internet.MimeUtility;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import model.CartItem;
import model.User;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.UUID;
import model.Order;
import model.OrderContact;
import model.OrderDetail;
import model.WishlistItem;
//import org.json.JSONObject;
import utils.Encryption;

/**
 *
 * @author nguye
 */
@WebServlet(name = "UserController", urlPatterns = {"/login", "/register", "/checkExisting",
    "/forgotPassword", "/resetPassword", "/confirmLink", "/logout",
    "/userProfile", "/updateProfile", "/changePassword", "/updateAvatar", "/orderDetail",
    "/filterBanUser", "/emailReminder", "/banUser", "/updateRoleUser", "/filterUser", "/restoreUser"})
@MultipartConfig

public class UserController extends HttpServlet {

    IUserDAO userDAO = new UserDAO();
    ICartDAO cartDAO = new CartDAO();
    IWishlistDAO wishlistDAO = new WishlistDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    Encryption e = new Encryption();
    // Cập nhật ảnh đại diện
    private static final String IMAGE_UPLOAD_DIR = "D:\\Materials\\Kì 5 - Spring25\\SWP291\\ShoesShop\\web\\img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                getLogin(request, response);//get
                break;
            case "/register":
                getRegister(request, response);//get 
                break;
//            case "/checkExisting":
//                checkExisting(request, response);//get 
//                break;
            case "/logout":
                getLogout(request, response);//get
                break;
            case "/confirmLink":
                confirmLink(request, response);//get của resetPassword lấy giá trị của reset code
                break;
            case "/userProfile":
                userProfile(request, response);//get
                break;
            case "/orderDetail":
                orderDetail(request, response);//get
                break;
            case "/filterUser":
                filterUser(request, response);//get
                break;
            case "/emailReminder":
                emailReminder(request, response);//get
                break;
            case "/banUser":
                banUser(request, response);//get
                break;
            case "/updateRoleUser":
                updateRoleUser(request, response);//get
                break;
            case "/restoreUser":
                restoreUser(request, response);//get
                break;
            case "/filterBanUser":
                filterBanUser(request, response);//get
                break;

            default:
                request.getRequestDispatcher("/home").forward(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                postLogin(request, response);//post
                break;
            case "/register":
                postRegister(request, response);//post(cần thêm get để check xem trùng email hay tên chưa, xác thực email)
                break;

            case "/forgotPassword":
                forgotPassword(request, response);//post(cần thêm get check xem email có tồn tại không)
                break;

            case "/resetPassword":
                resetPassword(request, response);//post lấy giá trị code, mk, nlmk
                break;

            case "/updateProfile":
                updateProfile(request, response);
                break;
            case "/changePassword":
                changePassword(request, response);
                break;
            case "/updateAvatar":
                updateAvatar(request, response);
                break;

            default:
                request.getRequestDispatcher("/home").forward(request, response);
                break;
        }

    }

    protected void getLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tất cả các cookies từ yêu cầu
        Cookie[] cookies = request.getCookies();

        String username = "";
        String password = "";

        // Kiểm tra xem có cookie username và password không
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    username = cookie.getValue(); // Gán giá trị cookie username vào biến
                }
                if ("password".equals(cookie.getName())) {
                    password = cookie.getValue(); // Gán giá trị cookie password vào biến
                }
            }
        }

        // Gắn giá trị của username và password vào request để sử dụng trong JSP
        request.setAttribute("username", username);
        request.setAttribute("password", password);

        // Tiến hành forward request đến trang login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    protected void postLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        User user = userDAO.login(username, e.getMd5(password));
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("role", user.getRole());
            // Lấy thông tin giỏ hàng của người dùng từ database và lưu vào session
            List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
            session.setAttribute("cart", cartItems);
            // Lấy thông tin danh sách yêu thích của người dùng từ database và lưu vào session
            List<WishlistItem> wishlistItems = wishlistDAO.getWishlistItems(user.getUserId());
            session.setAttribute("wishlist", wishlistItems);
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
            response.sendRedirect("home");

        } else {
            request.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
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
        // Lấy danh sách email, username và phonenumber từ cơ sở dữ liệu
        List<String> existingEmails = userDAO.getAllEmails();
        List<String> existingUsernames = userDAO.getAllUsernames();
        List<String> existingPhoneNumbers = userDAO.getAllPhoneNumbers();

        // Đưa các danh sách vào request để sử dụng trong trang JSP
        request.setAttribute("existingEmails", existingEmails);
        request.setAttribute("existingUsernames", existingUsernames);
        request.setAttribute("existingPhoneNumbers", existingPhoneNumbers);

        // Tiến hành forward request đến trang register.jsp
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

//    protected void checkExisting(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String email = request.getParameter("email");
//
//        // Kiểm tra trong cơ sở dữ liệu
//        boolean isUsernameExists = userDAO.checkUsernameExists(username);
//        boolean isEmailExists = userDAO.checkEmailExists(email);
//
//        // Trả kết quả dưới dạng JSON
//        JSONObject result = new JSONObject();
//        result.put("isUsernameExists", isUsernameExists);
//        result.put("isEmailExists", isEmailExists);
//
//        response.setContentType("application/json");
//        response.getWriter().write(result.toString());
//    }
    protected void postRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tạo đối tượng DAO để thao tác với cơ sở dữ liệu
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");

        // Kiểm tra nếu username đã tồn tại
        User existingUserByUsername = userDAO.getUserByUsername(username);
        if (existingUserByUsername != null) {
            request.setAttribute("error", "Username already exists. Please choose another.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu email đã tồn tại
        boolean emailExists = userDAO.checkEmailExists(email);
        if (emailExists) {
            request.setAttribute("error", "Email already exists. Please choose another.");
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

        request.setAttribute("message", "Đăng ký thành công");
        request.getRequestDispatcher("login.jsp").forward(request, response);

    }

    protected void forgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy email người dùng từ form quên mật khẩu
        String userEmail = request.getParameter("email");

        // Kiểm tra email trong database (giả sử bạn đã có hàm kiểm tra email trong UserDAO)
        boolean emailExists = userDAO.checkEmailExists(userEmail);
        if (!emailExists) {
            // Nếu email không tồn tại, chuyển hướng hoặc thông báo lỗi
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Tạo mã xác nhận hoặc link đặt lại mật khẩu
        String resetCode = generateResetCode();
        String resetLink = "http://localhost:8080/ShoesStoreWed/confirmLink?code=" + resetCode;

        // Lưu mã xác nhận vào database (cần implement)
        userDAO.saveResetCode(userEmail, resetCode);

        // Gửi email cho người dùng
        String subject = "Yêu cầu đặt lại mật khẩu";
        String messageText = "Để đặt lại mật khẩu của bạn, vui lòng nhấp vào liên kết sau: " + resetLink;
        EmailService.sendEmail(userEmail, subject, messageText);

        // Thông báo người dùng rằng email đã được gửi
        request.setAttribute("message", "Mã đặt lại mật khẩu đã gửi qua email.");
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
        // Kiểm tra mật khẩu mới và xác nhận
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu không khớp. Vui lòng thử lại.");
            request.setAttribute("code", resetCode);
            request.getRequestDispatcher("confirmLink").forward(request, response);
        }

        // Cập nhật mật khẩu
        userDAO.updatePassword(resetCode, e.getMd5(newPassword));

        // Thông báo thành công và chuyển hướng đến trang đăng nhập
        request.setAttribute("message", "Mật khẩu đã được đặt lại thành công.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    //Hiển thị trang hồ sơ người dùng
    protected void userProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        int userId = user.getUserId();
        User u = userDAO.getUserById(userId);

        // Xử lý địa chỉ
        if (u.getAddress() != null && !u.getAddress().isEmpty()) {
            String[] addressElements = u.getAddress().split(", ");
            if (addressElements.length == 4) {
                List<String> address = new ArrayList<>();
                address.add(addressElements[0]); // addressDetail
                address.add(addressElements[1]); // ward
                address.add(addressElements[2]); // district
                address.add(addressElements[3]); // city
                request.setAttribute("address", address);
            }
        } else {
            List<String> defaultAddress = new ArrayList<>();
            defaultAddress.add("");
            defaultAddress.add("");
            defaultAddress.add("");
            defaultAddress.add("");
            request.setAttribute("address", defaultAddress);
        }

        // Lấy thông báo từ session và gán vào request attribute
        String messageChangePassword = (String) session.getAttribute("messageChangePassword");
        if (messageChangePassword != null) {
            request.setAttribute("message", messageChangePassword);
            session.removeAttribute("messageChangePassword"); // Xóa sau khi sử dụng
        }

        // Thông tin đơn hàng
        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());

        // Gửi dữ liệu
        request.setAttribute("user", u);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }

    protected void updateAvatar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUserId();

        jakarta.servlet.http.Part filePart = request.getPart("profileImageURL"); // Lấy tệp hình ảnh
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + ".jpg";
            File imageFile = new File(IMAGE_UPLOAD_DIR, fileName);
            filePart.write(imageFile.getAbsolutePath());
            imageUrl = "./img/" + fileName;
        }
        User u = new User(); // Gọi hàm để lấy thông tin người dùng
        u.setUserId(userId);
        u.setProfileImageURL(imageUrl);
        userDAO.updateUser(u);

        // Sử dụng sendRedirect để chuyển hướng đến trang userProfile
        response.sendRedirect("userProfile"); // Chuyển hướng tới trang userProfile

    }

    //Chức năng cập nhật hồ sơ
    protected void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login");
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
        String message = "Cập nhật hồ sơ thành công!";
        session.setAttribute("messageUpdateProfile", message);
        // Sử dụng sendRedirect để chuyển hướng đến trang userProfile
        response.sendRedirect("userProfile"); // Chuyển hướng tới trang userProfile
    }

    protected void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login");
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
        } else {
            userDAO.changePassword(userId, e.getMd5(newPassword)); // Cập nhật mật khẩu mới
            message = "Đổi mật khẩu thành công.";
        }

//        String message = "Thay đổi mật khẩu thành công!";
        System.out.println(message);
        session.setAttribute("messageChangePassword", message);
        // Sử dụng sendRedirect để chuyển hướng đến trang userProfile
        response.sendRedirect("userProfile"); // Chuyển hướng tới trang userProfile
    }

    protected void orderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderContact oC = userDAO.getOrderContactsByOrderID(orderId);

        Order o = orderDAO.getOrdersByOrderId(orderId);

        List<OrderDetail> orderDetails = orderDAO.getOrderDetailByOderId(orderId);
        ReviewDAO reviewDAO = new ReviewDAO();
        request.setAttribute("reviewDAO", reviewDAO);
        request.setAttribute("orderContact", oC);
        request.setAttribute("order", o);// tính tổng tiền, phương thức thanh toán,trạng thái
        request.setAttribute("orderDetails", orderDetails);
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("viewDetailOrderHistory.jsp").forward(request, response);
    }

    protected void filterUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || !u.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        // Lấy thông tin phân trang cho khách hàng và nhân viên
        String pageStr1 = request.getParameter("pageStr1"); // Phân trang cho khách hàng
        String pageStr2 = request.getParameter("pageStr2"); // Phân trang cho nhân viên

        // Nếu không có tham số phân trang, mặc định là trang 1
        int pageCustomer = (pageStr1 != null && !pageStr1.isEmpty()) ? Integer.parseInt(pageStr1) : 1;
        int pageEmployee = (pageStr2 != null && !pageStr2.isEmpty()) ? Integer.parseInt(pageStr2) : 1;
        int pageSize = 4; // Số người dùng trên mỗi trang

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Lọc người dùng theo các thông tin được nhập từ form
        List<User> filteredUsers = userDAO.filterUsers(username, fullName, email, phone, registrationDate);

        // Tạo danh sách khách hàng và nhân viên từ kết quả lọc
        List<User> customers = new ArrayList<>();
        List<User> employees = new ArrayList<>();

        for (User user : filteredUsers) {
            int deliveredCount = 0;
            int cancelledCount = 0;

            for (Order order : user.getOrders()) {
                if ("Delivered".equals(order.getOrderStatus())) {
                    deliveredCount++;
                } else if ("Cancelled".equals(order.getOrderStatus())) {
                    cancelledCount++;
                }
            }

            user.setDeliveredCount(deliveredCount);
            user.setCancelledCount(cancelledCount);

            if ("Customer".equals(user.getRole())) {
                customers.add(user);
            } else {
                employees.add(user);
            }
        }
        customers.sort(Comparator.comparingInt(User::getCancelledCount).reversed());
        employees.sort(Comparator.comparingInt(User::getCancelledCount).reversed());

        // Phân trang cho khách hàng
        int totalCustomers = customers.size();
        int totalPagesCustomer = (int) Math.ceil((double) totalCustomers / pageSize);
        int startIndexCustomer = (pageCustomer - 1) * pageSize;
        int endIndexCustomer = Math.min(startIndexCustomer + pageSize, totalCustomers);

        if (startIndexCustomer < totalCustomers) {
            List<User> paginatedCustomers = customers.subList(startIndexCustomer, endIndexCustomer);
            request.setAttribute("customers", paginatedCustomers);
        } else {
            request.setAttribute("customers", new ArrayList<>()); // Nếu không có dữ liệu, gán danh sách rỗng
        }

        // Phân trang cho nhân viên
        int totalEmployees = employees.size();
        int totalPagesEmployee = (int) Math.ceil((double) totalEmployees / pageSize);
        int startIndexEmployee = (pageEmployee - 1) * pageSize;
        int endIndexEmployee = Math.min(startIndexEmployee + pageSize, totalEmployees);

        if (startIndexEmployee < totalEmployees) {
            List<User> paginatedEmployees = employees.subList(startIndexEmployee, endIndexEmployee);
            request.setAttribute("employees", paginatedEmployees);
        } else {
            request.setAttribute("employees", new ArrayList<>()); // Nếu không có dữ liệu, gán danh sách rỗng
        }

        request.setAttribute("currentPageCustomer", pageCustomer);
        request.setAttribute("currentPageEmployee", pageEmployee);
        request.setAttribute("totalPagesCustomer", totalPagesCustomer);
        request.setAttribute("totalPagesEmployee", totalPagesEmployee);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalEmployees", totalEmployees);
        request.getRequestDispatcher("accountList.jsp").forward(request, response);
    }

    protected void banUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin userId từ tham số request
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || !u.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId")); // Lấy userId từ URL
        userDAO.isLocked(userId); // Gọi phương thức isLocked để khóa tài khoản

        // Lấy thông tin các tham số tìm kiếm và đảm bảo rằng nếu chúng là null thì sẽ mặc định là ""
        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Nếu các tham số là null, gán giá trị mặc định là rỗng ""
        pageStr1 = (pageStr1 == null) ? "" : pageStr1;
        pageStr2 = (pageStr2 == null) ? "" : pageStr2;
        username = (username == null) ? "" : username;
        fullName = (fullName == null) ? "" : fullName;
        email = (email == null) ? "" : email;
        phone = (phone == null) ? "" : phone;
        registrationDate = (registrationDate == null) ? "" : registrationDate;

        String message = "Khóa tài khoản thành công!";
        session.setAttribute("message", message);

        // Chuyển hướng về trang filterUser và giữ lại các tham số tìm kiếm trong URL
        response.sendRedirect("filterUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName=" + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);
    }

    protected void updateRoleUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin userId từ tham số request
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || !u.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        User u11 = userDAO.getUserById(Integer.parseInt(request.getParameter("userId")));

        User u1 = new User(); // Gọi hàm để lấy thông tin người dùng
        u1.setUserId(Integer.parseInt(request.getParameter("userId")));

        // Nếu hiện tại là Admin thì hủy quyền về Customer
        if ("Admin".equals(u11.getRole())) {
            u1.setRole("Customer");
        } else {
            u1.setRole("Admin");
        }
        userDAO.updateUser(u1);

        // Lấy thông tin các tham số tìm kiếm và đảm bảo rằng nếu chúng là null thì sẽ mặc định là ""
        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Nếu các tham số là null, gán giá trị mặc định là rỗng ""
        pageStr1 = (pageStr1 == null) ? "" : pageStr1;
        pageStr2 = (pageStr2 == null) ? "" : pageStr2;
        username = (username == null) ? "" : username;
        fullName = (fullName == null) ? "" : fullName;
        email = (email == null) ? "" : email;
        phone = (phone == null) ? "" : phone;
        registrationDate = (registrationDate == null) ? "" : registrationDate;

        String message = "Cấp quyền khoản thành công!";
        session.setAttribute("message", message);

        // Chuyển hướng về trang filterUser và giữ lại các tham số tìm kiếm trong URL
        response.sendRedirect("filterUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName=" + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);
    }

    protected void emailReminder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u1 = (User) session.getAttribute("user");

        if (u1 == null || !u1.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId")); // Lấy userId từ URL
        User u = userDAO.getUserById(userId); // Gọi hàm để lấy thông tin người dùng

        // Gửi email cho người dùng
        String subject = "[Lời ngỏ ý] Quan trọng:Nhắc nhở về hành vi đặt hàng không hợp lệ";
        String encodedSubject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String messageText = "<html><body>"
                + "<p><b>Kính gửi " + u.getFullName() + ",</b></p>"
                + "<p>Chúng tôi rất tiếc phải thông báo rằng chúng tôi đã phát hiện tài khoản của bạn có hành vi đặt hàng và không hoàn tất nhiều lần trên hệ thống của cửa hàng <i>Hola Shoes Shop</i>. Điều này không chỉ gây khó khăn cho công việc kinh doanh của chúng tôi mà còn ảnh hưởng đến khả năng phục vụ các khách hàng khác.</p>"
                + "<p>Chúng tôi hiểu rằng có thể có lý do khách quan khiến bạn không thể hoàn tất đơn hàng, tuy nhiên, chúng tôi mong muốn bạn có thể cân nhắc và tránh tái diễn hành vi này trong tương lai. Nếu tình trạng này tiếp tục xảy ra, chúng tôi sẽ buộc phải áp dụng các biện pháp như tạm khóa tài khoản hoặc từ chối nhận đơn hàng từ tài khoản của bạn.</p>"
                + "<p>Chúng tôi hy vọng sẽ tiếp tục phục vụ bạn trong các lần mua sắm sắp tới với các trải nghiệm tốt nhất.</p>"
                + "<p>Cảm ơn bạn đã hợp tác và hiểu cho tình huống này.</p>"
                + "<p>Trân trọng,</p>"
                + "<p><i>Hola Shoes Shop</i></p>"
                + "<p>26 Cụm 1, Thôn 3, Thạch Thất, Hà Nội</p>"
                + "<p>T: 0812843609 </p>"
                + "<p>E: nguyenphuong9824@gmail.com</p>"
                + "<p>F: https://www.facebook.com/HolaShoesShop</p>"
                + "<p>W: http://localhost:8080/ShoesStoreWed</p>"
                + "</body></html>";

        EmailService.sendEmail(u.getEmail(), encodedSubject, messageText);

        // Hiển thị thông báo thành công
//        String message = "Khôi phục tài khoản thành công.";
//        session.setAttribute("message", message);
        // Chuyển hướng về trang danh sách người dùng bị khóa
        // Lấy thông tin các tham số tìm kiếm và đảm bảo rằng nếu chúng là null thì sẽ mặc định là ""
        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Nếu các tham số là null, gán giá trị mặc định là rỗng ""
        pageStr1 = (pageStr1 == null) ? "" : pageStr1;
        pageStr2 = (pageStr2 == null) ? "" : pageStr2;
        username = (username == null) ? "" : username;
        fullName = (fullName == null) ? "" : fullName;
        email = (email == null) ? "" : email;
        System.out.println(email);
        phone = (phone == null) ? "" : phone;
        registrationDate = (registrationDate == null) ? "" : registrationDate;

        String message = "Gửi mail thành công!";
        session.setAttribute("message", message);

        // Chuyển hướng về trang filterUser và giữ lại các tham số tìm kiếm trong URL
        response.sendRedirect("filterUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName=" + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);

    }

    protected void restoreUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin userId từ tham số request
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || !u.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId")); // Lấy userId từ URL

        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Nếu các tham số là null, gán giá trị mặc định là rỗng ""
        pageStr1 = (pageStr1 == null) ? "" : pageStr1;
        pageStr2 = (pageStr2 == null) ? "" : pageStr2;
        username = (username == null) ? "" : username;
        fullName = (fullName == null) ? "" : fullName;
        email = (email == null) ? "" : email;
        phone = (phone == null) ? "" : phone;
        registrationDate = (registrationDate == null) ? "" : registrationDate;
        userDAO.isUnlocked(userId);
        String message = "Khôi phục tài khoản thành công!";
        session.setAttribute("message", message);

        // Chuyển hướng về trang filterUser và giữ lại các tham số tìm kiếm trong URL
        response.sendRedirect("filterBanUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName=" + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);

    }

    protected void filterBanUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || !u.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        // Lấy thông tin phân trang cho khách hàng và nhân viên
        String pageStr1 = request.getParameter("pageStr1"); // Phân trang cho khách hàng
        String pageStr2 = request.getParameter("pageStr2"); // Phân trang cho nhân viên

        // Nếu không có tham số phân trang, mặc định là trang 1
        int pageCustomer = (pageStr1 != null && !pageStr1.isEmpty()) ? Integer.parseInt(pageStr1) : 1;
        int pageEmployee = (pageStr2 != null && !pageStr2.isEmpty()) ? Integer.parseInt(pageStr2) : 1;
        int pageSize = 4; // Số người dùng trên mỗi trang

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String registrationDate = request.getParameter("registrationDate");

        // Lọc người dùng theo các thông tin được nhập từ form
        List<User> filteredUsers = userDAO.filterBanUsers(username, fullName, email, phone, registrationDate);

        // Tạo danh sách khách hàng và nhân viên từ kết quả lọc
        List<User> customers = new ArrayList<>();
        List<User> employees = new ArrayList<>();

        for (User user : filteredUsers) {
            int deliveredCount = 0;
            int cancelledCount = 0;

            for (Order order : user.getOrders()) {
                if ("Delivered".equals(order.getOrderStatus())) {
                    deliveredCount++;
                } else if ("Cancelled".equals(order.getOrderStatus())) {
                    cancelledCount++;
                }
            }

            user.setDeliveredCount(deliveredCount);
            user.setCancelledCount(cancelledCount);

            if ("Customer".equals(user.getRole())) {
                customers.add(user);
            } else {
                employees.add(user);
            }
        }
        customers.sort(Comparator.comparingInt(User::getCancelledCount).reversed());
        employees.sort(Comparator.comparingInt(User::getCancelledCount).reversed());

        // Phân trang cho khách hàng
        int totalCustomers = customers.size();
        int totalPagesCustomer = (int) Math.ceil((double) totalCustomers / pageSize);
        int startIndexCustomer = (pageCustomer - 1) * pageSize;
        int endIndexCustomer = Math.min(startIndexCustomer + pageSize, totalCustomers);

        if (startIndexCustomer < totalCustomers) {
            List<User> paginatedCustomers = customers.subList(startIndexCustomer, endIndexCustomer);
            request.setAttribute("customers", paginatedCustomers);
        } else {
            request.setAttribute("customers", new ArrayList<>()); // Nếu không có dữ liệu, gán danh sách rỗng
        }

        // Phân trang cho nhân viên
        int totalEmployees = employees.size();
        int totalPagesEmployee = (int) Math.ceil((double) totalEmployees / pageSize);
        int startIndexEmployee = (pageEmployee - 1) * pageSize;
        int endIndexEmployee = Math.min(startIndexEmployee + pageSize, totalEmployees);

        if (startIndexEmployee < totalEmployees) {
            List<User> paginatedEmployees = employees.subList(startIndexEmployee, endIndexEmployee);
            request.setAttribute("employees", paginatedEmployees);
        } else {
            request.setAttribute("employees", new ArrayList<>()); // Nếu không có dữ liệu, gán danh sách rỗng
        }

        request.setAttribute("currentPageCustomer", pageCustomer);
        request.setAttribute("currentPageEmployee", pageEmployee);
        request.setAttribute("totalPagesCustomer", totalPagesCustomer);
        request.setAttribute("totalPagesEmployee", totalPagesEmployee);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalEmployees", totalEmployees);
        request.getRequestDispatcher("accountIsLockedList.jsp").forward(request, response);
    }

    public static void main(String[] args) {
        String username = "1";
        String fullName = null;
        String email = null;
        String phone = null;
        String registrationDate = null;
        UserDAO userDAO = new UserDAO();

        // Lọc người dùng theo các thông tin được nhập từ form
        List<User> filteredUsers = userDAO.filterUsers(username, fullName, email, phone, registrationDate);

        // Tạo danh sách khách hàng và nhân viên từ kết quả lọc
        List<User> customers = new ArrayList<>();
        List<User> employees = new ArrayList<>();

        for (User user : filteredUsers) {
            int deliveredCount = 0;
            int cancelledCount = 0;

            for (Order order : user.getOrders()) {
                if ("Delivered".equals(order.getOrderStatus())) {
                    deliveredCount++;
                } else if ("Cancelled".equals(order.getOrderStatus())) {
                    cancelledCount++;
                }
            }

            user.setDeliveredCount(deliveredCount);
            user.setCancelledCount(cancelledCount);

            if ("Customer".equals(user.getRole())) {
                System.out.println(user.getUserId());
                customers.add(user);
            } else {
                employees.add(user);
            }
        }
    }

}
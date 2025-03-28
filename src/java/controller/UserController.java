/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ICartDAO;
import dal.IShippingDAO;
import dal.IUserDAO;
import dal.IWishlistDAO;
import dal.imp.CartDAO;
import dal.imp.EmailService;
import dal.imp.OrderDAO;
import dal.imp.ReviewDAO;
import dal.imp.ShippingDAO;
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
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import model.CartItem;
import model.User;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Random;
import java.util.UUID;
import model.CartStat;
import model.Order;
import model.OrderContact;
import model.OrderDetail;
import model.Shipping;
import model.WishlistItem;
//import org.json.JSONObject;
import utils.Encryption;
import model.ReviewStat;
import model.WishlistStat;

/**
 *
 * @author nguye
 */
@WebServlet(name = "UserController", urlPatterns = { "/login", "/register", "/confirmEmail",
        "/forgotPassword", "/resetPassword", "/confirmLink", "/logout",
        "/userProfile", "/updateProfile", "/changePassword", "/updateAvatar",
        "/userOrder", "/orderDetail", "/allUserOrder", "/confirmOrder",
        "/filterBanUser", "/emailReminder", "/banUser", "/registerEmployee",
        "/filterUser", "/restoreUser", "/userDetail",
        "/shippingInformation", "/addShippingInformation",
        "/activeCustomers", "/customerBehavior" })
@MultipartConfig

public class UserController extends HttpServlet {

    IUserDAO userDAO = new UserDAO();
    ICartDAO cartDAO = new CartDAO();
    IWishlistDAO wishlistDAO = new WishlistDAO();
    private final OrderDAO orderDAO = new OrderDAO();
    Encryption e = new Encryption();
    // Cập nhật ảnh đại diện
    private static final String IMAGE_UPLOAD_DIR = "D:\\Materials\\Kì 5 - Spring25\\SWP291\\ShoesShop\\web\\img";
    IShippingDAO shippingDAO = new ShippingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/login":
                getLogin(request, response);// get
                break;
            case "/register":
                getRegister(request, response);// get
                break;

            case "/logout":
                getLogout(request, response);// get
                break;
            case "/confirmLink":
                confirmLink(request, response);// get của resetPassword lấy giá trị của reset code
                break;
            case "/userProfile":
                userProfile(request, response);// get
                break;
            case "/filterUser":
                filterUser(request, response);// get
                break;
            case "/emailReminder":
                emailReminder(request, response);// get
                break;
            case "/banUser":
                banUser(request, response);// get
                break;

            case "/restoreUser":
                restoreUser(request, response);// get
                break;
            case "/filterBanUser":
                filterBanUser(request, response);// get
                break;
            case "/userOrder":
                userOrder(request, response);// get
                break;
            case "/orderDetail":
                orderDetail(request, response);// get confirmOrder
                break;
            case "/allUserOrder":
                allUserOrder(request, response);// get
                break;
            case "/confirmOrder":
                confirmOrder(request, response);// get confirmOrder
                break;
            case "/shippingInformation":
                shippingInformation(request, response);// get confirmOrder
                break;
            case "/userDetail":
                userDetail(request, response);// get confirmOrder
                break;
            case "/activeCustomers":
                getActiveCustomers(request, response);
                break;
            case "/customerBehavior":
                getCustomerBehavior(request, response);
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
                postLogin(request, response);// post
                break;
            case "/register":
                postRegister(request, response);// post(cần thêm get để check xem trùng email hay tên chưa, xác thực
                                                // email)
                break;
            case "/registerEmployee":
                registerEmployee(request, response);// get
                break;
            case "/confirmEmail":
                confirmEmail(request, response);
                break;
            case "/forgotPassword":
                forgotPassword(request, response);// post(cần thêm get check xem email có tồn tại không)
                break;

            case "/resetPassword":
                resetPassword(request, response);// post lấy giá trị code, mk, nlmk
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
            case "/addShippingInformation":
                addShippingInformation(request, response);// get confirmOrder
                break;
            case "/activeCustomers":
                exportActiveCustomers(request, response);
                break;

            default:
                request.getRequestDispatcher("/home").forward(request, response);
                break;
        }

    }

    protected void getLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            response.sendRedirect("home"); // Nếu đã đăng nhập, chuyển hướng về home
            return;
        }

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
            // Lấy thông tin danh sách yêu thích của người dùng từ database và lưu vào
            // session
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            response.sendRedirect("home"); // Nếu đã đăng nhập, chuyển hướng về home
            return;
        }
        // Tiến hành forward request đến trang register.jsp
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void postRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");

        // Gán lại tất cả các giá trị đã nhập
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("confirm_password", confirmPassword);
        request.setAttribute("fullname", fullname);
        request.setAttribute("email", email);
        request.setAttribute("phonenumber", phonenumber);

        // Kiểm tra username tồn tại
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Tên tài khoản đã tồn tại. Vui lòng chọn tên tài khoản khác.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email tồn tại
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại.Vui lòng nhập tài khoản email khác.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo mã xác nhận ngẫu nhiên 6 chữ số
        String verificationCode = generateVerificationCode();

        // Tạo người dùng mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(e.getMd5(password));
        newUser.setFullName(fullname);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phonenumber);
        // userDAO.addUser(newUser);
        // Lưu thông tin tạm thời vào session
        HttpSession session = request.getSession();
        session.setAttribute("tempUser", newUser);
        session.setAttribute("verificationCode", verificationCode);

        // Gửi email với mã xác nhận
        String subject = "Xác nhận đăng ký tài khoản";
        String encodedSubject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String messageText = "Mã xác nhận của bạn là: <strong>" + verificationCode
                + "</strong>. Vui lòng nhập mã này để hoàn tất đăng ký.";
        EmailService.sendEmail(email, encodedSubject, messageText);

        // Chuyển hướng đến trang confirmEmail.jsp
        request.getRequestDispatcher("confirmEmail.jsp").forward(request, response);
    }

    // Hàm tạo mã xác nhận 6 chữ số
    private String generateVerificationCode() {
        Random rand = new Random();
        int code = 100000 + rand.nextInt(900000); // Tạo số ngẫu nhiên từ 100000 đến 999999
        return String.valueOf(code);
    }

    protected void confirmEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String inputCode = request.getParameter("verificationCode");
        String storedCode = (String) session.getAttribute("verificationCode");
        User tempUser = (User) session.getAttribute("tempUser");

        // Gán lại các giá trị để hiển thị lại nếu cần
        request.setAttribute("username", tempUser.getUsername());
        request.setAttribute("password", ""); // Không hiển thị mật khẩu thật
        request.setAttribute("fullname", tempUser.getFullName());
        request.setAttribute("email", tempUser.getEmail());
        request.setAttribute("phonenumber", tempUser.getPhoneNumber());

        if (inputCode.equals(storedCode)) {
            // Tạo tài khoản nếu mã xác nhận đúng
            userDAO.addUser(tempUser);

            // Xóa thông tin tạm khỏi session
            session.removeAttribute("tempUser");
            session.removeAttribute("verificationCode");

            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Mã xác nhận không đúng. Vui lòng thử lại.");
            request.getRequestDispatcher("confirmEmail.jsp").forward(request, response);
        }
    }

    protected void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy email người dùng từ form quên mật khẩu
        String userEmail = request.getParameter("email");

        // Kiểm tra email trong database (giả sử bạn đã có hàm kiểm tra email trong
        // UserDAO)
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
        String subject = "[Hola Shoes Shop] - Yêu cầu đặt lại mật khẩu của bạn";
        String encodedSubject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String messageText = "<p>Xin chào</p>"
                + "<p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn tại Hola Shoes Shop. Vui lòng nhấp vào liên kết bên dưới để thiết lập mật khẩu mới:</p>"
                + "\n"
                + "👉 " + resetLink
                + "\n"
                + "<p>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này hoặc liên hệ với chúng tôi ngay tại Holashoesshop@gmail.com.vn.</p>"
                + "<p>Trân trọng,</p>"
                + "<p><i>Hola Shoes Shop</i></p>"
                + "<p>26 Cụm 1, Thôn 3, Thạch Thất, Hà Nội</p>"
                + "<p>T: 0812843609 </p>"
                + "<p>E: nguyenphuong9824@gmail.com</p>"
                + "<p>F: https://www.facebook.com/HolaShoesShop</p>"
                + "<p>W: http://localhost:8080/ShoesStoreWed</p>";
        EmailService.sendEmail(userEmail, encodedSubject, messageText);

        // Thông báo người dùng rằng email đã được gửi
        request.setAttribute("message", "Mã đặt lại mật khẩu đã gửi qua email.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Hàm để tạo mã xác nhận ngẫu nhiên
    private String generateResetCode() {
        // Tạo mã xác nhận (có thể dùng UUID hoặc ngẫu nhiên số)
        return java.util.UUID.randomUUID().toString();
    }

    protected void confirmLink(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resetCode = request.getParameter("code");
        request.setAttribute("code", resetCode);
        request.getRequestDispatcher("reset-password.jsp").forward(request, response);
    }

    protected void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    // Hiển thị trang hồ sơ người dùng
    protected void userProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            request.setAttribute("address", null); // Đặt address là null thay vì danh sách rỗng
        }

        // Thông tin đơn hàng
        // List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        // Gửi dữ liệu
        request.setAttribute("user", u);
        // request.setAttribute("orders", orders);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response); // Chuyển hướng đến trang JSP
    }

    protected void updateAvatar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    // Chức năng cập nhật hồ sơ
    protected void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        // Xử lý address

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

    protected void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

        // String message = "Thay đổi mật khẩu thành công!";
        System.out.println(message);
        session.setAttribute("messageChangePassword", message);
        // Sử dụng sendRedirect để chuyển hướng đến trang userProfile
        response.sendRedirect("userProfile"); // Chuyển hướng tới trang userProfile
    }

    protected void userOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy UserID từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy các tham số từ form
        String orderCode = request.getParameter("orderCode");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String sortBy = request.getParameter("sortBy");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Xử lý giá trị minPrice và maxPrice
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        // Xử lý phương thức thanh toán
        String selectedPaymentMethod = null;
        if ("Chuyển Khoản Ngân Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Chuyển Khoản Ngân Hàng";
        } else if ("Thẻ Tín Dụng".equals(paymentMethod)) {
            selectedPaymentMethod = "Thẻ Tín Dụng";
        } else if ("Tiền Mặt Khi Nhận Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Tiền Mặt Khi Nhận Hàng";
        }

        // Xử lý sắp xếp
        String orderBy = null;
        if ("priceDesc".equals(sortBy)) {
            orderBy = "TotalAmount DESC";
        } else if ("priceAsc".equals(sortBy)) {
            orderBy = "TotalAmount ASC";
        } else {
            orderBy = "OrderDate DESC";
        }

        List<Order> orders;

        if (user.getRole().equals("Admin") || user.getRole().equals("Staff")) {
            // Lấy danh sách đơn hàng với các điều kiện lọc
            orders = orderDAO.getAllOrders(
                    orderCode, shippingAddress,
                    selectedPaymentMethod,
                    fromDate,
                    toDate,
                    minPrice,
                    maxPrice,
                    orderBy);
            System.out.println("11111111111");
        } else if (user.getRole().equals("Customer")) {
            // Lấy danh sách đơn hàng với các điều kiện lọc
            orders = orderDAO.getOrdersByUserId(
                    user.getUserId(),
                    orderCode, shippingAddress,
                    selectedPaymentMethod,
                    fromDate,
                    toDate,
                    minPrice,
                    maxPrice,
                    orderBy);
            System.out.println("222222222222");
        } else {
            // Lấy danh sách đơn hàng với các điều kiện lọc
            orders = orderDAO.getOrdersByUserIdInShipping(
                    user.getUserId(),
                    orderCode, shippingAddress,
                    selectedPaymentMethod,
                    fromDate,
                    toDate,
                    minPrice,
                    maxPrice,
                    orderBy);
            System.out.println("3333333333333");
        }

        // Gửi dữ liệu sang JSP (bao gồm các giá trị đã nhập)
        request.setAttribute("orders", orders);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("shippingAddress", shippingAddress);

        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("minPrice", minPriceStr); // Giữ nguyên chuỗi để hiển thị
        request.setAttribute("maxPrice", maxPriceStr); // Giữ nguyên chuỗi để hiển thị

        request.getRequestDispatcher("userOrder.jsp").forward(request, response);
    }

    protected void allUserOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy UserID từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        if (user.getRole().equals("Customer")) {
            response.sendRedirect("home");
            return;
        }

        // Lấy các tham số từ form
        String orderCode = request.getParameter("orderCode");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String sortBy = request.getParameter("sortBy");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Lấy tham số phân trang
        String pageStr = request.getParameter("pageStr");
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 4; // Số đơn hàng trên mỗi trang

        // Xử lý giá trị minPrice và maxPrice
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        // Xử lý phương thức thanh toán
        String selectedPaymentMethod = null;
        if ("Chuyển Khoản Ngân Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Chuyển Khoản Ngân Hàng";
        } else if ("Thẻ Tín Dụng".equals(paymentMethod)) {
            selectedPaymentMethod = "Thẻ Tín Dụng";
        } else if ("Tiền Mặt Khi Nhận Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Tiền Mặt Khi Nhận Hàng";
        }

        // Xử lý sắp xếp
        String orderBy = null;
        if ("priceDesc".equals(sortBy)) {
            orderBy = "TotalAmount DESC";
        } else if ("priceAsc".equals(sortBy)) {
            orderBy = "TotalAmount ASC";
        } else {
            orderBy = "OrderDate DESC";
        }

        // Lấy danh sách đơn hàng với các điều kiện lọc
        List<Order> orders;

        if (user.getRole().equals("Admin") || user.getRole().equals("Staff")) {
            orders = orderDAO.getAllPendingOrders("Pending",
                    orderCode, shippingAddress,
                    selectedPaymentMethod,
                    fromDate,
                    toDate,
                    minPrice,
                    maxPrice,
                    orderBy);
        } else {
            orders = orderDAO.getAllPendingOrders("Confirmed",
                    orderCode, shippingAddress,
                    selectedPaymentMethod,
                    fromDate,
                    toDate,
                    minPrice,
                    maxPrice,
                    orderBy);
        }

        // Phân trang cho danh sách đơn hàng
        int totalOrders = orders.size();
        int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalOrders);

        List<Order> paginatedOrders;
        if (startIndex < totalOrders) {
            paginatedOrders = orders.subList(startIndex, endIndex);
        } else {
            paginatedOrders = new ArrayList<>(); // Nếu không có dữ liệu, trả về danh sách rỗng
        }

        // Gửi dữ liệu sang JSP (bao gồm các giá trị đã nhập và thông tin phân trang)
        request.setAttribute("orders", paginatedOrders);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("shippingAddress", shippingAddress);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("minPrice", minPriceStr);
        request.setAttribute("maxPrice", maxPriceStr);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", totalOrders);
        request.getRequestDispatcher("listPendingOrder.jsp").forward(request, response);
    }

    protected void confirmOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy UserID từ session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        if (!user.getRole().equals("Staff") & !user.getRole().equals("Admin") & !user.getRole().equals("Shipper")) {
            response.sendRedirect("home");
            return;
        }
        // Lấy các tham số từ request
        String orderCode = request.getParameter("orderCode");
        String shippingAddress = request.getParameter("shippingAddress");

        String paymentMethod = request.getParameter("paymentMethod");
        String sortBy = request.getParameter("sortBy");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String pageStr = request.getParameter("pageStr");

        // Xử lý giá trị
        orderCode = (orderCode == null) ? "" : orderCode;
        paymentMethod = (paymentMethod == null) ? "" : paymentMethod;
        sortBy = (sortBy == null) ? "" : sortBy;
        fromDate = (fromDate == null) ? "" : fromDate;
        toDate = (toDate == null) ? "" : toDate;
        minPrice = (minPrice == null) ? "" : minPrice;
        maxPrice = (maxPrice == null) ? "" : maxPrice;
        pageStr = (pageStr == null) ? "" : pageStr;

        Double minPriceValue = (minPrice.isEmpty()) ? null : Double.parseDouble(minPrice);
        Double maxPriceValue = (maxPrice.isEmpty()) ? null : Double.parseDouble(maxPrice);
        // Xử lý phương thức thanh toán
        String selectedPaymentMethod = null;
        if ("Chuyển Khoản Ngân Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Chuyển Khoản Ngân Hàng";
        } else if ("Thẻ Tín Dụng".equals(paymentMethod)) {
            selectedPaymentMethod = "Thẻ Tín Dụng";
        } else if ("Tiền Mặt Khi Nhận Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Tiền Mặt Khi Nhận Hàng";
        }

        String orderBy = null;
        if ("priceDesc".equals(sortBy)) {
            orderBy = "TotalAmount DESC";
        } else if ("priceAsc".equals(sortBy)) {
            orderBy = "TotalAmount ASC";
        } else {
            orderBy = "OrderDate DESC";
        }

        if (user.getRole().equals("Admin") || user.getRole().equals("Staff")) {
            if (request.getParameter("orderId") == null) {
                // Gọi phương thức confirmAllPendingOrders
                orderDAO.confirmAllPendingOrders(orderCode, shippingAddress, selectedPaymentMethod, fromDate, toDate,
                        minPriceValue, maxPriceValue, orderBy);

                // Đặt thông báo
                session.setAttribute("message", "Đã xác nhận tất cả đơn hàng đang chờ!");
            } else {
                int oId = Integer.parseInt(request.getParameter("orderId")); // Lấy orderId từ URL
                boolean a = orderDAO.updateOrderStatus(oId, "Confirmed", 0);
                session.setAttribute("message", "Đã xác nhận đơn hàng !");

            }
        } else {
            if (request.getParameter("orderId") == null) {
                // Gọi phương thức confirmAllPendingOrders
                orderDAO.receiveAllConfirmedOrders(orderCode, shippingAddress, selectedPaymentMethod, fromDate, toDate,
                        minPriceValue, maxPriceValue, orderBy, user.getUserId());

                // Đặt thông báo
                session.setAttribute("message", "Đã xác nhận tất cả đơn hàng đang chờ!");
            } else {
                int oId = Integer.parseInt(request.getParameter("orderId")); // Lấy orderId từ URL
                boolean a = orderDAO.updateOrderStatus(oId, "Shipped", user.getUserId());
                System.out.println(user.getUserId());
                session.setAttribute("message", "Đã xác nhận đơn hàng !");

            }

        }

        // Mã hóa các tham số có dấu
        String encodedPaymentMethod = (selectedPaymentMethod == null) ? ""
                : URLEncoder.encode(selectedPaymentMethod, StandardCharsets.UTF_8);

        // Chuyển hướng về trang allUserOrder và giữ lại các tham số tìm kiếm trong URL
        response.sendRedirect("allUserOrder?pageStr=" + pageStr + "&orderCode=" + orderCode + "&shippingAddress="
                + shippingAddress + "&paymentMethod=" + encodedPaymentMethod
                + "&sortBy=" + sortBy + "&fromDate=" + fromDate + "&toDate=" + toDate
                + "&minPrice=" + minPrice + "&maxPrice=" + maxPrice);
    }

    protected void orderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy UserID từ session hoặc request
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user"); // Giả sử bạn đã lưu userId trong session
        if (user == null) {
            // Nếu user chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderContact oC = userDAO.getOrderContactsByOrderID(orderId);

        Order o = orderDAO.getOrdersByOrderId(orderId);

        List<OrderDetail> orderDetails = orderDAO.getOrderDetailByOderId(orderId);
        ReviewDAO reviewDAO = new ReviewDAO();
        request.setAttribute("reviewDAO", reviewDAO);
        OrderContact orderContact = userDAO.getOrderContactsByOrderID(orderId);

        request.setAttribute("orderContact", oC);
        request.setAttribute("order", o);// tính tổng tiền, phương thức thanh toán,trạng thái
        request.setAttribute("orderDetails", orderDetails);
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("viewDetailOrderHistory.jsp").forward(request, response);
    }

    protected void banUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        if (u == null || (!u.getRole().equals("Admin") && !u.getRole().equals("Staff"))) {
            response.sendRedirect("home"); // Nếu chưa đăng nhập hoặc không phải Admin/Staff
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId")); // Lấy userId từ URL
        userDAO.isLocked(userId); // Gọi phương thức isLocked để khóa tài khoản

        // Lấy thông tin các tham số tìm kiếm và đảm bảo rằng nếu chúng là null thì sẽ
        // mặc định là ""
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
        response.sendRedirect(
                "filterUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName="
                        + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);
    }

    protected void emailReminder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u1 = (User) session.getAttribute("user");
        if (u1 == null || (!u1.getRole().equals("Admin") && !u1.getRole().equals("Staff"))) {
            response.sendRedirect("home"); // Nếu chưa đăng nhập hoặc không phải Admin/Staff
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId")); // Lấy userId từ URL
        User u = userDAO.getUserById(userId); // Gọi hàm để lấy thông tin người dùng"Xin chào

        // Gửi email cho người dùng
        String subject = "[Lời ngỏ ý] Quan trọng:Nhắc nhở về hành vi đặt hàng không hợp lệ";
        String encodedSubject = MimeUtility.encodeText(subject, "UTF-8", "B");
        String messageText = "<html><body>"
                + "<p><b>Xin chào " + u.getFullName() + ",</b></p>"
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
        // String message = "Khôi phục tài khoản thành công.";
        // session.setAttribute("message", message);
        // Chuyển hướng về trang danh sách người dùng bị khóa
        // Lấy thông tin các tham số tìm kiếm và đảm bảo rằng nếu chúng là null thì sẽ
        // mặc định là ""
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
        response.sendRedirect(
                "filterUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName="
                        + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);

    }

    protected void restoreUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin userId từ tham số request
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");
        if (u == null || (!u.getRole().equals("Admin") && !u.getRole().equals("Staff"))) {
            response.sendRedirect("home"); // Nếu chưa đăng nhập hoặc không phải Admin/Staff
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
        response.sendRedirect(
                "filterBanUser?pageStr1=" + pageStr1 + "&pageStr2=" + pageStr2 + "&username=" + username + "&fullName="
                        + fullName + "&email=" + email + "&phone=" + phone + "&registrationDate=" + registrationDate);

    }

    protected void filterUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || (!u.getRole().equals("Admin") && !u.getRole().equals("Staff"))) {
            response.sendRedirect("home");
            return;
        }

        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        int pageCustomer = (pageStr1 != null && !pageStr1.isEmpty()) ? Integer.parseInt(pageStr1) : 1;
        int pageEmployee = (pageStr2 != null && !pageStr2.isEmpty()) ? Integer.parseInt(pageStr2) : 1;
        int pageSize = 4;

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String minRegistrationDate = request.getParameter("minRegistrationDate");
        String maxRegistrationDate = request.getParameter("maxRegistrationDate");
        String minDelivered = request.getParameter("minDelivered");
        String maxDelivered = request.getParameter("maxDelivered");
        String minCancelled = request.getParameter("minCancelled");
        String maxCancelled = request.getParameter("maxCancelled");
        String sortBy = request.getParameter("sortBy");

        List<User> filteredUsers = userDAO.filterUsers(username, fullName, email, phone, minRegistrationDate,
                maxRegistrationDate,
                minDelivered != null && !minDelivered.isEmpty() ? Integer.parseInt(minDelivered) : null,
                maxDelivered != null && !maxDelivered.isEmpty() ? Integer.parseInt(maxDelivered) : null,
                minCancelled != null && !minCancelled.isEmpty() ? Integer.parseInt(minCancelled) : null,
                maxCancelled != null && !maxCancelled.isEmpty() ? Integer.parseInt(maxCancelled) : null);

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

        // Sắp xếp
        Comparator<User> comparator = null;
        if ("cancelledDesc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getCancelledCount).reversed();
        } else if ("cancelledAsc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getCancelledCount);
        } else if ("deliveredDesc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getDeliveredCount).reversed();
        } else if ("deliveredAsc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getDeliveredCount);
        }

        if (comparator != null) {
            customers.sort(comparator);
            employees.sort(comparator);
        }

        // Phân trang
        int totalCustomers = customers.size();
        int totalPagesCustomer = (int) Math.ceil((double) totalCustomers / pageSize);
        int startIndexCustomer = (pageCustomer - 1) * pageSize;
        int endIndexCustomer = Math.min(startIndexCustomer + pageSize, totalCustomers);
        request.setAttribute("customers",
                startIndexCustomer < totalCustomers ? customers.subList(startIndexCustomer, endIndexCustomer)
                        : new ArrayList<>());

        int totalEmployees = employees.size();
        int totalPagesEmployee = (int) Math.ceil((double) totalEmployees / pageSize);
        int startIndexEmployee = (pageEmployee - 1) * pageSize;
        int endIndexEmployee = Math.min(startIndexEmployee + pageSize, totalEmployees);
        request.setAttribute("employees",
                startIndexEmployee < totalEmployees ? employees.subList(startIndexEmployee, endIndexEmployee)
                        : new ArrayList<>());

        request.setAttribute("currentPageCustomer", pageCustomer);
        request.setAttribute("currentPageEmployee", pageEmployee);
        request.setAttribute("totalPagesCustomer", totalPagesCustomer);
        request.setAttribute("totalPagesEmployee", totalPagesEmployee);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalEmployees", totalEmployees);
        request.getRequestDispatcher("accountList.jsp").forward(request, response);
    }

    protected void registerEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !admin.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");
        String role = request.getParameter("role");

        // Gán lại tất cả các giá trị đã nhập để hiển thị lại nếu có lỗi
        request.setAttribute("username", username);
        request.setAttribute("password", password); // Thêm password
        request.setAttribute("confirm_password", confirmPassword); // Thêm confirm_password
        request.setAttribute("fullname", fullname);
        request.setAttribute("email", email);
        request.setAttribute("phonenumber", phonenumber);
        request.setAttribute("role", role);

        // Kiểm tra username tồn tại
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Tên tài khoản đã tồn tại. Vui lòng chọn tên tài khoản khác.");
            request.getRequestDispatcher("registerForEmployee.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email tồn tại
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại. Vui lòng nhập tài khoản email khác.");
            request.getRequestDispatcher("registerForEmployee.jsp").forward(request, response);
            return;
        }

        // Tạo người dùng mới
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(e.getMd5(password));
        newUser.setFullName(fullname);
        newUser.setEmail(email);
        newUser.setPhoneNumber(phonenumber);
        newUser.setRole(role); // Gán vai trò từ form
        userDAO.addUser(newUser);

        // Thông báo thành công và chuyển hướng
        session.setAttribute("message", "Tạo tài khoản nhân viên thành công!");
        response.sendRedirect("filterUser");
    }

    protected void filterBanUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("user");

        if (u == null || (!u.getRole().equals("Admin") && !u.getRole().equals("Staff"))) {
            response.sendRedirect("home");
            return;
        }

        String pageStr1 = request.getParameter("pageStr1");
        String pageStr2 = request.getParameter("pageStr2");
        int pageCustomer = (pageStr1 != null && !pageStr1.isEmpty()) ? Integer.parseInt(pageStr1) : 1;
        int pageEmployee = (pageStr2 != null && !pageStr2.isEmpty()) ? Integer.parseInt(pageStr2) : 1;
        int pageSize = 4;

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String minRegistrationDate = request.getParameter("minRegistrationDate");
        String maxRegistrationDate = request.getParameter("maxRegistrationDate");
        String minDelivered = request.getParameter("minDelivered");
        String maxDelivered = request.getParameter("maxDelivered");
        String minCancelled = request.getParameter("minCancelled");
        String maxCancelled = request.getParameter("maxCancelled");
        String sortBy = request.getParameter("sortBy");

        List<User> filteredUsers = userDAO.filterBanUsers(username, fullName, email, phone, minRegistrationDate,
                maxRegistrationDate,
                minDelivered != null && !minDelivered.isEmpty() ? Integer.parseInt(minDelivered) : null,
                maxDelivered != null && !maxDelivered.isEmpty() ? Integer.parseInt(maxDelivered) : null,
                minCancelled != null && !minCancelled.isEmpty() ? Integer.parseInt(minCancelled) : null,
                maxCancelled != null && !maxCancelled.isEmpty() ? Integer.parseInt(maxCancelled) : null);

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

        // Sắp xếp
        Comparator<User> comparator = null;
        if ("cancelledDesc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getCancelledCount).reversed();
        } else if ("cancelledAsc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getCancelledCount);
        } else if ("deliveredDesc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getDeliveredCount).reversed();
        } else if ("deliveredAsc".equals(sortBy)) {
            comparator = Comparator.comparingInt(User::getDeliveredCount);
        }

        if (comparator != null) {
            customers.sort(comparator);
            employees.sort(comparator);
        }

        // Phân trang
        int totalCustomers = customers.size();
        int totalPagesCustomer = (int) Math.ceil((double) totalCustomers / pageSize);
        int startIndexCustomer = (pageCustomer - 1) * pageSize;
        int endIndexCustomer = Math.min(startIndexCustomer + pageSize, totalCustomers);
        request.setAttribute("customers",
                startIndexCustomer < totalCustomers ? customers.subList(startIndexCustomer, endIndexCustomer)
                        : new ArrayList<>());

        int totalEmployees = employees.size();
        int totalPagesEmployee = (int) Math.ceil((double) totalEmployees / pageSize);
        int startIndexEmployee = (pageEmployee - 1) * pageSize;
        int endIndexEmployee = Math.min(startIndexEmployee + pageSize, totalEmployees);
        request.setAttribute("employees",
                startIndexEmployee < totalEmployees ? employees.subList(startIndexEmployee, endIndexEmployee)
                        : new ArrayList<>());

        request.setAttribute("currentPageCustomer", pageCustomer);
        request.setAttribute("currentPageEmployee", pageEmployee);
        request.setAttribute("totalPagesCustomer", totalPagesCustomer);
        request.setAttribute("totalPagesEmployee", totalPagesEmployee);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("totalEmployees", totalEmployees);
        request.getRequestDispatcher("accountIsLockedList.jsp").forward(request, response);
    }

    protected void getActiveCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }
    }

    protected void userDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || (!admin.getRole().equals("Admin") && !admin.getRole().equals("Staff"))) {
            response.sendRedirect("home"); // Nếu chưa đăng nhập hoặc không phải Admin/Staff
            return;
        }
        // Lấy các tham số từ form
        String orderCode = request.getParameter("orderCode");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String sortBy = request.getParameter("sortBy");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Xử lý giá trị minPrice và maxPrice
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        // Xử lý phương thức thanh toán
        String selectedPaymentMethod = null;
        if ("Chuyển Khoản Ngân Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Chuyển Khoản Ngân Hàng";
        } else if ("Thẻ Tín Dụng".equals(paymentMethod)) {
            selectedPaymentMethod = "Thẻ Tín Dụng";
        } else if ("Tiền Mặt Khi Nhận Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Tiền Mặt Khi Nhận Hàng";
        }

        // Xử lý sắp xếp
        String orderBy = null;
        if ("priceDesc".equals(sortBy)) {
            orderBy = "TotalAmount DESC";
        } else if ("priceAsc".equals(sortBy)) {
            orderBy = "TotalAmount ASC";
        } else {
            orderBy = "OrderDate DESC";
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userDAO.getUserById(userId);
        List<Order> orders = orderDAO.getOrdersByUserId(
                userId,
                orderCode, shippingAddress,
                selectedPaymentMethod,
                fromDate,
                toDate,
                minPrice,
                maxPrice,
                orderBy);

        // Gửi dữ liệu sang JSP (bao gồm các giá trị đã nhập)
        request.setAttribute("orders", orders);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("shippingAddress", shippingAddress);

        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("minPrice", minPriceStr); // Giữ nguyên chuỗi để hiển thị
        request.setAttribute("maxPrice", maxPriceStr); // Giữ nguyên chuỗi để hiển thị

        // request.getRequestDispatcher("userOrder.jsp").forward(request, response);
        request.setAttribute("user", user);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("userDetail.jsp").forward(request, response);
    }

    protected void shippingInformation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login"); // Nếu chưa đăng nhập, chuyển hướng về login
            return;
        }
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        // Lấy danh sách Shipping theo OrderID
        List<Shipping> shippingList = shippingDAO.getListShippingByOrderID(orderId);

        // Lấy UserID từ Shipping
        Integer shipperId = shippingDAO.getUserIDInShippingByOrderID(orderId);
        User shipper;

        if (shipperId == null) {
            // Tạo User giả nếu không có Shipper
            shipper = new User();
            shipper.setUserId(0); // Giá trị mặc định, có thể thay đổi tùy yêu cầu
            shipper.setFullName("Đơn chưa được nhận");
            shipper.setPhoneNumber("Chưa được cập nhật");
            shipper.setEmail("Chưa được cập nhật");
        } else {
            // Lấy thông tin Shipper từ userDAO
            shipper = userDAO.getUserById(shipperId);
            if (shipper == null) {
                // Nếu userDAO không tìm thấy User, tạo User giả với thông tin mặc định
                shipper = new User();
                shipper.setUserId(shipperId);
                shipper.setFullName("Đơn chưa được nhận");
                shipper.setPhoneNumber("Chưa được cập nhật");
                shipper.setEmail("Chưa được cập nhật");
            }
        }

        Order order = orderDAO.getOrdersByOrderId(orderId);

        // Đặt thuộc tính để truyền sang JSP
        request.setAttribute("orderId", orderId);
        request.setAttribute("order", order);
        request.setAttribute("shipper", shipper);
        request.setAttribute("shippingList", shippingList);

        // Chuyển hướng đến JSP
        request.getRequestDispatcher("shippingInformation.jsp").forward(request, response);
    }

    protected void addShippingInformation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String reason = request.getParameter("reason"); // Lý do từ ô text
        String orderStatus = request.getParameter("status"); // "", "Delivered" hoặc "Cancelled"
        String shippingStatus;

        // Xử lý shippingStatus dựa trên orderStatus
        if ("Delivered".equalsIgnoreCase(orderStatus)) {
            shippingStatus = "Giao hàng thành công";
        } else if ("Cancelled".equalsIgnoreCase(orderStatus)) {
            shippingStatus = "Giao hàng không thành công, " + reason;
        } else {
            shippingStatus = reason; // Trường hợp status=""
        }

        // Gọi phương thức addStatusShippingByOrderID
        boolean success = shippingDAO.addStatusShippingByOrderID(orderId, shippingStatus, userId, orderStatus);
        response.sendRedirect("shippingInformation?orderId=" + orderId);

    }

    public static void main(String[] args) {
        String username = "1";
        String fullName = null;
        String email = null;
        String phone = null;
        String registrationDate = null;
        UserDAO userDAO = new UserDAO();

        // Lọc người dùng theo các thông tin được nhập từ form
        // List<User> filteredUsers = userDAO.filterUsers(username, fullName, email,
        // phone, registrationDate);
        // Tạo danh sách khách hàng và nhân viên từ kết quả lọc
        // List<User> customers = new ArrayList<>();
        // List<User> employees = new ArrayList<>();
        //
        // for (User user : filteredUsers) {
        // int deliveredCount = 0;
        // int cancelledCount = 0;
        //
        // for (Order order : user.getOrders()) {
        // if ("Delivered".equals(order.getOrderStatus())) {
        // deliveredCount++;
        // } else if ("Cancelled".equals(order.getOrderStatus())) {
        // cancelledCount++;
        // }
        // }
        //
        // user.setDeliveredCount(deliveredCount);
        // user.setCancelledCount(cancelledCount);
        //
        // if ("Customer".equals(user.getRole())) {
        // System.out.println(user.getUserId());
        // customers.add(user);
        // } else {
        // employees.add(user);
        // }
        // }
    }

    protected void userDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || (!admin.getRole().equals("Admin") && !admin.getRole().equals("Staff"))) {
            response.sendRedirect("home"); // Nếu chưa đăng nhập hoặc không phải Admin/Staff
            return;
        }
        // Lấy các tham số từ form
        String orderCode = request.getParameter("orderCode");
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String sortBy = request.getParameter("sortBy");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Xử lý giá trị minPrice và maxPrice
        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        // Xử lý phương thức thanh toán
        String selectedPaymentMethod = null;
        if ("Chuyển Khoản Ngân Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Chuyển Khoản Ngân Hàng";
        } else if ("Thẻ Tín Dụng".equals(paymentMethod)) {
            selectedPaymentMethod = "Thẻ Tín Dụng";
        } else if ("Tiền Mặt Khi Nhận Hàng".equals(paymentMethod)) {
            selectedPaymentMethod = "Tiền Mặt Khi Nhận Hàng";
        }

        // Xử lý sắp xếp
        String orderBy = null;
        if ("priceDesc".equals(sortBy)) {
            orderBy = "TotalAmount DESC";
        } else if ("priceAsc".equals(sortBy)) {
            orderBy = "TotalAmount ASC";
        } else {
            orderBy = "OrderDate DESC";
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        User user = userDAO.getUserById(userId);
        List<Order> orders = orderDAO.getOrdersByUserId(
                userId,
                orderCode, shippingAddress,
                selectedPaymentMethod,
                fromDate,
                toDate,
                minPrice,
                maxPrice,
                orderBy);

        // Gửi dữ liệu sang JSP (bao gồm các giá trị đã nhập)
        request.setAttribute("orders", orders);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("shippingAddress", shippingAddress);

        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("minPrice", minPriceStr); // Giữ nguyên chuỗi để hiển thị
        request.setAttribute("maxPrice", maxPriceStr); // Giữ nguyên chuỗi để hiển thị

        // request.getRequestDispatcher("userOrder.jsp").forward(request, response);
        request.setAttribute("user", user);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("userDetail.jsp").forward(request, response);
    }

}

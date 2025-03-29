<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <title>Kết quả giao dịch</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <%@page import="model.User"%>
    <%@page import="model.CartItem"%>
    <%@ page import="java.util.List" %>

    <%@page import="jakarta.servlet.http.HttpSession"%>
    <%
        // Sử dụng biến session từ request mà không cần khai báo lại
        User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
    %>
    <% 
    // Lấy danh sách sản phẩm trong giỏ hàng từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    int totalQuantity = 0;
    double subtotal = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalQuantity += item.getQuantity();
            subtotal += item.getProduct().getPrice() * item.getQuantity();
        }
    }
    %>
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp" />
        <!-- /HEADER -->
        <!-- NAVIGATION -->
        <nav id="navigation">
            <div class="container">
                <div id="responsive-nav">
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="./home">Trang Chủ</a></li>
                        <li><a href="./product">Danh Mục</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- /NAVIGATION -->
        <section style="margin-top: 50px; margin-bottom: 50px; text-align: center;">
            <div>
                <img src="https://cdn2.cellphones.com.vn/insecure/rs:fill:150:0/q:90/plain/https://cellphones.com.vn/media/wysiwyg/Review-empty.png" 
                     alt="Transaction Status" 
                     style="width: 120px; height: 120px; margin-bottom: 20px;">
            </div>

            <div>
                <h3 style="font-weight: bold; color: #28a745;">
                    Bạn đã đặt hàng thành công! 
                    <i class="fas fa-check-circle"></i>
                </h3>
                <p style="font-size: 18px; margin-top: 15px;">Mã đơn hàng của bạn là: <strong>${requestScope.orderCode}</strong></p>
                <p style="font-size: 18px; margin-top: 15px;">Cảm ơn bạn đã đặt hàng. Chúng tôi sẽ xử lý đơn hàng của bạn sớm nhất có thể.</p>
                <p style="font-size: 18px; margin-top: 15px;">Vui lòng để ý số điện thoại của nhân viên tư vấn:</p>
                <strong style="color: red; font-size: 24px;">0383459560</strong><br><hr>
                <a href="./home" style="background-color: #D10024; border-color: #D10024" class="btn btn-success">Quay Lại Trang Chủ</a>
                <a href="./userOrder" style="background-color: #D10024; border-color: #D10024" class="btn btn-success">Xem Danh Sách Đơn Hàng</a>
            </div>

        </section>
        <!-- FOOTER -->
        <jsp:include page="footer.jsp" />
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>

<%-- header.jsp (phiên bản rút gọn, không chứa thẻ HTML, HEAD, BODY) --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css"/>
<link rel="stylesheet" href="css/searchbar.css" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="model.User" %>
<%@page import="model.CartItem" %>
<%@page import="model.WishlistItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%
    // Sử dụng biến session từ request mà không cần khai báo lại
        User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
    // Lấy danh sách sản phẩm trong giỏ hàng từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    int totalQuantity = 0;
    double subtotal = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalQuantity += item.getQuantity();
            subtotal += item.getProduct().getSalePrice() * item.getQuantity();
        }
    }
    // Lấy danh sách wishlist từ session
    List<WishlistItem> wishlistItems = (List<WishlistItem>) session.getAttribute("wishlist");
    int total = 0;
    if (wishlistItems != null) {
        for (WishlistItem item : wishlistItems) {
            total += 1;
        }
    }
    
    Calendar calendar = Calendar.getInstance();
    int currentYear = calendar.get(Calendar.YEAR);
    int currentMonth = calendar.get(Calendar.MONTH) + 1;
%>
<!-- HEADER -->
<header>
    <!-- TOP HEADER -->
    <div id="top-header">
        <div class="container">
            <ul class="header-links pull-left">
                <li><a href="#"><i class="fa fa-phone"></i> 0812843609</a></li>
                <li><a href="#"><i class="fa fa-envelope-o"></i> nguyenphuong9824@gmail.com</a></li>
                <li><a href="#"><i class="fa fa-map-marker"></i> 26 Cụm 1, Thôn 3, Thạch Thất, Hà Nội</a></li>
            </ul>
            <ul class="header-links pull-right">
                <% if (user == null) { %>
                <li><a href="login"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                    <% } else { %>
                    <% if ("Admin".equals(user.getRole())) { %>
                <li>
                    <a href="list">
                        <i class="fa fa-dashboard"></i> Dashboard
                    </a>
                </li>
                <% } %>
                <li><a href="userProfile"><i class="fa fa-user"></i> Chào mừng, <%= user.getUsername() %></a></li>
                <li><a href="logout"><i class="fa fa-sign-out"></i> Đăng xuất</a></li>
                    <% } %>
            </ul>
        </div>
    </div>
    <!-- /TOP HEADER -->

    <!-- MAIN HEADER -->
    <div id="header">
        <div class="container">
            <div class="row" style="display: flex; align-items: center">
                <!-- LOGO -->
                <div class="col-md-3">
                    <div class="header-logo">
                        <a href="./home" class="logo">
                            <img src="./img/logo2.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

            </div>
        </div>
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->


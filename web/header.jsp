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
            subtotal += item.getProduct().getPrice() * item.getQuantity();
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
                <li><a href="login.jsp"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                    <% } else { %>
                    <% if ("Admin".equals(user.getRole())) { %>
                <li>
                    <a href="/ProjectPRJ301/revenue?year=<%= currentYear %>&month=<%= currentMonth %>">
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
                            <img src="./img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <!-- /LOGO -->

                <!-- Search Bar -->
                <div class="col-md-6">
                    <div class="search-bar">
                        <form style="display: flex; width: 100%" action="search" method="get">
                            <div class="dropdown-searchbar">
                                <div id="drop-text" class="dropdown-text">
                                    <span id="span">All</span>
                                    <i id="icon" class="fa-solid fa-chevron-down"></i>
                                </div>
                                <ul id="list" class="dropdown-list">
                                    <li class="dropdown-list-item" value="">All</li>
                                    <li class="dropdown-list-item" value="Laptop">Sneakers</li>
                                    <li class="dropdown-list-item" value="Smartphone">Oxford</li>
                                    <li class="dropdown-list-item" value="Camera">Boot</li>
                                    <li class="dropdown-list-item" value="Accessory">Sandals</li>
                                </ul>
                            </div>
                            <div class="search-box">
                                <input name="query" type="text" id="search-input" placeholder="Search anything..." />
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /Search Bar -->

                <!-- ACCOUNT -->
                <div class="col-md-3 clearfix">
                    <div class="header-ctn">
                        <!-- Wishlist -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                <i class="fa fa-heart-o"></i>
                                <span>Your Wishlist</span>
                                <div class="qty"><%= total %></div>
                            </a>
                            <div class="cart-dropdown">
                                <div class="cart-list">
                                    <% if (wishlistItems != null && !wishlistItems.isEmpty()) { %>
                                    <% for (WishlistItem item : wishlistItems) { %>
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="<%= item.getProduct().getImageURL() %>" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#"><%= item.getProduct().getProductName() %></a></h3>
                                            <h4 class="product-price">$<%= item.getProduct().getSalePrice() %></h4>
                                        </div>
                                        <form action="deleteWishlistItem" method="POST">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getProductID() %>">
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </form>
                                    </div>
                                    <% } %>
                                    <% } else { %>
                                    <p>Danh sách yêu thích của bạn đang trống</p>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        <!-- /Wishlist -->

                        <!-- Cart -->
                        <div class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                <i class="fa fa-shopping-cart"></i>
                                <span>Giỏ Hàng</span>
                                <div class="qty"><%= totalQuantity %></div>
                            </a>
                            <div class="cart-dropdown">
                                <div class="cart-list">
                                    <% if (cartItems != null && !cartItems.isEmpty()) { %>
                                    <% for (CartItem item : cartItems) { %>
                                    <div class="product-widget">
                                        <div class="product-img">
                                            <img src="<%= item.getProduct().getImageURL() %>" alt="">
                                        </div>
                                        <div class="product-body">
                                            <h3 class="product-name"><a href="#"><%= item.getProduct().getProductName() %></a></h3>
                                            <h4 class="product-price"><span class="qty"><%= item.getQuantity() %>x</span>$<%= item.getProduct().getSalePrice() %></h4>
                                        </div>
                                        <form action="deleteCartItem" method="POST">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getProductID() %>">
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </form>
                                    </div>
                                    <% } %>
                                    <% } else { %>
                                    <p>Giỏ hàng của bạn đang trống</p>
                                    <% } %>
                                </div>
                                <div class="cart-summary">
                                    <small><%= totalQuantity %> sản phẩm</small>
                                    <h5>Tổng: $<%= subtotal %></h5>
                                </div>
                                <div class="cart-btns">
                                    <a href="cartItem">Xem Giỏ Hàng</a>
                                    <a href="getOrderItem">Thanh Toán <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                        <!-- /Cart -->

                        <!-- Menu Toggle -->
                        <div class="menu-toggle">
                            <a href="#">
                                <i class="fa fa-bars"></i>
                                <span>Menu</span>
                            </a>
                        </div>
                        <!-- /Menu Toggle -->
                    </div>
                </div>
                <!-- /ACCOUNT -->
            </div>
        </div>
    </div>
    <!-- /MAIN HEADER -->
</header>
<!-- /HEADER -->
<script src="js/searchbar.js"></script>


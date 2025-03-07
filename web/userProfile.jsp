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

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style type="text/css">
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            .container.user-profile {
                margin-top: 20px;
            }

            .card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1),
                    0 -4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .card-body {
                padding: 1.5rem;
            }

            .card {
                margin-bottom: 20px; /* Khoảng cách bên dưới thẻ card */
            }



            .d-flex.align-items-center.text-center img.rounded-circle {
                border: 2px solid #D10024;
            }

            .text-secondary {
                color: #6c757d !important;
            }

            .btn {
                padding: 0.5rem 1.5rem;
                border-radius: 20px;
                font-size: 14px;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-outline-primary {
                color: #007bff;
                border: 1px solid #007bff;
                background-color: transparent;
            }

            .card h5 {
                color: #007bff;
                font-size: 1.2rem;
                font-weight: bold;
            }

            .list-group-item {
                border: none;
                padding: 10px 0;
            }

            .list-group-item h6 {
                color: #333;
                font-weight: 600;
            }

            .list-group-item span.text-secondary {
                font-weight: 500;
            }

            .progress-bar {
                height: 6px;
                border-radius: 10px;
            }

            .progress-bar.bg-primary {
                background-color: #007bff;
            }

            .progress-bar.bg-danger {
                background-color: #dc3545;
            }

            .progress-bar.bg-success {
                background-color: #28a745;
            }

            .progress-bar.bg-warning {
                background-color: #ffc107;
            }

            .progress-bar.bg-info {
                background-color: #17a2b8;
            }

            .form-control {
                border-radius: 5px;
                border: 1px solid #ced4da;
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            }

            .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .card-body .row.mb-3 {
                align-items: center;
                padding: 0.5rem 0;
                margin-left: 14px;
                margin-right: 14px;
            }

            .card-body .row.mb-3 h6 {
                font-weight: bold;
                color: #495057;
            }

            .card-body .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
            }

            .user-profile .camera-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 110px; /* Đặt kích thước lớp phủ */
                height: 110px;
                background: rgba(0, 0, 0, 0.5); /* Màu nền đen mờ */
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0; /* Ban đầu ẩn */
                transition: opacity 0.3s ease; /* Hiệu ứng chuyển động */
            }

            .user-profile .profile-image-container {
                position: relative;
                display: inline-block;
            }

            .user-profile .profile-image-container:hover .camera-overlay {
                opacity: 1; /* Hiện lớp phủ khi di chuyển chuột */
            }

            .user-profile .camera-icon {
                color: white;
                font-size: 24px; /* Kích thước biểu tượng */
            }

            .list-product {
                margin: 10px;
                margin-left: 20px;
            }
            table {
                width: 100%; /* Đặt chiều rộng của bảng 100% */
                border-collapse: collapse; /* Gộp các viền lại với nhau */
                font-size: 12px;
            }

            /* Cài đặt cho các ô tiêu đề */
            th {
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                padding: 12px; /* Đệm cho ô tiêu đề */
                text-align: center; /* Căn trái cho chữ */
                vertical-align: middle;
            }

            /* Cài đặt cho các ô dữ liệu */
            td {
                padding: 8px; /* Đệm cho ô dữ liệu */
                text-align: center;
                vertical-align: middle;
            }

            /* Thay đổi màu nền khi rê chuột qua hàng */
            tr:hover {
                background-color: #f5f5f5; /* Màu nền khi rê chuột */
            }

            /* Cài đặt cho hàng lẻ */
            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng lẻ */
            }

            /* Cài đặt cho hình ảnh trong bảng */
            img {
                border-radius: 5px; /* Bo tròn góc cho hình ảnh */
            }
            /* Cài đặt cho tiêu đề sản phẩm */
            .product-title {
                font-size: 18px; /* Kích thước chữ */
                color: #333; /* Màu chữ */
                text-align: center; /* Căn giữa tiêu đề */
            }

            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-bottom: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }
            .action-link {
                text-decoration: none; /* Bỏ gạch chân */
                padding: 8px 12px; /* Khoảng cách bên trong */
                border-radius: 4px; /* Bo góc */
                color: white; /* Màu chữ */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .btn-edit {
                background-color: #4CAF50; /* Màu xanh lá cây cho nút sửa */
            }

            .btn-delete {
                background-color: #f44336; /* Màu đỏ cho nút xóa */
            }

            .btn-edit:hover {
                background-color: #45a049; /* Màu xanh lá cây đậm khi hover */
            }

            .btn-delete:hover {
                background-color: #e53935; /* Màu đỏ đậm khi hover */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }

            .table-responsive {
                max-height: 283px; /* Chiều cao tối đa của bảng */
                overflow-y: auto; /* Thêm thanh cuộn dọc khi vượt quá chiều cao tối đa */
                overflow-x: hidden; /* Ẩn thanh cuộn ngang (tuỳ chọn) */
            }

            table {
                width: 100%; /* Đảm bảo bảng chiếm hết chiều rộng của div chứa */
                border-collapse: collapse; /* Kết hợp biên bảng */
            }

            th {
                position: sticky; /* Giữ tiêu đề cố định */
                top: 0; /* Vị trí dính lại trên cùng */
                z-index: 1; /* Đặt độ ưu tiên để không bị che khuất */
            }

            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng chẵn */
            }

            h2{
                margin: 0px;
                margin-bottom: 10px;
            }

            .form-select {
                padding: 8px 12px;
                font-size: 14px;
                color: #333; /* Màu chữ */
                background-color: #f8f9fa; /* Màu nền */
                border: 1px solid #ced4da; /* Viền */
                border-radius: 5px; /* Bo tròn góc */
                appearance: none; /* Ẩn mũi tên mặc định của select */
                -webkit-appearance: none; /* Ẩn mũi tên cho trình duyệt Webkit */
                -moz-appearance: none; /* Ẩn mũi tên cho trình duyệt Firefox */
                margin-left: 15px;
            }

            .form-select-sm {
                font-size: 13px; /* Kích thước chữ nhỏ */
            }

            .form-select:hover {
                background-color: #e9ecef; /* Đổi màu nền khi hover */
                border-color: #adb5bd; /* Đổi màu viền khi hover */
            }

            .form-select:focus {
                outline: none; /* Xóa viền focus mặc định */
                border-color: #80bdff; /* Màu viền khi focus */
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Tạo hiệu ứng viền sáng khi focus */
            }

            .message-success {
                color: green;
                font-weight: bold;
                padding: 10px;
                background-color: #e6ffed;
                border: 1px solid #66cc66;
                border-radius: 5px;
                margin-top: 10px;
            }

            /* CSS cho thông báo lỗi */
            .message-error {
                color: red;
                font-weight: bold;
                padding: 10px;
                background-color: #ffe6e6;
                border: 1px solid #ff6666;
                border-radius: 5px;
                margin-top: 10px;
            }

        </style>
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
        <header>
            <!-- TOP HEADER -->
            <div id="top-header">
                <div class="container">
                    <ul class="header-links pull-left">
                        <li><a href="#"><i class="fa fa-phone"></i> 0812843609</a></li>
                        <li><a href="#"><i class="fa fa-envelope-o"></i> nguyenphuong9824@gmail.com</a></li>
                        <li><a href="#"><i class="fa fa-map-marker"></i> SE1881 - PRJ301</a></li>
                    </ul>
                    <ul class="header-links pull-right">
                        <% if (user == null) { %>
                        <li><a href="login.jsp"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                            <% } else { %>
                        <li><a href="#"><i class="fa fa-dollar"></i> Chào Mừng, <%= user.getUsername() %></a></li>
                        <li><a href="logout"><i class="fa fa-user-o"></i> Đăng Xuất</a></li>
                            <% } %>
                    </ul>
                </div>
            </div>
            <!-- /TOP HEADER -->
        </header>

        <!-- /TOP HEADER -->


        <!-- MAIN HEADER -->
        <div id="header">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- LOGO -->
                    <div class="col-md-3">
                        <div class="header-logo">
                            <a href="/ProjectPRJ301/home" class="logo">
                                <img src="./img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <!-- /LOGO -->

                    <!-- SEARCH BAR -->
                    <div class="col-md-6">
                        <div class="header-search">
                            <form action="search" method="get">
                                <select class="input-select" name="category">
                                    <option value="">Tất cả</option>
                                    <option value="Laptop">Laptop</option>
                                    <option value="Smartphone">Điện Thoại</option>
                                    <option value="Camera">Máy Ảnh</option>
                                    <option value="Accessory">Phụ Kiện</option>
                                    <!-- Thêm các loại sản phẩm khác nếu cần -->
                                </select>
                                <input class="input" name="query" placeholder="Search here">
                                <button type="submit" class="search-btn">Tìm kiếm</button>
                            </form>
                        </div>
                    </div>
                    <!-- /SEARCH BAR -->

                    <!-- ACCOUNT -->
                    <div class="col-md-3 clearfix">
                        <div class="header-ctn">

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
                            <!-- Menu Toogle -->
                            <div class="menu-toggle">
                                <a href="#">
                                    <i class="fa fa-bars"></i>
                                    <span>Menu</span>
                                </a>
                            </div>
                            <!-- /Menu Toogle -->
                        </div>
                    </div>
                    <!-- /ACCOUNT -->
                </div>
                <!-- row -->
            </div>
            <!-- container -->
        </div>
        <!-- /MAIN HEADER -->
    </header>
    <!-- /HEADER -->

    <!-- NAVIGATION -->
    <nav id="navigation">
        <!-- container -->
        <div class="container">
            <!-- responsive-nav -->
            <div id="responsive-nav">
                <!-- NAV -->
                <ul class="main-nav nav navbar-nav">
                    <li><a href="/ProjectPRJ301/home">Trang Chủ</a></li>
                    <li><a href="/ProjectPRJ301/product">Danh Mục</a></li>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                        <li><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
                        <li><a href="getAllOrders" class="admin-link">Danh Sách Tất Cả Đơn Hàng</a></li>
                        </c:if>
                </ul>
                <!-- /NAV -->
            </div>
            <!-- /responsive-nav -->
        </div>
        <!-- /container -->
    </nav>
    <!-- /NAVIGATION -->


    <div class="container user-profile">
        <div class="main-body">
            <div class="row" style="margin-top: 30px; margin-bottom: 30px">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-column align-items-center text-center">
                                <form action="updateAvatar" method="POST" enctype="multipart/form-data" multiple required>
                                    <div class="profile-image-container">
                                        <label for="profileImage" style="cursor: pointer;">
                                            <img style="margin: 10px; cursor: pointer;" 
                                                 src="${user.profileImageURL != null && user.profileImageURL != '' ? 
                                                        user.profileImageURL : 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg'}" 
                                                 alt="Profile Image" class="rounded-circle p-1 bg-primary" width="110" height="110px">
                                            <input type="file" id="profileImage" name="profileImageURL" accept="image/*" style="display: none;" onchange="updateAvatar()">

                                            <div class="camera-overlay" style="margin: 10px;">
                                                <i class="fas fa-camera camera-icon"></i>
                                            </div>
                                        </label>
                                    </div>
                                </form>
                                <div class="mt-3">
                                    <h4>${user.fullName}</h4>
                                    <p class="text-secondary mb-1">${user.role}</p>
                                    <p class="text-muted font-size-sm">${user.address}</p>
                                </div>
                            </div>
                            <hr class="my-4">
                            <ul class="list-group list-group-flush">
                                <h2 class="product-title">Change Password</h2>
                                <form action="changePassword" method="POST">
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Password</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="password" class="form-control" name="password">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">New Password</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="password" class="form-control" name="newPassword">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Confirm New Passwords</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="password" class="form-control" name="confirmNewPassword">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-9 text-secondary">
                                            <button type="submit" class="btn btn-primary px-4">Save Changes</button>
                                        </div>
                                    </div>
                                </form>
                                <c:if test="${not empty message}">
                                    <p class="${message == 'Đổi mật khẩu thành công.' ? 'message-success' : 'message-error'}">
                                        ${message}
                                    </p>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                </div>


                <div class="col-lg-8">

                    <form action="updateProfile" method="POST">         
                        <div class="card">
                            <hr>
                            <h2 class="product-title">User Profile</h2>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Full Name</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" name="fullName" value="${user.fullName}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Email</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" name="email" value="${user.email}">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Phone</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" name="phoneNumber" value="${user.phoneNumber}">
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Address</h6>
                                    </div>
                                    <select name="city" class="form-select form-select-sm mb-3" id="city" aria-label=".form-select-sm">
                                        <option value="" selected>${address.get(3) != null ? address.get(3) : "Tỉnh Thành"}</option>           
                                    </select>

                                    <select name="district" class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                                        <option value="" selected>${address.get(2) != null ? address.get(2) : "Quận Huyện"}</option>
                                    </select>

                                    <select name="ward" class="form-select form-select-sm" id="ward" aria-label=".form-select-sm">
                                        <option value="" selected>${address.get(1) != null ? address.get(1) : "Xã Phường"}</option>
                                    </select>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Address Detail</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" name="addressDetail" value="${address.get(0)}">
                                    </div>
                                </div>

                                <div class="row" style="margin-top: 10px">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-secondary">
                                        <button type="submit" class="btn btn-primary px-4">Save Changes</button>
                                    </div>
                                </div>
                                <hr>
                            </div>
                        </div>

                    </form>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="list-product">
                                        <h2 class="product-title">Danh Sách Đơn Hàng</h2>
                                        <div class="table-responsive">
                                            <table border="1">
                                                <tr>
                                                    <th>Mã Đơn Hàng</th>
                                                    <th>Ngày Đặt Hàng</th>
                                                    <th>Tổng Số Tiền</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Phương Thức Thanh Toán</th>
                                                    <th>Địa Chỉ Giao Hàng</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>${order.orderCode}</td>
                                                        <td>${order.orderDate}</td>
                                                        <td>${order.totalAmount}</td>
                                                        <td>${order.orderStatus}</td>
                                                        <td>${order.paymentMethod}</td>
                                                        <td>${order.shippingAddress}</td>
                                                        <td><a href="orderDetail?id=${order.orderId}">Chi Tiết</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <!-- FOOTER -->
    <footer id="footer">
        <!-- top footer -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">About Us</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
                            <ul class="footer-links">
                                <li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
                                <li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Categories</h3>
                            <ul class="footer-links">
                                <li><a href="#">Hot deals</a></li>
                                <li><a href="#">Laptops</a></li>
                                <li><a href="#">Smartphones</a></li>
                                <li><a href="#">Cameras</a></li>
                                <li><a href="#">Accessories</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="clearfix visible-xs"></div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Information</h3>
                            <ul class="footer-links">
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Contact Us</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Orders and Returns</a></li>
                                <li><a href="#">Terms & Conditions</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Service</h3>
                            <ul class="footer-links">
                                <li><a href="#">My Account</a></li>
                                <li><a href="#">View Cart</a></li>
                                <li><a href="#">Wishlist</a></li>
                                <li><a href="#">Track My Order</a></li>
                                <li><a href="#">Help</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /top footer -->

        <!-- bottom footer -->
        <div id="bottom-footer" class="section">
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12 text-center">
                        <ul class="footer-payments">
                            <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                            <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                        </ul>
                        <span class="copyright">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </span>


                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /bottom footer -->
    </footer>
    <!-- /FOOTER -->

    <!-- jQuery Plugins -->
    <!-- jQuery -->
    <!-- Bootstrap Bundle JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
                                var citis = document.getElementById("city");
                                var districts = document.getElementById("district");
                                var wards = document.getElementById("ward");
                                var Parameter = {
                                    url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                    method: "GET",
                                    responseType: "application/json",
                                };
                                var promise = axios(Parameter);
                                promise.then(function (result) {
                                    renderCity(result.data);
                                });

                                function renderCity(data) {
                                    for (const x of data) {
                                        // Đặt value thành tên thay vì ID
                                        citis.options[citis.options.length] = new Option(x.Name, x.Name);
                                    }
                                    citis.onchange = function () {
                                        districts.length = 1;
                                        wards.length = 1;
                                        if (this.value != "") {
                                            const result = data.filter(n => n.Name === this.value);

                                            for (const k of result[0].Districts) {
                                                // Đặt value thành tên thay vì ID
                                                districts.options[districts.options.length] = new Option(k.Name, k.Name);
                                            }
                                        }
                                    };
                                    districts.onchange = function () {
                                        wards.length = 1;
                                        const dataCity = data.filter((n) => n.Name === citis.value);
                                        if (this.value != "") {
                                            const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

                                            for (const w of dataWards) {
                                                // Đặt value thành tên thay vì ID
                                                wards.options[wards.options.length] = new Option(w.Name, w.Name);
                                            }
                                        }
                                    };
                                }
    </script>
    <script>
        document.getElementById('profileImage').addEventListener('change', function () {
            const form = this.closest('form'); // Lấy form bao quanh
            form.submit(); // Gửi form
        });
    </script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Đơn Hàng</title>

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min_1.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">

        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>


        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">


        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            body {
                background-color: #f9f7f7;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .user-profile {
                margin-top: 20px;
                margin-bottom: 40px;
            }

            .card {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(255,0,0,0.1);
                margin-bottom: 30px;
                border: none;
            }

            .card-header {
                background-color: red;
                color: white;
                border-radius: 10px 10px 0 0 !important;
                padding: 15px 20px;
                border: none;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: 600;
                margin-right: 10px;
                color: #343a40;
            }

            .search-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                border: 1px solid #e9ecef;
            }

            .btn-primary {
                background-color: red;
                border-color: red;
                padding: 8px 20px;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background-color: #E60000;
                border-color: #CC0000;
                box-shadow: 0 5px 15px rgba(255,0,0,0.2);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table th {
                background-color: red;
                color: white;
                padding: 12px 15px;
                text-align: left;
                font-weight: 600;
            }

            .responsive-table th {
                background-color: red;
                color: white;
            }

            table td {
                padding: 12px 15px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
            }

            table tr:hover {
                background-color: #ffecef;
            }

            .action-link {
                color: red;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .action-link:hover {
                color: #E60000;
                text-decoration: underline;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .pagination a {
                color: red;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #e9ecef;
                margin: 0 4px;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .pagination a:hover {
                background-color: #FF0000;
                color: white;
            }

            .pagination a.active {
                background-color: #FF0000;
                color: white;
                border: 1px solid #FF0000;
            }

            .back-btn {
                display: inline-block;
                margin-left: 20px;
                color: #FF0000;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .back-btn:hover {
                color: #E60000;
                text-decoration: underline;
            }

            .nav-tabs {
                border-bottom: 2px solid #e9ecef;
                margin-bottom: 20px;
            }

            .nav-tabs .nav-link {
                border: none;
                color: #6c757d;
                font-weight: 600;
                padding: 10px 20px;
            }

            .nav-tabs .nav-link.active {
                color: #FF0000;
                border-bottom: 3px solid #FF0000;
                background-color: transparent;
            }

            .product-title {
                color: #343a40;
                font-weight: 700;
                margin-bottom: 20px;
                text-align: center;
            }

            .confirm-all-btn {
                background-color: #28a745;
                border-color: #28a745;
            }

            .confirm-all-btn:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }

            .search-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: flex-end;
            }

            .search-col {
                flex: 1;
                min-width: 250px;
            }

            .search-actions {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .responsive-table {
                overflow-x: auto;
            }

            .form-control:focus {
                border-color: #FF0000;
                box-shadow: 0 0 0 0.2rem rgba(255, 0, 0, 0.25);
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(255, 0, 0, 0.05);
            }

            h5 {
                color: #FF0000;
                font-weight: 600;
            }

            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
            }

            .sidebar .navbar-nav {
                background-color: #191c24;
            }


            .sidebar .navbar .dropdown-item {
                padding: 10px 35px;
                border-radius: 0 30px 30px 0;
                color: var(--light);
            }
        </style>
    </head>
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
    <body>
        <div class="container-fluid position-relative d-flex p-0">   
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">
                    <a href="home" class="navbar-brand mx-5 mb-3">
                        <h3 class="text-primary"><i class=""></i>ShoeShop</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 style="color: red" class="mb-0"><%= user.getUsername() %></h6>
                            <span style="color: red"><%= user.getRole() %></span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <c:choose>
                            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Shipper'}">
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Đơn Hàng</a>
                                    <div class="dropdown-menu bg-transparent border-0">
                                        <a href="allUserOrder" class="dropdown-item">Đơn Hàng Có Thể Nhận</a>
                                        <a href="userOrder" class="dropdown-item">Đơn Hàng Đã Nhận</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Sản Phẩm</a>
                                    <div class="dropdown-menu bg-transparent border-0">
                                        <a href="list" class="dropdown-item">Danh Sách Sản Phẩm</a>
                                        <a href="#" class="dropdown-item">Khác</a>
                                    </div>
                                </div>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Tài Khoản</a>
                                    <div class="dropdown-menu bg-transparent border-0">
                                        <a href="filterUser" class="dropdown-item">Danh Sách Người Dùng</a>
                                        <a href="filterBanUser" class="dropdown-item">Tài Khoản Bị Khóa</a>
                                    </div>
                                </div>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Hoạt Động</a>
                                    <div class="dropdown-menu bg-transparent border-0">
                                        <a href="activeCustomers" class="dropdown-item">Hoạt Động Khách Hàng</a>
                                        <a href="customerBehavior" class="dropdown-item">Sản Phẩm Ưa Chuộng</a>
                                    </div>
                                </div>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Đơn Hàng</a>
                                    <div class="dropdown-menu bg-transparent border-0">
                                        <a href="allUserOrder" class="dropdown-item">Đơn Hàng Chờ Xác Nhận</a>
                                        <a href="userOrder" class="dropdown-item">Đơn Hàng Đã Duyệt</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

            <div style="background-color: white" class="content"> 
                <jsp:include page="headerAdmin.jsp"/>  
                <div class="container-fluid pt-4 px-4">
                    <div class="container user-profile">
                        <div class="main-body">
                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h3 style="color: white" class="mb-0">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                        <i class="fas fa-clipboard-list mr-2"></i> Quản Lý Đơn Hàng
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-shipping-fast mr-2"></i> Đơn Hàng Có Thể Nhận
                                                    </c:otherwise>
                                                </c:choose>
                                            </h3>
                                        </div>
                                        <div class="card-body">
                                            <!-- Form tìm kiếm -->
                                            <div class="search-section">
                                                <h5><i class="fas fa-search mr-2"></i> Tìm Kiếm Đơn Hàng</h5>
                                                <form action="allUserOrder" method="GET">
                                                    <div class="search-row">
                                                        <div class="search-col">
                                                            <label for="orderCode">Mã Đơn Hàng:</label>
                                                            <input style="background-color: white" type="text" class="form-control" id="orderCode" name="orderCode" 
                                                                   placeholder="Nhập mã đơn" value="${orderCode}">
                                                        </div>

                                                        <div class="search-col">
                                                            <label for="shippingAddress">Địa Chỉ Giao Hàng:</label>
                                                            <input style="background-color: white" type="text" class="form-control" id="shippingAddress" name="shippingAddress" 
                                                                   placeholder="Nhập địa chỉ giao hàng" value="${shippingAddress}">
                                                        </div>
                                                    </div>

                                                    <div class="search-row">
                                                        <div class="search-col">
                                                            <label for="paymentMethod">Phương Thức Thanh Toán:</label>
                                                            <select style="background-color: white" class="form-control" id="paymentMethod" name="paymentMethod">
                                                                <option value="null" ${paymentMethod == null || paymentMethod == 'null' ? 'selected' : ''}>Tất cả</option>
                                                                <option value="Chuyển Khoản Ngân Hàng" ${paymentMethod == 'Chuyển Khoản Ngân Hàng' ? 'selected' : ''}>Chuyển Khoản Ngân Hàng</option>
                                                                <option value="Tiền Mặt Khi Nhận Hàng" ${paymentMethod == 'Tiền Mặt Khi Nhận Hàng' ? 'selected' : ''}>Tiền Mặt Khi Nhận Hàng</option>
                                                            </select>
                                                        </div>

                                                        <div class="search-col">
                                                            <label for="sortBy">Sắp Xếp:</label>
                                                            <select style="background-color: white" class="form-control" id="sortBy" name="sortBy">
                                                                <option value="default" ${sortBy == null || sortBy == 'default' ? 'selected' : ''}>Mặc định</option>
                                                                <option value="priceDesc" ${sortBy == 'priceDesc' ? 'selected' : ''}>Tổng Số Tiền giảm dần</option>
                                                                <option value="priceAsc" ${sortBy == 'priceAsc' ? 'selected' : ''}>Tổng Số Tiền tăng dần</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="search-row">
                                                        <div class="search-col">
                                                            <label>Ngày Đặt Hàng:</label>
                                                            <div class="d-flex">
                                                                <input style="background-color: white" type="date" class="form-control" id="fromDate" name="fromDate" value="${fromDate}">
                                                                <span class="mx-2 align-self-center">đến</span>
                                                                <input style="background-color: white" type="date" class="form-control" id="toDate" name="toDate" value="${toDate}">
                                                            </div>
                                                        </div>

                                                        <div class="search-col">
                                                            <label>Tổng Số Tiền:</label>
                                                            <div class="d-flex">
                                                                <input style="background-color: white" type="number" class="form-control" id="minPrice" name="minPrice" 
                                                                       placeholder="Giá tối thiểu" value="${minPrice}">
                                                                <span class="mx-2 align-self-center">đến</span>
                                                                <input style="background-color: white" type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                                                       placeholder="Giá tối đa" value="${maxPrice}">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="search-actions">
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-search mr-2"></i> Tìm Kiếm
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>

                                            <div class="list-product">
                                                <!-- Tiêu đề danh sách đơn hàng -->
                                                <h4 class="product-title">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                            <i class="fas fa-clipboard-check mr-2"></i> Danh Sách Đơn Hàng Chờ Xác Nhận
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-truck mr-2"></i> Danh Sách Đơn Hàng Có Thể Nhận
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h4>
                                                <%-- Hiển thị thông báo từ session nếu có --%>
                                                <c:if test="${not empty sessionScope.message}">
                                                    <div class="alert alert-success" role="alert">
                                                        ${sessionScope.message}
                                                        <%-- Xóa thông báo sau khi hiển thị để tránh hiển thị lại khi tải lại trang --%>
                                                        <% session.removeAttribute("message"); %>
                                                    </div>
                                                </c:if>

                                                <!-- Tabs điều hướng -->
                                                <ul class="nav nav-tabs">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#pending">
                                                            <c:choose>
                                                                <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                                    <i class="fas fa-hourglass-half mr-1"></i> Chờ xác nhận
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-hand-holding-box mr-1"></i> Chờ nhận đơn
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                    </li>
                                                    <li class="nav-item ml-auto">
                                                        <a href="./userOrder" class="back-btn">
                                                            <c:choose>
                                                                <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                                    <i class="fas fa-list mr-1"></i> Danh sách đơn đã duyệt
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-list mr-1"></i> Danh sách đơn đã nhận
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <i class="fas fa-arrow-right ml-1"></i>
                                                        </a>
                                                    </li>
                                                </ul>

                                                <div class="tab-content">
                                                    <!-- Chờ xác nhận -->
                                                    <div id="pending" class="tab-pane active">
                                                        <!-- Nút Xác nhận tất cả -->
                                                        <div class="text-right mb-3">
                                                            <a href="confirmOrder?pageStr=${currentPage}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                               onclick="return confirm('Bạn có chắc chắn muốn xác nhận tất cả đơn hàng đang chờ không?')" 
                                                               class="btn btn-primary confirm-all-btn">
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                                        <i class="fas fa-check-double mr-1"></i> Xác nhận tất cả
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class="fas fa-check-double mr-1"></i> Nhận tất cả đơn
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </a>
                                                        </div>

                                                        <div class="responsive-table">
                                                            <table id="pendingOrdersTable" class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th><i class="fas fa-hashtag mr-1"></i> Mã Đơn Hàng</th>
                                                                        <th><i class="fas fa-calendar-alt mr-1"></i> Ngày Đặt Hàng</th>
                                                                        <th><i class="fas fa-money-bill-wave mr-1"></i> Tổng Số Tiền</th>
                                                                        <th><i class="fas fa-credit-card mr-1"></i> Phương Thức Thanh Toán</th>
                                                                        <th><i class="fas fa-map-marker-alt mr-1"></i> Địa Chỉ Giao Hàng</th>
                                                                        <th><i class="fas fa-info-circle mr-1"></i> Chi Tiết</th>
                                                                        <th><i class="fas fa-check-circle mr-1"></i> Xác nhận</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="pendingOrdersBody">
                                                                    <c:forEach var="order" items="${orders}">
                                                                        <tr>
                                                                            <td>${order.orderCode}</td>
                                                                            <td>${order.orderDate}</td>
                                                                            <td><strong>${order.totalAmount}</strong></td>
                                                                            <td>${order.paymentMethod}</td>
                                                                            <td>${order.shippingAddress}</td>
                                                                            <td>
                                                                                <a href="orderDetail?orderId=${order.orderId}" class="action-link">
                                                                                    <i class="fas fa-eye mr-1"></i> Chi Tiết
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <a href="confirmOrder?orderId=${order.orderId}&pageStr=${currentPage}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                                                   class="action-link">
                                                                                    <c:choose>
                                                                                        <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                                                            <i class="fas fa-check mr-1"></i> Xác nhận
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <i class="fas fa-truck-loading mr-1"></i> Nhận đơn
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <!-- Phân trang cho đơn hàng -->
                                                        <div class="pagination">
                                                            <c:if test="${currentPage > 1}">
                                                                <a href="allUserOrder?pageStr=1&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« Đầu</a>
                                                            </c:if>

                                                            <c:if test="${currentPage > 3}">
                                                                <span>...</span>
                                                            </c:if>

                                                            <c:if test="${currentPage > 1}">
                                                                <a href="allUserOrder?pageStr=${currentPage - 1}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« Trước</a>
                                                            </c:if>

                                                            <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}" varStatus="status">
                                                                <c:if test="${i > 0 && i <= totalPages}">
                                                                    <a href="allUserOrder?pageStr=${i}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" class="${i == currentPage ? 'active' : ''}">
                                                                        ${i}
                                                                    </a>
                                                                </c:if>
                                                            </c:forEach>

                                                            <c:if test="${currentPage < totalPages - 2}">
                                                                <span>...</span>
                                                            </c:if>

                                                            <c:if test="${currentPage < totalPages}">
                                                                <a href="allUserOrder?pageStr=${currentPage + 1}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Sau »</a>
                                                            </c:if>

                                                            <c:if test="${currentPage < totalPages}">
                                                                <a href="allUserOrder?pageStr=${totalPages}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Cuối »</a>
                                                            </c:if>
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
                </div>
            </div> 
        </div>    
        <!-- FOOTER -->
        <jsp:include page="footerAdmin.jsp"/>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
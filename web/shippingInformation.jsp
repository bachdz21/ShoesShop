<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin vận chuyển</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
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
            :root {
                --primary-color: #4285f4;
                --secondary-color: #f8f9fa;
                --accent-color: #34a853;
                --danger-color: #ea4335;
                --text-color: #333;
                --border-color: #e0e0e0;
            }
            :root {
                --primary-color: #d32f2f;
                --primary-light: #ffcdd2;
                --primary-dark: #b71c1c;
                --secondary-color: #f8f9fa;
                --text-color: #333;
                --border-color: #e0e0e0;
                --success-color: #689f38;
                --light-gray: #f5f5f5;
            }



            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Roboto', Arial, sans-serif;
            }

            body {
                background-color: #f8f9fa;
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }

            header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            h1 {
                color: red;
                font-size: 28px;
                margin-bottom: 10px;
            }

            h2 {
                color: var(--text-color);
                font-size: 20px;
                margin: 25px 0 15px 0;
                padding-bottom: 8px;
                border-bottom: 1px solid var(--border-color);
            }

            .info-card {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }

            .info-item {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .info-item i {
                margin-right: 10px;
                color: red;
                width: 20px;
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
            }

            th {
                background-color: red;
                color: white;
                font-weight: 500;
            }

            tr:nth-child(even) {
                background-color: var(--secondary-color);
            }

            tr:hover {
                background-color: rgba(66, 133, 244, 0.05);
            }

            .status-pill {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 50px;
                font-size: 14px;
                font-weight: 500;
                background-color: #e0e0e0;
            }

            .form-container {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                font-size: 16px;
            }

            .button {
                display: inline-block;
                padding: 10px 20px;
                margin: 5px;
                background-color: red;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.2s;
            }

            .button:hover {
                background-color: #3367d6;
            }

            .button-success {
                background-color: var(--accent-color);
            }

            .button-success:hover {
                background-color: #2d9247;
            }

            .button-danger {
                background-color: var(--danger-color);
            }

            .button-danger:hover {
                background-color: #d33426;
            }

            .empty-state {
                text-align: center;
                padding: 30px;
                color: #757575;
                font-style: italic;
            }

            .btn-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 15px;
            }

            .back-btn {
                display: inline-flex;
                align-items: center;
                padding: 10px 15px;
                background-color: red;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 500;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                margin-bottom: 10px;

            }

            .back-btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .back-btn i {
                margin-right: 8px;
            }

            .btn-wrapper {
                display: flex;
                gap: 10px; /* Tạo khoảng cách giữa các form */
                align-items: center; /* Canh các phần tử trên cùng một hàng */
            }

            .btn-container {
                display: flex;
                gap: 10px;
            }

            .button {
                flex: 1; /* Để các nút có kích thước đều nhau */
                padding: 10px 20px;
                background-color: #4285f4; /* Màu xanh dương cho nút cập nhật */
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                text-align: center;
                transition: background-color 0.2s;
            }

            .button:hover {
                background-color: #3367d6;
            }

            .button-danger {
                background-color: #ea4335; /* Màu đỏ */
            }

            .button-danger:hover {
                background-color: #d33426;
            }

            .button-success {
                background-color: #34a853; /* Màu xanh lá */
            }

            .button-success:hover {
                background-color: #2d9247;
            }


            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .button {
                    width: 100%;
                    margin: 5px 0;
                }

                .btn-container {
                    flex-direction: column;
                }
            }

            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
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
                            <h6 style="color: red; margin-top: 20px" class="mb-0"><%= user.getUsername() %></h6>
                            <span style="color: red">Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Danh Sách</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="getAllOrders" class="dropdown-item">Danh Sách Đơn Hàng</a>
                                <a href="list" class="dropdown-item">Danh Sách Sản Phẩm</a>
                                <a href="#" class="dropdown-item">Khác</a>
                            </div>
                        </div>
                        <a href="getRevenueLastNDays?numberOfDays=7" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Biểu Đồ</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Hoạt Động</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="activeCustomers" class="dropdown-item">Hoạt Động Khách Hàng</a>
                                <a href="customerBehavior" class="dropdown-item">Sản Phẩm Ưa Chuộng</a>
                            </div>
                        </div>
                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Quản Lý Đơn Hàng</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="allUserOrder" class="dropdown-item">Đơn Hàng Chờ Xác Nhân</a>
                                <a href="userOrder" class="dropdown-item active">Đơn Hàng Đã Duyệt</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
           <!-- Sidebar End --> 
           
        <div style="background-color: white;width: 100%; margin-left: 230px; margin-top: -20px" class="content"> 
            <jsp:include page="headerAdmin.jsp"/>  
            <div class="container-fluid pt-4 px-4">
                <div class="container">
                    <header>
                        <h1><i class="fas fa-shipping-fast"></i> Thông tin vận chuyển</h1>
                    </header>

                    <div class="nav-buttons">
                        <a href="./orderDetail?orderId=${order.orderId}" class="back-btn">
                            <i class="fas fa-receipt"></i> Chi tiết đơn hàng
                        </a>
                        <a href="./userOrder" class="back-btn">
                            <i class="fas fa-arrow-circle-right"></i>  danh sách đơn hàng
                        </a>
                    </div>

                    <!-- Thông tin Shipper -->
                    <div class="info-card">
                        <h2><i class="fas fa-user-circle"></i> Shipper phụ trách</h2>
                        <div class="info-item">
                            <i class="fas fa-user"></i>
                            <span><strong>Họ tên:</strong> ${shipper.fullName}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-phone"></i>
                            <span><strong>Số điện thoại:</strong> ${shipper.phoneNumber}</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-envelope"></i>
                            <span><strong>Email:</strong> ${shipper.email}</span>
                        </div>
                    </div>

                    <!-- Danh sách trạng thái vận chuyển -->
                    <h2><i class="fas fa-list-alt"></i> Lịch sử trạng thái vận chuyển</h2>
                    <c:if test="${not empty shippingList}">
                        <table>
                            <thead>
                                <tr>
                                    <th><i class="far fa-calendar-alt"></i> Ngày vận chuyển</th>
                                    <th><i class="fas fa-info-circle"></i> Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="shipping" items="${shippingList}">
                                    <tr>
                                        <td>${shipping.shippingDate}</td>
                                        <td>
                                            <span class="status-pill
                                                  <c:choose>
                                                      <c:when test="${shipping.shippingStatus == 'Delivered'}">button-success</c:when>
                                                      <c:when test="${shipping.shippingStatus == 'Cancelled'}">button-danger</c:when>
                                                      <c:otherwise></c:otherwise>
                                                  </c:choose>
                                                  ">
                                                ${shipping.shippingStatus}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty shippingList}">
                        <div class="empty-state">
                            <i class="fas fa-box-open fa-3x"></i>
                            <p>Chưa có thông tin vận chuyển cho đơn hàng này.</p>
                        </div>
                    </c:if>

                    <!-- Form cập nhật trạng thái vận chuyển -->
                    <c:if test="${order.orderStatus != 'Delivered' and order.orderStatus != 'Cancelled' and sessionScope.user.role == 'Shipper'}">
                        <div class="form-container">
                            <h2><i class="fas fa-pen"></i> Cập nhật trạng thái giao hàng</h2>
                            <form action="addShippingInformation" method="post">
                                <input type="hidden" name="orderId" value="${orderId}">
                                <input type="hidden" name="userId" value="${shipper.userId}">

                                <div class="form-group">
                                    <label for="reason"><i class="fas fa-comment"></i> Lý do:</label>
                                    <input type="text" id="reason" name="reason" class="form-control" required placeholder="Nhập lý do cập nhật trạng thái">
                                </div>

                                <div class="btn-container">
                                    <button type="submit" name="status" value="" class="button">
                                        <i class="fas fa-sync-alt"></i> Cập nhật thông tin
                                    </button>
                                    <button type="submit" name="status" value="Cancelled" class="button button-danger">
                                        <i class="fas fa-times-circle"></i> Giao hàng không thành công
                                    </button>
                                </div>
                            </form>

                            <form action="addShippingInformation" method="post" style="margin-top: 15px;">
                                <input type="hidden" name="orderId" value="${orderId}">
                                <input type="hidden" name="userId" value="${shipper.userId}">
                                <input type="hidden" name="reason" value="">

                                <button type="submit" name="status" value="Delivered" class="button button-success" style="width: 100%;">
                                    <i class="fas fa-check-circle"></i> Giao hàng thành công
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
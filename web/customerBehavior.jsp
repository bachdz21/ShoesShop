<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hành Vi Khách Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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

        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: white;
            margin: 0;
            padding: 30px;
            color: #333;
        }
        h1 {
            text-align: center;
            color: #d32f2f; /* Đỏ đậm */
            font-size: 2.5em;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        h2 {
            color: #c62828; /* Đỏ nhạt hơn */
            font-size: 1.8em;
            margin-top: 40px;
            border-bottom: 2px solid #ef5350; /* Đường viền đỏ */
            padding-bottom: 10px;
            text-align: center;
        }
        .filter-container {
            margin-bottom: 30px;
            text-align: center;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .filter-container label {
            font-weight: bold;
            color: #d32f2f;
            margin-right: 10px;
        }
        .filter-container input[type="date"] {
            padding: 8px;
            margin: 0 15px;
            border: 2px solid #ef5350;
            border-radius: 5px;
            font-size: 1em;
        }
        .filter-container button {
            padding: 10px 25px;
            background-color: #d32f2f; /* Đỏ đậm */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .filter-container button:hover {
            background-color: #b71c1c; /* Đỏ tối hơn khi hover */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #ffcdd2; /* Đỏ rất nhạt */
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #d32f2f; /* Đỏ đậm cho header */
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background-color: #ffebee; /* Đỏ cực nhạt */
        }
        tr:hover {
            background-color: #ffcccb; /* Đỏ nhạt khi hover */
            transition: background-color 0.2s ease;
        }
        td {
            color: #555;
        }
        .chart-container {
            margin-top: 40px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
            .sidebar {
                position: fixed;
                margin-top: 0px;
                width: 278px;
                height: 100vh;
                overflow-y: auto;
                background-color: #191c24;
                transition: 0.5s;
                z-index: 999;
            }
            
            .content {
                min-height: 80vh;
                background: #ffffff;
                transition: 0.5s;
                width: 1600px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
    <div style="margin-left: -24px;margin-top: -30px; width: 1838px" class="container-fluid position-relative d-flex p-0">   
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
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Hoạt Động</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="activeCustomers" class="dropdown-item">Hoạt Động Khách Hàng</a>
                                <a href="customerBehavior" class="dropdown-item active">Sản Phẩm Ưa Chuộng</a>
                            </div>
                        </div>
                            <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Trang</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="#" class="dropdown-item">Sign In</a>
                                <a href="#" class="dropdown-item">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
           <!-- Sidebar End --> 
           
    <div style="margin-left: 270px" class="content"> 
        <jsp:include page="headerAdmin.jsp"/>  
        <div class="container-fluid pt-4 px-4">
            <h1>Sản Phẩm Ưa Chuộng</h1>
            <div class="filter-container">
                <form action="customerBehavior" method="get">
                    <label for="start-date">Từ ngày:</label>
                    <input type="date" id="start-date" name="startDate" value="${param.startDate}">
                    <label for="end-date">Đến ngày:</label>
                    <input type="date" id="end-date" name="endDate" value="${param.endDate}">
                    <button type="submit">Lọc</button>
                </form>
            </div>

            <!-- Sản Phẩm Được Thêm Vào Giỏ Hàng Nhiều Nhất -->
            <h2>Sản Phẩm Được Thêm Vào Giỏ Hàng Nhiều Nhất</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Số Giỏ Hàng</th>
                        <th>Thương Hiệu</th>
                        <th>Tổng Số Lượng</th> <!-- Đổi từ "Số Lượng Trung Bình" thành "Tổng Số Lượng" -->
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty cartStats}">
                            <tr>
                                <td colspan="4">Không có dữ liệu trong khoảng thời gian này.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="cartStat" items="${cartStats}">
                                <tr>
                                    <td>${cartStat.productName}</td>
                                    <td>${cartStat.addToCartCount}</td>
                                    <td>${cartStat.brand}</td>
                                    <td><fmt:formatNumber value="${cartStat.totalQuantity}" maxFractionDigits="0"/></td> <!-- Đổi avgQuantity thành totalQuantity -->
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>


            <!-- Sản Phẩm Được Yêu Thích Nhất -->
            <h2>Sản Phẩm Được Yêu Thích Nhất</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Số Lần Thêm Vào Danh Sách Yêu Thích</th>
                        <th>Danh Mục</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="wishlistStat" items="${wishlistStats}">
                        <tr>
                            <td>${wishlistStat.productName}</td>
                            <td>${wishlistStat.wishlistCount}</td>
                            <td>${wishlistStat.categoryName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Đánh Giá Sản Phẩm -->
            <h2>Đánh Giá Sản Phẩm</h2>
            <table>
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Điểm Đánh Giá Trung Bình</th>
                        <th>Số Lượt Đánh Giá</th>
                        <th>Tỷ Lệ Hài Lòng (%)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="reviewStat" items="${reviewStats}">
                        <tr>
                            <td>${reviewStat.productName}</td>
                            <td><fmt:formatNumber value="${reviewStat.avgRating}" maxFractionDigits="1"/></td>
                            <td>${reviewStat.reviewCount}</td>
                            <td><fmt:formatNumber value="${reviewStat.satisfactionRate}" maxFractionDigits="2"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
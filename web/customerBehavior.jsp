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
    <!-- jQuery UI for slider -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
    
    <!-- Favicon and other styles -->
    <link href="img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    <link href="css/bootstrap.min_1.css" rel="stylesheet">
    <link href="css/style_1.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
    <link rel="stylesheet" href="css/font-awesome.min.css">

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
            color: #d32f2f;
            font-size: 2.5em;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        h2 {
            color: #c62828;
            font-size: 1.8em;
            margin-top: 40px;
            border-bottom: 2px solid #ef5350;
            padding-bottom: 10px;
            text-align: center;
        }
        .filter-container {
            margin-bottom: 20px;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .filter-container label {
            font-weight: bold;
            color: #d32f2f;
            margin-right: 10px;
        }
        .filter-container input, .filter-container select {
            padding: 8px;
            margin: 0 10px;
            border: 2px solid #ef5350;
            border-radius: 5px;
            font-size: 1em;
        }
        .filter-container button {
            padding: 8px 20px;
            background-color: #d32f2f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        .filter-container button:hover {
            background-color: #b71c1c;
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
            border: 1px solid #ffcdd2;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #d32f2f;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
        }
        tr:nth-child(even) {
            background-color: #ffebee;
        }
        tr:hover {
            background-color: #ffcccb;
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
        .slider-container {
            margin: 15px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .slider-container label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
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
            width: 1236px;
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
        .filter-row {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 10px;
        }
        .filter-group {
            margin-right: 15px;
            margin-bottom: 10px;
        }
        .table-container {
            max-height: 500px;
            overflow-y: auto;
            margin-bottom: 30px;
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
    <body style="overflow-x: hidden">
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
                
                <!-- Bảng Sản Phẩm Được Thêm Vào Giỏ Hàng Nhiều Nhất -->
                <div class="section-container">
                    <h2>Sản Phẩm Được Thêm Vào Giỏ Hàng Nhiều Nhất</h2>
                    
                    <div class="filter-container">
                        <form id="cartFilterForm" method="get" action="customerBehavior">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label for="cartProductName">Tên sản phẩm:</label>
                                    <input type="text" id="cartProductName" name="cartProductName" placeholder="Nhập tên sản phẩm">
                                </div>
                                
                                <div class="filter-group">
                                    <button type="button" onclick="filterCartTable()">Lọc</button>
                                </div>
                            </div>
                            
                            <div class="slider-container">
                                <label for="cartItemsSlider">Số lượng hiển thị: <span id="cartItemsValue">10</span></label>
                                <div id="cartItemsSlider"></div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="table-container">
                        <table id="cartTable">
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Số Giỏ Hàng</th>
                                    <th>Thương Hiệu</th>
                                    <th>Tổng Số Lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty cartStats}">
                                        <tr>
                                            <td colspan="4">Không có dữ liệu.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="cartStat" items="${cartStats}" varStatus="loop">
                                            <tr class="cart-row" <c:if test="${loop.index >= 10}">style="display:none"</c:if>>
                                                <td>${cartStat.productName}</td>
                                                <td>${cartStat.addToCartCount}</td>
                                                <td>${cartStat.brand}</td>
                                                <td><fmt:formatNumber value="${cartStat.totalQuantity}" maxFractionDigits="0"/></td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Bảng Sản Phẩm Được Yêu Thích Nhất -->
                <div class="section-container">
                    <h2>Sản Phẩm Trong Danh Sách Ưa Thích</h2>
                    
                    <div class="filter-container">
                        <form id="wishlistFilterForm" method="get" action="customerBehavior">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label for="wishlistProductName">Tên sản phẩm:</label>
                                    <input type="text" id="wishlistProductName" name="wishlistProductName" placeholder="Nhập tên sản phẩm">
                                </div>
                                
                                <div class="filter-group">
                                    <button type="button" onclick="filterWishlistTable()">Lọc</button>
                                </div>
                            </div>
                            
                            <div class="slider-container">
                                <label for="wishlistItemsSlider">Số lượng hiển thị: <span id="wishlistItemsValue">10</span></label>
                                <div id="wishlistItemsSlider"></div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="table-container">
                        <table id="wishlistTable">
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Số Lần Thêm Vào Danh Sách Yêu Thích</th>
                                    <th>Danh Mục</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="wishlistStat" items="${wishlistStats}" varStatus="loop">
                                    <tr class="wishlist-row" <c:if test="${loop.index >= 10}">style="display:none"</c:if>>
                                        <td>${wishlistStat.productName}</td>
                                        <td>${wishlistStat.wishlistCount}</td>
                                        <td>${wishlistStat.categoryName}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Bảng Đánh Giá Sản Phẩm -->
                <div class="section-container">
                    <h2>Đánh Giá Sản Phẩm</h2>
                    
                    <div class="filter-container">
                        <form id="reviewFilterForm" method="get" action="customerBehavior">
                            <div class="filter-row">
                                <div class="filter-group">
                                    <label for="reviewProductName">Tên sản phẩm:</label>
                                    <input type="text" id="reviewProductName" name="reviewProductName" placeholder="Nhập tên sản phẩm">
                                </div>
                                
                                <div class="filter-group">
                                    <label for="minRating">Điểm từ:</label>
                                    <select id="minRating" name="minRating">
                                        <option value="0">Tất cả</option>
                                        <option value="1">1 sao</option>
                                        <option value="2">2 sao</option>
                                        <option value="3">3 sao</option>
                                        <option value="4">4 sao</option>
                                        <option value="5">5 sao</option>
                                    </select>
                                </div>
                                
                                <div class="filter-group">
                                    <label for="minReviews">Số đánh giá từ:</label>
                                    <input type="number" id="minReviews" name="minReviews" min="0" placeholder="0">
                                </div>
                                
                                <div class="filter-group">
                                    <button type="button" onclick="filterReviewTable()">Lọc</button>
                                </div>
                            </div>
                            
                            <div class="slider-container">
                                <label for="reviewItemsSlider">Số lượng hiển thị: <span id="reviewItemsValue">10</span></label>
                                <div id="reviewItemsSlider"></div>
                            </div>
                        </form>
                    </div>
                    
                    <div class="table-container">
                        <table id="reviewTable">
                            <thead>
                                <tr>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Điểm Đánh Giá Trung Bình</th>
                                    <th>Số Lượt Đánh Giá</th>
                                    <th>Tỷ Lệ Hài Lòng (%)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="reviewStat" items="${reviewStats}" varStatus="loop">
                                    <tr class="review-row" <c:if test="${loop.index >= 10}">style="display:none"</c:if>>
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
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // Khởi tạo slider cho bảng giỏ hàng
            $("#cartItemsSlider").slider({
                range: "min",
                min: 1,
                max: 50,
                value: 10,
                slide: function(event, ui) {
                    $("#cartItemsValue").text(ui.value);
                    updateTableRows('.cart-row', ui.value);
                }
            });
            
            // Khởi tạo slider cho bảng yêu thích
            $("#wishlistItemsSlider").slider({
                range: "min",
                min: 1,
                max: 50,
                value: 10,
                slide: function(event, ui) {
                    $("#wishlistItemsValue").text(ui.value);
                    updateTableRows('.wishlist-row', ui.value);
                }
            });
            
            // Khởi tạo slider cho bảng đánh giá
            $("#reviewItemsSlider").slider({
                range: "min",
                min: 1,
                max: 50,
                value: 10,
                slide: function(event, ui) {
                    $("#reviewItemsValue").text(ui.value);
                    updateTableRows('.review-row', ui.value);
                }
            });
            
            // Khôi phục giá trị filter từ URL nếu có
            restoreFilterValues();
        });
        
        function updateTableRows(selector, count) {
            $(selector).each(function(index) {
                $(this).toggle(index < count);
            });
        }
        
        function filterCartTable() {
            const productName = $("#cartProductName").val().toLowerCase();
            
            $(".cart-row").each(function() {
                const rowProductName = $(this).find("td:eq(0)").text().toLowerCase();
                
                const nameMatch = productName === "" || rowProductName.includes(productName);
                
                $(this).toggle(nameMatch);
            });
        }
        
        function filterWishlistTable() {
            const productName = $("#wishlistProductName").val().toLowerCase();
            
            $(".wishlist-row").each(function() {
                const rowProductName = $(this).find("td:eq(0)").text().toLowerCase();
                
                const nameMatch = productName === "" || rowProductName.includes(productName);
                
                $(this).toggle(nameMatch);
            });
        }
        
        function filterReviewTable() {
            const productName = $("#reviewProductName").val().toLowerCase();
            const minRating = parseFloat($("#minRating").val());
            const minReviews = parseInt($("#minReviews").val()) || 0;
            
            $(".review-row").each(function() {
                const rowProductName = $(this).find("td:eq(0)").text().toLowerCase();
                const rowRating = parseFloat($(this).find("td:eq(1)").text());
                const rowReviews = parseInt($(this).find("td:eq(2)").text());
                
                const nameMatch = productName === "" || rowProductName.includes(productName);
                const ratingMatch = rowRating >= minRating;
                const reviewsMatch = rowReviews >= minReviews;
                
                $(this).toggle(nameMatch && ratingMatch && reviewsMatch);
            });
        }
        
        function restoreFilterValues() {
            // Lấy tham số từ URL
            const urlParams = new URLSearchParams(window.location.search);
            
            // Khôi phục giá trị cho bảng giỏ hàng
            if(urlParams.has('cartProductName')) {
                $("#cartProductName").val(urlParams.get('cartProductName'));
            }
            
            // Khôi phục giá trị cho bảng yêu thích
            if(urlParams.has('wishlistProductName')) {
                $("#wishlistProductName").val(urlParams.get('wishlistProductName'));
            }
            
            // Khôi phục giá trị cho bảng đánh giá
            if(urlParams.has('reviewProductName')) {
                $("#reviewProductName").val(urlParams.get('reviewProductName'));
            }
            if(urlParams.has('minRating')) {
                $("#minRating").val(urlParams.get('minRating'));
            }
            if(urlParams.has('minReviews')) {
                $("#minReviews").val(urlParams.get('minReviews'));
            }
            
            // Áp dụng filter sau khi khôi phục giá trị
            filterCartTable();
            filterWishlistTable();
            filterReviewTable();
        }
        

    </script>
    
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
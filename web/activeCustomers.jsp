<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Khách Hàng Hoạt Động Nhiều Nhất</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
<!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f9e6e6; /* Nền đỏ nhạt */
            padding: 20px;
            margin: 0;
            color: #333;
        }
        .container-fluid {
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #d32f2f; /* Đỏ đậm */
            font-size: 2.5rem;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        h2 {
            color: #c62828;
            font-size: 1.8rem;
            margin-top: 40px;
            text-align: center;
            border-bottom: 2px solid #ef5350;
            padding-bottom: 10px;
        }
        .table {
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .table thead th {
            background-color: red;
            color: #fff;
            text-transform: uppercase;
            font-weight: 500;
        }
        .table tbody tr:nth-child(even) {
            background-color: #ffebee;
        }
        .table tbody tr:hover {
            background-color: #ffcccb;
            transition: background-color 0.2s;
        }
        .customer-row {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .customer-card {
            background-color: #fff;
            border: 2px solid #ef5350;
            border-radius: 10px;
            padding: 15px;
            width: 200px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .customer-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        .customer-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
            border: 2px solid #d32f2f;
        }
        .customer-card h5 {
            font-size: 1.1rem;
            color: #d32f2f;
            margin: 5px 0;
        }
        .customer-card p {
            font-size: 0.9rem;
            color: #666;
            margin: 3px 0;
        }
        .btn-primary, .btn-success {
            margin: 5px;
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
        .filter-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            text-align: center;
        }
        .filter-container .form-control, .filter-container select {
            display: inline-block;
            width: auto;
            margin: 0 10px;
            border: 2px solid #ef5350;
            border-radius: 5px;
        }
        .filter-container .btn-primary {
            background-color: #d32f2f;
            border: none;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        .filter-container .btn-primary:hover {
            background-color: #b71c1c;
        }
        .filter-container .btn-success {
            background-color: #4CAF50;
            border: none;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
        .filter-container .btn-success:hover {
            background-color: #45a049;
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
    <div style="margin-left: 6px;margin-top: -21px" class="container-fluid position-relative d-flex p-0">   
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
                                <a href="activeCustomers" class="dropdown-item active">Hoạt Động Khách Hàng</a>
                                <a href="customerBehavior" class="dropdown-item">Sản Phẩm Ưa Chuộng</a>
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
            <h1>Danh Sách Hoạt Động Khách Hàng</h1>
            <div class="filter-container">
                <form action="activeCustomers" method="get">
                    <input type="text" id="search" name="search" placeholder="Tìm kiếm khách hàng..." class="form-control mb-3" style="width: 300px; margin: auto; background-color: white" value="${param.search}">
                    <label for="start-date">Từ ngày:</label>
                    <input type="date" id="start-date" name="start_date" class="form-control d-inline-block" style="width: 200px; background-color: white" value="${param.start_date}">
                    <label for="end-date">Đến ngày:</label>
                    <input type="date" id="end-date" name="end_date" class="form-control d-inline-block" style="width: 200px; background-color: white" value="${param.end_date}">
                    <select id="sort-by" name="sort_by" class="form-control d-inline-block" style="width: 250px;">
                        <option value="total_activity" ${param.sort_by == 'total_activity' || param.sort_by == null ? 'selected' : ''}>Sắp xếp theo tổng hoạt động</option>
                        <option value="total_orders" ${param.sort_by == 'total_orders' ? 'selected' : ''}>Sắp xếp theo số đơn hàng</option>
                    </select>
                    <button type="submit" class="btn btn-primary">Lọc</button>
                </form>
                <form action="activeCustomers" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-success">Xuất Dữ Liệu</button>
                </form>
            </div>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <table class="table table-bordered">
                <thead style="background-color: red">
                    <tr>
                        <th>Khách Hàng</th>
                        <th>Số Đơn Hàng</th>
                        <th>Số Sản Phẩm Trong Giỏ</th>
                        <th>Tổng Hoạt Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr style="color: black">
                            <td>${customer.fullName}</td>
                            <td>${customer.totalOrders}</td>
                            <td>${customer.cartItemsCount}</td>
                            <td>${customer.totalOrders + customer.cartItemsCount}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Chart Section -->
            <div class="chart-container">
                <h2>Biểu Đồ Hoạt Động Khách Hàng</h2>
                <canvas id="customerActivityChart"></canvas>
            </div> 
                
            <!-- Top 3 Frequent Customers -->
            <div class="top-customers">
                <h2 style="text-align: center">Khách Hàng Hoạt Động Nhiều Nhất</h2>
                <div class="customer-row">
                    <c:forEach var="customer" items="${customers}" begin="0" end="2" varStatus="loop">
                        <div class="customer-card">
                            <img src="${customer.profileImageURL != null && !customer.profileImageURL.isEmpty() ? customer.profileImageURL : './img/default-avarta.jpg'}" 
                                 alt="Avatar" class="customer-avatar">
                            <h5>${customer.fullName}</h5>
                            <p>Tổng Hoạt Động: ${customer.totalOrders + customer.cartItemsCount}</p>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- New Customers -->
            <div class="new-customers">
                <h2 style="text-align: center">Khách Hàng Mới</h2>
                <div class="customer-row">
                    <c:forEach var="customer" items="${newCustomers}" begin="0" end="4" varStatus="loop">
                        <div class="customer-card">
                            <img src="${customer.profileImageURL != null && !customer.profileImageURL.isEmpty() ? customer.profileImageURL : './img/default-avarta.jpg'}" 
                                 alt="Avatar" class="customer-avatar">
                            <h5>${customer.fullName}</h5>
                            <p>Ngày Đăng Ký: <fmt:formatDate value="${customer.registrationDate}" pattern="dd-MM-yyyy"/></p>
                            <p>Tổng Hoạt Động: ${customer.totalOrders + customer.cartItemsCount}</p>
                        </div>
                    </c:forEach>
                </div>
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
<script>
        document.addEventListener('DOMContentLoaded', function () {
            // Lấy dữ liệu từ JSTL để vẽ biểu đồ (top 5 khách hàng)
            const customerNames = [
                <c:forEach var="customer" items="${customers}" begin="0" end="4" varStatus="loop">
                    "${customer.fullName}"${loop.last ? '' : ','}
                </c:forEach>
            ];
            const customerActivities = [
                <c:forEach var="customer" items="${customers}" begin="0" end="4" varStatus="loop">
                    ${customer.totalOrders + customer.cartItemsCount}${loop.last ? '' : ','}
                </c:forEach>
            ];

            const ctx = document.getElementById('customerActivityChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar', // Loại biểu đồ: cột
                data: {
                    labels: customerNames, // Tên khách hàng
                    datasets: [{
                        label: 'Tổng Hoạt Động',
                        data: customerActivities, // Tổng hoạt động
                        backgroundColor: '#d32f2f', // Màu đỏ đậm
                        borderColor: '#b71c1c', // Viền đỏ tối
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Số Hoạt Động'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Khách Hàng'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Top 5 Khách Hàng Hoạt Động Nhiều Nhất'
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
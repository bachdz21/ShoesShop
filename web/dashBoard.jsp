<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <title>Dashboard</title>

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
        .sidebar {
            position: fix;
 
            height: 100vh;
            overflow-y: auto;
            background: var(--secondary);
            transition: 0.5s;
            z-index: 999;
        }

        .content {
            margin-left: 125px;
            margin-right: 20px;
            margin-top: 0px;
            min-height: 100vh;
            background: #ffffff;
            transition: 0.5s;
            width: 91.5%;
        }
        

        #top-header {
            width: 1850px;
        }

        h1, h2, h3, h4, h5, h6 {
          color: #eb1616;
          font-weight: 700;
          margin: 0 0 10px;
        }

        a {
          color: #eb1616;
          font-weight: 500;
          -webkit-transition: 0.2s color;
          transition: 0.2s color;
        }
        body{
            overflow-x: hidden;
        }

        .bg-secondary {
            display: block !important;
        }

            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
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
    <%@page import="jakarta.servlet.http.HttpSession"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
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
            <!-- Spinner Start 
            <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">

                    <div class="navbar-nav w-100">
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
                        <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
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
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Đơn Hàng</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="allUserOrder" class="dropdown-item">Đơn Hàng Chờ Xác Nhân</a>
                                <a href="userOrder" class="dropdown-item">Đơn Hàng Đã Duyệt</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
           <!-- Sidebar End --> 
            

            <!-- Content Start -->
            <div class="content">
        <div style="background-color: white" class="content"> 
            <div>
                <nav style="border-radius: 0 0 0 0" class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                    <a href="home" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0">ShoeShop</h2>
                    </a>

                    <div class="navbar-nav align-items-center ms-auto">
                        <div style="margin-left: 750px" class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-envelope me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Message</span>
                            </a>
                            <div class="dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-bell me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Notification</span>
                            </a>
                            <div class="dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex"><%= user.getUsername() %></span>
                            </a>
                            <div class=" dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">

                            </div>
                        </div>
                    </div>
                </nav>
            </div>
                <!-- Sale & Revenue Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-sm-3 col-xl-2">
                            <div style="border-style: solid; border-width: 2px" class="bg-white rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-line fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Đã bán hôm nay</p>
                                    <h6 class="mb-0"><fmt:formatNumber value="${requestScope.todaySale}" type="number" maxFractionDigits="0" /></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div style="border-style: solid; border-width: 2px" class="bg-white rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-bar fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Tổng số đã bán</p>
                                    <h6 class="mb-0"><fmt:formatNumber value="${requestScope.totalSale}" type="number" maxFractionDigits="0" /></h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div style="border-style: solid; border-width: 2px" class="bg-white rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-area fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Doanh thu hôm nay</p>
                                    <h6 class="mb-0"><fmt:formatNumber value="${requestScope.todayRevenue}" type="number" groupingUsed="true" maxFractionDigits="0" />đ</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div style="border-style: solid; border-width: 2px" class="bg-white rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-pie fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Tổng doanh thu</p>
                                    <h6 class="mb-0"><fmt:formatNumber value="${requestScope.totalRevenue}" type="number" groupingUsed="true" maxFractionDigits="0" />đ</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Sale & Revenue End -->


                <!-- Sales Chart Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-sm-6 col-xl-3">
                            <div style="border-style: solid; border-width: 2px" class="bg-gradient text-center rounded p-4">
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <h6 class="mb-0">Doanh thu hàng tháng</h6>
                                    <a href="getRevenueLastNDays?numberOfDays=7">Xem tất cả</a> <!-- Link để hiển thị tất cả -->
                                </div>

                                <c:choose>
                                    <c:when test="${isMonthlyRevenue == 'true'}">
                                        <!-- Nếu isMonthlyRevenue là đúng, hiển thị biểu đồ doanh thu hàng tháng -->
                                        <canvas id="monthlyRevenueChart"></canvas>
                                        </c:when>
                                        <c:otherwise>
                                        <!-- Nếu isMonthlyRevenue là sai, hiển thị biểu đồ doanh thu hàng năm -->
                                        <canvas id="yearlyRevenueChart"></canvas>
                                        </c:otherwise>
                                    </c:choose>
                            </div>
                        </div>
                        <div class="col-sm-6 col-xl-3">
                            <div style="border-style: solid; border-width: 2px;" class="bg-gradient text-center rounded p-4">
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <h6 class="mb-0">Doanh thu các mặt hàng</h6>
<!--                                    <a href="getRevenueLastNDays?numberOfDays=7">Xem tất cả</a>-->
                                </div>
                                <canvas style="margin-bottom: 7px" id="worldwide-sales"></canvas>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <!-- Sales Chart End -->
      
            </div>
            <!-- Content End -->
        </div>                  
        </div>
        <jsp:include page="footerAdmin.jsp"/>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <!-- <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>-->
        <script src="js/bootstrap.min.js"></script>
        
        <script>
            // Hàm JavaScript để tự động submit form
            function submitStatusForm(orderId) {
            document.getElementById('statusForm' + orderId).submit();
            }

            // Worldwide Sales Chart
            // 
//            var ctx = $("#monthlyRevenueChart").get(0).getContext("2d");
//            var myChart = new Chart(ctx, {
//                type: "bar",
//                data: {
//                    labels: [<c:forEach var="item" items="${revenueList}">"${item.month}",</c:forEach>],
//                    datasets: [{
//                            label: "USA",
//                            data: [<c:forEach var="item" items="${revenueList}">"${item.totalRevenue}",</c:forEach>],
//                            backgroundColor: "rgba(235, 22, 22, .7)"
//                        },
//                        {
//                            label: "UK",
//                            data: [8, 35, 40, 60, 70, 55, 75],
//                            backgroundColor: "rgba(235, 22, 22, .5)"
//                        },
//                        {
//                            label: "AU",
//                            data: [12, 25, 45, 55, 65, 70, 60],
//                            backgroundColor: "rgba(235, 22, 22, .3)"
//                        }
//                    ]
//                },
//                options: {
//                    responsive: true
//                    
//                }
//            });
            </script>
            <script>
                // Tạo mảng nhãn cho danh mục từ `revenueListByCategories`
                var categoryLabels = [
            <c:forEach var="item" items="${revenueListByCategories}">
                "${item.categoryName}"<c:if test="${!item.categoryName.equals(revenueListByCategories[revenueListByCategories.size()-1].categoryName)}">,</c:if>
            </c:forEach>
                ];
                // Tạo mảng dữ liệu doanh thu cho từng danh mục
                var categoryData = [
            <c:forEach var="item" items="${revenueListByCategories}">
                ${item.totalRevenue}<c:if test="${!item.totalRevenue.equals(revenueListByCategories[revenueListByCategories.size()-1].totalRevenue)}">,</c:if>
            </c:forEach>
                ];
                // Khởi tạo biểu đồ `chart.js` sử dụng dữ liệu từ các mảng đã tạo
                var ctx1 = document.getElementById("worldwide-sales").getContext("2d");
                var myChart1 = new Chart(ctx1, {
                type: "bar",
                        data: {
                        labels: categoryLabels,
                                datasets: [{
                                label: "Doanh thu",
                                        data: categoryData,
                                        backgroundColor: [
                                                "rgba(235, 22, 22, .7)", "rgba(235, 22, 22, .5)",
                                                "rgba(235, 22, 22, .3)", "rgba(22, 235, 22, .5)",
                                                "rgba(22, 22, 235, .5)" // Thêm màu sắc cho các loại sản phẩm
                                        ]
                                }]
                        },
                        options: {
                        responsive: true
                        }
                });
        </script>
        <script>
            var ctx = document.getElementById('monthlyRevenueChart').getContext('2d');
            var revenueData = {
            labels: [<c:forEach var="item" items="${revenueList}">"${item.day}",</c:forEach>],
                    datasets: [{
                    label: 'Doanh Thu',
                            data: [<c:forEach var="item" items="${revenueList}">${item.totalRevenue},</c:forEach>],
                            backgroundColor: 'rgba(235, 22, 22, .7)',
                            borderColor: 'rgba(235, 22, 22, .5)',
                            borderWidth: 1
                    }]
            };
            var myChart = new Chart(ctx, {
            type: 'line',
                    data: revenueData,
                    options: {
                    scales: {
                    y: {
                    beginAtZero: true
                    }
                    }
                    }
            });
            </script>
            <script>
                var ctx = document.getElementById('yearlyRevenueChart').getContext('2d');
                var revenueData = {
                labels: [<c:forEach var="item" items="${revenueList}">"${item.month}",</c:forEach>],
                        datasets: [{
                        label: 'Doanh Thu',
                                data: [<c:forEach var="item" items="${revenueList}">${item.totalRevenue},</c:forEach>],
                                backgroundColor: 'rgba(235, 22, 22, .7)',
                                borderColor: 'rgba(235, 22, 22, .5)',
                                borderWidth: 1
                        }]
                };
                var myChart = new Chart(ctx, {
                type: 'line',
                        data: revenueData,
                        options: {
                        scales: {
                        y: {
                        beginAtZero: true
                        }
                        }
                        }
                });
                
        </script>
        <!-- Template Javascript -->
        <script src="js/main_1.js"></script>
        
    </body>

</html>
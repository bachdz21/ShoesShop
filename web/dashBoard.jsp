<!DOCTYPE html>
<html lang="vi">

    
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <title>Dashboard</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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
        <style>
        .sidebar {
            position: fixed;
            margin-top: 140px;
            width: 250px;
            height: 100vh;
            overflow-y: auto;
            background: var(--secondary);
            transition: 0.5s;
            z-index: 999;
        }

        .content {
            margin-left: -1600px;
            margin-top: 140px;
            min-height: 100vh;
            background: var(--dark);
            transition: 0.5s;
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
            overflow-y: hidden;
            background-color: #191c24
        }

        .bg-secondary {
            display: block !important;
        }
    </style>
    
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
        <div class="container-fluid position-relative d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">
                    <div class="navbar-nav w-100">
                        <a href="dashBoard.jsp" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>List</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="getAllOrders" class="dropdown-item">All Orders List</a>
                                <a href="list" class="dropdown-item">All Products List</a>
                                <a href="element.html" class="dropdown-item">Other</a>
                            </div>
                        </div>
                        <a href="chart.jsp" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Charts</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="signin.html" class="dropdown-item">Sign In</a>
                                <a href="signup.html" class="dropdown-item">Sign Up</a>
                                <a href="404.html" class="dropdown-item">404 Error</a>
                                <a href="blank.jsp" class="dropdown-item">Blank Page</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->
            <jsp:include page="header.jsp" />

            <!-- Content Start -->
            <div class="content">
                <!-- Sale & Revenue Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-sm-3 col-xl-2">
                            <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-line fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Today Sale</p>
                                    <h6 class="mb-0">${requestScope.todaySale}</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-bar fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Total Sale</p>
                                    <h6 class="mb-0">${requestScope.totalSale}</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-area fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Today Revenue</p>
                                    <h6 class="mb-0">$${requestScope.todayRevenue}</h6>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3 col-xl-2">
                            <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
                                <i class="fa fa-chart-pie fa-3x text-primary"></i>
                                <div class="ms-3">
                                    <p class="mb-2">Total Revenue</p>
                                    <h6 class="mb-0">$${requestScope.totalRevenue}</h6>
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
                            <div class="bg-secondary text-center rounded p-4">
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <h6 class="mb-0">Monthly Revenue</h6>
                                    <a href="getRevenueLastNDays?numberOfDays=7">Show All</a> <!-- Link để hiển thị tất cả -->
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
                            <div class="bg-secondary text-center rounded p-4">
                                <div class="d-flex align-items-center justify-content-between mb-4">
                                    <h6 class="mb-0">Sales & Revenue</h6>
                                    <a href="getRevenueLastNDays?numberOfDays=7">Show All</a>
                                </div>
                                <canvas id="worldwide-sales"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Sales Chart End -->




                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">ShoeShop</a>, All Right Reserved. 
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer End -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <!--            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>-->
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
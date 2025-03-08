<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <%@ page contentType="text/html; charset=UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <title>Chart</title>
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
                overflow-x: hidden; 
                background-color: #191c24
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
                        <a href="revenue?year=2025&month=3" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Danh Sách</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="#" class="dropdown-item">Danh sách đơn hàng</a>
                                <a href="list" class="dropdown-item">Danh sách sản phẩm</a>
                                <a href="#" class="dropdown-item">Khác</a>
                            </div>
                        </div>
                        <a href="getRevenueLastNDays?numberOfDays=7" class="nav-item nav-link active"><i class="fa fa-chart-bar me-2"></i>Charts</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="#" class="dropdown-item">Sign In</a>
                                <a href="#" class="dropdown-item">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->

            <jsp:include page="header.jsp" />
            <!-- Content Start -->
            <div style="background-color: white" class="content">
                <!-- Chart Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div style="margin-bottom: 77px" class="col-sm-12 col-xl-6" style="width: 100%; position: relative;">
                            <div class="bg-white rounded h-100 p-4">
                                <h6 class="mb-4">Revenue in: </h6>

                                <div style="display: flex; position: absolute; top: 14px; left: 130px; z-index: 10">
                                    <!-- Form cho số ngày -->
                                    <form id="formDays" action="getRevenueLastNDays" method="GET" style="display:none;">
                                        <input type="hidden" name="numberOfDays" id="daysInput">
                                    </form>

                                    <!-- Form cho năm và tháng -->
                                    <form id="formYear" action="getRevenueByMonthAndYear" method="GET" style="display:none;">
                                        <input type="hidden" name="year" id="yearInput">
                                        <input type="hidden" name="month" id="monthInput">
                                    </form>

                                    <!-- Select lựa chọn ngày hoặc năm -->
                                    <select style="background-color: white; font-size: 15px" id="selectOption" class="form-select" onchange="handleSelectChange(); submitFormBasedOnOption()">
                                        <option value="7" ${selectedOption == '7' ? 'selected' : ''}>7 ngày qua</option>
                                        <option value="14" ${selectedOption == '14' ? 'selected' : ''}>14 ngày qua</option>
                                        <option value="30" ${selectedOption == '30' ? 'selected' : ''}>30 ngày qua</option>
                                        <option value="60" ${selectedOption == '60' ? 'selected' : ''}>60 ngày qua</option>
                                        <option value="2023" ${selectedOption == '2023' ? 'selected' : ''}>Năm 2023</option>
                                        <option value="2024" ${selectedOption == '2024' ? 'selected' : ''}>Năm 2024</option>
                                        <option value="2025" ${selectedOption == '2025' ? 'selected' : ''}>Năm 2025</option>
                                    </select>

                                    <!-- Select tháng, chỉ hiện khi chọn năm -->
                                    <select id="monthSelect" class="form-select" name="month" style="display:none; margin-left: 15px; background-color: white; font-size: 15px" onchange="submitRevenueForm()">
                                        <option value="">-- Chọn tháng --</option>
                                        <c:forEach var="i" begin="1" end="12">
                                            <option value="${i}" ${selectedMonth == i ? 'selected' : ''}>Tháng ${i}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <canvas id="revenueChart" height="100"></canvas>
                            </div>
                        </div>
                        <jsp:include page="footer.jsp" />
                        <!--                    <div class="col-sm-12 col-xl-6">
                                                <div class="bg-secondary rounded h-100 p-4">
                                                    <h6 class="mb-4">Multiple Line Chart</h6>
                                                    <canvas id="salse-revenue"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-sm-12 col-xl-6">
                                                <div class="bg-secondary rounded h-100 p-4">
                                                    <h6 class="mb-4">Single Bar Chart</h6>
                                                    <canvas id="bar-chart"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-sm-12 col-xl-6">
                                                <div class="bg-secondary rounded h-100 p-4">
                                                    <h6 class="mb-4">Multiple Bar Chart</h6>
                                                    <canvas id="worldwide-sales"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-sm-12 col-xl-6">
                                                <div class="bg-secondary rounded h-100 p-4">
                                                    <h6 class="mb-4">Pie Chart</h6>
                                                    <canvas id="pie-chart"></canvas>
                                                </div>
                                            </div>
                                            <div class="col-sm-12 col-xl-6">
                                                <div class="bg-secondary rounded h-100 p-4">
                                                    <h6 class="mb-4">Doughnut Chart</h6>
                                                    <canvas id="doughnut-chart"></canvas>
                                                </div>
                                            </div>-->
                    </div>
                </div>
                <!-- Chart End -->
            </div>
            <!-- Content End -->
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>
        <script>
                                        var ctx = document.getElementById('revenueChart').getContext('2d');
                                        var revenueData = {
                                        labels: [
            <c:forEach var="item" items="${revenueLastNDays}">
                <c:choose>
                    <c:when test="${item.day != 0}">
                                        "${item.day}-${item.month}",
                    </c:when>
                    <c:otherwise>
                                            "${item.month}",
                    </c:otherwise>
                </c:choose>
            </c:forEach>
                                            ]
                                                    ,
                                                    datasets: [{
                                                    label: 'Doanh Thu',
                                                            data: [<c:forEach var="item" items="${revenueLastNDays}">${item.totalRevenue},</c:forEach>],
                                                            backgroundColor: 'rgba(235, 22, 22, .7)',
                                                            borderColor: 'rgba(235, 22, 22, .5)',
                                                            borderWidth: 1
                                                    }]
                                            }
                                            ;
                                            var myChart = new Chart(ctx, {
                                            type: '${chartType}',
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
            function handleSelectChange() {
            const selectOption = document.getElementById("selectOption").value;
            const monthSelect = document.getElementById("monthSelect");
            // Hiển thị select tháng nếu chọn 2023 hoặc 2024, ẩn đi nếu không
            if (selectOption === "2023" || selectOption === "2024" || selectOption === "2025") {
            monthSelect.style.display = "inline";
            } else {
            monthSelect.style.display = "none";
            }
            }

            function submitFormBasedOnOption() {
            const selectedValue = document.getElementById("selectOption").value;
            if (["7", "14", "30", "60"].includes(selectedValue)) {
            // Trường hợp chọn ngày
            document.getElementById("daysInput").value = selectedValue;
            document.getElementById("formDays").submit();
            } else if (["2023", "2024", "2025"].includes(selectedValue)) {
            // Trường hợp chọn năm
            document.getElementById("yearInput").value = selectedValue;
            document.getElementById("formYear").submit();
            }
            }

            function submitFormBasedOnMonth() {
            const selectedYear = document.getElementById("yearInput").value;
            const selectedMonth = document.getElementById("monthSelect").value;
            if (selectedYear && selectedMonth) {
            document.getElementById("monthInput").value = selectedMonth;
            document.getElementById("formYear").submit();
            }
            }


            function submitRevenueForm() {
            // Lấy giá trị của selectOption và monthSelect
            const selectedYear = document.getElementById("selectOption").value;
            const selectedMonth = document.getElementById("monthSelect").value;
            // Tạo form và thiết lập action
            const form = document.createElement("form");
            form.method = "GET";
            form.action = "getRevenueByMonthAndYear";
            const yearInput = document.createElement("input");
            yearInput.type = "hidden";
            yearInput.name = "year";
            yearInput.value = selectedYear;
            form.appendChild(yearInput);
            // Thêm input hidden cho giá trị tháng
            const monthInput = document.createElement("input");
            monthInput.type = "hidden";
            monthInput.name = "month";
            monthInput.value = selectedMonth;
            form.appendChild(monthInput);
            // Thêm form vào document và gửi
            document.body.appendChild(form);
            form.submit();
            }


            window.onload = function() {
            const url = window.location.href;
            if (url.includes("getRevenueByMonthAndYear")) {
            document.getElementById("monthSelect").style.display = "inline";
            }
            };</script>
        <!-- Template Javascript -->
        <script src="js/main_1.js"></script>
    </body>

</html>
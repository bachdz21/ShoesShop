<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>User Profile</title>

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
        <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.3.1/css/all.css'>

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
            /* General styles */
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }

            /* Container */
            .user-profile {
                padding: 20px 0;
            }

            /* Navigation */
            #navigation {
                background-color: #fff;
                border-bottom: 1px solid #e0e0e0;
                margin-bottom: 20px;
            }

            .main-nav {
                margin: 0;
                padding: 10px 0;
            }

            .main-nav li a {
                color: #333;
                font-weight: 500;
                padding: 10px 15px;
                transition: color 0.3s ease;
            }

            .main-nav li a:hover {
                color: #007bff;
            }

            /* Card */
            .card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }

            .card-body {
                padding: 20px;
            }

            /* Form styles */
            .form-inline .form-group {
                margin-bottom: 15px;
                margin-right: 25px;
            }

            .form-control {
                border-radius: 4px;
                border: 1px solid #ced4da;
                padding: 6px 12px;
            }
            .btn-primary {
                background-color: red;
                border-color: red;
                padding: 6px 16px; /* Giảm padding để làm nút thấp hơn */
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .btn-primary:hover {
                background-color: darkred;
                border-color: darkred;
            }


            .dropdown-menu {
                border-radius: 4px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            /* Product list title */
            .product-title {
                font-size: 24px;
                font-weight: 700;
                margin-bottom: 20px;
                color: #333;
            }

            /* Tabs */

            .tab-content {
                border: 1px solid #ddd;
                padding: 20px;
                border-top: none;
            }
            .nav-tabs {
                border-bottom: 1px solid #ddd;
            }

            .nav {
                padding-left: 0;
                margin-bottom: 0;
                list-style: none;
            }
            .nav-tabs .nav-item .nav-link {
                color: black;
                font-weight: bold;
                padding: 10px 20px;
                border-radius: 5px 5px 0 0;
                border: 1px solid #ddd;
            }


            /* Table styles */
            .table-responsive {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }

            th {
                background-color: red;
                font-weight: 700;
                color: white;
            }

            td a {
                color: #007bff;
                text-decoration: none;
            }

            td a:hover {
                text-decoration: underline;
            }

            /* Status colors */
            .status-pending {
                color: #ffc107;
                font-weight: 500;
            }

            .status-shipped {
                color: #17a2b8;
                font-weight: 500;
            }

            .status-delivered {
                color: #28a745;
                font-weight: 500;
            }

            .status-cancelled {
                color: #dc3545;
                font-weight: 500;
            }



            [id$="Pagination"] button {
                margin: 0 5px;
                padding: 5px 10px;
                cursor: pointer;
            }
            [id$="Pagination"] button.active {
                background-color: #007bff;
                color: white;
            }
            [id$="Pagination"] button:disabled {
                cursor: not-allowed;
                opacity: 0.5;
            }

            /* Thêm viền dọc giữa các cột */
            th, td {
                border-right: 1px solid #e0e0e0;
            }
            th:last-child, td:last-child {
                border-right: none; /* Bỏ viền cuối cùng */
            }

            th {
                background-color: red;
                font-weight: 700;
                color: white;
                text-transform: uppercase;
                font-size: 14px;
            }

            /* Hiệu ứng hover cho hàng */
            tbody tr:hover {
                background-color: #f5f5f5;
                transition: background-color 0.3s ease;
            }

            td a {
                color: #007bff;
                text-decoration: none;
            }

            td a:hover {
                text-decoration: underline;
            }


            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }
            .pagination a {
                padding: 8px 12px;
                margin: 0 5px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination a.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }
            .pagination a:hover:not(.active) {
                background-color: #f5f5f5;
            }
            .pagination span {
                padding: 0 10px;
                color: #666;
            }
            /* Style cho nút Trở về */
            .back-btn {
                display: block; /* Đảm bảo nó chiếm toàn bộ chiều ngang để có thể căn phải */
                text-align: right; /* Căn phần tử sang phải */
                padding: 10px 20px;
                background-color: red;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.3s ease;
                margin-left: auto; /* Đẩy sang phải */
                margin-right: 30px; /* Chạm mép phải nếu cần */
                margin-bottom: 20px;
                width: fit-content; /* Giữ kích thước theo nội dung */
                text-align: center;
            }
            .back-btn:hover {
                background-color: #e64a19; /* Màu tối hơn khi hover */
                color: white;
                text-decoration: none;
            }

        </style>

    </head>

    <body>
        <%@ include file="header.jsp" %>
        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="home">Trang Chủ</a></li>
                        <li><a href="product">Danh Mục</a></li>
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


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <form action="allUserOrder" method="GET" class="form-inline mb-3 gap-3">
                                        <div class="form-group mr-2">
                                            <label for="orderCode">Mã Đơn Hàng:</label>
                                            <input type="text" class="form-control ml-2" id="orderCode" name="orderCode" 
                                                   placeholder="Nhập mã đơn" value="${orderCode}" style="width: 300px;">
                                        </div>
                                        
                                        <div class="form-group mr-2" style="margin-left: 63px;">
                                            <label for="orderCode">Địa Chỉ Giao Hàng:</label>
                                            <input type="text" class="form-control ml-2" id="shippingAddress" name="shippingAddress" 
                                                   placeholder="Nhập Địa Chỉ Giao Hàng" value="${shippingAddress}" style="width: 400px;">
                                        </div>

                                        <div class="form-group mr-2">
                                            <label for="paymentMethod">Chọn phương thức thanh toán:</label>
                                            <select class="form-control ml-2" id="paymentMethod" name="paymentMethod">
                                                <option value="null" ${paymentMethod == null || paymentMethod == 'null' ? 'selected' : ''}>Tất cả</option>
                                                <option value="Chuyển Khoản Ngân Hàng" ${paymentMethod == 'Chuyển Khoản Ngân Hàng' ? 'selected' : ''}>Chuyển Khoản Ngân Hàng</option>
                                                <option value="Thẻ Tín Dụng" ${paymentMethod == 'Thẻ Tín Dụng' ? 'selected' : ''}>Thẻ Tín Dụng</option>
                                                <option value="Tiền Mặt Khi Nhận Hàng" ${paymentMethod == 'Tiền Mặt Khi Nhận Hàng' ? 'selected' : ''}>Tiền Mặt Khi Nhận Hàng</option>
                                            </select>
                                        </div>

                                        <div class="form-group mr-2" style="margin-left: 2px;">
                                            <label for="sortBy">Sắp xếp :</label>
                                            <select class="form-control ml-2" id="sortBy" name="sortBy" style="width: 400px;">
                                                <option value="default" ${sortBy == null || sortBy == 'default' ? 'selected' : ''}>Mặc định</option>
                                                <option value="priceDesc" ${sortBy == 'priceDesc' ? 'selected' : ''}>Tổng Số Tiền giảm dần</option>
                                                <option value="priceAsc" ${sortBy == 'priceAsc' ? 'selected' : ''}>Tổng Số Tiền tăng dần</option>
                                            </select>
                                        </div>

                                        <div class="form-group mr-2">
                                            <label for="fromDate">Ngày Đặt Hàng:</label>
                                            <input type="date" class="form-control ml-2" id="fromDate" name="fromDate" value="${fromDate}">
                                            <label for="toDate">-</label>
                                            <input type="date" class="form-control ml-2" id="toDate" name="toDate" value="${toDate}">
                                        </div>

                                        <div class="form-group mr-2" style="margin-left: 25px;">
                                            <label for="minPrice">Tổng Số Tiền:</label>
                                            <input type="number" class="form-control ml-2" id="minPrice" name="minPrice" 
                                                   placeholder="Nhập giá tối thiểu" value="${minPrice}">
                                            <label for="maxPrice">-</label>
                                            <input type="number" class="form-control ml-2" id="maxPrice" name="maxPrice" 
                                                   placeholder="Nhập giá tối đa" value="${maxPrice}">
                                        </div>
                                        
                                        

                                        <div class="form-group mr-2">
                                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                        </div>
                                    </form>


                                    <div class="list-product">
                                        <c:choose>
                                            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                <h2 class="product-title">Danh Sách Đơn Hàng Chờ Xác Nhận</h2>
                                            </c:when>
                                            <c:otherwise>
                                                <h2 class="product-title"> Danh Sách Đơn Hàng Có Thể Nhận</h2>


                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Tabs điều hướng -->
                                        <ul class="nav nav-tabs">
                                            <c:choose>
                                                <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#pending">Chờ xác nhận</a>
                                                    </li>
                                                    <a href="./userOrder" class="back-btn">Danh sách đơn đã duyệt<i class="fa fa-arrow-right"></i> </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#pending">Chờ nhận đơn</a>
                                                    </li>
                                                    <a href="./userOrder" class="back-btn">Danh sách đơn đã Nhận<i class="fa fa-arrow-right"></i> </a>


                                                </c:otherwise>
                                            </c:choose>

                                        </ul>

                                        <div class="tab-content">
                                            <!-- Chờ xác nhận -->
                                            <div id="pending" class="tab-pane active table-responsive">
                                                <!-- Nút Xác nhận tất cả -->
                                                <div style="margin-bottom: 15px; text-align: right;">
                                                    <a href="confirmOrder?pageStr=${currentPage}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xác nhận tất cả đơn hàng đang chờ không?')" 
                                                       class="btn btn-primary">Xác nhận tất cả</a>
                                                </div>
                                                <table id="pendingOrdersTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Mã Đơn Hàng</th>
                                                            <th>Ngày Đặt Hàng</th>
                                                            <th>Tổng Số Tiền</th>
                                                            <th>Phương Thức Thanh Toán</th>
                                                            <th>Địa Chỉ Giao Hàng</th>
                                                            <th>Chi Tiết</th>
                                                            <th>Xác nhận</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="pendingOrdersBody">
                                                        <c:forEach var="order" items="${orders}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>${order.totalAmount}</td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                <td>
                                                                    <a href="confirmOrder?orderId=${order.orderId}&pageStr=${currentPage}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                                                                                Xác nhận
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Nhận đơn

                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                                <!-- Phân trang cho đơn hàng -->
                                                <div class="pagination">
                                                    <c:if test="${currentPage > 1}">
                                                        <a href="allUserOrder?pageStr=1&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« First</a>
                                                    </c:if>

                                                    <c:if test="${currentPage > 3}">
                                                        <span>...</span>
                                                    </c:if>

                                                    <c:if test="${currentPage > 1}">
                                                        <a href="allUserOrder?pageStr=${currentPage - 1}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« Prev</a>
                                                    </c:if>

                                                    <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}" varStatus="status">
                                                        <c:if test="${i > 0 && i <= totalPages}">
                                                            <a href="allUserOrder?pageStr=${i}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" class="${i == currentPage ? 'active' : ''}">
                                                                ${i}
                                                            </a>
                                                        </c:if>
                                                    </c:forEach>

                                                    <c:if test="${currentPage < totalPages - 2}">
                                                        <span>...</span>
                                                    </c:if>

                                                    <c:if test="${currentPage < totalPages}">
                                                        <a href="allUserOrder?pageStr=${currentPage + 1}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Next »</a>
                                                    </c:if>

                                                    <c:if test="${currentPage < totalPages}">
                                                        <a href="allUserOrder?pageStr=${totalPages}&orderCode=${orderCode}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Last »</a>
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



        <!-- FOOTER -->
        <jsp:include page="footer.jsp"/>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <!-- jQuery -->
        <!-- Bootstrap Bundle JS -->




        <!-- jQuery -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <!-- Popper JS -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <!-- Bootstrap JS -->
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>



        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
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

            [id$="Pagination"] span {
                margin: 0 5px;
                color: #333;
                font-weight: bold;
            }
            .nav-tabs .nav-link {
                background-color: #f8f9fa; /* Màu nền mặc định */
                color: #007bff; /* Màu chữ mặc định */
                border: 1px solid #ddd;
            }

            .nav-tabs .nav-link:hover {
                background-color: #e9ecef; /* Màu khi hover */
            }

            .nav-tabs .nav-link.active {
                background-color: red !important; /* Màu đỏ nhạt */
                color: white !important; /* Màu chữ trắng */
                border-color: #ff4d4d; /* Viền đỏ đậm hơn để tạo điểm nhấn */
            }
            /* Style cho nút Trở về */
            .back-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: red; /* Màu đỏ cam đồng bộ với giao diện */
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.3s ease;
                margin-top: 15px;
                margin-left: 450px;
                text-align: center;
            }
            .back-btn:hover {
                background-color: #e64a19; /* Màu tối hơn khi hover */
                color: white;
                text-decoration: none;
            }


            .price-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .price-group .form-control {
                flex: 1;
            }
            .date-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .date-group .form-control {
                flex: 1;
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
                                    <div class="row justify-content-center">
                                        <div class="col-lg-12 search-container">
                                            <form action="userOrder" method="GET" class="row g-3">
                                                <input type="hidden" id="userId" name="userId" value="${user.userId}">

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label for="orderCode" class="form-label">Mã Đơn Hàng:</label>
                                                    <input type="text" class="form-control" id="orderCode" name="orderCode" 
                                                           placeholder="Nhập mã đơn" value="${orderCode}">
                                                </div>

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label for="shippingAddress" class="form-label">Địa Chỉ Giao Hàng:</label>
                                                    <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" 
                                                           placeholder="Nhập Địa Chỉ Giao Hàng" value="${shippingAddress}">
                                                </div>

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label for="paymentMethod">Chọn phương thức thanh toán:</label>
                                                    <select class="form-control ml-2" id="paymentMethod" name="paymentMethod">
                                                        <option value="null" ${paymentMethod == null || paymentMethod == 'null' ? 'selected' : ''}>Tất cả</option>
                                                        <option value="Chuyển Khoản Ngân Hàng" ${paymentMethod == 'Chuyển Khoản Ngân Hàng' ? 'selected' : ''}>Chuyển Khoản Ngân Hàng</option>
                                                        <option value="Thẻ Tín Dụng" ${paymentMethod == 'Thẻ Tín Dụng' ? 'selected' : ''}>Thẻ Tín Dụng</option>
                                                        <option value="Tiền Mặt Khi Nhận Hàng" ${paymentMethod == 'Tiền Mặt Khi Nhận Hàng' ? 'selected' : ''}>Tiền Mặt Khi Nhận Hàng</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label for="sortBy">Sắp xếp :</label>
                                                    <select class="form-control ml-2" id="sortBy" name="sortBy" >
                                                        <option value="default" ${sortBy == null || sortBy == 'default' ? 'selected' : ''}>Mặc định</option>
                                                        <option value="priceDesc" ${sortBy == 'priceDesc' ? 'selected' : ''}>Tổng Số Tiền giảm dần</option>
                                                        <option value="priceAsc" ${sortBy == 'priceAsc' ? 'selected' : ''}>Tổng Số Tiền tăng dần</option>
                                                    </select>
                                                </div>

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label class="form-label">Ngày Đặt Hàng:</label>
                                                    <div class="date-group">
                                                        <input type="date" class="form-control" id="fromDate" name="fromDate" value="${fromDate}">
                                                        <span>-</span>
                                                        <input type="date" class="form-control" id="toDate" name="toDate" value="${toDate}">
                                                    </div>
                                                </div>

                                                <div class="col-md-6" style="margin-top: 5px;">
                                                    <label class="form-label">Tổng Số Tiền:</label>
                                                    <div class="price-group">
                                                        <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                                               placeholder="Giá tối thiểu" value="${minPrice}">
                                                        <span>-</span>
                                                        <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                                               placeholder="Giá tối đa" value="${maxPrice}">
                                                    </div>
                                                </div>

                                                <div class="col-12 text-center mt-4" >
                                                    <button type="submit" class="btn btn-primary search-btn px-4" style="margin-top: 30px; margin-bottom: 30px">Tìm kiếm</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>


                                    <div class="list-product">
                                        <c:choose>
                                            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Customer'}">
                                                <h2 class="product-title">Danh Sách Đơn Hàng</h2>
                                            </c:when>
                                            <c:when test="${sessionScope.user != null && sessionScope.user.role == 'Shipper'}">
                                                <h2 class="product-title">Danh Sách Đơn Hàng Đã Nhận<a href="./allUserOrder" class="back-btn">Danh sách đơn có thể nhận<i class="fa "></i> </a></h2>
                                            </c:when>
                                            <c:otherwise>
                                                <h2 class="product-title">Danh Sách Đơn Hàng Đã Duyệt<a href="./allUserOrder" class="back-btn">Danh sách đơn chưa duyệt<i class="fa "></i> </a></h2>


                                            </c:otherwise>
                                        </c:choose>


                                        <!-- Tabs điều hướng -->
                                        <ul class="nav nav-tabs">
                                            <c:choose>
                                                <c:when test="${sessionScope.user != null 
                                                                and (sessionScope.user.role == 'Customer' 
                                                                or sessionScope.user.role == 'Admin' 
                                                                or sessionScope.user.role == 'Staff')}">
                                                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Customer'}">
                                                        <li class="nav-item">
                                                            <a class="nav-link" data-toggle="tab" href="#pending">Chờ xác nhận</a>
                                                        </li>
                                                    </c:if>

                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#confirmed">Đã xác nhận</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" data-toggle="tab" href="#shipped">Đang vận chuyển</a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="nav-item">
                                                        <a class="nav-link active" data-toggle="tab" href="#shipped">Đang vận chuyển</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>

                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#delivered">Đã giao</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#cancelled">Đã hủy</a>
                                            </li>
                                        </ul>

                                        <div class="tab-content">
                                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Customer'}">

                                                <!-- Chờ xác nhận -->
                                                <div id="pending" class="tab-pane fade table-responsive">
                                                    <table id="pendingOrdersTable">
                                                        <thead>
                                                            <tr>
                                                                <th>Mã Đơn Hàng</th>
                                                                <th>Ngày Đặt Hàng</th>
                                                                <th>Tổng Số Tiền</th>
                                                                <th>Phương Thức Thanh Toán</th>
                                                                <th>Địa Chỉ Giao Hàng</th>
                                                                <th>Chi Tiết</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="pendingOrdersBody">
                                                            <c:forEach var="order" items="${orders}">
                                                                <c:if test="${order.orderStatus eq 'Pending'}">
                                                                    <tr>
                                                                        <td>${order.orderCode}</td>
                                                                        <td>${order.orderDate}</td>
                                                                        <td>${order.totalAmount}</td>
                                                                        <td>${order.paymentMethod}</td>
                                                                        <td>${order.shippingAddress}</td>
                                                                        <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                    </tr>
                                                                </c:if>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <div id="pendingPagination" style="margin-top: 20px; text-align: center;"></div>
                                                </div>
                                            </c:if>

                                            <c:choose>
                                                <c:when test="${sessionScope.user != null 
                                                                && (sessionScope.user.role == 'Customer' 
                                                                || sessionScope.user.role == 'Admin' 
                                                                || sessionScope.user.role == 'Staff')}">
                                                        <!-- Đã xác nhận -->
                                                        <div id="confirmed" class="tab-pane active table-responsive">
                                                            <table id="confirmedOrdersTable">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Mã Đơn Hàng</th>
                                                                        <th>Ngày Đặt Hàng</th>
                                                                        <th>Tổng Số Tiền</th>
                                                                        <th>Phương Thức Thanh Toán</th>
                                                                        <th>Địa Chỉ Giao Hàng</th>
                                                                        <th>Chi Tiết</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="confirmedOrdersBody">
                                                                    <c:forEach var="order" items="${orders}">
                                                                        <c:if test="${order.orderStatus eq 'Confirmed'}">
                                                                            <tr>
                                                                                <td>${order.orderCode}</td>
                                                                                <td>${order.orderDate}</td>
                                                                                <td>${order.totalAmount}</td>
                                                                                <td>${order.paymentMethod}</td>
                                                                                <td>${order.shippingAddress}</td>
                                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                            </tr>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                            <div id="confirmedPagination" style="margin-top: 20px; text-align: center;"></div>
                                                        </div>

                                                        <!-- Đang vận chuyển -->
                                                        <div id="shipped" class="tab-pane fade table-responsive">
                                                            <table id="shippedOrdersTable">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Mã Đơn Hàng</th>
                                                                        <th>Ngày Đặt Hàng</th>
                                                                        <th>Tổng Số Tiền</th>
                                                                        <th>Phương Thức Thanh Toán</th>
                                                                        <th>Địa Chỉ Giao Hàng</th>
                                                                        <th>Chi Tiết</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="shippedOrdersBody">
                                                                    <c:forEach var="order" items="${orders}">
                                                                        <c:if test="${order.orderStatus eq 'Shipped'}">
                                                                            <tr>
                                                                                <td>${order.orderCode}</td>
                                                                                <td>${order.orderDate}</td>
                                                                                <td>${order.totalAmount}</td>
                                                                                <td>${order.paymentMethod}</td>
                                                                                <td>${order.shippingAddress}</td>
                                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                            </tr>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                            <div id="shippedPagination" style="margin-top: 20px; text-align: center;"></div>
                                                        </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <!-- Đang vận chuyển -->
                                                    <div id="shipped" class="tab-pane active table-responsive">
                                                        <table id="shippedOrdersTable">
                                                            <thead>
                                                                <tr>
                                                                    <th>Mã Đơn Hàng</th>
                                                                    <th>Ngày Đặt Hàng</th>
                                                                    <th>Tổng Số Tiền</th>
                                                                    <th>Phương Thức Thanh Toán</th>
                                                                    <th>Địa Chỉ Giao Hàng</th>
                                                                    <th>Chi Tiết</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="shippedOrdersBody">
                                                                <c:forEach var="order" items="${orders}">
                                                                    <c:if test="${order.orderStatus eq 'Shipped'}">
                                                                        <tr>
                                                                            <td>${order.orderCode}</td>
                                                                            <td>${order.orderDate}</td>
                                                                            <td>${order.totalAmount}</td>
                                                                            <td>${order.paymentMethod}</td>
                                                                            <td>${order.shippingAddress}</td>
                                                                            <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                        </tr>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                        <div id="shippedPagination" style="margin-top: 20px; text-align: center;"></div>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>




                                            <!-- Đã giao -->
                                            <div id="delivered" class="tab-pane fade table-responsive">
                                                <table id="deliveredOrdersTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Mã Đơn Hàng</th>
                                                            <th>Ngày Đặt Hàng</th>
                                                            <th>Tổng Số Tiền</th>   
                                                            <th>Phương Thức Thanh Toán</th>
                                                            <th>Địa Chỉ Giao Hàng</th>
                                                            <th>Chi Tiết</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="deliveredOrdersBody">
                                                        <c:forEach var="order" items="${orders}">
                                                            <c:if test="${order.orderStatus eq 'Delivered'}">
                                                                <tr>
                                                                    <td>${order.orderCode}</td>
                                                                    <td>${order.orderDate}</td>
                                                                    <td>${order.totalAmount}</td>
                                                                    <td>${order.paymentMethod}</td>
                                                                    <td>${order.shippingAddress}</td>
                                                                    <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                                <div id="deliveredPagination" style="margin-top: 20px; text-align: center;"></div>
                                            </div>

                                            <!-- Đã hủy -->
                                            <div id="cancelled" class="tab-pane fade table-responsive">
                                                <table id="cancelledOrdersTable">
                                                    <thead>
                                                        <tr>
                                                            <th>Mã Đơn Hàng</th>
                                                            <th>Ngày Đặt Hàng</th>
                                                            <th>Tổng Số Tiền</th>
                                                            <th>Phương Thức Thanh Toán</th>
                                                            <th>Địa Chỉ Giao Hàng</th>
                                                            <th>Chi Tiết</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="cancelledOrdersBody">
                                                        <c:forEach var="order" items="${orders}">
                                                            <c:if test="${order.orderStatus eq 'Cancelled'}">
                                                                <tr>
                                                                    <td>${order.orderCode}</td>
                                                                    <td>${order.orderDate}</td>
                                                                    <td>${order.totalAmount}</td>
                                                                    <td>${order.paymentMethod}</td>
                                                                    <td>${order.shippingAddress}</td>
                                                                    <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                                </tr>
                                                            </c:if>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                                <div id="cancelledPagination" style="margin-top: 20px; text-align: center;"></div>
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

        <!-- HTML giữ nguyên, chỉ cập nhật phần script -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
            const itemsPerPage = 4;
                    const tabs = [
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Customer'}">
                    {bodyId: 'pendingOrdersBody', paginationId: 'pendingPagination'},
            </c:if>
            <c:if test="${sessionScope.user != null && sessionScope.user.role != 'Shipper'}">
                    {bodyId: 'confirmedOrdersBody', paginationId: 'confirmedPagination'},
            </c:if>
                    {bodyId: 'shippedOrdersBody', paginationId: 'shippedPagination'}
                    ,
                    {bodyId: 'deliveredOrdersBody', paginationId: 'deliveredPagination'}
                    ,
                    {bodyId: 'cancelledOrdersBody', paginationId: 'cancelledPagination'
                    }
                    ];
                    tabs.forEach(tab => {
                    const tableBody = document.getElementById(tab.bodyId);
                            const rows = Array.from(tableBody.getElementsByTagName('tr'));
                            const totalItems = rows.length;
                            const totalPages = Math.ceil(totalItems / itemsPerPage);
                            let currentPage = 1;
                            function showPage(page) {
                            rows.forEach(row => row.style.display = 'none');
                                    const startIndex = (page - 1) * itemsPerPage;
                                    const endIndex = Math.min(startIndex + itemsPerPage, totalItems);
                                    for (let i = startIndex; i < endIndex; i++) {
                            rows[i].style.display = 'table-row';
                            }
                            currentPage = page;
                                    updatePagination();
                            }

                    function updatePagination() {
                    const pagination = document.getElementById(tab.paginationId);
                            pagination.innerHTML = '';
                            // Nút Previous
                            const prevBtn = document.createElement('button');
                            prevBtn.textContent = 'Trước';
                            prevBtn.disabled = currentPage === 1;
                            prevBtn.addEventListener('click', () => showPage(currentPage - 1));
                            pagination.appendChild(prevBtn);
                            // Nếu tổng số trang <= 5, hiển thị tất cả
                            if (totalPages <= 5) {
                    for (let i = 1; i <= totalPages; i++) {
                    const pageBtn = document.createElement('button');
                            pageBtn.textContent = i;
                            pageBtn.className = currentPage === i ? 'active' : '';
                            pageBtn.addEventListener('click', () => showPage(i));
                            pagination.appendChild(pageBtn);
                    }
                    } else {
                    // Hiển thị trang đầu
                    const firstPageBtn = document.createElement('button');
                            firstPageBtn.textContent = '1';
                            firstPageBtn.className = currentPage === 1 ? 'active' : '';
                            firstPageBtn.addEventListener('click', () => showPage(1));
                            pagination.appendChild(firstPageBtn);
                            // Thêm dấu "..." nếu trang hiện tại cách trang đầu > 2
                            if (currentPage > 3) {
                    const dots1 = document.createElement('span');
                            dots1.textContent = '...';
                            dots1.style.margin = '0 5px';
                            pagination.appendChild(dots1);
                    }

                    // Hiển thị các trang gần trang hiện tại
                    const startPage = Math.max(2, currentPage - 1);
                            const endPage = Math.min(totalPages - 1, currentPage + 1);
                            for (let i = startPage; i <= endPage; i++) {
                    const pageBtn = document.createElement('button');
                            pageBtn.textContent = i;
                            pageBtn.className = currentPage === i ? 'active' : '';
                            pageBtn.addEventListener('click', () => showPage(i));
                            pagination.appendChild(pageBtn);
                    }

                    // Thêm dấu "..." nếu trang hiện tại cách trang cuối > 2
                    if (currentPage < totalPages - 2) {
                    const dots2 = document.createElement('span');
                            dots2.textContent = '...';
                            dots2.style.margin = '0 5px';
                            pagination.appendChild(dots2);
                    }

                    // Hiển thị trang cuối
                    const lastPageBtn = document.createElement('button');
                            lastPageBtn.textContent = totalPages;
                            lastPageBtn.className = currentPage === totalPages ? 'active' : '';
                            lastPageBtn.addEventListener('click', () => showPage(totalPages));
                            pagination.appendChild(lastPageBtn);
                    }

                    // Nút Next
                    const nextBtn = document.createElement('button');
                            nextBtn.textContent = 'Sau';
                            nextBtn.disabled = currentPage === totalPages;
                            nextBtn.addEventListener('click', () => showPage(currentPage + 1));
                            pagination.appendChild(nextBtn);
                    }

                    if (totalItems > 0) {
                    showPage(1);
                    }
                    });
                    // Xử lý khi chuyển tab
                    document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function () {
            setTimeout(() => {
            tabs.forEach(tab => {
            const tableBody = document.getElementById(tab.bodyId);
                    const rows = Array.from(tableBody.getElementsByTagName('tr'));
                    if (rows.length > 0 && tableBody.closest('.tab-pane').classList.contains('active')) {
            showPage(1); // Reset về trang 1 khi chuyển tab
            }
            });
            }, 100); // Delay nhỏ để đảm bảo tab đã chuyển xong
            });
            });
            });
        </script>
    </body>
</html>
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

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .form-inline .form-group {
                    width: 100%;
                    margin-bottom: 10px;
                }

                .form-inline .form-group label {
                    width: 100%;
                    margin-bottom: 5px;
                }

                .form-inline .form-control {
                    width: 100%;
                }

                .btn-primary {
                    width: 100%;
                }

                th, td {
                    font-size: 14px;
                    padding: 10px;
                }
            }
            .form-group {
                padding-right: 20px;
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
                                    <form action="getAllOrders" method="GET" class="form-inline mb-3 gap-3">
                                        <div class="form-group mr-2">
                                            <label for="orderCode">Mã Đơn Hàng:</label>
                                            <input type="text" class="form-control ml-2" id="orderCode" name="orderCode" placeholder="Nhập mã đơn">
                                        </div>


                                        <div class="form-group mr-2">
                                            <label for="sortBy">Chọn phương thức thanh toán:</label>
                                            <select class="form-control ml-2" id="sortBy" name="sortBy">
                                                <option value="default">Tất cả</option>
                                                <option value="priceDesc">Thanh toán online</option>
                                                <option value="priceAsc">Thanh toán khi nhận hàng</option>
                                            </select>
                                        </div>

                                        <div class="form-group mr-2">
                                            <label for="sortBy">Sắp xếp :</label>
                                            <select class="form-control ml-2" id="sortBy" name="sortBy">
                                                <option value="default">Mặc đinh</option>
                                                <option value="priceDesc"> Tổng Số Tiền giảm dần</option>
                                                <option value="priceAsc"> Tổng Số Tiền tăng dần</option>
                                            </select>
                                        </div>


                                        <div class="form-group mr-2">
                                            <label for="fromDate">Ngày Đặt Hàng:</label>
                                            <input type="date" class="form-control ml-2" id="fromDate" name="fromDate">
                                            <label for="toDate">-</label>
                                            <input type="date" class="form-control ml-2" id="toDate" name="toDate">
                                        </div>



                                        <div class="form-group mr-2">
                                            <label for="minPrice">Tổng Số Tiền:</label>
                                            <input type="number" class="form-control ml-2" id="minPrice" name="minPrice" placeholder="Nhập giá tối thiểu">
                                            <label for="maxPrice">-</label>
                                            <input type="number" class="form-control ml-2" id="maxPrice" name="maxPrice" placeholder="Nhập giá tối đa">
                                        </div>



                                        <div class="form-group mr-2">
                                            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                        </div>
                                    </form>

                                    <div class="list-product">
                                        <h2 class="product-title">Danh Sách Đơn Hàng</h2>

                                        <!-- Tabs điều hướng -->
                                        <ul class="nav nav-tabs">
                                            <li class="nav-item">
                                                <a class="nav-link " data-toggle="tab" href="#pending">Chờ xác nhận</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#shipped">Đang vận chuyển</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#delivered">Đã giao</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#cancelled">Đã hủy</a>
                                            </li>
                                        </ul>

                                        <div class="tab-content">
                                            <!-- Chờ xác nhận -->
                                            <div id="pending" class=" tab-pane active table-responsive">
                                                <table>
                                                    <tr>
                                                        <th>Mã Đơn Hàng</th>
                                                        <th>Ngày Đặt Hàng</th>
                                                        <th>Tổng Số Tiền</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Phương Thức Thanh Toán</th>
                                                        <th>Địa Chỉ Giao Hàng</th>
                                                        <th>Chi Tiết</th>
                                                    </tr>
                                                    <c:forEach var="order" items="${orders}">
                                                        <c:if test="${order.orderStatus eq 'Pending'}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>${order.totalAmount}</td>
                                                                <td class="status-pending">Chờ xác nhận</td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </table>
                                            </div>

                                            <!-- Đang vận chuyển -->
                                            <div id="shipped" class=" tab-pane fade table-responsive">
                                                <table>
                                                    <tr>
                                                        <th>Mã Đơn Hàng</th>
                                                        <th>Ngày Đặt Hàng</th>
                                                        <th>Tổng Số Tiền</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Phương Thức Thanh Toán</th>
                                                        <th>Địa Chỉ Giao Hàng</th>
                                                        <th>Chi Tiết</th>
                                                    </tr>
                                                    <c:forEach var="order" items="${orders}">
                                                        <c:if test="${order.orderStatus eq 'Shipped'}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>${order.totalAmount}</td>
                                                                <td class="status-shipped">Đang vận chuyển</td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </table>
                                            </div>

                                            <!-- Đã giao -->
                                            <div id="delivered" class=" tab-pane fade table-responsive">
                                                <table>
                                                    <tr>
                                                        <th>Mã Đơn Hàng</th>
                                                        <th>Ngày Đặt Hàng</th>
                                                        <th>Tổng Số Tiền</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Phương Thức Thanh Toán</th>
                                                        <th>Địa Chỉ Giao Hàng</th>
                                                        <th>Chi Tiết</th>
                                                    </tr>
                                                    <c:forEach var="order" items="${orders}">
                                                        <c:if test="${order.orderStatus eq 'Delivered'}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>${order.totalAmount}</td>
                                                                <td class="status-delivered">Đã giao</td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </table>
                                            </div>

                                            <!-- Đã hủy -->
                                            <div id="cancelled" class=" tab-pane fade table-responsive">
                                                <table>
                                                    <tr>
                                                        <th>Mã Đơn Hàng</th>
                                                        <th>Ngày Đặt Hàng</th>
                                                        <th>Tổng Số Tiền</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Phương Thức Thanh Toán</th>
                                                        <th>Địa Chỉ Giao Hàng</th>
                                                        <th>Chi Tiết</th>
                                                    </tr>
                                                    <c:forEach var="order" items="${orders}">
                                                        <c:if test="${order.orderStatus eq 'Cancelled'}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td>${order.totalAmount}</td>
                                                                <td class="status-cancelled">Đã hủy</td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td><a href="orderDetail?orderId=${order.orderId}">Chi Tiết</a></td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div> <!-- Kết thúc tab-content -->
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
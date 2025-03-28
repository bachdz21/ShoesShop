<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quản Lý Đơn Hàng</title>

        <!-- Bootstrap CSS -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f9f7f7;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .user-profile {
                margin-top: 20px;
                margin-bottom: 40px;
            }

            .card {
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(255,0,0,0.1);
                margin-bottom: 30px;
                border: none;
            }

            .card-header {
                background-color: red;
                color: white;
                border-radius: 10px 10px 0 0 !important;
                padding: 15px 20px;
                border: none;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: 600;
                margin-right: 10px;
                color: #343a40;
            }

            .search-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 25px;
                border: 1px solid #e9ecef;
            }

            .btn-primary {
                background-color: red;
                border-color: red;
                padding: 8px 20px;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background-color: #E60000;
                border-color: #CC0000;
                box-shadow: 0 5px 15px rgba(255,0,0,0.2);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table th {
                background-color: red;
                color: white;
                padding: 12px 15px;
                text-align: left;
                font-weight: 600;
            }

            table td {
                padding: 12px 15px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
            }

            table tr:hover {
                background-color: #ffecef;
            }

            .action-link {
                color: red;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .action-link:hover {
                color: #E60000;
                text-decoration: underline;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 30px;
            }

            .pagination a {
                color: red;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #e9ecef;
                margin: 0 4px;
                border-radius: 5px;
                transition: all 0.3s;
            }

            .pagination a:hover {
                background-color: #FF0000;
                color: white;
            }

            .pagination a.active {
                background-color: #FF0000;
                color: white;
                border: 1px solid #FF0000;
            }

            .back-btn {
                display: inline-block;
                margin-left: 20px;
                color: #FF0000;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
            }

            .back-btn:hover {
                color: #E60000;
                text-decoration: underline;
            }

            .nav-tabs {
                border-bottom: 2px solid #e9ecef;
                margin-bottom: 20px;
            }

            .nav-tabs .nav-link {
                border: none;
                color: #6c757d;
                font-weight: 600;
                padding: 10px 20px;
            }

            .nav-tabs .nav-link.active {
                color: #FF0000;
                border-bottom: 3px solid #FF0000;
                background-color: transparent;
            }

            .product-title {
                color: #343a40;
                font-weight: 700;
                margin-bottom: 20px;
                text-align: center;
            }

            .confirm-all-btn {
                background-color: #28a745;
                border-color: #28a745;
            }

            .confirm-all-btn:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }

            .search-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: flex-end;
            }

            .search-col {
                flex: 1;
                min-width: 250px;
            }

            .search-actions {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .responsive-table {
                overflow-x: auto;
            }

            .form-control:focus {
                border-color: #FF0000;
                box-shadow: 0 0 0 0.2rem rgba(255, 0, 0, 0.25);
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(255, 0, 0, 0.05);
            }

            h5 {
                color: #FF0000;
                font-weight: 600;
            }
        </style>
    </head>

    <body>

        <div class="container user-profile">
            <div class="main-body">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="mb-0">
                                    <c:choose>
                                        <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff') }">
                                            <i class="fas fa-clipboard-list mr-2"></i> Quản Lý Đơn Hàng
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-shipping-fast mr-2"></i> Đơn Hàng Có Thể Nhận
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                            </div>
                            <div class="card-body">
                                <!-- Form tìm kiếm -->
                                <div class="search-section">
                                    <h5><i class="fas fa-search mr-2"></i> Tìm Kiếm Đơn Hàng</h5>
                                    <form action="allUserOrder" method="GET">
                                        <div class="search-row">
                                            <div class="search-col">
                                                <label for="orderCode">Mã Đơn Hàng:</label>
                                                <input type="text" class="form-control" id="orderCode" name="orderCode" 
                                                       placeholder="Nhập mã đơn" value="${orderCode}">
                                            </div>

                                            <div class="search-col">
                                                <label for="shippingAddress">Địa Chỉ Giao Hàng:</label>
                                                <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" 
                                                       placeholder="Nhập địa chỉ giao hàng" value="${shippingAddress}">
                                            </div>
                                        </div>

                                        <div class="search-row">
                                            <div class="search-col">
                                                <label for="paymentMethod">Phương Thức Thanh Toán:</label>
                                                <select class="form-control" id="paymentMethod" name="paymentMethod">
                                                    <option value="null" ${paymentMethod == null || paymentMethod == 'null' ? 'selected' : ''}>Tất cả</option>
                                                    <option value="Chuyển Khoản Ngân Hàng" ${paymentMethod == 'Chuyển Khoản Ngân Hàng' ? 'selected' : ''}>Chuyển Khoản Ngân Hàng</option>
                                                    <option value="Thẻ Tín Dụng" ${paymentMethod == 'Thẻ Tín Dụng' ? 'selected' : ''}>Thẻ Tín Dụng</option>
                                                    <option value="Tiền Mặt Khi Nhận Hàng" ${paymentMethod == 'Tiền Mặt Khi Nhận Hàng' ? 'selected' : ''}>Tiền Mặt Khi Nhận Hàng</option>
                                                </select>
                                            </div>

                                            <div class="search-col">
                                                <label for="sortBy">Sắp Xếp:</label>
                                                <select class="form-control" id="sortBy" name="sortBy">
                                                    <option value="default" ${sortBy == null || sortBy == 'default' ? 'selected' : ''}>Mặc định</option>
                                                    <option value="priceDesc" ${sortBy == 'priceDesc' ? 'selected' : ''}>Tổng Số Tiền giảm dần</option>
                                                    <option value="priceAsc" ${sortBy == 'priceAsc' ? 'selected' : ''}>Tổng Số Tiền tăng dần</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="search-row">
                                            <div class="search-col">
                                                <label>Ngày Đặt Hàng:</label>
                                                <div class="d-flex">
                                                    <input type="date" class="form-control" id="fromDate" name="fromDate" value="${fromDate}">
                                                    <span class="mx-2 align-self-center">đến</span>
                                                    <input type="date" class="form-control" id="toDate" name="toDate" value="${toDate}">
                                                </div>
                                            </div>

                                            <div class="search-col">
                                                <label>Tổng Số Tiền:</label>
                                                <div class="d-flex">
                                                    <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                                           placeholder="Giá tối thiểu" value="${minPrice}">
                                                    <span class="mx-2 align-self-center">đến</span>
                                                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                                           placeholder="Giá tối đa" value="${maxPrice}">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="search-actions">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-search mr-2"></i> Tìm Kiếm
                                            </button>
                                        </div>
                                    </form>
                                </div>

                                <div class="list-product">
                                    <!-- Tiêu đề danh sách đơn hàng -->
                                    <h4 class="product-title">
                                        <c:choose>
                                            <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff')}">
                                                <i class="fas fa-clipboard-check mr-2"></i> Danh Sách Đơn Hàng Chờ Xác Nhận
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-truck mr-2"></i> Danh Sách Đơn Hàng Có Thể Nhận
                                            </c:otherwise>
                                        </c:choose>
                                    </h4>
                                    <%-- Hiển thị thông báo từ session nếu có --%>
                                    <c:if test="${not empty sessionScope.message}">
                                        <div class="alert alert-success" role="alert">
                                            ${sessionScope.message}
                                            <%-- Xóa thông báo sau khi hiển thị để tránh hiển thị lại khi tải lại trang --%>
                                            <% session.removeAttribute("message"); %>
                                        </div>
                                    </c:if>

                                    <!-- Tabs điều hướng -->
                                    <ul class="nav nav-tabs">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#pending">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff')}">
                                                        <i class="fas fa-hourglass-half mr-1"></i> Chờ xác nhận
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-hand-holding-box mr-1"></i> Chờ nhận đơn
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                        </li>
                                        <li class="nav-item ml-auto">
                                            <a href="./userOrder" class="back-btn">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff')}">
                                                        <i class="fas fa-list mr-1"></i> Danh sách đơn đã duyệt
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fas fa-list mr-1"></i> Danh sách đơn đã nhận
                                                    </c:otherwise>
                                                </c:choose>
                                                <i class="fas fa-arrow-right ml-1"></i>
                                            </a>
                                        </li>
                                    </ul>

                                    <div class="tab-content">
                                        <!-- Chờ xác nhận -->
                                        <div id="pending" class="tab-pane active">
                                            <!-- Nút Xác nhận tất cả -->
                                            <div class="text-right mb-3">
                                                <a href="confirmOrder?pageStr=${currentPage}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xác nhận tất cả đơn hàng đang chờ không?')" 
                                                   class="btn btn-primary confirm-all-btn">
                                                    <c:choose>
                                                        <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff')}">
                                                            <i class="fas fa-check-double mr-1"></i> Xác nhận tất cả
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-check-double mr-1"></i> Nhận tất cả đơn
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </div>

                                            <div class="responsive-table">
                                                <table id="pendingOrdersTable" class="table table-striped">
                                                    <thead>
                                                        <tr>
                                                            <th><i class="fas fa-hashtag mr-1"></i> Mã Đơn Hàng</th>
                                                            <th><i class="fas fa-calendar-alt mr-1"></i> Ngày Đặt Hàng</th>
                                                            <th><i class="fas fa-money-bill-wave mr-1"></i> Tổng Số Tiền</th>
                                                            <th><i class="fas fa-credit-card mr-1"></i> Phương Thức Thanh Toán</th>
                                                            <th><i class="fas fa-map-marker-alt mr-1"></i> Địa Chỉ Giao Hàng</th>
                                                            <th><i class="fas fa-info-circle mr-1"></i> Chi Tiết</th>
                                                            <th><i class="fas fa-check-circle mr-1"></i> Xác nhận</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="pendingOrdersBody">
                                                        <c:forEach var="order" items="${orders}">
                                                            <tr>
                                                                <td>${order.orderCode}</td>
                                                                <td>${order.orderDate}</td>
                                                                <td><strong>${order.totalAmount}</strong></td>
                                                                <td>${order.paymentMethod}</td>
                                                                <td>${order.shippingAddress}</td>
                                                                <td>
                                                                    <a href="orderDetail?orderId=${order.orderId}" class="action-link">
                                                                        <i class="fas fa-eye mr-1"></i> Chi Tiết
                                                                    </a>
                                                                </td>
                                                                <td>
                                                                    <a href="confirmOrder?orderId=${order.orderId}&pageStr=${currentPage}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" 
                                                                       class="action-link">
                                                                        <c:choose>
                                                                            <c:when test="${sessionScope.user != null && (sessionScope.user.role == 'Admin' || sessionScope.user.role == 'Staff')}">
                                                                                <i class="fas fa-check mr-1"></i> Xác nhận
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <i class="fas fa-truck-loading mr-1"></i> Nhận đơn
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <!-- Phân trang cho đơn hàng -->
                                            <div class="pagination">
                                                <c:if test="${currentPage > 1}">
                                                    <a href="allUserOrder?pageStr=1&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« Đầu</a>
                                                </c:if>

                                                <c:if test="${currentPage > 3}">
                                                    <span>...</span>
                                                </c:if>

                                                <c:if test="${currentPage > 1}">
                                                    <a href="allUserOrder?pageStr=${currentPage - 1}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">« Trước</a>
                                                </c:if>

                                                <c:forEach var="i" begin="${currentPage - 1}" end="${currentPage + 1}" varStatus="status">
                                                    <c:if test="${i > 0 && i <= totalPages}">
                                                        <a href="allUserOrder?pageStr=${i}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}" class="${i == currentPage ? 'active' : ''}">
                                                            ${i}
                                                        </a>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages - 2}">
                                                    <span>...</span>
                                                </c:if>

                                                <c:if test="${currentPage < totalPages}">
                                                    <a href="allUserOrder?pageStr=${currentPage + 1}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Sau »</a>
                                                </c:if>

                                                <c:if test="${currentPage < totalPages}">
                                                    <a href="allUserOrder?pageStr=${totalPages}&orderCode=${orderCode}&shippingAddress=${shippingAddress}&paymentMethod=${paymentMethod}&sortBy=${sortBy}&fromDate=${fromDate}&toDate=${toDate}&minPrice=${minPrice}&maxPrice=${maxPrice}">Cuối »</a>
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


    <!-- jQuery Plugins -->
    <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
    <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
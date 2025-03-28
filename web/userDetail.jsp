<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Chi tiết người dùng</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    /* Reset mặc định và cải thiện tổng thể */
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        line-height: 1.6;
    }

    /* Tiêu đề chính */
    h1 {
        text-align: center;
        font-size: 36px;
        color: #d32f2f;
        margin: 30px 0;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* Thông tin người dùng */
    .user-info {
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        margin-bottom: 30px;
    }

    .user-info h3 {
        color: #333;
        margin-bottom: 15px;
        font-size: 24px;
        text-align: center;
    }

    .user-info .info-container {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }

    .user-info .info-item {
        flex: 1 1 45%; /* 2 cột, mỗi cột chiếm khoảng 45% chiều rộng */
        font-size: 16px;
        color: #555;
        margin-bottom: 10px;
    }

    .user-info .info-item strong {
        color: #d32f2f;
        min-width: 120px;
        display: inline-block;
    }

    /* Form tìm kiếm */
    .form-inline {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        align-items: center;
        justify-content: space-between;
    }

    .form-group {
        display: flex;
        align-items: center;
        flex: 1 1 30%; /* Mỗi form-group chiếm khoảng 30% chiều rộng */
        min-width: 250px; /* Đảm bảo kích thước tối thiểu */
        margin-bottom: 15px;
    }

    .form-group label {
        margin-right: 10px;
        font-weight: 500;
        color: #333;
        min-width: 100px; /* Đảm bảo label có kích thước đồng đều */
        text-align: right;
    }

    .form-control {
        border-radius: 5px;
        border: 1px solid #ddd;
        padding: 8px 12px;
        width: 100%; /* Đảm bảo ô nhập liệu chiếm hết chiều rộng còn lại */
        transition: border-color 0.3s ease;
    }

    .form-control:focus {
        border-color: #d32f2f;
        box-shadow: 0 0 5px rgba(211, 47, 47, 0.3);
        outline: none;
    }

    .btn-primary {
        background-color: #d32f2f;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .btn-primary:hover {
        background-color: #b71c1c;
    }

    /* Tabs */
    .nav-tabs {
        border-bottom: 2px solid #d32f2f;
        margin-bottom: 20px;
    }

    .nav-tabs .nav-link {
        color: #555;
        padding: 10px 20px;
        border-radius: 5px 5px 0 0;
        transition: all 0.3s ease;
    }

    .nav-tabs .nav-link:hover {
        background-color: #f1f1f1;
        border-color: transparent;
    }

    .nav-tabs .nav-link.active {
        background-color: #d32f2f;
        color: white;
        border-color: #d32f2f;
    }

    /* Bảng đơn hàng */
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        font-size: 15px;
        text-align: left;
    }

    th {
        background-color: #d32f2f;
        color: white;
        font-weight: 600;
        text-transform: uppercase;
    }

    td {
        border-bottom: 1px solid #eee;
        color: #555;
    }

    tbody tr:nth-child(even) {
        background-color: #fafafa;
    }

    tbody tr:hover {
        background-color: #f5f5f5;
        transition: background-color 0.3s ease;
    }

    td a {
        color: #d32f2f;
        text-decoration: none;
        font-weight: 500;
    }

    td a:hover {
        text-decoration: underline;
        color: #b71c1c;
    }

    /* Phân trang */
    #pendingPagination, #confirmedPagination, #shippedPagination, 
    #deliveredPagination, #cancelledPagination {
        margin-top: 20px;
        display: flex;
        justify-content: center;
        gap: 5px;
    }

    #pendingPagination button, #confirmedPagination button, 
    #shippedPagination button, #deliveredPagination button, 
    #cancelledPagination button {
        padding: 8px 12px;
        border: 1px solid #ddd;
        background: #fff;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    #pendingPagination button.active, #confirmedPagination button.active, 
    #shippedPagination button.active, #deliveredPagination button.active, 
    #cancelledPagination button.active {
        background: #d32f2f;
        color: white;
        border-color: #d32f2f;
    }

    #pendingPagination button:hover, #confirmedPagination button:hover, 
    #shippedPagination button:hover, #deliveredPagination button:hover, 
    #cancelledPagination button:hover {
        background: #f1f1f1;
    }

    #pendingPagination button:disabled, #confirmedPagination button:disabled, 
    #shippedPagination button:disabled, #deliveredPagination button:disabled, 
    #cancelledPagination button:disabled {
        background: #eee;
        cursor: not-allowed;
        opacity: 0.6;
    }
    
    .search-btn {
            background-color: #007bff;
            border-color: #007bff;
            transition: all 0.3s ease;
        }
        .search-btn:hover {
            background-color: #0056b3;
            border-color: #0056b3;
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
        
        

    /* Responsive */
    @media (max-width: 768px) {
        .user-info .info-item {
            flex: 1 1 100%; /* Trên mobile, mỗi thông tin chiếm 1 dòng */
        }

        .form-group {
            flex: 1 1 100%; /* Trên mobile, mỗi form-group chiếm toàn bộ chiều rộng */
        }

        .form-group label {
            text-align: left; /* Căn trái label trên mobile */
        }

        th, td {
            font-size: 14px;
            padding: 10px;
        }
    }
</style>

    </head>
    <body>


        <!-- Giới hạn chiều rộng bảng -->
        <div class="card shadow-lg mt-4 mx-auto" style="max-width: 900px;">
            <div class="card-header bg-danger text-white text-center">
                <h3 class="mb-0">Thông tin người dùng</h3>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Tên:</strong> ${user.fullName}</p>
                    </div>
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Tài khoản:</strong> ${user.username}</p>
                    </div>
                    
                    
                    
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Email:</strong> ${user.email}</p>
                    </div>
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Ngày tạo:</strong> ${user.registrationDate}</p>
                    </div>
                    
                    
                    
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Số điện thoại:</strong> ${user.phoneNumber}</p>
                    </div>
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Vai trò:</strong> 
                            <span class="badge bg-primary">${user.role}</span>
                        </p>
                    </div>
                    
                    
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Địa chỉ:</strong> ${user.address}</p>
                    </div>
                    
                    
                    <div class="col-12 col-md-6">
                        <p><strong class="text-danger">Trạng thái:</strong> 
                            <span class="badge ${user.locked == 1 ? 'bg-secondary' : 'bg-success'}">
                                ${user.locked == 1 ? 'Bị khóa' : 'Hoạt động'}
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


        <div class="container user-profile">
            <div class="main-body">
                <div class="row" style="margin-top: 30px; margin-bottom: 30px">


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-12 search-container">
                <form action="userDetail" method="GET" class="row g-3">
                    <input type="hidden" id="userId" name="userId" value="${user.userId}">

                    <div class="col-md-6">
                        <label for="orderCode" class="form-label">Mã Đơn Hàng:</label>
                        <input type="text" class="form-control" id="orderCode" name="orderCode" 
                               placeholder="Nhập mã đơn" value="${orderCode}">
                    </div>

                    <div class="col-md-6">
                        <label for="shippingAddress" class="form-label">Địa Chỉ Giao Hàng:</label>
                        <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" 
                               placeholder="Nhập Địa Chỉ Giao Hàng" value="${shippingAddress}">
                    </div>

                    <div class="col-md-6">
                        <label for="paymentMethod" class="form-label">Chọn phương thức thanh toán:</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod">
                            <option value="null" ${paymentMethod == null || paymentMethod == 'null' ? 'selected' : ''}>Tất cả</option>
                            <option value="Chuyển Khoản Ngân Hàng" ${paymentMethod == 'Chuyển Khoản Ngân Hàng' ? 'selected' : ''}>Chuyển Khoản Ngân Hàng</option>
                            <option value="Thẻ Tín Dụng" ${paymentMethod == 'Thẻ Tín Dụng' ? 'selected' : ''}>Thẻ Tín Dụng</option>
                            <option value="Tiền Mặt Khi Nhận Hàng" ${paymentMethod == 'Tiền Mặt Khi Nhận Hàng' ? 'selected' : ''}>Tiền Mặt Khi Nhận Hàng</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label for="sortBy" class="form-label">Sắp xếp:</label>
                        <select class="form-select" id="sortBy" name="sortBy">
                            <option value="default" ${sortBy == null || sortBy == 'default' ? 'selected' : ''}>Mặc định</option>
                            <option value="priceDesc" ${sortBy == 'priceDesc' ? 'selected' : ''}>Tổng Số Tiền giảm dần</option>
                            <option value="priceAsc" ${sortBy == 'priceAsc' ? 'selected' : ''}>Tổng Số Tiền tăng dần</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ngày Đặt Hàng:</label>
                        <div class="date-group">
                            <input type="date" class="form-control" id="fromDate" name="fromDate" value="${fromDate}">
                            <span>-</span>
                            <input type="date" class="form-control" id="toDate" name="toDate" value="${toDate}">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Tổng Số Tiền:</label>
                        <div class="price-group">
                            <input type="number" class="form-control" id="minPrice" name="minPrice" 
                                   placeholder="Giá tối thiểu" value="${minPrice}">
                            <span>-</span>
                            <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                                   placeholder="Giá tối đa" value="${maxPrice}">
                        </div>
                    </div>

                    <div class="col-12 text-center mt-4">
                        <button type="submit" class="btn btn-primary search-btn px-4">Tìm kiếm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


                                    <div class="list-product">
                                        <h2 class="product-title">Danh Sách Đơn Hàng</h2>

                                        <!-- Tabs điều hướng -->
                                        <ul class="nav nav-tabs">
                                            <li class="nav-item">
                                                <a class="nav-link" data-toggle="tab" href="#pending">Chờ xác nhận</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link active" data-toggle="tab" href="#confirmed">Đã xác nhận</a>
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






        <!-- jQuery -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <!-- Popper JS -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <!-- Bootstrap JS -->
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>




        <!-- HTML giữ nguyên, chỉ cập nhật phần script -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
            const itemsPerPage = 4;
                    const tabs = [
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Customer'}">
                    {bodyId: 'pendingOrdersBody', paginationId: 'pendingPagination'},
            </c:if>
                    {bodyId: 'confirmedOrdersBody', paginationId: 'confirmedPagination'},
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
<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>

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
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }

            .container.user-profile {
                margin-top: 20px;
            }

            .card {
                border: none;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1),
                    0 -4px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .card-body {
                padding: 1.5rem;
            }

            .card {
                margin-bottom: 20px; /* Khoảng cách bên dưới thẻ card */
            }



            .d-flex.align-items-center.text-center img.rounded-circle {
                border: 2px solid #D10024;
            }

            .text-secondary {
                color: #6c757d !important;
            }

            .btn {
                padding: 0.5rem 1.5rem;
                border-radius: 20px;
                font-size: 14px;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-outline-primary {
                color: #007bff;
                border: 1px solid #007bff;
                background-color: transparent;
            }

            .card h5 {
                color: #007bff;
                font-size: 1.2rem;
                font-weight: bold;
            }

            .list-group-item {
                border: none;
                padding: 10px 0;
            }

            .list-group-item h6 {
                color: #333;
                font-weight: 600;
            }

            .list-group-item span.text-secondary {
                font-weight: 500;
            }

            .progress-bar {
                height: 6px;
                border-radius: 10px;
            }

            .progress-bar.bg-primary {
                background-color: #007bff;
            }

            .progress-bar.bg-danger {
                background-color: #dc3545;
            }

            .progress-bar.bg-success {
                background-color: #28a745;
            }

            .progress-bar.bg-warning {
                background-color: #ffc107;
            }

            .progress-bar.bg-info {
                background-color: #17a2b8;
            }

            .form-control {
                border-radius: 5px;
                border: 1px solid #ced4da;
                box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            }

            .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            }

            .card-body .row.mb-3 {
                align-items: center;
                padding: 0.5rem 0;
                margin-left: 14px;
                margin-right: 14px;
            }

            .card-body .row.mb-3 h6 {
                font-weight: bold;
                color: #495057;
            }

            .card-body .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
            }

            .user-profile .camera-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 110px; /* Đặt kích thước lớp phủ */
                height: 110px;
                background: rgba(0, 0, 0, 0.5); /* Màu nền đen mờ */
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0; /* Ban đầu ẩn */
                transition: opacity 0.3s ease; /* Hiệu ứng chuyển động */
            }

            .user-profile .profile-image-container {
                position: relative;
                display: inline-block;
            }

            .user-profile .profile-image-container:hover .camera-overlay {
                opacity: 1; /* Hiện lớp phủ khi di chuyển chuột */
            }

            .user-profile .camera-icon {
                color: white;
                font-size: 24px; /* Kích thước biểu tượng */
            }

            .list-product {
                margin: 10px;
                margin-left: 20px;
            }
            table {
                width: 100%; /* Đặt chiều rộng của bảng 100% */
                border-collapse: collapse; /* Gộp các viền lại với nhau */
                font-size: 12px;
            }

            /* Cài đặt cho các ô tiêu đề */
            th {
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                padding: 12px; /* Đệm cho ô tiêu đề */
                text-align: center; /* Căn trái cho chữ */
                vertical-align: middle;
            }

            /* Cài đặt cho các ô dữ liệu */
            td {
                padding: 8px; /* Đệm cho ô dữ liệu */
                text-align: center;
                vertical-align: middle;
            }

            /* Thay đổi màu nền khi rê chuột qua hàng */
            tr:hover {
                background-color: #f5f5f5; /* Màu nền khi rê chuột */
            }

            /* Cài đặt cho hàng lẻ */
            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng lẻ */
            }

            /* Cài đặt cho hình ảnh trong bảng */
            img {
                border-radius: 5px; /* Bo tròn góc cho hình ảnh */
            }
            /* Cài đặt cho tiêu đề sản phẩm */
            .product-title {
                font-size: 18px; /* Kích thước chữ */
                color: #333; /* Màu chữ */
                text-align: center; /* Căn giữa tiêu đề */
            }

            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-bottom: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }
            .action-link {
                text-decoration: none; /* Bỏ gạch chân */
                padding: 8px 12px; /* Khoảng cách bên trong */
                border-radius: 4px; /* Bo góc */
                color: white; /* Màu chữ */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .btn-edit {
                background-color: #4CAF50; /* Màu xanh lá cây cho nút sửa */
            }

            .btn-delete {
                background-color: #f44336; /* Màu đỏ cho nút xóa */
            }

            .btn-edit:hover {
                background-color: #45a049; /* Màu xanh lá cây đậm khi hover */
            }

            .btn-delete:hover {
                background-color: #e53935; /* Màu đỏ đậm khi hover */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }

            .table-responsive {
                max-height: 283px; /* Chiều cao tối đa của bảng */
                overflow-y: auto; /* Thêm thanh cuộn dọc khi vượt quá chiều cao tối đa */
                overflow-x: hidden; /* Ẩn thanh cuộn ngang (tuỳ chọn) */
            }

            table {
                width: 100%; /* Đảm bảo bảng chiếm hết chiều rộng của div chứa */
                border-collapse: collapse; /* Kết hợp biên bảng */
            }

            th {
                position: sticky; /* Giữ tiêu đề cố định */
                top: 0; /* Vị trí dính lại trên cùng */
                z-index: 1; /* Đặt độ ưu tiên để không bị che khuất */
            }

            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng chẵn */
            }

            h2{
                margin: 0px;
                margin-bottom: 10px;
            }

            .form-select {
                padding: 8px 12px;
                font-size: 14px;
                color: #333; /* Màu chữ */
                background-color: #f8f9fa; /* Màu nền */
                border: 1px solid #ced4da; /* Viền */
                border-radius: 5px; /* Bo tròn góc */
                appearance: none; /* Ẩn mũi tên mặc định của select */
                -webkit-appearance: none; /* Ẩn mũi tên cho trình duyệt Webkit */
                -moz-appearance: none; /* Ẩn mũi tên cho trình duyệt Firefox */
                margin-left: 15px;
            }

            .form-select-sm {
                font-size: 13px; /* Kích thước chữ nhỏ */
            }

            .form-select:hover {
                background-color: #e9ecef; /* Đổi màu nền khi hover */
                border-color: #adb5bd; /* Đổi màu viền khi hover */
            }

            .form-select:focus {
                outline: none; /* Xóa viền focus mặc định */
                border-color: #80bdff; /* Màu viền khi focus */
                box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); /* Tạo hiệu ứng viền sáng khi focus */
            }

            .message-success {
                color: green;
                font-weight: bold;
                padding: 10px;
                background-color: #e6ffed;
                border: 1px solid #66cc66;
                border-radius: 5px;
                margin-top: 10px;
            }

            /* CSS cho thông báo lỗi */
            .message-error {
                color: red;
                font-weight: bold;
                padding: 10px;
                background-color: #ffe6e6;
                border: 1px solid #ff6666;
                border-radius: 5px;
                margin-top: 10px;
            }

            .review-form {
                background-color: #fff;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #666;
                font-size: 14px;
            }
            .product-info {
                margin-bottom: 20px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .product-image {
                max-width: 200px;
                height: auto;
                margin-bottom: 10px;
            }
            .star-rating {
                display: flex;
                gap: 5px;
                margin-bottom: 10px;
            }
            .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.3s ease;
            }
            .star.active {
                color: #ffd700;
            }
            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
                height: 100px;
                resize: vertical;
            }
            .file-input {
                margin-top: 5px;
            }
            .submit-btn {
                background-color: #ffd700;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            .submit-btn:hover {
                background-color: #e0a400;
            }
            .note {
                color: #888;
                font-size: 12px;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp"/>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="home">Trang Chủ</a></li>
                        <li><a href="/product">Danh Mục</a></li>
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
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <form action="updateAvatar" method="POST" enctype="multipart/form-data" multiple required>
                                        <div class="profile-image-container">
                                            <label for="profileImage" style="cursor: pointer;">
                                                <img style="margin: 10px; cursor: pointer;" 
                                                     src="${user.profileImageURL != null && user.profileImageURL != '' ? 
                                                            user.profileImageURL : 'https://cellphones.com.vn/sforum/wp-content/uploads/2023/10/avatar-trang-4.jpg'}" 
                                                     alt="Profile Image" class="rounded-circle p-1 bg-primary" width="110" height="110px">
                                                <input type="file" id="profileImage" name="profileImageURL" accept="image/*" style="display: none;" onchange="updateAvatar()">

                                                <div class="camera-overlay" style="margin: 10px;">
                                                    <i class="fas fa-camera camera-icon"></i>
                                                </div>
                                            </label>
                                        </div>
                                    </form>
                                    <div class="mt-3">
                                        <h4>${user.fullName}</h4>
                                        <p class="text-secondary mb-1">${user.role}</p>
                                        <p class="text-muted font-size-sm">${user.address}</p>
                                    </div>
                                </div>
                                <hr class="my-4">
                                <ul class="list-group list-group-flush">
                                    <h2 class="product-title">Đổi mật khẩu</h2>
                                    <form action="changePassword" method="POST" onsubmit="return validatePasswordChange()">
                                        <div class="row mb-3">
                                            <div class="col-sm-12">
                                                <h6 class="mb-0">Mật khẩu cũ</h6>
                                            </div>
                                            <div class="col-sm-12 text-secondary">
                                                <input type="password" class="form-control" name="password" required>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-sm-12">
                                                <h6 class="mb-0">Mật khẩu mới</h6>
                                            </div>
                                            <div class="col-sm-12 text-secondary">
                                                <input type="password" class="form-control" name="newPassword" required>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-sm-12">
                                                <h6 class="mb-0">Xác nhận mật khẩu mới</h6>
                                            </div>
                                            <div class="col-sm-12 text-secondary">
                                                <input type="password" class="form-control" name="confirmNewPassword" required>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-9 text-secondary " style="margin-top: 10px">
                                                <button type="submit" class="btn btn-primary px-4">Lưu thay đổi</button>
                                            </div>
                                        </div>
                                    </form>

                                    <c:if test="${not empty message}">
                                        <p class="${message == 'Đổi mật khẩu thành công.' ? 'message-success' : 'message-error'}">
                                            ${message}
                                        </p>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <div class="col-lg-8">

                        <form action="updateProfile" method="POST" onsubmit="return validateProfileForm()">
                            <div class="card">
                                <hr>
                                <h2 class="product-title">Hồ sơ của tôi</h2>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Tên</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Email</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="email" class="form-control" name="email" value="${user.email}" required>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Số điện thoại</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="phoneNumber" value="${user.phoneNumber}" required>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Địa chỉ</h6>
                                        </div>
                                        <select name="city" class="form-select form-select-sm mb-3" id="city" aria-label=".form-select-sm">
                                            <option value="${address != null && address.size() > 3 ? address.get(3) : ''}" selected>Tỉnh Thành</option>
                                        </select>

                                        <select name="district" class="form-select form-select-sm mb-3" id="district" aria-label=".form-select-sm">
                                            <option value="${address != null && address.size() > 2 ? address.get(2) : ''}" selected>Quận Huyện</option>
                                        </select>

                                        <select name="ward" class="form-select form-select-sm" id="ward" aria-label=".form-select-sm">
                                            <option value="${address != null && address.size() > 1 ? address.get(1) : ''}" selected>Xã Phường</option>
                                        </select>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Địa chỉ cụ thể</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="addressDetail" value="${address != null && address.size() > 0 ? address.get(0) : ""}" required>
                                        </div>
                                    </div>

                                    <div class="row" style="margin-top: 10px">
                                        <div class="col-sm-3"></div>
                                        <div class="col-sm-9 text-secondary">
                                            <button type="submit" class="btn btn-primary px-4">Lưu thay đổi</button>
                                        </div>
                                        <div class="col-sm-6 text-secondary">
                                            <c:if test="${not empty message1}">
                                                <p class="${message1 == 'Cập nhật hồ sơ thành công.' ? 'message-success' : 'message-error'}">
                                                    ${message1}
                                                </p>
                                            </c:if>
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                            </div>
                        </form>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="list-product">
                                            <h2 class="product-title">Danh Sách Đơn Hàng</h2>
                                            <div class="table-responsive">
                                                <table border="1">
                                                    <tr>
                                                        <th>Mã Đơn Hàng</th>
                                                        <th>Ngày Đặt Hàng</th>
                                                        <th>Tổng Số Tiền</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Phương Thức Thanh Toán</th>
                                                        <th>Địa Chỉ Giao Hàng</th>
                                                        <th>Chi Tiết</th>
                                                        <th>Đánh Giá</th>
                                                    </tr>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td>${order.orderCode}</td>
                                                            <td>${order.orderDate}</td>
                                                            <td>${order.totalAmount}</td>
                                                            <td>${order.orderStatus}</td>
                                                            <td>${order.paymentMethod}</td>
                                                            <td>${order.shippingAddress}</td>
                                                            <td><a href="orderDetail?id=${order.orderId}">Chi Tiết</a></td>
                                                            <td>
                                                                <button type="button" class="btn btn-info btn-round" data-toggle="modal" data-target="#reviewModal" 
                                                                        data-orderid="${order.orderId}" 
                                                                        ${order.orderStatus != 'Delivered' ? 'disabled' : ''}>
                                                                    Đánh Giá
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </table>
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

        <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-bottom-0">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-title text-center">
                            <h4>Đánh Giá Sản Phẩm</h4>
                            <p id="modalResult"></p>
                        </div>
                        <div class="d-flex flex-column text-center">
                            <form action="addReview" method="POST" class="review-form" enctype="multipart/form-data" style="text-align: start">
                                <div class="form-group product-info">
                                    <label>Chọn sản phẩm để đánh giá:</label>
                                    <select name="productID" id="productSelect" required>
                                        <option value="" disabled selected>Chọn một sản phẩm</option>
                                        <!-- Danh sách sản phẩm sẽ được thêm bằng JS -->
                                    </select>
                                    <!-- Input ẩn cho productID -->

                                    <div class="selected-product-info" id="selectedProductInfo" style="display: none;">
                                        <img id="selectedProductImage" src="" alt="Selected Product" class="product-image">
                                        <p id="selectedProductName"></p>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="rating">Your Rating * :</label>
                                    <div class="star-rating" id="starRating">
                                        <span class="star" data-value="1">★</span>
                                        <span class="star" data-value="2">★</span>
                                        <span class="star" data-value="3">★</span>
                                        <span class="star" data-value="4">★</span>
                                        <span class="star" data-value="5">★</span>
                                    </div>
                                    <input type="hidden" name="rating" id="ratingValue" value="">
                                </div>

                                <div class="form-group">
                                    <label for="review">Your Review * :</label>
                                    <textarea id="review" name="review"></textarea>
                                </div>

                                <div class="form-group">
                                    <label>Upload Media (Optional):</label>
                                    <input type="file" name="media" class="file-input" accept="image/*,video/*" multiple>
                                    <input type="hidden" name="mediaType" id="mediaType">
                                </div>

                                <button type="submit" class="submit-btn">Leave Your Review</button>
                            </form>
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


        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const buttons = document.querySelectorAll(".btn-info"); // Nút "Đánh Giá"
                buttons.forEach(function (button) {
                    button.addEventListener("click", function (event) {
                        event.preventDefault(); // Ngăn chặn hành động mặc định

                        // Lấy orderID từ data attribute của nút
                        var orderID = button.getAttribute('data-orderid');

                        // Gửi request AJAX
                        fetch("getProductsByOrderID", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: "orderID=" + orderID
                        })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.error) {
                                        alert("Error: " + data.error);
                                    } else {
                                        // Làm sạch danh sách sản phẩm trong select trước khi thêm sản phẩm mới
                                        const productSelect = document.getElementById("productSelect");
                                        productSelect.innerHTML = '<option value="" disabled selected>Chọn một sản phẩm</option>'; // reset

                                        // Duyệt qua danh sách sản phẩm và thêm các option vào select
                                        data.forEach(product => {
                                            let option = document.createElement("option");
                                            option.value = product.productID;  // Sử dụng productID
                                            option.textContent = product.productName;  // Hiển thị tên sản phẩm
                                            productSelect.appendChild(option);
                                        });

                                        // Hiển thị thông tin và gán productID khi chọn sản phẩm
                                        productSelect.addEventListener('change', function () {
                                            const selectedProductId = productSelect.value;
                                            const selectedProduct = data.find(p => p.productID == selectedProductId);

                                            if (selectedProduct) {
                                                // Hiển thị hình ảnh và tên sản phẩm đã chọn
                                                document.getElementById("selectedProductImage").src = selectedProduct.imageURL;
                                                document.getElementById("selectedProductName").textContent = selectedProduct.productName;
                                                document.getElementById("selectedProductInfo").style.display = "block";
                                            }
                                        });
                                    }
                                })
                                .catch(error => {
                                    alert("Có lỗi xảy ra!");
                                });
                    });
                });

                // Reset lại thông tin modal khi đóng hoặc khi mở modal mới
                function resetModal() {
                    // Reset lại các trường thông tin trong modal
                    document.getElementById("modalResult").innerText = "";
                    document.getElementById("productSelect").value = ""; // Reset chọn sản phẩm
                    document.getElementById("selectedProductImage").src = ""; // Reset hình ảnh
                    document.getElementById("selectedProductName").textContent = ""; // Reset tên sản phẩm
                    document.getElementById("selectedProductInfo").style.display = "none"; // Ẩn thông tin sản phẩm
                    document.getElementById("hiddenProductID").value = ""; // Reset productID
                }

                // Đóng modal khi bấm vào nút X
                document.querySelector(".close").addEventListener("click", function () {
                    $('#reviewModal').modal('hide');
                    resetModal(); // Reset thông tin modal khi đóng
                });

                // Đóng modal khi bấm ra ngoài
                window.onclick = function (event) {
                    var modal = document.getElementById("reviewModal");
                    if (event.target === modal) {
                        $('#reviewModal').modal('hide');
                        resetModal(); // Reset thông tin modal khi đóng
                    }
                };

                // Reset padding-right khi đóng modal
                $('#reviewModal').on('hidden.bs.modal', function () {
                    $('body').css('padding-right', ''); // Xóa padding-right khi modal đóng
                });
            });
        </script>

        <script>
            document.querySelector('.file-input').addEventListener('change', function (event) {
                var files = event.target.files;  // Lấy tất cả các file được chọn
                var mediaTypes = [];  // Mảng lưu loại media (image, video, or other)

                // Duyệt qua từng file và xác định loại
                Array.from(files).forEach(file => {
                    var fileType = file.type;

                    // Kiểm tra kiểu file và thêm vào mảng mediaTypes
                    if (fileType.startsWith('image/')) {
                        mediaTypes.push('image');
                    } else if (fileType.startsWith('video/')) {
                        mediaTypes.push('video');
                    } else {
                        mediaTypes.push('other'); // Nếu là loại file khác
                    }
                });
                console.log('Media Types:', mediaTypes);
                // Cập nhật giá trị vào input ẩn (dùng để gửi qua form)
                document.getElementById('mediaType').value = JSON.stringify(mediaTypes);  // Chuyển mảng thành JSON string
            });
        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
            var citis = document.getElementById("city");
            var districts = document.getElementById("district");
            var wards = document.getElementById("ward");
            var Parameter = {
                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                method: "GET",
                responseType: "application/json",
            };
            var promise = axios(Parameter);
            promise.then(function (result) {
                renderCity(result.data);
            });
            function renderCity(data) {
                for (const x of data) {
                    // Đặt value thành tên thay vì ID
                    citis.options[citis.options.length] = new Option(x.Name, x.Name);
                }
                citis.onchange = function () {
                    districts.length = 1;
                    wards.length = 1;
                    if (this.value != "") {
                        const result = data.filter(n => n.Name === this.value);
                        for (const k of result[0].Districts) {
                            // Đặt value thành tên thay vì ID
                            districts.options[districts.options.length] = new Option(k.Name, k.Name);
                        }
                    }
                };
                districts.onchange = function () {
                    wards.length = 1;
                    const dataCity = data.filter((n) => n.Name === citis.value);
                    if (this.value != "") {
                        const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;
                        for (const w of dataWards) {
                            // Đặt value thành tên thay vì ID
                            wards.options[wards.options.length] = new Option(w.Name, w.Name);
                        }
                    }
                };
            }
        </script>
        <script>
            document.getElementById('profileImage').addEventListener('change', function () {
                const form = this.closest('form'); // Lấy form bao quanh
                form.submit(); // Gửi form
            });
        </script>
        <script>
            function validatePasswordChange() {
                // Lấy các giá trị từ các ô nhập liệu
                var oldPassword = document.getElementsByName("password")[0].value;
                var newPassword = document.getElementsByName("newPassword")[0].value;
                var confirmNewPassword = document.getElementsByName("confirmNewPassword")[0].value;
                var phoneNumber = document.getElementsByName("phoneNumber")[0].value;
                // Kiểm tra mật khẩu mới và mật khẩu xác nhận có khớp không
                if (newPassword !== confirmNewPassword) {
                    alert("Mật khẩu mới và xác nhận mật khẩu không khớp.");
                    return false; // Không cho phép gửi form
                }

                // Kiểm tra mật khẩu cũ phải khác mật khẩu mới
                if (oldPassword === newPassword) {
                    alert("Mật khẩu cũ không được giống mật khẩu mới.");
                    return false; // Không cho phép gửi form
                }

                // Kiểm tra mật khẩu mới có ít nhất 6 ký tự, bao gồm ít nhất 1 chữ cái và 1 chữ số
                var passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
                if (!passwordPattern.test(newPassword)) {
                    alert("Mật khẩu mới cần có ít nhất 6 ký tự, bao gồm ít nhất 1 chữ cái và 1 chữ số.");
                    return false; // Không cho phép gửi form
                }


                // Nếu tất cả các điều kiện đều đúng, cho phép gửi form
                return true;
            }
        </script>

        <script>
            function validateProfileForm() {
                // Lấy giá trị số điện thoại từ ô nhập liệu
                var phoneNumber = document.getElementsByName("phoneNumber")[0].value;
                // Kiểm tra số điện thoại có đúng 10 chữ số
                var phonePattern = /^\d{10}$/;
                if (!phonePattern.test(phoneNumber)) {
                    alert("Số điện thoại phải gồm 10 chữ số.");
                    return false; // Không cho phép gửi form nếu không đúng định dạng
                }
                // Nếu tất cả các điều kiện đều đúng, cho phép gửi form
                return true;
            }
        </script>

        <script>
            $(document).ready(function () {
                $('#loginModal').modal('show');
                $(function () {
                    $('[data-toggle="tooltip"]').tooltip()
                })
            });
        </script>
        <!-- jQuery -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <!-- Popper JS -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <!-- Bootstrap JS -->
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>

        <script>
            const stars = document.querySelectorAll('.star');
            const ratingInput = document.getElementById('ratingValue');
            stars.forEach(star => {
                star.addEventListener('click', function () {
                    const value = this.getAttribute('data-value');
                    ratingInput.value = value;
                    stars.forEach(s => s.classList.remove('active'));
                    this.classList.add('active');
                    for (let i = 0; i < value; i++) {
                        stars[i].classList.add('active');
                    }
                });
                star.addEventListener('mouseover', function () {
                    const value = this.getAttribute('data-value');
                    stars.forEach((s, index) => {
                        if (index < value)
                            s.classList.add('active');
                        else
                            s.classList.remove('active');
                    });
                });
                star.addEventListener('mouseout', function () {
                    stars.forEach(s => s.classList.remove('active'));
                    const currentRating = ratingInput.value;
                    if (currentRating) {
                        for (let i = 0; i < currentRating; i++) {
                            stars[i].classList.add('active');
                        }
                    }
                });
            });
        </script>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
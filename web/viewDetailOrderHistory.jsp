<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin đơn hàng</title>
        <link rel="stylesheet" href="styles.css"> <!-- Optional: add your custom styles -->
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

        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <%@ include file="header.jsp" %>

    </head>
    <body>
        <style type="text/css">
            /* Thu hẹp chiều rộng và cải tiến phần thông tin người nhận */
            .user-profile {
                width: 90%; /* Thu hẹp chiều rộng */
                max-width: 800px; /* Giới hạn chiều rộng tối đa */
                background-color: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                margin: 30px auto; /* Căn giữa và tạo khoảng cách với các phần khác */
                margin-top: 30px;
                border-left: 8px solid #ff5722; /* Viền đậm hơn với màu đỏ cam */
            }

            /* Tiêu đề thông tin người nhận */
            .user-profile h3 {
                font-size: 20px;
                color: #333;
                font-weight: 700; /* Chữ in đậm hơn */
                margin-bottom: 12px;
            }

            /* Cải tiến bảng đơn hàng */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 15px;
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 10px 15px; /* Giảm padding để bảng gọn hơn */
                text-align: left;
                border-bottom: 2px solid #ff5722; /* Đổi màu viền bảng sang đỏ cam */
                font-weight: 700; /* Chữ trong bảng đậm hơn */
            }

            th {
                background-color: #ff5722; /* Màu nền đỏ cam cho header bảng */
                color: white;
                text-transform: uppercase;
                font-size: 14px;
            }

            td {
                background-color: #f9f9f9;
                font-size: 14px;
            }

            td img {
                width: 70px;
                height: 70px;
                object-fit: cover;
                border-radius: 4px;
            }

            /* Phần vận chuyển và tổng tiền */
            .user-profile div p {
                font-size: 16px;
                color: #555;
                margin-bottom: 10px;
            }

            /* Khung cho phần vận chuyển và tổng tiền */
            .user-profile div {
                padding: 15px;
                border: 2px solid #ff5722; /* Viền đỏ cam đậm cho phần vận chuyển và tổng tiền */
                border-radius: 8px;
                background-color: #fff;
                margin-top: 15px;
                margin-bottom: 15px;
            }

            /* Footer */
            footer {
                padding: 10px 0;
                text-align: center;
                background-color: #ff5722; /* Màu nền đỏ cam cho footer */
                color: white;
                font-size: 16px;
                border-radius: 8px;
                margin-top: 20px;
            }

            /* Responsive: Thu nhỏ giao diện trên thiết bị di động */
            @media screen and (max-width: 768px) {
                .user-profile {
                    width: 100%; /* Đảm bảo rằng đơn hàng sẽ chiếm toàn bộ chiều rộng màn hình di động */
                    margin-top: 20px;
                }

                table {
                    font-size: 12px;
                }

                td img {
                    width: 60px;
                    height: 60px;
                }
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
            
            /* Style cho nút Trở về */
            .back-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #ff5722; /* Màu đỏ cam đồng bộ với giao diện */
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.3s ease;
                margin-top: 15px;
                text-align: center;
            }
            .back-btn:hover {
                background-color: #e64a19; /* Màu tối hơn khi hover */
                color: white;
                text-decoration: none;
            }
        </style>
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
        
        <a href="./userOrder" class="back-btn"><i class="fa fa-arrow-left"></i> Trở về</a>
        
        <div class="user-profile-page">
            <div class="container user-profile">
                <h1>Thông tin đơn hàng</h1>

                <!-- User's Information -->
                <div>
                    <h3>Thông tin người nhận</h3>
                    <p>Tên người nhận: ${orderContact.recipientName}</p>
                    <p>Địa chỉ: ${order.shippingAddress}</p>
                    <p>Số điện thoại: ${orderContact.recipientPhone}</p>
                    <p>Ghi chú: ${orderContact.note}</p>
                </div>

                <!-- Order Details -->
                <table border="1">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Ảnh sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Số tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Lặp qua orderDetails và lấy thông tin sản phẩm -->
                        <c:forEach var="orderDetail" items="${orderDetails}">
                            <tr>
                                <td>${orderDetail.product.productName}</td>
                                <!-- Hiển thị ảnh sản phẩm -->
                                <td><img src="${orderDetail.product.imageURL}" alt="Product Image" width="100" height="100" /></td>
                                <td>${orderDetail.price} $</td>
                                <td>${orderDetail.quantity}</td>
                                <td>${orderDetail.price * orderDetail.quantity} $</td>
                                <td>
                                    <button type="button" class="btn btn-info btn-round" data-toggle="modal" data-target="#reviewModal" 
                                            data-orderid="${order.orderId}" 
                                            data-productid="${orderDetail.product.productID}" 
                                            data-productname="<c:out value='${orderDetail.product.productName}'/>" 
                                            data-imageurl="${orderDetail.product.imageURL}"
                                            ${order.orderStatus != 'Delivered' ? 'disabled' : ''}>
                                        Đánh Giá
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Shipping and Total -->
                <div>
                    <p>Vận chuyển: 0 đ</p>
                    <p>Tổng: ${order.totalAmount} đ</p>
                </div>

                <!-- Footer -->
                <footer>
                    <p>Phương thức thanh toán: ${order.paymentMethod}</p>
                </footer>
            </div>
        </div>

        <%@ include file="blank.jsp" %>


    </body>
</html>

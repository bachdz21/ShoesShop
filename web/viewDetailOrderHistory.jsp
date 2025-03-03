<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin đơn hàng</title>
        <link rel="stylesheet" href="styles.css"> <!-- Optional: add your custom styles -->
    </head>
    <body>
        <style type="text/css">
            /* Reset some basic styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Set background and font colors */
            body {
                font-family: Arial, sans-serif;
                background-color: #fff;
                color: #333;
            }

            /* Center the content with a max-width container */
            .container {
                width: 60%; /* Giới hạn chiều rộng trang */
                max-width: 1200px; /* Đảm bảo không quá rộng */
                margin: 40px auto; /* Căn giữa nội dung */
                padding: 20px;
            }

            /* Header style */
            h1 {
                text-align: center;
                color: #d32f2f; /* Màu đỏ */
                font-size: 36px;
                padding: 20px 0;
            }

            /* User info container */
            div {
                margin: 20px;
                padding: 10px;
                border: 2px solid #d32f2f;
                border-radius: 8px;
                background-color: #f8f8f8;
            }

            h3 {
                color: #d32f2f;
                font-size: 24px;
                margin-bottom: 10px;
            }

            /* Table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table th, table td {
                padding: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }

            table th {
                background-color: #d32f2f;
                color: white;
            }

            table td {
                background-color: #fff;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            /* Shipping and total section */
            div p {
                font-size: 18px;
                margin: 10px 0;
                color: #333;
            }

            footer {
                text-align: center;
                margin-top: 20px;
                padding: 10px;
                background-color: #d32f2f;
                color: white;
                font-size: 18px;
                border-radius: 5px;
            }

        </style>

        <div class="container">
            <h1>Thông tin đơn hàng</h1>

            <!-- User's Information -->
            <div>
                <h3>Thông tin người nhận</h3>
                <p>Tên người nhận: ${user.fullName}</p>
                <p>Địa chỉ: ${user.address}</p>
                <p>Số điện thoại: ${user.phoneNumber}</p>
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
                            <td>${orderDetail.product.price} đ</td>
                            <td>${orderDetail.quantity}</td>
                            <td>${orderDetail.price} đ</td>
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


    </body>
</html>

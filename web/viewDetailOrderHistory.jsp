<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
        <style>
            :root {
                --primary-color: #d32f2f;
                --primary-light: #ffcdd2;
                --primary-dark: #b71c1c;
                --secondary-color: #f8f9fa;
                --text-color: #333;
                --border-color: #e0e0e0;
                --success-color: #689f38;
                --light-gray: #f5f5f5;
            }
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Roboto', Arial, sans-serif;
            }
            
            body {
                background-color: var(--light-gray);
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }
            
            .container {
                max-width: 1000px;
                margin: 0 auto;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }
            
            header {
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }
            
            h1 {
                color: red;
                font-size: 28px;
                margin-bottom: 10px;
            }
            
            h3 {
                color: red;
                font-size: 20px;
                margin: 25px 0 15px 0;
                padding-bottom: 8px;
                border-bottom: 1px solid var(--border-color);
            }
            
            .nav-buttons {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .back-btn {
                display: inline-flex;
                align-items: center;
                padding: 10px 15px;
                background-color: red;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 500;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }
            
            .back-btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }
            
            .back-btn i {
                margin-right: 8px;
            }
            
            .info-card {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-bottom: 25px;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
                border-left: 4px solid red;
            }
            
            .info-item {
                margin-bottom: 12px;
                display: flex;
                align-items: center;
            }
            
            .info-item i {
                margin-right: 10px;
                color: red;
                width: 20px;
                text-align: center;
            }
            
            .info-item:last-child {
                margin-bottom: 0;
            }
            
            .product-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0 30px;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }
            
            .product-table th {
                background-color:red;
                color: white;
                font-weight: 500;
                text-align: left;
                padding: 15px;
            }
            
            .product-table td {
                padding: 15px;
                border-bottom: 1px solid var(--border-color);
                vertical-align: middle;
            }
            
            .product-table tr:last-child td {
                border-bottom: none;
            }
            
            .product-table tr:nth-child(even) {
                background-color: var(--secondary-color);
            }
            
            .product-table tr:hover {
                background-color: rgba(211, 47, 47, 0.05);
            }
            
            .product-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 4px;
                border: 1px solid var(--border-color);
            }
            
            .price {
                font-weight: 500;
                color: red;
            }
            
            .total-price {
                font-weight: 700;
                color: var(--primary-dark);
            }
            
            .button {
                display: inline-block;
                padding: 8px 15px;
                background-color: red;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.2s;
            }
            
            .button:hover {
                background-color: var(--primary-dark);
            }
            
            .button:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }
            
            .summary-section {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                align-items: center;
            }
            
            .summary-item {
                display: flex;
                flex-direction: column;
            }
            
            .summary-label {
                font-size: 14px;
                color: #757575;
            }
            
            .summary-value {
                font-size: 18px;
                font-weight: 700;
                color: red;
            }
            
            .order-status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 50px;
                font-size: 14px;
                font-weight: 500;
                background-color: var(--primary-light);
                color: var(--primary-dark);
            }
            
            .order-delivered {
                background-color: rgba(104, 159, 56, 0.2);
                color: var(--success-color);
            }
            
            footer {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .payment-method {
                display: flex;
                align-items: center;
            }
            
            .payment-method i {
                margin-right: 10px;
                color: red;
            }
            
            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }
                
                .nav-buttons {
                    flex-direction: column;
                    width: 100%;
                }
                
                .back-btn {
                    width: 100%;
                    justify-content: center;
                }
                
                .product-table {
                    display: block;
                    overflow-x: auto;
                }
                
                .summary-section {
                    flex-direction: column;
                    gap: 15px;
                    align-items: flex-start;
                }
                
                footer {
                    flex-direction: column;
                    gap: 15px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <header>
                <h1><i class="fas fa-receipt"></i> Chi tiết đơn hàng</h1>
                <div class="order-status ${order.orderStatus == 'Delivered' ? 'order-delivered' : ''}">
                    <i class="fas fa-${order.orderStatus == 'Delivered' ? 'check-circle' : 'clock'}"></i>
                    ${order.orderStatus}
                </div>
            </header>
            
            <div class="nav-buttons">
                <a href="./userOrder" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Trở về danh sách đơn hàng
                </a>
                <a href="./shippingInformation?orderId=${order.orderId}" class="back-btn">
                    <i class="fas fa-shipping-fast"></i> Thông tin vận chuyển
                </a>
            </div>
            
            <!-- Thông tin người nhận -->
            <div class="info-card">
                <h3><i class="fas fa-user-circle"></i> Thông tin người nhận</h3>
                <div class="info-item">
                    <i class="fas fa-user"></i>
                    <span><strong>Tên người nhận:</strong> ${orderContact.recipientName}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span><strong>Địa chỉ:</strong> ${order.shippingAddress}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-phone"></i>
                    <span><strong>Số điện thoại:</strong> ${orderContact.recipientPhone}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-sticky-note"></i>
                    <span><strong>Ghi chú:</strong> ${orderContact.note != null && !orderContact.note.isEmpty() ? orderContact.note : 'Không có ghi chú'}</span>
                </div>
            </div>
            
            <!-- Chi tiết sản phẩm -->
            <h3><i class="fas fa-box-open"></i> Chi tiết sản phẩm</h3>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Ảnh</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Tổng tiền</th>
                        <th>Đánh giá</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="orderDetail" items="${orderDetails}">
                        <tr>
                            <td>${orderDetail.product.productName}</td>
                            <td>
                                <img src="${orderDetail.product.imageURL}" alt="${orderDetail.product.productName}" class="product-img" />
                            </td>
                            <td class="price">${orderDetail.price} $</td>
                            <td>${orderDetail.quantity}</td>
                            <td class="total-price">${orderDetail.price * orderDetail.quantity} $</td>
                            <td>
                                <button type="button" class="button" data-toggle="modal" data-target="#reviewModal" 
                                        data-orderid="${order.orderId}" 
                                        data-productid="${orderDetail.product.productID}" 
                                        data-productname="<c:out value='${orderDetail.product.productName}'/>" 
                                        data-imageurl="${orderDetail.product.imageURL}"
                                        ${order.orderStatus != 'Delivered' ? 'disabled' : ''}>
                                    <i class="fas fa-star"></i> Đánh giá
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <!-- Tổng kết đơn hàng -->
            <div class="summary-section">
                <div class="summary-item">
                    <span class="summary-label">Phí vận chuyển</span>
                    <span class="summary-value">0 đ</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Tổng tiền hàng</span>
                    <span class="summary-value">${order.totalAmount} đ</span>
                </div>
            </div>
            
            <!-- Footer -->
            <footer>
                <div class="payment-method">
                    <i class="fas fa-money-bill-wave"></i>
                    <span><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</span>
                </div>
                <div>
                    <span><strong>Mã đơn hàng:</strong> #${order.orderCode}</span>
                </div>
            </footer>
        </div>
    </body>
</html>
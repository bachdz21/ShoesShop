<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin vận chuyển</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
        <style>
            :root {
                --primary-color: #4285f4;
                --secondary-color: #f8f9fa;
                --accent-color: #34a853;
                --danger-color: #ea4335;
                --text-color: #333;
                --border-color: #e0e0e0;
            }
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
                background-color: #f8f9fa;
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }

            header {
                text-align: center;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
            }

            h1 {
                color: red;
                font-size: 28px;
                margin-bottom: 10px;
            }

            h2 {
                color: var(--text-color);
                font-size: 20px;
                margin: 25px 0 15px 0;
                padding-bottom: 8px;
                border-bottom: 1px solid var(--border-color);
            }

            .info-card {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }

            .info-item {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .info-item i {
                margin-right: 10px;
                color: red;
                width: 20px;
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 12px 15px;
                text-align: left;
            }

            th {
                background-color: red;
                color: white;
                font-weight: 500;
            }

            tr:nth-child(even) {
                background-color: var(--secondary-color);
            }

            tr:hover {
                background-color: rgba(66, 133, 244, 0.05);
            }

            .status-pill {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 50px;
                font-size: 14px;
                font-weight: 500;
                background-color: #e0e0e0;
            }

            .form-container {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-top: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 10px;
                border: 1px solid var(--border-color);
                border-radius: 4px;
                font-size: 16px;
            }

            .button {
                display: inline-block;
                padding: 10px 20px;
                margin: 5px;
                background-color: red;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                transition: background-color 0.2s;
            }

            .button:hover {
                background-color: #3367d6;
            }

            .button-success {
                background-color: var(--accent-color);
            }

            .button-success:hover {
                background-color: #2d9247;
            }

            .button-danger {
                background-color: var(--danger-color);
            }

            .button-danger:hover {
                background-color: #d33426;
            }

            .empty-state {
                text-align: center;
                padding: 30px;
                color: #757575;
                font-style: italic;
            }

            .btn-container {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 15px;
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
                margin-bottom: 10px;

            }

            .back-btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .back-btn i {
                margin-right: 8px;
            }

            .btn-wrapper {
                display: flex;
                gap: 10px; /* Tạo khoảng cách giữa các form */
                align-items: center; /* Canh các phần tử trên cùng một hàng */
            }

            .btn-container {
                display: flex;
                gap: 10px;
            }

            .button {
                flex: 1; /* Để các nút có kích thước đều nhau */
                padding: 10px 20px;
                background-color: #4285f4; /* Màu xanh dương cho nút cập nhật */
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 500;
                text-align: center;
                transition: background-color 0.2s;
            }

            .button:hover {
                background-color: #3367d6;
            }

            .button-danger {
                background-color: #ea4335; /* Màu đỏ */
            }

            .button-danger:hover {
                background-color: #d33426;
            }

            .button-success {
                background-color: #34a853; /* Màu xanh lá */
            }

            .button-success:hover {
                background-color: #2d9247;
            }


            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .button {
                    width: 100%;
                    margin: 5px 0;
                }

                .btn-container {
                    flex-direction: column;
                }
            }

        </style>
    </head>
    <body>
        <div class="container">
            <header>
                <h1><i class="fas fa-shipping-fast"></i> Thông tin vận chuyển</h1>
            </header>

            <div class="nav-buttons">
                <a href="./orderDetail?orderId=${order.orderId}" class="back-btn">
                    <i class="fas fa-receipt"></i> Chi tiết đơn hàng
                </a>
                <a href="./userOrder" class="back-btn">
                    <i class="fas fa-arrow-circle-right"></i>  danh sách đơn hàng
                </a>
            </div>

            <!-- Thông tin Shipper -->
            <div class="info-card">
                <h2><i class="fas fa-user-circle"></i> Shipper phụ trách</h2>
                <div class="info-item">
                    <i class="fas fa-user"></i>
                    <span><strong>Họ tên:</strong> ${shipper.fullName}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-phone"></i>
                    <span><strong>Số điện thoại:</strong> ${shipper.phoneNumber}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-envelope"></i>
                    <span><strong>Email:</strong> ${shipper.email}</span>
                </div>
            </div>

            <!-- Danh sách trạng thái vận chuyển -->
            <h2><i class="fas fa-list-alt"></i> Lịch sử trạng thái vận chuyển</h2>
            <c:if test="${not empty shippingList}">
                <table>
                    <thead>
                        <tr>
                            <th><i class="far fa-calendar-alt"></i> Ngày vận chuyển</th>
                            <th><i class="fas fa-info-circle"></i> Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="shipping" items="${shippingList}">
                            <tr>
                                <td>${shipping.shippingDate}</td>
                                <td>
                                    <span class="status-pill
                                          <c:choose>
                                              <c:when test="${shipping.shippingStatus == 'Delivered'}">button-success</c:when>
                                              <c:when test="${shipping.shippingStatus == 'Cancelled'}">button-danger</c:when>
                                              <c:otherwise></c:otherwise>
                                          </c:choose>
                                          ">
                                        ${shipping.shippingStatus}
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty shippingList}">
                <div class="empty-state">
                    <i class="fas fa-box-open fa-3x"></i>
                    <p>Chưa có thông tin vận chuyển cho đơn hàng này.</p>
                </div>
            </c:if>

            <!-- Form cập nhật trạng thái vận chuyển -->
            <c:if test="${order.orderStatus != 'Delivered' and order.orderStatus != 'Cancelled' and sessionScope.user.role == 'Shipper'}">
                <div class="form-container">
                    <h2><i class="fas fa-pen"></i> Cập nhật trạng thái giao hàng</h2>
                    <form action="addShippingInformation" method="post">
                        <input type="hidden" name="orderId" value="${orderId}">
                        <input type="hidden" name="userId" value="${shipper.userId}">

                        <div class="form-group">
                            <label for="reason"><i class="fas fa-comment"></i> Lý do:</label>
                            <input type="text" id="reason" name="reason" class="form-control" required placeholder="Nhập lý do cập nhật trạng thái">
                        </div>

                        <div class="btn-container">
                            <button type="submit" name="status" value="" class="button">
                                <i class="fas fa-sync-alt"></i> Cập nhật thông tin
                            </button>
                            <button type="submit" name="status" value="Cancelled" class="button button-danger">
                                <i class="fas fa-times-circle"></i> Giao hàng không thành công
                            </button>
                        </div>
                    </form>

                    <form action="addShippingInformation" method="post" style="margin-top: 15px;">
                        <input type="hidden" name="orderId" value="${orderId}">
                        <input type="hidden" name="userId" value="${shipper.userId}">
                        <input type="hidden" name="reason" value="">

                        <button type="submit" name="status" value="Delivered" class="button button-success" style="width: 100%;">
                            <i class="fas fa-check-circle"></i> Giao hàng thành công
                        </button>
                    </form>
                </div>
            </c:if>
        </div>
    </body>
</html>
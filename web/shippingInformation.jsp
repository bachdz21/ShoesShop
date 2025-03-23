<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin vận chuyển</title>
        <style>
            table {
                width: 80%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .button {
                padding: 10px 20px;
                margin: 5px;
            }
        </style>
    </head>
    <body>
        <h1>Thông tin vận chuyển</h1>

        <!-- Hiển thị Shipper phụ trách -->
        <p>Shipper phụ trách: <strong>${shipper.fullName}</strong></p>
        <p>Shipper phụ trách: <strong>${shipper.userId}</strong></p>



        <!-- Danh sách Shipping -->
        <h2>Danh sách trạng thái vận chuyển</h2>
        <c:if test="${not empty shippingList}">
            <table>
                <thead>
                    <tr>
                        <th>Ngày vận chuyển</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="shipping" items="${shippingList}">
                        <tr>
                            <td>${shipping.shippingDate}</td>
                            <td>${shipping.shippingStatus}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty shippingList}">
            <p>Chưa có thông tin vận chuyển cho đơn hàng này.</p>
        </c:if>
        <!-- Form thêm trạng thái Shipping -->
        <c:if test="${order.orderStatus != 'Delivered' and order.orderStatus != 'Cancelled'}">
            <h2>Cập nhật trạng thái giao hàng</h2>
            <form action="addShippingInformation" method="post">
                <input type="hidden" name="orderId" value="${orderId}">
                <input type="hidden" name="userId" value="${shipper.userId}">

                <label for="reason">Lý do:</label><br>
                <input type="text" id="reason" name="reason" required ><br><br>
                <button type="submit" name="status" value="" class="button">Cập nhật Thông tin vận chuyển</button>
                <button type="submit" name="status" value="Cancelled" class="button">Giao hàng Không thành công</button>
                <br>
            </form>
            <form action="addShippingInformation" method="post">
                <input type="hidden" name="orderId" value="${orderId}">
                <input type="hidden" name="userId" value="${shipper.userId}">
                <input type="hidden"  name="reason" value="">
                <br>
                <button type="submit" name="status" value="Delivered" class="button">Giao hàng thành công</button> 
            </form>
        </c:if>


    </body>

</html>
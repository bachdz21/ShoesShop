<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<html>
    <head>
        <title>Danh sách người dùng</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            .pagination {
                display: flex;
                justify-content: center;
                list-style-type: none;
                padding: 0;
            }

            .pagination a {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
                color: #555;
            }

            .pagination .active {
                background-color: purple;
                color: white;
            }

            .pagination a:hover {
                background-color: #ddd;
            }
        </style>

    </head>
    <body>

        <h1>Danh sách người dùng</h1>

        <!-- Form tìm kiếm -->
        <form action="filterUser" method="get" class="form-inline">
    <input type="text" name="username" class="form-control mb-2 mr-sm-2" placeholder="Tài khoản"
        value="<c:out value='${param.username}' />">
    <input type="text" name="fullName" class="form-control mb-2 mr-sm-2" placeholder="Tên"
        value="<c:out value='${param.fullName}' />">
    <input type="text" name="email" class="form-control mb-2 mr-sm-2" placeholder="Email"
        value="<c:out value='${param.email}' />">
    <input type="text" name="phone" class="form-control mb-2 mr-sm-2" placeholder="Số điện thoại"
        value="<c:out value='${param.phone}' />">
    <input type="date" name="registrationDate" class="form-control mb-2 mr-sm-2" placeholder="Ngày tạo"
        value="<c:out value='${param.registrationDate}' />">
    <button type="submit" class="btn btn-primary mb-2">Tìm kiếm</button>
</form>


        <!-- Tabs điều hướng -->
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#Customer">Khách hàng</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Admin">Nhân viên</a>
            </li>
        </ul>

        <div class="tab-content">
            <!-- Tab Khách hàng -->
            <div id="Customer" class="container tab-pane active"><br>
                <h3>Danh sách Khách hàng</h3>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Tài khoản</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Ngày tạo</th>
                            <th>Đơn mua</th>
                            <th>Đơn hủy</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${customers}">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.phoneNumber}</td>
                                <td>${user.registrationDate}</td>
                                <td>${user.deliveredCount}</td>
                                <td>${user.cancelledCount}</td>
                                <td>
                                    <a href="emailReminder?userId=${user.userId}">Mail cảnh báo</a> | 
                                    <a href="banUser?userId=${user.userId}">Khóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang cho khách hàng -->
                <!-- Phân trang cho khách hàng -->
<div class="pagination">
    <c:if test="${currentPageCustomer > 1}">
        <a href="filterUser?pageStr1=1&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">&laquo; First</a>
    </c:if>

    <c:if test="${currentPageCustomer > 3}">
        <span>...</span>
    </c:if>

    <!-- Chỉ hiển thị "Prev" nếu không phải trang đầu tiên -->
    <c:if test="${currentPageCustomer > 1}">
        <a href="filterUser?pageStr1=${currentPageCustomer - 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">&laquo; Prev</a>
    </c:if>

    <!-- Hiển thị trang hiện tại và các trang xung quanh -->
    <c:forEach var="i" begin="${currentPageCustomer - 1}" end="${currentPageCustomer + 1}" varStatus="status">
        <c:if test="${i > 0 && i <= totalPagesCustomer}">
            <a href="filterUser?pageStr1=${i}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}" class="<c:if test='${i == currentPageCustomer}'>active</c:if>">
                ${i}
            </a>
        </c:if>
    </c:forEach>

    <c:if test="${currentPageCustomer < totalPagesCustomer - 2}">
        <span>...</span>
    </c:if>

    <c:if test="${currentPageCustomer < totalPagesCustomer}">
        <a href="filterUser?pageStr1=${currentPageCustomer + 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Next &raquo;</a>
    </c:if>

    <c:if test="${currentPageCustomer < totalPagesCustomer}">
        <a href="filterUser?pageStr1=${totalPagesCustomer}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Last &raquo;</a>
    </c:if>
</div>



            </div>

            <!-- Tab Nhân viên -->
            <div id="Admin" class="container tab-pane fade"><br>
                <h3>Danh sách Nhân viên</h3>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Tài khoản</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Ngày tạo</th>
                            <th>Đơn mua</th>
                            <th>Đơn hủy</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${employees}">
                            <tr>
                                <td>${user.username}</td>
                                <td>${user.fullName}</td>
                                <td>${user.email}</td>
                                <td>${user.phoneNumber}</td>
                                <td>${user.registrationDate}</td>
                                <td>${user.deliveredCount}</td>
                                <td>${user.cancelledCount}</td>
                                <td>
                                    <a href="emailReminder?userId=${user.userId}">Mail cảnh báo</a> | 
                                    <a href="banUser?userId=${user.userId}">Khóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang cho nhân viên -->
                <div class="pagination">
                    <c:if test="${currentPageEmployee > 1}">
                        <a href="filterUser?pageStr2=${currentPageEmployee - 1}">&laquo; Prev</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPagesEmployee}" varStatus="status">
                        <a href="filterUser?pageStr2=${i}" class="<c:if test='${i == currentPageEmployee}'>active</c:if>">
                            ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPageEmployee < totalPagesEmployee}">
                        <a href="filterUser?pageStr2=${currentPageEmployee + 1}">Next &raquo;</a>
                    </c:if>

                </div>



            </div>

        </div>


    </body>
</html>

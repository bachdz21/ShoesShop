<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<html>
    <head>
        <title>Danh sách người dùng</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <style>
            /* Trung tâm hóa form tìm kiếm */
            .form-inline {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-bottom: 30px;
                flex-wrap: wrap;
            }

            .form-control {
                width: 250px; /* Tăng kích thước input */
                margin-bottom: 15px;
                margin-right: 15px;
                font-size: 16px; /* Tăng kích thước font */
            }

            button {
                margin-top: 15px;
                font-size: 16px; /* Tăng kích thước nút */
            }

            /* Tiêu đề "Danh sách người dùng" màu đỏ */
            h1 {
                text-align: center;
                font-size: 36px; /* Tăng kích thước tiêu đề */
                color: #d32f2f; /* Màu đỏ cho tiêu đề */
                margin-bottom: 30px;
                font-weight: 700;
            }

            /* Styling cho bảng danh sách người dùng */
            table {
                width: 100%;
                margin-bottom: 30px;
                border-collapse: collapse;
                border: 2px solid #d32f2f; /* Viền bảng màu đỏ */
                border-radius: 10px; /* Tăng bo góc cho bảng */
            }

            th, td {
                text-align: left;
                padding: 20px; /* Tăng padding cho các ô */
                font-size: 16px; /* Tăng kích thước font */
            }

            th {
                background-color: #d32f2f; /* Màu nền đỏ cho tiêu đề bảng */
                color: white;
                font-weight: 600;
            }

            tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tbody tr:hover {
                background-color: #f1f1f1;
            }

            /*a {
                color: #007bff;
                text-decoration: none;
                font-size: 16px;  Tăng kích thước chữ cho liên kết 
            }*/

            a:hover {
                text-decoration: underline;
            }

            /* Phân trang */
            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
                margin-top: 30px;
            }

            .pagination a {
                padding: 10px 20px;
                border: 2px solid #d32f2f; /* Viền đỏ cho các trang */
                color: #555;
                text-decoration: none;
                margin: 0 8px;
                border-radius: 5px;
                font-size: 16px; /* Tăng kích thước font */
            }

            .pagination a:hover {
                background-color: #d32f2f;
                color: white;
            }

            .pagination .active {
                background-color: #d32f2f;
                color: white;
                border: 2px solid #d32f2f;
            }

            .pagination span {
                margin: 0 8px;
                color: #555;
            }

            /* Tinh chỉnh responsive */
            @media (max-width: 768px) {
                .form-inline {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .form-control {
                    width: 100%;
                    margin-bottom: 15px;
                }

                .pagination {
                    flex-wrap: wrap;
                }

                .pagination a {
                    padding: 10px 18px; /* Cải thiện hiển thị phân trang trên màn hình nhỏ */
                }
            }


        </style>

    </head>
    <body>

        <h1></h1>

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
        <%-- Hiển thị thông báo khóa tài khoản thành công nếu có --%>
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success" role="alert">
                ${sessionScope.message}
            </div>
            <%-- Xóa thông báo sau khi đã hiển thị --%>
            <c:remove var="message"/>
        </c:if>


        <div class="tab-content">
            <!-- Tab Khách hàng -->
            <div id="Customer" class="container tab-pane active"><br>
                <h3>Danh sách Khách hàng</h3>
                <h4>Tổng số khách hàng: <c:out value="${totalCustomers}" /></h4>

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
                                    <a href="emailReminder?userId=${user.userId}&pageStr1=${currentPageCustomer}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Mail cảnh báo</a> | 
                                    <a href="banUser?userId=${user.userId}&pageStr1=${currentPageCustomer}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Khóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

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
                <h4>Tổng số nhân viên: <c:out value="${totalEmployees}" /></h4>
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
                                    <a href="emailReminder?userId=${user.userId}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Mail cảnh báo</a> | 
                                    <a href="banUser?userId=${user.userId}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Khóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang cho nhân viên -->
                <div class="pagination">
                    <c:if test="${currentPageEmployee > 1}">
                        <a href="filterUser?pageStr2=1&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">&laquo; First</a>
                    </c:if>

                    <c:if test="${currentPageEmployee > 3}">
                        <span>...</span>
                    </c:if>

                    <!-- Chỉ hiển thị "Prev" nếu không phải trang đầu tiên -->
                    <c:if test="${currentPageEmployee > 1}">
                        <a href="filterUser?pageStr2=${currentPageEmployee - 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">&laquo; Prev</a>
                    </c:if>

                    <!-- Hiển thị trang hiện tại và các trang xung quanh -->
                    <c:forEach var="i" begin="${currentPageEmployee - 1}" end="${currentPageEmployee + 1}" varStatus="status">
                        <c:if test="${i > 0 && i <= totalPagesEmployee}">
                            <a href="filterUser?pageStr2=${i}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}" class="<c:if test='${i == currentPageEmployee}'>active</c:if>">
                                ${i}
                            </a>
                        </c:if>
                    </c:forEach>

                    <c:if test="${currentPageEmployee < totalPagesEmployee - 2}">
                        <span>...</span>
                    </c:if>

                    <c:if test="${currentPageEmployee < totalPagesEmployee}">
                        <a href="filterUser?pageStr2=${currentPageEmployee + 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Next &raquo;</a>
                    </c:if>

                    <c:if test="${currentPageEmployee < totalPagesEmployee}">
                        <a href="filterUser?pageStr2=${totalPagesEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&registrationDate=${param.registrationDate}">Last &raquo;</a>
                    </c:if>
                </div>




            </div>

        </div>

        <%@ include file="blank.jsp" %>
    </body>
</html>

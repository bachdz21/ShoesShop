<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Danh sách người dùng bị khóa</title>
    <!-- Thêm Bootstrap CSS để hỗ trợ Tabs -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <h1>Danh sách người dùng bị khóa</h1>

    <!-- Tabs điều hướng -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#CustomerLocked">Khách hàng bị khóa</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#AdminLocked">Nhân viên bị khóa</a>
        </li>
    </ul>

    <div class="tab-content">
        <!-- Tab Khách hàng bị khóa -->
        <div id="CustomerLocked" class="container tab-pane active"><br>
            <h3>Danh sách Khách hàng bị khóa</h3>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Ngày tạo</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${customerLockedUsers}">
                        <tr>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.registrationDate}</td>
                            <td>${user.role}</td>
                            <td>
                                <a href="restoreUser?userId=${user.userId}">Khôi phục</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Tab Nhân viên bị khóa -->
        <div id="AdminLocked" class="container tab-pane fade"><br>
            <h3>Danh sách Nhân viên bị khóa</h3>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Ngày tạo</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${adminLockedUsers}">
                        <tr>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phoneNumber}</td>
                            <td>${user.registrationDate}</td>
                            <td>${user.role}</td>
                            <td>
                                <a href="restoreUser?userId=${user.userId}">Khôi phục</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

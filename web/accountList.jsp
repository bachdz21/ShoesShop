<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách người dùng</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <style>
            body {
                background-color: #f4f6f9;
                font-family: 'Arial', sans-serif;
            }
            .search-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                padding: 20px;
                margin-bottom: 20px;
            }
            .nav-tabs .nav-link {
                color: #495057;
            }
            .nav-tabs .nav-link.active {
                background-color: #dc3545; /* Red instead of blue */
                color: white;
            }
            .table {
                background-color: white;
                box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            }
            .table thead {
                background-color: #f8f9fa;
            }
            .pagination {
                justify-content: center;
                margin-top: 20px;
            }
            .pagination a {
                color: #dc3545; /* Red instead of blue */
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
            }
            .pagination a:hover {
                background-color: #e9ecef;
            }
            .pagination a.active {
                background-color: #dc3545; /* Red instead of blue */
                color: white;
                border-radius: 4px;
            }
            .btn-group .btn {
                margin-right: 5px;
            }
            .card-header {
                background-color: #dc3545; /* Red instead of blue */
            }
            .btn-primary {
                background-color: #dc3545; /* Red instead of blue */
                border-color: #dc3545;
            }
            .btn-primary:hover {
                background-color: #c82333; /* Darker red for hover */
                border-color: #c82333;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid py-4">
            <div class="row">
                <div class="col-12">
                    <h1 class="text-center mb-4">Danh sách người dùng</h1>

                    <!-- Search Form -->
                    <div class="search-container">
                        <form action="${pageContext.request.contextPath}/filterUser" method="get" class="row g-3">
                            <div class="col-md-3">
                                <input type="text" name="username" class="form-control" placeholder="Tài khoản" value="<c:out value='${param.username}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="fullName" class="form-control" placeholder="Tên" value="<c:out value='${param.fullName}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="email" class="form-control" placeholder="Email" value="<c:out value='${param.email}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" value="<c:out value='${param.phone}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="number" name="minDelivered" class="form-control" placeholder="Đơn mua tối thiểu" value="<c:out value='${param.minDelivered}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="number" name="maxDelivered" class="form-control" placeholder="Đơn mua tối đa" value="<c:out value='${param.maxDelivered}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="number" name="minCancelled" class="form-control" placeholder="Đơn hủy tối thiểu" value="<c:out value='${param.minCancelled}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="number" name="maxCancelled" class="form-control" placeholder="Đơn hủy tối đa" value="<c:out value='${param.maxCancelled}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="date" name="minRegistrationDate" class="form-control" placeholder="Ngày tạo từ" value="<c:out value='${param.minRegistrationDate}' />">
                            </div>
                            <div class="col-md-3">
                                <input type="date" name="maxRegistrationDate" class="form-control" placeholder="Ngày tạo đến" value="<c:out value='${param.maxRegistrationDate}' />">
                            </div>


                            <div class="col-md-3">
                                <select name="sortBy" class="form-select">
                                    <option value="">Không sắp xếp</option>
                                    <option value="cancelledDesc" <c:if test="${param.sortBy == 'cancelledDesc'}">selected</c:if>>Đơn hủy giảm dần</option>
                                    <option value="cancelledAsc" <c:if test="${param.sortBy == 'cancelledAsc'}">selected</c:if>>Đơn hủy tăng dần</option>
                                    <option value="deliveredDesc" <c:if test="${param.sortBy == 'deliveredDesc'}">selected</c:if>>Đơn mua giảm dần</option>
                                    <option value="deliveredAsc" <c:if test="${param.sortBy == 'deliveredAsc'}">selected</c:if>>Đơn mua tăng dần</option>
                                    </select>
                                </div>
                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                                </div>
                            </form>
                        </div>

                        <!-- Navigation Button -->
                        <div style="text-align: center; margin-bottom: 20px;">
                            <a href="filterBanUser" class="btn btn-primary">Danh sách tài khoản bị khóa</a>
                        </div>

                        <!-- Success Message -->
                    <c:if test="${not empty sessionScope.message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${sessionScope.message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <c:remove var="message"/>
                    </c:if>

                    <!-- Tabs -->
                    <ul class="nav nav-tabs mb-3" id="userTabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-bs-toggle="tab" href="#Customer">Khách hàng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-bs-toggle="tab" href="#Admin">Nhân viên</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <!-- Customer Tab -->
                        <div id="Customer" class="tab-pane fade show active">
                            <div class="card shadow-lg mt-4 mx-auto" style="max-width: 95%;">
                                <div class="card-header text-white">
                                    <h4 class="mb-0">Danh sách Khách hàng</h4>
                                </div>
                                <div class="card-body">
                                    <p class="card-text">Tổng số khách hàng: <strong><c:out value="${totalCustomers}" /></strong></p>

                                    <div class="table-responsive">
                                        <table class="table table-hover">
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
                                                            <div class="btn-group" role="group">
                                                                <a href="javascript:void(0);" onclick="confirmAction('emailReminder?userId=${user.userId}&pageStr1=${currentPageCustomer}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}', 'Gửi email cảnh báo?')" class="btn btn-sm btn-warning">Email cảnh báo</a>
                                                                <a href="javascript:void(0);" onclick="confirmAction('banUser?userId=${user.userId}&pageStr1=${currentPageCustomer}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}', 'Bạn có chắc chắn muốn khóa tài khoản này?')" class="btn btn-sm btn-danger">Khóa</a>
                                                                <a href="userDetail?userId=${user.userId}" class="btn btn-sm btn-info">Chi tiết</a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Customer Pagination -->
                                    <nav aria-label="Phân trang khách hàng">
                                        <ul class="pagination">
                                            <c:if test="${currentPageCustomer > 1}">
                                                <li class="page-item"><a class="page-link" href="filterUser?pageStr1=1&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">« Đầu</a></li>
                                                <li class="page-item"><a class="page-link" href="filterUser?pageStr1=${currentPageCustomer - 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Trước</a></li>
                                                </c:if>

                                            <c:forEach var="i" begin="${currentPageCustomer - 1}" end="${currentPageCustomer + 1}" varStatus="status">
                                                <c:if test="${i > 0 && i <= totalPagesCustomer}">
                                                    <li class="page-item ${i == currentPageCustomer ? 'active' : ''}">
                                                        <a class="page-link" href="filterUser?pageStr1=${i}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">${i}</a>
                                                    </li>
                                                </c:if>
                                            </c:forEach>

                                            <c:if test="${currentPageCustomer < totalPagesCustomer}">
                                                <li class="page-item"><a class="page-link" href="filterUser?pageStr1=${currentPageCustomer + 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Sau</a></li>
                                                <li class="page-item"><a class="page-link" href="filterUser?pageStr1=${totalPagesCustomer}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Cuối »</a></li>
                                                </c:if>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>


                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                            <!-- Admin Tab -->
                            <div id="Admin" class="tab-pane fade">
                                <div class="card shadow-lg mt-4 mx-auto" style="max-width: 95%;">
                                    <div class="card-header text-white">
                                        <h4 class="mb-0">Danh sách Nhân viên</h4>
                                    </div>
                                    <div class="card-body">
                                        <p class="card-text">Tổng số nhân viên: <strong><c:out value="${totalEmployees}" /></strong></p>

                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Tài khoản</th>
                                                        <th>Tên</th>
                                                        <th>Email</th>
                                                        <th>Số điện thoại</th>
                                                        <th>Ngày tạo</th>
                                                        <th>Vai trò</th>
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
                                                            <td>${user.role}</td>
                                                            <td>
                                                                <div class="btn-group" role="group">
                                                                    <a href="javascript:void(0);" onclick="confirmAction('banUser?userId=${user.userId}&pageStr1=${currentPageCustomer}&pageStr2=${currentPageEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}', 'Bạn có chắc chắn muốn khóa tài khoản này?')" class="btn btn-sm btn-danger">Khóa</a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Create Employee Button -->
                                        <div style="text-align: center; margin-top: 20px;">
                                            <a href="registerForEmployee.jsp" class="btn btn-success">Tạo tài khoản nhân viên</a>
                                        </div>

                                        <!-- Employee Pagination -->
                                        <nav aria-label="Phân trang nhân viên">
                                            <ul class="pagination">
                                                <c:if test="${currentPageEmployee > 1}">
                                                    <li class="page-item"><a class="page-link" href="filterUser?pageStr2=1&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">« Đầu</a></li>
                                                    <li class="page-item"><a class="page-link" href="filterUser?pageStr2=${currentPageEmployee - 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Trước</a></li>
                                                    </c:if>

                                                <c:forEach var="i" begin="${currentPageEmployee - 1}" end="${currentPageEmployee + 1}" varStatus="status">
                                                    <c:if test="${i > 0 && i <= totalPagesEmployee}">
                                                        <li class="page-item ${i == currentPageEmployee ? 'active' : ''}">
                                                            <a class="page-link" href="filterUser?pageStr2=${i}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">${i}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${currentPageEmployee < totalPagesEmployee}">
                                                    <li class="page-item"><a class="page-link" href="filterUser?pageStr2=${currentPageEmployee + 1}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Sau</a></li>
                                                    <li class="page-item"><a class="page-link" href="filterUser?pageStr2=${totalPagesEmployee}&username=${param.username}&fullName=${param.fullName}&email=${param.email}&phone=${param.phone}&minRegistrationDate=${param.minRegistrationDate}&maxRegistrationDate=${param.maxRegistrationDate}&minDelivered=${param.minDelivered}&maxDelivered=${param.maxDelivered}&minCancelled=${param.minCancelled}&maxCancelled=${param.maxCancelled}&sortBy=${param.sortBy}">Cuối »</a></li>
                                                    </c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </c:if>   

                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Confirmation Script -->
        <script>
                                                                    function confirmAction(url, message) {
                                                                        if (confirm(message)) {
                                                                            window.location.href = url;
                                                                        }
                                                                    }
        </script>
    </body>
</html>
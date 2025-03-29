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
        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">
        
        
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min_1.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        
<!--         Bootstrap 
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>-->

        
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        
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
            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
                font-size: 14px;
                width: 237px;
            }
            
            .sidebar .navbar-nav {
                background-color: #191c24;
            }
            

            .sidebar .navbar .dropdown-item {
                padding: 10px 35px;
                border-radius: 0 30px 30px 0;
                color: var(--light);
                font-size: 14px;
            }
            .sidebar .navbar .dropdown-toggle::after {
                position: absolute;
                top: 12px;
                right: 7px;
                border: none;
                content: "\f107";
                font-family: "Font Awesome 5 Free";
                font-weight: 900;
                transition: .5s;
            }

        </style>
    </head>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <%@page import="model.User" %>
    <%@page import="model.CartItem" %>
    <%@page import="model.WishlistItem" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.Calendar" %>
    <%
        // Sử dụng biến session từ request mà không cần khai báo lại
            User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
        // Lấy danh sách sản phẩm trong giỏ hàng từ session
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        int totalQuantity = 0;
        double subtotal = 0.0;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                totalQuantity += item.getQuantity();
                subtotal += item.getProduct().getSalePrice() * item.getQuantity();
            }
        }
        // Lấy danh sách wishlist từ session
        List<WishlistItem> wishlistItems = (List<WishlistItem>) session.getAttribute("wishlist");
        int total = 0;
        if (wishlistItems != null) {
            for (WishlistItem item : wishlistItems) {
                total += 1;
            }
        }

        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH) + 1;
    %> 
    <body>
    <div class="container-fluid position-relative d-flex p-0">   
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">

                    <div class="navbar-nav w-100">
                        <a href="home" class="navbar-brand mx-5 mb-3">
                            <h3 class="text-primary"><i class=""></i>ShoeShop</h3>
                        </a>
                        <div class="d-flex align-items-center ms-4 mb-4">
                            <div class="position-relative">
                                <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                            </div>
                            <div class="ms-3">
                                <h6 style="color: red" class="mb-0"><%= user.getUsername() %></h6>
                                <span style="color: red"><%= user.getRole() %></span>
                            </div>
                        </div>                        
                        <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Sản Phẩm</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="list" class="dropdown-item">Danh Sách Sản Phẩm</a>
                                <a href="#" class="dropdown-item">Khác</a>
                            </div>
                        </div>    
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Tài Khoản</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="filterUser" class="dropdown-item active">Danh Sách Người Dùng</a>
                                <a href="filterBanUser" class="dropdown-item">Tài Khoản Bị Khóa</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Hoạt Động</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="activeCustomers" class="dropdown-item">Hoạt Động Khách Hàng</a>
                                <a href="customerBehavior" class="dropdown-item">Sản Phẩm Ưa Chuộng</a>
                            </div>
                        </div>
                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Đơn Hàng</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="allUserOrder" class="dropdown-item">Đơn Hàng Chờ Xác Nhân</a>
                                <a href="userOrder" class="dropdown-item">Đơn Hàng Đã Duyệt</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
           <!-- Sidebar End --> 
           
        <div style="background-color: white" class="content"> 
            <div>
            <jsp:include page="headerAdmin.jsp"/> 
            </div>
            <div class="container-fluid pt-4 px-4">
                <div class="container-fluid py-4">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="text-center mb-4">Danh sách người dùng</h1>

                            <!-- Search Form -->
                            <div class="search-container">
                                <form action="${pageContext.request.contextPath}/filterUser" method="get" class="row g-3">
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="text" name="username" class="form-control" placeholder="Tài khoản" value="<c:out value='${param.username}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="text" name="fullName" class="form-control" placeholder="Tên" value="<c:out value='${param.fullName}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="text" name="email" class="form-control" placeholder="Email" value="<c:out value='${param.email}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="text" name="phone" class="form-control" placeholder="Số điện thoại" value="<c:out value='${param.phone}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="number" name="minDelivered" class="form-control" placeholder="Đơn mua tối thiểu" value="<c:out value='${param.minDelivered}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="number" name="maxDelivered" class="form-control" placeholder="Đơn mua tối đa" value="<c:out value='${param.maxDelivered}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="number" name="minCancelled" class="form-control" placeholder="Đơn hủy tối thiểu" value="<c:out value='${param.minCancelled}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="number" name="maxCancelled" class="form-control" placeholder="Đơn hủy tối đa" value="<c:out value='${param.maxCancelled}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="date" name="minRegistrationDate" class="form-control" placeholder="Ngày tạo từ" value="<c:out value='${param.minRegistrationDate}' />">
                                    </div>
                                    <div class="col-md-3">
                                        <input style="background-color: white" type="date" name="maxRegistrationDate" class="form-control" placeholder="Ngày tạo đến" value="<c:out value='${param.maxRegistrationDate}' />">
                                    </div>


                                    <div class="col-md-3">
                                        <select style="background-color: white"  name="sortBy" class="form-select">
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
                                            <h4 style="color: white" class="mb-0">Danh sách Khách hàng</h4>
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
                                                <h4 style="color: white" class="mb-0">Danh sách Nhân viên</h4>
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
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>


    </body>
</html>
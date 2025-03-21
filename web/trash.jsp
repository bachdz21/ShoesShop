<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ShoeShop</title>

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
        
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .list-product {
                margin: 30px; /* Lề cho container */
            }
            table {
                width: 100%; /* Đặt chiều rộng của bảng 100% */
                border-collapse: collapse; /* Gộp các viền lại với nhau */
                margin-top: 20px; /* Thêm khoảng cách phía trên */
            }

            /* Cài đặt cho các ô tiêu đề */
            th {
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                padding: 12px; /* Đệm cho ô tiêu đề */
                text-align: center; /* Căn trái cho chữ */
                vertical-align: middle;
            }

            /* Cài đặt cho các ô dữ liệu */
            td {
                border: 1px solid #ddd; /* Viền ô dữ liệu */
                padding: 8px; /* Đệm cho ô dữ liệu */
                text-align: center;
                vertical-align: middle;
            }

            /* Thay đổi màu nền khi rê chuột qua hàng */
            tr:hover {
                background-color: #f5f5f5; /* Màu nền khi rê chuột */
            }

            /* Cài đặt cho hàng lẻ */
            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng lẻ */
            }

            /* Cài đặt cho hình ảnh trong bảng */
            img {
                border-radius: 5px; /* Bo tròn góc cho hình ảnh */
            }
            /* Cài đặt cho tiêu đề sản phẩm */
            .product-title {
                font-size: 24px; /* Kích thước chữ */
                color: #333; /* Màu chữ */
                margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
                text-align: center; /* Căn giữa tiêu đề */
            }

            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-bottom: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }
            .action-link {
                text-decoration: none; /* Bỏ gạch chân */
                padding: 8px 12px; /* Khoảng cách bên trong */
                border-radius: 4px; /* Bo góc */
                color: white; /* Màu chữ */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .btn-edit {
                background-color: #4CAF50; /* Màu xanh lá cây cho nút sửa */
            }

            .btn-delete {
                background-color: #f44336; /* Màu đỏ cho nút xóa */
            }

            .btn-edit:hover {
                background-color: #45a049; /* Màu xanh lá cây đậm khi hover */
            }

            .btn-delete:hover {
                background-color: #e53935; /* Màu đỏ đậm khi hover */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }

            .sidebar {
                position: fixed;
                margin-top: 0px;
                width: 270px;
                height: 100vh;
                overflow-y: auto;
                background-color: #191c24;
                transition: 0.5s;
                z-index: 999;
            }
            .content {
                min-height: 80vh;
                background: #ffffff;
                transition: 0.5s;
                width: 1600px;
            }

            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
            }
            
            .sidebar .navbar-nav {
                background-color: #191c24;
            }
            


            .sidebar .navbar .dropdown-item {
                padding: 10px 35px;
                border-radius: 0 30px 30px 0;
                color: var(--light);
            }
            
            .form-check-input {
                background-color: white;
            }
            
            .form-group {
                margin-left: 100px;
                margin-right: 110px;
            }
            
            body {
                background-color: #191c24;
                overflow-x: hidden;
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
                   <a href="home.jsp" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class=""></i>ShoeShop</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 style="color: red" class="mb-0"><%= user.getUsername() %></h6>
                            <span style="color: red">Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Danh Sách</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="getAllOrders" class="dropdown-item">Danh Sách Đơn Hàng</a>
                                <a href="list" class="dropdown-item active">Danh Sách Sản Phẩm</a>
                                <a href="#" class="dropdown-item">Khác</a>
                            </div>
                        </div>
                        <a href="getRevenueLastNDays?numberOfDays=7" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Biểu Đồ</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Trang</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="#" class="dropdown-item">Sign In</a>
                                <a href="#" class="dropdown-item">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>

    <div class="content"> 
        <jsp:include page="headerAdmin.jsp"/> 
        <div class="list-product">
            <h2 class="product-title">Danh Sách Sản Phẩm Đã Xoá</h2>
            <a href="list" class="product-add-link">Danh Sách Sản Phẩm</a>
                <form action="productAction" method="post">
                    <table border="1">
                        <tr>    
                            <th>Chọn</th>
                            <th>ID</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Mô Tả</th>
                            <th>Giá</th>
                            <th>Kho</th>
                            <th>Hình Ảnh</th>
                            <th>Danh Mục</th>
                            <th>Thương Hiệu</th>
                            <th>Sale</th>
                            <th>Ngày Tạo</th>
                            <th>Chỉnh Sửa</th>
                        </tr>
                        <c:forEach var="p" items="${requestScope.listDeletedProducts}">
                            <tr>
                                <td><input type="checkbox" name="selectedProducts" value="${p.productID}" /></td>
                                <td>${p.productID}</td>
                                <td>${p.productName}</td>
                                <td>${p.description}</td>
                                <td>${p.price}</td>
                                <td>${p.stock}</td>
                                <td><img src="${p.imageURL}" alt="Product Image" width="50"/></td>
                                <td>${p.categoryName}</td>
                                <td>${p.brand}</td>
                                <td>${p.sale}</td>
                                <td>${p.createdDate}</td>
                                <td>
                                    <a href="restore?id=${p.productID}" class="action-link btn-edit">Khôi Phục</a>
                                    <span class="divider">|</span>
                                    <a href="deleteTrash?id=${p.productID}" class="action-link btn-delete">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
                    <button type="submit" class="btn-delete-all action-link btn-delete" style="margin-right: 50px;margin-bottom: 50px;border: none;
                            margin-top: 15px;" name="action" value="deleteMultiple">Xóa Tất Cả Đã Chọn</button>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
                    <button type="submit" class="btn-delete-all action-link btn-delete" style="border: none;
                            margin-top: 15px;" name="action" value="restoreMultiple">Khôi Phục Nhiều</button> 
                </form>
            </div>
        </div>
    </div>

    <!-- jQuery Plugins -->
    <script>
        function toggleSelectAll(selectAllCheckbox) {
            const checkboxes = document.getElementsByName('selectedProducts');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = selectAllCheckbox.checked;
            });
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

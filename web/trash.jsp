<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>ShoeShop</title>

        <!-- Google font -->
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

        </style>
    </head>
    <%@page import="model.User"%>
    <%@page import="model.CartItem"%>
    <%@ page import="java.util.List" %>
    
    <%@page import="jakarta.servlet.http.HttpSession"%>
    <%
        // Sử dụng biến session từ request mà không cần khai báo lại
        User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
    %>
    <% 
    // Lấy danh sách sản phẩm trong giỏ hàng từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
    int totalQuantity = 0;
    double subtotal = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            totalQuantity += item.getQuantity();
            subtotal += item.getProduct().getPrice() * item.getQuantity();
        }
    }
    %>
    <body>
       
    <jsp:include page="header.jsp" />

    <!-- NAVIGATION -->
    <nav id="navigation">
        <!-- container -->
        <div class="container">
            <!-- responsive-nav -->
            <div id="responsive-nav">
                <!-- NAV -->
                <ul class="main-nav nav navbar-nav">
                    <li><a href="/ShoesStoreWeb/home">Trang Chủ</a></li>
                    <li><a href="/ShoesStoreWeb/product">Danh Mục</a></li>
                    <li class=""><a href="getOrderByUserID" class="admin-link">Danh Sách Đơn Hàng</a></li>
                    <li><a href="getAllOrders" class="admin-link">Danh Sách Tất Cả Đơn Hàng</a></li>
                    <li class="active"><a href="trash" class="admin-link">Danh Sách Sản Phẩm Đã Xóa</a></li>
                        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                        <li><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
                            <li><a href="trash" class="admin-link">Danh Sách Sản Phẩm Đã Xóa</a></li>
                        <li><a href="getAllOrders" class="admin-link">Danh Sách Tất Cả Đơn Hàng</a></li>
                        </c:if>

                </ul>
                <!-- /NAV -->
            </div>
            <!-- /responsive-nav -->
        </div>
        <!-- /container -->
    </nav>
    <!-- /NAVIGATION -->

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
            <button type="submit" class="btn-delete-all action-link btn-delete" style="border: none;
                    margin-top: 15px;" name="action" value="deleteMultiple">Xóa Tất Cả Đã Chọn</button>
            <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
            <button type="submit" class="btn-delete-all action-link btn-delete" style="border: none;
                    margin-top: 15px;" name="action" value="restoreMultiple">Khôi Phục Nhiều</button> 
        </form>
    </div>

    <!-- FOOTER -->
    <footer id="footer">
        <!-- top footer -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">About Us</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut.</p>
                            <ul class="footer-links">
                                <li><a href="#"><i class="fa fa-map-marker"></i>Thach That - Ha Noi</a></li>
                                <li><a href="#"><i class="fa fa-phone"></i>0399823683</a></li>
                                <li><a href="#"><i class="fa fa-envelope-o"></i>nvhoang2004k1922@email.com</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Categories</h3>
                            <ul class="footer-links">
                                <li><a href="#">Hot deals</a></li>
                                <li><a href="#">Nike</a></li>
                                <li><a href="#">Adidas</a></li>
                                <li><a href="#">Converse</a></li>
                                <li><a href="#">Puma</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="clearfix visible-xs"></div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Information</h3>
                            <ul class="footer-links">
                                <li><a href="#">About Us</a></li>
                                <li><a href="#">Contact Us</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Orders and Returns</a></li>
                                <li><a href="#">Terms & Conditions</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-3 col-xs-6">
                        <div class="footer">
                            <h3 class="footer-title">Service</h3>
                            <ul class="footer-links">
                                <li><a href="#">My Account</a></li>
                                <li><a href="#">View Cart</a></li>
                                <li><a href="#">Wishlist</a></li>
                                <li><a href="#">Track My Order</a></li>
                                <li><a href="#">Help</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /top footer -->

        <!-- bottom footer -->
        <div id="bottom-footer" class="section">
            <div class="container">
                <!-- row -->
                <div class="row">
                    <div class="col-md-12 text-center">
                        <ul class="footer-payments">
                            <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                            <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                            <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                        </ul>
                        <span class="copyright">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </span>


                    </div>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /bottom footer -->
    </footer>
    <!-- /FOOTER -->

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

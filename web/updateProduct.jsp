<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>

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
            .add-product-container {
                margin: 40px auto; /* Căn giữa với margin tự động */
                max-width: 600px; /* Đặt độ rộng tối đa */
                margin-bottom: 100px;
                margin-top: 100px;
                display: flex; /* Sử dụng Flexbox */
                flex-direction: column;
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                height: 100vh; /* Chiều cao bằng 100% viewport */

            }

            .add-product-form {
                border: 1px solid #dee2e6;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                width: 90%;
            }

            .add-product-title {
                text-align: center;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .btn-submit {
                width: 100%;
            }

            .btn-primary {
                color: #fff;
                background-color: #D10024;
                border-color: #a94442;

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
            <!-- HEADER -->
            <header>
                <!-- TOP HEADER -->
                <div id="top-header">
                    <div class="container">
                        <ul class="header-links pull-left">
                            <li><a href="#"><i class="fa fa-phone"></i> 0812843609</a></li>
                            <li><a href="#"><i class="fa fa-envelope-o"></i> nguyenphuong9824@gmail.com</a></li>
                            <li><a href="#"><i class="fa fa-map-marker"></i> SE1881 - PRJ301</a></li>
                        </ul>
                        <ul class="header-links pull-right">
                            <% if (user == null) { %>
                            <li><a href="login.jsp"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                                <% } else { %>
                            <li><a href="#"><i class="fa fa-dollar"></i> Chào Mừng, <%= user.getUsername() %></a></li>
                            <li><a href="logout"><i class="fa fa-user-o"></i> Đăng Xuất</a></li>
                                <% } %>
                        </ul>
                    </div>
                </div>
                <!-- /TOP HEADER -->
            </header>

            <!-- /TOP HEADER -->


            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="/ProjectPRJ301/home" class="logo">
                                    <img src="./img/logo.png" alt="">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-6">
                            <div class="header-search">
                                <form action="search" method="get">
                                    <select class="input-select" name="category">
                                        <option value="">Tất cả</option>
                                        <option value="Laptop">Laptop</option>
                                        <option value="Smartphone">Điện Thoại</option>
                                        <option value="Camera">Máy Ảnh</option>
                                        <option value="Accessory">Phụ Kiện</option>
                                        <!-- Thêm các loại sản phẩm khác nếu cần -->
                                    </select>
                                    <input class="input" name="query" placeholder="Search here">
                                    <button type="submit" class="search-btn">Tìm kiếm</button>
                                </form>
                            </div>
                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">

                                <!-- Cart -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Giỏ Hàng</span>
                                        <div class="qty"><%= totalQuantity %></div>
                                    </a>
                                    <div class="cart-dropdown">
                                        <div class="cart-list">
                                            <% if (cartItems != null && !cartItems.isEmpty()) { %>
                                            <% for (CartItem item : cartItems) { %>
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<%= item.getProduct().getImageURL() %>" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="#"><%= item.getProduct().getProductName() %></a></h3>
                                                    <h4 class="product-price"><span class="qty"><%= item.getQuantity() %>x</span>$<%= item.getProduct().getSalePrice() %></h4>
                                                </div>
                                            </div>
                                            <% } %>
                                            <% } else { %>
                                            <p>Giỏ hàng của bạn đang trống</p>
                                            <% } %>
                                        </div>
                                        <div class="cart-summary">
                                            <small><%= totalQuantity %> sản phẩm</small>
                                            <h5>Tổng: $<%= subtotal %></h5>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="cartItem">Xem Giỏ Hàng</a>
                                            <a href="getOrderItem">Thanh Toán <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Cart -->
                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="/ProjectPRJ301/home">Trang Chủ</a></li>
                        <li><a href="/ProjectPRJ301/product">Danh Mục</a></li>
                        <li><a href="getOrderByUserID" class="admin-link">Danh Sách Đơn Hàng</a></li>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                            <li class="active"><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
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

        <!-- EDITPRODUCT -->
        <div class="container edit-product-container">
            <h2 class="edit-product-title">Sửa Sản Phẩm</h2>
            <form action="update" method="post" enctype="multipart/form-data" class="edit-product-form">
                <hr>
                <input type="hidden" id="productId" name="productId" value="${product.productID}" />
                <div class="form-group">
                    <label for="productName">Tên Sản Phẩm:</label>
                    <input type="text" id="productName" name="productName" class="form-control" value="${product.productName}" required>
                </div>

                <div class="form-group">
                    <label for="description">Mô Tả:</label>
                    <textarea id="description" name="description" class="form-control" required>${product.description}</textarea>
                </div>

                <div class="form-group">
                    <label for="price">Giá:</label>
                    <input type="number" id="price" name="price" class="form-control" value="${product.price}" required>
                </div>

                <div class="form-group form-check">
                    <input type="checkbox" class="form-check-input" id="isSale" name="isSale" onchange="toggleSaleInput(this)" ${product.sale > 0 ? 'checked' : ''}>
                    <label class="form-check-label" for="isSale">Sale:</label>
                </div>

                <div id="salePercentage" class="form-group" style="display: ${product.sale > 0 ? 'block' : 'none'};">
                    <label for="sale">Nhập phần trăm giá giảm:</label>
                    <input type="text" id="sale" name="sale" class="form-control" value="${product.sale}" placeholder="Phần trăm giảm" />
                </div>

                <div class="form-group">
                    <label for="stock">Số lượng:</label>
                    <input type="number" id="stock" name="stock" class="form-control" value="${product.stock}" required>
                </div>

                <div class="form-group">
                    <label for="category">Danh Mục:</label>
                    <select id="category" name="category" class="form-control" onchange="toggleOtherCategory()">
                        <option value="">Chọn Danh Mục</option>
                        <option value="Laptop" ${product.categoryName == 'Laptop' ? 'selected' : ''}>Laptop</option>
                        <option value="Điện Thoại" ${product.categoryName == 'Điện Thoại' ? 'selected' : ''}>Điện Thoại</option>
                        <option value="Máy Ảnh" ${product.categoryName == 'Máy Ảnh' ? 'selected' : ''}>Máy Ảnh</option>
                        <option value="Phụ Kiện" ${product.categoryName == 'Phụ Kiện' ? 'selected' : ''}>Phụ Kiện</option>
                        <option value="Khác" ${product.categoryName == 'Khác' ? 'selected' : ''}>Khác</option>
                    </select>
                </div>

                <div id="otherCategory" class="form-group" style="display: ${product.categoryName == 'Khác' ? 'block' : 'none'};">
                    <label for="otherCategoryInput">Danh Mục Khác:</label>
                    <input type="text" id="otherCategoryInput" name="otherCategory" class="form-control" value="${product.categoryName == 'Khác' ? product.otherCategory : ''}" />
                </div>

                <div class="form-group">
                    <label for="images">Tải Lên Ảnh Mới:</label>
                    <input type="file" id="images" name="images" class="form-control-file" accept="image/*" multiple>
                </div>

                <div class="form-group">
                    <label for="brand">Thương Hiệu:</label>
                    <input type="text" id="brand" name="brand" class="form-control" value="${product.brand}" required>
                </div>

                <button type="submit" class="btn btn-primary btn-submit">Sửa Sản Phẩm</button>
                <hr>
            </form>
        </div>
        <!-- EDITPRODUCT -->

        <script>
            // Đặt giá trị mặc định của sale là 0 khi trang tải
            document.getElementById('sale').value = '0';
        </script> 


        <script>
            function toggleSalePriceInput() {
                const saleCheckbox = document.getElementById("sale");
                const salePriceInput = document.getElementById("salePrice");
                const salePriceLabel = document.getElementById("salePriceLabel");

                // Hiển thị hoặc ẩn input giá mới khi checkbox được tích hoặc bỏ tích
                if (saleCheckbox.checked) {
                    salePriceInput.style.display = "inline-block";
                    salePriceLabel.style.display = "inline";
                } else {
                    salePriceInput.style.display = "none";
                    salePriceLabel.style.display = "none";
                }
            }
        </script>

        <!-- UPDATEPRODUCT -->

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
                                    <li><a href="#"><i class="fa fa-map-marker"></i>1734 Stonecoal Road</a></li>
                                    <li><a href="#"><i class="fa fa-phone"></i>+021-95-51-84</a></li>
                                    <li><a href="#"><i class="fa fa-envelope-o"></i>email@email.com</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-3 col-xs-6">
                            <div class="footer">
                                <h3 class="footer-title">Categories</h3>
                                <ul class="footer-links">
                                    <li><a href="#">Hot deals</a></li>
                                    <li><a href="#">Laptops</a></li>
                                    <li><a href="#">Smartphones</a></li>
                                    <li><a href="#">Cameras</a></li>
                                    <li><a href="#">Accessories</a></li>
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
            function toggleSaleInput(checkbox) {
                const saleInput = document.getElementById('salePercentage');
                const saleValueInput = document.getElementById('sale');

                if (checkbox.checked) {
                    saleInput.style.display = 'block'; // Hiện ô input khi checkbox được tích
                } else {
                    saleInput.style.display = 'none'; // Ẩn ô input khi checkbox không được tích
                    saleValueInput.value = '0'; // Đặt lại giá trị ô input thành 0
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

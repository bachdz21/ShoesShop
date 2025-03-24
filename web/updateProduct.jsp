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
        <jsp:include page="header.jsp" />

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="/ShoesStoreWed/home">Trang Chủ</a></li>
                        <li><a href="/ShoesStoreWed/product">Danh Mục</a></li>
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
                    <textarea id="description" name="description" class="form-control" >${product.description}</textarea>
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
                        <option value="Sneakers" ${product.categoryName == 'Sneakers' ? 'selected' : ''}>Sneakers</option>
                        <option value="Oxford" ${product.categoryName == 'Oxford' ? 'selected' : ''}>Oxford</option>
                        <option value="Boot" ${product.categoryName == 'Boot' ? 'selected' : ''}>Boot</option>
                        <option value="Sandal" ${product.categoryName == 'Sandal' ? 'selected' : ''}>Sandal</option>
                        <option value="Other" ${product.categoryName == 'Other' ? 'selected' : ''}>Khác</option>
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

                <button type="submit" class="btn btn-primary btn-submit">Lưu Thay Đổi</button>
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

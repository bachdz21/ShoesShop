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
        <link rel="stylesheet" href="css/cart.css">
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            #buy-amount{
                display: flex;
            }
            #buy-amount button{
                width: 35px;
                height: 35px;
                outline: none;
                background: none;
                border: 1px solid #ececec;
                cursor: pointer;
            }
            #buy-amount button:hover{
                background-color: #ececec;
            }
            #buy-amount #amount{
                width: 40px;
                text-align: center;
                border: 1px solid #ececec;
            }

            .slfWNx.slfWNx{
                text-align: center;
                padding-top: 10px;
            }
            
            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-top: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
                margin-left: 187px; /* Lề cho container */

            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }
        </style>
    </head>
    <%@page import="model.User"%>
    <%@page import="jakarta.servlet.http.HttpSession"%>
    <%
        // Sử dụng biến session từ request mà không cần khai báo lại
        User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
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
                        <li><a href="#"><i class="fa fa-dollar"></i> USD</a></li>
                            <% if (user == null) { %>
                        <li><a href="login.jsp"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                            <% } else { %>
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
                            <a href="./home" class="logo">
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
                            <!-- Wishlist -->
                            <div>
                                <a href="#">
                                    <i class="fa fa-heart-o"></i>
                                    <span>Your Wishlist</span>
                                    <div class="qty">2</div>
                                </a>
                            </div>
                            <!-- /Wishlist -->

                            <!-- Cart -->
                            <div class="dropdown">
                                <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                    <i class="fa fa-shopping-cart"></i>
                                    <span>Your Cart</span>
                                    <div class="qty">3</div>
                                </a>
                                <div class="cart-dropdown">
                                    <div class="cart-list">
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="./img/product01.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price"><span class="qty">1x</span>$980.00</h4>
                                            </div>
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </div>

                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="./img/product02.png" alt="">
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="#">product name goes here</a></h3>
                                                <h4 class="product-price"><span class="qty">3x</span>$980.00</h4>
                                            </div>
                                            <button class="delete"><i class="fa fa-close"></i></button>
                                        </div>
                                    </div>
                                    <div class="cart-summary">
                                        <small>3 Item(s) selected</small>
                                        <h5>SUBTOTAL: $2940.00</h5>
                                    </div>
                                    <div class="cart-btns">
                                        <a href="#">View Cart</a>
                                        <a href="#">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
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
                        <li><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
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
    <a href="cartItem" class="product-add-link">Giỏ Hàng</a>
    <!-- CART -->
    <div class="container shopee-fake">
        <main class="GO0LDV" style="margin-bottom: 0px;">
            <h2 class="a11y-hidden">Product List Section</h2>
            <div class="Za1N64">
                <div class="SQGY8I">
                    <label class="stardust-checkbox">
                        <input class="stardust-checkbox__input" type="checkbox" aria-checked="false" aria-disabled="false" 
                               tabindex="0" role="checkbox" aria-label="Click here to select all products">
                        <div class="stardust-checkbox__box"></div>
                    </label>

                </div>
                <div class="jX4z5R">Sản Phẩm</div>
                <div class="jHcdvj">Đơn Giá</div>
                <div class="o1QlcH">Số Lượng</div>
                <div class="RT5qRd">Số Tiền</div>
                <div class="TkKRaF">Thao Tác</div>

            </div>
            <section class="AuhAvM">
                <h3 class="a11y-hidden">Shop Section</h3>
                <section class="RqMReY" role="list">
                    <div class="lDiGJB" role="listitem">
                        <h4 class="a11y-hidden">cart_accessibility_item</h4>

                        <c:forEach var="p" items="${requestScope.listCartItemTrash}">
                            <div class="f1bSN6">
                                <div class="Xp4RLg">
                                    <label class="stardust-checkbox">
                                        <input class="stardust-checkbox__input" type="checkbox" aria-checked="false" aria-disabled="false" 
                                               tabindex="0" role="checkbox" aria-label="Click here to select this product">
                                        <div class="stardust-checkbox__box"></div>
                                    </label>
                                </div>
                                <div class="brf29Y">
                                    <div class="bzhajK">
                                        <a href="">
                                            <picture class="xh1MNn">
                                                <img width="80" loading="lazy" class="RIhds1 lazyload jFEiVQ" 
                                                     src="${p.getProduct().getImageURL()}" 
                                                     height="80" alt="product image">
                                            </picture>
                                        </a>
                                        <div class="Ou_0WX">
                                            <a class="c54pg1" title="Dép nam Dép thời trang Dép đi biển Giày đi biển nữ" 
                                               href="">${p.getProduct().getProductName()}</a>
                                            <div class="j_w5yD">

                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="eHDC_o">
                                    <div class="qNRZqG">
                                        <button class="mM4TZ8" role="button" tabindex="0">
                                            <div class="iIg1CN">Phân loại hàng:
                                            </div>
                                            <div class="dDPSp3">${p.getProduct().getCategoryName()}</div>
                                        </button>
                                        <div>
                                        </div>
                                    </div>
                                </div>
                                <div class="gJyWia">
                                    <div>
                                        <span class="vjkBXu">${p.getProduct().getSalePrice()} $</span>
                                    </div>
                                </div>
                                <div class="sluy3i">
                                    <div id="buy-amount">
                                        <button class="minus-btn" onclick="handleMinus()">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14" />
                                            </svg>
                                        </button>
                                        <input type="text" name="amount" id="amount" value="${p.quantity}">
                                        <button class="plus-btn" onclick="handlePlus()">
                                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                                <div class="HRvCAv total-amount">
                                    <span class="total-price">0 $</span> <!-- Phần tử hiển thị tổng số tiền -->
                                </div>
                                <div class="bRSn43 TvSDdG">
                                    <a class="lSrQtj" href="deleteCartItemTrash?productId=${p.getProduct().getProductID()}">Xóa</a>
                                    <div class="J8cCGR">
                                        <a href="restoreCartItem?productId=${p.getProduct().getProductID()}" class="shopee-button-no-outline slfWNx">
                                            <span class="wZrjgF" style="font-size: 14px;">Khôi phục</span>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <hr>
                        </c:forEach>
                        
                    </div>
                </section>

            </section>
        </main>
        <section class="yn6AIc dhqg2H">
            <h2 class="a11y-hidden">cart_accessibility_footer</h2>

            <h3 class="a11y-hidden">cart_accessibility_footer_coin_row</h3>


            <div class="WhvsrO Kk1Mak">
                <h3 class="a11y-hidden">cart_accessibility_footer_checkout_row</h3>
                <div class="u4pma8">
                    <label class="stardust-checkbox">
                        <input class="stardust-checkbox__input" type="checkbox" aria-checked="false" aria-disabled="false" tabindex="0" 
                               role="checkbox" aria-label="Click here to select all products">
                        <div class="stardust-checkbox__box"></div>
                    </label>
                </div>
                <button class="v5CBXg clear-btn-style">Chọn Tất Cả </button>
                <button class="clear-btn-style GQ7Hga">Xóa</button>
                <div class=""></div>

                
            </div>
        </section>
    </div>
    <!-- /CART -->












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
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>

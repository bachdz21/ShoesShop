<%-- 
    Document   : productList
    Created on : Feb 10, 2025, 9:20:49 AM
    Author     : DELL
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

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

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .active{
                color: white;
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
        <!-- HEADER -->
        <header>
            <!-- TOP HEADER -->
            <div id="top-header">
                <div class="container">
                    <ul class="header-links pull-left">
                        <li><a href="#"><i class="fa fa-phone"></i> 0812843609</a></li>
                        <li><a href="#"><i class="fa fa-envelope-o"></i> nguyenphuong9824@gmail.com</a></li>
                        <li><a href="#"><i class="fa fa-map-marker"></i> SWP</a></li>
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
                                    <option value="Sneaker"></option>
                                    <option value="Oxford"></option>
                                    <option value="Boot"></option>
                                    <option value="Sandal"></option>
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
                                    <div class="qty"></div>
                                </a>
                                <div class="cart-dropdown">
                                    <div class="cart-list">
                                       
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="" alt="">
                                            </div>
                                            <div class="product-body">
                                                <h3 class="product-name"><a href="#"></a></h3>
                                                <h4 class="product-price"><span class="qty"></span></h4>
                                            </div>
                                        </div>
                                       
                                       
                                        
                                    </div>
                                    <div class="cart-summary">
                                        <small> sản phẩm</small>
                                        <h5></h5>
                                    </div>
                                    <div class="cart-btns">
                                        <a href="cartItem">Xem Giỏ Hàng</a>
                                        <a href="getOrderItem">Thanh Toán <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div>
                            </div>
                            <!-- /Cart -->

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
                    <li><a href="/ShoesStoreWed/home">Trang Chủ</a></li>
                    <li class="active"><a href="/ShoesStoreWed/product">Danh Mục</a></li>
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

    <!-- SECTION -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- ASIDE -->
                <form id="product" action="product" method="get">
                    <div id="aside" class="col-md-3">

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Loại sản phẩm</h3>
                            <div class="checkbox-filter">

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-1" name="categories" value="Sneakers">
                                    <label for="category-1">
                                        <span></span>
                                        Sneakers
                                    </label>
                                </div>

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-2" name="categories" value="Oxford">
                                    <label for="category-2">
                                        <span></span>
                                        Oxford
                                    </label>
                                </div>

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-3" name="categories" value="Boot">
                                    <label for="category-3">
                                        <span></span>
                                        Boot
                                    </label>
                                </div>

                                <div class="input-checkbox">
                                    <input type="checkbox" id="category-4" name="categories" value="Sandals">
                                    <label for="category-4">
                                        <span></span>
                                        Sandals
                                    </label>
                                </div>



                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Giá tiền</h3>
                            <div class="price-filter">
                                <div id="price-slider"></div>
                                <div class="input-number price-min">
                                    <input name="minPrice" id="price-min" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                                <span>-</span>
                                <div class="input-number price-max">
                                    <input name="maxPrice" id="price-max" type="number">
                                    <span class="qty-up">+</span>
                                    <span class="qty-down">-</span>
                                </div>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                        <!-- aside Widget -->
                        <div class="aside">
                            <h3 class="aside-title">Nhà sản xuất</h3>
                            <div class="checkbox-filter">
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-1" value="ADIDAS">
                                    <label for="brand-1">
                                        <span></span>
                                        ADIDAS
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-2" value="NIKE">
                                    <label for="brand-2">
                                        <span></span>
                                        NIKE
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-3" value="PUMA">
                                    <label for="brand-3">
                                        <span></span>
                                        PUMA
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-4" value="CONVERSE">
                                    <label for="brand-4">
                                        <span></span>
                                        CONVERSE
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-5" value="BLCG">
                                    <label for="brand-5">
                                        <span></span>
                                        BLCG
                                    </label>
                                </div>
                                <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-6" value="NEW BALANCE">
                                    <label for="brand-6">
                                        <span></span>
                                        NEW BALANCE
                                    </label>
                                </div>
                                 <div class="input-checkbox">
                                    <input name="brands" type="checkbox" id="brand-7" value="VANS">
                                    <label for="brand-7">
                                        <span></span>
                                        VANS
                                    </label>
                                </div>
                            </div>
                            <div class="filter-bar" style="display: flex; justify-content: center; margin-top: 20px;">
                                <button type="submit" id="filter-btn" style="
                                        padding: 10px 20px;
                                        background-color: #D10024; /* Màu đỏ */
                                        color: white;
                                        border: none;
                                        border-radius: 4px;
                                        font-size: 16px;
                                        cursor: pointer;
                                        transition: background-color 0.3s ease;
                                        " 
                                        onmouseover="this.style.backgroundColor = '#e60000'" 
                                        onmouseout="this.style.backgroundColor = '#D10024'" 
                                        onmousedown="this.style.backgroundColor = '#cc0000'" 
                                        onmouseup="this.style.backgroundColor = '#e60000'">
                                    Filter
                                </button>
                            </div>
                        </div>
                        <!-- /aside Widget -->

                    </div>
                    <!-- /ASIDE -->
                </form>


                <!-- STORE -->
                <div id="store" class="col-md-9">
                    <!-- store top filter -->
                    <div class="store-filter clearfix">
                        <div class="store-sort">
                            <form id="filterForm" action="product" method="get">
                                <label>
                                    Sắp Xếp:
                                    <select id="sortOption" name="sortOption" class="input-select" onchange="submitFilterForm()">
                                        <option value="default" <c:if test="${selectedOption == 'default'}">selected</c:if>>Mặc Định</option>
                                        <option value="priceDesc" <c:if test="${selectedOption == 'priceDesc'}">selected</c:if>>Giá Giảm Dần</option>
                                        <option value="priceAsc" <c:if test="${selectedOption == 'priceAsc'}">selected</c:if>>Giá Tăng Dần</option>
                                        <option value="saleDesc" <c:if test="${selectedOption == 'saleDesc'}">selected</c:if>>Khuyến Mãi Giảm Dần</option>
                                        <option value="saleAsc" <c:if test="${selectedOption == 'saleAsc'}">selected</c:if>>Khuyến Mãi Tăng Dần</option>
                                        </select>
                                    </label>
                                    <!-- Thêm các tham số lọc ở đây -->
                                    <input type="hidden" name="minPrice" value="${minPrice}">
                                <input type="hidden" name="maxPrice" value="${maxPrice}">
                                <c:forEach var="category" items="${categories}">
                                    <input type="hidden" name="categories" value="${category}">
                                </c:forEach>
                                <c:forEach var="brand" items="${brands}">
                                    <input type="hidden" name="brands" value="${brand}">
                                </c:forEach>
                            </form>
                        </div>
                    </div>
                    <!-- /store top filter -->

                    <!-- store products -->
                    <div class="row">
                        <!-- product -->
                        <c:forEach var="i" items="${requestScope.listProducts}">
                            <div class="col-md-4 col-xs-6">
                                <div class="product">
                                    <a href="productDetail?id=${i.productID}">
                                        <div class="product-img">
                                            <img src="${i.imageURL}" alt="">
                                            <c:choose>
                                                <c:when test="${i.salePrice > 0}">
                                                    <div class="product-label">
                                                        <span class="sale">-${i.sale}%</span>
                                                        <span class="new">NEW</span>
                                                    </div>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </a>
                                    <div class="product-body">
                                        <p class="product-category">${i.categoryName}</p>
                                        <h3 class="product-name"><a href="productDetail?id=${i.productID}">${i.productName}</a></h3>
                                            <c:choose>
                                                <c:when test="${i.salePrice > 0}">
                                                <h4 class="product-price">${i.salePrice} <del class="product-old-price">${i.price}</del></h4>
                                                </c:when>
                                                <c:otherwise>
                                                <h4 class="product-price">${i.price}</h4>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="product-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                        </div>
                                    </div>
                                    <div class="add-to-cart">
                                        <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> add to cart</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- /product -->
                    </div>
                    <!-- /store products -->

                    <!-- store bottom filter -->
                    <div class="store-filter clearfix">
                        <ul class="store-pagination">
                            <!-- Previous button -->
                            <c:if test="${currentPage > 1}">
                                <li>
                                    <a href="product?page=${currentPage - 1}&minPrice=${minPrice}&maxPrice=${maxPrice}&sortOption=${selectedOption}
                                       <c:if test="${not empty categories}">
                                           <c:forEach var="category" items="${categories}">
                                               &categories=${category}
                                           </c:forEach>
                                       </c:if>
                                       <c:if test="${not empty brands}">
                                           <c:forEach var="brand" items="${brands}">
                                               &brands=${brand}
                                           </c:forEach>
                                       </c:if>">
                                        <
                                    </a>
                                </li>
                            </c:if>

                            <!-- Page buttons -->
                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <li class="<c:if test='${i == currentPage}'>active</c:if>">
                                    <a href="?page=${i}&minPrice=${minPrice}&maxPrice=${maxPrice}&sortOption=${selectedOption}
                                       <c:if test="${not empty categories}">&categories=${fn:join(categories, '&categories=')}</c:if>
                                       <c:if test="${not empty brands}">&brands=${fn:join(brands, '&brands=')}</c:if>"
                                       class="<c:if test='${i == currentPage}'>active</c:if>">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Next button -->
                            <c:if test="${currentPage < totalPages}">
                                <li>
                                    <a href="?page=${currentPage + 1}&minPrice=${minPrice}&maxPrice=${maxPrice}&sortOption=${selectedOption}
                                       <c:if test="${not empty categories}">&categories=${fn:join(categories, '&categories=')}</c:if>
                                       <c:if test="${not empty brands}">&brands=${fn:join(brands, '&brands=')}</c:if>">
                                           >
                                       </a>
                                    </li>
                            </c:if>
                        </ul>
                    </div>
                    <!-- /store bottom filter -->
                </div>
                <!-- /STORE -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

    <!-- NEWSLETTER -->
    <div id="newsletter" class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-12">
                    <div class="newsletter">
                        <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                        <form>
                            <input class="input" type="email" placeholder="Enter Your Email">
                            <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                        </form>
                        <ul class="newsletter-follow">
                            <li>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-pinterest"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /NEWSLETTER -->

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
        function submitFilterForm() {
            document.getElementById('filterForm').submit();
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

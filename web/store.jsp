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
        <jsp:include page="header.jsp" />
        <!-- /HEADER -->

        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="./home">Trang Chủ</a></li>
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
                                    <input type="checkbox" id="category-1" name="categories" value="Sneaker">
                                    <label for="category-1">
                                        <span></span>
                                        Sneaker
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
                                        <a href="productDetail?id=${i.productID}&category=${i.categoryName}" class="product-img">
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
                                                    <c:when test="${i.sale > 0}">
                                                    <h4 class="product-price">$${i.salePrice} <del class="product-old-price">$${i.price}</del></h4>
                                                </c:when>
                                                <c:otherwise>
                                                    <h4 class="product-price">$${i.price}</h4>
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
                                        <form action="addCartQuick" method="GET">
                                            <div class="add-to-cart">
                                                <input type="hidden" name="quantity" value="1">
                                                <input type="hidden" name="productID" value="${i.productID}"> <!-- Gửi productID -->
                                                <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                            </div>
                                        </form>
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
        <jsp:include page="footer.jsp" />
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

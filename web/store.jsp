<%-- 
    Document   : productList
    Created on : Feb 10, 2025, 9:20:49 AM
    Author     : DELL
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            .rating-stars {
                display: inline-flex;
                position: relative;
            }

            .rating-stars i {
                font-size: 16px; /* Kích thước sao */
                color: #D10024; /* Màu vàng cho sao đầy */
            }

            .rating-stars .star-wrapper {
                position: relative;
                display: inline-block;
                width: 16px; /* Kích thước sao */
                height: 16px;
            }

            .rating-stars .star-fill {
                position: absolute;
                top: 0;
                left: 0;
                overflow: hidden;
                color: #D10024; /* Màu vàng cho phần đầy */
            }

            .rating-stars .star-empty {
                color: #ccc; /* Màu xám cho phần rỗng */
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
                                    <div class="input-number price-min" style="height: 40px">
                                        <input name="minPrice" id="price-min" type="number" style="display: none"> <!-- Ẩn input gốc -->
                                        <span id="price-min-display" class="price-display" contenteditable="true"
                                              style="display: inline-block;
                                              height: 40px;
                                              width: 104.25px;
                                              text-align: center;
                                              line-height: 40px;border: 1px solid #E4E7ED"></span> <!-- Thêm phần tử để hiển thị định dạng -->
                                        <span class="qty-up">+</span>
                                        <span class="qty-down">-</span>
                                    </div>
                                    <span>-</span>
                                    <div class="input-number price-max" style="height: 40px">
                                        <input name="maxPrice" id="price-max" type="number" style="display: none"> <!-- Ẩn input gốc -->
                                        <span id="price-max-display" class="price-display" contenteditable="true"
                                              style="display: inline-block;
                                              height: 40px;
                                              width: 104.25px;
                                              text-align: center;
                                              line-height: 40px;border: 1px solid #E4E7ED"></span> <!-- Thêm phần tử để hiển thị định dạng -->
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
                                                <img src="${i.imageURL}" alt="" style="height: 262.5px">
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
                                                    <h4 class="product-price">
                                                        <fmt:formatNumber value="${i.salePrice}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                        <br>
                                                        <del class="product-old-price">
                                                            <fmt:formatNumber value="${i.price}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                        </del>
                                                    </h4>
                                                </c:when>
                                                <c:otherwise>
                                                    <h4 class="product-price" style="height: 39.6px">
                                                        <fmt:formatNumber value="${i.price}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                    </h4>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="rating-avg">
                                                <div class="rating-stars">
                                                    <c:set var="rating" value="${i.averageRating}" />
                                                    <c:set var="fullStars" value="${rating.intValue()}" /> <!-- Phần nguyên -->
                                                    <c:set var="fraction" value="${rating - fullStars}" /> <!-- Phần thập phân -->
                                                    <!-- Hiển thị sao đầy -->
                                                    <c:forEach var="it" begin="1" end="${fullStars}">
                                                        <i class="fa fa-star"></i>
                                                    </c:forEach>
                                                    <!-- Hiển thị sao phân số (nếu có) -->
                                                    <c:if test="${fraction > 0}">
                                                        <div class="star-wrapper">
                                                            <i class="fa fa-star star-empty"></i>
                                                            <div class="star-fill" style="width: ${fraction * 100}%;">
                                                                <i class="fa fa-star"></i>
                                                            </div>
                                                        </div>
                                                    </c:if>

                                                    <!-- Hiển thị sao rỗng cho phần còn lại -->
                                                    <c:forEach var="it" begin="${fullStars + (fraction > 0 ? 1 : 0) + 1}" end="5">
                                                        <i class="fa fa-star-o"></i>
                                                    </c:forEach>
                                                    <!-- Kiểm tra nếu sản phẩm đã có trong wishlist -->
                                                    <c:set var="isInWishlist" value="false" />
                                                    <c:forEach var="item" items="${sessionScope.wishlist}">
                                                        <c:if test="${item.product.productID == i.productID}">
                                                            <c:set var="isInWishlist" value="true" />
                                                        </c:if>
                                                    </c:forEach>

                                                    <!-- Thay thế form action="addWishlist" -->
                                                    <div class="product-btns">
                                                        <button class="add-to-wishlist" onclick="addToWishlist(${i.productID}, this)">
                                                            <i class="${isInWishlist ? 'fa fa-heart text-danger' : 'far fa-heart'}"></i>
                                                            <span class="tooltipp">${isInWishlist ? 'Đã có trong wishlist' : 'Thêm vào wishlist'}</span>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Thay thế form action="addCartQuick" -->
                                        <div class="add-to-cart">
                                            <button class="add-to-cart-btn" onclick="addToCartQuick(${i.productID})">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
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
        <script>
            function openMostSoldSettingsModal() {
                document.getElementById("settingsMostSoldModal").style.display = "block";
            }

            function closeMostSoldSettingsModal() {
                document.getElementById("settingsMostSoldModal").style.display = "none";
            }

            window.onclick = function (event) {
                const modal = document.getElementById("settingsMostSoldModal");
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            };

            function saveMostSoldSettings() {
                const form = document.getElementById("category-display-form");
                const formData = new FormData(form);

                fetch('updateDisplayedCategories', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => response.text())
                        .then(() => {
                            closeMostSoldSettingsModal();
                            location.reload();
                        })
                        .catch(error => console.error('Error saving settings:', error));
            }

            // Hàm thêm vào Wishlist
            function addToWishlist(productId, button) {
                fetch('/ShoesStoreWed/addWishlist', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productID=' + productId
                })
                        .then(response => {
                            if (!response.ok) {
                                if (response.status === 401) {
                                    window.location.href = 'login.jsp'; // Chuyển hướng nếu chưa đăng nhập
                                }
                                return response.text().then(text => {
                                    throw new Error(text);
                                });
                            }
                            return response.text();
                        })
                        .then(text => {
                            if (text === "Added to wishlist successfully") {
                                const heartIcon = button.querySelector('i');
                                const tooltip = button.querySelector('.tooltipp');
                                if (heartIcon.classList.contains('far')) {
                                    heartIcon.classList.remove('far', 'fa-heart');
                                    heartIcon.classList.add('fa', 'fa-heart', 'text-danger');
                                    tooltip.textContent = 'Đã có trong wishlist';
                                    updateWishlistCount(1); // Tăng số lượng wishlist
                                }
                            } else {
                                throw new Error(text); // Nếu server trả về lỗi
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi thêm vào wishlist: ' + error.message);
                        });
            }

            // Hàm thêm vào giỏ hàng nhanh
            function addToCartQuick(productId) {
                fetch('/ShoesStoreWed/addCartQuick', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productID=' + productId
                })
                        .then(response => {
                            if (response.ok) {
                                return response.text();
                            } else if (response.status === 401) {
                                window.location.href = 'login.jsp'; // Chuyển hướng nếu chưa đăng nhập
                                throw new Error('Unauthorized');
                            } else {
                                throw new Error('Error adding to cart');
                            }
                        })
                        .then(() => {
                            // Cập nhật số lượng trong giỏ hàng mà không reload
                            updateCartCount(1); // Tăng số lượng giỏ hàng
                            alert('Đã thêm vào giỏ hàng thành công!');
                        })
                        .catch(error => console.error('Error:', error));
            }

            // Hàm cập nhật số lượng Wishlist trên header
            function updateWishlistCount(change) {
                const wishlistQty = document.querySelector('.header-ctn .dropdown .qty');
                let currentCount = parseInt(wishlistQty.textContent);
                wishlistQty.textContent = currentCount + change;
            }

            // Hàm cập nhật số lượng Cart trên header
            function updateCartCount(change) {
                const cartQty = document.querySelector('.header-ctn .dropdown:nth-child(2) .qty');
                let currentCount = parseInt(cartQty.textContent);
                cartQty.textContent = currentCount + change;
            }
        </script>
    </body>
</html>

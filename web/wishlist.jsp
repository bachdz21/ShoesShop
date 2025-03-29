<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

            .yn6AIc.dhqg2H{
                padding: 28px
            }

            .bRSn43.TvSDdG {
                display: flex;
                align-items: center;
                gap: 20px;
            }
            .lSrQtj {
                color: #D10024; /* Màu ví dụ */
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
            }
            .lSrQtj:hover {
                background-color: #f0f0f0;
            }


        </style>
    </head>
    <%@page import="model.User"%>
    <%@page import="model.WishlistItem"%>
    <%@ page import="java.util.List" %>

    <%@page import="jakarta.servlet.http.HttpSession"%>

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
                        <li><a href="./product">Danh Mục</a></li>
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->
        <!-- CART -->
        <div class="container shopee-fake">
            <form action="getCartItemUpdateQuantity" method="POST">
                <main class="GO0LDV" style="margin-bottom: 10px;">
                    <h2 class="a11y-hidden">Product List Section</h2>
                    <div class="Za1N64">
                        <div class="SQGY8I">
                            <label class="stardust-checkbox">
                                <input class="stardust-checkbox__input" type="checkbox" aria-checked="false" aria-disabled="false" 
                                       tabindex="0" role="checkbox" aria-label="Click here to select all products">
                            </label>

                        </div>
                        <div class="jX4z5R">Sản Phẩm</div>
                        <div class="jHcdvj">Đơn Giá</div>
                        <div class="o1QlcH"></div>
                        <div class="TkKRaF">Thao Tác</div>

                    </div>
                    <section class="AuhAvM">
                        <h3 class="a11y-hidden">Shop Section</h3>
                        <section class="RqMReY" role="list">

                            <div class="lDiGJB" role="listitem">
                                <h4 class="a11y-hidden">cart_accessibility_item</h4>

                                <c:forEach var="p" items="${requestScope.listWishlistItem}">
                                    <div class="f1bSN6">
                                        <input type="hidden" name="productID" value="${p.getProduct().getProductID()}"> <!-- Trường ẩn để gửi productID -->
                                        <div class="Xp4RLg">
                                            <label class="stardust-checkbox">
                                                <input class="stardust-checkbox__input" type="checkbox" aria-checked="false" aria-disabled="false" 
                                                       tabindex="0" role="checkbox" aria-label="Click here to select this product">
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
                                                    <div class="iIg1CN">Phân loại hàng:</div>
                                                    <div class="dDPSp3">${p.getProduct().getCategoryName()}</div>
                                                </button>
                                                <div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="gJyWia">
                                            <div style="text-align: center">
                                                <c:choose>
                                                    <c:when test="${p.getProduct().getSale() > 0}">
                                                        <span class="vjkBXu">
                                                            <fmt:formatNumber value="${p.getProduct().getSalePrice()}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                        </span>
                                                        <span style="text-decoration: line-through; color: #757575">
                                                            <fmt:formatNumber value="${p.getProduct().getPrice()}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="vjkBXu">
                                                            <fmt:formatNumber value="${p.getProduct().getPrice()}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="sluy3i">
                                            <div id="buy-amount">
                                            </div>
                                        </div>
                                        <div class="bRSn43 TvSDdG">
                                            <div style="display: flex; align-items: center; gap: 20px;">
                                                <a class="lSrQtj" href="addCartQuickFromWishlist?productID=${p.getProduct().getProductID()}&quantity=1">Thêm vào giỏ hàng</a>
                                                <a class="lSrQtj" href="deleteWishlistItem?productId=${p.getProduct().getProductID()}">Xóa</a>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>
                            </div>

                        </section>

                    </section>
                </main>
            </form>
        </div>
        <!-- /CART -->

        <!-- FOOTER -->
        <jsp:include page="footer.jsp" />
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

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
            
            .yn6AIc.dhqg2H{
                padding: 28px
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
    <a href="trashCart" class="product-add-link">Sản Phẩm Đã Xoá</a>
    <!-- CART -->
    <div class="container shopee-fake">
        <form action="getOrderItemUpdateQuantity" method="POST">
            <main class="GO0LDV" style="margin-bottom: 0px;">
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
                    <div class="o1QlcH">Số Lượng</div>
                    <div class="RT5qRd">Số Tiền</div>
                    <div class="TkKRaF">Thao Tác</div>

                </div>
                <section class="AuhAvM">
                    <h3 class="a11y-hidden">Shop Section</h3>
                    <section class="RqMReY" role="list">

                        <div class="lDiGJB" role="listitem">
                            <h4 class="a11y-hidden">cart_accessibility_item</h4>

                            <c:forEach var="p" items="${requestScope.listCartItem}">
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
                                            <button type="button" class="minus-btn" onclick="handleMinus()">
                                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14" />
                                                </svg>
                                            </button>
                                            <input type="text" name="amount${p.getProduct().getProductID()}" id="amount" value="${p.quantity}">
                                            <button type="button" class="plus-btn" onclick="handlePlus()">
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
                                        <a class="lSrQtj" href="deleteCartItem?productId=${p.getProduct().getProductID()}">Xóa</a>
                                        <div class="J8cCGR">
                                            <a href="/ProjectPRJ301/product?categories=${p.getProduct().getCategoryName()}&minPrice=1.00&maxPrice=999.00" class="shopee-button-no-outline slfWNx">
                                                <span class="wZrjgF">Tìm sản phẩm tương tự</span>
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
                <div class="WhvsrO Kk1Mak">
                    <button class="v5CBXg clear-btn-style"></button>
                    <button class="clear-btn-style GQ7Hga"></button>
                    <div class="BV92a3" role="region">
                        <div class="total-and-buy">
                            <div class="DScaTh">
                                <div class="znJ7TE">
                                    <div class="CoYXUV">Tổng thanh toán:</div>
                                    <div class="mketV9 grand-total">
                                        <span id="grand-total">0 $</span>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="shopee-button-solid shopee-button-solid--primary SHq91i">Mua hàng</button>

                        </div>
                    </div>
                </div>
            </section>
        </form>
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
    <script>
        // Hàm tính tổng số tiền cho một sản phẩm
        const updateTotalPriceForSingleProduct = (item) => {
            const price = parseFloat(item.querySelector('.vjkBXu').innerText.replace('$', '').trim()); // Lấy giá sản phẩm
            const amountInput = item.querySelector('input[name^="amount"]'); // Tìm input có name bắt đầu bằng "amount"
            const amount = parseInt(amountInput.value); // Lấy số lượng sản phẩm
            const totalPrice = (price * amount).toFixed(2); // Tính tổng số tiền cho sản phẩm
            item.querySelector('.total-price').innerText = totalPrice + " $"; // Cập nhật tổng tiền cho sản phẩm
            return totalPrice; // Trả về tổng tiền cho sản phẩm
        }

        // Hàm tính tổng số tiền cho tất cả sản phẩm
        const updateTotalPriceForAllProducts = () => {
            let grandTotal = 0;
            const cartItems = document.querySelectorAll('.f1bSN6'); // Lấy tất cả sản phẩm trong giỏ hàng

            cartItems.forEach(item => {
                const totalPrice = parseFloat(item.querySelector('.total-price').innerText.replace('$', '').trim()); // Lấy tổng số tiền cho sản phẩm
                grandTotal += totalPrice; // Cộng dồn vào tổng
            });

            document.getElementById('grand-total').innerText = grandTotal.toFixed(2) + " $"; // Cập nhật tổng tiền cho tất cả sản phẩm
        }

        // Lắng nghe sự kiện cho các nút "+" và "-" cho từng sản phẩm
        document.querySelectorAll('.plus-btn').forEach(button => {
            button.addEventListener('click', (event) => {
                const item = event.target.closest('.f1bSN6'); // Lấy sản phẩm cha
                const amountInput = item.querySelector('input[name^="amount"]'); // Tìm input có name bắt đầu bằng "amount"
                let amount = parseInt(amountInput.value);
                amount++;
                amountInput.value = amount; // Cập nhật giá trị input
                updateTotalPriceForSingleProduct(item); // Cập nhật tổng số tiền cho sản phẩm
                updateTotalPriceForAllProducts(); // Cập nhật tổng số tiền cho tất cả sản phẩm
            });
        });

        document.querySelectorAll('.minus-btn').forEach(button => {
            button.addEventListener('click', (event) => {
                const item = event.target.closest('.f1bSN6'); // Lấy sản phẩm cha
                const amountInput = item.querySelector('input[name^="amount"]'); // Tìm input có name bắt đầu bằng "amount"
                let amount = parseInt(amountInput.value);
                if (amount > 1) {
                    amount--;
                    amountInput.value = amount; // Cập nhật giá trị input
                    updateTotalPriceForSingleProduct(item); // Cập nhật tổng số tiền cho sản phẩm
                    updateTotalPriceForAllProducts(); // Cập nhật tổng số tiền cho tất cả sản phẩm
                }
            });
        });

        // Lắng nghe sự kiện cho input số lượng
        document.querySelectorAll('input[name^="amount"]').forEach(amountInput => {
            amountInput.addEventListener('input', (event) => {
                const item = event.target.closest('.f1bSN6'); // Lấy sản phẩm cha
                let amount = parseInt(event.target.value);
                if (isNaN(amount) || amount <= 0) {
                    amount = 1; // Đảm bảo giá trị tối thiểu là 1
                }
                event.target.value = amount; // Cập nhật giá trị input
                updateTotalPriceForSingleProduct(item); // Cập nhật tổng số tiền cho sản phẩm
                updateTotalPriceForAllProducts(); // Cập nhật tổng số tiền cho tất cả sản phẩm
            });
        });

        // Gọi hàm để tính tổng khi trang được tải cho từng sản phẩm
        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll('.f1bSN6').forEach(item => {
                updateTotalPriceForSingleProduct(item); // Cập nhật tổng tiền cho từng sản phẩm
            });
            updateTotalPriceForAllProducts(); // Cập nhật tổng tiền cho tất cả sản phẩm
        });
    </script>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>

</body>
</html>

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
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

        <style>
            .order-details:before {
                top: 0px;
            }

            .order-details {
                margin-top: 10px;
            }

            /* Tùy chỉnh thêm cho bảng */
            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: hidden;
                text-align: center !important;
                padding: 10px 0px;
            }

            th {
                font-weight: bold;
            }

            th.col1 div, td.col1 {
                text-align: left !important;
            }

            th.col2 div, td.col2 {
                text-align: center !important;
            }

            th.col3 div, td.col3 {
                text-align: right !important;
            }

            .section-title {
                margin-bottom: 15px;
                margin-top: 30px;
            }

            /* CSS cho các trường select địa chỉ */
            .form-select {
                padding: 8px 12px;
                font-size: 14px;
                color: #333;
                background-color: #f8f9fa;
                border: 1px solid #ced4da;
                border-radius: 5px;
                width: 100%;
                transition: border-color 0.3s ease;
            }

            .form-select:focus {
                outline: none;
                border-color: #D10024;
                box-shadow: 0 0 0 0.2rem rgba(209, 0, 36, 0.25);
            }

            /* CSS cho label */
            .form-label {
                font-size: 14px;
                font-weight: 500;
                color: #333;
                margin-bottom: 5px;
                display: block;
            }

            /* CSS cho thông báo lỗi */
            .error-message {
                color: #D10024;
                font-size: 12px;
                margin-top: 5px;
                display: none;
            }

            /* CSS cho input bị lỗi */
            .input-error {
                border-color: #D10024 !important;
            }

            /* CSS để đặt 3 trường địa chỉ ngang hàng */
            .address-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px; /* Khoảng cách giữa các cột */
            }

            .address-col {
                flex: 1;
                min-width: 200px; /* Đảm bảo cột không quá hẹp */
            }

            /* Responsive: xếp chồng trên màn hình nhỏ */
            @media (max-width: 768px) {
                .address-row {
                    flex-direction: column;
                    gap: 0;
                }

                .address-col {
                    min-width: 100%;
                }

                .form-select {
                    margin-bottom: 10px;
                }
            }

            .order-details .submit-btn {
                display: block; /* Để nút trở thành block element, cho phép căn giữa */
                margin: 20px auto; /* Căn giữa nút với margin auto, thêm khoảng cách trên dưới */
                text-align: center; /* Đảm bảo nội dung bên trong nút được căn giữa */
            }

            .submit-btn:disabled {
                opacity: 0.5; /* Làm mờ nút */
                cursor: not-allowed; /* Đổi con trỏ chuột để chỉ ra rằng nút không thể nhấn */
                background-color: #cccccc; /* Đổi màu nền để trông khác biệt */
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
            <div class="container">
                <div id="responsive-nav">
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="/ProjectPRJ301/home">Trang Chủ</a></li>
                        <li><a href="/ProjectPRJ301/product">Danh Mục</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- /NAVIGATION -->

        <!-- SECTION -->
        <div class="section">
            <div class="container">
                <div class="row">
                    <form action="checkout" method="POST" id="checkoutForm">
                        <div class="col-md-7">
                            <!-- Billing Details -->
                            <div class="billing-details">
                                <div class="section-title">
                                    <h3 class="title">Billing Address</h3>
                                </div>

                                <div class="form-group">
                                    <label for="full-name" class="form-label">Tên</label>
                                    <input class="input" type="text" id="full-name" name="full-name" 
                                           value="${requestScope.user != null ? requestScope.user.fullName : ''}" 
                                           placeholder="Full Name" required>
                                    <div class="error-message" id="full-name-error">Please enter your full name.</div>
                                </div>

                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <input class="input" type="email" id="email" name="email" 
                                           value="${requestScope.user != null ? requestScope.user.email : ''}" 
                                           placeholder="Email" required>
                                    <div class="error-message" id="email-error">Please enter a valid email address.</div>
                                </div>

                                <div class="form-group">
                                    <label for="tel" class="form-label">Số Điện Thoại</label>
                                    <input class="input" type="tel" id="tel" name="tel" 
                                           value="${requestScope.user != null ? requestScope.user.phoneNumber : ''}" 
                                           placeholder="Telephone" required>
                                    <div class="error-message" id="tel-error">Please enter a valid phone number.</div>
                                </div>

                                <!-- Đặt 3 trường địa chỉ ngang hàng -->
                                <div class="form-group address-row">
                                    <div class="address-col">
                                        <label for="city" class="form-label">Tỉnh / Thành Phố</label>
                                        <select name="city" class="form-select" id="city" required>
                                            <option value="${requestScope.address != null && requestScope.address.size() > 3 ? requestScope.address.get(3) : ''}" selected>
                                                ${requestScope.address != null && requestScope.address.size() > 3 ? requestScope.address.get(3) : 'Tỉnh Thành'}
                                            </option>
                                        </select>
                                        <div class="error-message" id="city-error">Please select a city/province.</div>
                                    </div>

                                    <div class="address-col">
                                        <label for="district" class="form-label">Quận / Huyện</label>
                                        <select name="district" class="form-select" id="district" required>
                                            <option value="${requestScope.address != null && requestScope.address.size() > 2 ? requestScope.address.get(2) : ''}" selected>
                                                ${requestScope.address != null && requestScope.address.size() > 2 ? requestScope.address.get(2) : 'Quận Huyện'}
                                            </option>
                                        </select>
                                        <div class="error-message" id="district-error">Please select a district.</div>
                                    </div>

                                    <div class="address-col">
                                        <label for="ward" class="form-label">Xã / Phường</label>
                                        <select name="ward" class="form-select" id="ward" required>
                                            <option value="${requestScope.address != null && requestScope.address.size() > 1 ? requestScope.address.get(1) : ''}" selected>
                                                ${requestScope.address != null && requestScope.address.size() > 1 ? requestScope.address.get(1) : 'Xã Phường'}
                                            </option>
                                        </select>
                                        <div class="error-message" id="ward-error">Please select a ward.</div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="addressDetail" class="form-label">Địa Chỉ Chi Tiết</label>
                                    <input type="text" class="input" id="addressDetail" name="addressDetail" 
                                           value="${requestScope.address != null && requestScope.address.size() > 0 ? requestScope.address.get(0) : ''}" 
                                           placeholder="Detailed Address" required>
                                    <div class="error-message" id="addressDetail-error">Please enter your detailed address.</div>
                                </div>
                            </div>
                            <!-- /Billing Details -->

                            <!-- Order notes -->
                            <div class="order-notes">
                                <label for="note" class="form-label">Ghi Chú Đơn Hàng</label>
                                <textarea name="note" id="note" class="input" placeholder="Order Notes"></textarea>
                            </div>
                            <!-- /Order notes -->
                        </div>

                        <!-- Order Details -->
                        <!-- Order Details -->
                        <div class="col-md-5 order-details">
                            <div class="section-title text-center">
                                <h3 class="title">Your Order</h3>
                            </div>
                            <div class="order-summary">
                                <div class="order-products">
                                    <div class="order-col">
                                        <table border="1">
                                            <thead>
                                                <tr>
                                                    <th class="col1"><div class="order-col"><div><strong>PRODUCT</strong></div></div></th>
                                                    <th class="col2"><div class="order-col"><div><strong>QUANTITY</strong></div></div></th>
                                                    <th class="col3"><div class="order-col"><div><strong>TOTAL</strong></div></div></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${not empty requestScope.listCartItem}">
                                                    <c:forEach var="p" items="${requestScope.listCartItem}">
                                                        <c:set var="price" value="${p.getProduct().getSalePrice()}" />
                                                        <c:set var="quantity" value="${p.getQuantity()}" />
                                                        <c:set var="itemTotal" value="${price * quantity}" />
                                                        <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                                                        <tr>
                                                            <td class="col1">${p.getProduct().getProductName()}</td>
                                                            <td class="col2">${p.getQuantity()}</td>
                                                            <td class="col3">$${itemTotal}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty requestScope.listCartItem}">
                                                    <tr>
                                                        <td colspan="3">No items in cart.</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="order-col">
                                    <div>Shipping</div>
                                    <div><strong>FREE</strong></div>
                                </div>
                                <div class="order-col">
                                    <div><strong>TOTAL</strong></div>
                                    <div><strong class="order-total">${totalAmount}</strong></div>
                                </div>
                            </div>
                            <div class="payment-method">
                                <label class="form-label">Phương Thức Thanh Toán</label>
                                <div class="input-radio">
                                    <input type="radio" name="payment" value="BankTransfer" id="payment-1">
                                    <label for="payment-1">
                                        <span></span>
                                        Chuyển Khoản Ngân Hàng
                                    </label>
                                    <div class="caption">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                                    </div>
                                </div>
                                <div class="input-radio">
                                    <input type="radio" name="payment" value="Cash" id="payment-3">
                                    <label for="payment-3">
                                        <span></span>
                                        Tiền Mặt Khi Nhận Hàng
                                    </label>
                                    <div class="caption">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                                    </div>
                                </div>
                                <div class="error-message" id="payment-error">Vui lòng chọn một phương thức thanh toán.</div>
                            </div>
                            <!-- Thêm trường ẩn để gửi totalAmount -->
                            <input type="hidden" name="totalAmount" value="${totalAmount != null ? totalAmount : 0}">
                            <button type="submit" class="primary-btn order-submit submit-btn" 
                                    <c:if test="${empty requestScope.listCartItem}">disabled</c:if>>Submit</button>
                        </div>
                        <!-- /Order Details -->
                        <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /SECTION -->

            <!-- NEWSLETTER -->
            <div id="newsletter" class="section">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="newsletter">
                                <p>Sign Up for the <strong>NEWSLETTER</strong></p>
                                <form>
                                    <input class="input" type="email" placeholder="Enter Your Email">
                                    <button class="newsletter-btn"><i class="fa fa-envelope"></i> Subscribe</button>
                                </form>
                                <ul class="newsletter-follow">
                                    <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                                    <li><a href="#"><i class="fa fa-pinterest"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /NEWSLETTER -->

            <!-- FOOTER -->
            <footer id="footer">
                <div class="section">
                    <div class="container">
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
                    </div>
                </div>

                <div id="bottom-footer" class="section">
                    <div class="container">
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
                                    Copyright ©<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </footer>
            <!-- /FOOTER -->

            <!-- jQuery Plugins -->
            <script src="js/jquery.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script src="js/slick.min.js"></script>
            <script src="js/nouislider.min.js"></script>
            <script src="js/jquery.zoom.min.js"></script>
            <script src="js/main.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
            <script>
                                        var citis = document.getElementById("city");
                                        var districts = document.getElementById("district");
                                        var wards = document.getElementById("ward");
                                        var Parameter = {
                                            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                            method: "GET",
                                            responseType: "application/json",
                                        };
                                        var promise = axios(Parameter);
                                        promise.then(function (result) {
                                            renderCity(result.data);
                                        });
                                        function renderCity(data) {
                                            for (const x of data) {
                                                // Đặt value thành tên thay vì ID
                                                citis.options[citis.options.length] = new Option(x.Name, x.Name);
                                            }
                                            citis.onchange = function () {
                                                districts.length = 1;
                                                wards.length = 1;
                                                if (this.value != "") {
                                                    const result = data.filter(n => n.Name === this.value);
                                                    for (const k of result[0].Districts) {
                                                        // Đặt value thành tên thay vì ID
                                                        districts.options[districts.options.length] = new Option(k.Name, k.Name);
                                                    }
                                                }
                                            };
                                            districts.onchange = function () {
                                                wards.length = 1;
                                                const dataCity = data.filter((n) => n.Name === citis.value);
                                                if (this.value != "") {
                                                    const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;
                                                    for (const w of dataWards) {
                                                        // Đặt value thành tên thay vì ID
                                                        wards.options[wards.options.length] = new Option(w.Name, w.Name);
                                                    }
                                                }
                                            };
                                        }
            </script>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var checkoutForm = document.getElementById('checkoutForm');
                    var paymentRadios = document.querySelectorAll('input[name="payment"]');
                    var paymentError = document.getElementById('payment-error');

                    // Thay đổi action dựa trên phương thức thanh toán
                    paymentRadios.forEach(function (radio) {
                        radio.addEventListener('change', function () {
                            if (this.value === 'Cash') {
                                checkoutForm.action = 'checkout';
                            } else if (this.value === 'BankTransfer') {
                                checkoutForm.action = 'payment';
                            }
                            paymentError.style.display = 'none'; // Ẩn thông báo lỗi khi chọn
                        });
                    });

                    // Xử lý submit form
                    checkoutForm.addEventListener('submit', function (e) {
                        var selectedPayment = document.querySelector('input[name="payment"]:checked');
                        if (!selectedPayment) {
                            e.preventDefault(); // Ngăn submit nếu chưa chọn
                            paymentError.style.display = 'block'; // Hiển thị thông báo lỗi
                        } else {
                            paymentError.style.display = 'none'; // Ẩn thông báo lỗi nếu đã chọn
                        }
                    });
                });
            </script>
    </body>
</html>
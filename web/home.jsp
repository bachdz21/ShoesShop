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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

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
            .text-danger {
                color: #D10024 !important;
            }


            .settings-btn {
                position: absolute;
                top: 1760px;
                left: 56px;
                background: none;
                border: none;
                font-size: 24px;
                color: #333;
                cursor: pointer;
                z-index: 10; /* Đảm bảo nút nằm trên các phần tử khác */
            }
            /* CSS cho nút Settings */
            .hot-deal-setting {
                position: absolute;
                top: -40px;
                left: -120px;
                background: none;
                border: none;
                font-size: 24px;
                color: #333;
                cursor: pointer;
                z-index: 10; /* Đảm bảo nút nằm trên các phần tử khác */
            }


            .settings-btn:hover {
                color: #D10024; /* Màu khi hover, tùy chỉnh theo theme của bạn */
            }

            /* CSS cho Modal */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
            }

            .modal-content {
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
                border-radius: 5px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
            }

            .form-group input {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }

            /* Đảm bảo container của hot-deal không che khuất nút */
            #hot-deal .container {
                position: relative;
            }

            .form-group input[type="text"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .primary-btn {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                color: #fff;
                cursor: pointer;
            }
            .primary-btn:hover {
                opacity: 0.9;
            }

            /* CSS for Most Sold Modal */
            #settingsMostSoldModal .modal-content {
                width: 100%;
                max-width: 400px; /* Adjusted width to fit content */
                margin: 10% auto; /* Center the modal vertically and horizontally */
                padding: 20px;
                text-align: center; /* Center-align text and inline elements */
            }

            #settingsMostSoldModal h4 {
                margin-bottom: 20px; /* Add spacing below the title */
            }

            #settingsMostSoldModal .form-group {
                text-align: left; /* Align form content to the left for better readability */
                margin: 0 auto; /* Center the form group */
                width: 80%; /* Limit the width of the form group for better spacing */
            }

            #settingsMostSoldModal .form-group label {
                display: flex; /* Use flexbox to align checkbox and text */
                align-items: center; /* Vertically center the checkbox and label text */
                margin-bottom: 10px; /* Add spacing between each label */
            }

            #settingsMostSoldModal .form-group input[type="checkbox"] {
                margin-right: 10px; /* Add spacing between checkbox and label text */
                width: 16px; /* Set a consistent size for the checkbox */
                height: 16px; /* Set a consistent size for the checkbox */
                margin-bottom: 5px;
            }

            #settingsMostSoldModal .primary-btn {
                display: inline-block; /* Ensure the button is centered */
                background-color: #D10024; /* Match the theme color */
            }
        </style>
    </head>


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
                        <li  class="active"><a href="./home">Trang Chủ</a></li>
                        <li><a href="./product">Danh Mục</a></li>
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
                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/SneakerHotSale.jpg" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Giày Thể Thao<br>Hot Sale</h3>
                                <a href="./search?category=Sneaker&query=" class="cta-btn">Mua Ngay <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/BootsHotSale.jpg" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Boots<br>Hot Sale</h3>
                                <a href="./search?category=Boot&query=" class="cta-btn">Mua Ngay <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->

                    <!-- shop -->
                    <div class="col-md-4 col-xs-6">
                        <div class="shop">
                            <div class="shop-img">
                                <img src="./img/SandalHotSale.jpg" alt="">
                            </div>
                            <div class="shop-body">
                                <h3>Sandal<br>Hot Sale</h3>
                                <a href="./search?category=Sandal&query=" class="cta-btn">Mua Ngay <i class="fa fa-arrow-circle-right"></i></a>
                            </div>
                        </div>
                    </div>
                    <!-- /shop -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">

                    <!-- section title -->
                    <div class="col-md-12">
                        <div class="section-title">
                            <h3 class="title">SẢN PHẨM MỚI</h3>
                        </div>
                    </div>
                    <!-- /section title -->

                    <!-- Products tab & slick -->
                    <div class="col-md-12">
                        <div class="row">
                            <div class="products-tabs">
                                <!-- tab -->
                                <div id="tab1" class="tab-pane active">

                                    <div class="products-slick" data-nav="#slick-nav-sale">
                                        <!-- product -->
                                        <c:forEach var="i" items="${requestScope.listSaleProducts}">
                                            <div class="product">
                                                <a href="productDetail?id=${i.productID}&category=${i.categoryName}" class="product-img">
                                                    <img src="${i.imageURL}" alt="">
                                                    <div class="product-label">
                                                        <span class="sale">-${i.sale}%</span>
                                                        <span class="new">Mới</span>
                                                    </div>
                                                </a>
                                                <div class="product-body">
                                                    <p class="product-category">${i.categoryName}</p>
                                                    <h3 class="product-name"><a href="productDetail?id=${i.productID}">${i.productName}</a></h3>
                                                    <h4 class="product-price">$${i.salePrice} <del class="product-old-price">$${i.price}</del></h4>
                                                    <div class="product-rating">
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                        <i class="fa fa-star"></i>
                                                    </div>

                                                    <!-- Kiểm tra nếu sản phẩm đã có trong wishlist -->
                                                    <c:set var="isInWishlist" value="false" />
                                                    <c:forEach var="item" items="${sessionScope.wishlist}">
                                                        <c:if test="${item.product.productID == i.productID}">
                                                            <c:set var="isInWishlist" value="true" />
                                                        </c:if>
                                                    </c:forEach>

                                                    <form action="addWishlist" method="GET" style="display: inline-block">
                                                        <input type="hidden" name="productID" value="${i.productID}">
                                                        <div class="product-btns">
                                                            <!-- Hiển thị icon trái tim đỏ nếu đã có trong wishlist, nếu không thì hiển thị trái tim trắng -->
                                                            <button class="add-to-wishlist">
                                                                <i class="${isInWishlist ? 'fa fa-heart text-danger' : 'far fa-heart'}"></i>
                                                                <span class="tooltipp">${isInWishlist ? 'Đã có trong wishlist' : 'Thêm vào wishlist'}</span>
                                                            </button>
                                                        </div>
                                                    </form>

                                                    <div class="product-btns" style="display: inline-block">
                                                        <button class="quick-view"><i class="fa-regular fa-eye"></i><span class="tooltipp">quick view</span></button>
                                                    </div>
                                                </div>

                                                <form action="addCartQuick" method="GET">
                                                    <div class="add-to-cart">
                                                        <input type="hidden" name="quantity" value="1">
                                                        <input type="hidden" name="productID" value="${i.productID}">
                                                        <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                                    </div>
                                                </form>

                                            </div>
                                        </c:forEach>
                                        <!-- product -->
                                    </div>
                                    <div id="slick-nav-sale" class="products-slick-nav"></div>
                                </div>
                                <!-- /tab -->
                            </div>
                        </div>
                    </div>
                    <!-- Products tab & slick -->
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /SECTION -->

        <!-- HOT DEAL SECTION -->

        <div id="hot-deal" class="section">
            <!-- container -->
            <div class="container">
                <!-- Icon Settings cho Employee -->
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Employee'}">
                    <button class="settings-btn hot-deal-setting" onclick="openSettingsModal()">
                        <i class="fa fa-cog"></i>
                    </button>
                </c:if>

                <!-- row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="hot-deal">
                            <ul class="hot-deal-countdown">
                                <li><div><h3 id="days">00</h3><span>Ngày</span></div></li>
                                <li><div><h3 id="hours">00</h3><span>Giờ</span></div></li>
                                <li><div><h3 id="minutes">00</h3><span>Phút</span></div></li>
                                <li><div><h3 id="seconds">00</h3><span>Giây</span></div></li>
                            </ul>
                            <h2 class="text-uppercase" id="hot-deal-title"></h2>
                            <p id="hot-deal-subtitle"></p>
                            <a class="primary-btn cta-btn" href="./product">Mua Ngay</a>
                        </div>
                    </div>
                </div>
                <!-- /row -->
            </div>
        </div>
        <!-- /container -->

        <!-- Modal Settings -->
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Employee'}">
            <div id="settingsModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeSettingsModal()">×</span>
                    <h4>Cài Đặt Hot Deal</h4>
                    <form id="hot-deal-form" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="hot-deal-image">Thay đổi ảnh:</label>
                            <input type="file" id="hot-deal-image" name="hot-deal-image" accept="image/*">
                        </div>
                        <div class="form-group">
                            <label for="hot-deal-endtime">Thời gian kết thúc:</label>
                            <input type="datetime-local" id="hot-deal-endtime" name="hot-deal-endtime">
                        </div>
                        <div class="form-group">
                            <label for="hot-deal-title-input">Tiêu đề:</label>
                            <input type="text" id="hot-deal-title-input" name="hot-deal-title-input">
                        </div>
                        <div class="form-group">
                            <label for="hot-deal-subtitle-input">Phụ đề:</label>
                            <input type="text" id="hot-deal-subtitle-input" name="hot-deal-subtitle-input">
                        </div>
                        <button type="button" onclick="saveSettings()" class="primary-btn">Lưu</button>
                        <button type="button" onclick="resetSettings()" class="primary-btn" style="color: #D10024;
                                background-color: white;
                                margin-left: 10px;
                                border: solid 1px;">XOÁ HẾT</button>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- /HOT DEAL SECTION -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- Icon Settings cho Employee -->
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Employee'}">
                    <button class="settings-btn" onclick="openMostSoldSettingsModal()">
                        <i class="fa fa-cog"></i>
                    </button>
                </c:if>

                <!-- row -->
                <div class="row">
                    <c:forEach var="category" items="${requestScope.categories}" varStatus="loop">
                        <div class="col-md-4 col-xs-6">
                            <div class="section-title">
                                <h4 class="title">${category.categoryName}</h4><br>
                                <h4 class="title">Bán Chạy Nhất</h4>
                                <div class="section-nav">
                                    <div id="slick-nav-${loop.count}" class="products-slick-nav"></div>
                                </div>
                            </div>

                            <div class="products-widget-slick" data-nav="#slick-nav-${loop.count}">
                                <div>
                                    <c:forEach var="product" items="${requestScope.mostSoldProductsByCategory[category.categoryName]}" varStatus="status" begin="0" end="2">
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="${product.imageURL}" alt="">
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">${product.categoryName}</p>
                                                <h3 class="product-name"><a href="#">${product.productName}</a></h3>
                                                    <c:choose>
                                                        <c:when test="${product.sale > 0}">
                                                        <h4 class="product-price">$${product.salePrice} <del class="product-old-price">$${product.price}</del></h4>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <h4 class="product-price">$${product.price}</h4>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div>
                                    <c:forEach var="product" items="${requestScope.mostSoldProductsByCategory[category.categoryName]}" varStatus="status" begin="3" end="5">
                                        <div class="product-widget">
                                            <div class="product-img">
                                                <img src="${product.imageURL}" alt="">
                                            </div>
                                            <div class="product-body">
                                                <p class="product-category">${product.categoryName}</p>
                                                <h3 class="product-name"><a href="#">${product.productName}</a></h3>
                                                    <c:choose>
                                                        <c:when test="${product.sale > 0}">
                                                        <h4 class="product-price">$${product.salePrice} <del class="product-old-price">$${product.price}</del></h4>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <h4 class="product-price">$${product.price}</h4>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <c:if test="${loop.count % 3 == 0}">
                            <div class="clearfix visible-sm visible-xs"></div>
                        </c:if>
                    </c:forEach>
                </div>
                <!-- /row -->
            </div>
            <!-- /container -->

            <!-- Modal Settings cho Employee -->
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Employee'}">
                <div id="settingsMostSoldModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeMostSoldSettingsModal()">×</span>
                        <h4>Chọn Danh Mục Hiển Thị</h4>
                        <form id="category-display-form" method="post" action="updateDisplayedCategories">
                            <div class="form-group">
                                <c:forEach var="category" items="${allCategories}">
                                    <label>
                                        <input type="checkbox" name="selectedCategories" value="${category.categoryID}"
                                               <c:forEach var="displayed" items="${requestScope.categories}">
                                                   <c:if test="${displayed.categoryID == category.categoryID}">checked</c:if>
                                               </c:forEach>
                                               > ${category.categoryName}
                                    </label><br>
                                </c:forEach>
                            </div>
                            <button type="button" onclick="saveMostSoldSettings()" class="primary-btn">Lưu</button>
                        </form>
                    </div>
                </div>
            </c:if>
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
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>            
        <script>
                                const userRole = "${sessionScope.user != null ? sessionScope.user.role : 'Customer'}";

                                // Hàm đếm ngược
                                function updateCountdown(endTime) {
                                    const now = new Date();
                                    const targetTime = endTime ? new Date(endTime) : now;
                                    const totalTimeRemaining = targetTime - now;
                                    if (totalTimeRemaining <= 0) {
                                        clearInterval(countdownInterval);
                                        document.getElementById("days").innerText = "00";
                                        document.getElementById("hours").innerText = "00";
                                        document.getElementById("minutes").innerText = "00";
                                        document.getElementById("seconds").innerText = "00";
                                        return true; // Trả về true nếu thời gian đã hết
                                    }

                                    const seconds = Math.floor((totalTimeRemaining / 1000) % 60);
                                    const minutes = Math.floor((totalTimeRemaining / 1000 / 60) % 60);
                                    const hours = Math.floor((totalTimeRemaining / 1000 / 60 / 60) % 24);
                                    const days = Math.floor(totalTimeRemaining / (1000 * 60 * 60 * 24));
                                    document.getElementById("days").innerText = days < 10 ? "0" + days : days;
                                    document.getElementById("hours").innerText = hours < 10 ? "0" + hours : hours;
                                    document.getElementById("minutes").innerText = minutes < 10 ? "0" + minutes : minutes;
                                    document.getElementById("seconds").innerText = seconds < 10 ? "0" + seconds : seconds;
                                    return false; // Trả về false nếu thời gian chưa hết
                                }

                                // Hàm khởi tạo Hot Deal từ server
                                function initializeHotDeal() {
                                    fetch('/ShoesStoreWed/getHotDeal')
                                            .then(response => response.json())
                                            .then(data => {
                                                const hotDealSection = document.getElementById("hot-deal");
                                                const isTimeExpired = data.endTime ? updateCountdown(data.endTime) : true;

                                                // Nếu thời gian hết và không phải Employee, ẩn Hot Deal
                                                if (isTimeExpired && userRole !== "Employee") {
                                                    hotDealSection.style.display = "none";
                                                    return; // Thoát hàm nếu không hiển thị
                                                } else {
                                                    hotDealSection.style.display = "block"; // Đảm bảo hiển thị nếu không thỏa mãn điều kiện ẩn
                                                }

                                                if (data.endTime && !isTimeExpired) {
                                                    clearInterval(countdownInterval);
                                                    countdownInterval = setInterval(() => updateCountdown(data.endTime), 1000);
                                                } else {
                                                    updateCountdown(); // Hiển thị 00:00:00:00 nếu không có thời gian hoặc đã hết
                                                }

                                                document.getElementById("hot-deal-title").innerText = data.title ? data.title.toUpperCase() : "TIÊU ĐỀ";
                                                document.getElementById("hot-deal-subtitle").innerText = data.subtitle || "Phụ Đề";

                                                // Chỉ cập nhật các input trong modal nếu người dùng là Employee
                                                if (userRole === "Employee") {
                                                    document.getElementById("hot-deal-title-input").value = data.title || "TIÊU ĐỀ";
                                                    document.getElementById("hot-deal-subtitle-input").value = data.subtitle || "Phụ Đề";
                                                    document.getElementById("hot-deal-endtime").value = data.endTime ? data.endTime.slice(0, 16) : "";
                                                }

                                                if (data.imageURL) {
                                                    hotDealSection.style.background = "url('" + data.imageURL + "') no-repeat center center";
                                                    hotDealSection.style.backgroundSize = "cover";
                                                } else {
                                                    hotDealSection.style.background = "url('./img/hotdeal.png') no-repeat center center";
                                                    hotDealSection.style.backgroundSize = "cover";
                                                }
                                            })
                                            .catch(error => console.error('Error fetching hot deal settings:', error));
                                }

                                window.onload = function () {
                                    initializeHotDeal();
                                };

                                // Hàm mở/đóng Modal
                                function openSettingsModal() {
                                    document.getElementById("settingsModal").style.display = "block";
                                }

                                function closeSettingsModal() {
                                    document.getElementById("settingsModal").style.display = "none";
                                }

                                window.onclick = function (event) {
                                    const modal = document.getElementById("settingsModal");
                                    if (event.target == modal) {
                                        modal.style.display = "none";
                                    }
                                };

                                // Hàm lưu cài đặt
                                function saveSettings() {
                                    const endTime = document.getElementById("hot-deal-endtime").value;
                                    const title = document.getElementById("hot-deal-title-input").value;
                                    const subtitle = document.getElementById("hot-deal-subtitle-input").value;
                                    const fileInput = document.getElementById("hot-deal-image");

                                    if (endTime && new Date(endTime) <= new Date()) {
                                        alert("Vui lòng chọn thời gian trong tương lai!");
                                        return;
                                    }

                                    const formData = new FormData();
                                    formData.append("endTime", endTime);
                                    formData.append("title", title);
                                    formData.append("subtitle", subtitle);
                                    if (fileInput.files.length > 0) {
                                        formData.append("hot-deal-image", fileInput.files[0]);
                                    }

                                    fetch('/ShoesStoreWed/saveHotDeal', {
                                        method: 'POST',
                                        body: formData
                                    })
                                            .then(response => response.text())
                                            .then(() => {
                                                if (endTime) {
                                                    clearInterval(countdownInterval);
                                                    countdownInterval = setInterval(() => updateCountdown(endTime), 1000);
                                                } else {
                                                    clearInterval(countdownInterval);
                                                    updateCountdown();
                                                }
                                                document.getElementById("hot-deal-title").innerText = title ? title.toUpperCase() : "TIÊU ĐỀ";
                                                document.getElementById("hot-deal-subtitle").innerText = subtitle || "Phụ Đề";
                                                initializeHotDeal(); // Cập nhật lại giao diện sau khi lưu
                                                closeSettingsModal();
                                            })
                                            .catch(error => console.error('Error saving settings:', error));
                                }

                                // Hàm reset cài đặt
                                function resetSettings() {
                                    fetch('/ShoesStoreWed/resetHotDeal', {method: 'POST'})
                                            .then(response => response.text())
                                            .then(() => {
                                                clearInterval(countdownInterval);
                                                updateCountdown();
                                                document.getElementById("hot-deal-title").innerText = "TIÊU ĐỀ";
                                                document.getElementById("hot-deal-subtitle").innerText = "Phụ Đề";
                                                document.getElementById("hot-deal-endtime").value = "";
                                                document.getElementById("hot-deal-title-input").value = "TIÊU ĐỀ";
                                                document.getElementById("hot-deal-subtitle-input").value = "Phụ Đề";
                                                initializeHotDeal(); // Cập nhật lại giao diện sau khi reset
                                                closeSettingsModal();
                                            })
                                            .catch(error => console.error('Error resetting settings:', error));
                                }

                                let countdownInterval;
        </script>
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
        </script>
    </body>
</html>

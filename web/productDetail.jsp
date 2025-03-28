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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .add-to-cart {
                display: flex;
                align-items: center;
            }

            .input-number {
                display: flex;
                align-items: center;
                margin-right: 10px; /* Khoảng cách giữa input và nút */
            }

            .add-to-cart-btn {
                margin-left: 10px; /* Khoảng cách giữa nút và input */
            }

            .product-details .add-to-cart {
                margin-bottom: 0px;
            }

            .product-img {
                position: relative; /* Đặt vị trí tương đối để .product-label định vị tuyệt đối bên trong */
                display: block;
            }

            .product-label {
                position: absolute;
                top: 10px; /* Khoảng cách từ đỉnh */
                right: 10px; /* Khoảng cách từ bên phải */
                text-align: center;
            }

            .product-label .sale {
                background-color: #ff0000; /* Màu nền đỏ cho nổi bật - tùy chỉnh nếu cần */
                color: #fff; /* Màu chữ trắng */
                padding: 5px 10px; /* Khoảng đệm */
                border-radius: 3px; /* Bo góc */
                font-size: 12px; /* Kích thước chữ */
            }

            .shop-reply {
                margin-top: 15px;
                padding-left: 20px;
                border-left: 2px solid #ddd;
            }

            .shop-reply-title {
                font-size: 14px;
                font-weight: bold;
                color: #555;
            }

            .review-media {
                display: flex; /* Sử dụng flexbox để sắp xếp ngang */
                gap: 10px; /* Khoảng cách giữa các phần tử */
                margin-top: 10px;
            }

            .reviews-pagination li {
                display: inline-block;
            }

            .reviews-pagination li a {
                text-decoration: none;
                color: #000;
            }

            .reviews-pagination li.active a {
                color: #fff;
            }

            .reviews-pagination {
                margin-top: 20px;
                text-align: center;
            }
            .reviews-pagination button {
                margin: 0 5px;
                cursor: pointer;
                display: inline-block;
                width: 35px;
                height: 35px;
                line-height: 35px;
                text-align: center;
                background-color: #FFF;
                border: 1px solid #E4E7ED;
                -webkit-transition: 0.2s all;
                transition: 0.2s all;
            }

            .reviews-pagination button:hover {
                background-color: #E4E7ED;
                color: #D10024;
            }

            .reviews-pagination button.active {
                background-color: #D10024;
                border-color: #D10024;
                color: #FFF;
                cursor: default;
            }
            .reviews-pagination button:disabled {
                cursor: not-allowed;
                opacity: 0.5;
            }
            .reviews-pagination span {
                margin: 0 5px;
                color: #333;
                font-weight: bold;
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
    <body>
        <!-- HEADER -->
        <jsp:include page="header.jsp"/>
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
                        <li class="active"><a href="./product">Danh Mục</a></li>

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
                    <!-- Product main img -->
                    <div class="col-md-5 col-md-push-2">
                        <div id="product-main-img">
                            <c:forEach var="imageUrl" items="${product.imageURLDetail}">
                                <div class="product-preview">
                                    <img src="${imageUrl}" alt="Product Image">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- /Product main img -->

                    <!-- Product thumb imgs -->
                    <div class="col-md-2  col-md-pull-5">
                        <div id="product-imgs">

                        </div>
                    </div>
                    <!-- /Product thumb imgs -->

                    <!-- Product details -->
                    <div class="col-md-5">
                        <div class="product-details">
                            <h2 class="product-name">${product.productName}</h2>
                            <div>
                                <div class="product-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <span style="font-size: 16px; color: gray; margin-left: 10px;">
                                    Đã bán: <strong>${totalSold}</strong> sản phẩm
                                </span>
                            </div>
                            <div>
                                <!-- Kiểm tra nếu salePrice > 0 -->
                                <c:choose>
                                    <c:when test="${product.salePrice > 0}">
                                        <h3 class="product-price">
                                            ${product.salePrice} 
                                            <del class="product-old-price">${product.price}</del>
                                        </h3>
                                    </c:when>
                                    <c:otherwise>
                                        <h3 class="product-price">${product.price}</h3>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${product.stock == 0}">
                                        <span class="product-available">HẾT HÀNG</span>
                                    </div>
                                    <p>${product.description}</p>

                                    <div class="product-options">
                                        <label>
                                            Size
                                            <select class="input-select">
                                                <option value="0">X</option>
                                            </select>
                                        </label>
                                        <label>
                                            Color
                                            <select class="input-select">
                                                <option value="0">Red</option>
                                            </select>
                                        </label>
                                    </div>
                                    <div class="add-to-cart">
                                        <div class="qty-label">
                                            Qty
                                            <div class="input-number">
                                                <input type="number" name="quantity" id="amount" value="1">
                                                <span class="qty-up" onclick="handlePlus()">+</span>
                                                <span class="qty-down" onclick="handleMinus()" > - </span>
                                            </div>
                                        </div>

                                        <div class="add-to-cart">
                                            <input type="hidden" name="productID" value="${product.productID}"> <!-- Gửi productID -->
                                            <button style="background-color: white; border: black; color: black;text-transform: uppercase;
                                                    font-weight: 700;
                                                    border-radius: 40px;" >Hết hàng</button>
                                        </div>
                                    </div>

                                    <ul class="product-links">
                                        <li>LOẠI SẢN PHẨM:</li>
                                        <li><a href=""></a></li>
                                    </ul>

                                    <ul class="product-links">
                                        <li>Share:</li>
                                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                        <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                        <li><a href="#"><i class="fa fa-google-plus"></i></a></li>
                                        <li><a href="#"><i class="fa fa-envelope"></i></a></li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <span class="product-available">CÒN HÀNG</span>
                                </div>
                                <p>${product.description}</p>

                                <div class="product-options">
                                    <label>
                                        Size
                                        <select class="input-select" name="size" id="sizeSelect">
                                            <c:forEach var="variant" items="${productVariants}">
                                                <option value="${variant.sizeName}">${variant.sizeName}</option>
                                            </c:forEach>
                                        </select>
                                    </label>
                                    <label>
                                        Color
                                        <select class="input-select" name="color" id="colorSelect">
                                            <c:forEach var="variant" items="${productVariants}">
                                                <option value="${variant.colorName}">${variant.colorName}</option>
                                            </c:forEach>
                                        </select>
                                    </label>
                                </div>
                                
                                <form style="display: flex; align-items: center;" action="addCart" method="POST"> <!-- Đổi sang POST -->
                                    <div class="add-to-cart">
                                        <div class="qty-label">
                                            Qty
                                            <div class="input-number">
                                                <input type="number" name="quantity" id="amount" value="1" min="1">
                                                <span class="qty-up" onclick="handlePlus()">+</span>
                                                <span class="qty-down" onclick="handleMinus()"> - </span>
                                            </div>
                                        </div>
                                        <div class="add-to-cart">
                                            <input type="hidden" name="productID" value="${product.productID}">
                                            <input type="hidden" name="selectedSize" id="selectedSize">
                                            <input type="hidden" name="selectedColor" id="selectedColor">
                                            <button type="submit" class="add-to-cart-btn" onclick="updateHiddenFields()">
                                                <i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                            </button>
                                        </div>
                                    </div>
                                </form>

                                <ul style="padding-top: 20px" class="product-btns">
                                    <li><a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a></li>
                                </ul>

                                <ul class="product-links">
                                    <li>LOẠI SẢN PHẨM:</li>
                                    <li><a href="">${product.categoryName}</a></li>
                                </ul>


                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
                <!-- /Product details -->

                <!-- Product tab -->
                <div class="col-md-12">
                    <div id="product-tab">
                        <!-- product tab nav -->
                        <ul class="tab-nav">
                            <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                            <li><a data-toggle="tab" href="#tab2">Details</a></li>
                            <li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li>
                        </ul>
                        <!-- /product tab nav -->

                        <!-- product tab content -->
                        <div class="tab-content">
                            <!-- tab1  -->
                            <div id="tab1" class="tab-pane fade in active">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                    </div>
                                </div>
                            </div>
                            <!-- /tab1  -->

                            <!-- tab2  -->
                            <div id="tab2" class="tab-pane fade in">
                                <div class="row">
                                    <div class="col-md-12">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                                    </div>
                                </div>
                            </div>
                            <!-- /tab2  -->

                            <!-- tab3  -->
                            <div id="tab3" class="tab-pane fade in">
                                <div class="row">
                                    <!-- Rating -->
                                    <div class="col-md-3">
                                        <div id="rating">
                                            <div class="rating-avg">
                                                <span>${product.averageRating}</span>
                                                <div class="rating-stars">
                                                    <c:set var="rating" value="${product.averageRating}" />
                                                    <c:set var="fullStars" value="${rating.intValue()}" /> <!-- Phần nguyên -->
                                                    <c:set var="fraction" value="${rating - fullStars}" /> <!-- Phần thập phân -->

                                                    <!-- Hiển thị sao đầy -->
                                                    <c:forEach var="i" begin="1" end="${fullStars}">
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
                                                    <c:forEach var="i" begin="${fullStars + (fraction > 0 ? 1 : 0) + 1}" end="5">
                                                        <i class="fa fa-star-o"></i>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <ul class="rating">
                                                <c:forEach var="level" items="${ratingLevels}" varStatus="loop">
                                                    <li>
                                                        <div class="rating-stars">
                                                            <c:forEach var="i" begin="1" end="${level}">
                                                                <i class="fa fa-star"></i>
                                                            </c:forEach>
                                                            <c:forEach var="i" begin="${level + 1}" end="5">
                                                                <i class="fa fa-star-o"></i>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="rating-progress">
                                                            <c:set var="ratingCount" value="${ratings[loop.index]}" />
                                                            <c:set var="progressWidth" value="${totalReviews > 0 ? (ratingCount / totalReviews) * 100 : 0}" />
                                                            <div style="width: ${progressWidth}%; max-width: 100%"></div>
                                                        </div>
                                                        <span class="sum">${ratingCount}</span> <!-- Hiển thị số lượng rating -->
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- /Rating -->

                                    <!-- Reviews -->
                                    <!-- Reviews -->
                                    <div class="col-md-9">
                                        <div id="reviews">
                                            <ul class="reviews" id="reviewsBody">
                                                <c:forEach var="review" items="${reviews}">
                                                    <c:if test="${not empty review.comment || not empty review.reviewMedia}">
                                                        <li>
                                                            <div class="review-heading">
                                                                <h5 class="name">${review.userName}</h5>
                                                                <p class="date">
                                                                    <fmt:formatDate value="${review.reviewDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                </p>
                                                                <div class="review-rating">
                                                                    <c:forEach var="i" begin="1" end="${review.rating}">
                                                                        <i class="fa fa-star"></i>
                                                                    </c:forEach>
                                                                    <c:forEach var="i" begin="${review.rating + 1}" end="5">
                                                                        <i class="fa fa-star-o empty"></i>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>${review.comment}</p>
                                                            </div>
                                                            <div class="review-media">
                                                                <c:forEach var="media" items="${review.reviewMedia}">
                                                                    <c:choose>
                                                                        <c:when test="${media.mediaType == 'image'}">
                                                                            <a href="${media.mediaUrl}" data-lightbox="review-image" data-title="${review.userName}">
                                                                                <img src="${media.mediaUrl}" alt="Review Image" class="review-image" style="max-width: 200px; height: auto;" />
                                                                            </a>
                                                                        </c:when>
                                                                        <c:when test="${media.mediaType == 'video'}">
                                                                            <video controls class="review-video" style="max-width: 200px; height: auto;">
                                                                                <source src="${media.mediaUrl}" type="video/mp4">
                                                                                Your browser does not support the video tag.
                                                                            </video>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:forEach>
                                                            </div>
                                                            <div class="shop-reply">
                                                                <c:forEach var="reply" items="${review.reviewReply}">
                                                                    <h6 class="shop-reply-title">Shop Reply</h6>
                                                                    <p class="shop-reply-text">${reply.replyText}</p>
                                                                    <p class="shop-reply-date">
                                                                        <fmt:formatDate value="${reply.replyDate}" pattern="dd/MM/yyyy HH:mm" />
                                                                    </p>
                                                                </c:forEach>
                                                            </div>
                                                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Employee'}">
                                                                <div class="review-actions">
                                                                    <form action="deleteReview" method="POST" style="position: absolute; top: 5px; right: 5px;">
                                                                        <input type="hidden" name="reviewId" value="${review.reviewId}">
                                                                        <input type="hidden" name="productId" value="${product.productID}">
                                                                        <button type="submit" class="btn btn-link p-0" style="color: red;" onclick="return confirm('Bạn có chắc muốn xóa review này?');">
                                                                            <i class="fa fa-times"></i>
                                                                        </button>
                                                                    </form>
                                                                    <button class="btn btn-primary btn-sm" style="margin-top: 10px;" onclick="showReplyForm(${review.reviewId})">Trả lời</button>
                                                                    <div id="reply-form-${review.reviewId}" style="display: none; margin-top: 10px;">
                                                                        <form action="replyReview" method="POST">
                                                                            <input type="hidden" name="reviewId" value="${review.reviewId}">
                                                                            <input type="hidden" name="productId" value="${product.productID}">
                                                                            <textarea name="replyText" class="form-control" rows="3" placeholder="Nhập phản hồi của bạn..." required></textarea>
                                                                            <button type="submit" class="btn btn-success btn-sm" style="margin-top: 5px;">Gửi</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                            <hr>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                            <ul class="reviews-pagination" id="reviewsPagination"></ul>
                                        </div>
                                    </div>
                                    <!-- /Reviews -->
                                    <!-- /tab3  -->
                                </div>
                                <!-- /product tab content  -->
                            </div>
                        </div>
                        <!-- /product tab -->
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /SECTION -->

            <!-- Section -->
            <div class="section">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">

                        <div class="col-md-12">
                            <div class="section-title text-center">
                                <h3 class="title">Related Products</h3>
                            </div>
                        </div>

                        <!-- Product Relative -->
                        <c:forEach var="pr" items="${requestScope.productRelative}">
                            <div class="col-md-3 col-xs-6">
                                <div class="product">
                                    <a href="productDetail?id=${pr.productID}&category=${pr.categoryName}" class="product-img">
                                        <img src="${pr.imageURL}" alt="">
                                        <c:choose>
                                            <c:when test="${pr.salePrice > 0}">
                                                <div class="product-label">
                                                    <span class="sale">-${pr.sale}%</span>
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </a>

                                    <div class="product-body">
                                        <p class="product-category">${pr.categoryName}</p>
                                        <h3 class="product-name"><a href="productDetail?id=${pr.productID}&category=${pr.categoryName}">${pr.productName}</a></h3>
                                            <c:choose>
                                                <c:when test="${pr.salePrice > 0}">
                                                <h4 class="product-price">${pr.salePrice} <del class="product-old-price">${pr.price}</del></h4>
                                                </c:when>
                                                <c:otherwise>
                                                <h4 class="product-price">${pr.price}</h4>
                                            </c:otherwise>
                                        </c:choose>
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
                                            <input type="hidden" name="productID" value="${pr.productID}">
                                            <button class="add-to-cart-btn"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                    <!-- Product Relative -->

                </div>
                <!-- /row -->
            </div>
            <!-- /container -->
        </div>
        <!-- /Section -->

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
        <!-- Script AJAX -->
        <!-- jQuery -->
        <script src='https://code.jquery.com/jquery-3.3.1.slim.min.js'></script>
        <!-- Popper JS -->
        <script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js'></script>
        <!-- Bootstrap JS -->
        <script src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js'></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                                                                        function deleteReview(reviewId, productId) {
                                                                            if (confirm('Bạn có chắc muốn xóa review này?')) {
                                                                                $.ajax({
                                                                                    url: 'deleteReview',
                                                                                    type: 'POST',
                                                                                    data: {
                                                                                        reviewId: reviewId,
                                                                                        productId: productId
                                                                                    },
                                                                                    success: function (response) {
                                                                                        if (response === 'Success') {
                                                                                            $('#review-' + reviewId).remove();
                                                                                            alert('Review đã được xóa thành công!');
                                                                                        } else {
                                                                                            alert('Đã xảy ra lỗi: ' + response);
                                                                                        }
                                                                                    },
                                                                                    error: function (xhr, status, error) {
                                                                                        alert('Đã xảy ra lỗi khi xóa review: ' + error);
                                                                                    }
                                                                                });
                                                                            }
                                                                        }

                                                                        function showReplyForm(reviewId) {
                                                                            var form = document.getElementById('reply-form-' + reviewId);
                                                                            if (form.style.display === 'none' || form.style.display === '') {
                                                                                form.style.display = 'block';
                                                                            } else {
                                                                                form.style.display = 'none';
                                                                            }
                                                                        }

                                                                        function submitReply(event, reviewId, productId) {
                                                                            event.preventDefault(); // Ngăn form submit mặc định
                                                                            var form = $('#reply-form-submit-' + reviewId);
                                                                            var replyText = form.find('textarea[name="replyText"]').val();

                                                                            $.ajax({
                                                                                url: 'replyReview',
                                                                                type: 'POST',
                                                                                data: {
                                                                                    reviewId: reviewId,
                                                                                    productId: productId,
                                                                                    replyText: replyText
                                                                                },
                                                                                success: function (response) {
                                                                                    if (response.startsWith('Success')) {
                                                                                        var replyDate = response.split('|')[1] || new Date().toLocaleString();
                                                                                        var replyHtml = '<h6 class="shop-reply-title">Shop Reply</h6>' +
                                                                                                '<p class="shop-reply-text">' + replyText + '</p>' +
                                                                                                '<p class="shop-reply-date">' + replyDate + '</p>';

                                                                                        // Nối thêm reply mới vào danh sách thay vì ghi đè
                                                                                        $('#shop-reply-' + reviewId).append(replyHtml);

                                                                                        // Ẩn form và xóa nội dung textarea
                                                                                        $('#reply-form-' + reviewId).hide();
                                                                                        form.find('textarea[name="replyText"]').val('');
                                                                                    } else {
                                                                                        alert('Đã xảy ra lỗi: ' + response);
                                                                                    }
                                                                                },
                                                                                error: function (xhr, status, error) {
                                                                                    alert('Đã xảy ra lỗi khi gửi phản hồi: ' + error);
                                                                                }
                                                                            });
                                                                        }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const itemsPerPage = 4; // Số review mỗi trang
                const tableBody = document.getElementById('reviewsBody');
                const rows = Array.from(tableBody.getElementsByTagName('li'));
                const totalItems = rows.length;
                const totalPages = Math.ceil(totalItems / itemsPerPage);
                let currentPage = 1;

                function showPage(page) {
                    rows.forEach(row => row.style.display = 'none');
                    const startIndex = (page - 1) * itemsPerPage;
                    const endIndex = Math.min(startIndex + itemsPerPage, totalItems);
                    for (let i = startIndex; i < endIndex; i++) {
                        rows[i].style.display = 'list-item';
                    }
                    currentPage = page;
                    updatePagination();
                }

                function updatePagination() {
                    const pagination = document.getElementById('reviewsPagination');
                    pagination.innerHTML = '';

                    // Nút Previous
                    const prevBtn = document.createElement('button');
                    prevBtn.textContent = '<';
                    prevBtn.disabled = currentPage === 1;
                    prevBtn.addEventListener('click', () => showPage(currentPage - 1));
                    pagination.appendChild(prevBtn);

                    // Nếu tổng số trang <= 5, hiển thị tất cả
                    if (totalPages <= 5) {
                        for (let i = 1; i <= totalPages; i++) {
                            const pageBtn = document.createElement('button');
                            pageBtn.textContent = i;
                            pageBtn.className = currentPage === i ? 'active' : '';
                            pageBtn.addEventListener('click', () => showPage(i));
                            pagination.appendChild(pageBtn);
                        }
                    } else {
                        // Hiển thị trang đầu
                        const firstPageBtn = document.createElement('button');
                        firstPageBtn.textContent = '1';
                        firstPageBtn.className = currentPage === 1 ? 'active' : '';
                        firstPageBtn.addEventListener('click', () => showPage(1));
                        pagination.appendChild(firstPageBtn);

                        // Thêm dấu "..." nếu trang hiện tại cách trang đầu > 2
                        if (currentPage > 3) {
                            const dots1 = document.createElement('span');
                            dots1.textContent = '...';
                            pagination.appendChild(dots1);
                        }

                        // Hiển thị các trang gần trang hiện tại
                        const startPage = Math.max(2, currentPage - 1);
                        const endPage = Math.min(totalPages - 1, currentPage + 1);
                        for (let i = startPage; i <= endPage; i++) {
                            const pageBtn = document.createElement('button');
                            pageBtn.textContent = i;
                            pageBtn.className = currentPage === i ? 'active' : '';
                            pageBtn.addEventListener('click', () => showPage(i));
                            pagination.appendChild(pageBtn);
                        }

                        // Thêm dấu "..." nếu trang hiện tại cách trang cuối > 2
                        if (currentPage < totalPages - 2) {
                            const dots2 = document.createElement('span');
                            dots2.textContent = '...';
                            pagination.appendChild(dots2);
                        }

                        // Hiển thị trang cuối
                        const lastPageBtn = document.createElement('button');
                        lastPageBtn.textContent = totalPages;
                        lastPageBtn.className = currentPage === totalPages ? 'active' : '';
                        lastPageBtn.addEventListener('click', () => showPage(totalPages));
                        pagination.appendChild(lastPageBtn);
                    }

                    // Nút Next
                    const nextBtn = document.createElement('button');
                    nextBtn.textContent = '>';
                    nextBtn.disabled = currentPage === totalPages;
                    nextBtn.addEventListener('click', () => showPage(currentPage + 1));
                    pagination.appendChild(nextBtn);
                }

                if (totalItems > 0) {
                    showPage(1);
                }
            });

            function showReplyForm(reviewId) {
                var form = document.getElementById('reply-form-' + reviewId);
                if (form.style.display === 'none' || form.style.display === '') {
                    form.style.display = 'block';
                } else {
                    form.style.display = 'none';
                }
            }

            function handlePlus() {
                let amount = document.getElementById("amount");
                let value = parseInt(amount.value);
                amount.value = value + 1;
            }

            function handleMinus() {
                let amount = document.getElementById("amount");
                let value = parseInt(amount.value);
                if (value > 1) {
                    amount.value = value - 1;
                }
        
        <script>
            function updateHiddenFields() {
                var size = document.getElementById("sizeSelect").value;
                var color = document.getElementById("colorSelect").value;
                document.getElementById("selectedSize").value = size;
                document.getElementById("selectedColor").value = color;
            }
        </script>
    </body>
</html>

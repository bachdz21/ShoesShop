<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <title>Thông tin đơn hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
        <!-- Thêm Bootstrap CSS để hỗ trợ modal -->
        <link type="text/css" rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
        <style>
            :root {
                --primary-color: #d32f2f;
                --primary-light: #ffcdd2;
                --primary-dark: #b71c1c;
                --secondary-color: #f8f9fa;
                --text-color: #333;
                --border-color: #e0e0e0;
                --success-color: #689f38;
                --light-gray: #f5f5f5;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Roboto', Arial, sans-serif;
            }

            body {
                background-color: var(--light-gray);
                color: var(--text-color);
                line-height: 1.6;
                padding: 20px;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }

            header {
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
            }

            h1 {
                color: red;
                font-size: 28px;
                margin-bottom: 10px;
            }

            h3 {
                color: red;
                font-size: 20px;
                margin: 25px 0 15px 0;
                padding-bottom: 8px;
                border-bottom: 1px solid var(--border-color);
            }

            .nav-buttons {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
            }

            .back-btn {
                display: inline-flex;
                align-items: center;
                padding: 10px 15px;
                background-color: red;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 500;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
            }

            .back-btn:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .back-btn i {
                margin-right: 8px;
            }

            .info-card {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-bottom: 25px;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
                border-left: 4px solid red;
            }

            .info-item {
                margin-bottom: 12px;
                display: flex;
                align-items: center;
            }

            .info-item i {
                margin-right: 10px;
                color: red;
                width: 20px;
                text-align: center;
            }

            .info-item:last-child {
                margin-bottom: 0;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0 30px;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 1px 5px rgba(0,0,0,0.05);
            }

            .product-table th {
                background-color:red;
                color: white;
                font-weight: 500;
                text-align: left;
                padding: 15px;
            }

            .product-table td {
                padding: 15px;
                border-bottom: 1px solid var(--border-color);
                vertical-align: middle;
            }

            .product-table tr:last-child td {
                border-bottom: none;
            }

            .product-table tr:nth-child(even) {
                background-color: var(--secondary-color);
            }

            .product-table tr:hover {
                background-color: rgba(211, 47, 47, 0.05);
            }

            .product-img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 4px;
                border: 1px solid var(--border-color);
            }

            .price {
                font-weight: 500;
                color: red;
            }

            .total-price {
                font-weight: 700;
                color: var(--primary-dark);
            }

            .button {
                display: inline-block;
                padding: 8px 15px;
                background-color: red;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.2s;
            }

            .button:hover {
                background-color: var(--primary-dark);
            }

            .button:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            .summary-section {
                background-color: var(--secondary-color);
                border-radius: 6px;
                padding: 20px;
                margin-top: 20px;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                align-items: center;
            }

            .summary-item {
                display: flex;
                flex-direction: column;
            }

            .summary-label {
                font-size: 14px;
                color: #757575;
            }

            .summary-value {
                font-size: 18px;
                font-weight: 700;
                color: red;
            }

            .order-status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 50px;
                font-size: 14px;
                font-weight: 500;
                background-color: var(--primary-light);
                color: var(--primary-dark);
            }

            .order-delivered {
                background-color: rgba(104, 159, 56, 0.2);
                color: var(--success-color);
            }

            footer {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .payment-method {
                display: flex;
                align-items: center;
            }

            .payment-method i {
                margin-right: 10px;
                color: red;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .nav-buttons {
                    flex-direction: column;
                    width: 100%;
                }

                .back-btn {
                    width: 100%;
                    justify-content: center;
                }

                .product-table {
                    display: block;
                    overflow-x: auto;
                }

                .summary-section {
                    flex-direction: column;
                    gap: 15px;
                    align-items: flex-start;
                }

                footer {
                    flex-direction: column;
                    gap: 15px;
                }
            }
            /* CSS hiện tại của file mới giữ nguyên */
            /* ... (giữ nguyên toàn bộ CSS hiện tại) ... */

            /* Thêm CSS từ file cũ cho form đánh giá */
            .review-form {
                background-color: #fff;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                color: #666;
                font-size: 14px;
            }
            .product-info {
                margin-bottom: 20px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .product-image {
                max-width: 200px;
                height: auto;
                margin-bottom: 10px;
            }
            .star-rating {
                display: flex;
                gap: 5px;
                margin-bottom: 10px;
            }
            .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
                transition: color 0.3s ease;
            }
            .star.active {
                color: #ffd700;
            }
            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
                height: 100px;
                resize: vertical;
            }
            .file-input {
                margin-top: 5px;
            }
            .submit-btn {
                background-color: #ffd700;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }
            .submit-btn:hover {
                background-color: #e0a400;
            }
            .note {
                color: #888;
                font-size: 12px;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <header>
                <h1><i class="fas fa-receipt"></i> Chi tiết đơn hàng</h1>
                <div class="order-status ${order.orderStatus == 'Delivered' ? 'order-delivered' : ''}">
                    <i class="fas fa-${order.orderStatus == 'Delivered' ? 'check-circle' : 'clock'}"></i>
                    ${order.orderStatus}
                </div>
            </header>

            <div class="nav-buttons">
                <a href="./userOrder" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Trở về danh sách đơn hàng
                </a>
                <a href="./shippingInformation?orderId=${order.orderId}" class="back-btn">
                    <i class="fas fa-shipping-fast"></i> Thông tin vận chuyển
                </a>
            </div>

            <!-- Thông tin người nhận -->
            <div class="info-card">
                <h3><i class="fas fa-user-circle"></i> Thông tin người nhận</h3>
                <div class="info-item">
                    <i class="fas fa-user"></i>
                    <span><strong>Tên người nhận:</strong> ${orderContact.recipientName}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span><strong>Địa chỉ:</strong> ${order.shippingAddress}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-phone"></i>
                    <span><strong>Số điện thoại:</strong> ${orderContact.recipientPhone}</span>
                </div>
                <div class="info-item">
                    <i class="fas fa-sticky-note"></i>
                    <span><strong>Ghi chú:</strong> ${orderContact.note != null && !orderContact.note.isEmpty() ? orderContact.note : 'Không có ghi chú'}</span>
                </div>
            </div>

            <!-- Chi tiết sản phẩm -->
            <h3><i class="fas fa-box-open"></i> Chi tiết sản phẩm</h3>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Ảnh</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Tổng tiền</th>
                        <!-- Chỉ hiển thị cột Đánh giá nếu role là Customer -->
                        <c:if test="${sessionScope.user.role == 'Customer'}">
                            <th>Đánh giá</th>
                            </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="orderDetail" items="${orderDetails}">
                        <tr>
                            <td>${orderDetail.product.productName}</td>
                            <td>
                                <img src="${orderDetail.product.imageURL}" alt="${orderDetail.product.productName}" class="product-img" />
                            </td>
                            <td><fmt:formatNumber value="${orderDetail.price}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ</td>
                            <td>${orderDetail.quantity}</td>
                            <td><fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ</td>
                            <!-- Chỉ hiển thị ô Đánh giá nếu role là Customer -->
                            <c:if test="${sessionScope.user.role == 'Customer'}">
                                <td>
                                    <!-- Kiểm tra xem đã có đánh giá hay chưa -->
                                    <c:set var="existingReview" value="${reviewDAO.getReviewByUserAndProduct(sessionScope.user.userId, orderDetail.product.productID)}" />
                                    <button type="button" class="button" data-toggle="modal" data-target="#reviewModal" 
                                            data-orderid="${order.orderId}" 
                                            data-productid="${orderDetail.product.productID}" 
                                            data-productname="<c:out value='${orderDetail.product.productName}'/>" 
                                            data-imageurl="${orderDetail.product.imageURL}"
                                            data-rating="${existingReview != null ? existingReview.rating : ''}"
                                            data-comment="${existingReview != null ? existingReview.comment : ''}"
                                            ${order.orderStatus != 'Delivered' ? 'disabled' : ''}>
                                        <i class="fas fa-star"></i> ${existingReview != null ? 'Sửa Đánh Giá' : 'Đánh Giá'}
                                    </button>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Review Modal -->
            <div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header border-bottom-0">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-title text-center">
                                <h4>Đánh Giá Sản Phẩm</h4>
                            </div>
                            <div class="d-flex flex-column text-center">
                                <form action="addReview" method="POST" class="review-form" enctype="multipart/form-data" style="text-align: start">
                                    <div class="form-group product-info">
                                        <label>Sản phẩm được đánh giá:</label>
                                        <div class="selected-product-info" id="selectedProductInfo">
                                            <img id="selectedProductImage" src="" alt="Selected Product" class="product-image">
                                            <p id="selectedProductName"></p>
                                        </div>
                                        <input type="hidden" name="productID" id="productID" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="rating">Your Rating * :</label>
                                        <div class="star-rating" id="starRating">
                                            <span class="star" data-value="1">★</span>
                                            <span class="star" data-value="2">★</span>
                                            <span class="star" data-value="3">★</span>
                                            <span class="star" data-value="4">★</span>
                                            <span class="star" data-value="5">★</span>
                                        </div>
                                        <input type="hidden" name="rating" id="ratingValue" value="">
                                    </div>

                                    <div class="form-group">
                                        <label for="review">Your Review:</label>
                                        <textarea id="review" name="review"></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label>Upload Media (Optional):</label>
                                        <input type="file" name="media" class="file-input" accept="image/*,video/*" multiple>
                                        <input type="hidden" name="mediaType" id="mediaType">
                                    </div>
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="submit-btn">Gửi Đánh Giá</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng kết đơn hàng -->
            <div class="summary-section">
                <div class="summary-item">
                </div>
                <div class="summary-item">
                    <span class="summary-label">Tổng tiền hàng</span>
                    <span class="summary-value"><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true" pattern="#,###" /> VNĐ</span>
                </div>
            </div>

            <!-- Footer -->
            <footer>
                <div class="payment-method">
                    <i class="fas fa-money-bill-wave"></i>
                    <span><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</span>
                </div>
                <div>
                    <span><strong>Mã đơn hàng:</strong> #${order.orderCode}</span>
                </div>
            </footer>
        </div>

        <!-- Thêm Bootstrap JS và jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Thêm JavaScript từ file cũ -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const buttons = document.querySelectorAll(".button[data-target='#reviewModal']");

                buttons.forEach(function (button) {
                    button.addEventListener("click", function () {
                        const productID = button.getAttribute('data-productid');
                        const productName = button.getAttribute('data-productname');
                        const imageURL = button.getAttribute('data-imageurl');
                        const rating = button.getAttribute('data-rating');
                        const comment = button.getAttribute('data-comment');

                        // Gán thông tin sản phẩm vào modal
                        document.getElementById("productID").value = productID;
                        document.getElementById("selectedProductImage").src = imageURL;
                        document.getElementById("selectedProductName").textContent = productName;
                        document.getElementById("selectedProductInfo").style.display = "block";

                        // Load rating hiện tại (nếu có)
                        if (rating) {
                            document.getElementById("ratingValue").value = rating;
                            const stars = document.querySelectorAll('.star');
                            stars.forEach(star => {
                                if (star.getAttribute('data-value') <= rating) {
                                    star.classList.add('active');
                                } else {
                                    star.classList.remove('active');
                                }
                            });
                        }

                        // Load comment hiện tại (nếu có)
                        if (comment) {
                            document.getElementById("review").value = comment;
                        }
                    });
                });

                // Reset modal khi đóng
                function resetModal() {
                    document.getElementById("selectedProductImage").src = "";
                    document.getElementById("selectedProductName").textContent = "";
                    document.getElementById("selectedProductInfo").style.display = "none";
                    document.getElementById("productID").value = "";
                    document.getElementById("ratingValue").value = "";
                    document.getElementById("review").value = "";
                    document.querySelectorAll('.star').forEach(star => star.classList.remove('active'));
                }

                document.querySelector(".close").addEventListener("click", function () {
                    $('#reviewModal').modal('hide');
                    resetModal();
                });

                $('#reviewModal').on('hidden.bs.modal', function () {
                    resetModal();
                });

                // Xử lý file upload và mediaType
                document.querySelector('.file-input').addEventListener('change', function (event) {
                    var files = event.target.files;
                    var mediaTypes = [];

                    Array.from(files).forEach(file => {
                        var fileType = file.type;
                        if (fileType.startsWith('image/')) {
                            mediaTypes.push('image');
                        } else if (fileType.startsWith('video/')) {
                            mediaTypes.push('video');
                        } else {
                            mediaTypes.push('other');
                        }
                    });
                    document.getElementById('mediaType').value = JSON.stringify(mediaTypes);
                });

                // Xử lý đánh giá sao
                const stars = document.querySelectorAll('.star');
                const ratingInput = document.getElementById('ratingValue');
                stars.forEach(star => {
                    star.addEventListener('click', function () {
                        const value = this.getAttribute('data-value');
                        ratingInput.value = value;
                        stars.forEach(s => s.classList.remove('active'));
                        this.classList.add('active');
                        for (let i = 0; i < value; i++) {
                            stars[i].classList.add('active');
                        }
                    });
                    star.addEventListener('mouseover', function () {
                        const value = this.getAttribute('data-value');
                        stars.forEach((s, index) => {
                            if (index < value)
                                s.classList.add('active');
                            else
                                s.classList.remove('active');
                        });
                    });
                    star.addEventListener('mouseout', function () {
                        stars.forEach(s => s.classList.remove('active'));
                        const currentRating = ratingInput.value;
                        if (currentRating) {
                            for (let i = 0; i < currentRating; i++) {
                                stars[i].classList.add('active');
                            }
                        }
                    });
                });
            });
        </script>
    </body>
</html>
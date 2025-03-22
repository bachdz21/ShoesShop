<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/cart.css">
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <style>
            #buy-amount {
                display: flex;
            }
            #buy-amount button {
                width: 35px;
                height: 35px;
                outline: none;
                background: none;
                border: 1px solid #ececec;
                cursor: pointer;
            }
            #buy-amount button:hover {
                background-color: #ececec;
            }
            #buy-amount #amount {
                width: 40px;
                text-align: center;
                border: 1px solid #ececec;
            }
            .slfWNx.slfWNx {
                text-align: center;
                padding-top: 10px;
            }
            .product-add-link {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 15px;
                background-color: #D10024;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
                margin-left: 187px;
            }
            .product-add-link:hover {
                background-color: #ff3333;
            }
            /* Tùy chỉnh checkbox */
            .stardust-checkbox {
                display: inline-block;
                position: relative;
                padding-left: 25px;
                cursor: pointer;
                user-select: none;
            }
            .stardust-checkbox input[type="checkbox"] {
                position: absolute;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }
            .stardust-checkbox .checkmark {
                position: absolute;
                top: -8px;
                left: 0;
                height: 20px;
                width: 20px;
                background-color: #fff;
                border: 1px solid #ccc;
                border-radius: 3px;
            }
            .stardust-checkbox:hover input[type="checkbox"] ~ .checkmark {
                background-color: #f0f0f0;
            }
            .stardust-checkbox input[type="checkbox"]:checked ~ .checkmark {
                background-color: #D10024;
                border-color: #D10024;
            }
            .stardust-checkbox .checkmark:after {
                content: "";
                position: absolute;
                display: none;
            }
            .stardust-checkbox input[type="checkbox"]:checked ~ .checkmark:after {
                display: block;
            }
            .stardust-checkbox .checkmark:after {
                left: 7px;
                top: 3px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <nav id="navigation">
            <div class="container">
                <div id="responsive-nav">
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="/ProjectPRJ301/home">Trang Chủ</a></li>
                        <li><a href="/ProjectPRJ301/product">Danh Mục</a></li>
                        <li><a href="getOrderByUserID" class="admin-link">Danh Sách Đơn Hàng</a></li>
                            <c:if test="${sessionScope.user != null && sessionScope.user.role == 'Admin'}">
                            <li><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
                            <li><a href="getAllOrders" class="admin-link">Danh Sách Tất Cả Đơn Hàng</a></li>
                            </c:if>
                    </ul>
                </div>
            </div>
        </nav>
        <a href="cartItem" class="product-add-link">Giỏ Hàng</a>
        <div class="container shopee-fake">
            <main class="GO0LDV" style="margin-bottom: 0px;">
                <h2 class="a11y-hidden">Product List Section</h2>
                <div class="Za1N64">
                    <div class="SQGY8I">
                        <label class="stardust-checkbox">
                            <input id="select-all" class="stardust-checkbox__input" type="checkbox" aria-label="Select all products">
                            <span class="checkmark"></span>
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
                                            <input class="item-checkbox" type="checkbox" data-product-id="${p.getProduct().getProductID()}" aria-label="Select this product">
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                    <div class="brf29Y">
                                        <div class="bzhajK">
                                            <a href="">
                                                <picture class="xh1MNn">
                                                    <img width="80" loading="lazy" class="RIhds1 lazyload jFEiVQ" src="${p.getProduct().getImageURL()}" height="80" alt="product image">
                                                </picture>
                                            </a>
                                            <div class="Ou_0WX">
                                                <a class="c54pg1" title="${p.getProduct().getProductName()}" href="">${p.getProduct().getProductName()}</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="eHDC_o">
                                        <div class="qNRZqG">
                                            <button class="mM4TZ8" role="button" tabindex="0">
                                                <div class="iIg1CN">Phân loại hàng:</div>
                                                <div class="dDPSp3">${p.getProduct().getCategoryName()}</div>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="gJyWia">
                                        <div>
                                            <c:choose>
                                                <c:when test="${p.getProduct().getSale() > 0}">
                                                    <span class="vjkBXu">${p.getProduct().getSalePrice()} $</span>
                                                    <span style="text-decoration: line-through; color: #757575; margin-left: 8px;">
                                                        ${p.getProduct().getPrice()} $
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="vjkBXu">${p.getProduct().getPrice()} $</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="sluy3i">
                                        <div id="buy-amount">
                                            <input style="height: 35px" type="text" name="amount" id="amount" value="${p.quantity}" readonly>
                                        </div>
                                    </div>
                                    <div class="HRvCAv total-amount">
                                        <span class="total-price">${p.getProduct().getPrice()} $</span>
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
                <div class="WhvsrO Kk1Mak">
                    <button id="delete-selected" class="clear-btn-style GQ7Hga">Xóa Đã Chọn</button>
                    <button id="restore-selected" class="clear-btn-style GQ7Hga">Khôi Phục Đã Chọn</button>
                </div>
            </section>
        </div>
        <footer id="footer">
            <jsp:include page="footer.jsp" />
        </footer>

        <!-- jQuery Plugins -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

        <!-- JavaScript xử lý chọn checkbox và hành động -->
        <script>
            // Xử lý checkbox "Chọn Tất Cả" ở trên cùng
            document.getElementById('select-all').addEventListener('change', function () {
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                itemCheckboxes.forEach(checkbox => {
                    checkbox.checked = this.checked; // Đồng bộ trạng thái với checkbox trên cùng
                });
            });

            // Xử lý khi thay đổi trạng thái của checkbox sản phẩm
            document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function () {
                    const allCheckboxes = document.querySelectorAll('.item-checkbox');
                    const selectAllCheckbox = document.getElementById('select-all');
                    const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
                    const someChecked = Array.from(allCheckboxes).some(cb => cb.checked);

                    // Cập nhật trạng thái checkbox "Chọn Tất Cả"
                    selectAllCheckbox.checked = allChecked;
                    if (!someChecked)
                        selectAllCheckbox.checked = false;
                });
            });

            // Xử lý nút "Xóa Đã Chọn"
            document.getElementById('delete-selected').addEventListener('click', function () {
                const selectedItems = document.querySelectorAll('.item-checkbox:checked');
                if (selectedItems.length === 0) {
                    alert('Vui lòng chọn ít nhất một sản phẩm để xóa.');
                    return;
                }

                const productIds = Array.from(selectedItems).map(item => item.getAttribute('data-product-id'));
                deleteSelectedItems(productIds, 'deleteCartItemTrash');
            });

            // Xử lý nút "Khôi Phục Đã Chọn"
            document.getElementById('restore-selected').addEventListener('click', function () {
                const selectedItems = document.querySelectorAll('.item-checkbox:checked');
                if (selectedItems.length === 0) {
                    alert('Vui lòng chọn ít nhất một sản phẩm để khôi phục.');
                    return;
                }

                const productIds = Array.from(selectedItems).map(item => item.getAttribute('data-product-id'));
                deleteSelectedItems(productIds, 'restoreCartItem');
            });

            // Hàm gửi yêu cầu AJAX để xóa hoặc khôi phục
            function deleteSelectedItems(productIds, actionUrl) {
                fetch(actionUrl, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({productIds: productIds})
                })
                        .then(response => {
                            if (response.ok) {
                                location.reload();
                            } else {
                                alert('Có lỗi xảy ra. Vui lòng thử lại.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra. Vui lòng thử lại.');
                        });
            }
            
            const updateTotalPriceForSingleProduct = (item) => {
                const price = parseFloat(item.querySelector('.vjkBXu').innerText.replace('$', '').trim()); // Lấy giá sản phẩm
                const amountInput = item.querySelector('input[name^="amount"]'); // Tìm input có name bắt đầu bằng "amount"
                const amount = parseInt(amountInput.value); // Lấy số lượng sản phẩm
                const totalPrice = (price * amount).toFixed(2); // Tính tổng số tiền cho sản phẩm
                item.querySelector('.total-price').innerText = totalPrice + " $"; // Cập nhật tổng tiền cho sản phẩm
                return totalPrice; // Trả về tổng tiền cho sản phẩm
            }
            
            // Gọi hàm để tính tổng khi trang được tải cho từng sản phẩm
            document.addEventListener("DOMContentLoaded", () => {
                document.querySelectorAll('.f1bSN6').forEach(item => {
                    updateTotalPriceForSingleProduct(item); // Cập nhật tổng tiền cho từng sản phẩm
                });
                updateTotalPriceForAllProducts(); // Cập nhật tổng tiền cho tất cả sản phẩm
            });
        </script>
    </body>
</html>
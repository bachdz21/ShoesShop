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
                margin-left: 191px;
            }
            .product-add-link:hover {
                background-color: #ff3333;
            }
            .yn6AIc.dhqg2H {
                padding: 28px;
            }
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
                        <li><a href="./home">Trang Chủ</a></li>
                        <li><a href="./product">Danh Mục</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <a href="trashCart" class="product-add-link">Sản Phẩm Đã Xóa</a>
        <div class="container shopee-fake">
            <form action="getCartItemUpdateQuantity" method="POST">
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
                                <c:forEach var="p" items="${requestScope.listCartItem}">
                                    <div class="f1bSN6">
                                        <input type="hidden" name="productID" value="${p.getProduct().getProductID()}">
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
                                                        <img width="80" loading="lazy" class="RIhds1 lazyload jFEiVQ" 
                                                             src="${p.getProduct().getImageURL()}" 
                                                             height="80" alt="product image">
                                                    </picture>
                                                </a>
                                                <div class="Ou_0WX">
                                                    <a class="c54pg1" title="${p.getProduct().getProductName()}" 
                                                       href="">${p.getProduct().getProductName()}</a>
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
                                                <button type="button" class="minus-btn" data-product-id="${p.getProduct().getProductID()}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14" />
                                                    </svg>
                                                </button>
                                                <input type="text" name="amount${p.getProduct().getProductID()}" id="amount" 
                                                       value="${p.quantity}" data-product-id="${p.getProduct().getProductID()}" 
                                                       data-stock="${p.getProduct().getStock()}"> <!-- Thêm data-stock -->
                                                <button type="button" class="plus-btn" data-product-id="${p.getProduct().getProductID()}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15" />
                                                    </svg>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="HRvCAv total-amount">
                                            <span class="total-price">${p.getProduct().getPrice()}</span>
                                        </div>
                                        <div class="bRSn43 TvSDdG">
                                            <a class="lSrQtj" href="deleteCartItem?productId=${p.getProduct().getProductID()}">Xóa</a>
                                            <div class="J8cCGR">
                                                <a href="./product?categories=${p.getProduct().getCategoryName()}&minPrice=1.00&maxPrice=999.00" class="shopee-button-no-outline slfWNx">
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
                        <button id="delete-selected" class="clear-btn-style GQ7Hga">Xóa Đã Chọn</button>
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
        <footer id="footer">
            <jsp:include page="footer.jsp" />
        </footer>

        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>

        <script>
            // Hàm tính tổng số tiền cho một sản phẩm
            const updateTotalPriceForSingleProduct = (item) => {
                const price = parseFloat(item.querySelector('.vjkBXu').innerText.replace('$', '').trim());
                const amountInput = item.querySelector('input[name^="amount"]');
                const amount = parseInt(amountInput.value);
                const totalPrice = (price * amount).toFixed(2);
                item.querySelector('.total-price').innerText = totalPrice + " $";
                return totalPrice;
            }

            // Hàm tính tổng số tiền cho tất cả sản phẩm
            const updateTotalPriceForAllProducts = () => {
                let grandTotal = 0;
                const cartItems = document.querySelectorAll('.f1bSN6');
                cartItems.forEach(item => {
                    const totalPrice = parseFloat(item.querySelector('.total-price').innerText.replace('$', '').trim());
                    grandTotal += totalPrice;
                });
                document.getElementById('grand-total').innerText = grandTotal.toFixed(2) + " $";
            }

            // Hàm gửi yêu cầu AJAX để cập nhật số lượng
            const updateQuantityInDatabase = (productId, quantity, stock) => {
                if (quantity > stock) {
                    alert(`Số lượng yêu cầu vượt quá lượng hàng tồn kho.`);
                    return Promise.reject(new Error('Số lượng vượt quá tồn kho'));
                }

                return fetch('updateQuantity', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'productID=' + productId + '&quantity=' + quantity
                })
                        .then(response => {
                            if (!response.ok) {
                                return response.text().then(text => {
                                    throw new Error(text || 'Cập nhật số lượng thất bại');
                                });
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert(error.message);
                            throw error;
                        });
            }

            // Lắng nghe sự kiện cho các nút "+" và "-" cho từng sản phẩm
            document.querySelectorAll('.plus-btn').forEach(button => {
                button.addEventListener('click', (event) => {
                    const item = event.target.closest('.f1bSN6');
                    const amountInput = item.querySelector('input[name^="amount"]');
                    const productId = button.getAttribute('data-product-id');
                    const stock = parseInt(amountInput.getAttribute('data-stock'));
                    let amount = parseInt(amountInput.value);
                    amount++;
                    amountInput.value = amount;
                    updateQuantityInDatabase(productId, amount, stock)
                            .then(() => {
                                updateTotalPriceForSingleProduct(item);
                                updateTotalPriceForAllProducts();
                            })
                            .catch(() => {
                                amountInput.value = amount - 1; // Hoàn tác nếu lỗi
                            });
                });
            });

            document.querySelectorAll('.minus-btn').forEach(button => {
                button.addEventListener('click', (event) => {
                    const item = event.target.closest('.f1bSN6');
                    const amountInput = item.querySelector('input[name^="amount"]');
                    const productId = button.getAttribute('data-product-id');
                    const stock = parseInt(amountInput.getAttribute('data-stock'));
                    let amount = parseInt(amountInput.value);
                    if (amount > 1) {
                        amount--;
                        amountInput.value = amount;
                        updateQuantityInDatabase(productId, amount, stock)
                                .then(() => {
                                    updateTotalPriceForSingleProduct(item);
                                    updateTotalPriceForAllProducts();
                                })
                                .catch(() => {
                                    amountInput.value = amount + 1; // Hoàn tác nếu lỗi
                                });
                    }
                });
            });

            // Lắng nghe sự kiện cho input số lượng
            document.querySelectorAll('input[name^="amount"]').forEach(amountInput => {
                amountInput.addEventListener('input', (event) => {
                    const item = event.target.closest('.f1bSN6');
                    const productId = amountInput.getAttribute('data-product-id');
                    const stock = parseInt(amountInput.getAttribute('data-stock'));
                    let amount = parseInt(event.target.value);
                    if (isNaN(amount) || amount <= 0) {
                        amount = 1;
                    }
                    event.target.value = amount;
                    updateQuantityInDatabase(productId, amount, stock)
                            .then(() => {
                                updateTotalPriceForSingleProduct(item);
                                updateTotalPriceForAllProducts();
                            })
                            .catch(() => {
                                event.target.value = amountInput.defaultValue; // Hoàn tác nếu lỗi
                            });
                });
            });

            // Gọi hàm để tính tổng khi trang được tải
            document.addEventListener("DOMContentLoaded", () => {
                document.querySelectorAll('.f1bSN6').forEach(item => {
                    updateTotalPriceForSingleProduct(item);
                });
                updateTotalPriceForAllProducts();
            });

            // Xử lý checkbox "Chọn Tất Cả"
            document.getElementById('select-all').addEventListener('change', function () {
                const itemCheckboxes = document.querySelectorAll('.item-checkbox');
                itemCheckboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
            });

            // Xử lý khi thay đổi trạng thái của checkbox sản phẩm
            document.querySelectorAll('.item-checkbox').forEach(checkbox => {
                checkbox.addEventListener('change', function () {
                    const allCheckboxes = document.querySelectorAll('.item-checkbox');
                    const selectAllCheckbox = document.getElementById('select-all');
                    const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
                    const someChecked = Array.from(allCheckboxes).some(cb => cb.checked);

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
                fetch('deleteCartItem', {
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
            });
        </script>
    </body>
</html>
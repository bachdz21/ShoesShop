<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>
        
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
        
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
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            .list-product {
                margin: 30px; /* Lề cho container */
            }
            table {
                width: 100%; /* Đặt chiều rộng của bảng 100% */
                border-collapse: collapse; /* Gộp các viền lại với nhau */
                margin-top: 20px; /* Thêm khoảng cách phía trên */
            }

            /* Cài đặt cho các ô tiêu đề */
            th {
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                padding: 12px; /* Đệm cho ô tiêu đề */
                text-align: center; /* Căn trái cho chữ */
                vertical-align: middle;
            }

            /* Cài đặt cho các ô dữ liệu */
            td {
                border: 1px solid #ddd; /* Viền ô dữ liệu */
                padding: 8px; /* Đệm cho ô dữ liệu */
                text-align: center;
                vertical-align: middle;
            }

            /* Thay đổi màu nền khi rê chuột qua hàng */
            tr:hover {
                background-color: #f5f5f5; /* Màu nền khi rê chuột */
            }

            /* Cài đặt cho hàng lẻ */
            tr:nth-child(even) {
                background-color: #f9f9f9; /* Màu nền cho hàng lẻ */
            }

            /* Cài đặt cho hình ảnh trong bảng */
            img {
                border-radius: 5px; /* Bo tròn góc cho hình ảnh */
            }
            /* Cài đặt cho tiêu đề sản phẩm */
            .product-title {
                font-size: 24px; /* Kích thước chữ */
                color: #333; /* Màu chữ */
                margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
                text-align: center; /* Căn giữa tiêu đề */
            }

            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-bottom: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }
            .action-link {
                text-decoration: none; /* Bỏ gạch chân */
                padding: 8px 12px; /* Khoảng cách bên trong */
                border-radius: 4px; /* Bo góc */
                color: white; /* Màu chữ */
                transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu nền */
            }

            .btn-edit {
                background-color: #4CAF50; /* Màu xanh lá cây cho nút sửa */
            }

            .btn-delete {
                background-color: #f44336; /* Màu đỏ cho nút xóa */
            }

            .btn-edit:hover {
                background-color: #45a049; /* Màu xanh lá cây đậm khi hover */
            }

            .btn-delete:hover {
                background-color: #e53935; /* Màu đỏ đậm khi hover */
            }

            .divider {
                margin: 0 10px; /* Khoảng cách giữa các liên kết */
            }
            .add-product-container {
                margin: 40px auto; /* Căn giữa với margin tự động */
                max-width: 600px; /* Đặt độ rộng tối đa */
                margin-bottom: 100px;
                margin-top: 100px;
                display: flex; /* Sử dụng Flexbox */
                flex-direction: column;
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                height: 100vh; /* Chiều cao bằng 100% viewport */

            }

        </style>
    </head>
    <body>
    <jsp:include page="header.jsp" />

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
    <div class="container">
    <div class="container-fluid pt-4 px-4">
    <form action="add" method="post" enctype="multipart/form-data" class="add-product-form">
        <hr>
        <div class="form-group">
            <label for="productName">Tên Sản Phẩm:</label>
            <input type="text" id="productName" name="productName" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="description">Mô Tả:</label>
            <textarea id="description" name="description" class="form-control "></textarea>
            <script type="text/javascript">
            </script>
        </div>

        <div class="form-group">
            <label for="price">Giá:</label>
            <input type="number" id="price" name="price" class="form-control" required>
        </div>

        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isSale" name="isSale" onchange="toggleSaleInput(this)">
            <label class="form-check-label" for="isSale">Sale:</label>
        </div>

        <div id="salePercentage" class="form-group" style="display: none;">
            <label for="sale">Nhập phần trăm giá giảm:</label>
            <input type="text" id="sale" name="sale" class="form-control" placeholder="Phần trăm giảm" />
        </div>

        <div class="form-group">
            <label for="stock">Số lượng:</label>
            <input type="number" id="stock" name="stock" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="category">Danh Mục:</label>
            <select id="category" name="category" class="form-select mb-3" aria-label="Default select example" onchange="toggleOtherCategory()">
                <option value="">Chọn Danh Mục</option>
                <option value="Sneakers">Sneakers</option>
                <option value="Oxford">Oxford</option>
                <option value="Boot">Boot</option>
                <option value="Sandal">Sandal</option>
                <option value="Other">Khác</option>
            </select>
        </div>

        <div id="otherCategory" class="form-group" style="display: none;">
            <label for="otherCategoryInput">Danh Mục Khác:</label>
            <input type="text" id="otherCategoryInput" name="otherCategory" class="form-control" />
        </div>

        <div class="form-group">
            <label for="images" class="form-label">Tải Lên Ảnh:</label>
            <input type="file" id="imagesFormFileMultiple" name="images" class="form-control-file form-control bg-dark" accept="image/*" multiple required>
        </div>

        <div class="form-group">
            <label for="brand">Thương Hiệu:</label>
            <input type="text" id="brand" name="brand" class="form-control" required>
        </div>

        <button style="background-color: #d10024" type="submit" class="btn btn-primary btn-submit">Thêm Sản Phẩm</button>
        <hr>
    </form>
    </div>
    </div>
    <jsp:include page="footer.jsp" />

    <!-- jQuery Plugins -->
    <script>
        function toggleSelectAll(selectAllCheckbox) {
            const checkboxes = document.getElementsByName('productIds');
            checkboxes.forEach((checkbox) => {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }
    </script>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>
        <script>
                                        // Đặt giá trị mặc định của sale là 0 khi trang tải
                                        document.getElementById('sale').value = '0';
        </script>
        <script>
            function toggleSaleInput(checkbox) {
                const saleInput = document.getElementById('salePercentage');
                const saleValueInput = document.getElementById('sale');

                if (checkbox.checked) {
                    saleInput.style.display = 'block'; // Hiện ô input khi checkbox được tích
                } else {
                    saleInput.style.display = 'none'; // Ẩn ô input khi checkbox không được tích
                    saleValueInput.value = '0'; // Đặt lại giá trị ô input thành 0
                }
            }
        </script>
</body>
</html>

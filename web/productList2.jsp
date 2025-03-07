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
                        <li class="active"><a href="list" class="admin-link">Danh Sách Sản Phẩm</a></li>
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

    <form action="deleteMultipleProducts" method="post">
        <div class="list-product">
            <h2 class="product-title">Danh Sách Sản Phẩm</h2>
            <a href="addProduct2.jsp" class="product-add-link">Thêm Sản Phẩm</a>
            <a href="trash" class="product-add-link">Sản Phẩm Đã Xoá</a>
            <table border="1">
                <tr>
                    <th>Chọn</th>
                    <th>ID</th>
                    <th>Tên Sản Phẩm</th>
                    <th>Mô Tả</th>
                    <th>Giá</th>
                    <th>Kho</th>
                    <th>Hình Ảnh</th>
                    <th>Danh Mục</th>
                    <th>Thương Hiệu</th>
                    <th>Sale</th>
                    <th>Chỉnh Sửa</th>
                </tr>
                <c:forEach var="p" items="${requestScope.list}">
                    <tr>
                        <td><input type="checkbox" name="productIds" value="${p.productID}"></td>
                        <td>${p.productID}</td>
                        <td>${p.productName}</td>
                        <td>${p.description}</td>
                        <td>${p.price}</td>
                        <td>${p.stock}</td>
                        <td><img src="${p.imageURL}" alt="Product Image" width="50"/></td>
                        <td>${p.categoryName}</td>
                        <td>${p.brand}</td>
                        <td>${p.sale}</td>
                        <td>
                            <a href="edit?id=${p.getProductID()}" class="action-link btn-edit">Sửa</a>
                            <span class="divider">|</span>
                            <a href="deleteProduct?id=${p.productID}" class="action-link btn-delete">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
            <button type="submit" class="action-link btn-delete" style="border: none;
                    margin-top: 15px;">Xóa Nhiều Sản Phẩm</button>
        </div>
    </form>

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

</body>
</html>

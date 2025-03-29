<!DOCTYPE html>
<html lang="vi">
    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Electro - HTML Ecommerce Template</title>
        

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min_1.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

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
            .sidebar {
                position: fixed;
                margin-top: 0px;
                height: 100vh;
                overflow-y: auto;
                background-color: #191c24;
                transition: 0.5s;
                z-index: 999;
            }
            .content {
                min-height: 80vh;
                background: #ffffff;
                transition: 0.5s;
                width: 1600px;
            }

            .sidebar .navbar .navbar-nav .nav-link {
                padding: 10px 20px;
                color: var(--light);
                font-weight: 500;
                border-left: 3px solid var(--secondary);
                border-radius: 0 30px 30px 0;
                outline: none;
            }
            
            .sidebar .navbar-nav {
                background-color: #191c24;
            }
            


            .sidebar .navbar .dropdown-item {
                padding: 10px 35px;
                border-radius: 0 30px 30px 0;
                color: var(--light);
            }
            
            .form-check-input {
                background-color: white;
            }
            
            .form-group {
                margin-left: 100px;
                margin-right: 110px;
            }
            
            .btn {
                margin-left: 100px;
            }
            
            .form-group #category {
                background-color: white;
                border-style: solid;
                border-color:#cccccc;
                border-width: 1px;
                box-shadow: 0 0 1px #ededed; 
            }
            body {
                background-color: white;
                overflow-x: hidden;
            }
            #top-header {
                width: 1850px;
            }
            
            .form-group #productName {
                background-color: white;
            }
            .form-group #description {
                background-color: white;
            }
            .form-group #price {
                background-color: white;
            }
            .form-group #productName {
                background-color: white;
            }
            .form-group #sale {
                background-color: white;
            }
            .form-group #stock {
                background-color: white;
            }
            .form-group #brand {
                background-color: white;
            }
            
            
        </style>
       
    </head>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <%@page import="model.User" %>
    <%@page import="model.CartItem" %>
    <%@page import="model.WishlistItem" %>
    <%@ page import="java.util.List" %>
    <%@ page import="java.util.Calendar" %>
    <%
        // Sử dụng biến session từ request mà không cần khai báo lại
            User user = (User) request.getSession().getAttribute("user"); // Lấy thông tin người dùng từ session
        // Lấy danh sách sản phẩm trong giỏ hàng từ session
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        int totalQuantity = 0;
        double subtotal = 0.0;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                totalQuantity += item.getQuantity();
                subtotal += item.getProduct().getSalePrice() * item.getQuantity();
            }
        }
        // Lấy danh sách wishlist từ session
        List<WishlistItem> wishlistItems = (List<WishlistItem>) session.getAttribute("wishlist");
        int total = 0;
        if (wishlistItems != null) {
            for (WishlistItem item : wishlistItems) {
                total += 1;
            }
        }

        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        int currentMonth = calendar.get(Calendar.MONTH) + 1;
    %> 
        
    <body>
    <div class="container-fluyid position-relative d-flex p-0">   
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">

                    <div class="navbar-nav w-100">
                        <a href="home" class="navbar-brand mx-5 mb-3">
                            <h3 class="text-primary"><i class=""></i>ShoeShop</h3>
                        </a>
                        <div class="d-flex align-items-center ms-4 mb-4">
                            <div class="position-relative">
                                <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                            </div>
                            <div class="ms-3">
                                <h6 style="color: red" class="mb-0"><%= user.getUsername() %></h6>
                                <span style="color: red"><%= user.getRole() %></span>
                            </div>
                        </div>                        
                        <a href="./revenue?year=<%= currentYear %>&month=<%= currentMonth %>" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Doanh Thu</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Sản Phẩm</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="list" class="dropdown-item active">Danh Sách Sản Phẩm</a>
                                <a href="#" class="dropdown-item">Khác</a>
                            </div>
                        </div>    
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Tài Khoản</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="filterUser" class="dropdown-item">Danh Sách Người Dùng</a>
                                <a href="filterBanUser" class="dropdown-item">Tài Khoản Bị Khóa</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Hoạt Động</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="activeCustomers" class="dropdown-item">Hoạt Động Khách Hàng</a>
                                <a href="customerBehavior" class="dropdown-item">Sản Phẩm Ưa Chuộng</a>
                            </div>
                        </div>
                        
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-table me-2"></i>Đơn Hàng</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="allUserOrder" class="dropdown-item">Đơn Hàng Chờ Xác Nhân</a>
                                <a href="userOrder" class="dropdown-item">Đơn Hàng Đã Duyệt</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
           <!-- Sidebar End --> 
    
        <div class="content"> 
            <jsp:include page="headerAdmin.jsp"/>
            <div class="container-fluid pt-4 px-4">
                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                        <div style="color: red; font-weight: bold;">
                            <%= error %>
                        </div>
                    <% } %>                
                <form action="add" method="post" enctype="multipart/form-data" class="add-product-form">

                    <hr>

                    <div class="form-group">
                        <label for="productName">Tên Sản Phẩm:</label>
                        <input type="text" id="productName" name="productName" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="description">Mô Tả:</label>
                        <textarea id="description" name="description" class="form-control "></textarea>
                        <script type="text/javascript">
                        </script>
                    </div>

                    <div class="form-group">
                        <label for="price">Giá:</label>
                        <input type="number" id="price" name="price" class="form-control">
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
                        <input type="number" id="stock" name="stock" class="form-control">
                    </div>

                    <div class="form-group">
                        <label for="category">Danh Mục:</label>
                        <select id="category" name="category" class="form-select mb-3" aria-label="Default select example" onchange="toggleOtherCategory()">
                            <option value="">Chọn Danh Mục</option>
                            <option value="Sneaker">Sneaker</option>
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
                        <input type="file" id="imagesFormFileMultiple" name="images" class="form-control-file form-control bg-white" accept="image/*" multiple required>
                    </div>

                    <div class="form-group">
                        <label for="brand">Thương Hiệu:</label>
                        <input type="text" id="brand" name="brand" class="form-control">
                    </div>

                    <button style="background-color: #d10024" type="submit" class="btn btn-primary btn-submit">Thêm Sản Phẩm</button>
                    <hr>
                </form>                  
            </div>
        </div>
    </div>
    

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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
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

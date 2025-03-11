<!DOCTYPE html>
<html lang="vi">

    <head>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
        
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="//cdn.ckeditor.com/4.22.1/full/ckeditor.js"></script>
        
        
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <style>
            body{
                background-color: #191c24
            }
            
            .form-group{
                margin-bottom: 10px;
            }
            
            .sidebar {
                position: fixed;
                margin-top: 140px;
                width: 250px;
                height: 100vh;
                overflow-y: auto;
                background: var(--secondary);
                transition: 0.5s;
                z-index: 999;
            }

            .content {
                margin-left: -1600px;
                margin-top: 140px;
                min-height: 100vh;
                background: var(--dark);
                transition: 0.5s;
            }

            #top-header {
                width: 1850px;
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
        <div class="container-fluid position-relative d-flex p-0">
            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                    <nav class="navbar bg-secondary navbar-dark">

                    <div class="navbar-nav w-100">
                        <a href="index.html" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>List</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="#" class="dropdown-item">All Orders List</a>
                                <a href="list" class="dropdown-item nav-item nav-link active">All Products List</a>
                                <a href="#" class="dropdown-item">Other</a>
                            </div>
                        </div>
                        <a href="#" class="nav-item nav-link"><i class="fa fa-table me-2"></i>User List</a>
                        <a href="chart.html" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Charts</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="signin.html" class="dropdown-item">Sign In</a>
                                <a href="signup.html" class="dropdown-item">Sign Up</a>
                                <a href="404.html" class="dropdown-item">404 Error</a>
                                <a href="blank.html" class="dropdown-item">Blank Page</a>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->
                <!-- Navbar End -->
                
                
            <!-- MAIN HEADER -->
            <header>
                                <!-- TOP HEADER -->
                <div id="top-header">
                    <div class="container">
                        <ul class="header-links pull-left">
                            <li><a href="#"><i class="fa fa-phone"></i> 0399823683</a></li>
                            <li><a href="#"><i class="fa fa-envelope-o"></i> nvhoang2004k1922@gmail.com</a></li>
                            <li><a href="#"><i class="fa fa-map-marker"></i> SE1872 - SWP391</a></li>
                        </ul>
                        <ul class="header-links pull-right">
                            <% if (user == null) { %>
                            <li><a href="login.jsp"><i class="fa fa-user-o"></i> Đăng Nhập</a></li>
                                <% } else { %>
                            <li><a href="#"><i class="fa fa-dollar"></i> Chào Mừng, <%= user.getUsername() %></a></li>
                            <li><a href="logout"><i class="fa fa-user-o"></i> Đăng Xuất</a></li>
                                <% } %>
                        </ul>
                    </div>
                </div>
                <!-- /TOP HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="/ShoesStoreWeb/home" class="logo">
                                    <h1 style="color: white; margin-top: 14px">ShoeShop</h1>
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->
                        <div class="col-md-6">
                            <div class="header-search">
                                <form action="search" method="get">
                                    <select class="input-select" name="category">
                                        <option value="">Tất cả</option>
                                        <option value="Nike">Nike</option>
                                        <option value="Adidas">Adidas</option>
                                        <option value="Converse">Converse</option>
                                        <option value="Puma">Puma</option>
                                        <!-- Thêm các loại sản phẩm khác nếu cần -->
                                    </select>
                                    <input class="input" name="query" placeholder="Search here">
                                    <button type="submit" class="search-btn">Tìm kiếm</button>
                                </form>
                            </div>
                        </div>
                        <!-- /SEARCH BAR -->

                        <!-- ACCOUNT -->
                        <div class="col-md-3 clearfix">
                            <div class="header-ctn">

                                <!-- Cart -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Giỏ Hàng</span>
                                        <div class="qty"><%= totalQuantity %></div>
                                    </a>
                                    <div class="cart-dropdown">
                                        <div class="cart-list">
                                            <% if (cartItems != null && !cartItems.isEmpty()) { %>
                                            <% for (CartItem item : cartItems) { %>
                                            <div class="product-widget">
                                                <div class="product-img">
                                                    <img src="<%= item.getProduct().getImageURL() %>" alt="">
                                                </div>
                                                <div class="product-body">
                                                    <h3 class="product-name"><a href="#"><%= item.getProduct().getProductName() %></a></h3>
                                                    <h4 class="product-price"><span class="qty"><%= item.getQuantity() %>x</span>$<%= item.getProduct().getSalePrice() %></h4>
                                                </div>
                                            </div>
                                            <% } %>
                                            <% } else { %>
                                            <p>Giỏ hàng của bạn đang trống</p>
                                            <% } %>
                                        </div>
                                        <div class="cart-summary">
                                            <small><%= totalQuantity %> sản phẩm</small>
                                            <h5>Tổng: $<%= subtotal %></h5>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="cartItem">Xem Giỏ Hàng</a>
                                            <a href="getOrderItem">Thanh Toán <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <!-- /Cart -->
                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!
        <!-- /HEAD-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
            <!-- Content Start -->
            <div class="content">
                <!-- Form Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded h-100 p-4">
                        <h6 class="mb-4">Basic Form</h6>
                        <!-- ADDPRODUCT -->

                        <form action="add" method="post" enctype="multipart/form-data" class="add-product-form">
                            <hr>
                            <div class="form-group">
                                <label for="productName">Tên Sản Phẩm:</label>
                                <input type="text" id="productName" name="productName" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="description">Mô Tả:</label>
                                <textarea id="description" name="description" class="form-control ckeditor" required></textarea>
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
                                    <option value="Nike">Nike</option>
                                    <option value="Adidas">Adidas</option>
                                    <option value="Converse">Converse</option>
                                    <option value="Puma">Puma</option>
                                    <option value="Other">Khác</option>
                                </select>
                            </div>

                            <div id="otherCategory" class="form-group" style="display: none;">
                                <label for="otherCategoryInput">Danh Mục Khác:</label>
                                <input type="text" id="otherCategoryInput" name="otherCategory" class="form-control" />
                            </div>

                            <div class="form-group">
                                <label for="images" class="form-label">Tải Lên Ảnh:</label>
                                <input type="file" id="images formFileMultiple" name="images" class="form-control-file form-control bg-dark" accept="image/*" multiple required>
                            </div>

                            <div class="form-group">
                                <label for="brand">Thương Hiệu:</label>
                                <input type="text" id="brand" name="brand" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-primary btn-submit">Thêm Sản Phẩm</button>
                            <hr>
                        </form>
                        <!-- ADDPRODUCT -->


                    </div>
                </div>
                <!-- Form End -->


                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">ShoeShop</a>, All Right Reserved. 
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer End -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/chart/chart.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="lib/tempusdominus/js/moment.min.js"></script>
        <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

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

        <!-- Template Javascript -->
        <script src="js/main_1.js"></script>
    </body>

</html>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <title>ShoeShop</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

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

        <style>
            .table>:not(caption)>*>* {
                border-bottom-width: 0px;
            }

            .form-check-input {
                margin-top: .3em;
            }

            /* Ghim thead */
            thead th {
                position: sticky;
                top: 0;
                background-color: #f8f9fa; /* Màu nền cho tiêu đề */
                z-index: 10; /* Đặt z-index để phần đầu luôn ở trên */
            }
            /* Ghim tfoot */
            tfoot td {
                position: sticky;
                bottom: 0;
                background-color: #f8f9fa; /* Màu nền cho chân bảng */
                z-index: 10; /* Đặt z-index để chân bảng luôn ở trên */
            }

            .m-2 {
                margin: 0rem !important;
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
            <!-- Spinner Start -->
<!--            <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>-->
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                    <nav class="navbar bg-secondary navbar-dark">
                    <a href="index.html" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>ShoeShop</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Hoang</h6>
                            <span>Admin</span>
                        </div>
                    </div>
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


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">
                    <a href="index.html" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-user-edit"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4">
                        <input class="form-control bg-dark border-0" type="search" placeholder="Search">
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-envelope me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Message</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Hoang send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Hoang send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Hoang send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>  
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item text-center">See all message</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-bell me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Notification</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">Profile updated</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">New user added</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">Password changed</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item text-center">See all notifications</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">Hoang</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">My Profile</a>
                                <a href="#" class="dropdown-item">Settings</a>
                                <a href="#" class="dropdown-item">Log Out</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->


                <!-- Table Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="bg-secondary rounded h-100 p-4">
                                <div style="display: flex">
                                    <h6 class="mb-4">Table</h6>
                                    <a style="position: absolute;
                                       left: 380px;
                                       top: 110px;" href="addProduct.jsp" class="product-add-link">Thêm Sản Phẩm</a>
                                       
                                    <a style="position: absolute;
                                       left: 1635px;
                                       top: 110px;" href="trash" class="product-add-link">Sản Phẩm Đã Xóa</a>     
                                </div>
                                

                                <div class="table-responsive table-container"> <!-- Áp dụng lớp CSS ở đây -->
                                    <form action="deleteMultipleProducts" method="post">
                                        <table class="table">
                                                <h2 class="edit-product-title">Sửa Sản Phẩm</h2>
                                                <form action="update" method="post" enctype="multipart/form-data" class="edit-product-form">
                                                    <hr>
                                                    <input type="hidden" id="productId" name="productId" value="${product.productID}" />
                                                    <div class="form-group">
                                                        <label for="productName">Tên Sản Phẩm:</label>
                                                        <input type="text" id="productName" name="productName" class="form-control" value="${product.productName}" required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="description">Mô Tả:</label>
                                                        <textarea id="description" name="description" class="form-control" >${product.description}</textarea>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="price">Giá:</label>
                                                        <input type="number" id="price" name="price" class="form-control" value="${product.price}" required>
                                                    </div>

                                                    <div class="form-group form-check">
                                                        <input type="checkbox" class="form-check-input" id="isSale" name="isSale" onchange="toggleSaleInput(this)" ${product.sale > 0 ? 'checked' : ''}>
                                                        <label class="form-check-label" for="isSale">Sale:</label>
                                                    </div>

                                                    <div id="salePercentage" class="form-group" style="display: ${product.sale > 0 ? 'block' : 'none'};">
                                                        <label for="sale">Nhập phần trăm giá giảm:</label>
                                                        <input type="text" id="sale" name="sale" class="form-control" value="${product.sale}" placeholder="Phần trăm giảm" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="stock">Số lượng:</label>
                                                        <input type="number" id="stock" name="stock" class="form-control" value="${product.stock}" required>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="category">Danh Mục:</label>
                                                        <select id="category" name="category" class="form-control" onchange="toggleOtherCategory()">
                                                            <option value="">Chọn Danh Mục</option>
                                                            <option value="Nike" ${product.categoryName == 'Nike' ? 'selected' : ''}>Nike</option>
                                                            <option value="Adidas" ${product.categoryName == 'Adidas' ? 'selected' : ''}>Adidas</option>
                                                            <option value="Converse" ${product.categoryName == 'Converse' ? 'selected' : ''}>Converse</option>
                                                            <option value="Puma" ${product.categoryName == 'Puma' ? 'selected' : ''}>Puma</option>
                                                            <option value="Other" ${product.categoryName == 'Other' ? 'selected' : ''}>Khác</option>
                                                        </select>
                                                    </div>

                                                    <div id="otherCategory" class="form-group" style="display: ${product.categoryName == 'Khác' ? 'block' : 'none'};">
                                                        <label for="otherCategoryInput">Danh Mục Khác:</label>
                                                        <input type="text" id="otherCategoryInput" name="otherCategory" class="form-control" value="${product.categoryName == 'Khác' ? product.otherCategory : ''}" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="images">Tải Lên Ảnh Mới:</label>
                                                        <br>
                                                        <input type="file" id="images" name="images" class="form-control-file" accept="image/*" multiple>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="brand">Thương Hiệu:</label>
                                                        <input type="text" id="brand" name="brand" class="form-control" value="${product.brand}" required>
                                                    </div>

                                                    <button type="submit" class="btn btn-primary btn-submit">Lưu Thay Đổi</button>
                                                    <hr>
                                                </form>
                                                                           <!-- EDITPRODUCT -->

                                            <script>
                                                // Đặt giá trị mặc định của sale là 0 khi trang tải
                                                document.getElementById('sale').value = '0';
                                            </script> 


                                            <script>
                                                function toggleSalePriceInput() {
                                                    const saleCheckbox = document.getElementById("sale");
                                                    const salePriceInput = document.getElementById("salePrice");
                                                    const salePriceLabel = document.getElementById("salePriceLabel");

                                                    // Hiển thị hoặc ẩn input giá mới khi checkbox được tích hoặc bỏ tích
                                                    if (saleCheckbox.checked) {
                                                        salePriceInput.style.display = "inline-block";
                                                        salePriceLabel.style.display = "inline";
                                                    } else {
                                                        salePriceInput.style.display = "none";
                                                        salePriceLabel.style.display = "none";
                                                    }
                                                }
                                    
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                                            </script>                      
                                            <!-- EDITPRODUCT -->

                                            <script>
                                                // Đặt giá trị mặc định của sale là 0 khi trang tải
                                                document.getElementById('sale').value = '0';
                                            </script> 


                                            <script>
                                                function toggleSalePriceInput() {
                                                    const saleCheckbox = document.getElementById("sale");
                                                    const salePriceInput = document.getElementById("salePrice");
                                                    const salePriceLabel = document.getElementById("salePriceLabel");

                                                    // Hiển thị hoặc ẩn input giá mới khi checkbox được tích hoặc bỏ tích
                                                    if (saleCheckbox.checked) {
                                                        salePriceInput.style.display = "inline-block";
                                                        salePriceLabel.style.display = "inline";
                                                    } else {
                                                        salePriceInput.style.display = "none";
                                                        salePriceLabel.style.display = "none";
                                                    }
                                                }
                                            </script>                                                         
                                                    
                <!-- Table End -->
                
                <script>
                    // Đặt giá trị mặc định của sale là 0 khi trang tải
                    document.getElementById('sale').value = '0';
                </script> 


                <script>
                    function toggleSalePriceInput() {
                        const saleCheckbox = document.getElementById("sale");
                        const salePriceInput = document.getElementById("salePrice");
                        const salePriceLabel = document.getElementById("salePriceLabel");

                        // Hiển thị hoặc ẩn input giá mới khi checkbox được tích hoặc bỏ tích
                        if (saleCheckbox.checked) {
                            salePriceInput.style.display = "inline-block";
                            salePriceLabel.style.display = "inline";
                        } else {
                            salePriceInput.style.display = "none";
                            salePriceLabel.style.display = "none";
                        }
                    }
                </script>

                <!-- UPDATEPRODUCT -->

                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">ShoeStore</a>, All Right Reserved. 
                            </div>
                            <div class="col-12 col-sm-6 text-center text-sm-end">
                                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                                <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
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
                                                            function toggleSelectAll(selectAllCheckbox) {
                                                                const checkboxes = document.getElementsByName('productIds');
                                                                checkboxes.forEach((checkbox) => {
                                                                    checkbox.checked = selectAllCheckbox.checked;
                                                                });
                                                            }
        </script>
        <!-- Template Javascript -->
        <script src="js/main_1.js"></script>
    </body>

</html>
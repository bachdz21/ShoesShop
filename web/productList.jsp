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


        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min_1.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

        
        <!-- Custom styles -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        
        <style>
            .table>:not(caption)>*>* {
                border-bottom-width: 0px;
            }

            .form-check-input {
                margin-top: .3em;
            }

            .table-container {
                max-height: 565px; /* Giới hạn chiều cao của bảng */
                overflow-y: auto;  /* Thêm cuộn dọc nếu nội dung vượt quá chiều cao */
                position: relative; /* Để tạo không gian cho các phần sticky */
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

            /* Tùy chỉnh thanh cuộn */
            .table-container::-webkit-scrollbar {
                width: 12px; /* Độ rộng của thanh cuộn dọc */
            }

            .table-container::-webkit-scrollbar-track {
                background: none; /* Màu nền của track (vùng chứa thanh cuộn) */
            }

            .table-container::-webkit-scrollbar-thumb {
                background: #0f1116; /* Màu của thanh cuộn */
                border-radius: 6px; /* Làm tròn các góc của thanh cuộn */
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: #555; /* Màu của thanh cuộn khi di chuột qua */
            }
            
            body{
                overflow-y: hidden;
                background-color: #191c24
                
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
                        <a href="revenue?year=2025&month=3" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
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
            <jsp:include page="header.jsp" />
        <!-- /HEADER -->
            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <!-- Table Start -->
                
                <div class="container-fluid pt-4 px-4">
                    
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="bg-secondary rounded h-100 p-4">
                                <div style="display: flex">
                                    <h6 class="mb-4">Table</h6>
                                    <a style="position: absolute;
                                       left: 380px;
                                       top: 167px;" href="addProduct.jsp" class="product-add-link">Thêm Sản Phẩm</a>
                                       
                                    <a style="position: absolute;
                                       left: 1635px;
                                       top: 167px;" href="trash" class="product-add-link">Sản Phẩm Đã Xóa</a>
                                </div>

                                <div class="table-responsive table-container"> <!-- Áp dụng lớp CSS ở đây -->
                                    <form action="deleteMultipleProducts" method="post">
                                        <table class="table">
                                            <thead style="position: sticky; top: 0; background-color: #0f1116; z-index: 1">
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Image</th>
                                                    <th scope="col">Product Name</th>
                                                    <th scope="col">Brand</th>
                                                    <th scope="col">Category</th>
                                                    <th scope="col">Description</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Sale</th>
                                                    <th scope="col">Stock</th>
                                                    <th scope="col">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="p" items="${requestScope.list}">
                                                    <tr>
                                                        <td><input class="form-check-input" type="checkbox" name="productIds" value="${p.productID}"></td>
                                                        <th scope="row">${p.productID}</th>
                                                        <td><img src="${p.imageURL}" alt="Product Image" width="50"/></td>
                                                        <td>${p.productName}</td>
                                                        <td>${p.brand}</td>
                                                        <td>${p.categoryName}</td>
                                                        <td>${p.description}</td>
                                                        <td>${p.price}</td>
                                                        <td>${p.sale}</td>
                                                        <td>${p.stock}</td>
                                                        <td>
                                                            <a href="edit?id=${p.getProductID()}" class="action-link btn-edit">Sửa</a>
                                                            <a href="deleteProduct?id=${p.productID}" class="action-link btn-delete">Xóa</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot style="position: sticky; bottom: 0; background-color: #0f1116; z-index: 1;">
                                                <!-- Hàng cố định ở cuối -->
                                                <tr>
                                                    <td>
                                                        <input class="form-check-input" type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td></td>
                                                    <td><button type="submit" class="btn btn-danger m-2" style="font-size: 12px;margin: 0px;height: 25px;padding-top: 2px;">Delete</button></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Table End -->

                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">ShoeStore</a>, All Right Reserved. 
                            </div>
                            <div class="col-12 col-sm-6 text-center text-sm-end">

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
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
</html>
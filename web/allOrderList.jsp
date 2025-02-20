<!DOCTYPE html>
<html lang="vi">

    <head>
        <%@ page contentType="text/html; charset=UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <meta charset="UTF-8">
        <title>DarkPan - Bootstrap 5 Admin Template</title>
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
            .badge-delivered {
                color: #212529;
                background-color: #7ED321;
            }
            a.badge-delivered:hover, a.badge-delivered:focus {
                color: #212529;
                background-color: #64a71a;
            }
            a.badge-delivered:focus, a.badge-delivered.focus {
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(126, 211, 33, 0.5);
            }


            .badge-pending {
                color: #212529;
                background-color: #FFAA16;
            }
            a.badge-pending:hover, a.badge-pending:focus {
                color: #212529;
                background-color: #e29000;
            }
            a.badge-pending:focus, a.badge-pending.focus {
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(255, 170, 22, 0.5);
            }


            .badge-shipped {
                color: #fff;
                background-color: #593bdb;
            }
            a.badge-shipped:hover, a.badge-shipped:focus {
                color: #fff;
                background-color: #4123c0;
            }
            a.badge-shipped:focus, a.badge-shipped.focus {
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(89, 59, 219, 0.5);
            }


            .badge-cancelled {
                color: #fff;
                background-color: #FF1616;
            }
            a.badge-cancelled:hover, a.badge-cancelled:focus {
                color: #fff;
                background-color: #e20000;
            }
            a.badge-cancelled:focus, a.badge-cancelled.focus {
                outline: 0;
                box-shadow: 0 0 0 0.2rem rgba(255, 22, 22, 0.5);
            }

            #buy-amount{
                display: flex;
            }
            #buy-amount button{
                width: 35px;
                height: 35px;
                outline: none;
                background: none;
                border: 1px solid #ececec;
                cursor: pointer;
            }
            #buy-amount button:hover{
                background-color: #ececec;
            }
            #buy-amount #amount{
                width: 40px;
                text-align: center;
                border: 1px solid #ececec;
            }

            .slfWNx.slfWNx{
                text-align: center;
                padding-top: 10px;
            }

            /* Cài đặt cho liên kết "Thêm Sản Phẩm" */
            .product-add-link {
                display: inline-block; /* Hiển thị như một khối */
                margin-top: 20px; /* Khoảng cách dưới liên kết */
                padding: 10px 15px; /* Đệm cho liên kết */
                background-color: #D10024; /* Màu nền xanh lá cây */
                color: white; /* Màu chữ trắng */
                text-decoration: none; /* Xóa gạch chân */
                border-radius: 5px; /* Bo tròn góc cho liên kết */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền khi rê chuột */
                margin-left: 187px; /* Lề cho container */

            }

            /* Thay đổi màu nền khi rê chuột qua liên kết */
            .product-add-link:hover {
                background-color: #ff3333; /* Màu nền khi rê chuột */
            }

            .yn6AIc.dhqg2H{
                padding: 28px
            }
            
            /* Tùy chỉnh thanh cuộn */
            .table-container::-webkit-scrollbar {
                width: 12px; /* Độ rộng của thanh cuộn dọc */
            }

            .table-container::-webkit-scrollbar-track {
                background: none; /* Màu nền của track (vùng chứa thanh cuộn) */
            }

            .table-container::-webkit-scrollbar-thumb {
                background: none; /* Màu của thanh cuộn */
                border-radius: 6px; /* Làm tròn các góc của thanh cuộn */
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: #555; /* Màu của thanh cuộn khi di chuột qua */
            }
        </style>
    </head>

    <body>
        <div class="container-fluid position-relative d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-secondary navbar-dark">
                    <a href="index.html" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>DarkPan</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Jhon Doe</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="revenue?year=2024&month=11" class="nav-item nav-link"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Elements</a>
                            <div class="dropdown-menu bg-transparent border-0">
                                <a href="getAllOrders" class="dropdown-item active">All Orders List</a>
                                <a href="typography.html" class="dropdown-item">Product List</a>
                                <a href="element.html" class="dropdown-item">Other Elements</a>
                            </div>
                        </div>
                        <a href="widget.html" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Widgets</a>
                        <a href="form.html" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>Forms</a>
                        <a href="table.html" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Tables</a>
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
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
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
                                <span class="d-none d-lg-inline-flex">Notificatin</span>
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
                                <span class="d-none d-lg-inline-flex">John Doe</span>
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
                    <div class="bg-secondary text-center rounded p-4">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h6 class="mb-0">Recent Salse</h6>
                        </div>
                        <div class="table-responsive">
                            <div class="table-container" style="max-height: 371px; overflow-y: auto; border-bottom: 1px solid black">
                                <table class="table text-start align-middle table-bordered table-hover mb-0" style="width: 100%;">
                                    <thead style="position: sticky; top: 0; background-color: #0f1116; z-index: 1;">
                                        <tr class="text-white" style="border-top: 0px">
                                            <th scope="col">Date</th>
                                            <th scope="col">Invoice</th>
                                            <th scope="col">Customer</th>
                                            <th scope="col">Amount</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${requestScope.orders}">
                                            <tr>
                                                <td>${order.orderDate}</td>
                                                <td>${order.orderCode}</td>
                                                <td>${order.recipientName}</td>
                                                <td>$${order.totalAmount}</td>
                                                <td>
                                                    <span class="badge badge-${order.orderStatus.toLowerCase()}" onclick="openStatusPopup(${order.orderId}, '${order.orderStatus}')">
                                                        ${order.orderStatus}
                                                    </span>
                                                </td>
                                                <td><a class="btn btn-sm btn-primary" href="getDetailOrders?orderId=${order.orderId}">Detail</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pop-up Modal -->
                <div id="statusModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Chọn trạng thái mới</h5>
                                </button>
                            </div>
                            <div class="modal-body">
                                <select id="newStatus" class="form-control">
                                    <option value="Delivered">Delivered</option>
                                    <option value="Pending">Pending</option>
                                    <option value="Shipped">Shipped</option>
                                    <option value="Cancelled">Cancelled</option>
                                </select>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" id="confirmStatusChange">Cập nhật</button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="container-fluid pt-4 px-4">
                        <div class="bg-secondary text-center rounded p-4">
                            <div class="d-flex align-items-center justify-content-between mb-4">
                                <h6 class="mb-0">Recent Salse</h6>
                            </div>
                            <div class="table-responsive">
                                <div style="display: flex; max-height: 1000px; overflow-y: auto; border-bottom: 1px solid black">
                                    <table class="table text-start align-middle table-bordered table-hover mb-0" style="width: 100%;">
                                        <thead style="position: sticky; top: 0; background-color: #0f1116; z-index: 1;">
                                            <tr class="text-white" style="border-top: 0px">
                                                <th scope="col">Product Name</th>
                                                <th scope="col">Category</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${requestScope.products}">
                                                <tr>
                                                    <td><img src="${p.imageURL}" alt="alt" width="50px" style="margin-right: 10px"/>${p.productName}</td>
                                                    <td>${p.categoryName}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <table class="table text-start align-middle table-bordered table-hover mb-0" style="width: 100%;">
                                        <thead style="position: sticky; top: 0; background-color: #0f1116; z-index: 1;">
                                            <tr class="text-white" style="border-top: 0px">
                                                <th scope="col">Price</th>
                                                <th scope="col">Quantity</th>
                                                <th scope="col">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="od" items="${requestScope.detailOrders}">
                                                <tr>
                                                    <td>${od.price}</td>
                                                    <td>${od.quantity}</td>
                                                    <td>${od.totalAmount}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    


                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-secondary rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">Your Site Name</a>, All Right Reserved. 
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
            let currentOrderId;

            function openStatusPopup(orderId, currentStatus) {
                currentOrderId = orderId; // Lưu lại orderId hiện tại
                $('#statusModal').modal('show'); // Hiện pop-up
                $('#newStatus').val(currentStatus); // Đặt giá trị trạng thái hiện tại
            }

            $(document).ready(function () {
                $('#confirmStatusChange').click(function () {
                    const newStatus = $('#newStatus').val();

                    // Gửi yêu cầu cập nhật trạng thái
                    $.ajax({
                        url: 'updateStatus', // URL cho Servlet xử lý cập nhật
                        method: 'POST',
                        data: {
                            orderId: currentOrderId,
                            orderStatus: newStatus
                        },
                        success: function (response) {
                            // Làm mới trang hoặc cập nhật bảng sau khi thành công
                            location.reload(); // Làm mới trang
                        },
                        error: function () {
                            alert('Có lỗi xảy ra khi cập nhật trạng thái.');
                        }
                    });
                });
            });
        </script>
        
        <!-- Template Javascript -->
        <script src="js/main_1.js"></script>
    </body>

</html>
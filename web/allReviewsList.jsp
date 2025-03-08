<%-- 
    Document   : allReviewsList
    Created on : Mar 7, 2025, 5:10:55 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
      
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
        <div class="container-fluid pt-4 px-4">
    <div class="bg-secondary text-center rounded p-4">
        <div class="d-flex align-items-center justify-content-between mb-4">
            <h6 class="mb-0">Customer Reviews</h6>
        </div>
        <div class="table-responsive">
            <div class="table-container" style="max-height: 500px; overflow-y: auto; border-bottom: 1px solid black">
                <table class="table text-start align-middle table-bordered table-hover mb-0" style="width: 100%;">
                    <thead style="position: sticky; top: 0; background-color: #0f1116; z-index: 1;">
                        <tr class="text-white" style="border-top: 0px">
                            <th scope="col">Review ID</th>
                            <th scope="col">Product ID</th>
                            <th scope="col">User ID</th>
                            <th scope="col">Rating</th>
                            <th scope="col">Comment</th>
                            <th scope="col">Review Date</th>
                            <th scope="col">Approved</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="review" items="${requestScope.reviews}">
                            <tr>
                                <td>${review.reviewID}</td>
                                <td>${review.productID}</td>
                                <td>${review.userID}</td>
                                <td>${review.rating}</td>
                                <td>${review.comment}</td>
                                <td>${review.reviewDate}</td>
                                <td>
    <select class="form-select" onchange="updateApproval(${review.reviewID}, this.value)">
                        <option value="true" ${review.isApproved ? 'selected' : ''}>Đã duyệt</option>
                        <option value="false" ${!review.isApproved ? 'selected' : ''}>Chưa duyệt</option>
                    </select>
</td>



                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
   function updateApproval(reviewID, status) {
        fetch('updateReviewStatus', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `reviewID=${reviewID}&status=${status}`
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Cập nhật thành công!');
            } else {
                alert('Lỗi khi cập nhật trạng thái!');
            }
        })
        .catch(error => console.error('Lỗi:', error));
    }

</script>

    </body>
</html>

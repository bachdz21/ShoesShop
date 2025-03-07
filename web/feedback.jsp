<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh Giá Sản Phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .review-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .product-info {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .product-info img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 20px;
            border-radius: 5px;
        }
        .rating {
            margin-bottom: 25px;
        }
        .stars {
            display: inline-flex;
            direction: rtl;
            margin: 0 15px;
        }
        .stars input {
            display: none;
        }
        .stars label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .stars input:checked ~ label,
        .stars label:hover,
        .stars label:hover ~ label {
            color: #ffd700;
        }
        .review-text textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            resize: vertical;
            min-height: 150px;
        }
        .upload-section {
            margin: 25px 0;
        }
        .upload-section input[type="file"] {
            display: block;
            margin: 10px 0;
        }
        .submit-btn {
            text-align: right;
        }
        .submit {
            background-color: #007bff;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .submit:hover {
            background-color: #0056b3;
        }
        .back-btn {
            margin-top: 20px;
            background-color: #6c757d;
        }
        h2 {
            color: #333;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>
    <div class="review-container">
        <h2 class="text-center">Đánh Giá Sản Phẩm</h2>
        
        <div class="product-info">
            <img src="adidas-shoes.jpg" alt="Adidas XLG RUNNER">
            <div>
                <h5>Adidas XLG RUNNER DELUXE series</h5>
                <p class="text-muted">Cổ điển thể thao - Size: 42.5</p>
            </div>
        </div>

        <div class="rating">
            <span>Chất lượng sản phẩm:</span>
            <div class="stars">
                <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                <input type="radio" id="star1" name="rating" value="1"><label for="star1">★</label>
            </div>
            <span>Tuyệt vời</span>
        </div>

        <form action="submitReview" method="POST" enctype="multipart/form-data">
            <div class="review-text mb-4">
                <label for="review" class="form-label">Chất lượng sản phẩm:</label>
                <textarea name="review" id="review" class="form-control" rows="5" 
                    placeholder="Hãy chia sẻ những điều bạn thích về sản phẩm này với những người mua khác." 
                    required></textarea>
            </div>

            <div class="upload-section">
                <div class="mb-3">
                    <label for="image" class="form-label">Thêm Hình ảnh:</label>
                    <input type="file" name="image" id="image" class="form-control">
                </div>
                <div class="mb-3">
                    <label for="video" class="form-label">Thêm Video:</label>
                    <input type="file" name="video" id="video" class="form-control">
                </div>
            </div>

            <div class="submit-btn">
                <button type="submit" class="btn btn-primary submit">Hoàn Thành</button>
            </div>
        </form>

        <button onclick="window.location.href='backToPreviousPage'" 
                class="btn btn-secondary back-btn w-100">Trở lại</button>
    </div>

    <!-- Bootstrap JS (optional, for interactive components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
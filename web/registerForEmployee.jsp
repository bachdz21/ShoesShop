<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
    <head>
        <title>Tạo tài khoản nhân viên</title>
        <link rel="stylesheet" href="css/login-register.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f8f9fa;
            }
            .register-container {
                max-width: 500px;
                margin: 50px auto;
                padding: 30px;
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h2 {
                text-align: center;
                color: #d32f2f;
                margin-bottom: 30px;
            }
            .form-group label {
                font-weight: 500;
            }
            .btn-register {
                width: 100%;
                background-color: #d32f2f;
                border: none;
            }
            .btn-register:hover {
                background-color: #b71c1c;
            }
            .alert {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>

        <div class="register-container">
            <h2>Tạo tài khoản nhân viên</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <form action="registerEmployee" method="post">
            <div class="form-group">
                <label for="username">Tài khoản</label>
                <input type="text" class="form-control" id="username" name="username" value="<c:out value='${username}'/>" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" value="<c:out value='${password}'/>" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Xác nhận mật khẩu</label>
                <input type="password" class="form-control" id="confirm_password" name="confirm_password" value="<c:out value='${confirm_password}'/>" required>
            </div>
            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" class="form-control" id="fullname" name="fullname" value="<c:out value='${fullname}'/>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<c:out value='${email}'/>" required>
            </div>
            <div class="form-group">
                <label for="phonenumber">Số điện thoại</label>
                <input type="text" class="form-control" id="phonenumber" name="phonenumber" value="<c:out value='${phonenumber}'/>" required>
            </div>
            <div class="form-group">
                <label for="role">Vai trò</label>
                <select class="form-control" id="role" name="role" required>
                    <option value="Staff" <c:if test="${role == 'Staff'}">selected</c:if>>Nhân viên</option>
                    <option value="Shipper" <c:if test="${role == 'Shipper'}">selected</c:if>>Shipper</option>
                </select>
            </div>
            <button type="submit" class="btn btn-register">Tạo tài khoản</button>
            <div class="signup-link">
                <a href="filterUser">Quay lại danh sách</a>
            </div>
        </form>

            
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // JavaScript kiểm tra mật khẩu và xác nhận mật khẩu, cũng như kiểm tra số điện thoại
                document.querySelector("form").addEventListener("submit", function (event) {
                    // Lấy giá trị từ các ô nhập liệu
                    const username = document.querySelector("input[name='username']");
                    const password = document.querySelector("input[name='password']").value;
                    const confirmPassword = document.querySelector("input[name='confirm_password']").value;
                    const fullname = document.querySelector("input[name='fullname']");
                    const email = document.querySelector("input[name='email']");
                    const phonenumber = document.querySelector("input[name='phonenumber']");

                    // Xóa khoảng trắng ở hai bên cho các ô trừ mật khẩu và xác nhận mật khẩu
                    username.value = username.value.trim();
                    fullname.value = fullname.value.trim();
                    email.value = email.value.trim();
                    phonenumber.value = phonenumber.value.trim();

                    // Regex kiểm tra mật khẩu và số điện thoại
                    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
                    const phoneRegex = /^[0-9]{10}$/; // Kiểm tra số điện thoại chỉ chứa 10 chữ số

                    // Kiểm tra mật khẩu
                    if (!password.match(passwordRegex)) {
                        alert("Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất 1 chữ cái và 1 chữ số.");
                        event.preventDefault(); // Ngừng gửi biểu mẫu
                        return;
                    }

                    // Kiểm tra xác nhận mật khẩu
                    if (password !== confirmPassword) {
                        alert("Mật khẩu và xác nhận mật khẩu không khớp.");
                        event.preventDefault(); // Ngừng gửi biểu mẫu
                        return;
                    }

                    // Kiểm tra số điện thoại
                    if (!phonenumber.value.match(phoneRegex)) {
                        alert("Số điện thoại phải có 10 chữ số và không chứa kí tự khác.");
                        event.preventDefault(); // Ngừng gửi biểu mẫu
                        return;
                    }
                });
            });
        </script>
    </body>
</html>
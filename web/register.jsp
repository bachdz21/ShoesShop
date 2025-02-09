<%-- 
    Document   : register
    Created on : Oct 10, 2024, 12:32:38 AM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Register Form Design</title>
        <link rel="stylesheet" href="css/login-register.css">
    </head>
    <body>
        <div class="wrapper">
            <div class="title">
                Register Form
            </div>
            <!-- Hiển thị thông báo lỗi -->
            <br>
            <c:if test="${not empty error}">
                <div class="error-message" style="color: red; text-align: center;">
                    ${error}
                </div>
            </c:if>
            <form action="register" method="POST">
                <div class="field">
                    <input type="text" name="username" required>
                    <label>Tài Khoản</label>
                </div>
                <div class="field">
                    <input type="password" name="password" required>
                    <label>Mật Khẩu</label>
                </div>
                <div class="field">
                    <input type="password" name="confirm_password" required>
                    <label>Nhập Lại Mật Khẩu</label>
                </div>
                <div class="field">
                    <input type="text" name="fullname" required>
                    <label>Họ Và Tên</label>
                </div>
                <div class="field">
                    <input type="email" name="email" required>
                    <label>Email</label>
                </div>
                <div class="field">
                    <input type="text" name="phonenumber" required>
                    <label>Số Điện Thoại</label>
                </div>
                <br>
                <div class="field">
                    <input type="submit" value="Register">
                </div>
                <div class="signup-link">
                    Bạn đã có tài khoản rồi? <a href="login.jsp">Đăng Nhập</a>
                </div>
            </form>
        </div>
    </body>
</html>

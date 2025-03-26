<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Register Form Design</title>
        <link rel="stylesheet" href="css/login-register.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="wrapper">
            <div class="title">
                Đăng ký
            </div>
            <!-- Hiển thị thông báo lỗi -->
            <br>
            <c:if test="${not empty error}">
                <div class="error-message" style="color: red; text-align: center;">
                    ${error}
                </div>
            </c:if>
            <form action="register" method="POST" id="registerForm">
                <div class="field">
                    <input type="text" name="username" value="<c:out value='${username}'/>" required>
                    <label>Tài Khoản</label>
                </div>
                <div class="field">
                    <input type="password" name="password" value="<c:out value='${password}'/>" required>
                    <label>Mật Khẩu</label>
                </div>

                <div class="field">
                    <input type="password" name="confirm_password" value="<c:out value='${confirm_password}'/>" required>
                    <label>Nhập Lại Mật Khẩu</label>
                </div>
                <div class="field">
                    <input type="text" name="fullname" value="<c:out value='${fullname}'/>" required>
                    <label>Họ Và Tên</label>
                </div>
                <div class="field">
                    <input type="email" name="email" value="<c:out value='${email}'/>" required>
                    <label>Email</label>
                </div>
                <div class="field">
                    <input type="text" name="phonenumber" value="<c:out value='${phonenumber}'/>" required>
                    <label>Số Điện Thoại</label>
                </div>
                <br>
                <div class="field">
                    <input type="submit" value="Đăng ký" id="submitBtn">
                </div>
                <div class="signup-link">
                    Bạn đã có tài khoản rồi? <a href="login">Đăng Nhập</a>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="utf-8">
        <title>Xác nhận Email</title>
        <link rel="stylesheet" href="css/login-register.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>.signup-link {
    text-align: center;
    margin-bottom: 15px;
}



</style>
    </head>
    <body>
  
        
        <div class="wrapper">
            <div class="title">
                Xác nhận Email
            </div>
            <br>
            <c:if test="${not empty error}">
                <div class="error-message" style="color: red; text-align: center;">
                    ${error}
                </div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success-message" style="color: green; text-align: center;">
                    ${message}
                </div>
            </c:if>
            <form action="confirmEmail" method="POST" id="confirmEmailForm">
                <div class="field">
                    <input type="text" name="verificationCode" required>
                    <label>Nhập mã xác nhận (6 chữ số)</label>
                </div>
                <!-- Hidden field để gửi thông tin người dùng đã nhập trước đó -->
                <input type="hidden" name="username" value="${username}">
                <input type="hidden" name="password" value="${password}">
                <input type="hidden" name="fullname" value="${fullname}">
                <input type="hidden" name="email" value="${email}">
                <input type="hidden" name="phonenumber" value="${phonenumber}">
                <br>
                <div class="field">
                    <input type="submit" value="Xác nhận">
                </div>
            </form>
            <div class="signup-link">
                 <a href="login">Quay Lại Đăng Nhập</a>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector("form").addEventListener("submit", function (event) {
                    const code = document.querySelector("input[name='verificationCode']").value;
                    const codeRegex = /^[0-9]{6}$/; // Kiểm tra mã phải là 6 chữ số
                    if (!code.match(codeRegex)) {
                        alert("Mã xác nhận phải là 6 chữ số.");
                        event.preventDefault();
                    }
                });
            });
        </script>
    </body>
</html>
<!DOCTYPE html>
<html lang="vi">
<head>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu</title>
    <link rel="stylesheet" href="css/login-register.css">
</head>
<body>
    <div class="wrapper">
        <div class="title">
            QUÊN MẬT KHẨU
        </div>
        <br>
        <c:if test="${not empty error}">
            <div style="color: red; text-align: center;">
                ${error}
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div style="color: green; text-align: center;">
                ${message}
            </div>
        </c:if>
        <form action="forgotPassword" method="POST">
            <div class="field">
                <input type="email" name="email" required>
                <label>Email của bạn</label>
            </div>
            <div class="field">
                <input type="submit" value="Gửi Yêu Cầu">
            </div>
            <div class="signup-link">
                <a href="login.jsp">Quay lại đăng nhập</a>
            </div>
        </form>
    </div>
</body>
</html>

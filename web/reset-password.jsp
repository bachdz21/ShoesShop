<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt Lại Mật Khẩu</title>
        <link rel="stylesheet" href="css/login-register.css">
    </head>
    <body>
        <div class="wrapper">
            <div class="title">Đặt Lại Mật Khẩu</div>
            <form action="resetPassword" method="POST">
                <input type="hidden" name="code" value="${code}">
                <div class="field">
                    <input type="password" name="newPassword" required>
                    <label>Mật Khẩu Mới</label>
                </div>
                <div class="field">
                    <input type="password" name="confirmPassword" required>
                    <label>Xác Nhận Mật Khẩu</label>
                </div>
                <div class="field">
                    <input type="submit" value="Đặt Lại Mật Khẩu">
                </div>
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
            </form>
        </div>
    </body>
</html>
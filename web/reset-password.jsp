<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đặt Lại Mật Khẩu</title>
        <link rel="stylesheet" href="css/login-register.css">
        <script>
            function validatePassword(event) {
                var password = document.querySelector('input[name="newPassword"]').value;
                var confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
                var errorDiv = document.getElementById('errorMessage');

                // Biểu thức kiểm tra mật khẩu (ít nhất 6 ký tự, có ít nhất 1 chữ cái và 1 số)
                var regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;

                if (!regex.test(password)) {
                    errorDiv.innerText = "Mật khẩu phải có ít nhất 6 ký tự, bao gồm ít nhất 1 chữ cái và 1 chữ số.";
                    event.preventDefault(); // Ngăn không cho form gửi đi
                    return false;
                }

                if (password !== confirmPassword) {
                    errorDiv.innerText = "Xác nhận mật khẩu không khớp.";
                    event.preventDefault();
                    return false;
                }

                errorDiv.innerText = ""; // Xóa thông báo lỗi nếu hợp lệ
                return true;
            }
        </script>
    </head>
    <body>
        <div class="wrapper">
            <div class="title">Đặt Lại Mật Khẩu</div>
            <form action="resetPassword" method="POST" onsubmit="return validatePassword(event)">
                                <div id="errorMessage" style="color: red; text-align: center; margin-bottom: 10px;"></div>

                <input type="hidden" name="code" value="${code}">
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
                
                <div class="field">
                    <input type="password" name="newPassword" required>
                    <label>Mật Khẩu Mới</label>
                </div>

                <div class="field">
                    <input type="password" name="confirmPassword" required>
                    <label>Xác Nhận Mật Khẩu</label>
                </div>

                <div id="errorMessage" style="color: red; text-align: center; margin-bottom: 10px;"></div>

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

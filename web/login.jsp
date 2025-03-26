<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
    <link rel="stylesheet" href="css/login-register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
    <style>
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .password-container input[type="password"] {
            width: 100%;
            padding-right: 30px; /* Chừa khoảng trống cho icon */
        }

        .eye {
            position: absolute;
            right: 15px;
            cursor: pointer;
            width: 20px;
            height: 20px;
            color: #666; /* Thay đổi màu icon nếu muốn */
        }

        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="title">
            ĐĂNG NHẬP
        </div>
        <br>
        <c:if test="${not empty message}">
            <div style="color: green; text-align: center;">
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div style="color: red; text-align: center;">
                ${error}
            </div>
        </c:if>
        <form action="login" method="POST" id="loginForm">
            <div class="field">
                <input type="text" name="username" id="username" value="${username}" required>
                <label>Tài Khoản</label>
            </div>
            <div class="field password-container">
                <input class="input" type="password" name="password" id="password" value="${password}" required>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="eye eye-open">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
                </svg>
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="eye eye-close hidden">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88" />
                </svg>
                <br>
                <label>Mật Khẩu</label>
            </div>
            <div class="content">
                <div class="checkbox">
                    <input type="checkbox" id="remember" name="remember" ${cookie.username != null ? "checked" : ""}>
                    <label for="remember-me">Ghi nhớ đăng nhập</label>
                </div>
                <div class="pass-link">
                    <a href="forgot-password.jsp">Quên mật khẩu?</a>
                </div>
            </div>
            <div class="field">
                <input type="submit" value="Login">
            </div>
            <div class="signup-link">
                Chưa có tài khoản? <a href="register">Đăng ký</a>
            </div>
        </form>
    </div>

    <script>
        const input = document.querySelector(".input");
        const eyeOpen = document.querySelector(".eye-open");
        const eyeClose = document.querySelector(".eye-close");

        // Xử lý hiển thị/ẩn mật khẩu
        eyeOpen.addEventListener("click", function () {
            eyeOpen.classList.add("hidden");
            eyeClose.classList.remove("hidden");
            input.setAttribute("type", "password");
        });
        eyeClose.addEventListener("click", function () {
            eyeOpen.classList.remove("hidden");
            eyeClose.classList.add("hidden");
            input.setAttribute("type", "text");
        });

        // Xóa khoảng trắng hai bên ô tài khoản khi gửi form
        document.getElementById("loginForm").addEventListener("submit", function (event) {
            const usernameInput = document.getElementById("username");
            usernameInput.value = usernameInput.value.trim();
        });
    </script>
</body>
</html>
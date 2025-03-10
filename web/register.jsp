<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <input type="submit" value="Đăng ký" id="submitBtn">
                </div>
                <div class="signup-link">
                    Bạn đã có tài khoản rồi? <a href="login.jsp">Đăng Nhập</a>
                </div>
            </form>
        </div>
        <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        const usernameInput = document.querySelector("input[name='username']");
                        const emailInput = document.querySelector("input[name='email']");
                        const submitButton = document.querySelector("#submitBtn");
        
                        function checkExisting() {
                            const username = usernameInput.value;
                            const email = emailInput.value;
        
                            // Kiểm tra xem giá trị đã được lấy đúng hay chưa
                            console.log("Checking username: ", username, "and email: ", email);
        
                            fetch(`/checkExisting?username=${username}&email=${email}`, {
                                method: "GET"
                            })
                                    .then(response => response.json())
                                    .then(data => {
                                        console.log(data);  // Kiểm tra phản hồi từ server
                                        if (data.isUsernameExists) {
                                            alert("Tên đăng nhập đã tồn tại.");
                                            submitButton.disabled = true;
                                        } else if (data.isEmailExists) {
                                            alert("Email đã tồn tại.");
                                            submitButton.disabled = true;
                                        } else {
                                            submitButton.disabled = false;
                                        }
                                    })
                                    .catch(error => {
                                        console.error("Có lỗi xảy ra:", error);
                                    });
                        }
        
        
                        // Gọi kiểm tra khi người dùng nhập username hoặc email
                        usernameInput.addEventListener("input", checkExisting);
                        emailInput.addEventListener("input", checkExisting);
        
                        // JavaScript kiểm tra mật khẩu và xác nhận mật khẩu, cũng như kiểm tra số điện thoại
                        document.querySelector("form").addEventListener("submit", function (event) {
                            const password = document.querySelector("input[name='password']").value;
                            const confirmPassword = document.querySelector("input[name='confirm_password']").value;
                            const phoneNumber = document.querySelector("input[name='phonenumber']").value;
        
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
                            if (!phoneNumber.match(phoneRegex)) {
                                alert("Số điện thoại phải có 10 chữ số và không chứa kí tự khác.");
                                event.preventDefault(); // Ngừng gửi biểu mẫu
                                return;
                            }
                        });
                    });
        </script>
    </body>
</html>

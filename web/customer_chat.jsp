<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    if (userId == null || !"Customer".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Customer Chat</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900&display=swap" rel="stylesheet">
        <link href="https://zavoloklom.github.io/material-design-iconic-font/css/docs.md-iconic-font.min.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/chat.css">
    </head>
    <body>
        <div class="fabs">
            <div class="chat" style="width: 400px">
                <div class="chat_header">
                    <div class="chat_option">
                        <div class="header_img">
                            <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
                        </div>
                        <span id="chat_head">Chat hỗ trợ khách hàng</span>
                        <span class="agent">Support</span>
                        <span class="online">(Online)</span>
                        <span id="chat_fullscreen_loader" class="chat_fullscreen_loader"><i class="fullscreen zmdi zmdi-window-maximize"></i></span>
                    </div>
                </div>
                <div class="chat_body">
                    <div id="chat" class="chat_converse"></div>
                </div>
                <div class="fab_field">
                    <a id="fab_camera" class="fab"><i class="zmdi zmdi-camera"></i></a>
                    <input type="file" id="fileInput" accept="image/*,video/*" multiple style="display:none;"/>
                    <span id="filePreview" class="file-preview"></span>
                    <textarea id="msg" name="chat_message" placeholder="Send a message" class="chat_field chat_message"></textarea>
                    <a id="fab_send" class="fab" onclick="sendMessageAndFile()"><i class="zmdi zmdi-mail-send"></i></a>
                </div>
            </div>
            <a id="prime" class="fab"><i class="prime zmdi zmdi-comment-outline"></i></a>
        </div>

        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script>
                        const userId = <%= userId %>;
                        const employeeId = 19;
                        const ws = new WebSocket("ws://" + window.location.host + "/ShoesStoreWed/chat?userId=" + userId);
                        let messageQueue = [];
                        let isProcessingQueue = false;

                        ws.onmessage = function (event) {
                            try {
                                const data = JSON.parse(event.data);
                                if (data.type === "history") {
                                    if (data.data.length === 0) {
                                        queueMessage("Không có lịch sử tin nhắn", [], "chat_msg_item_admin");
                                    } else {
                                        data.data.forEach(msg => {
                                            if (msg.content || (msg.fileIds && msg.fileIds.length > 0)) {
                                                queueMessage(msg.content, msg.fileIds || [], msg.senderId === userId ? "chat_msg_item_user" : "chat_msg_item_admin", msg.time);
                                            }
                                        });
                                    }
                                } else if (data.type === "message") {
                                    if (data.senderId !== userId) {
                                        const fileIds = data.fileIds || (data.fileId ? [data.fileId] : []);
                                        if (data.content || fileIds.length > 0) {
                                            queueMessage(data.content, fileIds, "chat_msg_item_admin");
                                        }
                                    }
                                } else if (data.type === "error") {
                                    queueMessage(data.message, [], "chat_msg_item_admin");
                                }
                            } catch (e) {
                                console.error("Error parsing message:", e);
                            }
                        };

                        function getCurrentTime() {
                            return new Date().toLocaleTimeString('vi-VN', {hour: '2-digit', minute: '2-digit', hour12: false});
                        }

                        function appendMessage(content, className, time = getCurrentTime()) {
                            const chat = document.getElementById("chat");
                            const span = document.createElement("span");
                            span.className = "chat_msg_item " + className;
                            span.innerHTML = "<div class='chat_avatar'><img src='http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg'/></div>" + content + "<div class='status'>" + time + "</div>";
                            chat.appendChild(span);
                            chat.scrollTop = chat.scrollHeight;
                        }

                        function appendFile(fileId, className) {
                            return new Promise((resolve) => {
                                fetch('/ShoesStoreWed/getFileInfo?fileId=' + fileId)
                                        .then(response => response.json())
                                        .then(data => {
                                            const fileName = data.fileName;
                                            const isImage = /\.(jpg|jpeg|png|gif)$/i.test(fileName);
                                            const isVideo = /\.(mp4|mov)$/i.test(fileName);
                                            if (isImage) {
                                                resolve("<img style=\"max-width: 100%\" src=\"/ShoesStoreWed/downloadFile?fileId=" + fileId + "\" class=\"media\" alt=\"" + fileName + "\"/>");
                                            } else if (isVideo) {
                                                resolve("<video style=\"max-width: 100%\" controls class=\"media\"><source src=\"/ShoesStoreWed/downloadFile?fileId=" + fileId + "\" type=\"video/" + fileName.split('.').pop() + "\">" + fileName + "</video>");
                                            }

                                        })
                                        .catch(error => resolve("<span>Lỗi khi tải file: " + error.message + "</span>"));
                            });
                        }
                        function queueMessage(content, fileIds, className, time = getCurrentTime()) {
                            messageQueue.push({content, fileIds, className, time});
                            processQueue();
                        }

                        async function processQueue() {
                            if (isProcessingQueue || messageQueue.length === 0)
                                return;
                            isProcessingQueue = true;

                            while (messageQueue.length > 0) {
                                const {content, fileIds, className, time} = messageQueue.shift();
                                const chat = document.getElementById("chat");
                                const span = document.createElement("span");
                                span.className = "chat_msg_item " + className;

                                let fullContent = "";
                                if (content)
                                    fullContent += "<span>" + content + "</span>";
                                if (fileIds && fileIds.length > 0) {
                                    const fileContents = await Promise.all(fileIds.map(fileId => appendFile(fileId, className)));
                                    fileContents.forEach(fileContent => fullContent += (fullContent ? "<br/>" : "") + fileContent);
                                }

                                if (fullContent) {
                                    span.innerHTML = (className === "chat_msg_item_admin" ? "<div class='chat_avatar'><img src='http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg'/></div>" : "") + fullContent + "<div class='status'>" + time + "</div>";
                                    chat.appendChild(span);
                                    chat.scrollTop = chat.scrollHeight;
                                }
                                await new Promise(resolve => setTimeout(resolve, 50));
                            }
                            isProcessingQueue = false;
                        }

                        function sendMessageAndFile() {
                            const msg = document.getElementById("msg").value;
                            const fileInput = document.getElementById("fileInput");
                            const files = fileInput.files;

                            if (!msg && files.length === 0)
                                return;

                            if (files.length > 0) {
                                const formData = new FormData();
                                formData.append("userId", userId);
                                formData.append("employeeId", employeeId);
                                formData.append("messageContent", msg || "");
                                for (let i = 0; i < files.length; i++)
                                    formData.append("files", files[i]);

                                fetch('/ShoesStoreWed/uploadFile', {method: 'POST', body: formData})
                                        .then(response => response.json())
                                        .then(data => {
                                            if (data.fileIds && Array.isArray(data.fileIds)) {
                                                queueMessage(msg, data.fileIds, "chat_msg_item_user");
                                                ws.send(employeeId + ":" + JSON.stringify({message: msg || "", fileIds: data.fileIds}));
                                            } else {
                                                queueMessage("Lỗi: Không nhận được fileIds hợp lệ!", [], "chat_msg_item_admin");
                                            }
                                        })
                                        .catch(error => queueMessage("Lỗi khi tải file: " + error.message, [], "chat_msg_item_admin"));
                                fileInput.value = "";
                                document.getElementById("filePreview").innerHTML = "";
                            } else {
                                queueMessage(msg, [], "chat_msg_item_user");
                                ws.send(employeeId + ":" + JSON.stringify({message: msg, fileIds: []}));
                            }
                            document.getElementById("msg").value = "";
                        }


                        // FAB toggle
                        $('#prime').click(function () {
                            toggleFab();
                        });


                        function toggleFab() {
                            const $prime = $('#prime');
                            const $icon = $prime.find('i');

                            // Thay đổi class của icon
                            if ($icon.hasClass('zmdi-comment-outline')) {
                                $icon.removeClass('zmdi-comment-outline').addClass('zmdi-close');
                            } else {
                                $icon.removeClass('zmdi-close').addClass('zmdi-comment-outline');
                            }

                            // Toggle trạng thái active và các class khác
                            $prime.toggleClass('is-active is-float');
                            $('.chat, .fab').toggleClass('is-visible');
                        }

                        $('#fab_camera').click(function () {
                            $('#fileInput').click();
                        });

                        // Hiển thị file đã chọn
                        $('#fileInput').change(function () {
                            const files = this.files;
                            const preview = document.getElementById("filePreview");
                            preview.innerHTML = "";
                            for (let i = 0; i < files.length; i++) {
                                preview.innerHTML += "<span>" + files[i].name + "</span><br>";
                            }
                        });
        </script>
    </body>
</html>
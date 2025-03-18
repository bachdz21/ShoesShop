<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<% 
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    if (userId == null || !"Employee".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Employee Chat</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900&display=swap" rel="stylesheet">
        <link href="https://zavoloklom.github.io/material-design-iconic-font/css/docs.md-iconic-font.min.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/chat.css"/>
    </head>
    <body>
        <div class="fabs">
            <div class="chat">

                <div class="chat_container">

                    <div class="session-list" id="sessionList"></div>
                    <div class="chat_body">
                        <div class="chat_header">
                            <div class="chat_option">
                                <div class="header_img">
                                    <img src="http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg"/>
                                </div>
                                <span id="chat_head">Chat với khách hàng</span>
                            </div>
                        </div>
                        <div id="chat" class="chat_converse"></div>
                        <div class="fab_field">
                            <a id="fab_camera" class="fab"><i class="zmdi zmdi-camera"></i></a>
                            <input type="file" id="fileInput" accept="image/*,video/*" multiple style="display:none;"/>
                            <span id="filePreview" class="file-preview"></span>
                            <textarea id="msg" name="chat_message" placeholder="Send a message" class="chat_field chat_message"></textarea>
                            <a id="fab_send" class="fab" onclick="sendMessageAndFile()"><i class="zmdi zmdi-mail-send"></i></a>
                        </div>
                    </div>
                </div>

            </div>
            <a id="prime" class="fab"><i class="prime zmdi zmdi-comment-outline"></i></a>
        </div>

        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script>
                                const userId = <%= userId %>;
                                let selectedCustomerId = null;
                                let selectedSessionId = null;
                                const ws = new WebSocket("ws://" + window.location.host + "/ShoesStoreWed/chat?userId=" + userId);
                                let messageQueue = [];
                                let isProcessingQueue = false;

                                ws.onmessage = function (event) {
                                    const chat = document.getElementById("chat");
                                    try {
                                        const data = JSON.parse(event.data);
                                        if (data.type === "SessionList") {
                                            updateSessionList(data); // Chỉ cập nhật danh sách phiên
                                            // Không gọi selectLatestSession nữa
                                        } else if (data.type === "message") {
                                            if (data.sessionId === selectedSessionId && data.senderId !== userId) {
                                                queueMessage(data.content, data.fileIds || [], "chat_msg_item_admin");
                                            }
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

                                // Hàm chọn phiên mới nhất
                                function selectLatestSession(data) {
                                    const sessions = data.data.split(";");
                                    if (sessions.length > 0 && sessions[0]) {
                                        const [sessionId, customerId, name] = sessions[0].split(",");
                                        selectSession(sessionId, customerId, name);
                                    }
                                }

                                function updateSessionList(data) {
    const list = document.getElementById("sessionList");
    list.innerHTML = ""; // Xóa danh sách cũ
    const sessions = data.data.split(";");
    sessions.forEach(s => {
        if (s) {
            const [sessionId, customerId, name] = s.split(",");
            const parsedSessionId = parseInt(sessionId); // Đảm bảo sessionId là số nguyên
            const div = document.createElement("div");
            div.innerText = name || "Khách hàng " + customerId;
            div.dataset.sessionId = parsedSessionId; // Lưu sessionId vào dataset để dễ debug
            div.dataset.customerId = customerId; // Lưu customerId để sử dụng nếu cần
            div.onclick = () => selectSession(parsedSessionId, customerId, name);
            if (parsedSessionId === selectedSessionId) { // So sánh chính xác với selectedSessionId
                div.classList.add("active");
            }
            list.appendChild(div);
        }
    });
    console.log("Updated session list, selectedSessionId:", selectedSessionId); // Debug
}

                                function selectSession(sessionId, customerId, name) {
                                    if (selectedSessionId !== parseInt(sessionId)) { // Chỉ tải lịch sử nếu phiên thay đổi
                                        selectedCustomerId = parseInt(customerId);
                                        selectedSessionId = parseInt(sessionId);
                                        document.getElementById("chat").innerHTML = "";
                                        fetchMessageHistory(sessionId);
                                    }
                                    // Cập nhật giao diện tiêu đề và trạng thái active
                                    document.getElementById("chat_head").innerText = name || "Khách hàng " + customerId;
                                    const sessionItems = document.querySelectorAll(".session-list div");
                                    sessionItems.forEach(item => item.classList.remove("active"));
                                    const selectedItem = Array.from(sessionItems).find(item => item.innerText === (name || "Khách hàng " + customerId));
                                    if (selectedItem)
                                        selectedItem.classList.add("active");
                                }

                                function fetchMessageHistory(sessionId) {
                                    fetch('/ShoesStoreWed/getMessageHistory?sessionId=' + sessionId)
                                            .then(response => response.json())
                                            .then(messages => {
                                                messages.forEach(msg => {
                                                    if (msg.senderId && msg.time && (msg.content || (msg.fileIds && msg.fileIds.length > 0))) {
                                                        queueMessage(msg.content, msg.fileIds || [], msg.senderId == userId ? "chat_msg_item_user" : "chat_msg_item_admin", msg.time);
                                                    }
                                                });
                                            });
                                }

                                function sendMessageAndFile() {
                                    const msg = document.getElementById("msg").value;
                                    const fileInput = document.getElementById("fileInput");
                                    const files = fileInput.files;

                                    if (!msg && files.length === 0)
                                        return;
                                    if (!selectedCustomerId) {
                                        alert("Vui lòng chọn một khách hàng để chat!");
                                        return;
                                    }

                                    if (files.length > 0) {
                                        const formData = new FormData();
                                        formData.append("userId", userId);
                                        formData.append("employeeId", selectedCustomerId);
                                        formData.append("messageContent", msg || "");
                                        for (let i = 0; i < files.length; i++)
                                            formData.append("files", files[i]);

                                        fetch('/ShoesStoreWed/uploadFile', {method: 'POST', body: formData})
                                                .then(response => response.json())
                                                .then(data => {
                                                    if (data.fileIds && Array.isArray(data.fileIds)) {
                                                        queueMessage(msg, data.fileIds, "chat_msg_item_user");
                                                        ws.send(selectedCustomerId + ":" + JSON.stringify({message: msg || "", fileIds: data.fileIds}));
                                                    } else if (data.error) {
                                                        queueMessage(data.error, [], "chat_msg_item_admin");
                                                    }
                                                })
                                                .catch(error => console.error('Error uploading files:', error));
                                        fileInput.value = "";
                                        document.getElementById("filePreview").innerHTML = "";
                                    } else {
                                        queueMessage(msg, [], "chat_msg_item_user");
                                        ws.send(selectedCustomerId + ":" + JSON.stringify({message: msg, fileIds: []}));
                                    }
                                    document.getElementById("msg").value = "";
                                }

                                // FAB toggle
                                $('#prime').click(function () {
                                    toggleFab();
                                    // Nếu danh sách session đã được tải, chọn phiên mới nhất ngay khi mở
                                    if (document.querySelector(".session-list").children.length > 0) {
                                        const latestSession = document.querySelector(".session-list div");
                                        if (latestSession && !selectedSessionId) {
                                            latestSession.click(); // Kích hoạt sự kiện click để chọn phiên mới nhất
                                        }
                                    }
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
        </script>
    </body>
</html>
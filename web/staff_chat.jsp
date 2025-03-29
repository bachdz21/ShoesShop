<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User" %>
<% 
    Integer userId = (Integer) session.getAttribute("userId");
    String role = (String) session.getAttribute("role");
    if (userId == null || (!"Employee".equals(role)&&!"Staff".equals(role))) {
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
        <!-- Thêm Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9FtM8jKkS6z/JXzP5rN8eT2S4GOhB9ANlR1yO7hX7+p8eKLi9Uzr7Nwdp91tT7BXnuJrs9NYV8Nzg8QvHA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
                            <div class="input-row">
                                <a id="fab_camera" class="fab"><i class="fa fa-camera"></i></a>
                                <input type="file" id="fileInput" accept="image/*,video/*" multiple style="display:none;"/>
                                <textarea id="msg" name="chat_message" placeholder="Send a message" class="chat_field chat_message"></textarea>
                                <a id="fab_send" class="fab" onclick="sendMessageAndFile()"><i class="fa fa-paper-plane"></i></a>
                            </div>
                            <div id="filePreview" class="file-preview-container"></div>
                        </div>
                    </div>
                </div>
            </div>
            <a id="prime" class="fab"><i class="prime fa fa-comment"></i></a>
        </div>

        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script>
                                    const userId = <%= userId %>;
                                    let selectedCustomerId = null;
                                    let selectedSessionId = null;
                                    let selectedFiles = [];
                                    const ws = new WebSocket("ws://" + window.location.host + "/ShoesStoreWed/chat?userId=" + userId);
                                    let messageQueue = [];
                                    let isProcessingQueue = false;

                                    ws.onmessage = function (event) {
                                        const chat = document.getElementById("chat");
                                        try {
                                            const data = JSON.parse(event.data);
                                            if (data.type === "SessionList") {
                                                updateSessionList(data); // Chỉ cập nhật danh sách phiên
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
                                            const {content, fileIds, className, time, profileImageURL} = messageQueue.shift();
                                            const chat = document.getElementById("chat");
                                            const span = document.createElement("span");
                                            span.className = "chat_msg_item " + className;

                                            let fullContent = "";
                                            if (content)
                                                fullContent += content;
                                            if (fileIds && fileIds.length > 0) {
                                                const fileContents = await Promise.all(fileIds.map(fileId => appendFile(fileId, className)));
                                                fileContents.forEach(fileContent => fullContent += (fullContent ? "<br/>" : "") + fileContent);
                                            }

                                            if (fullContent) {
                                                const avatarSrc = profileImageURL || "http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg";
                                                span.innerHTML = (className === "chat_msg_item_admin" ? "<div class='chat_avatar'><img src='" + avatarSrc + "'/></div>" : "") + fullContent + "<div class='status'>" + time + "</div>";
                                                chat.appendChild(span);
                                                chat.scrollTop = chat.scrollHeight;
                                            }
                                            await new Promise(resolve => setTimeout(resolve, 50));
                                        }
                                        isProcessingQueue = false;
                                    }

                                    function selectLatestSession(data) {
                                        const sessions = data.data.split(";");
                                        if (sessions.length > 0 && sessions[0]) {
                                            const [sessionId, customerId, name] = sessions[0].split(",");
                                            selectSession(sessionId, customerId, name);
                                        }
                                    }

                                    function updateSessionList(data) {
                                        const list = document.getElementById("sessionList");
                                        list.innerHTML = "";
                                        const sessions = data.data.split(";");
                                        sessions.forEach(s => {
                                            if (s) {
                                                const [sessionId, customerId, name] = s.split(",");
                                                const parsedSessionId = parseInt(sessionId);
                                                const div = document.createElement("div");
                                                div.innerText = name || "Khách hàng " + customerId;
                                                div.dataset.sessionId = parsedSessionId;
                                                div.dataset.customerId = customerId;
                                                div.onclick = () => selectSession(parsedSessionId, customerId, name);
                                                if (parsedSessionId === selectedSessionId) {
                                                    div.classList.add("active");
                                                }
                                                list.appendChild(div);
                                            }
                                        });
                                        console.log("Updated session list, selectedSessionId:", selectedSessionId);
                                    }

                                    function selectSession(sessionId, customerId, name) {
                                        if (selectedSessionId !== parseInt(sessionId)) {
                                            selectedCustomerId = parseInt(customerId);
                                            selectedSessionId = parseInt(sessionId);
                                            document.getElementById("chat").innerHTML = "";
                                            fetchMessageHistory(sessionId);
                                        }
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
                                        const textarea = document.getElementById("msg");
                                        const msg = textarea.value.trim();
                                        const fileInput = document.getElementById("fileInput");

                                        if (!msg && selectedFiles.length === 0)
                                            return;

                                        if (typeof selectedCustomerId !== "undefined" && !selectedCustomerId) {
                                            alert("Vui lòng chọn một khách hàng để chat!");
                                            return;
                                        }

                                        if (selectedFiles.length > 0) {
                                            const formData = new FormData();
                                            formData.append("userId", userId);
                                            formData.append("employeeId", selectedCustomerId);
                                            formData.append("messageContent", msg || "");
                                            selectedFiles.forEach(file => formData.append("files", file));

                                            fetch('/ShoesStoreWed/uploadFile', {method: 'POST', body: formData})
                                                    .then(response => response.json())
                                                    .then(data => {
                                                        if (data.fileIds && Array.isArray(data.fileIds)) {
                                                            queueMessage(msg, data.fileIds, "chat_msg_item_user");
                                                            ws.send(selectedCustomerId + ":" + JSON.stringify({message: msg || "", fileIds: data.fileIds}));
                                                        } else if (data.error) {
                                                            queueMessage(data.error, [], "chat_msg_item_admin");
                                                        }
                                                        // Reset sau khi gửi
                                                        selectedFiles = [];
                                                        textarea.value = "";
                                                        updateFilePreview();
                                                        fileInput.value = "";
                                                        adjustTextareaHeight(); // Reset chiều cao textarea sau khi gửi
                                                    })
                                                    .catch(error => console.error('Error uploading files:', error));
                                        } else {
                                            queueMessage(msg, [], "chat_msg_item_user");
                                            ws.send(selectedCustomerId + ":" + JSON.stringify({message: msg, fileIds: []}));
                                            textarea.value = "";
                                            adjustTextareaHeight(); // Reset chiều cao textarea sau khi gửi
                                        }
                                    }

                                    // FAB toggle
                                    $('#prime').click(function () {
                                        toggleFab();
                                        if (document.querySelector(".session-list").children.length > 0) {
                                            const latestSession = document.querySelector(".session-list div");
                                            if (latestSession && !selectedSessionId) {
                                                latestSession.click();
                                            }
                                        }
                                    });

                                    $('#fab_camera').click(function () {
                                        $('#fileInput').click();
                                    });

                                    function toggleFab() {
                                        const $prime = $('#prime');
                                        const $icon = $prime.find('i');

                                        if ($icon.hasClass('fa-comment')) {
                                            $icon.removeClass('fa-comment').addClass('fa-times');
                                        } else {
                                            $icon.removeClass('fa-times').addClass('fa-comment');
                                        }
                                        $prime.toggleClass('is-active is-float');
                                        $('.chat, .fab').toggleClass('is-visible');

                                        // Cập nhật kích thước khi hiển thị chat
                                        if ($('.chat').hasClass('is-visible')) {
                                            setTimeout(() => {
                                                setTextareaMaxHeight(); // Cập nhật max-height
                                                adjustTextareaHeight(); // Cập nhật height
                                                adjustChatBodyHeight(); // Cập nhật chat_body
                                            }, 0); // Chạy sau khi DOM render
                                        }
                                    }

                                    $('#fab_camera').click(function () {
                                        $('#fileInput').click();
                                    });

                                    // Hiển thị file đã chọn với nút xóa
                                    $('#fileInput').change(function () {
                                        const files = Array.from(this.files);
                                        const previewContainer = document.getElementById("filePreview");

                                        console.log("File input changed. Selected files: " + files);
                                        selectedFiles = selectedFiles.concat(files);
                                        console.log("Updated selectedFiles: " + selectedFiles);
                                        updateFilePreview();
                                    });

                                    function updateFilePreview() {
                                        const previewContainer = document.getElementById("filePreview");
                                        previewContainer.innerHTML = "";

                                        console.log("Updating file preview. selectedFiles length: " + selectedFiles.length);

                                        if (selectedFiles.length > 0) {
                                            previewContainer.style.display = "block";
                                            selectedFiles.forEach(function (file, index) {
                                                const previewItem = document.createElement("div");
                                                previewItem.className = "file-preview-item";
                                                previewItem.innerHTML =
                                                        "<span>" + file.name + "</span>" +
                                                        "<i class='remove-file fa fa-times' data-index='" + index + "'></i>";
                                                previewContainer.appendChild(previewItem);

                                                console.log("Added file to preview: " + file.name + ", index: " + index);
                                            });

                                            document.querySelectorAll(".remove-file").forEach(function (button) {
                                                button.addEventListener("click", function () {
                                                    const index = parseInt(this.getAttribute("data-index"));
                                                    selectedFiles.splice(index, 1);
                                                    console.log("Removed file at index " + index + ". New selectedFiles: " + selectedFiles);
                                                    updateFilePreview();
                                                    adjustChatBodyHeight(); // Cập nhật chiều cao chat_converse
                                                });
                                            });
                                        } else {
                                            previewContainer.style.display = "none";
                                        }
                                        adjustChatBodyHeight(); // Cập nhật chiều cao chat_converse sau khi preview thay đổi
                                    }

                                    // Tự động điều chỉnh chiều cao textarea và chat_converse
                                    const textarea = document.getElementById("msg");
                                    const chatBox = document.querySelector(".chat");
                                    const chatBody = document.querySelector(".chat_converse"); // Sử dụng chat_converse thay vì chat_body
                                    const fabField = document.querySelector(".fab_field");
                                    const chatHeader = document.querySelector(".chat_header");

                                    // Tính max-height là 40% chiều cao box chat
                                    function setTextareaMaxHeight() {
                                        const chatHeight = chatBox.offsetHeight;
                                        const maxHeight = chatHeight * 0.4; // 40% chiều cao box chat
                                        textarea.style.maxHeight = maxHeight + "px";
                                    }

                                    // Điều chỉnh chiều cao textarea dựa trên nội dung
                                    function adjustTextareaHeight() {
                                        textarea.style.height = "auto"; // Reset chiều cao để tính lại
                                        textarea.style.height = textarea.scrollHeight + "px"; // Đặt chiều cao theo nội dung
                                        adjustChatBodyHeight(); // Cập nhật chiều cao chat_converse
                                    }

                                    // Điều chỉnh chiều cao chat_converse dựa trên chiều cao fab_field
                                    function adjustChatBodyHeight() {
                                        const chatHeight = chatBox.offsetHeight;
                                        const headerHeight = chatHeader.offsetHeight;
                                        const fabHeight = fabField.offsetHeight; // Chiều cao của fab_field (bao gồm textarea và preview)
                                        const availableHeight = chatHeight - headerHeight - fabHeight;
                                        chatBody.style.height = availableHeight + "px";
                                    }

                                    // Gọi hàm setTextareaMaxHeight khi trang tải và khi cửa sổ thay đổi kích thước
                                    window.addEventListener("load", function () {
                                        setTextareaMaxHeight();
                                        adjustTextareaHeight();
                                        adjustChatBodyHeight();
                                    });
                                    window.addEventListener("resize", function () {
                                        setTextareaMaxHeight();
                                        adjustTextareaHeight();
                                        adjustChatBodyHeight();
                                    });

                                    // Gọi adjustTextareaHeight khi người dùng nhập
                                    textarea.addEventListener("input", adjustTextareaHeight);

                                    // Gọi adjustTextareaHeight ban đầu để đảm bảo chiều cao đúng
                                    adjustTextareaHeight();
        </script>
    </body>
</html>
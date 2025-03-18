$(document).ready(function() {
    // Ban đầu ẩn chat
    $('#chat-box .chat').removeClass('is-visible');
    $('#chat-box .fab').removeClass('is-visible');
    $('#chat-box #prime').removeClass('is-float');
    $('#chat-box .prime').removeClass('is-active');
    $('#chat-box .prime').removeClass('is-visible');

    // Đặt người dùng mặc định (Jane Doe) là active (nếu có chat_list - Employee)
    var $defaultUser = $('#chat-box .chat_list_item[data-user="jane_doe"]');
    if ($defaultUser.length) {
        $defaultUser.addClass('active');
    }

    // Tự động tải nội dung cho người dùng mặc định khi popup mở lần đầu
    function loadDefaultChat() {
        var user, userName, userStatus, avatarUrl;

        if ($defaultUser.length) { // Employee: Có chat_list
            user = $defaultUser.data('user');
            userName = $defaultUser.find('.chat_list_name').text();
            userStatus = $defaultUser.find('.chat_list_status').text();
            avatarUrl = $defaultUser.find('.chat_list_avatar img').attr('src');
        } else { // Customer: Không có chat_list, sử dụng giá trị mặc định
            user = 'jane_doe';
            userName = 'Jane Doe';
            userStatus = 'Agent (Online)';
            avatarUrl = 'http://res.cloudinary.com/dqvwa7vpe/image/upload/v1496415051/avatar_ma6vug.jpg';
        }

        $('#chat-box #chat_head').text(userName);
        $('#chat-box .agent').text(userStatus.includes('Agent') ? 'Agent' : '');
        $('#chat-box .online').text(userStatus.includes('Online') ? '(Online)' : '(Offline)');
        $('#chat-box .chat_header .header_img img').attr('src', avatarUrl);

        $('#chat-box #chat_converse').empty();

        if (user === 'jane_doe') {
            $('#chat-box #chat_converse').append(`
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hey there! Any question?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Hello!</span>
                <span class="status">20m ago</span>
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hey! Would you like to talk sales, support, or anyone?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry.</span>
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</span>
                <span class="status2">Just now. Not seen yet</span>
            `);
        } else if (user === 'john_doe') {
            $('#chat-box #chat_converse').append(`
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hi! How can I assist you today?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Hey, I have a question about pricing.</span>
                <span class="status">10m ago</span>
            `);
        }

        $('#chat-box #chat_converse').scrollTop($('#chat-box #chat_converse')[0].scrollHeight);
    }

    // Gọi hàm loadDefaultChat khi popup mở lần đầu
    $('#chat-box #prime').click(function() {
        toggleFab();
        if ($('#chat-box .chat').hasClass('is-visible') && !$defaultUser.data('content-loaded')) {
            loadDefaultChat();
            $defaultUser.data('content-loaded', true); // Đánh dấu đã tải nội dung
        }
    });

    // Khi nhấp vào một người trong danh sách (chỉ áp dụng cho Employee)
    $('#chat-box .chat_list_item').click(function() {
        $('#chat-box .chat_list_item').removeClass('active');
        $(this).addClass('active');

        var user = $(this).data('user');
        var userName = $(this).find('.chat_list_name').text();
        var userStatus = $(this).find('.chat_list_status').text();
        var avatarUrl = $(this).find('.chat_list_avatar img').attr('src');

        $('#chat-box #chat_head').text(userName);
        $('#chat-box .agent').text(userStatus.includes('Agent') ? 'Agent' : '');
        $('#chat-box .online').text(userStatus.includes('Online') ? '(Online)' : '(Offline)');
        $('#chat-box .chat_header .header_img img').attr('src', avatarUrl);

        $('#chat-box #chat_converse').empty();

        if (user === 'jane_doe') {
            $('#chat-box #chat_converse').append(`
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hey there! Any question?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Hello!</span>
                <span class="status">20m ago</span>
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hey! Would you like to talk sales, support, or anyone?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Lorem Ipsum is simply dummy text of the printing and typesetting industry.</span>
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</span>
                <span class="status2">Just now. Not seen yet</span>
            `);
        } else if (user === 'john_doe') {
            $('#chat-box #chat_converse').append(`
                <span class="chat_msg_item chat_msg_item_admin">
                    <div class="chat_avatar">
                        <img src="${avatarUrl}"/>
                    </div>Hi! How can I assist you today?</span>
                <span class="chat_msg_item chat_msg_item_user">
                    Hey, I have a question about pricing.</span>
                <span class="status">10m ago</span>
            `);
        }

        $('#chat-box #chat_converse').scrollTop($('#chat-box #chat_converse')[0].scrollHeight);
    });

    // Xử lý gửi tin nhắn khi click vào #fab_send
    $('#chat-box #fab_send').click(function(e) {
        var message = $('#chat-box #chatSend').val();
        if (message.trim() !== "") {
            $('#chat-box #chat_converse').append('<span class="chat_msg_item chat_msg_item_user">' + message + '</span>');
            $('#chat-box #chatSend').val(''); // Xóa nội dung sau khi gửi
            $('#chat-box #chat_converse').scrollTop($('#chat-box #chat_converse')[0].scrollHeight); // Cuộn xuống dưới cùng
        }
    });

    // Xử lý thêm ảnh khi click vào #fab_image (mở hộp thoại tải file)
    $('#chat-box #fab_image').click(function(e) {
        var input = $('<input type="file" accept="image/*" />');
        input.trigger('click');
        input.on('change', function() {
            var file = this.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = $('<span class="chat_msg_item chat_msg_item_user"><img src="' + e.target.result + '" style="max-width: 200px;"/></span>');
                    $('#chat-box #chat_converse').append(img);
                    $('#chat-box #chat_converse').scrollTop($('#chat-box #chat_converse')[0].scrollHeight);
                };
                reader.readAsDataURL(file);
            }
        });
    });
    
    $('#chat-box #fab_send').click(function(e) {
        var message = $('#chat-box #chatSend').val();
        if (message.trim() !== "") {
            var receiverId = user.role === 'Customer' ? 1 : $('.chat_list_item.active').data('user'); // 1 là ID mặc định của Employee
            var conversationId = user.role === 'Customer' ? 0 : $('.chat_list_item.active').data('conversation');
            sendMessage(conversationId, receiverId, message);
            $('#chat-box #chatSend').val('');
        }
    });

    // Xử lý chọn người dùng trong danh sách (Employee)
    $('#chat-box').on('click', '.chat_list_item', function() {
        $('#chat-box .chat_list_item').removeClass('active');
        $(this).addClass('active');
        var userId = $(this).data('user');
        var conversationId = $(this).data('conversation');
        loadConversation(conversationId);
    });

    function loadConversation(conversationId) {
        $.get('/ShoesStoreWed/getMessages?conversationId=' + conversationId, function(messages) {
            $('#chat-box #chat_converse').empty();
            messages.forEach(function(msg) {
                displayMessage(msg);
            });
        });
    }
});

// Hàm toggleFab để hiển thị/ẩn chat
function toggleFab() {
    var $primeIcon = $('#chat-box .prime');
    if ($('#chat-box .chat').hasClass('is-visible')) {
        $primeIcon.removeClass('fa-times').addClass('fa-comment'); // Chuyển thành bong bóng khi đóng
    } else {
        $primeIcon.removeClass('fa-comment').addClass('fa-times'); // Chuyển thành close khi mở
    }
    $('#chat-box .prime').toggleClass('is-active');
    $('#chat-box .prime').toggleClass('is-visible');
    $('#chat-box #prime').toggleClass('is-float');
    $('#chat-box .chat').toggleClass('is-visible');
    $('#chat-box .fab').toggleClass('is-visible');

    // Đảm bảo chat_list hiển thị khi chat mở (chỉ áp dụng cho Employee)
    if ($('#chat-box .chat').hasClass('is-visible')) {
        $('#chat-box .chat_list').css({
            'opacity': '1',
            'visibility': 'visible',
            'height': 'auto',
            'display': 'block'
        });
        $('#chat-box .chat_list_item').css({
            'opacity': '1',
            'visibility': 'visible',
            'display': 'flex'
        });
    } else {
        $('#chat-box .chat_list').css({
            'opacity': '0',
            'visibility': 'hidden',
            'height': '0'
        });
        $('#chat-box .chat_list_item').css({
            'opacity': '0',
            'visibility': 'hidden'
        });
    }
}
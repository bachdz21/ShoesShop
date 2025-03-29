package websocket;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;
import model.Message;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.imp.ChatDAO;

@ServerEndpoint("/chat")
public class WebSocket {

    private static Map<Integer, Session> userSessions = new ConcurrentHashMap<>();
    private ChatDAO chatDAO;
    private Gson gson;

    public WebSocket() {
        chatDAO = new ChatDAO();
        gson = new Gson();
    }

    @OnOpen
    public void onOpen(Session session) {
        String userId = session.getQueryString().split("=")[1];
        int userIdInt = Integer.parseInt(userId);
        userSessions.put(userIdInt, session);

        try {
            String role = chatDAO.getUserRole(userIdInt);
            if ("Staff".equals(role)) {
                updateSessionList(userIdInt);
            } else if ("Customer".equals(role)) {
                int staffId = 19;
                int sessionId = chatDAO.getOrCreateChatSession(userIdInt, staffId);

                List<Message> messages = chatDAO.getMessageHistory(sessionId);
                StringBuilder jsonResponse = new StringBuilder("{\"type\":\"history\",\"data\":[");
                if (messages != null && !messages.isEmpty()) {
                    // Sửa định dạng thời gian từ HH:mm:ss thành HH:mm
                    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                    for (int i = 0; i < messages.size(); i++) {
                        Message msg = messages.get(i);
                        String formattedTime = (msg.getSentTime() != null) ? sdf.format(msg.getSentTime()) : "No time";
                        List<Integer> fileIds = chatDAO.getFileIdsByMessageId(msg.getMessageId());
                        jsonResponse.append("{\"senderId\":").append(msg.getSenderId())
                                .append(",\"content\":\"").append(msg.getMessageContent().replace("\"", "\\\""))
                                .append("\",\"fileIds\":[").append(fileIds.stream().map(String::valueOf).collect(Collectors.joining(",")))
                                .append("],\"time\":\"").append(formattedTime).append("\"}");
                        if (i < messages.size() - 1) {
                            jsonResponse.append(",");
                        }
                    }
                }
                jsonResponse.append("]}");
                session.getAsyncRemote().sendText(jsonResponse.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.getAsyncRemote().sendText("{\"type\":\"error\",\"message\":\"Error fetching history\"}");
        }
    }

    @OnClose
    public void onClose(Session session) {
        Integer userId = getUserIdFromSession(session);
        userSessions.remove(userId);
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            if (message.equals("logout")) {
                Integer userId = getUserIdFromSession(session);
                userSessions.remove(userId);
                session.close();
                return;
            }

            Integer senderId = getUserIdFromSession(session);
            String[] parts = message.split(":", 2);
            Integer receiverId = Integer.parseInt(parts[0]);

            // Parse JSON thủ công
            JsonObject jsonObject = JsonParser.parseString(parts[1]).getAsJsonObject();
            String messageContent = jsonObject.has("message") ? jsonObject.get("message").getAsString() : null;

            List<Integer> fileIds = new ArrayList<>();
            if (jsonObject.has("fileIds")) {
                jsonObject.get("fileIds").getAsJsonArray().forEach(element -> fileIds.add(element.getAsInt()));
            } else if (jsonObject.has("fileId") && !jsonObject.get("fileId").isJsonNull()) {
                fileIds.add(jsonObject.get("fileId").getAsInt());
            }

            String senderRole = chatDAO.getUserRole(senderId);
            String receiverRole = chatDAO.getUserRole(receiverId);
            if (!isValidChat(senderRole, receiverRole)) {
                session.getAsyncRemote().sendText("{\"type\":\"error\",\"message\":\"Invalid chat roles.\"}");
                return;
            }

            int customerId = "Customer".equals(senderRole) ? senderId : receiverId;
            int staffId = "Staff".equals(senderRole) ? senderId : receiverId;
            int sessionId = chatDAO.getOrCreateChatSession(customerId, staffId);

            // Chỉ lưu tin nhắn nếu không có file (trường hợp gửi text không qua uploadFile)
            if (fileIds.isEmpty()) {
                chatDAO.saveMessage(senderId, receiverId, messageContent != null ? messageContent : "", sessionId);
            }

            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("type", "message");
            responseMap.put("sessionId", sessionId);
            responseMap.put("senderId", senderId);
            responseMap.put("content", messageContent);
            responseMap.put("fileIds", fileIds.isEmpty() ? null : fileIds);
            String jsonResponse = gson.toJson(responseMap);

            Session receiverSession = userSessions.get(receiverId);
            if (receiverSession != null && receiverSession.isOpen()) {
                receiverSession.getAsyncRemote().sendText(jsonResponse);
            }
            session.getAsyncRemote().sendText(jsonResponse);

            updateSessionList(customerId);

        } catch (Exception e) {
            e.printStackTrace();
            session.getAsyncRemote().sendText("{\"type\":\"error\",\"message\":\"Error processing message: " + e.getMessage() + "\"}");
        }
    }

    private Integer getUserIdFromSession(Session session) {
        String userId = session.getQueryString().split("=")[1];
        return Integer.parseInt(userId);
    }

    private boolean isValidChat(String senderRole, String receiverRole) {
        return ("Customer".equals(senderRole) && "Staff".equals(receiverRole))
                || ("Staff".equals(senderRole) && "Customer".equals(receiverRole));
    }

    private void updateSessionList(int staffId) throws SQLException {
        List<String> sessions = chatDAO.getChatSessions();
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("type", "SessionList");
        responseMap.put("data", String.join(";", sessions));
        String json = gson.toJson(responseMap);

        for (Map.Entry<Integer, Session> entry : userSessions.entrySet()) {
            if ("Staff".equals(chatDAO.getUserRole(entry.getKey())) && entry.getValue().isOpen()) {
                entry.getValue().getAsyncRemote().sendText(json);
            }
        }
    }
}

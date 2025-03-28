package dal.imp;

import dal.DBConnect;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import model.Message;
import model.User;

public class ChatDAO extends DBConnect {

    public String getUserRole(int userId) throws SQLException {
        String sql = "SELECT Role FROM Users WHERE UserId = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Role");
            }
        }
        return null;
    }

    public int getOrCreateChatSession(int customerId, int staffId) throws SQLException {
        String selectSql = "SELECT SessionId FROM ChatSessions WHERE CustomerId = ? AND StaffId = ?";
        try (PreparedStatement stmt = c.prepareStatement(selectSql)) {
            stmt.setInt(1, customerId);
            stmt.setInt(2, staffId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("SessionId");
            } else {
                String insertSql = "INSERT INTO ChatSessions (CustomerId, StaffId) VALUES (?, ?); "
                        + "SELECT SCOPE_IDENTITY() AS SessionId;";
                try (PreparedStatement insertStmt = c.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, customerId);
                    insertStmt.setInt(2, staffId);
                    ResultSet rsInsert = insertStmt.executeQuery();
                    if (rsInsert.next()) {
                        return rsInsert.getInt("SessionId");
                    }
                }
            }
        }
        return -1;
    }

    public void saveMessage(int senderId, int receiverId, String messageContent, int sessionId) throws SQLException {
        String sql = "INSERT INTO Messages (SenderId, ReceiverId, MessageContent, SessionId) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setString(3, messageContent);
            stmt.setInt(4, sessionId);
            stmt.executeUpdate();
        }
    }

    public List<String> getChatSessions() throws SQLException {
        List<String> sessionList = new ArrayList<>();
        String sql = "SELECT cs.SessionId, u.UserId, COALESCE(u.FullName, 'Khách hàng không tên') AS FullName, "
                + "(SELECT MAX(SentTime) FROM Messages m WHERE m.SessionId = cs.SessionId) AS LastMessageTime "
                + "FROM ChatSessions cs "
                + "JOIN Users u ON cs.CustomerId = u.UserId "
                + "ORDER BY LastMessageTime DESC";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String sessionData = rs.getInt("SessionId") + ","
                        + rs.getInt("UserId") + ","
                        + rs.getString("FullName");
                sessionList.add(sessionData);
            }
        }
        return sessionList;
    }

    public List<Message> getMessageHistory(int sessionId) throws SQLException {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT MessageId, SenderId, ReceiverId, MessageContent, SentTime, IsRead, SessionId "
                + "FROM Messages WHERE SessionId = ? ORDER BY SentTime ASC";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, sessionId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int messageId = rs.getInt("MessageId");
                int senderId = rs.getInt("SenderId");
                int receiverId = rs.getInt("ReceiverId");
                String messageContent = rs.getString("MessageContent");
                Timestamp sentTime = rs.getTimestamp("SentTime");
                Boolean isRead = rs.getBoolean("IsRead");
                int sessionIdFromDb = rs.getInt("SessionId");

                Message message = new Message(messageId, senderId, receiverId, messageContent, sentTime, isRead, sessionIdFromDb);
                messages.add(message);
            }
        }
        return messages;
    }

    public int saveFile(int sessionId, int senderId, String fileName, String filePath, int messageId) throws SQLException {
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif", ".mp4", ".mov"};
        boolean isValid = false;
        for (String ext : allowedExtensions) {
            if (fileName.toLowerCase().endsWith(ext)) {
                isValid = true;
                break;
            }
        }
        if (!isValid) {
            throw new SQLException("Chỉ được gửi file ảnh (.jpg, .png, .gif) hoặc video (.mp4, .mov)!");
        }

        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String insertSql = "INSERT INTO Files (SessionId, SenderId, FileName, FilePath, MessageId) VALUES (?, ?, ?, ?, ?)";
            stmt = c.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, sessionId);
            stmt.setInt(2, senderId);
            stmt.setString(3, fileName);
            stmt.setString(4, filePath);
            stmt.setInt(5, messageId);
            stmt.executeUpdate();

            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return -1;
    }

    public String getFilePathById(int fileId) throws SQLException {
        String sql = "SELECT FilePath FROM Files WHERE FileId = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, fileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("FilePath");
            }
        }
        return null;
    }

    public String getFileNameById(int fileId) throws SQLException {
        String sql = "SELECT FileName FROM Files WHERE FileId = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, fileId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("FileName");
            }
        }
        return null;
    }

    public List<Integer> getFileIdsByMessageId(int messageId) throws SQLException {
        List<Integer> fileIds = new ArrayList<>();
        String sql = "SELECT FileId FROM Files WHERE MessageId = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, messageId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                fileIds.add(rs.getInt("FileId"));
            }
        }
        return fileIds;
    }

    public int getLatestMessageId(int sessionId, int senderId, String messageContent) throws SQLException {
        String sql = "SELECT TOP 1 MessageId FROM Messages WHERE SessionId = ? AND SenderId = ? AND MessageContent = ? ORDER BY SentTime DESC";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setInt(1, sessionId);
            stmt.setInt(2, senderId);
            stmt.setString(3, messageContent);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("MessageId");
            }
        }
        return -1;
    }

    public void updateMessageContent(int messageId, String newContent) throws SQLException {
        String sql = "UPDATE Messages SET MessageContent = ? WHERE MessageId = ?";
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            stmt.setString(1, newContent);
            stmt.setInt(2, messageId);
            stmt.executeUpdate();
        }
    }

}

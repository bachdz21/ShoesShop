package controller;

import com.google.gson.Gson;
import dal.imp.ChatDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;
import model.Message;

@WebServlet(name = "ChatController", urlPatterns = {"/getMessageHistory", "/downloadFile", "/getFileInfo", "/uploadFile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ChatController extends HttpServlet {

    ChatDAO chatDAO = new ChatDAO();
    String UPLOAD_DIR = "D:\\Materials\\Kì 4 - Fall24\\ChatApp\\web\\img";
    Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/getMessageHistory")) {
            getMessageHistory(request, response);
        } else if (request.getServletPath().equals("/uploadFile")) {
            uploadFile(request, response);
        } else if (request.getServletPath().equals("/getFileInfo")) {
            getFileInfo(request, response);
        } else if (request.getServletPath().equals("/downloadFile")) {
            downloadFile(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void getMessageHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int sessionId = Integer.parseInt(request.getParameter("sessionId"));
            List<Message> messages = chatDAO.getMessageHistory(sessionId);
            response.setContentType("application/json");
            StringBuilder jsonResponse = new StringBuilder("[");
            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm"); // Chỉ định dạng giờ và phút
            for (int i = 0; i < messages.size(); i++) {
                Message msg = messages.get(i);
                String formattedTime = (msg.getSentTime() != null) ? sdf.format(msg.getSentTime()) : "No time";
                List<Integer> fileIds = chatDAO.getFileIdsByMessageId(msg.getMessageId()); // Lấy danh sách fileIds
                jsonResponse.append("{\"senderId\":").append(msg.getSenderId())
                        .append(",\"content\":\"").append(msg.getMessageContent() != null ? msg.getMessageContent().replace("\"", "\\\"") : "")
                        .append("\",\"fileIds\":[").append(fileIds.stream().map(String::valueOf).collect(Collectors.joining(",")))
                        .append("],\"time\":\"").append(formattedTime).append("\"}");
                if (i < messages.size() - 1) {
                    jsonResponse.append(",");
                }
            }
            jsonResponse.append("]");
            response.getWriter().write(jsonResponse.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu");
        }
    }

    protected void uploadFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String messageContent = request.getParameter("messageContent");
        List<Part> fileParts = request.getParts().stream()
                .filter(part -> "files".equals(part.getName()) && part.getSize() > 0)
                .collect(Collectors.toList());

        // Kiểm tra định dạng file
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif", ".mp4", ".mov"};
        for (Part filePart : fileParts) {
            String originalFileName = getFileExtension(filePart);
            boolean isValid = false;
            for (String ext : allowedExtensions) {
                if (originalFileName.toLowerCase().endsWith(ext)) {
                    isValid = true;
                    break;
                }
            }
            if (!isValid) {
                response.setContentType("application/json");
                response.getWriter().write("{\"error\":\"Chỉ được gửi file ảnh (.jpg, .png, .gif) hoặc video (.mp4, .mov)!\"}");
                return;
            }
        }

        try {
            int sessionId = chatDAO.getOrCreateChatSession(
                    "Customer".equals(chatDAO.getUserRole(userId)) ? userId : staffId,
                    "Staff".equals(chatDAO.getUserRole(userId)) ? userId : staffId
            );

            // Lưu tin nhắn một lần duy nhất
            chatDAO.saveMessage(userId, staffId, messageContent != null ? messageContent : "", sessionId);
            int messageId = chatDAO.getLatestMessageId(sessionId, userId, messageContent != null ? messageContent : "");

            List<Integer> fileIds = new ArrayList<>();
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            for (Part filePart : fileParts) {
                String originalFileName = getFileExtension(filePart);
                String fileName = UUID.randomUUID().toString() + originalFileName;
                File mediaFile = new File(UPLOAD_DIR, fileName);
                filePart.write(mediaFile.getAbsolutePath());
                String filePath = "img/" + fileName;
                int fileId = chatDAO.saveFile(sessionId, userId, fileName, filePath, messageId);
                fileIds.add(fileId);
            }

            // Gửi thông tin qua WebSocket từ đây
            Map<String, Object> responseMap = new HashMap<>();
            responseMap.put("type", "message");
            responseMap.put("sessionId", sessionId);
            responseMap.put("senderId", userId);
            responseMap.put("content", messageContent);
            responseMap.put("fileIds", fileIds.isEmpty() ? null : fileIds);
            String jsonResponse = gson.toJson(responseMap);

            // Trả về phản hồi cho client
            response.setContentType("application/json");
            response.getWriter().write("{\"fileIds\":[" + fileIds.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]}");

            // Gửi qua WebSocket cho receiver (sẽ xử lý trong ChatServlet nếu cần)
        } catch (Exception e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private String getFileExtension(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=\"") + 10, contentDisposition.lastIndexOf("\""));
        return fileName.substring(fileName.lastIndexOf("."));
    }

    protected void getFileInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fileIdStr = request.getParameter("fileId");
        if (fileIdStr == null || fileIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing fileId parameter");
            return;
        }

        int fileId;
        try {
            fileId = Integer.parseInt(fileIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid fileId format: " + fileIdStr);
            return;
        }

        try {
            String fileName = chatDAO.getFileNameById(fileId);
            if (fileName == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found for fileId: " + fileId);
                return;
            }

            response.setContentType("application/json");
            response.getWriter().write("{\"fileName\":\"" + fileName + "\"}");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    protected void downloadFile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fileIdStr = request.getParameter("fileId");
        if (fileIdStr == null || fileIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing fileId parameter");
            return;
        }

        int fileId;
        try {
            fileId = Integer.parseInt(fileIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid fileId format: " + fileIdStr);
            return;
        }

        try {
            String filePath = chatDAO.getFilePathById(fileId);
            if (filePath == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found for fileId: " + fileId);
                return;
            }

            File file = new File("D:\\Materials\\Kì 4 - Fall24\\ChatApp\\web\\" + filePath);
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File does not exist on server: " + filePath);
                return;
            }

            response.setContentType(getServletContext().getMimeType(file.getName()));
            response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");

            try (FileInputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error reading file: " + e.getMessage());
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/getMessageHistory")) {
            getMessageHistory(request, response);
        } else if (request.getServletPath().equals("/uploadFile")) {
            uploadFile(request, response);
        } else if (request.getServletPath().equals("/getFileInfo")) {
            getFileInfo(request, response);
        } else if (request.getServletPath().equals("/downloadFile")) {
            downloadFile(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

}
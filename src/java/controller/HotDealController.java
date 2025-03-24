package controller;

import dal.imp.HotDealDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.UUID;
import model.HotDealSettings;

@WebServlet(name = "HotDealController", urlPatterns = {"/saveHotDeal", "/resetHotDeal", "/getHotDeal"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class HotDealController extends HttpServlet {

    private final HotDealDAO hotDealDAO = new HotDealDAO();
    private static final String IMAGE_UPLOAD_DIR = "D:\\Materials\\Kì 5 - Spring25\\SWP291\\ShoesShop\\web\\img"; // Đường dẫn tuyệt đối đến thư mục img

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/saveHotDeal":
                saveHotDeal(request, response);
                break;
            case "/resetHotDeal":
                resetHotDeal(request, response);
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/getHotDeal".equals(path)) {
            getHotDeal(request, response);
        }
    }

    private void saveHotDeal(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String endTimeStr = request.getParameter("endTime");
    String title = request.getParameter("title");
    String subtitle = request.getParameter("subtitle");
    Part filePart = request.getPart("hot-deal-image");

    HotDealSettings settings = new HotDealSettings();
    String imageURL = null;

    try {
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
            File imageFile = new File(IMAGE_UPLOAD_DIR, fileName);
            filePart.write(imageFile.getAbsolutePath());
            imageURL = "./img/" + fileName;
            // Debug
        } else {
        }

        if (endTimeStr != null && !endTimeStr.isEmpty()) {
            String formattedEndTime = endTimeStr.replace("T", " ") + ":00";
            settings.setEndTime(Timestamp.valueOf(formattedEndTime));
        } else {
            settings.setEndTime(null);
        }

        settings.setTitle(title != null && !title.isEmpty() ? title : null);
        settings.setSubtitle(subtitle != null && !subtitle.isEmpty() ? subtitle : null);
        settings.setImageURL(imageURL);

        hotDealDAO.saveHotDealSettings(settings);
        response.getWriter().write("Settings saved successfully");
    } catch (Exception e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error: " + e.getMessage());
        e.printStackTrace();
    }
}

    private void resetHotDeal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            hotDealDAO.resetHotDealSettings();
            response.getWriter().write("Settings reset successfully");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void getHotDeal(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        HotDealSettings settings = hotDealDAO.getHotDealSettings();
        response.setContentType("application/json");
        if (settings != null) {
            String json = String.format("{\"endTime\": %s, \"title\": %s, \"subtitle\": %s, \"imageURL\": %s}",
                    settings.getEndTime() != null ? "\"" + settings.getEndTime() + "\"" : "null",
                    settings.getTitle() != null ? "\"" + settings.getTitle() + "\"" : "null",
                    settings.getSubtitle() != null ? "\"" + settings.getSubtitle() + "\"" : "null",
                    settings.getImageURL() != null ? "\"" + settings.getImageURL() + "\"" : "null");
            // Debug
            response.getWriter().write(json);
        } else {
            String json = "{\"endTime\": null, \"title\": null, \"subtitle\": null, \"imageURL\": null}";
            response.getWriter().write(json);
        }
    } catch (SQLException e) {
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        e.printStackTrace();
    }
}

    // Phương thức giúp lấy phần mở rộng của file từ Part
    private String getFileExtension(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=\"") + 10, contentDisposition.lastIndexOf("\""));
        return fileName.substring(fileName.lastIndexOf("."));
    }
}
package controller;

import com.google.gson.Gson;
import dal.imp.ReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import java.util.UUID;
import model.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;
import model.Review;

@WebServlet(name = "ReviewController", urlPatterns = {"/addReview", "/deleteReview", "/replyReview"})
@MultipartConfig
public class ReviewController extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();
    private static final String IMAGE_UPLOAD_DIR = "D:\\Materials\\Kì 5 - Spring25\\SWP291\\ShoesShop\\web\\img"; // Đường dẫn thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/addReview")) {
            addReview(request, response);
        } else if (path.equals("/deleteReview")) {
            deleteReview(request, response);
        } else if (path.equals("/replyReview")) {
            replyReview(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void addReview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy thông tin từ form
            int userId = user.getUserId();
            int productId = Integer.parseInt(request.getParameter("productID"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("review");
            String orderId = request.getParameter("orderId");

            // Kiểm tra xem user đã review sản phẩm này chưa
            Review existingReview = reviewDAO.getReviewByUserAndProduct(userId, productId);
            if (existingReview != null) {
                // Nếu đã có review, cập nhật review thay vì thêm mới
                existingReview.setRating(rating);
                existingReview.setComment(comment);
                reviewDAO.updateReview(existingReview);

                // Xử lý cập nhật media nếu có
                String mediaTypeString = request.getParameter("mediaType");
                List<String> mediaTypes = new ArrayList<>();
                if (mediaTypeString != null && !mediaTypeString.isEmpty()) {
                    mediaTypes = new Gson().fromJson(mediaTypeString, List.class);
                }

                Collection<Part> fileParts = request.getParts();
                int mediaIndex = 0;
                for (Part filePart : fileParts) {
                    if (filePart.getName().equals("media") && filePart.getSize() > 0) {
                        String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
                        File mediaFile = new File(IMAGE_UPLOAD_DIR, fileName);
                        filePart.write(mediaFile.getAbsolutePath());
                        String mediaUrl = "img/" + fileName;
                        String mediaType = mediaTypes.size() > mediaIndex ? mediaTypes.get(mediaIndex) : "other";
                        reviewDAO.updateReviewMedia(existingReview.getReviewId(), mediaUrl, mediaType); // Cập nhật media
                        mediaIndex++;
                    }
                }

                response.sendRedirect("orderDetail?orderId=" + orderId + "&message=Review+updated+successfully");
            } else {
                // Nếu chưa có review, thêm mới như cũ
                Review review = new Review(productId, userId, rating, comment);
                int reviewId = reviewDAO.addReview(review);

                if (reviewId > 0) {
                    String mediaTypeString = request.getParameter("mediaType");
                    List<String> mediaTypes = new ArrayList<>();
                    if (mediaTypeString != null && !mediaTypeString.isEmpty()) {
                        mediaTypes = new Gson().fromJson(mediaTypeString, List.class);
                    }

                    Collection<Part> fileParts = request.getParts();
                    int mediaIndex = 0;
                    for (Part filePart : fileParts) {
                        if (filePart.getName().equals("media") && filePart.getSize() > 0) {
                            String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
                            File mediaFile = new File(IMAGE_UPLOAD_DIR, fileName);
                            filePart.write(mediaFile.getAbsolutePath());
                            String mediaUrl = "img/" + fileName;
                            String mediaType = mediaTypes.size() > mediaIndex ? mediaTypes.get(mediaIndex) : "other";
                            reviewDAO.addReviewMedia(reviewId, mediaUrl, mediaType);
                            mediaIndex++;
                        }
                    }

                    response.sendRedirect("orderDetail?orderId=" + orderId + "&message=Review+added+successfully");
                }
            }
        } catch (Exception e) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Đã xảy ra lỗi: " + e.getMessage() + "');");
            out.println("window.location='orderDetail?orderId=" + request.getParameter("orderId") + "';");
            out.println("</script>");
        }
    }

// Phương thức giúp lấy phần mở rộng của file từ Part
    private String getFileExtension(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=\"") + 10, contentDisposition.lastIndexOf("\""));
        return fileName.substring(fileName.lastIndexOf("."));
    }

    protected void deleteReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (user == null || !"Staff".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("Unauthorized");
            return;
        }

        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            reviewDAO.deleteReview(reviewId);
            out.print("Success");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error: " + e.getMessage());
        }
    }

    // Phương thức trả lời review
    protected void replyReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        if (user == null || !"Staff".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("Unauthorized");
            return;
        }

        try {
            String reviewIdStr = request.getParameter("reviewId");
            String productIdStr = request.getParameter("productId");
            String replyText = request.getParameter("replyText");
            if (reviewIdStr == null || productIdStr == null || replyText == null || replyText.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("Error: Missing or invalid parameters");
                return;
            }

            int reviewId = Integer.parseInt(reviewIdStr);
            int productId = Integer.parseInt(productIdStr);
            String replyDate = reviewDAO.addReviewReply(reviewId, 0, replyText);
            out.print("Success|" + replyDate);
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("Error: Invalid reviewId or productId format");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/addReview")) {
            addReview(request, response);
        } else if (path.equals("/deleteReview")) {
            deleteReview(request, response);
        } else if (path.equals("/replyReview")) {
            replyReview(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

}

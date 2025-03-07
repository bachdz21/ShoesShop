package controller;

import com.google.gson.Gson;
import dal.ICategoryDAO;
import dal.IProductDAO;
import dal.IUserDAO;
import dal.imp.CategoryDAO;
import dal.imp.ProductDAO;
import dal.imp.ReviewDAO;
import dal.imp.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.UUID;
import model.Product;
import model.User;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import model.Review;

@WebServlet(name = "ReviewController", urlPatterns = {"/addReview"})
@MultipartConfig
public class ReviewController extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();
    private static final String IMAGE_UPLOAD_DIR = "D:\\Materials\\Kì 5 - Spring25\\SWP291\\ShoesShop\\web\\img"; // Đường dẫn thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/addReview")) {
            addReview(request, response);
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

        // Lấy thông tin từ form
        int userId = user.getUserId();
        int productId = Integer.parseInt(request.getParameter("productID"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("review");

        // Tạo đối tượng Review
        Review review = new Review(productId, userId, rating, comment);

        // Gọi phương thức addReview để thêm vào database
        int reviewId = reviewDAO.addReview(review);

        if (reviewId > 0) {
            // Lấy mảng loại file từ request (giải mã JSON)
            String mediaTypeString = request.getParameter("mediaType");
            List<String> mediaTypes = new ArrayList<>();

            if (mediaTypeString != null && !mediaTypeString.isEmpty()) {
                mediaTypes = new Gson().fromJson(mediaTypeString, List.class);
            }

            // Đường dẫn thư mục lưu trữ file media

            // Xử lý các phần media (hình ảnh hoặc video)
            Collection<Part> fileParts = request.getParts();
            List<String> mediaUrls = new ArrayList<>();

            int mediaIndex = 0;  // Chỉ số dùng để duyệt qua các loại media
            for (Part filePart : fileParts) {
                if (filePart.getName().equals("media") && filePart.getSize() > 0) {
                    // Tạo tên file duy nhất
                    String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
                    File mediaFile = new File(IMAGE_UPLOAD_DIR, fileName);
                    filePart.write(mediaFile.getAbsolutePath());

                    // Lấy URL của media đã lưu
                    String mediaUrl = "/img/" + fileName;
                    mediaUrls.add(mediaUrl);

                    // Lưu loại media (ảnh, video, hoặc loại khác)
                    String mediaType = mediaTypes.size() > mediaIndex ? mediaTypes.get(mediaIndex) : "other";

                    // Thêm media vào database (nếu có)
                    reviewDAO.addReviewMedia(reviewId, mediaUrl, mediaType);
                    mediaIndex++;
                }
            }

            // Điều hướng đến trang userProfile
            response.sendRedirect("userProfile");
        } else {
            response.sendRedirect("reviewError.jsp");
        }
    }

// Phương thức giúp lấy phần mở rộng của file từ Part
    private String getFileExtension(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String fileName = contentDisposition.substring(contentDisposition.indexOf("filename=\"") + 10, contentDisposition.lastIndexOf("\""));
        return fileName.substring(fileName.lastIndexOf("."));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/addReview")) {
            addReview(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }

}

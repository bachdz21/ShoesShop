/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IReviewDAO;
import java.security.Timestamp;
import java.sql.PreparedStatement;
import model.Review;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.ReviewMedia;
import model.ReviewReply;

/**
 *
 * @author nguye
 */
public class ReviewDAO extends DBConnect implements IReviewDAO {

    @Override
    public int addReview(Review review) {
        String query = "INSERT INTO Reviews (ProductID, UserID, Rating, Comment, ReviewDate, IsApproved) "
                + "VALUES (?, ?, ?, ?, GETDATE(), 1)";

        try {
            // Sử dụng Statement.RETURN_GENERATED_KEYS để yêu cầu trả về khóa tự động tạo ra
            PreparedStatement ps = c.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, review.getProductId());
            ps.setInt(2, review.getUserId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getComment());

            // Thực thi câu lệnh INSERT
            ps.executeUpdate();

            // Sau khi thực thi, lấy khóa tự động tạo ra
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Lấy khóa tự động tạo ra (ReviewID)
                } else {
                    throw new SQLException("Không lấy được ReviewID.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Hàm thêm media (nếu có)
    public void addReviewMedia(int reviewId, String mediaUrl, String mediaType) {
        String query = "INSERT INTO ReviewMedia (ReviewID, MediaURL, MediaType) VALUES (?, ?, ?)";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, reviewId);
            ps.setString(2, mediaUrl);
            ps.setString(3, mediaType);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    // Hàm lấy danh sách Review theo ProductID
    public List<Review> getReviewsByProductID(int productID) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.ReviewID, r.Rating, r.Comment, r.ReviewDate, u.UserName, "
                + "       rm.MediaURL, rm.MediaType "
                + "FROM Reviews r "
                + "JOIN Users u ON r.UserID = u.UserID "
                + "LEFT JOIN ReviewMedia rm ON r.ReviewID = rm.ReviewID "
                + "WHERE r.ProductID = ? AND r.IsApproved = 1 "
                + "ORDER BY r.ReviewDate DESC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();

            // Duyệt qua các dòng dữ liệu
            Map<Integer, Review> reviewMap = new HashMap<>();
            while (rs.next()) {
                int reviewID = rs.getInt("ReviewID");
                Review review = reviewMap.get(reviewID);
                if (review == null) {
                    review = new Review();
                    review.setReviewId(reviewID);
                    review.setRating(rs.getInt("Rating"));
                    review.setComment(rs.getString("Comment"));
                    review.setReviewDate(rs.getTimestamp("ReviewDate"));
                    review.setUserName(rs.getString("UserName"));
                    reviews.add(review);
                    reviewMap.put(reviewID, review);
                }

                // Thêm media
                String mediaURL = rs.getString("MediaURL");
                String mediaType = rs.getString("MediaType");
                if (mediaURL != null) {
                    ReviewMedia media = new ReviewMedia();
                    media.setMediaUrl(mediaURL);
                    media.setMediaType(mediaType);
                    review.getReviewMedia().add(media);
                }
            }

            // Sau khi lấy tất cả các review, chúng ta sẽ gọi hàm lấy danh sách reply cho tất cả reviewID
            // Tạo Map<Integer, List<ReviewReply>> để lưu các reply cho từng reviewID
            Map<Integer, List<ReviewReply>> reviewRepliesMap = getReviewRepliesByReviewIDs(reviewMap.keySet());

            // Duyệt qua các review và gắn các reply từ reviewRepliesMap
            for (Review review : reviews) {
                List<ReviewReply> replies = reviewRepliesMap.get(review.getReviewId());
                if (replies != null) {
                    review.getReviewReply().addAll(replies);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviews;
    }

    // Hàm lấy danh sách reply cho nhiều Review cùng lúc
    public Map<Integer, List<ReviewReply>> getReviewRepliesByReviewIDs(Set<Integer> reviewIDs) {
        Map<Integer, List<ReviewReply>> reviewRepliesMap = new HashMap<>();

        if (reviewIDs.isEmpty()) {
            return reviewRepliesMap;
        }

        // Chuẩn bị câu lệnh SQL để lấy tất cả các reply cho các reviewID
        String sql = "SELECT rp.ReviewID, rp.ReplyText, rp.ReplyDate "
                + "FROM ReviewReplies rp "
                + "WHERE rp.ReviewID IN (" + String.join(",", Collections.nCopies(reviewIDs.size(), "?")) + ")";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            int index = 1;
            for (Integer reviewID : reviewIDs) {
                ps.setInt(index++, reviewID);
            }

            ResultSet rs = ps.executeQuery();

            // Duyệt qua các dòng kết quả và phân bổ phản hồi vào reviewID tương ứng
            while (rs.next()) {
                int reviewID = rs.getInt("ReviewID");
                ReviewReply reply = new ReviewReply();
                reply.setReplyText(rs.getString("ReplyText"));
                reply.setReplyDate(rs.getTimestamp("ReplyDate"));

                // Thêm reply vào Map
                reviewRepliesMap
                        .computeIfAbsent(reviewID, k -> new ArrayList<>())
                        .add(reply);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reviewRepliesMap;
    }

    // Phương thức xóa review
    public void deleteReview(int reviewId) {
        String deleteMediaQuery = "DELETE FROM ReviewMedia WHERE ReviewID = ?";
        String deleteRepliesQuery = "DELETE FROM ReviewReplies WHERE ReviewID = ?";
        String deleteReviewQuery = "DELETE FROM Reviews WHERE ReviewID = ?";

        try {
            c.setAutoCommit(false); // Bắt đầu giao dịch

            // Xóa media liên quan
            try (PreparedStatement psMedia = c.prepareStatement(deleteMediaQuery)) {
                psMedia.setInt(1, reviewId);
                psMedia.executeUpdate();
            }

            // Xóa replies liên quan
            try (PreparedStatement psReplies = c.prepareStatement(deleteRepliesQuery)) {
                psReplies.setInt(1, reviewId);
                psReplies.executeUpdate();
            }

            // Xóa review
            try (PreparedStatement psReview = c.prepareStatement(deleteReviewQuery)) {
                psReview.setInt(1, reviewId);
                psReview.executeUpdate();
            }

            c.commit(); // Hoàn tất giao dịch
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                c.rollback(); // Rollback nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                c.setAutoCommit(true); // Khôi phục chế độ tự động commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Phương thức thêm trả lời review
    public String addReviewReply(int reviewId, int userId, String replyText) {
        // Bỏ tham số userId vì không cần nữa, nhưng giữ nguyên để tương thích với mã hiện tại
        String query = "INSERT INTO ReviewReplies (ReviewID, ReplyText, ReplyDate) VALUES (?, ?, GETDATE()); "
                + "SELECT ReplyDate FROM ReviewReplies WHERE ReviewID = ? AND ReplyText = ? AND ReplyDate = (SELECT MAX(ReplyDate) FROM ReviewReplies WHERE ReviewID = ?)";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, reviewId);
            ps.setString(2, replyText);
            ps.setInt(3, reviewId);
            ps.setString(4, replyText);
            ps.setInt(5, reviewId);

            // Sử dụng execute() thay vì executeQuery()
            boolean isResultSet = ps.execute();

            // Kiểm tra xem có ResultSet trả về không
            if (isResultSet) {
                try (ResultSet rs = ps.getResultSet()) {
                    if (rs.next()) {
                        java.sql.Timestamp replyDate = rs.getTimestamp("ReplyDate");
                        return new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(replyDate);
                    }
                }
            } else {
                // Nếu không có ResultSet, kiểm tra số hàng bị ảnh hưởng bởi INSERT
                int updateCount = ps.getUpdateCount();
                if (updateCount > 0) {
                    // INSERT thành công, nhưng không có ResultSet từ SELECT
                    // Có thể trả về thời gian hiện tại nếu cần
                    return new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date());
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to add reply: " + e.getMessage());
        }
        return new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date());
    }

    // Kiểm tra xem user đã review sản phẩm này chưa
    public Review getReviewByUserAndProduct(int userId, int productId) {
        String query = "SELECT * FROM Reviews WHERE UserID = ? AND ProductID = ?";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("ReviewID"));
                review.setProductId(rs.getInt("ProductID"));
                review.setUserId(rs.getInt("UserID"));
                review.setRating(rs.getInt("Rating"));
                review.setComment(rs.getString("Comment"));
                review.setReviewDate(rs.getTimestamp("ReviewDate"));
                review.setIsApproved(rs.getBoolean("IsApproved"));
                return review;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

// Cập nhật review
    public void updateReview(Review review) {
        String query = "UPDATE Reviews SET Rating = ?, Comment = ?, ReviewDate = GETDATE() WHERE ReviewID = ?";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, review.getRating());
            ps.setString(2, review.getComment());
            ps.setInt(3, review.getReviewId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Cập nhật media (xóa media cũ và thêm media mới)
    public void updateReviewMedia(int reviewId, String mediaUrl, String mediaType) {
        // Xóa media cũ
        String deleteQuery = "DELETE FROM ReviewMedia WHERE ReviewID = ?";
        try (PreparedStatement ps = c.prepareStatement(deleteQuery)) {
            ps.setInt(1, reviewId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Thêm media mới
        addReviewMedia(reviewId, mediaUrl, mediaType);
    }

    public static void main(String[] args) {
        ReviewDAO d = new ReviewDAO();
        List<Review> list = d.getReviewsByProductID(1);
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
            
        }
    }
}

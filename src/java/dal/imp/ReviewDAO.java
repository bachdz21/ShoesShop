/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IReviewDAO;
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
                + "VALUES (?, ?, ?, ?, GETDATE(), 0)";

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

}

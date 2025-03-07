/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IReviewDAO;
import jakarta.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import model.Review;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;

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
    public void addReviewMedia(int reviewId, String mediaUrl, String mediaType){
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
    
    
    public static void main(String[] args){
        ReviewDAO r = new ReviewDAO();
//        int id = r.addReview(new Review(1, 18, 5, "xấu"));
//        r.addReviewMedia(1, "https://vlipsy.com/vlip/92Pv8LyV", "video");
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import model.Reviews;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author DELL
 */
public class ReviewsDAO extends DBConnect {

    // Lấy danh sách tất cả review
    public List<Reviews> getAllReviews() {
        List<Reviews> reviews = new ArrayList<>();
        String query = "SELECT ReviewID, ProductID, UserID, Rating, Comment, ReviewDate, IsApproved FROM Reviews";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reviews review = new Reviews(
                    rs.getInt("ReviewID"),
                    rs.getInt("ProductID"),
                    rs.getInt("UserID"),
                    rs.getInt("Rating"),
                    rs.getString("Comment"),
                    rs.getDate("ReviewDate"),
                    rs.getBoolean("IsApproved")
                );
                reviews.add(review);
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

       // Cập nhật trạng thái duyệt của review
   public boolean updateReviewStatus(int reviewID, boolean status) {
    String query = "UPDATE Reviews SET IsApproved = ? WHERE ReviewID = ?";
    try {
        PreparedStatement ps = c.prepareStatement(query);
        ps.setBoolean(1, status);
        ps.setInt(2, reviewID);
        int rowsUpdated = ps.executeUpdate();
        ps.close();
        return rowsUpdated > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

    // Xóa review theo ID
    public boolean deleteReview(int reviewID) {
        String query = "DELETE FROM Reviews WHERE ReviewID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, reviewID);
            int rowsDeleted = ps.executeUpdate();
            ps.close();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public static void main(String[] args) {
        ReviewsDAO reviewsDAO = new ReviewsDAO();

        int reviewID = 8; // Thay ID bằng một ID hợp lệ trong database
        boolean newStatus = false; // Đổi thành false để kiểm tra chưa duyệt

        boolean result = reviewsDAO.updateReviewStatus(reviewID, newStatus);

        if (result) {
            System.out.println("✅ Cập nhật thành công reviewID=" + reviewID + " thành trạng thái: " + newStatus);
        } else {
            System.err.println("❌ Cập nhật thất bại reviewID=" + reviewID);
        }
    }
}

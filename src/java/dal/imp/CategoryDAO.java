package dal.imp;

import dal.DBConnect;
import dal.ICategoryDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBConnect implements ICategoryDAO {

    @Override
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT * FROM Categories";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    @Override
    public List<Category> getDisplayedCategories() {
        List<Category> categories = new ArrayList<>();
        try {
            String query = "SELECT c.CategoryID, c.CategoryName " +
                           "FROM Categories c " +
                           "JOIN SelectedCategories sc ON c.CategoryID = sc.CategoryID " +
                           "WHERE sc.IsDisplayed = 1";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("CategoryID"));
                category.setCategoryName(rs.getString("CategoryName"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    @Override
    public void updateDisplayedCategories(List<Integer> selectedCategoryIds) {
        try {
            // Đặt tất cả về không hiển thị trước
            String resetQuery = "UPDATE SelectedCategories SET IsDisplayed = 0";
            PreparedStatement resetPs = c.prepareStatement(resetQuery);
            resetPs.executeUpdate();

            // Cập nhật các danh mục được chọn thành hiển thị
            if (selectedCategoryIds != null && !selectedCategoryIds.isEmpty()) {
                String updateQuery = "UPDATE SelectedCategories SET IsDisplayed = 1 WHERE CategoryID = ?";
                PreparedStatement updatePs = c.prepareStatement(updateQuery);
                for (Integer categoryId : selectedCategoryIds) {
                    updatePs.setInt(1, categoryId);
                    updatePs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    // Phương thức mới: Đồng bộ SelectedCategories với Categories
    public void syncSelectedCategories() {
        try {
            // Lấy tất cả danh mục từ Categories
            List<Category> allCategories = getAllCategories();

            // Lấy danh sách CategoryID hiện có trong SelectedCategories
            String query = "SELECT CategoryID FROM SelectedCategories";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            List<Integer> existingIds = new ArrayList<>();
            while (rs.next()) {
                existingIds.add(rs.getInt("CategoryID"));
            }

            // Thêm các danh mục mới vào SelectedCategories nếu chưa tồn tại
            String insertQuery = "INSERT INTO SelectedCategories (CategoryID, IsDisplayed) VALUES (?, 1)";
            PreparedStatement insertPs = c.prepareStatement(insertQuery);
            for (Category category : allCategories) {
                if (!existingIds.contains(category.getCategoryID())) {
                    insertPs.setInt(1, category.getCategoryID());
                    insertPs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        CategoryDAO u = new CategoryDAO();
        u.syncSelectedCategories(); // Test đồng bộ
        List<Category> list = u.getDisplayedCategories();
        System.out.println("Displayed Categories:");
        for (Category category : list) {
            System.out.println(category.toString());
        }
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IWishlistDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.WishlistItem;

/**
 *
 * @author nguye
 */
public class WishlistDAO extends DBConnect implements IWishlistDAO {

    @Override
    public void addWishlistItem(int userId, int productId) {
        try {
            // Kiểm tra nếu Wishlist đã tồn tại cho người dùng
            String checkWishlistQuery = "SELECT WishlistID FROM Wishlist WHERE UserID = ?";
            PreparedStatement checkWishlistStmt = c.prepareStatement(checkWishlistQuery);
            checkWishlistStmt.setInt(1, userId);
            ResultSet wishlistResult = checkWishlistStmt.executeQuery();

            int wishlistId;
            if (wishlistResult.next()) {
                // Nếu Wishlist đã tồn tại, lấy WishlistID
                wishlistId = wishlistResult.getInt("WishlistID");
            } else {
                // Nếu Wishlist chưa tồn tại, tạo Wishlist mới
                createWishlistForUser(userId);
                // Lấy lại WishlistID sau khi tạo Wishlist
                wishlistResult = checkWishlistStmt.executeQuery(); // Thực hiện lại truy vấn
                wishlistResult.next();
                wishlistId = wishlistResult.getInt("WishlistID");
            }

            // Kiểm tra nếu sản phẩm đã tồn tại trong Wishlist của người dùng
            String query = "SELECT * FROM WishlistItems WHERE WishlistID = ? AND ProductID = ?";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, wishlistId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                // Nếu sản phẩm chưa có trong Wishlist, thêm mới
                String insertQuery = "INSERT INTO WishlistItems (WishlistID, ProductID) VALUES (?, ?)";
                PreparedStatement insertStmt = c.prepareStatement(insertQuery);
                insertStmt.setInt(1, wishlistId);
                insertStmt.setInt(2, productId);
                insertStmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(WishlistDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void createWishlistForUser(int userId) throws SQLException {
        String query = "INSERT INTO Wishlist (UserID) VALUES (?)";
        PreparedStatement stmt = c.prepareStatement(query);
        stmt.setInt(1, userId);
        stmt.executeUpdate();
    }

    @Override
    public List<WishlistItem> getWishlistItems(int userId) {
        List<WishlistItem> wishlistItems = new ArrayList<>();
        try {
            String query = "SELECT wi.WishlistItemID, wi.ProductID, p.ProductName, p.Description, p.Price, p.Stock, "
                    + "c.CategoryName, p.imageURL, p.Sale, p.brand "
                    + "FROM WishlistItems wi "
                    + "JOIN Products p ON wi.ProductID = p.ProductID "
                    + "JOIN Categories c ON p.CategoryID = c.CategoryID "
                    + "WHERE WishlistID = (SELECT WishlistID FROM Wishlist WHERE UserID = ?)";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int wishlistItemId = rs.getInt("WishlistItemID");
                Product product = new Product(rs.getInt("ProductID"), rs.getString("ProductName"), rs.getString("Description"),
                        rs.getDouble("Price"), rs.getInt("Stock"), rs.getString("CategoryName"),
                        rs.getString("imageURL"), rs.getInt("Sale"), rs.getString("brand"));
                if (product.getSale() > 0) {
                    product.setSalePrice((double) product.getPrice() * ((100 - product.getSale()) / 100.0));
                    DecimalFormat df = new DecimalFormat("0.##");
                    String formattedPrice = df.format(product.getSalePrice());
                    product.setSalePrice(Double.parseDouble(formattedPrice));
                }
                WishlistItem item = new WishlistItem(wishlistItemId, wishlistItemId, product);
                wishlistItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return wishlistItems;
    }

    @Override
    public void deleteWishlistItem(int userId, int productId) {
        try {
            // Xóa sản phẩm khỏi bảng WishlistItems
            String deleteQuery = "DELETE wi\n"
                    + "FROM WishlistItems wi\n"
                    + "JOIN Wishlist w ON wi.WishlistID = w.WishlistID\n"
                    + "JOIN Users u ON w.UserID = u.UserID\n"
                    + "WHERE u.UserID = ? AND wi.ProductID = ?;";
            PreparedStatement stmtDel = c.prepareStatement(deleteQuery);
            stmtDel.setInt(1, userId);
            stmtDel.setInt(2, productId);
            stmtDel.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        WishlistDAO w = new WishlistDAO();
        w.deleteWishlistItem(2, 99);
        List<WishlistItem> list = w.getWishlistItems(2);
        System.out.println(list);
    }

}

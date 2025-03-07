/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import java.sql.Statement;
import dal.DBConnect;
import dal.ICartDAO;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.CartItem;
import model.Product;


/**
 *
 * @author nguye
 */
public class CartDAO extends DBConnect implements ICartDAO {

    // 1. Thêm sản phẩm vào giỏ hàng
    @Override
    public void addCartItem(int userId, int productId, int quantity) {
        try {
            // Kiểm tra nếu giỏ hàng đã tồn tại cho người dùng
            String checkCartQuery = "SELECT CartID FROM Cart WHERE UserID = ?";
            PreparedStatement checkCartStmt = c.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, userId);
            ResultSet cartResult = checkCartStmt.executeQuery();

            int cartId;
            if (cartResult.next()) {
                // Nếu giỏ hàng đã tồn tại, lấy CartID
                cartId = cartResult.getInt("CartID");
            } else {
                // Nếu giỏ hàng chưa tồn tại, tạo giỏ hàng mới
                createCartForUser(userId);
                // Lấy lại CartID sau khi tạo giỏ hàng
                cartResult = checkCartStmt.executeQuery(); // Thực hiện lại truy vấn
                cartResult.next();
                cartId = cartResult.getInt("CartID");
            }

            // Kiểm tra nếu sản phẩm đã tồn tại trong giỏ hàng của người dùng
            String query = "SELECT * FROM CartItems WHERE CartID = ? AND ProductID = ?";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Nếu sản phẩm đã có trong giỏ hàng, cập nhật số lượng
                int existingQuantity = rs.getInt("Quantity");
                int newQuantity = existingQuantity + quantity;
                String updateQuery = "UPDATE CartItems SET Quantity = ? WHERE CartItemID = ?";
                PreparedStatement updateStmt = c.prepareStatement(updateQuery);
                updateStmt.setInt(1, newQuantity);
                updateStmt.setInt(2, rs.getInt("CartItemID"));
                updateStmt.executeUpdate();
            } else {
                // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
                String insertQuery = "INSERT INTO CartItems (CartID, ProductID, Quantity) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = c.prepareStatement(insertQuery);
                insertStmt.setInt(1, cartId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // 2. Lấy danh sách các mục trong giỏ hàng của người dùng
    @Override
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        try {

            String query = "SELECT ci.CartItemID, ci.ProductID, ci.Quantity, ci.AddedDate, p.ProductName, p.Description, p.Price, p.Stock, "
                    + "c.CategoryName, p.imageURL, p.Sale, p.brand\n"
                    + "FROM CartItems ci\n"
                    + "JOIN Products p ON ci.ProductID = p.ProductID\n"
                    + "JOIN Categories c on p.CategoryID = c.CategoryID\n"
                    + "WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int cartItemId = rs.getInt("CartItemID");
                int productId = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");
                Date addedDate = rs.getDate("AddedDate");
                Product product = new Product(rs.getInt("ProductID"), rs.getString("ProductName"), rs.getString("Description"),
                        rs.getDouble("Price"), rs.getInt("Stock"), rs.getString("CategoryName"),
                        rs.getString("imageURL"), rs.getInt("Sale"), rs.getString("brand"));
                if (product.getSale() > 0) {
                    product.setSalePrice((double) product.getPrice() * ((100 - product.getSale()) / 100.0));
                    DecimalFormat df = new DecimalFormat("0.##");
                    String formattedPrice = df.format(product.getSalePrice());
                    product.setSalePrice(Double.parseDouble(formattedPrice));
                }
                CartItem item = new CartItem(cartItemId, cartItemId, quantity, addedDate, product);
                cartItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    // 3. Cập nhật số lượng sản phẩm trong giỏ hàng
    @Override
    public void updateCartItemQuantity(int cartItemId, int newQuantity) {
        try {
            String query = "UPDATE CartItems SET Quantity = ? WHERE CartItemID = ?";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 4. Xóa sản phẩm khỏi giỏ hàng
    @Override
    public void deleteCartItem(int userId, int productId) {
        try {

            String query = "INSERT INTO CartItemsTrash (CartItemID, CartID, ProductID, Quantity, AddedDate) \n"
                    + "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate\n"
                    + "FROM CartItems ci\n"
                    + "JOIN Cart c ON ci.CartID = c.CartID\n"
                    + "JOIN Users u ON c.UserID = u.UserID\n"
                    + "WHERE u.UserID = ? AND ci.ProductID = ?;";

            // Xóa sản phẩm khỏi bảng Products
            String deleteQuery = "DELETE ci\n"
                    + "FROM CartItems ci\n"
                    + "JOIN Cart c ON ci.CartID = c.CartID\n"
                    + "JOIN Users u ON c.UserID = u.UserID\n"
                    + "WHERE u.UserID = ? AND ci.ProductID = ?;";
            PreparedStatement stmt = c.prepareStatement(query);
            PreparedStatement stmtDel = c.prepareStatement(deleteQuery);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
            stmtDel.setInt(1, userId);
            stmtDel.setInt(2, productId);
            stmtDel.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteTrashCartItem(int userId, int productId) {
        String deleteQuery = "DELETE ci\n"
                + "FROM CartItemsTrash ci\n"
                + "JOIN Cart c ON ci.CartID = c.CartID\n"
                + "JOIN Users u ON c.UserID = u.UserID\n"
                + "WHERE u.UserID = ? AND ci.ProductID = ?;";

        try {

            PreparedStatement ps = c.prepareStatement(deleteQuery);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Xóa tất cả mục trong giỏ hàng của người dùng
    @Override
    public void clearCart(int userId) {
        try {
            // Chuyển tất cả các mục từ CartItems sang CartItemsTrash
            String insertQuery = "INSERT INTO CartItemsTrash (CartItemID, CartID, ProductID, Quantity, AddedDate) "
                    + "SELECT CartItemID, CartID, ProductID, Quantity, AddedDate "
                    + "FROM CartItems WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";

            PreparedStatement insertStmt = c.prepareStatement(insertQuery);
            insertStmt.setInt(1, userId);
            insertStmt.executeUpdate();

            // Xóa tất cả các mục trong CartItems
            String deleteQuery = "DELETE FROM CartItems WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, userId);
            deleteStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void clearCartForever(int userId) {
        try {
            // Xóa tất cả các mục trong CartItems
            String deleteQuery = "DELETE FROM CartItems WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, userId);
            deleteStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void restoreCartItemTrash(int userId, int productId) {
        try {
            // Khôi phục dữ liệu từ bảng CartItemsTrash vào CartItems
            String query = "SET IDENTITY_INSERT CartItems ON\n"
                    + "INSERT INTO CartItems (CartItemID, CartID, ProductID, Quantity, AddedDate) \n"
                    + "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate\n"
                    + "FROM CartItemsTrash ci\n"
                    + "JOIN Cart c ON ci.CartID = c.CartID\n"
                    + "JOIN Users u ON c.UserID = u.UserID\n"
                    + "WHERE u.UserID = ? AND ci.ProductID = ?;";

            // Xóa bản ghi đã khôi phục khỏi bảng CartItemsTrash
            String deleteQuery = "DELETE ci\n"
                    + "FROM CartItemsTrash ci\n"
                    + "JOIN Cart c ON ci.CartID = c.CartID\n"
                    + "JOIN Users u ON c.UserID = u.UserID\n"
                    + "WHERE u.UserID = ? AND ci.ProductID = ?\n"
                    + "SET IDENTITY_INSERT CartItems OFF;";

            // Khôi phục mục từ CartItemsTrash vào CartItems
            PreparedStatement restoreStmt = c.prepareStatement(query);
            restoreStmt.setInt(1, userId);
            restoreStmt.setInt(2, productId);
            restoreStmt.executeUpdate();

            // Xóa mục khỏi CartItemsTrash sau khi khôi phục thành công
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, userId);
            deleteStmt.setInt(2, productId);
            deleteStmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createCartForUser(int userId) throws SQLException {
        String query = "INSERT INTO Cart (UserID) VALUES (?)";
        PreparedStatement stmt = c.prepareStatement(query);
        stmt.setInt(1, userId);
        stmt.executeUpdate();
    }

    public int countDistinctProductIdsInCart(int userId) throws SQLException {
        int distinctCount = 0;
        String sql = "SELECT COUNT(DISTINCT productId) AS total FROM CartItems WHERE userId = ?";

        try (PreparedStatement statement = c.prepareStatement(sql)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                distinctCount = resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }

        return distinctCount;
    }

    @Override
    public List<CartItem> getCartItemsTrash(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        try {

            String query = "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate, p.ProductName, p.Description, p.Price, p.Stock, "
                    + "c.CategoryName, p.imageURL, p.Sale, p.brand\n"
                    + "FROM CartItemsTrash ci\n"
                    + "JOIN Products p ON ci.ProductID = p.ProductID\n"
                    + "JOIN Categories c on p.CategoryID = c.CategoryID\n"
                    + "WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement stmt = c.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int cartItemId = rs.getInt("CartItemID");
                int cartId = rs.getInt("CartID");
                int productId = rs.getInt("ProductID");
                int quantity = rs.getInt("Quantity");
                Date addedDate = rs.getDate("AddedDate");
                Product product = new Product(rs.getInt("ProductID"), rs.getString("ProductName"), rs.getString("Description"),
                        rs.getDouble("Price"), rs.getInt("Stock"), rs.getString("CategoryName"),
                        rs.getString("imageURL"), rs.getInt("Sale"), rs.getString("brand"));
                if (product.getSale() > 0) {
                    product.setSalePrice((double) product.getPrice() * ((100 - product.getSale()) / 100.0));
                    DecimalFormat df = new DecimalFormat("0.##");
                    String formattedPrice = df.format(product.getSalePrice());
                    product.setSalePrice(Double.parseDouble(formattedPrice));
                }
                CartItem item = new CartItem(cartItemId, cartId, quantity, addedDate, product);
                cartItems.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }
    
    @Override
    public void updateQuantityInCart(int userID, int productId, int quantity) {
        String query = "UPDATE CartItems\n"
                + "SET Quantity = ?\n"
                + "WHERE ProductID = ? \n"
                + "  AND CartID = (SELECT c.CartID \n"
                + "                FROM Cart c\n"
                + "                JOIN Users u ON c.UserID = u.UserID\n"
                + "                WHERE u.UserID = ?);";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, userID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    

    public static void main(String[] args) {
        CartDAO cd = new CartDAO();
        cd.restoreCartItemTrash(12, 15);
    }

}

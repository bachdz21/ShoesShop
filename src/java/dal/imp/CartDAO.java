package dal.imp;

import dal.DBConnect;
import dal.ICartDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Product;

public class CartDAO extends DBConnect implements ICartDAO {

    @Override
    public void addCartItem(int userId, int productId, int quantity) {
        try {
            String checkCartQuery = "SELECT CartID FROM Cart WHERE UserID = ?";
            PreparedStatement checkCartStmt = c.prepareStatement(checkCartQuery);
            checkCartStmt.setInt(1, userId);
            ResultSet cartResult = checkCartStmt.executeQuery();

            int cartId;
            if (cartResult.next()) {
                cartId = cartResult.getInt("CartID");
            } else {
                createCartForUser(userId);
                cartResult = checkCartStmt.executeQuery();
                cartResult.next();
                cartId = cartResult.getInt("CartID");
            }

            String query = "SELECT * FROM CartItems WHERE CartID = ? AND ProductID = ?";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int existingQuantity = rs.getInt("Quantity");
                int newQuantity = existingQuantity + quantity;
                String updateQuery = "UPDATE CartItems SET Quantity = ? WHERE CartItemID = ?";
                PreparedStatement updateStmt = c.prepareStatement(updateQuery);
                updateStmt.setInt(1, newQuantity);
                updateStmt.setInt(2, rs.getInt("CartItemID"));
                updateStmt.executeUpdate();
            } else {
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

    @Override
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        try {
            String query = "SELECT ci.CartItemID, ci.ProductID, ci.Quantity, ci.AddedDate, p.ProductName, p.Description, p.Price, p.Stock, " +
                          "c.CategoryName, p.imageURL, p.Sale, p.brand " +
                          "FROM CartItems ci " +
                          "JOIN Products p ON ci.ProductID = p.ProductID " +
                          "JOIN Categories c on p.CategoryID = c.CategoryID " +
                          "WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
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
                product.setSalePrice(product.getPrice());
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

    @Override
    public void deleteMultipleCartItems(int userId, List<Integer> productIds) {
        try {
            String insertQuery = "INSERT INTO CartItemsTrash (CartItemID, CartID, ProductID, Quantity, AddedDate) " +
                                "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate " +
                                "FROM CartItems ci " +
                                "JOIN Cart c ON ci.CartID = c.CartID " +
                                "JOIN Users u ON c.UserID = u.UserID " +
                                "WHERE u.UserID = ? AND ci.ProductID = ?;";

            String deleteQuery = "DELETE ci " +
                                "FROM CartItems ci " +
                                "JOIN Cart c ON ci.CartID = c.CartID " +
                                "JOIN Users u ON c.UserID = u.UserID " +
                                "WHERE u.UserID = ? AND ci.ProductID = ?;";

            PreparedStatement insertStmt = c.prepareStatement(insertQuery);
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);

            for (int productId : productIds) {
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, productId);
                insertStmt.addBatch();

                deleteStmt.setInt(1, userId);
                deleteStmt.setInt(2, productId);
                deleteStmt.addBatch();
            }

            insertStmt.executeBatch();
            deleteStmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMultipleTrashCartItems(int userId, List<Integer> productIds) {
        String deleteQuery = "DELETE ci FROM CartItemsTrash ci " +
                            "JOIN Cart c ON ci.CartID = c.CartID " +
                            "JOIN Users u ON c.UserID = u.UserID " +
                            "WHERE u.UserID = ? AND ci.ProductID = ?";

        try {
            PreparedStatement ps = c.prepareStatement(deleteQuery);
            for (int productId : productIds) {
                ps.setInt(1, userId);
                ps.setInt(2, productId);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void clearCart(int userId) {
        try {
            String insertQuery = "INSERT INTO CartItemsTrash (CartItemID, CartID, ProductID, Quantity, AddedDate) " +
                                "SELECT CartItemID, CartID, ProductID, Quantity, AddedDate " +
                                "FROM CartItems WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement insertStmt = c.prepareStatement(insertQuery);
            insertStmt.setInt(1, userId);
            insertStmt.executeUpdate();

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
            String deleteQuery = "DELETE FROM CartItems WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, userId);
            deleteStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void restoreMultipleCartItemsTrash(int userId, List<Integer> productIds) {
        try {
            String restoreQuery = "SET IDENTITY_INSERT CartItems ON; " +
                                 "INSERT INTO CartItems (CartItemID, CartID, ProductID, Quantity, AddedDate) " +
                                 "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate " +
                                 "FROM CartItemsTrash ci " +
                                 "JOIN Cart c ON ci.CartID = c.CartID " +
                                 "JOIN Users u ON c.UserID = u.UserID " +
                                 "WHERE u.UserID = ? AND ci.ProductID = ?;";

            String deleteQuery = "DELETE ci FROM CartItemsTrash ci " +
                                "JOIN Cart c ON ci.CartID = c.CartID " +
                                "JOIN Users u ON c.UserID = u.UserID " +
                                "WHERE u.UserID = ? AND ci.ProductID = ?; " +
                                "SET IDENTITY_INSERT CartItems OFF;";

            PreparedStatement restoreStmt = c.prepareStatement(restoreQuery);
            PreparedStatement deleteStmt = c.prepareStatement(deleteQuery);

            for (int productId : productIds) {
                restoreStmt.setInt(1, userId);
                restoreStmt.setInt(2, productId);
                restoreStmt.addBatch();

                deleteStmt.setInt(1, userId);
                deleteStmt.setInt(2, productId);
                deleteStmt.addBatch();
            }

            restoreStmt.executeBatch();
            deleteStmt.executeBatch();
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
            String query = "SELECT ci.CartItemID, ci.CartID, ci.ProductID, ci.Quantity, ci.AddedDate, p.ProductName, p.Description, p.Price, p.Stock, " +
                          "c.CategoryName, p.imageURL, p.Sale, p.brand " +
                          "FROM CartItemsTrash ci " +
                          "JOIN Products p ON ci.ProductID = p.ProductID " +
                          "JOIN Categories c on p.CategoryID = c.CategoryID " +
                          "WHERE CartID = (SELECT CartID FROM Cart WHERE UserID = ?)";
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
                CartItem item = new CartItem(cartItemId, cartId, quantity, addedDate, product, query, query);
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    @Override
    public void updateQuantityInCart(int userID, int productId, int quantity) {
        String query = "UPDATE CartItems " +
                      "SET Quantity = ? " +
                      "WHERE ProductID = ? " +
                      "AND CartID = (SELECT c.CartID " +
                                    "FROM Cart c " +
                                    "JOIN Users u ON c.UserID = u.UserID " +
                                    "WHERE u.UserID = ?);";
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, userID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addCartItemWithVariant(int userId, int productId, int quantity, String size, String color) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
    public static void main(String[] args) {
        CartDAO c = new CartDAO();
        List<CartItem> list = c.getCartItems(20);
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i));
            
        }
    }
}

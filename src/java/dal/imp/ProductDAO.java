/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IProductDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import model.Product;
/**
 *
 * @author nguye
 */
public class ProductDAO extends DBConnect implements IProductDAO {

    @Override
    public List<Product> getSaleProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale\n"
                    + "FROM Products p\n"
                    + "INNER JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE p.Sale != 0";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName")); // Kiểm tra cột này
                product.setBrand(rs.getString("brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale, p.CreatedDate\n"
                    + "FROM Products p\n"
                    + "JOIN Categories c ON p.CategoryID = c.CategoryID";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("brand"));
                product.setSale(rs.getInt("Sale"));
                product.setCreatedDate(rs.getDate("CreatedDate"));
                product.setSalePrice(rs.getDouble("Price"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0);
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public List<Product> getProductsByPage(int offset, int limit, String orderBy, String[] categories, String[] brands, double priceMin, double priceMax) {
        List<Product> products = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, "
                    + "c.CategoryName, p.Brand, p.Sale, p.Price * (1 - p.Sale / 100.0) AS SalePrice "
                    + "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID "
                    + "WHERE p.Price BETWEEN ? AND ? ");

            // Thêm điều kiện lọc danh mục
            if (categories != null && categories.length > 0) {
                sql.append("AND c.CategoryName IN (");
                sql.append(String.join(",", Collections.nCopies(categories.length, "?")));
                sql.append(") ");
            }

            // Thêm điều kiện lọc thương hiệu
            if (brands != null && brands.length > 0) {
                sql.append("AND p.Brand IN (");
                sql.append(String.join(",", Collections.nCopies(brands.length, "?")));
                sql.append(") ");
            }

            // Thêm sắp xếp
            sql.append("ORDER BY ").append(orderBy).append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;");

            PreparedStatement ps = c.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Gán giá trị khoảng giá
            ps.setDouble(paramIndex++, priceMin);
            ps.setDouble(paramIndex++, priceMax);

            // Gán các giá trị lọc danh mục
            if (categories != null) {
                for (String category : categories) {
                    ps.setString(paramIndex++, category);
                }
            }

            // Gán các giá trị lọc thương hiệu
            if (brands != null) {
                for (String brand : brands) {
                    ps.setString(paramIndex++, brand);
                }
            }

            // Gán offset và limit
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public int getTotalProducts(String[] categories, String[] brands, double priceMin, double priceMax) {
        int count = 0;
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.Price BETWEEN ? AND ? ");

            // Thêm điều kiện lọc danh mục
            if (categories != null && categories.length > 0) {
                sql.append("AND c.CategoryName IN (");
                sql.append(String.join(",", Collections.nCopies(categories.length, "?")));
                sql.append(") ");
            }

            // Thêm điều kiện lọc thương hiệu
            if (brands != null && brands.length > 0) {
                sql.append("AND p.Brand IN (");
                sql.append(String.join(",", Collections.nCopies(brands.length, "?")));
                sql.append(")");
            }

            PreparedStatement ps = c.prepareStatement(sql.toString());
            int paramIndex = 1;

            // Gán giá trị khoảng giá
            ps.setDouble(paramIndex++, priceMin);
            ps.setDouble(paramIndex++, priceMax);

            // Gán các giá trị lọc danh mục
            if (categories != null) {
                for (String category : categories) {
                    ps.setString(paramIndex++, category);
                }
            }

            // Gán các giá trị lọc thương hiệu
            if (brands != null) {
                for (String brand : brands) {
                    ps.setString(paramIndex++, brand);
                }
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public List<Product> searchProducts(String query, String category) {
        List<Product> products = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale\n"
                    + "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE (p.ProductName LIKE ? OR p.Description LIKE ?)");

            if (category != null && !category.isEmpty()) {
                sql.append(" AND c.CategoryName = ?");
            }

            PreparedStatement ps = c.prepareStatement(sql.toString());
            String searchPattern = "%" + query + "%"; // Tạo mẫu tìm kiếm với wildcard
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

            if (category != null && !category.isEmpty()) {
                ps.setString(3, category); // Thêm category vào PreparedStatement
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public void addProduct(Product product) {
        String query = "INSERT INTO Products (\n"
                + "    ProductName, \n"
                + "    Description, \n"
                + "    Price, \n"
                + "    Stock, \n"
                + "    CategoryID, \n"
                + "    ImageURL, \n"
                + "    CreatedDate, \n"
                + "    Sale, \n"
                + "    brand\n"
                + ") VALUES (\n"
                + "    ?, \n"
                + "    ?, \n"
                + "    ?, \n"
                + "    ?, \n"
                + "    ?, \n"
                + "    ?, \n"
                + "    GETDATE(),  -- Tự động lấy thời gian hiện tại\n"
                + "    ?, \n"
                + "    ?\n"
                + ");";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setInt(5, getCategoryIdByName(product.getCategoryName())); // Lấy CategoryID từ tên
            ps.setString(6, product.getImageURL());
            ps.setInt(7, product.getSale());
            ps.setString(8, product.getBrand());
            if (product.getSale() > 0) {
                double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
            }
            ps.executeUpdate();
            // Lấy ProductID vừa tạo để thêm hình ảnh
            String getLastInsertedIdQuery = "SELECT @@IDENTITY AS ProductID"; // Sử dụng @@IDENTITY để lấy ID vừa tạo
            PreparedStatement idStmt = c.prepareStatement(getLastInsertedIdQuery);
            ResultSet rs = idStmt.executeQuery();
            int productId = 0;
            if (rs.next()) {
                productId = rs.getInt("ProductID");
            }

            // Thêm hình ảnh vào bảng ProductImages
            String insertedImgDetailQuery = "INSERT INTO [dbo].[ProductImages]\n"
                    + "           ([ProductID]\n"
                    + "           ,[ImageURL])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement imgDetailStmt = c.prepareStatement(insertedImgDetailQuery);
            for (String imageUrl : product.getImageURLDetail()) {
                imgDetailStmt.setInt(1, productId);
                imgDetailStmt.setString(2, imageUrl);
                imgDetailStmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateProduct(Product product) {
        String query = "UPDATE Products SET \n"
                + "    ProductName = ?, \n"
                + "    Description = ?, \n"
                + "    Price = ?, \n"
                + "    Stock = ?, \n"
                + "    CategoryID = ?, \n"
                + "    ImageURL = ?, \n"
                + "    Sale = ?, \n"
                + "    brand = ? \n"
                + "WHERE ProductID = ?;";

        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getStock());
            ps.setInt(5, getCategoryIdByName(product.getCategoryName())); // Lấy CategoryID từ tên
            ps.setString(6, product.getImageURL());
            ps.setInt(7, product.getSale());
            ps.setString(8, product.getBrand());
            ps.setInt(9, product.getProductID()); // Thêm ID sản phẩm để xác định bản ghi cần cập nhật

            ps.executeUpdate();

            // Cập nhật hình ảnh nếu có
            String deleteImagesQuery = "DELETE FROM ProductImages WHERE ProductID = ?";
            PreparedStatement deleteStmt = c.prepareStatement(deleteImagesQuery);
            deleteStmt.setInt(1, product.getProductID());
            deleteStmt.executeUpdate();

            for (String imageUrl : product.getImageURLDetail()) {
                String insertImageQuery = "INSERT INTO ProductImages(ProductID, ImageURL) VALUES (?, ?)";
                PreparedStatement insertStmt = c.prepareStatement(insertImageQuery);
                insertStmt.setInt(1, product.getProductID());
                insertStmt.setString(2, imageUrl);
                insertStmt.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getTotalProductSold(int productID) {
        int totalSold = 0;
        try {
            String query = "SELECT COALESCE(SUM(Quantity), 0) AS TotalSold FROM OrderDetails WHERE ProductID = ?";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalSold = rs.getInt("TotalSold");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSold;
    }

    @Override
    public void deleteProduct(int productId) {
        String query = "INSERT INTO DeletedProducts (ProductID, ProductName, Description, Price, Stock, CategoryID, "
                + "ImageURL, CreatedDate, Sale, Brand) "
                + "SELECT ProductID, ProductName, Description, Price, Stock, CategoryID, ImageURL, CreatedDate, "
                + "Sale, Brand FROM Products WHERE ProductID = ?";
        // Xóa sản phẩm khỏi bảng Products
        String deleteQuery = "DELETE FROM Products WHERE ProductID = ?";

        // Chuyển tất cả ảnh của sản phẩm vào thùng rác
        String queryImgTrash = "INSERT INTO DeletedProductImages (ProductID, ImageURL, DeletedDate) "
                + "SELECT ProductID, ImageURL, GETDATE() FROM ProductImages WHERE ProductID = ?";
        String deleteImgQuery = "DELETE FROM ProductImages WHERE ProductID = ?";

        try {
            // Bắt đầu giao dịch
            c.setAutoCommit(false);

            // Chèn ảnh vào bảng DeletedProductImages trước
            try (PreparedStatement psInsertImgTrash = c.prepareStatement(queryImgTrash); PreparedStatement psDeleteImg = c.prepareStatement(deleteImgQuery); PreparedStatement ps = c.prepareStatement(query); PreparedStatement deletePs = c.prepareStatement(deleteQuery)) {

                // Chèn ảnh vào DeletedProductImages
                psInsertImgTrash.setInt(1, productId);
                psInsertImgTrash.executeUpdate();

                // Xóa ảnh khỏi bảng ProductImages
                psDeleteImg.setInt(1, productId);
                psDeleteImg.executeUpdate();

                // Chèn sản phẩm vào bảng DeletedProducts
                ps.setInt(1, productId);
                ps.executeUpdate();

                // Xóa sản phẩm khỏi bảng Products
                deletePs.setInt(1, productId);
                deletePs.executeUpdate();
            }

            // Hoàn tất giao dịch
            c.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Nếu có lỗi, rollback giao dịch
                c.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                c.setAutoCommit(true); // Đảm bảo cài đặt lại chế độ tự động commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void deleteTrash(int productId) {
        // Xóa sản phẩm khỏi bảng Products
        String query = "DELETE FROM DeletedProducts WHERE ProductID = ?";
        String queryImg = "DELETE FROM DeletedProductImages WHERE ProductID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            PreparedStatement psImg = c.prepareStatement(queryImg);
            ps.setInt(1, productId);
            ps.executeUpdate();
            psImg.setInt(1, productId);
            psImg.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy danh sách sản phẩm đã bị xóa
    @Override
    public List<Product> getDeletedProducts() {
        List<Product> deletedProducts = new ArrayList<>();
        String query = "SELECT d.ProductID, d.ProductName, d.Description, d.Price, d.Stock, c.CategoryName, d.ImageURL, d.CreatedDate, d.Sale, d.Brand \n"
                + "FROM DeletedProducts d\n"
                + "JOIN Categories c ON d.CategoryID = c.CategoryID ";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                product.setCreatedDate(rs.getDate("CreatedDate"));
                deletedProducts.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deletedProducts;
    }

    // Phương thức khôi phục sản phẩm từ thùng rác
    @Override
    public void restoreProduct(int productId) {
        String query = "SET IDENTITY_INSERT Products ON\n"
                + "INSERT INTO Products (ProductID, ProductName, Description, Price, Stock, CategoryID, ImageURL, CreatedDate, Sale, Brand) "
                + "SELECT ProductID, ProductName, Description, Price, Stock, CategoryID, ImageURL, CreatedDate, Sale, Brand FROM DeletedProducts "
                + "WHERE ProductID = ?";

        String deleteQuery = "DELETE FROM DeletedProducts WHERE ProductID = ?\n"
                + "SET IDENTITY_INSERT Products OFF";

        // Chuyển tất cả ảnh của sản phẩm vào thùng rác
        String queryImgInsert = "INSERT INTO ProductImages (ProductID, ImageURL) "
                + "SELECT ProductID, ImageURL FROM DeletedProductImages WHERE ProductID = ?";
        String deleteImgQuery = "DELETE FROM DeletedProductImages WHERE ProductID = ?";

        try {
            // Bắt đầu giao dịch
            c.setAutoCommit(false);

            // Thực hiện các câu lệnh
            try (PreparedStatement ps = c.prepareStatement(query); PreparedStatement deletePs = c.prepareStatement(deleteQuery); PreparedStatement psInsertImg = c.prepareStatement(queryImgInsert); PreparedStatement deleteImgPs = c.prepareStatement(deleteImgQuery)) {

                // Chèn sản phẩm vào bảng Products
                ps.setInt(1, productId);
                ps.executeUpdate();

                // Xóa sản phẩm khỏi bảng DeletedProducts
                deletePs.setInt(1, productId);
                deletePs.executeUpdate();

                // Chèn hình ảnh vào bảng ProductImages
                psInsertImg.setInt(1, productId);
                psInsertImg.executeUpdate();

                deleteImgPs.setInt(1, productId);
                deleteImgPs.executeUpdate();
            }

            // Hoàn tất giao dịch
            c.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Nếu có lỗi, rollback giao dịch
                c.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                c.setAutoCommit(true); // Đảm bảo cài đặt lại chế độ tự động commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.Brand, p.Sale, p.CreatedDate, p.AverageRating "
                + "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.ProductID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL")); // Ảnh chính của sản phẩm
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));
                product.setCreatedDate(rs.getDate("CreatedDate")); // Sử dụng Date cho createdDate
                product.setAverageRating(rs.getDouble("AverageRating"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                // Lấy hình ảnh chi tiết của sản phẩm
                List<String> imageDetails = getProductImagesById(id);
                product.setImageURLDetail(imageDetails); // Giả sử bạn đã có phương thức để lấy danh sách hình ảnh
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    // Phương thức để lấy hình ảnh của sản phẩm theo ID

    @Override
    public List<Integer> getProductRatings(int productID) {
        List<Integer> ratingsCount = new ArrayList<>();
        
        // SQL để đếm số lượng đánh giá cho từng rating (1, 2, 3, 4, 5)
        String sql = "SELECT "
                   + "SUM(CASE WHEN Rating = 1 THEN 1 ELSE 0 END) AS Rating1Count, "
                   + "SUM(CASE WHEN Rating = 2 THEN 1 ELSE 0 END) AS Rating2Count, "
                   + "SUM(CASE WHEN Rating = 3 THEN 1 ELSE 0 END) AS Rating3Count, "
                   + "SUM(CASE WHEN Rating = 4 THEN 1 ELSE 0 END) AS Rating4Count, "
                   + "SUM(CASE WHEN Rating = 5 THEN 1 ELSE 0 END) AS Rating5Count "
                   + "FROM [ProjectSWP].[dbo].[Reviews] "
                   + "WHERE ProductID = ? "
                   + "GROUP BY ProductID";
        
        try (PreparedStatement stmt = c.prepareStatement(sql)) {
            
            // Set parameter for the SQL query
            stmt.setInt(1, productID);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Add each rating count to the list
                    ratingsCount.add(rs.getInt("Rating1Count"));
                    ratingsCount.add(rs.getInt("Rating2Count"));
                    ratingsCount.add(rs.getInt("Rating3Count"));
                    ratingsCount.add(rs.getInt("Rating4Count"));
                    ratingsCount.add(rs.getInt("Rating5Count"));
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return ratingsCount;
    }
    
    private List<String> getProductImagesById(int productId) {
        List<String> imageUrls = new ArrayList<>();
        String query = "SELECT ImageURL FROM ProductImages WHERE ProductID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                imageUrls.add(rs.getString("ImageURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imageUrls;
    }

    @Override
    public int getCategoryIdByName(String categoryName) {
        int categoryId = -1; // Giá trị mặc định nếu không tìm thấy
        String query = "SELECT CategoryID FROM Categories WHERE CategoryName = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                categoryId = rs.getInt("CategoryID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryId;
    }

    @Override
    public List<Product> getRelativeProducts(String category) {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT TOP(4) p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale\n"
                    + "FROM Products p\n"
                    + "INNER JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE c.CategoryName = ?";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName")); // Kiểm tra cột này
                product.setBrand(rs.getString("brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public List<Product> getMostSoldProducts(String categoryName) {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT TOP(6)\n"
                    + "    c.CategoryID,\n"
                    + "    c.CategoryName,\n"
                    + "    p.ProductID,\n"
                    + "    p.ProductName,\n"
                    + "	p.Price, p.Description, p.Price, p.Stock, p.ImageURL, p.brand, p.Sale,\n"
                    + "    COALESCE(SUM(od.Quantity), 0) AS TotalSold\n"
                    + "FROM Products p\n"
                    + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n"
                    + "WHERE c.CategoryName = ?\n"
                    + "GROUP BY c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.Price, p.Description, p.Price, p.Stock, p.ImageURL, p.brand, p.Sale\n"
                    + "ORDER BY c.CategoryID, TotalSold DESC;";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setDescription(rs.getString("Description"));
                product.setPrice(rs.getDouble("Price"));
                product.setStock(rs.getInt("Stock"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName")); // Kiểm tra cột này
                product.setBrand(rs.getString("brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public static void main(String[] args) {
        ProductDAO p = new ProductDAO();
        List<Product> list = p.getMostSoldProducts("Sneaker");
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i)); 
        }
    }

}
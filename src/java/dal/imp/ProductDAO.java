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
import java.sql.Connection;
import model.User;
import java.util.HashMap;
import java.util.Map;
import model.ProductVariant;

/**
 *
 * @author nguye
 */
public class ProductDAO extends DBConnect implements IProductDAO {

    @Override
    public List<Product> getSaleProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale, p.AverageRating\n"
                    + "FROM Products p\n"
                    + "INNER JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE p.Sale != 0 AND p.isDeleted = 0";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            // Phần còn lại giữ nguyên
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
                product.setAverageRating(rs.getDouble("AverageRating"));
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
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale, p.CreatedDate, p.AverageRating\n"
                    + "FROM Products p\n"
                    + "JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE p.isDeleted = 0";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            // Phần còn lại giữ nguyên
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
                product.setAverageRating(rs.getDouble("AverageRating"));
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
            StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, p.AverageRating, \n"
                    + "                    c.CategoryName, p.Brand, p.Sale, p.Price * (1 - p.Sale / 100.0) AS SalePrice\n"
                    + "                    FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "                    WHERE p.Price BETWEEN ? AND ? AND p.isDeleted = 0");

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
                product.setAverageRating(rs.getDouble("AverageRating"));
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
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.Price BETWEEN ? AND ? AND p.isDeleted = 0");

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
                    + "WHERE (p.ProductName LIKE ? OR p.Description LIKE ?) AND p.isDeleted = 0");

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
            String query = "SELECT COALESCE(SUM(Quantity), 0) AS TotalSold FROM OrderDetails WHERE ProductID = ? AND p.isDeleted = 0";
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
        String query = "UPDATE Products SET isDeleted = 1 WHERE ProductID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phương thức lấy danh sách sản phẩm đã bị xóa
    @Override
    public List<Product> getDeletedProducts() {
        List<Product> deletedProducts = new ArrayList<>();
        String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, c.CategoryName, p.ImageURL, p.CreatedDate, p.Sale, p.Brand \n"
                + "FROM Products p\n"
                + "JOIN Categories c ON p.CategoryID = c.CategoryID \n"
                + "WHERE p.isDeleted = 1";

        try {
            PreparedStatement stmt = c.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
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
                product.setCreatedDate(rs.getDate("CreatedDate"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Làm tròn đến 2 chữ số thập phân
                }
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
        String query = "UPDATE Products SET isDeleted = 0 WHERE ProductID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.Brand, p.Sale, p.CreatedDate, p.AverageRating "
                + "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.ProductID = ? AND p.isDeleted = 0";
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
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));
                product.setCreatedDate(rs.getDate("CreatedDate"));
                product.setAverageRating(rs.getDouble("AverageRating"));
                if (product.getSale() > 0) {
                    double salePrice = product.getPrice() * ((100 - product.getSale()) / 100.0);
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0);
                }
                List<String> imageDetails = getProductImagesById(id);
                product.setImageURLDetail(imageDetails);
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
            String query = "SELECT TOP(4) p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale, p.AverageRating\n"
                    + "FROM Products p\n"
                    + "INNER JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                    + "WHERE c.CategoryName = ? AND p.isDeleted = 0";
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
                product.setAverageRating(rs.getDouble("AverageRating"));
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
                    + "WHERE c.CategoryName = ? AND p.isDeleted = 0\n"
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

    public List<Product> getProductsForPage(int offset, int limit, String[] categories, String[] brands) {
        List<Product> products = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, "
                    + "c.CategoryName, p.Brand, p.Sale, p.Price * (1 - p.Sale / 100.0) AS SalePrice "
                    + "FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID"
                    + "ORDER by p.CreatedDate DESC"
            );

            List<Object> params = new ArrayList<>();

            // Add category filter
            if (categories != null && categories.length > 0) {
                sql.append(" AND c.CategoryName IN (");
                for (int i = 0; i < categories.length; i++) {
                    sql.append(i > 0 ? ", ?" : "?");
                    params.add(categories[i]);
                }
                sql.append(")");
            }

            // Add brand filter
            if (brands != null && brands.length > 0) {
                sql.append(" AND p.Brand IN (");
                for (int i = 0; i < brands.length; i++) {
                    sql.append(i > 0 ? ", ?" : "?");
                    params.add(brands[i]);
                }
                sql.append(")");
            }

            // Add pagination
            sql.append(" ORDER BY p.ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add(limit);
            params.add(offset);

            // Prepare and execute the query
            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));

                // Calculate sale price
                if (product.getSale() > 0) {
                    double salePrice = rs.getDouble("SalePrice");
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0); // Round to 2 decimal places
                } else {
                    product.setSalePrice(product.getPrice());
                }

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProductsByTable(String tableName, int offset, int limit, String[] categories, String[] brands, String search) {
        List<Product> products = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, "
                    + "c.CategoryName, p.Brand, p.Sale, p.CreatedDate, p.Price * (1 - p.Sale / 100.0) AS SalePrice "
                    + "FROM " + tableName + " p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.isDeleted = 0 AND 1=1");

            List<Object> params = new ArrayList<>();

            if (search != null && !search.isEmpty()) {
                sql.append(" AND (p.ProductName LIKE ? OR p.Description LIKE ?)");
                params.add("%" + search + "%");
                params.add("%" + search + "%");
            }

            if (categories != null && categories.length > 0) {
                sql.append(" AND UPPER(c.CategoryName) IN (");
                for (int i = 0; i < categories.length; i++) {
                    sql.append(i > 0 ? ", UPPER(?)" : "UPPER(?)");
                    params.add(categories[i]);
                }
                sql.append(")");
            }

            if (brands != null && brands.length > 0) {
                sql.append(" AND p.Brand IN (");
                for (int i = 0; i < brands.length; i++) {
                    sql.append(i > 0 ? ", ?" : "?");
                    params.add(brands[i]);
                }
                sql.append(")");
            }

            sql.append(" ORDER BY p.CreatedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
            params.add(offset);
            params.add(limit);

            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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
                product.setBrand(rs.getString("Brand"));
                product.setSale(rs.getInt("Sale"));
                if (product.getSale() > 0) {
                    double salePrice = rs.getDouble("SalePrice");
                    product.setSalePrice(Math.round(salePrice * 100.0) / 100.0);
                } else {
                    product.setSalePrice(product.getPrice());
                }
                product.setCreatedDate(rs.getDate("CreatedDate"));
                products.add(product);
            }
            System.out.println("SQL: " + sql.toString() + ", Offset: " + offset + ", Limit: " + limit + ", Products returned: " + products.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Count total products for pagination
    public int countProductsByTable(String tableName, String category, String brand, String search) {
        int count = 0;
        try {
            StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM " + tableName + " p JOIN Categories c ON p.CategoryID = c.CategoryID WHEREp.isDeleted = 0 AND 1=1");
            List<Object> params = new ArrayList<>();

            if (search != null && !search.isEmpty()) {
                sql.append(" AND (p.ProductName LIKE ? OR p.Description LIKE ?)");
                params.add("%" + search + "%");
                params.add("%" + search + "%");
            }

            if (category != null && !category.isEmpty()) {
                sql.append(" AND UPPER(c.CategoryName) = UPPER(?)");
                params.add(category);
            }

            if (brand != null && !brand.isEmpty()) {
                sql.append(" AND UPPER(p.Brand) = UPPER(?)");
                params.add(brand);
            }

            PreparedStatement ps = c.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    // Get all categories for filter dropdown
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT CategoryName FROM Categories ORDER BY CategoryName";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("CategoryName"));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving categories: " + e.getMessage());
        }

        return categories;
    }

    // Get all brands for filter dropdown
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT brand FROM Products ORDER BY brand";

        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving brands: " + e.getMessage());
        }

        return brands;
    }

    public List<ProductVariant> getProductVariantsByProductId(int productId) {
        List<ProductVariant> variants = new ArrayList<>();
        String sql = "SELECT pv.VariantID, pv.ProductID, c.ColorName, s.SizeName, pv.Stock "
                + "FROM ProductVariants pv "
                + "JOIN Colors c ON pv.ColorID = c.ColorID "
                + "JOIN Sizes s ON pv.SizeID = s.SizeID "
                + "WHERE pv.ProductID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductVariant variant = new ProductVariant(
                        rs.getInt("VariantID"),
                        rs.getInt("ProductID"),
                        rs.getString("ColorName"),
                        rs.getString("SizeName"),
                        rs.getInt("Stock")
                );
                variants.add(variant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return variants;
    }

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();
        int offset = 0;                    // Bắt đầu từ bản ghi đầu tiên
        int limit = 100;                   // Lấy tối đa 100 sản phẩm
        String orderBy = "ProductName ASC"; // Sắp xếp theo tên sản phẩm A-Z
        String[] categories = null;        // Không lọc danh mục
        String[] brands = null;            // Không lọc thương hiệu
        double priceMin = 50000;           // Giá tối thiểu 50,000 VNĐ
        double priceMax = 50000000;          // Giá tối đa 500,000 VNĐ

        List<Product> products = productDAO.getProductsByPage(offset, limit, orderBy, categories, brands, priceMin, priceMax);
        for (Product p : products) {
            System.out.println(p.getProductName() + " - " + p.getPrice());
        }
    }

}
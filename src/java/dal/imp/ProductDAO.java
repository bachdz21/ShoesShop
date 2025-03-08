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
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import model.Product;
import model.User;
import java.util.HashMap;
import java.util.Map;
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
    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.Brand, p.Sale, p.CreatedDate "
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

    public List<Product> getRelativeProducts(String category) {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT p.ProductID, p.ProductName, p.Description, p.Price, p.Stock, p.ImageURL, c.CategoryName, p.brand, p.Sale\n"
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

    public static void main(String[] args) {
        ProductDAO u = new ProductDAO();

        List<Product> relative = u.getRelativeProducts("Sneakers");
        for (Product product : relative) {
            System.out.println(product.toString());

        }
    }

}

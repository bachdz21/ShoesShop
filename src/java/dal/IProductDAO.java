/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.ProductVariant;
import model.User;

/**
 *
 * @author nguye
 */
public interface IProductDAO {
    List<Product> getSaleProducts();
    List<Product> getAllProducts();
    List<Product> getProductsByPage(int offset, int limit, String orderBy, String[] categories, String[] brands, double priceMin, double priceMax);
    int getTotalProducts(String[] categories, String[] brands, double priceMin, double priceMax);
    List<Product> searchProducts(String query, String category);
    void addProduct(Product product);
    Product getProductById(int id);
    int getTotalProductSold(int productID);
    int getCategoryIdByName(String categoryName);
    void updateProduct(Product product);
    void deleteProduct(int id);
    List<Product> getDeletedProducts();
    void restoreProduct(int productId);
    void deleteTrash(int productId);
    List<Product> getRelativeProducts(String category);
    List<Product> getMostSoldProducts(String categoryName);
    List<Integer> getProductRatings(int productID);
    List<ProductVariant> getProductVariantsByProductId(int productId);
}

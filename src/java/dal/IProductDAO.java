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
    Product getProductById(int id);
    int getTotalProductSold(int productID);
    int getCategoryIdByName(String categoryName);
    
    List<Product> getRelativeProducts(String category);
   
}

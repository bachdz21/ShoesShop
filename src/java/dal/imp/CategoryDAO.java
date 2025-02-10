/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.ICategoryDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author nguye
 */
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

    public static void main(String[] args) {
        CategoryDAO u = new CategoryDAO();
        List<Category> list = u.getAllCategories();
        System.out.println("List Sale:");
        for (Category category : list) {
            System.out.println(category.toString());
        }

    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Category;

/**
 *
 * @author nguye
 */
public interface ICategoryDAO {
    List<Category> getAllCategories();
    List<Category> getDisplayedCategories();
    void updateDisplayedCategories(List<Integer> selectedCategoryIds);
    void syncSelectedCategories();
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Review;

/**
 *
 * @author nguye
 */
public interface IReviewDAO {
    int addReview(Review review);
    List<Review> getReviewsByProductID(int productID);
}

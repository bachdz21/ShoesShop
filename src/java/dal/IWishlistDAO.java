/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.WishlistItem;

/**
 *
 * @author nguye
 */
public interface IWishlistDAO {
    void addWishlistItem(int userId, int productId);
    List<WishlistItem> getWishlistItems(int userId);
    void deleteWishlistItem(int wishlistId, int productId);
}

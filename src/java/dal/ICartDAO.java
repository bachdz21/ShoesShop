/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Cart;
import model.CartItem;

/**
 *
 * @author nguye
 */
public interface ICartDAO {
    void addCartItem(int userId, int productId, int quantity);
    List<CartItem> getCartItems(int userId);
    void updateCartItemQuantity(int cartItemId, int newQuantity);
    void deleteCartItem(int cartId, int productId);
    void clearCart(int userId);
    List<CartItem> getCartItemsTrash(int userId);
    void deleteTrashCartItem(int userId, int productId);
    void restoreCartItemTrash(int userId, int productId);
    void clearCartForever(int userId);
    void updateQuantityInCart(int userID, int productId, int quantity);
    void addCartItemWithVariant(int userId, int productId, int quantity, String size, String color);
}

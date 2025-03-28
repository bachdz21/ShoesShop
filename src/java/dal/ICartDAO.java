package dal;

import java.util.List;
import model.CartItem;

public interface ICartDAO {
    void addCartItem(int userId, int productId, int quantity);
    List<CartItem> getCartItems(int userId);
    void updateCartItemQuantity(int cartItemId, int newQuantity);
    void clearCart(int userId);
    void clearCartForever(int userId);
    List<CartItem> getCartItemsTrash(int userId);
    void updateQuantityInCart(int userID, int productId, int quantity);
    void deleteMultipleCartItems(int userId, List<Integer> productIds);
    void deleteMultipleTrashCartItems(int userId, List<Integer> productIds);
    void restoreMultipleCartItemsTrash(int userId, List<Integer> productIds);
    void addCartItemWithVariant(int userId, int productId, int quantity, String size, String color);
}

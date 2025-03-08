/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Order;
import model.Product;

/**
 *
 * @author nguye
 */
public interface IOrderDAO {
    int checkout(int userId, String fullName, String email, String phoneNumber, String shippingAddress, String paymentMethod, String note);
    String getOrderCodeByOrderID(int orderId);
    List<Order> getOrdersByUserId(int userId);
    List<Product> getProductForDetailOrdersByOderId(int oderId);
    List<Order> getDetailOrderByOderId(int oderId);
    List<Order> getAllOrders();
    boolean updateOrderStatus(int orderId, String orderStatus);
    List<Product> getProductsByOrderID(int orderID);
}

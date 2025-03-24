/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dal;

import java.util.List;
import model.Shipping;

/**
 *
 * @author Admin
 */
public interface IShippingDAO {
    Integer getUserIDInShippingByOrderID(int orderID);
    List<Shipping> getListShippingByOrderID(int orderID);
    boolean addStatusShippingByOrderID(int orderID, String shippingStatus, int userID,String orderStatus);
}

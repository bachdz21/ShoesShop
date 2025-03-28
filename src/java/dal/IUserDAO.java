/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.CartStat;
import model.OrderContact;
import model.ReviewStat;
import model.User;
import model.WishlistStat;

/**
 *
 * @author nguye
 */
public interface IUserDAO {

    List<String> getAllEmails();
    List<String> getAllUsernames();
    List<String> getAllPhoneNumbers();
    List<User> getLockedUsers();
    List<User> getAllUsers();
    void addUser(User u);
    User login(String username, String password);
    User getUserByUsername(String username);
    boolean checkEmailExists(String userEmail);
    boolean checkUsernameExists(String userEmail);
    //checkUsernameExists
    void saveResetCode(String userEmail, String resetCode);
    boolean isResetCodeValid(String resetCode);
    void updatePassword(String resetCode, String newPassword);
    User getUserById(Integer userId);
    void updateUser(User u);
    void changePassword(int userId, String newPassword);
    void isLocked(int userId);
    void isUnlocked(int userId);
    public OrderContact getOrderContactsByOrderID(int orderID);
    List<User> filterUsers(String username, String fullName, String email, String phone, 
        String minRegistrationDate, String maxRegistrationDate, Integer minDelivered, Integer maxDelivered, 
        Integer minCancelled, Integer maxCancelled);
    List<User> filterBanUsers(String username, String fullName, String email, String phone, 
        String minRegistrationDate, String maxRegistrationDate, Integer minDelivered, Integer maxDelivered, 
        Integer minCancelled, Integer maxCancelled) ;
    List<WishlistStat> getWishlistStats(String startDate, String endDate);
    List<ReviewStat> getReviewStats(String startDate, String endDate);
    List<User> getNewCustomers(int limit);
    List<User> getActiveCustomers(String search, String startDate, String endDate, String sortBy);
}

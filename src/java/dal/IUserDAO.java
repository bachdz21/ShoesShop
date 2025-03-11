/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.User;

/**
 *
 * @author nguye
 */
public interface IUserDAO {
    List<User> getAllUsers();
    void addUser(User u);
    User login(String username, String password);
    User getUserByUsername(String username);
    boolean checkEmailExists(String userEmail);
    void saveResetCode(String userEmail, String resetCode);
    boolean isResetCodeValid(String resetCode);
    void updatePassword(String resetCode, String newPassword);
    User getUserById(Integer userId);
    void updateUser(User u);
    void changePassword(int userId, String newPassword);
}

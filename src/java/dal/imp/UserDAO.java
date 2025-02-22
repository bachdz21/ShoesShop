/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import dal.DBConnect;
import dal.IUserDAO;
import utils.Encryption;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.sql.*;
import java.time.LocalDateTime;

// Vì class này thực hiện thao tác trên database => Ta phải có 1 cái connections => kết nối đến database
import java.util.*;
import model.User;

// UserDAO => Đã có connections
public class UserDAO extends DBConnect implements IUserDAO {
    
    Encryption e = new Encryption();
    // Method : Đọc dữ liệu có trong bảng User từ database lên Java
    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users";

        try (PreparedStatement stmt = c.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setRegistrationDate(rs.getDate("RegistrationDate"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        return users;
    }

    @Override
    public void addUser(User u) {
        String query = "INSERT INTO Users (Username, Password, FullName, Email, PhoneNumber, Address, Role, RegistrationDate) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, u.getUsername());
            stmt.setString(2, u.getPassword());
            stmt.setString(3, u.getFullName());
            stmt.setString(4, u.getEmail());
            stmt.setString(5, u.getPhoneNumber());
            stmt.setString(6, u.getAddress());
            stmt.setString(7, u.getRole());

            stmt.executeUpdate(); // Thực hiện câu lệnh thêm

        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
    }

    @Override
    public User login(String username, String password) {
        String query = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
        User user = null;
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID")); // Đảm bảo tên cột đúng với tên trong cơ sở dữ liệu
                user.setFullName(rs.getString("FullName"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password")); // Nên mã hóa mật khẩu thay vì lưu trữ trực tiếp
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setRegistrationDate(rs.getDate("RegistrationDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        return user; // Trả về user nếu đăng nhập thành công, ngược lại trả về null
    }

    @Override
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM Users WHERE Username = ?";
        User user = null;

        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getString("Role"));
                user.setRegistrationDate(rs.getDate("RegistrationDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user; // Trả về user nếu tìm thấy, ngược lại trả về null
    }

    public boolean checkEmailExists(String userEmail) {
        String query = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, userEmail);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void saveResetCode(String userEmail, String resetCode) {
        String query = "UPDATE Users SET ResetCode = ? WHERE Email = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, resetCode);
            stmt.setString(2, userEmail);

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean isResetCodeValid(String resetCode) {
        String sql = "SELECT COUNT(*) FROM Users WHERE reset_code = ? AND reset_code_expiration > NOW()";
        try (PreparedStatement ps = c.prepareStatement(sql);) {
            ps.setString(1, resetCode);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    // Thêm hàm để cập nhật mật khẩu
    public void updatePassword(String resetCode, String newPassword) {
        String sql = "UPDATE Users SET Password = ?, ResetCode = NULL WHERE ResetCode = ?";
        try (PreparedStatement ps = c.prepareStatement(sql);) {
            ps.setString(1, newPassword);
            ps.setString(2, resetCode);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User getUserById(Integer userId) {
        User user = null;
        String query = "SELECT * FROM Users WHERE UserID = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddress(rs.getString("Address"));
                user.setProfileImageURL(rs.getString("ProfileImageURL"));
                user.setRole(rs.getString("Role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void updateUser(User u) {
        try {
            StringBuilder sql = new StringBuilder("UPDATE Users SET ");
            List<Object> params = new ArrayList<>(); // Danh sách lưu trữ các tham số

            if (u.getFullName() != null) {
                sql.append("FullName = ?, ");
                params.add(u.getFullName()); // Thêm tham số vào danh sách
            }
            if (u.getEmail() != null) {
                sql.append("Email = ?, ");
                params.add(u.getEmail());
            }
            if (u.getPhoneNumber() != null) {
                sql.append("PhoneNumber = ?, ");
                params.add(u.getPhoneNumber());
            }
            if (u.getAddress() != null) {
                sql.append("Address = ?, ");
                params.add(u.getAddress());
            }
            if (u.getProfileImageURL() != null) {
                sql.append("ProfileImageURL = ?, ");
                params.add(u.getProfileImageURL());
            }

            // Xóa dấu phẩy cuối cùng và thêm điều kiện WHERE
            sql.setLength(sql.length() - 2); // Xóa ", "
            sql.append(" WHERE UserID = ?");
            params.add(u.getUserId()); // Thêm UserID vào danh sách

            PreparedStatement stmt = c.prepareStatement(sql.toString());

            // Thiết lập các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i)); // Thiết lập tham số
            }

            stmt.executeUpdate(); // Thực hiện câu lệnh thêm

        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
    }
    
    @Override
    public void changePassword(int userId, String newPassword) {
        String query = "UPDATE Users SET Password = ? WHERE UserID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        Encryption e = new Encryption();
        UserDAO ud = new UserDAO();
        User u = new User();
//        u.setProfileImageURL("https://images2.thanhnien.vn/528068263637045248/2024/1/25/e093e9cfc9027d6a142358d24d2ee350-65a11ac2af785880-17061562929701875684912.jpg");

//        List<User> user = ud.getAllUsers();
//        for (User user1 : user) {
//            ud.changePassword(user1.getUserId(), e.getMd5(user1.getPassword()));
//        }
////      
        System.out.println(e.getMd5("9824"));
//        ud.changePassword(user.get(11).getUserId(), user.get(11).getPassword());
    }

}

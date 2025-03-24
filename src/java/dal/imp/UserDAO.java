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
import model.Order;
import model.OrderContact;
import model.User;

// UserDAO => Đã có connections
public class UserDAO extends DBConnect implements IUserDAO {

    @Override
    public List<String> getAllEmails() {
        List<String> emails = new ArrayList<>();
        String sql = "SELECT Email FROM Users"; // Chắc chắn rằng 'Users' là tên bảng và 'Email' là tên cột
        try (PreparedStatement stmt = c.prepareStatement(sql); // Sử dụng kết nối từ 'c'
                 ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                emails.add(rs.getString("Email"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có
        }
        return emails;
    }

    @Override
    public List<String> getAllUsernames() {
        List<String> usernames = new ArrayList<>();
        String sql = "SELECT Username FROM Users"; // Kiểm tra danh sách username
        try (PreparedStatement stmt = c.prepareStatement(sql); // Sử dụng kết nối từ 'c'
                 ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                usernames.add(rs.getString("Username"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có
        }
        return usernames;
    }

    @Override
    public List<String> getAllPhoneNumbers() {
        List<String> phoneNumbers = new ArrayList<>();
        String sql = "SELECT PhoneNumber FROM Users"; // Chắc chắn rằng 'Users' là tên bảng và 'PhoneNumber' là tên cột
        try (PreparedStatement stmt = c.prepareStatement(sql); // Sử dụng kết nối từ 'c'
                 ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                phoneNumbers.add(rs.getString("PhoneNumber"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In lỗi nếu có
        }
        return phoneNumbers;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE locked = 0";  // Lọc những người dùng chưa bị khóa

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
                user.setLocked(rs.getInt("locked")); // Lưu trạng thái locked
                // Lấy danh sách đơn hàng của người dùng và gán vào thuộc tính 'orders'
                ArrayList<Order> orders = getOrdersByUserId(user.getUserId());
                user.setOrders(orders);

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
        String query = "SELECT * FROM Users WHERE Username = ? AND Password = ? AND locked = 0";
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
                user.setLocked(rs.getInt("locked")); // Lưu trạng thái locked
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

    @Override
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
    public boolean checkUsernameExists(String username) {
        String query = "SELECT COUNT(*) FROM Users WHERE Username = ?";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;  // Nếu có kết quả, tức là username đã tồn tại
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Nếu không có kết quả, tức là username không tồn tại
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
            if (u.getRole() != null) {
                sql.append("Role = ?, ");
                params.add(u.getRole());
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

    @Override
    public List<User> getLockedUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE locked = 1";  // Lọc những người dùng bị khóa

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
                user.setLocked(rs.getInt("locked")); // Lưu trạng thái locked

                // Lấy danh sách đơn hàng của người dùng và gán vào thuộc tính 'orders'
                ArrayList<Order> orders = getOrdersByUserId(user.getUserId());
                user.setOrders(orders);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        return users;
    }

    // Lấy danh sách đơn hàng của người dùng theo UserID
    private ArrayList<Order> getOrdersByUserId(int userId) {
        ArrayList<Order> orders = new ArrayList<>();  // Thay List bằng ArrayList
        String query = "SELECT * FROM Orders WHERE UserID = ?";

        try (PreparedStatement pstmt = c.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                orders.add(order);  // Thêm đơn hàng vào ArrayList
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;  // Trả về ArrayList<Order>
    }

    @Override
    public void isLocked(int userId) {
        String query = "UPDATE Users SET locked = 1 WHERE UserID = ?"; // Cập nhật trạng thái khóa tài khoản
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void isUnlocked(int userId) {
        String query = "UPDATE Users SET locked = 0 WHERE UserID = ?"; // Cập nhật trạng thái mở khóa tài khoản
        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> filterUsers(String username, String fullName, String email, String phone, String registrationDate) {
        List<User> users = new ArrayList<>();

        // Bắt đầu xây dựng câu truy vấn SQL với điều kiện cơ bản là lọc người dùng chưa bị khóa
        StringBuilder query = new StringBuilder("SELECT * FROM Users WHERE locked = 0");

        // Thêm các điều kiện tìm kiếm vào câu truy vấn
        if (username != null && !username.isEmpty()) {
            query.append(" AND Username LIKE ?");
        }
        if (fullName != null && !fullName.isEmpty()) {
            query.append(" AND FullName LIKE ?");
        }
        if (email != null && !email.isEmpty()) {
            query.append(" AND Email LIKE ?");
        }
        if (phone != null && !phone.isEmpty()) {
            query.append(" AND PhoneNumber LIKE ?");
        }
        if (registrationDate != null && !registrationDate.isEmpty()) {
            query.append(" AND  CAST(registrationDate AS DATE) =  ?");
        }

        try (PreparedStatement stmt = c.prepareStatement(query.toString())) {

            int paramIndex = 1; // Chỉ số tham số cho PreparedStatement

            // Gán các tham số vào PreparedStatement
            if (username != null && !username.isEmpty()) {
                stmt.setString(paramIndex++, "%" + username + "%");
            }
            if (fullName != null && !fullName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + fullName + "%");
            }
            if (email != null && !email.isEmpty()) {
                stmt.setString(paramIndex++, "%" + email + "%");
            }
            if (phone != null && !phone.isEmpty()) {
                stmt.setString(paramIndex++, "%" + phone + "%");
            }
            if (registrationDate != null && !registrationDate.isEmpty()) {
                stmt.setString(paramIndex++, registrationDate); // Định dạng ngày theo kiểu yyyy-mm-dd
            }

            // Thực hiện truy vấn và lấy kết quả
            try (ResultSet rs = stmt.executeQuery()) {
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
                    user.setLocked(rs.getInt("locked")); // Lưu trạng thái locked

                    // Lấy danh sách đơn hàng của người dùng và gán vào thuộc tính 'orders'
                    ArrayList<Order> orders = getOrdersByUserId(user.getUserId());
                    user.setOrders(orders);

                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        return users;
    }

    @Override
    public List<User> filterBanUsers(String username, String fullName, String email, String phone, String registrationDate) {
        List<User> users = new ArrayList<>();

        // Bắt đầu xây dựng câu truy vấn SQL với điều kiện cơ bản là lọc người dùng chưa bị khóa
        StringBuilder query = new StringBuilder("SELECT * FROM Users WHERE locked = 1");

        // Thêm các điều kiện tìm kiếm vào câu truy vấn
        if (username != null && !username.isEmpty()) {
            query.append(" AND Username LIKE ?");
        }
        if (fullName != null && !fullName.isEmpty()) {
            query.append(" AND FullName LIKE ?");
        }
        if (email != null && !email.isEmpty()) {
            query.append(" AND Email LIKE ?");
        }
        if (phone != null && !phone.isEmpty()) {
            query.append(" AND PhoneNumber LIKE ?");
        }
        if (registrationDate != null && !registrationDate.isEmpty()) {
            query.append(" AND  CAST(registrationDate AS DATE) =  ?");
        }

        try (PreparedStatement stmt = c.prepareStatement(query.toString())) {

            int paramIndex = 1; // Chỉ số tham số cho PreparedStatement

            // Gán các tham số vào PreparedStatement
            if (username != null && !username.isEmpty()) {
                stmt.setString(paramIndex++, "%" + username + "%");
            }
            if (fullName != null && !fullName.isEmpty()) {
                stmt.setString(paramIndex++, "%" + fullName + "%");
            }
            if (email != null && !email.isEmpty()) {
                stmt.setString(paramIndex++, "%" + email + "%");
            }
            if (phone != null && !phone.isEmpty()) {
                stmt.setString(paramIndex++, "%" + phone + "%");
            }
            if (registrationDate != null && !registrationDate.isEmpty()) {
                stmt.setString(paramIndex++, registrationDate); // Định dạng ngày theo kiểu yyyy-mm-dd
            }

            // Thực hiện truy vấn và lấy kết quả
            try (ResultSet rs = stmt.executeQuery()) {
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
                    user.setLocked(rs.getInt("locked")); // Lưu trạng thái locked

                    // Lấy danh sách đơn hàng của người dùng và gán vào thuộc tính 'orders'
                    ArrayList<Order> orders = getOrdersByUserId(user.getUserId());
                    user.setOrders(orders);

                    users.add(user);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }

        return users;
    }
    
    // Lấy một Employee bất kỳ (dùng cho Customer)
    public User getEmployee() {
        String query = "SELECT TOP 1 * FROM Users WHERE Role = 'Employee'";
        User employee = null;
        try (PreparedStatement ps = c.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                employee = new User();
                employee.setUserId(rs.getInt("UserID"));
                employee.setUsername(rs.getString("Username"));
                employee.setPassword(rs.getString("Password"));
                employee.setFullName(rs.getString("FullName"));
                employee.setEmail(rs.getString("Email"));
                employee.setPhoneNumber(rs.getString("PhoneNumber"));
                employee.setAddress(rs.getString("Address"));
                employee.setRole(rs.getString("Role"));
                employee.setProfileImageURL(rs.getString("ProfileImageURL"));
                employee.setRegistrationDate(rs.getTimestamp("RegistrationDate"));
                employee.setLocked(rs.getInt("locked"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }

    @Override
    public OrderContact getOrderContactsByOrderID(int orderID) {
        String query = "SELECT * FROM OrderContacts WHERE OrderID = ?";
        OrderContact orderContact = null;

        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                orderContact = new OrderContact();
                orderContact.setContactID(rs.getInt("ContactID"));
                orderContact.setOrderID(rs.getInt("OrderID"));
                orderContact.setRecipientName(rs.getString("RecipientName"));
                orderContact.setRecipientPhone(rs.getString("RecipientPhone"));
                orderContact.setRecipientEmail(rs.getString("RecipientEmail"));
                orderContact.setNote(rs.getString("NOTE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderContact; // Trả về đối tượng OrderContact nếu tìm thấy, ngược lại trả về null
    }

   

}

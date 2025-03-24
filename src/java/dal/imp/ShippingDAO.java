package dal.imp;

import dal.DBConnect;
import dal.IShippingDAO;
import java.util.ArrayList;
import java.util.List;
import model.Shipping;
import java.sql.*;

public class ShippingDAO extends DBConnect implements IShippingDAO {

    @Override
// Phương thức lấy danh sách Shipping theo OrderID
    public List<Shipping> getListShippingByOrderID(int orderID) {
        List<Shipping> shippingList = new ArrayList<>();
        String sql = "SELECT [ShippingID], [OrderID], [ShippingDate], [ShippingStatus], [UserID] "
                + "FROM [Shipping] WHERE [OrderID] = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Shipping shipping = new Shipping();
                shipping.setShippingId(rs.getInt("ShippingID"));
                shipping.setOrderId(rs.getInt("OrderID"));
                shipping.setShippingDate(rs.getString("ShippingDate"));
                shipping.setShippingStatus(rs.getString("ShippingStatus"));
                shipping.setUserId(rs.wasNull() ? null : rs.getInt("UserID")); // Xử lý NULL cho UserID
                shippingList.add(shipping);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shippingList;
    }

    @Override

    // Phương thức thêm trạng thái Shipping mới theo OrderID và cập nhật OrderStatus nếu cần
    public boolean addStatusShippingByOrderID(int orderID, String shippingStatus, int userID, String orderStatus) {
        try {
            // Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
            c.setAutoCommit(false);

            // Bước 1: Thêm bản ghi vào bảng Shipping
            String insertShippingSql = "INSERT INTO [Shipping] (OrderID, ShippingDate, ShippingStatus, UserID) "
                    + "VALUES (?, GETDATE(), ?, ?)";
            int shippingRowsAffected = 0;
            try (PreparedStatement psInsert = c.prepareStatement(insertShippingSql)) {
                psInsert.setInt(1, orderID);
                psInsert.setString(2, shippingStatus);
                psInsert.setInt(3, userID);
                shippingRowsAffected = psInsert.executeUpdate();
            }

            // Bước 2: Cập nhật OrderStatus trong bảng Orders nếu cần
            if (orderStatus != null && ("Delivered".equalsIgnoreCase(orderStatus) || "Cancelled".equalsIgnoreCase(orderStatus))) {
                String updateOrderSql = "UPDATE [Orders] SET [OrderStatus] = ? WHERE [OrderID] = ?";
                try (PreparedStatement psUpdate = c.prepareStatement(updateOrderSql)) {
                    psUpdate.setString(1, orderStatus);
                    psUpdate.setInt(2, orderID);
                    int orderRowsAffected = psUpdate.executeUpdate();

                    // Nếu cập nhật Orders thất bại nhưng Shipping đã thêm, rollback
                    if (orderRowsAffected == 0) {
                        c.rollback();
                        System.out.println("Không tìm thấy OrderID: " + orderID + " để cập nhật OrderStatus.");
                        return false;
                    }
                }
            }

            // Commit transaction nếu mọi thứ thành công
            c.commit();
            return shippingRowsAffected > 0;

        } catch (SQLException e) {
            try {
                c.rollback(); // Rollback nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                c.setAutoCommit(true); // Khôi phục chế độ auto-commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override

    // Phương thức lấy UserID mới nhất trong Shipping theo OrderID
    public Integer getUserIDInShippingByOrderID(int orderID) {
        String sql = "SELECT TOP 1 [UserID] FROM [Shipping] WHERE [OrderID] = ? ORDER BY [ShippingDate] DESC";
        Integer userId = null; // Sử dụng Integer để hỗ trợ giá trị NULL

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.wasNull() ? null : rs.getInt("UserID"); // Xử lý NULL cho UserID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userId;
    }

    public static void main(String[] args) {
        ShippingDAO shippingDAO = new ShippingDAO();
        List<Shipping> shippingList = shippingDAO.getListShippingByOrderID(87);
        System.out.println(shippingList.size());
        shippingDAO.addStatusShippingByOrderID(87, "Không liên lạc được với người nhận", 2, "Cancelled");
    }
}

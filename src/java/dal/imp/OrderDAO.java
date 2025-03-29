package dal.imp;

import dal.DBConnect;
import dal.ICartDAO;
import dal.IOrderDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import static java.text.NumberFormat.Field.PREFIX;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.Product;

public class OrderDAO extends DBConnect implements IOrderDAO {

    @Override
    public int checkout(int userId, String fullName, String email, String phoneNumber, String shippingAddress, String paymentMethod, String note) {
        int orderId = 0;
        double totalAmount = 0.0;
        ICartDAO cart = new CartDAO();
        List<CartItem> cartItems = cart.getCartItems(userId);

        try {
            c.setAutoCommit(false); // Bắt đầu giao dịch

            // Bước 1: Tính tổng tiền của giỏ hàng
            for (CartItem item : cartItems) {
                double price = item.getProduct().getSalePrice(); // Giả định getSalePrice() trả về kiểu double
                double itemTotal = price * item.getQuantity();
                totalAmount += itemTotal;
            }

            // Bước 2: Tạo đơn hàng mới
            String orderCode = generateOrderId();
            String insertOrder = "INSERT INTO Orders (UserID, OrderDate, TotalAmount, OrderStatus, PaymentMethod, ShippingAddress, orderCode) "
                    + "VALUES (?, GETDATE(), ?, 'Pending', ?, ?, ?)";
            try (PreparedStatement stmt = c.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.setDouble(2, totalAmount);
                stmt.setString(3, paymentMethod);
                stmt.setString(4, shippingAddress);
                stmt.setString(5, orderCode);
                stmt.executeUpdate();
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1); // Lấy OrderID vừa tạo
                }
            }

            // Bước 3: Thêm các chi tiết đơn hàng vào OrderDetails
            String insertOrderDetail = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = c.prepareStatement(insertOrderDetail)) {
                for (CartItem item : cartItems) {
                    stmt.setInt(1, orderId);
                    stmt.setInt(2, item.getProduct().getProductID());
                    stmt.setInt(3, item.getQuantity());
                    stmt.setDouble(4, item.getProduct().getSalePrice());
                    stmt.addBatch(); // Thêm vào batch để thực thi đồng thời
                }
                stmt.executeBatch();
            }

            // Bước 4: Thêm thông tin người nhận vào OrderContacts
            String insertOrderContacts = "INSERT INTO OrderContacts (OrderID, RecipientName, RecipientPhone, RecipientEmail, NOTE) "
                    + "VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = c.prepareStatement(insertOrderContacts)) {
                stmt.setInt(1, orderId);
                stmt.setString(2, fullName);
                stmt.setString(3, phoneNumber);
                stmt.setString(4, email);
                stmt.setString(5, note);
                stmt.executeUpdate();
            }

            // Bước 5: Xóa các sản phẩm trong giỏ hàng
            cart.clearCartForever(userId);

            // Bước 6: Thêm bản ghi thanh toán trong bảng Payments
            String insertPayment = "INSERT INTO Payments (OrderID, PaymentDate, PaymentMethod, PaymentStatus) "
                    + "VALUES (?, GETDATE(), ?, 'Completed')";
            try (PreparedStatement stmt = c.prepareStatement(insertPayment)) {
                stmt.setInt(1, orderId);
                stmt.setString(2, paymentMethod);
                stmt.executeUpdate();
            }
            // Bước 7: Cập nhật Stock
            String updateStockQuery = "UPDATE Products SET Stock = Stock - ? WHERE ProductID = ?";
            PreparedStatement updateStockStmt = c.prepareStatement(updateStockQuery);
            for (CartItem item : cartItems) {
                updateStockStmt.setInt(1, item.getQuantity());
                updateStockStmt.setInt(2, item.getProduct().getProductID());
                updateStockStmt.addBatch();
            }
            updateStockStmt.executeBatch();

            // Bước 8: Cập nhật doanh thu hằng ngày trong DailyRevenue
            // Lấy ngày, tháng, năm hiện tại
            String checkRevenueQuery = "SELECT TotalRevenue, TotalOrders FROM DailyRevenue WHERE [Day] = DAY(GETDATE()) AND [Month] = MONTH(GETDATE()) AND [Year] = YEAR(GETDATE())";
            double existingRevenue = 0.0;
            int existingOrders = 0;
            try (PreparedStatement checkStmt = c.prepareStatement(checkRevenueQuery); ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    existingRevenue = rs.getDouble("TotalRevenue");
                    existingOrders = rs.getInt("TotalOrders");
                }
            }

            if (existingOrders > 0) {
                // Nếu đã có bản ghi cho ngày hôm nay, cập nhật TotalRevenue và TotalOrders
                String updateRevenueQuery = "UPDATE DailyRevenue SET TotalRevenue = TotalRevenue + ?, TotalOrders = TotalOrders + 1 "
                        + "WHERE [Day] = DAY(GETDATE()) AND [Month] = MONTH(GETDATE()) AND [Year] = YEAR(GETDATE())";
                try (PreparedStatement updateStmt = c.prepareStatement(updateRevenueQuery)) {
                    updateStmt.setDouble(1, totalAmount);
                    updateStmt.executeUpdate();
                }
            } else {
                // Nếu chưa có bản ghi, thêm mới
                String insertRevenueQuery = "INSERT INTO DailyRevenue ([Day], [Month], [Year], TotalRevenue, TotalOrders) "
                        + "VALUES (DAY(GETDATE()), MONTH(GETDATE()), YEAR(GETDATE()), ?, 1)";
                try (PreparedStatement insertStmt = c.prepareStatement(insertRevenueQuery)) {
                    insertStmt.setDouble(1, totalAmount);
                    insertStmt.executeUpdate();
                }
            }

            // Bước 9: Cập nhật doanh thu hàng tháng trong MonthlyRevenue
            String checkMonthlyRevenueQuery = "SELECT TotalRevenue, TotalOrders FROM MonthlyRevenue WHERE [Month] = MONTH(GETDATE()) AND [Year] = YEAR(GETDATE())";
            double existingMonthlyRevenue = 0.0;
            int existingMonthlyOrders = 0;
            try (PreparedStatement checkStmt = c.prepareStatement(checkMonthlyRevenueQuery); ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    existingMonthlyRevenue = rs.getDouble("TotalRevenue");
                    existingMonthlyOrders = rs.getInt("TotalOrders");
                }
            }

            if (existingMonthlyOrders > 0) {
                String updateMonthlyRevenueQuery = "UPDATE MonthlyRevenue SET TotalRevenue = TotalRevenue + ?, TotalOrders = TotalOrders + 1 "
                        + "WHERE [Month] = MONTH(GETDATE()) AND [Year] = YEAR(GETDATE())";
                try (PreparedStatement updateStmt = c.prepareStatement(updateMonthlyRevenueQuery)) {
                    updateStmt.setDouble(1, totalAmount);
                    updateStmt.executeUpdate();
                }
            } else {
                String insertMonthlyRevenueQuery = "INSERT INTO MonthlyRevenue ([Year], [Month], TotalRevenue, TotalOrders) "
                        + "VALUES (YEAR(GETDATE()), MONTH(GETDATE()), ?, 1)";
                try (PreparedStatement insertStmt = c.prepareStatement(insertMonthlyRevenueQuery)) {
                    insertStmt.setDouble(1, totalAmount);
                    insertStmt.executeUpdate();
                }
            }

            c.commit(); // Xác nhận giao dịch nếu không lỗi
        } catch (SQLException e) {
            try {
                c.rollback(); // Quay lại nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                c.setAutoCommit(true); // Trở lại chế độ tự động xác nhận
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }

    public String generateOrderId() {
        final String PREFIX = "ORDER-"; // Tiền tố cho mã đơn hàng
        final int LENGTH = 6; // Độ dài mã ngẫu nhiên
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"; // Ký tự có thể dùng
        Random random = new Random();
        StringBuilder orderId = new StringBuilder(PREFIX);

        // Tạo mã ngẫu nhiên gồm các ký tự
        for (int i = 0; i < LENGTH; i++) {
            int index = random.nextInt(characters.length()); // Lấy một chỉ số ngẫu nhiên
            orderId.append(characters.charAt(index)); // Thêm ký tự vào mã
        }

        return orderId.toString();
    }

    @Override
    public String getOrderCodeByOrderID(int orderId) {
        String orderCode = null;
        String query = "SELECT orderCode FROM Orders WHERE OrderId = ?"; // Câu lệnh SQL

        try (PreparedStatement pstmt = c.prepareStatement(query)) {
            pstmt.setInt(1, orderId); // Gán giá trị cho tham số
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                orderCode = rs.getString("orderCode"); // Lấy mã đơn hàng
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return orderCode; // Trả về mã đơn hàng
    }

    // Lấy danh sách đơn hàng cho một người dùng
    @Override
    public List<Order> getOrdersByUserId(int userId, String orderCode, String shippingAddress, String paymentMethod,
            String fromDate, String toDate, Double minPrice,
            Double maxPrice, String orderBy) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [OrderID], [UserID], [OrderDate], [TotalAmount], "
                + "[OrderStatus], [PaymentMethod], [ShippingAddress], [orderCode] "
                + "FROM [Orders] WHERE [UserID] = ?");

        // Danh sách tham số cho PreparedStatement
        List<Object> params = new ArrayList<>();
        params.add(userId);

        // Thêm các điều kiện lọc
        if (orderCode != null && !orderCode.isEmpty()) {
            sql.append(" AND [orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }

        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            sql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }

        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            sql.append(" AND [PaymentMethod] = ?");
            params.add(paymentMethod);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND [OrderDate] >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND [OrderDate] <= ?");
            params.add(toDate);
        }

        if (minPrice != null) {
            sql.append(" AND [TotalAmount] >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND [TotalAmount] <= ?");
            params.add(maxPrice);
        }

        // Thêm điều kiện sắp xếp
        if (orderBy != null && !orderBy.isEmpty()) {
            sql.append(" ORDER BY ").append(orderBy);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setOrderCode(rs.getString("orderCode"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Lấy danh sách đơn hàng cho một người dùng
    @Override
    public List<Order> getAllPendingOrders(String OrderStatus, String orderCode, String shippingAddress, String paymentMethod,
            String fromDate, String toDate, Double minPrice,
            Double maxPrice, String orderBy) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [OrderID], [UserID], [OrderDate], [TotalAmount], "
                + "[OrderStatus], [PaymentMethod], [ShippingAddress], [orderCode] "
                + "FROM [Orders] WHERE [OrderStatus] = ?");

        // Danh sách tham số cho PreparedStatement
        List<Object> params = new ArrayList<>();
        params.add(OrderStatus);

        // Thêm các điều kiện lọc
        if (orderCode != null && !orderCode.isEmpty()) {
            sql.append(" AND [orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }
        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            sql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }
        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            sql.append(" AND [PaymentMethod] = ?");
            params.add(paymentMethod);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND [OrderDate] >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND [OrderDate] <= ?");
            params.add(toDate);
        }

        if (minPrice != null) {
            sql.append(" AND [TotalAmount] >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND [TotalAmount] <= ?");
            params.add(maxPrice);
        }

        // Thêm điều kiện sắp xếp
        if (orderBy != null && !orderBy.isEmpty()) {
            sql.append(" ORDER BY ").append(orderBy);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setOrderCode(rs.getString("orderCode"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Lấy danh sách đơn hàng cho một người dùng
    @Override
    public List<Order> getAllOrders(String orderCode, String shippingAddress, String paymentMethod,
            String fromDate, String toDate, Double minPrice,
            Double maxPrice, String orderBy) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT [OrderID], [UserID], [OrderDate], [TotalAmount], "
                + "[OrderStatus], [PaymentMethod], [ShippingAddress], [orderCode] "
                + "FROM [Orders] WHERE [OrderStatus] != ?");

        // Danh sách tham số cho PreparedStatement
        List<Object> params = new ArrayList<>();
        params.add("Pending");

        // Thêm các điều kiện lọc
        if (orderCode != null && !orderCode.isEmpty()) {
            sql.append(" AND [orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }

        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            sql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }

        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            sql.append(" AND [PaymentMethod] = ?");
            params.add(paymentMethod);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND [OrderDate] >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND [OrderDate] <= ?");
            params.add(toDate);
        }

        if (minPrice != null) {
            sql.append(" AND [TotalAmount] >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND [TotalAmount] <= ?");
            params.add(maxPrice);
        }

        // Thêm điều kiện sắp xếp
        if (orderBy != null && !orderBy.isEmpty()) {
            sql.append(" ORDER BY ").append(orderBy);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setOrderCode(rs.getString("orderCode"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getOrdersByUserIdInShipping(int userId, String orderCode, String shippingAddress, String paymentMethod,
            String fromDate, String toDate, Double minPrice,
            Double maxPrice, String orderBy) {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT DISTINCT o.[OrderID], o.[UserID], o.[OrderDate], o.[TotalAmount], "
                + "o.[OrderStatus], o.[PaymentMethod], o.[ShippingAddress], o.[orderCode] "
                + "FROM [Orders] o "
                + "INNER JOIN [Shipping] s ON o.OrderID = s.OrderID "
                + "WHERE s.[UserID] = ?");

        // Danh sách tham số cho PreparedStatement
        List<Object> params = new ArrayList<>();
        params.add(userId);

        // Thêm các điều kiện lọc
        if (orderCode != null && !orderCode.isEmpty()) {
            sql.append(" AND o.[orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }

        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            sql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }

        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            sql.append(" AND o.[PaymentMethod] = ?");
            params.add(paymentMethod);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND o.[OrderDate] >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND o.[OrderDate] <= ?");
            params.add(toDate);
        }

        if (minPrice != null) {
            sql.append(" AND o.[TotalAmount] >= ?");
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql.append(" AND o.[TotalAmount] <= ?");
            params.add(maxPrice);
        }

        // Thêm điều kiện sắp xếp
        if (orderBy != null && !orderBy.isEmpty()) {
            sql.append(" ORDER BY ").append(orderBy);
        }

        try (PreparedStatement ps = c.prepareStatement(sql.toString())) {
            // Gán các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setOrderCode(rs.getString("orderCode"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public void confirmAllPendingOrders(String orderCode, String shippingAddress, String paymentMethod, String fromDate, String toDate, Double minPrice, Double maxPrice, String orderBy) {
        // Bước 1: Lấy danh sách OrderID
        StringBuilder selectSql = new StringBuilder("SELECT OrderID FROM [Orders] WHERE [OrderStatus] = ?");
        List<Object> params = new ArrayList<>();
        params.add("Pending");

        if (orderCode != null && !orderCode.isEmpty()) {
            selectSql.append(" AND [orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }
        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            selectSql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }
        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            selectSql.append(" AND [PaymentMethod] = ?");
            params.add(paymentMethod);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            selectSql.append(" AND [OrderDate] >= ?");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            selectSql.append(" AND [OrderDate] <= ?");
            params.add(toDate);
        }
        if (minPrice != null) {
            selectSql.append(" AND [TotalAmount] >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            selectSql.append(" AND [TotalAmount] <= ?");
            params.add(maxPrice);
        }

        List<Integer> orderIds = new ArrayList<>();

        try (PreparedStatement psSelect = c.prepareStatement(selectSql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                psSelect.setObject(i + 1, params.get(i));
            }

            ResultSet rs = psSelect.executeQuery();
            while (rs.next()) {
                orderIds.add(rs.getInt("OrderID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }

        // Bước 2: Update Orders
        StringBuilder updateSql = new StringBuilder("UPDATE [Orders] SET [OrderStatus] = 'Confirmed' WHERE [OrderStatus] = ?");
        List<Object> updateParams = new ArrayList<>();
        updateParams.add("Pending");

        if (orderCode != null && !orderCode.isEmpty()) {
            updateSql.append(" AND [orderCode] LIKE ?");
            updateParams.add("%" + orderCode + "%");
        }
        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            updateSql.append(" AND [ShippingAddress] LIKE ?");
            updateParams.add("%" + shippingAddress + "%");
        }
        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            updateSql.append(" AND [PaymentMethod] = ?");
            updateParams.add(paymentMethod);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            updateSql.append(" AND [OrderDate] >= ?");
            updateParams.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            updateSql.append(" AND [OrderDate] <= ?");
            updateParams.add(toDate);
        }
        if (minPrice != null) {
            updateSql.append(" AND [TotalAmount] >= ?");
            updateParams.add(minPrice);
        }
        if (maxPrice != null) {
            updateSql.append(" AND [TotalAmount] <= ?");
            updateParams.add(maxPrice);
        }

        try (PreparedStatement psUpdate = c.prepareStatement(updateSql.toString())) {
            for (int i = 0; i < updateParams.size(); i++) {
                psUpdate.setObject(i + 1, updateParams.get(i));
            }

            int rowsAffected = psUpdate.executeUpdate();
            System.out.println("Đã xác nhận " + rowsAffected + " đơn hàng.");

            // Bước 3: Insert Shipping (đã xóa DeliveryDate)
            if (rowsAffected > 0 && !orderIds.isEmpty()) {
                String insertShippingSql = "INSERT INTO [Shipping] (OrderID, ShippingDate, ShippingStatus, UserID) "
                        + "VALUES (?, GETDATE(), ?, NULL)";

                try (PreparedStatement psInsert = c.prepareStatement(insertShippingSql)) {
                    for (Integer orderId : orderIds) {
                        psInsert.setInt(1, orderId);
                        psInsert.setString(2, "Đơn hàng đang được đóng gói");
                        psInsert.addBatch();
                    }
                    int[] shippingRows = psInsert.executeBatch();
                    System.out.println("Đã tạo " + shippingRows.length + " bản ghi shipping.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void receiveAllConfirmedOrders(String orderCode, String shippingAddress, String paymentMethod, String fromDate, String toDate, Double minPrice, Double maxPrice, String orderBy, int userID) {
        // Bước 1: Lấy danh sách OrderID
        StringBuilder selectSql = new StringBuilder("SELECT OrderID FROM [Orders] WHERE [OrderStatus] = ?");
        List<Object> params = new ArrayList<>();
        params.add("Confirmed");

        if (orderCode != null && !orderCode.isEmpty()) {
            selectSql.append(" AND [orderCode] LIKE ?");
            params.add("%" + orderCode + "%");
        }
        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            selectSql.append(" AND [ShippingAddress] LIKE ?");
            params.add("%" + shippingAddress + "%");
        }
        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            selectSql.append(" AND [PaymentMethod] = ?");
            params.add(paymentMethod);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            selectSql.append(" AND [OrderDate] >= ?");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            selectSql.append(" AND [OrderDate] <= ?");
            params.add(toDate);
        }
        if (minPrice != null) {
            selectSql.append(" AND [TotalAmount] >= ?");
            params.add(minPrice);
        }
        if (maxPrice != null) {
            selectSql.append(" AND [TotalAmount] <= ?");
            params.add(maxPrice);
        }

        List<Integer> orderIds = new ArrayList<>();

        try (PreparedStatement psSelect = c.prepareStatement(selectSql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                psSelect.setObject(i + 1, params.get(i));
            }

            ResultSet rs = psSelect.executeQuery();
            while (rs.next()) {
                orderIds.add(rs.getInt("OrderID"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }

        // Bước 2: Update Orders
        StringBuilder updateSql = new StringBuilder("UPDATE [Orders] SET [OrderStatus] = 'Shipped' WHERE [OrderStatus] = ?");
        List<Object> updateParams = new ArrayList<>();
        updateParams.add("Confirmed");

        if (orderCode != null && !orderCode.isEmpty()) {
            updateSql.append(" AND [orderCode] LIKE ?");
            updateParams.add("%" + orderCode + "%");
        }
        if (shippingAddress != null && !shippingAddress.isEmpty()) {
            updateSql.append(" AND [ShippingAddress] LIKE ?");
            updateParams.add("%" + shippingAddress + "%");
        }
        if (paymentMethod != null && !paymentMethod.isEmpty()) {
            updateSql.append(" AND [PaymentMethod] = ?");
            updateParams.add(paymentMethod);
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            updateSql.append(" AND [OrderDate] >= ?");
            updateParams.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            updateSql.append(" AND [OrderDate] <= ?");
            updateParams.add(toDate);
        }
        if (minPrice != null) {
            updateSql.append(" AND [TotalAmount] >= ?");
            updateParams.add(minPrice);
        }
        if (maxPrice != null) {
            updateSql.append(" AND [TotalAmount] <= ?");
            updateParams.add(maxPrice);
        }

        try (PreparedStatement psUpdate = c.prepareStatement(updateSql.toString())) {
            for (int i = 0; i < updateParams.size(); i++) {
                psUpdate.setObject(i + 1, updateParams.get(i));
            }

            int rowsAffected = psUpdate.executeUpdate();
            System.out.println("Đã nhận " + rowsAffected + " đơn hàng.");

            // Bước 3: Insert Shipping (đã xóa DeliveryDate)
            if (rowsAffected > 0 && !orderIds.isEmpty()) {
                String insertShippingSql = "INSERT INTO [Shipping] (OrderID, ShippingDate, ShippingStatus, UserID) "
                        + "VALUES (?, GETDATE(), ?, ?)";

                try (PreparedStatement psInsert = c.prepareStatement(insertShippingSql)) {
                    for (Integer orderId : orderIds) {
                        psInsert.setInt(1, orderId);
                        psInsert.setString(2, "Đơn hàng đã được Shipper đến lấy");
                        psInsert.setInt(3, userID);
                        psInsert.addBatch();
                    }
                    int[] shippingRows = psInsert.executeBatch();
                    System.out.println("Đã tạo " + shippingRows.length + " bản ghi shipping.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "  SELECT o.OrderID, o.UserID, o.OrderDate, o.orderCode, o.TotalAmount, o.OrderStatus, o.PaymentMethod, o.ShippingAddress, \n"
                + "  oc.RecipientName, oc.RecipientPhone, oc.RecipientEmail\n"
                + "  FROM Orders o\n"
                + "  LEFT JOIN OrderContacts oc ON o.OrderID = oc.OrderID";
        try (PreparedStatement ps = c.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setOrderCode(rs.getString("orderCode"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setRecipientName(rs.getString("RecipientName"));
                order.setRecipientPhone(rs.getString("RecipientPhone"));
                order.setRecipientEmail(rs.getString("RecipientEmail"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String orderStatus, int UserID) {
        String sql = "UPDATE Orders SET OrderStatus = ? WHERE OrderID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, orderStatus);
            ps.setInt(2, orderId);
            int rowsUpdated = ps.executeUpdate();

            // Nếu cập nhật thành công và orderStatus là "Confirmed", thêm bản ghi vào Shipping
            if (rowsUpdated > 0 && "Confirmed".equalsIgnoreCase(orderStatus)) {
                String insertShippingSql = "INSERT INTO [Shipping] (OrderID, ShippingDate, ShippingStatus, UserID) "
                        + "VALUES (?, GETDATE(), ?, NULL)";
                try (PreparedStatement psInsert = c.prepareStatement(insertShippingSql)) {
                    psInsert.setInt(1, orderId);
                    psInsert.setString(2, "Đơn hàng đang được đóng gói");
                    int shippingRows = psInsert.executeUpdate();
                    System.out.println("Đã tạo " + shippingRows + " bản ghi shipping cho OrderID: " + orderId);
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Không trả về false ở đây để không ảnh hưởng kết quả cập nhật Orders
                }
            } // Nếu cập nhật thành công và orderStatus là "Shipped", thêm bản ghi vào Shipping với UserID
            else if (rowsUpdated > 0 && "Shipped".equalsIgnoreCase(orderStatus)) {
                String insertShippingSql = "INSERT INTO [Shipping] (OrderID, ShippingDate, ShippingStatus, UserID) "
                        + "VALUES (?, GETDATE(), ?, ?)";
                try (PreparedStatement psInsert = c.prepareStatement(insertShippingSql)) {
                    psInsert.setInt(1, orderId);
                    psInsert.setString(2, "Đơn hàng đã được Shipper đến lấy");
                    psInsert.setInt(3, UserID);
                    int shippingRows = psInsert.executeUpdate();
                    System.out.println("Đã tạo " + shippingRows + " bản ghi shipping cho OrderID: " + orderId);
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Không trả về false ở đây để không ảnh hưởng kết quả cập nhật Orders
                }
            }

            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Order> getDetailOrderByOderId(int oderId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT p.ProductName, p.ImageURL, c.CategoryName, od.Price, od.Quantity, (od.Quantity * od.Price) AS TotalPrice  FROM OrderDetails od\n"
                + "  LEFT JOIN OrderContacts oc ON od.OrderID = oc.OrderID\n"
                + "  LEFT JOIN Products p ON od.ProductID = p.ProductID\n"
                + "  LEFT JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                + "  WHERE od.OrderID = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, oderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setPrice(rs.getInt("Price"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setTotalAmount(rs.getDouble("TotalPrice"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Product> getProductForDetailOrdersByOderId(int orderId) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.ProductName, p.ImageURL, c.CategoryName, od.Price, od.Quantity, (od.Quantity * od.Price) AS TotalPrice  FROM OrderDetails od\n"
                + "  LEFT JOIN OrderContacts oc ON od.OrderID = oc.OrderID\n"
                + "  LEFT JOIN Products p ON od.ProductID = p.ProductID\n"
                + "  LEFT JOIN Categories c ON p.CategoryID = c.CategoryID\n"
                + "  WHERE od.OrderID = ?";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductName(rs.getString("ProductName"));
                product.setImageURL(rs.getString("ImageURL"));
                product.setCategoryName(rs.getString("CategoryName"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Order getOrdersByOrderId(int orderId) {
        Order order = null;
        String query = "SELECT * FROM Orders WHERE OrderID = ?"; // Câu lệnh SQL

        try (PreparedStatement pstmt = c.prepareStatement(query)) {
            pstmt.setInt(1, orderId); // Gán giá trị cho tham số
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                order.setOrderCode(rs.getString("orderCode"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }
        return order; // Trả về đối tượng Order
    }

    @Override
    public List<Product> getProductsByOrderID(int orderID) {
        List<Product> products = new ArrayList<>();
        try {
            String query = "SELECT \n"
                    + "    p.ProductID,"
                    + "    p.ProductName,\n"
                    + "    p.ImageURL\n"
                    + "FROM \n"
                    + "    [ProjectSWP].[dbo].[OrderDetails] od\n"
                    + "INNER JOIN \n"
                    + "    [ProjectSWP].[dbo].[Products] p ON od.ProductID = p.ProductID\n"
                    + "WHERE \n"
                    + "    od.OrderID = ?;";
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, orderID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setImageURL(rs.getString("ImageURL"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<OrderDetail> getOrderDetailByOderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT od.OrderDetailID, od.OrderID, od.Quantity, od.Price, p.ProductID, p.ProductName, p.Price as ProductPrice, p.ImageURL "
                + "FROM OrderDetails od "
                + "JOIN Products p ON od.ProductID = p.ProductID "
                + "WHERE od.OrderID = ?"; // Câu lệnh SQL

        try (PreparedStatement pstmt = c.prepareStatement(query)) {
            pstmt.setInt(1, orderId); // Gán giá trị cho tham số
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setOrderDetailId(rs.getInt("OrderDetailID"));
                orderDetail.setOrderId(rs.getInt("OrderID"));
                orderDetail.setQuantity(rs.getInt("Quantity"));
                orderDetail.setPrice(rs.getInt("Price"));

                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getDouble("ProductPrice"));
                product.setImageURL(rs.getString("ImageURL"));

                orderDetail.setProduct(product); // Gán đối tượng Product vào OrderDetail
                orderDetails.add(orderDetail); // Thêm vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }

        return orderDetails; // Trả về danh sách OrderDetails

    }

    public boolean updateOrderPaymentStatus(Order order) {
        String sql = "UPDATE [dbo].[Orders]\n"
                + "   SET [PaymentStatus] = ?\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, order.getPaymentStatus());
            ps.setInt(2, order.getOrderId());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";

        try (PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderID"));
                order.setUserId(rs.getInt("UserID"));
                order.setOrderDate(rs.getString("OrderDate"));
                order.setOrderCode(rs.getString("orderCode"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getString("OrderStatus"));
                order.setPaymentMethod(rs.getString("PaymentMethod"));
                order.setShippingAddress(rs.getString("ShippingAddress"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean deleteOrder(int orderId) {
        boolean success = false;
        try {
            c.setAutoCommit(false); // Bắt đầu giao dịch

            // Xóa từ OrderDetails
            String deleteOrderDetails = "DELETE FROM OrderDetails WHERE OrderID = ?";
            try (PreparedStatement stmt = c.prepareStatement(deleteOrderDetails)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }

            // Xóa từ OrderContacts
            String deleteOrderContacts = "DELETE FROM OrderContacts WHERE OrderID = ?";
            try (PreparedStatement stmt = c.prepareStatement(deleteOrderContacts)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }

            // Xóa từ Payments
            String deletePayments = "DELETE FROM Payments WHERE OrderID = ?";
            try (PreparedStatement stmt = c.prepareStatement(deletePayments)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }

            // Xóa từ Shipping (nếu có)
            String deleteShipping = "DELETE FROM Shipping WHERE OrderID = ?";
            try (PreparedStatement stmt = c.prepareStatement(deleteShipping)) {
                stmt.setInt(1, orderId);
                stmt.executeUpdate();
            }

            // Xóa từ Orders
            String deleteOrder = "DELETE FROM Orders WHERE OrderID = ?";
            try (PreparedStatement stmt = c.prepareStatement(deleteOrder)) {
                stmt.setInt(1, orderId);
                int rowsAffected = stmt.executeUpdate();
                success = rowsAffected > 0;
            }

            c.commit(); // Xác nhận giao dịch nếu không có lỗi
        } catch (SQLException e) {
            try {
                c.rollback(); // Quay lại nếu có lỗi
                System.out.println("Rollback performed due to error: " + e.getMessage());
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                c.setAutoCommit(true); // Trở lại chế độ tự động xác nhận
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        o.deleteOrder(3);
    }
}

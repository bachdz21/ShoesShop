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
                    stmt.setDouble(4, item.getProduct().getPrice());
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
                    try (PreparedStatement checkStmt = c.prepareStatement(checkRevenueQuery);
                         ResultSet rs = checkStmt.executeQuery()) {
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
                    try (PreparedStatement checkStmt = c.prepareStatement(checkMonthlyRevenueQuery);
                         ResultSet rs = checkStmt.executeQuery()) {
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
    public boolean updateOrderStatus(int orderId, String orderStatus) {
        String sql = "UPDATE Orders SET OrderStatus = ? WHERE OrderID = ?";
        try (PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, orderStatus);
            ps.setInt(2, orderId);
            int rowsUpdated = ps.executeUpdate();
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
//                product.setProductId(rs.getInt("ProductID"));
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
}
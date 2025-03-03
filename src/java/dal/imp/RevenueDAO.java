package dal.imp;

import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Revenue;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author nguye
 */
public class RevenueDAO extends DBConnect {

    public List<Revenue> getYearlyRevenue(int year) {
        List<Revenue> yearlyRevenue = new ArrayList<>();

        // Danh sách tất cả các tháng từ 1 đến 12
        for (int month = 1; month <= 12; month++) {
            Revenue revenue = new Revenue();
            revenue.setYear(year);
            revenue.setMonth(month);
            revenue.setTotalRevenue(0.0); // Mặc định là 0 doanh thu
            revenue.setTotalOrders(0); // Mặc định là 0 đơn hàng
            yearlyRevenue.add(revenue); // Thêm vào danh sách
        }

        try {
            String query = "SELECT * FROM MonthlyRevenue\n"
                    + "WHERE Year = ?\n"
                    + "ORDER BY Month"; // Sửa lại để sử dụng "Month" không phải "MONTH"
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();

            // Cập nhật doanh thu cho các tháng có dữ liệu
            while (rs.next()) {
                int month = rs.getInt("Month");
                double totalRevenue = rs.getDouble("TotalRevenue");
                int totalOrders = rs.getInt("TotalOrders");

                // Tìm tháng tương ứng và cập nhật doanh thu và đơn hàng
                for (Revenue rev : yearlyRevenue) {
                    if (rev.getMonth() == month) {
                        rev.setTotalRevenue(totalRevenue);
                        rev.setTotalOrders(totalOrders);
                        break; // Thoát khỏi vòng lặp khi đã tìm thấy
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return yearlyRevenue; // Trả về danh sách doanh thu theo tháng
    }

    public List<Revenue> getMonthlyRevenue(int year, int month) {
        List<Revenue> monthlyRevenue = new ArrayList<>();

        // Danh sách tất cả các ngày trong tháng
        int daysInMonth = java.time.YearMonth.of(year, month).lengthOfMonth();
        for (int day = 1; day <= daysInMonth; day++) {
            Revenue revenue = new Revenue();
            revenue.setYear(year);
            revenue.setMonth(month);
            revenue.setDay(day); // Thêm thông tin ngày
            revenue.setTotalRevenue(0.0); // Mặc định là 0 doanh thu
            revenue.setTotalOrders(0); // Mặc định là 0 đơn hàng
            monthlyRevenue.add(revenue); // Thêm vào danh sách
        }

        try {
            String query = "SELECT * FROM DailyRevenue\n"
                    + "WHERE Year = ? AND Month = ?\n"
                    + "ORDER BY Day"; // Sử dụng "Day" để sắp xếp
            PreparedStatement ps = c.prepareStatement(query);
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();

            // Cập nhật doanh thu cho các ngày có dữ liệu
            while (rs.next()) {
                int day = rs.getInt("Day");
                double totalRevenue = rs.getDouble("TotalRevenue");
                int totalOrders = rs.getInt("TotalOrders");

                // Tìm ngày tương ứng và cập nhật doanh thu và đơn hàng
                for (Revenue rev : monthlyRevenue) {
                    if (rev.getDay() == day) {
                        rev.setTotalRevenue(totalRevenue);
                        rev.setTotalOrders(totalOrders);
                        break; // Thoát khỏi vòng lặp khi đã tìm thấy
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return monthlyRevenue; // Trả về danh sách doanh thu theo ngày
    }

    public List<Revenue> getYearlyRevenueByCategories() {
        List<Revenue> yearlyRevenueByCategory = new ArrayList<>();
        String query = "SELECT c.CategoryName,\n"
                + "COALESCE(SUM(od.Quantity * od.Price), 0) AS TotalIncome\n"
                + "FROM Categories c\n"
                + "LEFT JOIN Products p ON c.CategoryID = p.CategoryID\n"
                + "LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n"
                + "LEFT JOIN Orders o ON od.OrderID = o.OrderID\n"
                + "GROUP BY c.CategoryName\n"
                + "ORDER BY \n"
                + "    CASE WHEN c.CategoryName = 'Sneakers' THEN 1\n"
                + "         WHEN c.CategoryName = 'Oxford' THEN 2\n"
                + "         WHEN c.CategoryName = 'Boot' THEN 3\n"
                + "         WHEN c.CategoryName = 'Sandal' THEN 4\n"
                + "         WHEN c.CategoryName = 'Other' THEN 5\n"
                + "         ELSE 6 \n"
                + "	END";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Revenue revenue = new Revenue();
                revenue.setCategoryName(rs.getString("CategoryName"));
                revenue.setTotalRevenue(rs.getDouble("TotalIncome"));
                yearlyRevenueByCategory.add(revenue);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return yearlyRevenueByCategory;  // Return the list of revenue by category
    }

    public double getTodaySale() {
        double todaySale = 0;
        String query = "SELECT SUM(od.Quantity) AS TodaySale\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetails od ON o.OrderID = od.OrderID\n"
                + "WHERE MONTH(o.OrderDate) = MONTH(GETDATE())\n"
                + "  AND YEAR(o.OrderDate) = YEAR(GETDATE())\n"
                + "  AND CAST(o.OrderDate AS DATE) = CAST(GETDATE() AS DATE);";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Kiểm tra xem có kết quả không
                todaySale = rs.getDouble("TodaySale");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todaySale;
    }

    public double getTotalSale() {
        double totalSale = 0;
        String query = "SELECT SUM(od.Quantity) AS TotalSale\n"
                + "FROM OrderDetails od;";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Kiểm tra xem có kết quả không
                totalSale = rs.getDouble("TotalSale"); // Sửa tên cột ở đây
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSale;
    }

    public double getTodayRevenue() {
        double todayRevenue = 0;
        String query = "SELECT SUM(o.TotalAmount) AS TodayRevenue\n"
                + "FROM Orders o\n"
                + "JOIN OrderDetails od ON o.OrderID = od.OrderID\n"
                + "WHERE MONTH(o.OrderDate) = MONTH(GETDATE())\n"
                + "  AND YEAR(o.OrderDate) = YEAR(GETDATE())\n"
                + "  AND CAST(o.OrderDate AS DATE) = CAST(GETDATE() AS DATE);";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Kiểm tra xem có kết quả không
                todayRevenue = rs.getDouble("TodayRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return todayRevenue;
    }

    public double getTotalRevenue() {
        double totalRevenue = 0;
        String query = "SELECT SUM(od.Quantity * od.Price) AS TotalRevenue\n"
                + "FROM OrderDetails od;";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { // Kiểm tra xem có kết quả không
                totalRevenue = rs.getDouble("TotalRevenue"); // Lấy doanh thu tổng
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRevenue;
    }

    public List<Revenue> getRevenueLastNDays(int n) {
        List<Revenue> revenueList = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            Revenue revenue = new Revenue();
            LocalDate date = LocalDate.now().minusDays(i); // Lấy ngày từ hôm nay đến n ngày trước
            revenue.setDay(date.getDayOfMonth());
            revenue.setMonth(date.getMonthValue());
            revenue.setYear(date.getYear());
            revenue.setTotalRevenue(n); // Khởi tạo doanh thu là 0
            revenueList.add(revenue);
        }

        String query = "SELECT \n"
                + "    [Day], \n"
                + "    [Month], \n"
                + "    [Year], \n"
                + "    SUM(TotalRevenue) AS DailyRevenue\n"
                + "FROM \n"
                + "    [ProjectPRJ301].[dbo].[DailyRevenue]\n"
                + "WHERE \n"
                + "    (CAST(CONCAT([Year], '-', [Month], '-', [Day]) AS DATE) >= CAST(DATEADD(DAY, -?, GETDATE()) AS DATE)\n"
                + "    AND CAST(CONCAT([Year], '-', [Month], '-', [Day]) AS DATE) <= CAST(GETDATE() AS DATE))\n"
                + "GROUP BY \n"
                + "    [Day], [Month], [Year]\n"
                + "ORDER BY \n"
                + "    [Year] DESC, [Month] DESC, [Day] DESC;";

        try (PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, n - 1);
            ResultSet rs = ps.executeQuery();

            // Cập nhật doanh thu cho những ngày có dữ liệu
            while (rs.next()) {
                int day = rs.getInt("Day");
                int month = rs.getInt("Month");
                int year = rs.getInt("Year");
                double dailyRevenue = rs.getDouble("DailyRevenue");

                // Cập nhật doanh thu vào danh sách
                for (Revenue revenue : revenueList) {
                    if (revenue.getDay() == day && revenue.getMonth() == month && revenue.getYear() == year) {
                        revenue.setTotalRevenue(dailyRevenue); // Cập nhật doanh thu thực tế
                        break;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenueList;
    }

    public static void main(String[] args) {
        RevenueDAO r = new RevenueDAO();
//        double todaySale = r.getTodaySale();
//        double totalSale = r.getTotalSale();
//        double todayRevenue = r.getTodayRevenue();
//        double totalRevenue = r.getTotalRevenue();
//        System.out.println(todaySale + ", " + totalSale + ", " + todayRevenue + ", " + totalRevenue);
        List<Revenue> list = r.getRevenueLastNDays(30);
        for (Revenue revenue : list) {
            System.out.println(revenue.toString());
        }
    }
}

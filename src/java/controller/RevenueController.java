package controller;

import dal.imp.RevenueDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Revenue;
import model.User;

@WebServlet(name = "RevenueController", urlPatterns = {"/revenue", "/getMonthlyRevenue", "/getYearlyRevenue", "/getYearlyRevenueByCategories",
    "/getRevenueLastNDays", "/getRevenueByMonthAndYear"})
public class RevenueController extends HttpServlet {

    RevenueDAO r = new RevenueDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/revenue")) {
            getRevenue(request, response);
        } else if (request.getServletPath().equals("/getRevenueLastNDays")) {
            getRevenueLastNDays(request, response);
        } else if (request.getServletPath().equals("/getRevenueByMonthAndYear")) {
            getRevenueByMonthAndYear(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }

    protected void getRevenue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || (!admin.getRole().equals("Admin")&& !admin.getRole().equals("Staff"))) {
            response.sendRedirect("home");
            return;
        }

        // Lấy năm từ tham số yêu cầu
        List<Revenue> revenueList = null;
        int year = Integer.parseInt(request.getParameter("year"));

        // Kiểm tra xem tham số month có tồn tại và không rỗng
        String monthParam = request.getParameter("month");
        if (monthParam != null && !monthParam.isEmpty()) {
            // Chuyển month thành số nguyên khi người dùng nhập giá trị
            int month = Integer.parseInt(monthParam);
            revenueList = r.getMonthlyRevenue(year, month);
            request.setAttribute("isMonthlyRevenue", true);
        } else {
            // Nếu không có giá trị month, gọi hàm doanh thu theo năm
            revenueList = r.getYearlyRevenue(year);
            request.setAttribute("isMonthlyRevenue", false);
        }

        List<Revenue> revenueByCategoryList = r.getYearlyRevenueByCategories();
        double todaySale = r.getTodaySale();
        double totalSale = r.getTotalSale();
        double todayRevenue = r.getTodayRevenue();
        double totalRevenue = r.getTotalRevenue();
        // Gửi dữ liệu đến trang JSP
        request.setAttribute("todaySale", todaySale);
        request.setAttribute("totalSale", totalSale);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revenueListByCategories", revenueByCategoryList);
        request.setAttribute("revenueList", revenueList);

        // Điều hướng đến JSP để hiển thị dữ liệu
        request.getRequestDispatcher("dashBoard.jsp").forward(request, response);
    }
    
    protected void getRevenueLastNDays(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");
        if (admin == null || !admin.getRole().equals("Admin")) {
            response.sendRedirect("home");
            return;
        }
        
        
        int numberOfDays = Integer.parseInt(request.getParameter("numberOfDays"));
        List<Revenue> revenueLastNDays = r.getRevenueLastNDays(numberOfDays);
        request.setAttribute("revenueLastNDays", revenueLastNDays);
        request.setAttribute("selectedOption", numberOfDays);
        // Điều hướng đến JSP để hiển thị dữ liệu
        request.setAttribute("chartType", "bar");
        request.getRequestDispatcher("chart.jsp").forward(request, response);
    }

    protected void getRevenueByMonthAndYear(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy năm từ tham số yêu cầu
        List<Revenue> revenueList = null;
        int year = Integer.parseInt(request.getParameter("year"));

        // Kiểm tra xem tham số month có tồn tại và không rỗng
        String monthParam = request.getParameter("month");
        if (monthParam != null && !monthParam.isEmpty()) {
            // Chuyển month thành số nguyên khi người dùng nhập giá trị
            int month = Integer.parseInt(monthParam);
            revenueList = r.getMonthlyRevenue(year, month);
            request.setAttribute("isMonthlyRevenue", true);
            request.setAttribute("selectedMonth", month);
        } else {
            // Nếu không có giá trị month, gọi hàm doanh thu theo năm
            revenueList = r.getYearlyRevenue(year);
            request.setAttribute("isMonthlyRevenue", false);
        }
        // Gửi dữ liệu đến trang JSP
        request.setAttribute("revenueLastNDays", revenueList);
        request.setAttribute("selectedOption", year);
        request.setAttribute("chartType", "line");
        // Điều hướng đến JSP để hiển thị dữ liệu
        request.getRequestDispatcher("chart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getServletPath().equals("/revenue")) {
            getRevenue(request, response);
        } else if (request.getServletPath().equals("/getRevenueLastNDays")) {
            getRevenueLastNDays(request, response);
        } else if (request.getServletPath().equals("/getRevenueByMonthAndYear")) {
            getRevenueByMonthAndYear(request, response);
        } else {
            request.getRequestDispatcher("/home").forward(request, response);
        }

    }
}

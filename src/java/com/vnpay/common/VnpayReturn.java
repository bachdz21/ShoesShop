package com.vnpay.common;

import dal.imp.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import model.Order;

@WebServlet(name = "VnpayReturn", urlPatterns = {"/vnpayReturn"})
public class VnpayReturn extends HttpServlet {

    OrderDAO orderDao = new OrderDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");
                String orderIdStr = request.getParameter("vnp_TxnRef");
                int orderId = Integer.parseInt(orderIdStr);

                Order order = new Order();
                order.setOrderId(orderId);
                boolean transSuccess = false;

                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    // Thanh toán thành công
                    order.setPaymentStatus("Đã thanh toán");
                    System.out.println("Test s");
                    System.out.println("PAYMENT: " + order.getPaymentStatus());
                    System.out.println(order.toString());
                    orderDao.updateOrderPaymentStatus(order);
                    transSuccess = true;
                } else {
                    // Thanh toán thất bại, xóa đơn hàng
                    order.setPaymentStatus("Chưa thanh toán");
                    System.out.println("Test f");
                    boolean deleted = orderDao.deleteOrder(orderId);
                    if (deleted) {
                        System.out.println("Đơn hàng " + orderId + " đã được xóa do thanh toán thất bại.");
                    } else {
                        System.out.println("Không thể xóa đơn hàng " + orderId + ".");
                    }
                }

                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("paymentResult.jsp").forward(request, response);
            } else {
                // Chữ ký không hợp lệ
                System.out.println("GD KO HOP LE (invalid signature)");
                // Có thể thêm logic xóa đơn hàng ở đây nếu cần
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
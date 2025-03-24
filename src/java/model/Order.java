/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author nguye
 */
public class Order {
    private int orderId;
    private int userId;
    private String orderDate;
    private String orderCode;
    private double totalAmount;
    private String orderStatus;
    private String paymentMethod;
    private String shippingAddress;
    private String recipientName;
    private String recipientPhone;
    private String recipientEmail;
    private int productId;
    private int quantity;
    private double price;
    private String paymentStatus;
    
    public Order() {
    }

    public Order(int orderId, int userId, String orderDate, String orderCode, double totalAmount, String orderStatus, String paymentMethod, String shippingAddress, String recipientName, String recipientPhone, String recipientEmail, int productId, int quantity, double price, String paymentStatus) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.orderCode = orderCode;
        this.totalAmount = totalAmount;
        this.orderStatus = orderStatus;
        this.paymentMethod = paymentMethod;
        this.shippingAddress = shippingAddress;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.recipientEmail = recipientEmail;
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
        this.paymentStatus = paymentStatus;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getRecipientPhone() {
        return recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    public String getRecipientEmail() {
        return recipientEmail;
    }

    public void setRecipientEmail(String recipientEmail) {
        this.recipientEmail = recipientEmail;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", userId=" + userId + ", orderDate=" + orderDate + ", orderCode=" + orderCode + ", totalAmount=" + totalAmount + ", orderStatus=" + orderStatus + ", paymentMethod=" + paymentMethod + ", shippingAddress=" + shippingAddress + ", recipientName=" + recipientName + ", recipientPhone=" + recipientPhone + ", recipientEmail=" + recipientEmail + ", productId=" + productId + ", quantity=" + quantity + ", price=" + price + ", paymentStatus=" + paymentStatus + '}';
    }
    
}
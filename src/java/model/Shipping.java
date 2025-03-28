package model;

public class Shipping {
    private int shippingId;
    private int orderId;
    private String shippingDate;
    private String shippingStatus;
    private Integer userId; // Integer để hỗ trợ giá trị NULL

    // Constructor mặc định
    public Shipping() {
    }

    // Constructor đầy đủ
    public Shipping(int shippingId, int orderId, String shippingDate, String shippingStatus, Integer userId) {
        this.shippingId = shippingId;
        this.orderId = orderId;
        this.shippingDate = shippingDate;
        this.shippingStatus = shippingStatus;
        this.userId = userId;
    }

    // Getter và Setter
    public int getShippingId() {
        return shippingId;
    }

    public void setShippingId(int shippingId) {
        this.shippingId = shippingId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getShippingDate() {
        return shippingDate;
    }

    public void setShippingDate(String shippingDate) {
        this.shippingDate = shippingDate;
    }

    public String getShippingStatus() {
        return shippingStatus;
    }

    public void setShippingStatus(String shippingStatus) {
        this.shippingStatus = shippingStatus;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    // toString để debug
    @Override
    public String toString() {
        return "Shipping{" +
                "shippingId=" + shippingId +
                ", orderId=" + orderId +
                ", shippingDate='" + shippingDate + '\'' +
                ", shippingStatus='" + shippingStatus + '\'' +
                ", userId=" + userId +
                '}';
    }
}
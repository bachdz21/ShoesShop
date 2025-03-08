package model;

public class OrderContact {
    private int contactID;
    private int orderID;
    private String recipientName;
    private String recipientPhone;
    private String recipientEmail;
    private String note;

    public OrderContact() {
    }

    public OrderContact(int contactID, int orderID, String recipientName, String recipientPhone, String recipientEmail, String note) {
        this.contactID = contactID;
        this.orderID = orderID;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.recipientEmail = recipientEmail;
        this.note = note;
    }

    public int getContactID() {
        return contactID;
    }

    public void setContactID(int contactID) {
        this.contactID = contactID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "OrderContact{" +
                "contactID=" + contactID +
                ", orderID=" + orderID +
                ", recipientName='" + recipientName + '\'' +
                ", recipientPhone='" + recipientPhone + '\'' +
                ", recipientEmail='" + recipientEmail + '\'' +
                ", note='" + note + '\'' +
                '}';
    }
}

package model;

import java.util.ArrayList;
import java.util.Date;

public class User {

    private int userId;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String address;
    private String role = "Customer";  // Mặc định là Customer
    private String profileImageURL;
    private Date registrationDate;
    private String avatarUrl;
    private ArrayList<Order> orders = new ArrayList<>();
    private int locked; // Thêm thuộc tính locked (1 - bị ban, 0 - chưa bị ban)
    private int deliveredCount;
    private int cancelledCount;
    private int totalOrders;
    private int cartItemsCount;

    public int getDeliveredCount() {
        return deliveredCount;
    }

    public void setDeliveredCount(int deliveredCount) {
        this.deliveredCount = deliveredCount;
    }

    public int getCancelledCount() {
        return cancelledCount;
    }

    public void setCancelledCount(int cancelledCount) {
        this.cancelledCount = cancelledCount;
    }
    
    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getCartItemsCount() {
        return cartItemsCount;
    }

    public void setCartItemsCount(int cartItemsCount) {
        this.cartItemsCount = cartItemsCount;
    }
    
    public User() {
    }

    public User(int userId, String role) {
        this.userId = userId;
        this.role = role;
    }
    
    public User(int userId, String username, String password, String fullName, String email, String phoneNumber, String address, String profileImageURL, Date registrationDate, String avatarUrl) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.profileImageURL = profileImageURL;
        this.registrationDate = registrationDate;
        this.avatarUrl = avatarUrl;
    }
    public User(int userId, String username, String password, String fullName, String email, 
                    String phoneNumber, String address, String profileImageURL, Date registrationDate, 
                    String avatarUrl, int totalOrders, int cartItemsCount) {
            this.userId = userId;
            this.username = username;
            this.password = password;
            this.fullName = fullName;
            this.email = email;
            this.phoneNumber = phoneNumber;
            this.address = address;
            this.profileImageURL = profileImageURL;
            this.registrationDate = registrationDate;
            this.avatarUrl = avatarUrl;
            this.totalOrders = totalOrders;
            this.cartItemsCount = cartItemsCount;
        }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getProfileImageURL() {
        return profileImageURL;
    }

    public void setProfileImageURL(String profileImageURL) {
        this.profileImageURL = profileImageURL;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public ArrayList<Order> getOrders() {
        return orders;
    }

    public void setOrders(ArrayList<Order> orders) {
        this.orders = orders;
    }

    public int getLocked() {
        return locked;
    }

    public void setLocked(int locked) {
        this.locked = locked;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", username=" + username + ", password=" + password + ", fullName=" + fullName + ", email=" + email + ", phoneNumber=" + phoneNumber + ", address=" + address + ", role=" + role + ", profileImageURL=" + profileImageURL + ", registrationDate=" + registrationDate + '}';
    }

}

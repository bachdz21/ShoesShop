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
public class Cart {

    private int id; // Khóa chính
    private int userId; // ID người dùng

    // Constructor không tham số
    public Cart() {
    }

    // Constructor với tham số
    public Cart(int id, int userId) {
        this.id = id;
        this.userId = userId;
    }

    // Getter và Setter cho các thuộc tính
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", userId=" + userId + '}';
    }

}

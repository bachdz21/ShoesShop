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
public class CartItem {
    private int cartItemId;
    private int cartId;
    private int quantity;
    private Date addedDate;
    private Product product;
    private String color;
    private String size;
    
    public CartItem() {
    }

    public CartItem(int cartItemId, int cartId, int quantity, Date addedDate, Product product, String color, String size) {
        this.cartItemId = cartItemId;
        this.cartId = cartId;
        this.quantity = quantity;
        this.addedDate = addedDate;
        this.product = product;
        this.color = color;
        this.size = size;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getColor() {
        return color; 
    }
    
    public void setColor(String color) {
        this.color = color; 
    }
    
    public String getSize() {
        return size; 
    }
    
    public void setSize(String size) {
        this.size = size; 
    }
    
    @Override
    public String toString() {
        return "CartItem{" + "cartItemId=" + cartItemId + ", cartId=" + cartId + ", quantity=" + quantity + 
               ", addedDate=" + addedDate + ", product=" + product + ", color=" + color + ", size=" + size + '}';
    }

    
    
    
}

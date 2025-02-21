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
public class WishlistItem {
    private int wishlistItemID;
    private int wishlistID;
    private Product product;

    // Constructor, getters, and setters
    
    public WishlistItem() {
    }

    public WishlistItem(int wishlistItemID, int wishlistID, Product product) {
        this.wishlistItemID = wishlistItemID;
        this.wishlistID = wishlistID;
        this.product = product;
    }

    public int getWishlistItemID() {
        return wishlistItemID;
    }

    public void setWishlistItemID(int wishlistItemID) {
        this.wishlistItemID = wishlistItemID;
    }

    public int getWishlistID() {
        return wishlistID;
    }

    public void setWishlistID(int wishlistID) {
        this.wishlistID = wishlistID;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "WishlistItem{" + "wishlistItemID=" + wishlistItemID + ", wishlistID=" + wishlistID + ", product=" + product + '}';
    }    
    
}

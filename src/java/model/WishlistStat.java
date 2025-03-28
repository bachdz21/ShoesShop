/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Hoang
 */
public class WishlistStat {
    private String productName;
    private String categoryName;
    private int wishlistCount;

    public WishlistStat(String productName, String categoryName, int wishlistCount) {
        this.productName = productName;
        this.categoryName = categoryName;
        this.wishlistCount = wishlistCount;
    }

    // Getters and Setters
    public String getProductName() { 
        return productName; 
    }
    public void setProductName(String productName) { 
        this.productName = productName; 
    }
    public String getCategoryName() { 
        return categoryName; 
    }
    public void setCategoryName(String categoryName) { 
        this.categoryName = categoryName; 
    }
    public int getWishlistCount() { 
        return wishlistCount; 
    }
    public void setWishlistCount(int wishlistCount) { 
        this.wishlistCount = wishlistCount; 
    }
}

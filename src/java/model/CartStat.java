/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Hoang
 */
public class CartStat {
    private String productName;
    private String brand;
    private int addToCartCount;
    private double totalQuantity;

    public CartStat(String productName, String brand, int addToCartCount, double totalQuantity) {
        this.productName = productName;
        this.brand = brand;
        this.addToCartCount = addToCartCount;
        this.totalQuantity = totalQuantity;
    }

    // Getters and Setters
    public String getProductName() { 
        return productName; 
    }
    public void setProductName(String productName) { 
        this.productName = productName; 
    }
    public String getBrand() { 
        return brand; 
    }
    public void setBrand(String brand) { 
        this.brand = brand; 
    }
    public int getAddToCartCount() { 
        return addToCartCount; 
    }
    public void setAddToCartCount(int addToCartCount) { 
        this.addToCartCount = addToCartCount; 
    }
    public double getTotalQuantity() { 
        return totalQuantity; 
    }
    public void setAvgQuantity(double totalQuantity) { 
        this.totalQuantity = totalQuantity; 
    }
}

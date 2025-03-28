/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Hoang
 */
public class ProductVariant {
    private int variantID;
    private int productID;
    private String colorName;
    private String sizeName;
    private int stock;

    public ProductVariant(int variantID, int productID, String colorName, String sizeName, int stock) {
        this.variantID = variantID;
        this.productID = productID;
        this.colorName = colorName;
        this.sizeName = sizeName;
        this.stock = stock;
    }

    // Getter và Setter
    public int getVariantID() {
        return variantID; 
    }
    
    public void setVariantID(int variantID) {
        this.variantID = variantID; 
    }
    
    public int getProductID() {
        return productID; 
    }
    
    public void setProductID(int productID) {
        this.productID = productID; 
    }
    
    public String getColorName() {
        return colorName; 
    }
    
    public void setColorName(String colorName) {
        this.colorName = colorName; 
    }
    
    public String getSizeName() {
        return sizeName; 
    }
    
    public void setSizeName(String sizeName) {
        this.sizeName = sizeName; 
    }
    
    public int getStock() {
        return stock; 
    }
    
    public void setStock(int stock) {
        this.stock = stock; 
    }
}

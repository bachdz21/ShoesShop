/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class ProductVariant {
    private int variantID;
    private int productID;
    private String productName;
    private String color;
    private String size;
    private int stock;

    // Constructor
    public ProductVariant(int variantID, int productID, String productName, String color, String size, int stock) {
        this.variantID = variantID;
        this.productID = productID;
        this.productName = productName;
        this.color = color;
        this.size = size;
        this.stock = stock;
    }

    // Getter & Setter
    public int getVariantID() { return variantID; }
    public int getProductID() { return productID; }
    public String getProductName() { return productName; }
    public String getColor() { return color; }
    public String getSize() { return size; }
    public int getStock() { return stock; }
}


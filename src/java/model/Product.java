/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Hoang
 */
public class Product {

    private int productID;
    private String productName;
    private String description;
    private double price;
    private int stock; // Thêm thuộc tính stock
    private String categoryName;
    private String imageURL;
    private List<String> imageURLDetail;
    private int sale; // Thêm thuộc tính sale
    private Date createdDate;
    private String brand;
    private double salePrice = price;
    private int quantitySold;
    // Constructor

    public Product() {
    }

    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL, List<String> imageURLDetail, int sale, Date createdDate, String brand, int quantitySold) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.imageURLDetail = imageURLDetail;
        this.sale = sale;
        this.createdDate = createdDate;
        this.brand = brand;
        this.quantitySold = quantitySold;
    }

    public Product(String productName, String description, double price, int stock, String categoryName, String imageURL,
            int sale, String brand) {
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.sale = sale;
        this.createdDate = createdDate;
        this.brand = brand;
    }

    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL,
            int sale, String brand) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.sale = sale;
        this.brand = brand;
    }

    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL,
            int sale, Date createdDate, String brand) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.sale = sale;
        this.createdDate = createdDate;
        this.brand = brand;
    }

    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL,
            int sale, Date createdDate, String brand, double salePrice) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.sale = sale;
        this.createdDate = createdDate;
        this.brand = brand;
        this.salePrice = salePrice;
    }

    public Product(String productName, String description, double price, int stock, String categoryName, String imageURL, List<String> imageURLDetail, int sale, String brand) {
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.imageURLDetail = imageURLDetail;
        this.sale = sale;
        this.brand = brand;
    }
    
    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL, List<String> imageURLDetail, int sale, String brand) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.imageURLDetail = imageURLDetail;
        this.sale = sale;
        this.brand = brand;
    }

    public Product(int productID, String productName, String description, double price, int stock, String categoryName, String imageURL, List<String> imageURLDetail, int sale, Date createdDate, String brand) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.categoryName = categoryName;
        this.imageURL = imageURL;
        this.imageURLDetail = imageURLDetail;
        this.sale = sale;
        this.createdDate = createdDate;
        this.brand = brand;
    }

    // Getters and Setters cho từng thuộc tính
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() { // Getter cho stock
        return stock;
    }

    public void setStock(int stock) { // Setter cho stock
        this.stock = stock;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public int getSale() { // Getter cho sale
        return sale;
    }

    public void setSale(int sale) {
        this.sale = sale;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }

    public List<String> getImageURLDetail() {
        return imageURLDetail;
    }

    public void setImageURLDetail(List<String> imageURLDetail) {
        this.imageURLDetail = imageURLDetail;
    }

    public int getQuantitySold() {
        return quantitySold;
    }

    public void setQuantitySold(int quantitySold) {
        this.quantitySold = quantitySold;
    }

    
    @Override
    public String toString() {
        return "Product{" + "productID=" + productID + ", productName=" + productName + ", description=" + description
                + ", price=" + price + ", stock=" + stock + ", categoryName=" + categoryName + ", imageURL=" + imageURL
                + ", imageURLDetail=" + imageURLDetail + ", sale=" + sale + ", createdDate=" + createdDate + ", brand="
                + brand + ", salePrice=" + salePrice + '}';
    }

}

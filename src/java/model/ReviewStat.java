/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Hoang
 */
public class ReviewStat {
    private String productName;
    private double avgRating;
    private int reviewCount;
    private double satisfactionRate;

    public ReviewStat(String productName, double avgRating, int reviewCount, double satisfactionRate) {
        this.productName = productName;
        this.avgRating = avgRating;
        this.reviewCount = reviewCount;
        this.satisfactionRate = satisfactionRate;
    }

    // Getters and Setters
    public String getProductName() { 
        return productName; 
    }
    public void setProductName(String productName) { 
        this.productName = productName; 
    }
    public double getAvgRating() { 
        return avgRating; 
    }
    public void setAvgRating(double avgRating) { 
        this.avgRating = avgRating; 
    }
    public int getReviewCount() { 
        return reviewCount; 
    }
    public void setReviewCount(int reviewCount) { 
        this.reviewCount = reviewCount; 
    }
    public double getSatisfactionRate() { 
        return satisfactionRate; 
    }
    public void setSatisfactionRate(double satisfactionRate) { 
        this.satisfactionRate = satisfactionRate; 
    }
}

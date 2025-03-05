/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author nguye
 */
import java.util.Date;

public class Review {

    private int reviewID;
    private int productID;
    private int userID;
    private Integer rating;
    private String comment;
    private Date reviewDate;
    private boolean isApproved;
    private boolean isVerifiedPurchase;

    // Constructor
    public Review(int reviewID, int productID, int userID, Integer rating, String comment, Date reviewDate, boolean isApproved, boolean isVerifiedPurchase) {
        this.reviewID = reviewID;
        this.productID = productID;
        this.userID = userID;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.isApproved = isApproved;
        this.isVerifiedPurchase = isVerifiedPurchase;
    }

    public int getReviewID() {
        return reviewID;
    }

    public void setReviewID(int reviewID) {
        this.reviewID = reviewID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public boolean isIsVerifiedPurchase() {
        return isVerifiedPurchase;
    }

    public void setIsVerifiedPurchase(boolean isVerifiedPurchase) {
        this.isVerifiedPurchase = isVerifiedPurchase;
    }

    @Override
    public String toString() {
        return "Review{" + "reviewID=" + reviewID + ", productID=" + productID + ", userID=" + userID + ", rating=" + rating + ", comment=" + comment + ", reviewDate=" + reviewDate + ", isApproved=" + isApproved + ", isVerifiedPurchase=" + isVerifiedPurchase + '}';
    }

}

  

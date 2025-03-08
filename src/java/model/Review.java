/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author nguye
 */
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Review {

    private int reviewId;
    private int productId;
    private int userId;
    private String userName;
    private Integer rating;
    private String comment;
    private Timestamp reviewDate;
    private boolean isApproved;
    List<ReviewMedia> reviewMedia = new ArrayList<>();
    List<ReviewReply> reviewReply = new ArrayList<>();

    // Constructors
    public Review() {
    }

    public Review(int productId, int userId, Integer rating, String comment) {
        this.productId = productId;
        this.userId = userId;
        this.rating = rating;
        this.comment = comment;
    }

    public Review(int reviewId, int productId, int userId, String userName, Integer rating, String comment, Timestamp reviewDate, boolean isApproved) {
        this.reviewId = reviewId;
        this.productId = productId;
        this.userId = userId;
        this.userName = userName;
        this.rating = rating;
        this.comment = comment;
        this.reviewDate = reviewDate;
        this.isApproved = isApproved;
    }
    
    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public Timestamp getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Timestamp reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public List<ReviewMedia> getReviewMedia() {
        return reviewMedia;
    }

    public void setReviewMedia(List<ReviewMedia> reviewMedia) {
        this.reviewMedia = reviewMedia;
    }

    public List<ReviewReply> getReviewReply() {
        return reviewReply;
    }

    public void setReviewReply(List<ReviewReply> reviewReply) {
        this.reviewReply = reviewReply;
    }

    @Override
    public String toString() {
        return "Review{" + "reviewId=" + reviewId + ", productId=" + productId + ", userId=" + userId + ", userName=" + userName + ", rating=" + rating + ", comment=" + comment + ", reviewDate=" + reviewDate + ", isApproved=" + isApproved + ", reviewMedia=" + reviewMedia + ", reviewReply=" + reviewReply + '}';
    }

    
    
}

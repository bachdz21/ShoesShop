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

public class ReviewReply {

    private int replyId;
    private int reviewId;
    private int userId;
    private String replyText;
    private Timestamp replyDate;

    // Constructors
    public ReviewReply() {
    }

    public ReviewReply(int replyId, int reviewId, int userId, String replyText, Timestamp replyDate) {
        this.replyId = replyId;
        this.reviewId = reviewId;
        this.userId = userId;
        this.replyText = replyText;
        this.replyDate = replyDate;
    }

    // Getters and Setters
    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getReplyText() {
        return replyText;
    }

    public void setReplyText(String replyText) {
        this.replyText = replyText;
    }

    public Timestamp getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(Timestamp replyDate) {
        this.replyDate = replyDate;
    }

    @Override
    public String toString() {
        return "ReviewReply{" + "replyId=" + replyId + ", reviewId=" + reviewId + ", userId=" + userId + ", replyText=" + replyText + ", replyDate=" + replyDate + '}';
    }

}

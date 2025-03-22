package model;

import java.sql.Timestamp;

public class HotDealSettings {

    private Timestamp endTime;
    private String title;
    private String subtitle;
    private String imageURL; // Thêm thuộc tính mới

    // Getters và Setters
    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    @Override
    public String toString() {
        return "HotDealSettings{" + "endTime=" + endTime + ", title=" + title + ", subtitle=" + subtitle + ", imageURL=" + imageURL + '}';
    }

}

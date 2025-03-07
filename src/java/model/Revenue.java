/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author nguye
 */
public class Revenue {
    private int day;
    private int year;
    private int month;
    private double totalRevenue;
    private int totalOrders;
    private String categoryName;
    
    public Revenue() {
    }

    public Revenue(int day, int year, int month, double totalRevenue, int totalOrders, String categoryName) {
        this.day = day;
        this.year = year;
        this.month = month;
        this.totalRevenue = totalRevenue;
        this.totalOrders = totalOrders;
        this.categoryName = categoryName;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "Revenue{" + "day=" + day + ", year=" + year + ", month=" + month + ", totalRevenue=" + totalRevenue + ", totalOrders=" + totalOrders + ", categoryName=" + categoryName + '}';
    }


    

}

package com.example;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.time.Duration;

public class LoginTest {
    private WebDriver driver;
    private WebDriverWait wait;

    @BeforeMethod
    public void setup() {
        // Thiết lập ChromeDriver bằng WebDriverManager
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        wait = new WebDriverWait(driver, Duration.ofSeconds(10));
    }

    @Test
    public void testSuccessfulLogin() {
        // Mở trang đăng nhập
        driver.get("http://localhost:8080/ShoesStoreWed/login");

        // Tìm và nhập username
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("username")));
        usernameField.sendKeys("validUser");

        // Tìm và nhập password
        WebElement passwordField = driver.findElement(By.id("password"));
        passwordField.sendKeys("validPassword");

        // Nhấn nút đăng nhập
        WebElement loginButton = driver.findElement(By.xpath("//button[text()='Login']"));
        loginButton.click();

        // Kiểm tra xem có chuyển hướng đến trang chính không
        wait.until(ExpectedConditions.urlToBe("http://localhost:8080/ShoesStoreWed/home"));
        String currentUrl = driver.getCurrentUrl();
        Assert.assertEquals(currentUrl, "http://localhost:8080/ShoesStoreWed/home", "Đăng nhập không thành công, không chuyển hướng đến trang chính!");
    }

    @Test
    public void testFailedLogin() {
        // Mở trang đăng nhập
        driver.get("http://localhost:8080/ShoesStoreWed/login");

        // Tìm và nhập username sai
        WebElement usernameField = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("username")));
        usernameField.sendKeys("invalidUser");

        // Tìm và nhập password sai
        WebElement passwordField = driver.findElement(By.id("password"));
        passwordField.sendKeys("invalidPassword");

        // Nhấn nút đăng nhập
        WebElement loginButton = driver.findElement(By.xpath("//button[text()='Login']"));
        loginButton.click();

        // Kiểm tra thông báo lỗi
        WebElement errorMessage = wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("errorMessage")));
        String errorText = errorMessage.getText();
        Assert.assertEquals(errorText, "Invalid credentials", "Thông báo lỗi không đúng khi đăng nhập thất bại!");
    }

    @AfterMethod
    public void tearDown() {
        // Đóng trình duyệt sau mỗi test
        if (driver != null) {
            driver.quit();
        }
    }
}
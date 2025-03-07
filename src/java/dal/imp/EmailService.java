/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author nguye
 */
public class EmailService {

    public static void sendEmail(String toEmail, String subject, String messageText) {
        final String fromEmail = "nguyenphuong9824@gmail.com"; // Thay bằng email của bạn
        final String password = "hpue gvnj vzbn oezq"; // Thay bằng mật khẩu ứng dụng của email (không dùng mật khẩu email cá nhân)

        // Cấu hình thuộc tính cho mail server
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
        props.put("mail.smtp.port", "587"); // TLS Port
        props.put("mail.smtp.auth", "true"); // Enable authentication
        props.put("mail.smtp.starttls.enable", "true"); // Enable STARTTLS

        // Tạo session với thông tin xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Tạo thông điệp email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
             message.setContent(messageText, "text/html; charset=utf-8");

            // Gửi email
            Transport.send(message);
            System.out.println("Email đã được gửi thành công.");
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Gửi email thất bại.");
        }
    }
}

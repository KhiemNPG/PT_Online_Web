package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String FROM = "dangvuongthinhstg@gmail.com";
    private static final String PASSWORD = "pwpmfwupkznzwarf"; // Đảm bảo đây là App Password

    public static void sendEmail(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        // Thêm các cấu hình này để tăng khả năng thành công trên Server
        props.put("mail.smtp.connectiontimeout", "10000"); // 10 giây
        props.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });

        // Tắt log debug nếu bạn thấy quá nhiều thông tin trên console
        // session.setDebug(true); 

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            msg.setContent(content, "text/html; charset=UTF-8");

            System.out.println("Đang gửi email tới: " + to);
            Transport.send(msg);
            System.out.println("Email đã gửi thành công!");

        } catch (Exception e) {
            System.err.println("LỖI GỬI EMAIL THẤT BẠI:");
            e.printStackTrace(); // Đây là dòng quan trọng để biết tại sao fail trên Server
        }
    }
}

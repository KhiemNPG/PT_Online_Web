package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {

    private static final String FROM = "dangvuongthinhstg@gmail.com";
    private static final String PASSWORD = "jhmkchynxxpuuawk";

    public static void sendEmail(String to, String subject, String content) {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(FROM, PASSWORD);
                    }
                });

        try {

            Message msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(FROM));

            msg.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );

            msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            msg.setContent(content, "text/html; charset=UTF-8");

            Transport.send(msg);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
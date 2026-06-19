package utils;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class EmailService {

    public static final String SCRIPT_URL = "https://script.google.com/macros/s/AKfycbzZ45YqvVs3TlBZxhIkFiVqrlLbwbp_Nhhw0O4P8Jj5Bh0_YF77L7zBf6fbxaXQmqo/exec";

    public static void sendEmail(String to, String subject, String content) {

        try {
            // Mở kết nối lướt web (HTTP POST) sang cổng 443 của Google (Render không thể chặn)
            URL url = new URL(SCRIPT_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            // Đóng gói nội dung mail y hệt như việc điền form trên mạng
            String urlParameters = "to=" + URLEncoder.encode(to, "UTF-8") +
                                 "&subject=" + URLEncoder.encode(subject, "UTF-8") +
                                 "&content=" + URLEncoder.encode(content, "UTF-8");

            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = urlParameters.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // Gửi đi và đọc kết quả phản hồi từ Google
            int responseCode = conn.getResponseCode();
            if (responseCode == 200 || responseCode == 302) {
                System.out.println("THÀNH CÔNG: Mail đã được trạm trung chuyển Google gửi đi!");
            } else {
                System.err.println("LỖI GỬI MAIL. Mã lỗi HTTP: " + responseCode);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

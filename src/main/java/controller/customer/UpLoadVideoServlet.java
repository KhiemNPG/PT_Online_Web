package controller.customer;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "UpLoadVideoServlet", urlPatterns = {"/UpLoadVideo"})
public class UpLoadVideoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

            String jspPath = "/WEB-INF/View/customer/uploadVideo/index.jsp";

            request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // 1. Đọc nội dung JSON
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }

            // 2. Parse JSON
            Gson gson = new Gson();
            Map<String, Object> data = gson.fromJson(sb.toString(), Map.class);

            // 3. Trích xuất dữ liệu an toàn
            String type = (String) data.getOrDefault("type", "unknown");
            List<String> warnings = (List<String>) data.getOrDefault("warnings", new ArrayList<String>());
            String thumbBase64 = (String) data.get("thumb");

            // 4. LOGIC LƯU ẢNH (Nếu có)
            String fileName = "thumb_" + System.currentTimeMillis() + ".jpg";
            if (thumbBase64 != null && thumbBase64.contains(",")) {
                // Tách phần header "data:image/jpeg;base64," ra
                String base64Data = thumbBase64.split(",")[1];
                byte[] imageBytes = Base64.getDecoder().decode(base64Data);

                // Lưu vào thư mục thực tế trên server (ví dụ: /uploads/)
                String uploadPath = getServletContext().getRealPath("/") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                try (FileOutputStream fos = new FileOutputStream(new File(uploadDir, fileName))) {
                    fos.write(imageBytes);
                }
                System.out.println("Đã lưu ảnh tại: " + uploadPath + File.separator + fileName);
            }

            // 5. Gom lỗi để phản hồi (Tối ưu để máy đọc nghe tự nhiên hơn)
            String speechResponse;

            if (warnings == null || warnings.isEmpty()) {
                speechResponse = "Tuyệt vời! Kỹ thuật của bạn đạt chuẩn 100%. Hãy giữ vững phong độ này cho các hiệp tiếp theo nhé!";
            } else {
                // Biến danh sách lỗi thành một câu nói hoàn chỉnh
                String errors = String.join(", ", warnings);
                speechResponse = "Bạn tập rất nỗ lực! Tuy nhiên, có vài điểm cần chỉnh lại như sau: " + errors + ". Chút điều chỉnh nhỏ này sẽ giúp bạn tiến bộ rất nhanh đấy.";
            }

            System.out.println("Bài tập nhận được: " + type);
            System.out.println("Phản hồi AI: " + speechResponse);

            // 6. Trả về JSON thành công
            JsonObject resJson = new JsonObject();
            resJson.addProperty("status", "success");
            resJson.addProperty("message", speechResponse); // Câu này hàm speak() sẽ đọc
            resJson.addProperty("imagePath", "uploads/" + fileName);
            resJson.addProperty("warningRaw", String.join(", ", warnings)); // Lưu lỗi thô nếu cần

            out.print(gson.toJson(resJson));
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}

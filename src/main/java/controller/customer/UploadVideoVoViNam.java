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
@WebServlet(name = "UploadVideoVoViNam", urlPatterns = {"/UpLoadVideo_VoViNam"})
public class UploadVideoVoViNam extends HttpServlet {

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

        String jspPath = "/WEB-INF/View/customer/uploadVideo_VoViNam/index.jsp";

        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8"); // Thêm charset ở đây luôn

        try (PrintWriter out = response.getWriter()) {
            // 1. Đọc JSON (Dùng cách này ngắn gọn hơn StringBuilder)
            Gson gson = new Gson();
            JsonObject data = gson.fromJson(request.getReader(), JsonObject.class);

            // 2. Trích xuất dữ liệu an toàn từ JsonObject
            String type = data.has("type") ? data.get("type").getAsString() : "unknown";
            String thumbBase64 = data.has("thumb") && !data.get("thumb").isJsonNull()
                    ? data.get("thumb").getAsString() : null;

            // Lấy danh sách lỗi (Cực kỳ quan trọng để tránh lỗi Casting)
            List<String> warnings = new ArrayList<>();
            if (data.has("warnings") && data.get("warnings").isJsonArray()) {
                data.get("warnings").getAsJsonArray().forEach(e -> warnings.add(e.getAsString()));
            }

            // 3. Xử lý lưu ảnh (Giữ nguyên logic mkdirs để an toàn hơn)
            String fileName = "vovinam_" + System.currentTimeMillis() + ".jpg";
            if (thumbBase64 != null && thumbBase64.contains(",")) {
                String base64Data = thumbBase64.split(",")[1];
                byte[] imageBytes = Base64.getDecoder().decode(base64Data);
                String uploadPath = getServletContext().getRealPath("/") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs(); // mkdirs sẽ tạo cả thư mục cha nếu thiếu

                try (FileOutputStream fos = new FileOutputStream(new File(uploadDir, fileName))) {
                    fos.write(imageBytes);
                }
            }

            // 4. BIẾN ĐỔI CÂU NÓI CỦA AI (Để nghe không bị máy móc)
            String speechResponse;
            if (warnings.isEmpty()) {
                speechResponse = "Tuyệt vời! Đòn đấm Vovinam của bạn rất có lực và đúng kỹ thuật. Tiếp tục phát huy nhé!";
            } else {
                // Chỉ lấy tối đa 2 lỗi quan trọng nhất để đọc, tránh đọc quá dài
                String mainErrors = warnings.size() > 2
                        ? warnings.get(0) + " và " + warnings.get(1)
                        : String.join(", ", warnings);

                speechResponse = "Bạn đấm khá tốt, nhưng cần lưu ý: " + mainErrors + ". Hãy tập trung chỉnh lại để đòn đánh sắc bén hơn.";
            }

            // 5. Trả về JSON
            JsonObject resJson = new JsonObject();
            resJson.addProperty("status", "success");
            resJson.addProperty("message", speechResponse);
            resJson.addProperty("imagePath", "uploads/" + fileName);

            out.print(gson.toJson(resJson));
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().print("{\"status\":\"error\", \"message\":\"Server gặp lỗi xử lý.\"}");
        }
    }
}

package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "PTPersonalInformationServlet", urlPatterns = {"/PT_Detail"})
public class PTPersonalInformationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dateStr = request.getParameter("date");

        // NHÁNH 1: Nếu có tham số 'date', xử lý AJAX lấy khung giờ từ DATABASE THẬT
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            try {
                // 1. Lấy tham số ptId từ request gửi lên
                String ptIdParam = request.getParameter("ptId");
                int ptId = 2; // Mặc định ban đầu là ID = 2 (Anh Trần Quan Huy)

                // Bẫy mọi trường hợp chuỗi lỗi "null", "undefined" hoặc trống để tránh ném lỗi 400
                if (ptIdParam != null && !ptIdParam.trim().isEmpty()
                        && !ptIdParam.equalsIgnoreCase("null") && !ptIdParam.equalsIgnoreCase("undefined")) {
                    try {
                        ptId = Integer.parseInt(ptIdParam.trim());
                    } catch (NumberFormatException e) {
                        ptId = 2;
                    }
                }

                // 2. Gọi DAO lấy dữ liệu thật từ SQL Server
                dao.PT.PTAvailabilityDAO availabilityDAO = new dao.PT.PTAvailabilityDAO();
                java.util.List<model.entity.PTAvailabilityDTO> slots = availabilityDAO.getSlotsByDate(ptId, dateStr);

                // 3. Render thủ công sang chuỗi JSON đúng chuẩn
                StringBuilder json = new StringBuilder();
                json.append("[");
                for (int i = 0; i < slots.size(); i++) {
                    model.entity.PTAvailabilityDTO s = slots.get(i);
                    json.append("{")
                            .append("\"availabilityId\":").append(s.getAvailabilityId()).append(",")
                            .append("\"shiftName\":\"").append(s.getShiftName()).append("\",")
                            .append("\"startTime\":\"").append(s.getStartTime()).append("\",")
                            .append("\"endTime\":\"").append(s.getEndTime()).append("\",")
                            .append("\"status\":\"").append(s.getStatus()).append("\"")
                            .append("}");
                    if (i < slots.size() - 1) {
                        json.append(",");
                    }
                }
                json.append("]");

                // 4. Bắn chuỗi dữ liệu thật về lại cho Client và chặn luồng luôn
                response.getWriter().write(json.toString());
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("[]");
                return;
            }
        }

        // NHÁNH 2: Nếu load trang lần đầu (Không phải gọi AJAX), hiển thị giao diện index.jsp
        String jspPath = "/WEB-INF/View/customer/pt/ptPersonalInformation/index.jsp";
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Triệt tiêu processRequest cũ để tránh xung đột gửi nhầm dữ liệu HTML về cho AJAX
        doGet(request, response);
    }
}
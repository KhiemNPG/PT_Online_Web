package controller.customer;

import dao.ProgressDAO;
import dao.UserDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.entity.User;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/updateWeight")
public class UpdateWeightServlet extends HttpServlet {

    private final ProgressDAO progressDAO = new ProgressDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        try {

            if (session == null || session.getAttribute("accountId") == null) {
                throw new Exception("Chưa đăng nhập.");
            }

            int accountId = (Integer) session.getAttribute("accountId");

            String userScheduleIdStr = request.getParameter("userScheduleId");
            if (userScheduleIdStr == null || !userScheduleIdStr.matches("\\d+")) {
                throw new Exception("Thiếu userScheduleId.");
            }

            int userScheduleId = Integer.parseInt(userScheduleIdStr);
            int userId = userDAO.getUserIdByAccountId(accountId);

            String weightStr = request.getParameter("currentWeight");

            if (weightStr == null || !weightStr.matches("\\d+(\\.\\d+)?")) {
                throw new Exception("Cân nặng không hợp lệ.");
            }

            double newWeight = Double.parseDouble(weightStr);

            if (newWeight < 2 || newWeight > 500) {
                throw new Exception("Cân nặng phải từ 2 - 500 kg.");
            }

            // ===== LẤY CÂN NẶNG HIỆN TẠI TRONG PROFILE =====
            User user = userDAO.findByAccountId(accountId);

            if (user == null || user.getWeight() == null) {
                throw new Exception("Profile chưa có cân nặng.");
            }

            double profileWeight = user.getWeight();

            // ===== SO SÁNH CHỈ GIỮA NEW WEIGHT VÀ PROFILE =====
            String type;
            double diff;

            if (newWeight > profileWeight) {
                type = "increase";
                diff = newWeight - profileWeight;
            }
            else if (newWeight < profileWeight) {
                type = "decrease";
                diff = profileWeight - newWeight;
            }
            else {
                type = "same";
                diff = 0;
            }

            // ===== GHI ĐÈ FINAL WEIGHT (KHÔNG QUAN TÂM FINALWEIGHT CŨ) =====
            progressDAO.updateFinalWeight(userId, userScheduleId, newWeight);

            // ===== UPDATE PROFILE WEIGHT SAU KHI SO =====
            user.setWeight(newWeight);
            userDAO.upsertByAccountId(user);

            // ===== RETURN JSON =====
            out.print("{\"success\":true,"
                    + "\"type\":\"" + type + "\","
                    + "\"diff\":" + diff + ","
                    + "\"newWeight\":" + newWeight + "}");

        } catch (Exception e) {

            out.print("{\"success\":false,\"message\":\""
                    + e.getMessage().replace("\"", "\\\"")
                    + "\"}");
        }

        out.flush();
        out.close();
    }
}
package controller.customer;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.HealthProfile;
import model.entity.TrainingRequirement;
import model.training.TrainingDay;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "AllTrainingDayServlet", urlPatterns = {"/MyTrainingDay"})
public class AllTrainingDayServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/customer/schedule/allTrainingDay/index.jsp";
        String jspCheck = "/WEB-INF/View/customer/homePage/index.jsp";

        java.time.LocalDate today = java.time.LocalDate.now();

        int month = today.getMonthValue();
        int year = today.getYear();
        List<TrainingDay> trainingDayList = new ArrayList<>();

        String formattedDate = String.format("THÁNG %02d, %d", month, year);

        request.setAttribute("currentDate", formattedDate);

        String idString = request.getParameter("id");

        if ( idString != null && !idString.isEmpty() ){
            int id = Integer.parseInt(idString);

            TrainingDayDAO trainingDayDAO = new TrainingDayDAO();

            trainingDayList = trainingDayDAO.getOneTrainingDayFromUser(id);

            UserDAO userDAO = new UserDAO();

            int userId = userDAO.getUserIdByUserScheduleId(id);

            if (userId != 0){
                HealthProfileDAO healthProfileDAO = new HealthProfileDAO();
                HealthProfile healthProfile = healthProfileDAO.getHealthProfileByUserId(userId);

                TrainingRequirementDAO trainingRequirementDAO = new TrainingRequirementDAO();
                TrainingRequirement trainingRequirement = trainingRequirementDAO.getTrainingRequirementByUserId(userId);
                System.out.println("DEBUG: Joint Issues is " + healthProfile.getJointIssues());
                if (healthProfile != null){
                    request.setAttribute("healthProfile", healthProfile.getJointIssues());
                }

                if (trainingRequirement != null){
                    request.setAttribute("trainingRequirement", trainingRequirement.getPreferredDays());
                }
                request.setAttribute("userIdServlet", userId);
                request.setAttribute("userScheduleId", id);
            }

        } else {
            request.getRequestDispatcher(jspCheck).forward(request, response);
            return;
        }

        request.setAttribute("trainingDayList", trainingDayList);

        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            request.setCharacterEncoding("UTF-8");

            String contentType = request.getContentType();
            String action = null;
            JsonObject jsonBody = null; // Để dùng cho trường hợp JSON

            // BƯỚC 1: XÁC ĐỊNH ACTION
            if (contentType != null && contentType.contains("application/json")) {
                // Nếu là JSON, phải đọc Reader mới lấy được action
                Gson gson = new Gson();
                jsonBody = gson.fromJson(request.getReader(), JsonObject.class);
                if (jsonBody != null && jsonBody.has("action")) {
                    action = jsonBody.get("action").getAsString();
                }
            } else {
                // Nếu là Form bình thường
                action = request.getParameter("action");
            }

            if (action.equalsIgnoreCase("updateInjury")){
                String jointIssues = request.getParameter("jointIssues");

                String userIdStr = request.getParameter("userId");

                int userId = 0;

                if (userIdStr != null){
                    userId = Integer.parseInt(userIdStr);
                }

                if (userId != 0 && jointIssues != null){
                    HealthProfileDAO healthProfileDAO = new HealthProfileDAO();
                    boolean checkUpdate = healthProfileDAO.updateJointIssues(jointIssues, userId);

                    if (checkUpdate) {
                        // Gửi mã 200 về để JavaScript chạy vào đoạn .then()
                        response.setStatus(HttpServletResponse.SC_OK);
                    } else {
                        // Gửi mã 500 nếu update DB thất bại
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update failed");
                    }
                } else {
                    // Gửi mã 400 nếu dữ liệu truyền lên bị thiếu
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid data");
                }
            } else {
                if (action.equalsIgnoreCase("updateSchedule")){
                    if (jsonBody != null) {
                        int userId = jsonBody.get("userId").getAsInt();
                        int userScheduleId = jsonBody.get("userScheduleId").getAsInt();
                        JsonArray newSchedule = jsonBody.getAsJsonArray("newSchedule");

                        // Code update DB cho dời lịch ở đây...
                        System.out.println("Đã xử lý Schedule qua JSON Body");
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                }
            }
    }
}

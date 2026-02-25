package controller.customer;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.tracking.MasterScheduleDetail;
import model.tracking.Progress;
import model.training.TrainingDay;
import model.training.TrainingSchedule;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "AllScheduleServlet", urlPatterns = {"/MySchedule"})
public class AllScheduleServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/customer/schedule/allSchedule/index.jsp";
        UserDAO userDAO = new UserDAO();
        TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
        MasterScheduleDetailDAO masterScheduleDetailDAO = new MasterScheduleDetailDAO();

        // 1. Kiểm tra session xem đã đăng nhập chưa
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");

        if (accountId == null) {
            // Nếu chưa đăng nhập, đá về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Lấy userId
        int userId = userDAO.getUserIdByAccountId(accountId);
        String nameSchedule = "";

        if (userId != 0) {
            // 3. Lấy danh sách lịch tập
            List<TrainingSchedule> trainingScheduleList = trainingScheduleDAO.getAllTrainingSchedule(userId);
            if ( trainingScheduleList != null && !trainingScheduleList.isEmpty()){
                for (TrainingSchedule ts : trainingScheduleList){
                    if (ts.getStatus().equalsIgnoreCase("Active")){
                        nameSchedule = ts.getName();
                        ProgressDAO progressDAO = new ProgressDAO();
                        Progress progress = progressDAO.getProgressByUserIdAndUserScheduleId(userId, ts.getMasterScheduleId());
                        request.setAttribute("progress", progress);

                        MasterScheduleDetail masterScheduleDetail = masterScheduleDetailDAO.getMasterScheduleDetailByMasterScheduleId(ts.getMasterScheduleIdForAllSchedul());
                        request.setAttribute("masterScheduleDetail", masterScheduleDetail);

                        TrainingDayDAO trainingDayDAO = new TrainingDayDAO();
                        //List<TrainingDay> trainingDayList = trainingDayDAO.getOneTrainingDayFromUser(ts.getMasterScheduleId());
                        List<TrainingDay> trainingDayList = trainingDayDAO.getOneTrainingDayFromUser(6);
                        request.setAttribute("trainingDayList", trainingDayList);

                        break;
                    }
                }
            }

            // 4. Đẩy dữ liệu sang JSP
            request.setAttribute("TrainingSchedule", trainingScheduleList);
            request.setAttribute("NameSchedule", nameSchedule);
            request.getRequestDispatcher(jspPath).forward(request, response);
        } else {
            // Trường hợp có tài khoản nhưng chưa có thông tin User trong DB
            request.setAttribute("error", "Vui lòng hoàn tất hồ sơ sức khỏe trước khi xem lịch tập.");
            response.sendRedirect(request.getContextPath() + "/setup-profile");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}

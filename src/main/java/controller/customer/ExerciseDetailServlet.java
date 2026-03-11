package controller.customer;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.HealthProfile;
import model.training.Exercise;
import model.training.TrainingWorkoutExercise;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "ExerciseDetailServlet", urlPatterns = {"/ExerciseDetail"})
public class ExerciseDetailServlet extends HttpServlet {

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

        String jspPath = "/WEB-INF/View/customer/schedule/ExerciseDetail/index.jsp";
        String jspCheck = "/WEB-INF/View/customer/homePage/index.jsp";
        String idString = request.getParameter("id");
        String userDayIdString = request.getParameter("userDayId");

        List<Exercise> exerciseList = new ArrayList<>();
        List<TrainingWorkoutExercise> trainingWorkoutExerciseList = new ArrayList<>();
        TrainingWorkoutExerciseDAO trainingWorkoutExerciseDAO = new TrainingWorkoutExerciseDAO();
        Exercise lastExercise = new Exercise();

        boolean isCompleted = false;
        int id = -1, userDayId = -1;
        Exercise exercise = new Exercise();
        TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
        String jointIssues = "None";

        if (idString != null && userDayIdString != null) {
            id = Integer.parseInt(idString);
            userDayId = Integer.parseInt(userDayIdString);
            TrainingDayDAO trainingDayDAO = new TrainingDayDAO();
            Object statusObj = trainingDayDAO.getStatusByUserDayId(userDayId);
            isCompleted = (statusObj != null) ? (Boolean) statusObj : false;
        } else {
            request.getRequestDispatcher(jspCheck).forward(request, response);
            return;
        }

        if (id != -1 && userDayId != -1) {
            ExerciseDAO exDAO = new ExerciseDAO();
            exercise = exDAO.getExerciseByExerciseId(id);
            int userScheduleId = 0, userId = 0;
            userScheduleId = trainingScheduleDAO.getUserScheduleIdByUserDayId(userDayId);
            if (userScheduleId != 0) {
                UserDAO userDAO = new UserDAO();
                userId = userDAO.getUserIdByUserScheduleId(userScheduleId);
                if (userId != 0) {
                    HealthProfileDAO healthProfileDAO = new HealthProfileDAO();
                    HealthProfile healthProfile = healthProfileDAO.getHealthProfileByUserId(userId);
                    if (healthProfile != null && healthProfile.getJointIssues() != null) {
                        jointIssues = healthProfile.getJointIssues();
                    }
                }
                trainingWorkoutExerciseList = trainingWorkoutExerciseDAO.getTrainingWorkoutExerciseByUserDayId(userDayId);
                exerciseList = trainingWorkoutExerciseDAO.getExerciseByExerciseId(trainingWorkoutExerciseList, jointIssues);
            }

            if (exerciseList != null && !exerciseList.isEmpty()) {
                lastExercise = exerciseList.get(exerciseList.size() - 1);
                request.setAttribute("lastId", lastExercise.getExerciseId());
            } else {
                request.setAttribute("lastId", 0);
            }

            request.setAttribute("exerciseList", exerciseList);
            request.setAttribute("exercise", exercise);
            request.setAttribute("isCompleted", isCompleted);

            request.getRequestDispatcher(jspPath).forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userDayIdStr = request.getParameter("userDayId");
        boolean checkUpdate2 = false;
        int userDayId = 0;
        if (userDayIdStr != null){
            userDayId = Integer.parseInt(userDayIdStr);
        }

        if (userDayId != 0){
            TrainingDayDAO trainingDayDAO = new TrainingDayDAO();
            boolean checkUpdate = trainingDayDAO.updateUserDayByUserDayId(userDayId);
            if(checkUpdate){
                TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
                int userScheduleIdTemp = trainingScheduleDAO.getUserScheduleIdByUserDayId(userDayId);
                checkUpdate2 = trainingScheduleDAO.updateProgress(userScheduleIdTemp);
            }
        }

        if (checkUpdate2) {
            response.setStatus(HttpServletResponse.SC_OK); // Trả về 200 nếu mọi thứ ok
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update progress failed");
        }
    }
}

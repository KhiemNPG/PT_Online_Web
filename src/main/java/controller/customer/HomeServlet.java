package controller.customer;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.training.Exercise;
import model.training.TrainingDay;
import model.training.TrainingSchedule;
import model.training.TrainingWorkoutExercise;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/customer/homePage/index.jsp";
        UserDAO userDAO = new UserDAO();
        TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
        TrainingDayDAO trainingDayDAO = new TrainingDayDAO();
        TrainingWorkoutExerciseDAO trainingWorkoutExerciseDAO = new TrainingWorkoutExerciseDAO();
        ExerciseDAO exerciseDAO = new ExerciseDAO();
        int userId = -1;
        TrainingDay trainingDayToday = null;
        List<Exercise> exerciseListToday = new ArrayList();
        List<Exercise> exerciseListTomorrow = new ArrayList();
        List<TrainingSchedule> userScheduleList = new ArrayList<>();
        List<TrainingDay> trainingDayList = new ArrayList<>();
        List<TrainingWorkoutExercise> trainingWorkoutExerciseList = new ArrayList<>();

        Object accountIdObj = request.getSession().getAttribute("accountId");
        Integer accountId = null;

        if (accountIdObj != null) {
            accountId = (Integer) accountIdObj;
            userId = userDAO.getUserIdByAccountId(accountId);
            if (userId != -1){
                userScheduleList = trainingScheduleDAO.getAllTrainingSchedule(userId);
                if (userScheduleList != null){
                    for (TrainingSchedule ts : userScheduleList){
                        if ( ts.getStatus().equalsIgnoreCase("Active")){
                            trainingDayList = trainingDayDAO.getOneTrainingDayFromUser(ts.getMasterScheduleId());
                            if (trainingDayList != null){
                                LocalDate today = LocalDate.now();
                                //LocalDate today = LocalDate.of(2026, 3, 7);
                                for (TrainingDay td : trainingDayList){
                                    LocalDate date = (td.getScheduledDate() != null) ? td.getScheduledDate().toLocalDateTime().toLocalDate() : today;
                                    if (date.isEqual(today.plusDays(1))){
                                        trainingWorkoutExerciseList = trainingWorkoutExerciseDAO.getTrainingWorkoutExerciseByUserDayId(td.getMasterDayId());
                                        if (trainingWorkoutExerciseList != null){
                                            for (TrainingWorkoutExercise twe : trainingWorkoutExerciseList){
                                                Exercise exercise = exerciseDAO.getExerciseByExerciseId(twe.getExerciseId());
                                                exerciseListTomorrow.add(exercise);
                                            }
                                        }
                                    }

                                    if (date.isEqual(today)){
                                        trainingDayToday = td;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        request.setAttribute("exerciseListTomorrow", exerciseListTomorrow);
        request.setAttribute("trainingDayToday", trainingDayToday);
        request.getRequestDispatcher(jspPath).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}

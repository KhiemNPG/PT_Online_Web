package controller.customer;

import dao.TrainingWorkoutExerciseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
@WebServlet(name = "AllExerciseForTrainingDayServlet", urlPatterns = {"/Exercises"})
public class AllExerciseForTrainingDayServlet extends HttpServlet {

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

        String jspPath = "/WEB-INF/View/customer/schedule/allExercise/index.jsp";
        String idString = request.getParameter("id");
        int id = -1;
        List<Exercise> exerciseList = new ArrayList<>();
        List<TrainingWorkoutExercise> trainingWorkoutExerciseList = new ArrayList<>();
        TrainingWorkoutExerciseDAO trainingWorkoutExerciseDAO = new TrainingWorkoutExerciseDAO();

        if ( idString != null){
            id = Integer.parseInt(idString);
        }

        if ( id != -1){
            trainingWorkoutExerciseList = trainingWorkoutExerciseDAO.getTrainingWorkoutExerciseByUserDayId(id);
            exerciseList = trainingWorkoutExerciseDAO.getExerciseByExerciseId(trainingWorkoutExerciseList);

        }

        request.setAttribute("trainingWorkoutExerciseList", trainingWorkoutExerciseList);
        request.setAttribute("exerciseList", exerciseList);
        request.setAttribute("userDayId", id);


        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}

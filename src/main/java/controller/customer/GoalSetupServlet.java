package controller.customer;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.entity.HealthProfile;
import model.entity.TrainingRequirement;
import model.entity.User;
import model.training.TrainingDay;
import model.training.TrainingSchedule;
import model.training.TrainingWorkoutExercise;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GoalSetupServlet", urlPatterns = {"/setup/goal"})
public class GoalSetupServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final TrainingRequirementDAO trDAO = new TrainingRequirementDAO();
    private final HealthProfileDAO hpDAO = new HealthProfileDAO();

    private static final String DEFAULT_TEXT = "Không";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            User user = ensureUserExists(request, accountId);

            TrainingRequirement active = trDAO.findActiveByUserId(user.getUserId());

            if (active != null) {
                request.setAttribute("error",
                        "Bạn đang có mục tiêu chưa hoàn thành. Hãy hoàn thành mục tiêu hiện tại trước khi tạo mục tiêu mới.");
            }

            request.getRequestDispatcher("/WEB-INF/View/customer/profile/goal.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        // ====== LẤY DỮ LIỆU ======
        String goal = trimOrNull(request.getParameter("goal"));
        String availableTime = defaultIfBlank(request.getParameter("availableTime"), DEFAULT_TEXT);
        String preferredDays = defaultIfBlank(request.getParameter("preferredDays"), DEFAULT_TEXT);

        String ageRange = trimOrNull(request.getParameter("ageRange"));
        String gender = trimOrNull(request.getParameter("gender"));
        String jointIssues = defaultIfBlank(request.getParameter("jointIssues"), DEFAULT_TEXT);

        // ====== VALIDATE ======
        if (!isValidGoal(goal)) {
            request.getSession().setAttribute("error", "Bạn chưa chọn mục tiêu hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        if (ageRange == null || gender == null) {
            request.getSession().setAttribute("error", "Vui lòng chọn Khung tuổi và Giới tính.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        if (preferredDays.equals(DEFAULT_TEXT)) {
            request.getSession().setAttribute("error", "Vui lòng chọn Ngày bắt đầu tập.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        try {
            User user = ensureUserExists(request, accountId);

            // ❗ Nếu đang có goal active thì không cho tạo mới
            TrainingRequirement active = trDAO.findActiveByUserId(user.getUserId());
            if (active != null) {
                request.getSession().setAttribute("error",
                        "Bạn đang có mục tiêu chưa hoàn thành.");
                response.sendRedirect(request.getContextPath() + "/setup/goal");
                return;
            }

            // =========================
            // 1️⃣ INSERT TrainingRequirement
            // =========================
            TrainingRequirement tr = new TrainingRequirement();
            tr.setUserId(user.getUserId());
            tr.setGoal(goal);
            tr.setAvailableTime(availableTime);
            tr.setPreferredDays(preferredDays);

            int newRequirementId = trDAO.insertNew(tr); // phải return ID

            // =========================
            // 2️⃣ INSERT HealthProfile (gắn requirementId)
            // =========================
            HealthProfile hp = new HealthProfile();
            hp.setUserId(user.getUserId());
            hp.setRequirementId(newRequirementId); // 🔥 QUAN TRỌNG
            hp.setAgeRange(ageRange);
            hp.setGender(gender);
            hp.setJointIssues(jointIssues);

            hpDAO.insertNew(hp);

            TrainingRequirementDAO trainingRequirementDAO = new TrainingRequirementDAO();
            HealthProfileDAO healthProfileDAO = new HealthProfileDAO();
            TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
            ProgressScheduleDAO progressScheduleDAO = new ProgressScheduleDAO();
            TrainingDayDAO trainingDayDAO = new TrainingDayDAO();

            TrainingRequirement trainingRequirement= trainingRequirementDAO.getTrainingRequirementByUserId(user.getUserId());
            HealthProfile healthProfile = healthProfileDAO.getHealthProfileByUserId(user.getUserId());
            TrainingSchedule trainingSchedule = trainingScheduleDAO.getOneTrainingScheduleFromTemplate(trainingRequirement.getGoal(), healthProfile.getGender(), healthProfile.getAgeRange());

            int userScheduleId = trainingScheduleDAO.createTrainingSchedule(trainingSchedule, user.getUserId());

            if (userScheduleId != -1){

                List<TrainingDay> trainingDayList = trainingDayDAO.getOneTrainingDayFromTemplate(trainingSchedule.getMasterScheduleId());

                if (trainingDayList != null ){
                    int masterScheduleIdTemp = trainingDayList.get(0).getUserScheduleId();

                    List<TrainingDay> checkTrainingDayList = trainingDayDAO.createTrainingDay(trainingDayList, tr.getPreferredDays(), userScheduleId);
                    if (checkTrainingDayList != null && !checkTrainingDayList.isEmpty()) {
                        java.sql.Timestamp originalDate = checkTrainingDayList.get(0).getScheduledDate();
                        // Ép kiểu về java.sql.Date
                        java.sql.Date sqlDate = new java.sql.Date(originalDate.getTime());
                        progressScheduleDAO.createProgressSchedule(user.getUserId(), userScheduleId, sqlDate);

                        //TrainingWorkoutExerciseDAO trainingWorkoutExerciseDAO = new TrainingWorkoutExerciseDAO();
                        List<TrainingWorkoutExercise> trainingWorkoutExerciseList = trainingDayDAO.getTrainingWorkoutExercise(masterScheduleIdTemp);
                        if (trainingWorkoutExerciseList != null){
                            trainingDayDAO.createTrainingWorkoutExercise(trainingWorkoutExerciseList, checkTrainingDayList);
                        }
                    }
                }
            }
            request.getSession().setAttribute("success", "Tạo mục tiêu mới thành công!");

            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lưu thiết lập thất bại: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/setup/goal");
        }
    }

    private User ensureUserExists(HttpServletRequest request, Integer accountId) throws Exception {
        User user = userDAO.findByAccountId(accountId);

        if (user == null) {
            User newUser = new User();
            newUser.setAccountId(accountId);

            String username = (String) request.getSession().getAttribute("username");
            newUser.setName(username);

            int newId = userDAO.insert(newUser);
            if (newId <= 0) throw new Exception("Không thể tạo User mới.");

            user = userDAO.findByAccountId(accountId);
        }
        return user;
    }

    private boolean isValidGoal(String goal) {
        return goal != null && (
                goal.equals("GIAM_MO") ||
                        goal.equals("TANG_CO") ||
                        goal.equals("DUY_TRI") ||
                        goal.equals("SUC_BEN")
        );
    }

    private String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private String defaultIfBlank(String s, String defaultValue) {
        String t = trimOrNull(s);
        return (t == null) ? defaultValue : t;
    }
}

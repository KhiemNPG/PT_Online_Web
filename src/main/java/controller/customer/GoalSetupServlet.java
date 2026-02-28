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
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "GoalSetupServlet", urlPatterns = {"/setup/goal"})
public class GoalSetupServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final TrainingRequirementDAO trDAO = new TrainingRequirementDAO();
    private final HealthProfileDAO hpDAO = new HealthProfileDAO();
    private final TrainingScheduleDAO trainingScheduleDAO = new TrainingScheduleDAO();
    private final TrainingDayDAO trainingDayDAO = new TrainingDayDAO();
    private final ProgressScheduleDAO progressScheduleDAO = new ProgressScheduleDAO();

    private static final String DEFAULT_TEXT = "Không";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer accountId = (Integer) session.getAttribute("accountId");

        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            User user = ensureUserExists(request, accountId);

            TrainingRequirement active = trDAO.findActiveByUserId(user.getUserId());

            if (active != null) {
                request.setAttribute("error",
                        "Bạn đang có lộ trình chưa hoàn thành. Hãy hoàn thành lộ trình hiện tại trước khi tạo lộ trình mới.");
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

        HttpSession session = request.getSession();
        Integer accountId = (Integer) session.getAttribute("accountId");

        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String goal = trimOrNull(request.getParameter("goal"));
        String availableTime = defaultIfBlank(request.getParameter("availableTime"), DEFAULT_TEXT);
        String preferredDays = defaultIfBlank(request.getParameter("preferredDays"), DEFAULT_TEXT);
        String ageRange = trimOrNull(request.getParameter("ageRange"));
        String gender = trimOrNull(request.getParameter("gender"));
        String jointIssues = defaultIfBlank(request.getParameter("jointIssues"), DEFAULT_TEXT);

        if (!isValidGoal(goal)) {
            session.setAttribute("error", "Bạn chưa chọn mục tiêu hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        if (ageRange == null || gender == null) {
            session.setAttribute("error", "Vui lòng chọn Khung tuổi và Giới tính.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        if (preferredDays.equals(DEFAULT_TEXT)) {
            session.setAttribute("error", "Vui lòng chọn Ngày bắt đầu tập.");
            response.sendRedirect(request.getContextPath() + "/setup/goal");
            return;
        }

        try {

            User user = ensureUserExists(request, accountId);

            TrainingRequirement active = trDAO.findActiveByUserId(user.getUserId());
            if (active != null) {
                session.setAttribute("error",
                        "Bạn đang có lộ trình chưa hoàn thành.");
                response.sendRedirect(request.getContextPath() + "/setup/goal");
                return;
            }
            TrainingRequirement tr = new TrainingRequirement();
            tr.setUserId(user.getUserId());
            tr.setGoal(goal);
            tr.setAvailableTime(availableTime);
            tr.setPreferredDays(preferredDays);

            int requirementId = trDAO.insertNew(tr);

            HealthProfile hp = new HealthProfile();
            hp.setUserId(user.getUserId());
            hp.setRequirementId(requirementId);
            hp.setAgeRange(ageRange);
            hp.setGender(gender);
            hp.setJointIssues(jointIssues);

            hpDAO.insertNew(hp);

            TrainingSchedule templateSchedule =
                    trainingScheduleDAO.getOneTrainingScheduleFromTemplate(goal, gender, ageRange);

            int userScheduleId =
                    trainingScheduleDAO.createTrainingSchedule(templateSchedule, user.getUserId());

            if (userScheduleId != -1) {

                List<TrainingDay> templateDays =
                        trainingDayDAO.getOneTrainingDayFromTemplate(templateSchedule.getMasterScheduleId());

                if (templateDays != null && !templateDays.isEmpty()) {

                    List<TrainingDay> userDays =
                            trainingDayDAO.createTrainingDay(templateDays, preferredDays, userScheduleId);

                    if (userDays != null && !userDays.isEmpty()) {

                        Timestamp ts = userDays.get(0).getScheduledDate();
                        Date sqlDate = new Date(ts.getTime());

                        progressScheduleDAO.createProgressSchedule(
                                user.getUserId(), userScheduleId, sqlDate
                        );

                        List<TrainingWorkoutExercise> exercises =
                                trainingDayDAO.getTrainingWorkoutExercise(
                                        templateDays.get(0).getUserScheduleId()
                                );

                        if (exercises != null) {
                            trainingDayDAO.createTrainingWorkoutExercise(exercises, userDays);
                        }
                    }
                }
            }

            User fullUser = userDAO.findByAccountId(accountId);

            boolean profileIncomplete = false;

            if (isBlank(fullUser.getName())
                    || fullUser.getAge() == null
                    || isBlank(fullUser.getGender())
                    || fullUser.getHeight() == null
                    || fullUser.getWeight() == null
                    || isBlank(fullUser.getFitnessLevel())) {

                profileIncomplete = true;
            }

            session.setAttribute("goalSuccess", true);
            session.setAttribute("profileIncomplete", profileIncomplete);
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error",
                    "Lưu thiết lập thất bại: " + e.getMessage());
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

            if (newId <= 0)
                throw new Exception("Không thể tạo User mới.");

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
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
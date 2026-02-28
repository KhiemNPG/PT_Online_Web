package controller.customer;

import dao.*;
import model.tracking.UserSchedule;
import model.tracking.MasterScheduleDetail;
import model.tracking.Progress;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "TrackingServlet", urlPatterns = {"/tracking"})
public class TrackingServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        int accountId = (Integer) session.getAttribute("accountId");

        UserDAO userDAO = new UserDAO();
        int userId = userDAO.getUserIdByAccountId(accountId);

        if (userId == 0) {
            request.setAttribute("message", "Bạn chưa tạo hồ sơ.");
            request.getRequestDispatcher("/WEB-INF/View/customer/schedule/trackingCustomer/index.jsp")
                    .forward(request, response);
            return;
        }

        String param = request.getParameter("userScheduleId");

        UserScheduleDAO usDAO = new UserScheduleDAO();

        if (param == null) {

            List<UserSchedule> schedules =
                    usDAO.getUserSchedulesByUserId(userId);

            ProgressDAO progressDAO = new ProgressDAO();
            List<Progress> progressList =
                    progressDAO.getProgressByUserId(userId);

            request.setAttribute("schedules", schedules);
            request.setAttribute("progressList", progressList);

            request.getRequestDispatcher("/WEB-INF/View/customer/schedule/trackingCustomer/index.jsp")
                    .forward(request, response);
            return;
        }

        int userScheduleId = Integer.parseInt(param);

        List<UserSchedule> schedules =
                usDAO.getUserSchedulesByUserId(userId);

        UserSchedule selected = null;

        for (UserSchedule us : schedules) {
            if (us.getUserScheduleId() == userScheduleId) {
                selected = us;
                break;
            }
        }

        if (selected == null) {
            response.sendRedirect(request.getContextPath() + "/tracking");
            return;
        }

        int masterScheduleId = selected.getMasterScheduleId();

        MasterScheduleDetailDAO msdDAO = new MasterScheduleDetailDAO();
        MasterScheduleDetail detail =
                msdDAO.getMasterScheduleDetailForTracking(masterScheduleId);

        ProgressDAO progressDAO = new ProgressDAO();
        Progress progress =
                progressDAO.getProgressByUserIdAndUserScheduleId(userId, userScheduleId);

        request.setAttribute("detail", detail);
        request.setAttribute("progress", progress);
        request.setAttribute("selectedSchedule", selected);

        request.getRequestDispatcher("/WEB-INF/View/customer/schedule/UpdateWeight/index.jsp")
                .forward(request, response);
    }
}
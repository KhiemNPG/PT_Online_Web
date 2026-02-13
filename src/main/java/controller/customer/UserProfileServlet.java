package controller.customer;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.entity.User;

import java.io.IOException;

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/profile"})
public class UserProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer accountId = (Integer) request.getSession().getAttribute("accountId");

        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            User user = userDAO.findByAccountId(accountId);

            if (user == null) {
                user = new User();
                user.setAccountId(accountId);

                String username = (String) request.getSession().getAttribute("username");
                if (username != null) user.setName(username);
            }

            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/View/customer/profile/index.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi tải hồ sơ: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/home");
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

        try {
            User u = new User();
            u.setAccountId(accountId);

            u.setName(trimOrNull(request.getParameter("name")));
            u.setGender(trimOrNull(request.getParameter("gender")));
            u.setFitnessLevel(trimOrNull(request.getParameter("fitnessLevel")));

            u.setAge(parseInt(request.getParameter("age")));
            u.setHeight(parseDouble(request.getParameter("height")));
            u.setWeight(parseDouble(request.getParameter("weight")));

            userDAO.upsertByAccountId(u);

            request.getSession().setAttribute("success", "Lưu hồ sơ thành công!");
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lưu hồ sơ thất bại: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    private String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private Integer parseInt(String s) {
        try {
            if (s == null) return null;
            s = s.trim();
            if (s.isEmpty()) return null;
            return Integer.parseInt(s);
        } catch (Exception e) {
            return null;
        }
    }

    private Double parseDouble(String s) {
        try {
            if (s == null) return null;
            s = s.trim();
            if (s.isEmpty()) return null;
            return Double.parseDouble(s);
        } catch (Exception e) {
            return null;
        }
    }
}

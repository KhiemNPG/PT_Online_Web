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

        HttpSession session = request.getSession();
        Integer accountId = (Integer) session.getAttribute("accountId");

        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            User user = userDAO.findByAccountId(accountId);

            if (user == null) {
                user = new User();
                user.setAccountId(accountId);

                String username = (String) session.getAttribute("username");
                if (username != null) {
                    user.setName(username);
                }
            }

            String standardParam = request.getParameter("bmiStandard");

            if ("ASIA".equalsIgnoreCase(standardParam) ||
                    "WHO".equalsIgnoreCase(standardParam)) {
                session.setAttribute("bmiStandard", standardParam.toUpperCase());
            }

            String bmiStandard = (String) session.getAttribute("bmiStandard");
            if (bmiStandard == null) {
                bmiStandard = "ASIA";
                session.setAttribute("bmiStandard", "ASIA");
            }

            request.setAttribute("bmiStandard", bmiStandard);
            request.setAttribute("user", user);

            request.getRequestDispatcher("/WEB-INF/View/customer/profile/index.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            session.setAttribute("error", "Lỗi tải hồ sơ: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/home");
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

        try {

            User u = userDAO.findByAccountId(accountId);
            if (u == null) {
                u = new User();
                u.setAccountId(accountId);
            }

            String name = trimOrNull(request.getParameter("name"));
            String gender = trimOrNull(request.getParameter("gender"));
            String fitnessLevel = trimOrNull(request.getParameter("fitnessLevel"));

            if (name == null) {
                throw new Exception("Họ và tên không được để trống.");
            }

            Integer age = parseAge(request.getParameter("age"));

            Double height = parsePositiveDouble(
                    request.getParameter("height"),
                    "Chiều cao"
            );

            Double weight = parsePositiveDouble(
                    request.getParameter("weight"),
                    "Cân nặng"
            );

            if (age < 2 || age > 120) {
                throw new Exception("Tuổi phải từ 2 - 120.");
            }

            if (height < 30 || height > 300) {
                throw new Exception("Chiều cao phải từ 30 - 300 cm.");
            }

            if (weight < 2 || weight > 500) {
                throw new Exception("Cân nặng phải từ 2 - 500 kg.");
            }

            u.setName(name);
            u.setGender(gender);
            u.setFitnessLevel(fitnessLevel);
            u.setAge(age);
            u.setHeight(height);
            u.setWeight(weight);

            userDAO.upsertByAccountId(u);

            session.setAttribute("success", "Lưu hồ sơ thành công!");
            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }

    private String trimOrNull(String s) {
        if (s == null) return null;
        s = s.trim();
        return s.isEmpty() ? null : s;
    }

    private Integer parseAge(String s) throws Exception {

        if (s == null || s.trim().isEmpty()) {
            throw new Exception("Tuổi không được để trống.");
        }

        if (!s.matches("\\d+")) {
            throw new Exception("Tuổi phải là số nguyên dương.");
        }

        int value = Integer.parseInt(s);

        if (value <= 0) {
            throw new Exception("Tuổi phải lớn hơn 0.");
        }

        return value;
    }

    private Double parsePositiveDouble(String s, String fieldName) throws Exception {

        if (s == null || s.trim().isEmpty()) {
            throw new Exception(fieldName + " không được để trống.");
        }

        if (!s.matches("\\d+(\\.\\d+)?")) {
            throw new Exception(fieldName + " phải là số hợp lệ.");
        }

        double value = Double.parseDouble(s);

        if (value <= 0) {
            throw new Exception(fieldName + " phải lớn hơn 0.");
        }

        return value;
    }
}

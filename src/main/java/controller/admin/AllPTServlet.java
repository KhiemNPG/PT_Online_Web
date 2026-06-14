package controller.admin;

import dao.Admin.PTDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.PersonalTrainer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "AllPTServlet", urlPatterns = {"/admin/personal-trainer"})
public class AllPTServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/admin/pt/allPt/index.jsp";
        PTDAO ptDao = new PTDAO();
        List<PersonalTrainer> personalTrainerList = ptDao.getAllPT();
        request.setAttribute("personalTrainerList", personalTrainerList);
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        PTDAO ptDao = new PTDAO();
        List<PersonalTrainer> ptList = ptDao.getAllPT();
        int accountId = parseIntDefault(request.getParameter("accountId"), 0);

        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer");
            return;  // ✅ Phải return
        }

        // ✅ CHECK: Tài khoản đã là PT chưa? (Dùng list có sẵn)
        boolean isExist = false;
        for (PersonalTrainer p : ptList) {
            if (p.getAccountId() == accountId) {
                isExist = true;
                break;  // ✅ Tìm thấy rồi thì thoát loop ngay
            }
        }

        // ✅ Nếu đã là PT → Báo lỗi rõ ràng
        if (isExist) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=already_exists&accountId=" + accountId);
            return;  // ✅ QUAN TRỌNG: Phải return
        }

        // ✅ Nếu chưa là PT → Xử lý action
        try {
            switch (action) {
                case "add":
                    handleAddPT(request, response);
                    return;  // ✅ QUAN TRỌNG: Phải return

                case "update":
                    // handleUpdatePT(request, response);
                    return;

                case "delete":
                    // handleDeletePT(request, response);
                    return;

                default:
                    response.sendRedirect(request.getContextPath() + "/admin/personal-trainer");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=server_error");
        }

        // ❌ XÓA DÒNG NÀY - Không cần nữa
        // response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=server_error");
    }

    private void handleAddPT(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 1. Lấy dữ liệu từ form
        String ptName = request.getParameter("ptName");
        String titleLabel = request.getParameter("title");
        String slogan = request.getParameter("slogan");
        String tags = request.getParameter("tags");
        String bioSummary = request.getParameter("bio");
        String avatarUrl = request.getParameter("avatarUrl");
        String phone = request.getParameter("phoneZalo");
        String email = request.getParameter("email");
        String facebookUrl = request.getParameter("facebookUrl");
        String instagramUrl = request.getParameter("instagramUrl");

        Integer experienceYears = parseInteger(request.getParameter("experienceYears"));
        Integer successfulStudents = parseInteger(request.getParameter("successfulStudents"));
        int accountId = parseIntDefault(request.getParameter("accountId"), 0);

        boolean isActive = "1".equals(request.getParameter("isActive"));

        // ✅ VALIDATE THÊM: Check accountId
        if (accountId <= 0) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=account_required");
            return;
        }

        // 2. Validate các trường bắt buộc
        if (ptName == null || ptName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=name_required");
            return;
        }
        if (phone == null || phone.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=phone_required");
            return;
        }
        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=email_required");
            return;
        }

        // 3. Tạo object PersonalTrainer
        PersonalTrainer pt = new PersonalTrainer(
                0,                      // ptId = 0 (DB tự sinh)
                accountId,              // accountId
                ptName,                 // name
                avatarUrl,              // avatarUrl
                titleLabel,             // titleLabel
                slogan,                 // slogan
                experienceYears,        // experienceYears (Integer)
                successfulStudents,     // successfulStudents (Integer)
                tags,                   // tags
                bioSummary,             // bioSummary
                phone,                  // phone
                email,                  // email
                facebookUrl,            // facebookUrl
                instagramUrl,           // instagramUrl
                isActive                // isActive
        );

        // 4. Gọi DAO để insert
        PTDAO ptDao = new PTDAO();
        boolean success = ptDao.addPersonalTrainer(pt);

        // 5. Redirect kết quả
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?msg=added");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/personal-trainer?error=add_failed");
        }
    }
    // === Helper methods ===

    private Integer parseInteger(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private int parseIntDefault(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) return defaultValue;
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}

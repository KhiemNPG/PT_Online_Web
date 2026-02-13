package controller.customer;

import dao.AccountDAO;
import model.entity.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {

    private final AccountDAO accountDAO = new AccountDAO();

    private static final String COOKIE_REMEMBER_USER = "remember_user";
    private static final int REMEMBER_DAYS = 30;

    private String hashPassword(String raw) {
        return BCrypt.hashpw(raw, BCrypt.gensalt(10));
    }

    private boolean verifyPassword(String raw, String hash) {
        return BCrypt.checkpw(raw, hash);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    private void setCookie(HttpServletRequest req, HttpServletResponse resp, String name, String value, int maxAgeSeconds) {
        Cookie c = new Cookie(name, value);
        c.setHttpOnly(true);
        c.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
        c.setMaxAge(maxAgeSeconds);
        resp.addCookie(c);
    }

    private String getCookie(HttpServletRequest req, String name) {
        Cookie[] cookies = req.getCookies();
        if (cookies == null) return null;
        for (Cookie c : cookies) {
            if (name.equals(c.getName())) return c.getValue();
        }
        return null;
    }

    private void clearCookie(HttpServletRequest req, HttpServletResponse resp, String name) {
        setCookie(req, resp, name, "", 0);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "login";

        switch (action) {
            case "login": {
                HttpSession s = request.getSession(false);
                if (s != null && s.getAttribute("accountId") != null) {
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }

                String rememberedUser = getCookie(request, COOKIE_REMEMBER_USER);
                if (rememberedUser != null && !rememberedUser.trim().isEmpty()) {
                    request.setAttribute("rememberedUser", rememberedUser);
                    request.setAttribute("rememberChecked", Boolean.TRUE);
                }

                request.getRequestDispatcher("/WEB-INF/View/customer/auth/login.jsp").forward(request, response);
                break;
            }

            case "register":
                request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
                break;

            case "changePassword":
                Integer accountId = (Integer) request.getSession().getAttribute("accountId");
                if (accountId == null) {
                    response.sendRedirect(request.getContextPath() + "/auth?action=login");
                    return;
                }
                request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
                break;

            case "logout":
                HttpSession sessionLogout = request.getSession(false);
                if (sessionLogout != null) sessionLogout.invalidate();
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                break;

            case "forgotPassword":
                request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                        .forward(request, response);
                break;


            default:
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "login";

        try {
            if ("register".equals(action)) {
                handleRegister(request, response);
            } else if ("login".equals(action)) {
                handleLogin(request, response);
            } else if ("changePassword".equals(action)) {
                handleChangePassword(request, response);
            } else if ("forgotPassword".equals(action)) {
                handleForgotPassword(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm");

        request.setAttribute("oldUsername", username);

        Account exist = accountDAO.findByUsername(username);
        if (exist != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
            return;
        }

        if (isBlank(username) || password == null || password.length() < 8 || confirm == null || !password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu tối thiểu 8 ký tự và xác nhận phải khớp.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
            return;
        }

        Account a = new Account();
        a.setUsername(username);
        a.setPasswordHash(hashPassword(password));
        a.setRole("CUSTOMER");
        a.setActive(true);

        int newId = accountDAO.insert(a);
        if (newId <= 0) {
            request.setAttribute("error", "Đăng ký thất bại.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/auth?action=login&msg=register_success&username="
                        + java.net.URLEncoder.encode(username, "UTF-8")
        );
    }


    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (isBlank(username) || password == null) {
            request.setAttribute("error", "Vui lòng nhập tên đăng nhập và mật khẩu.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/login.jsp").forward(request, response);
            return;
        }

        Account a = accountDAO.findByUsername(username);

        if (a == null || !a.isActive() || !verifyPassword(password, a.getPasswordHash())) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession old = request.getSession(false);
        if (old != null) old.invalidate();

        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(30 * 60);
        session.setAttribute("accountId", a.getAccountId());
        session.setAttribute("username", a.getUsername());
        session.setAttribute("role", a.getRole());

        String remember = request.getParameter("remember");
        if ("on".equalsIgnoreCase(remember)) {
            int maxAge = REMEMBER_DAYS * 24 * 60 * 60;
            setCookie(request, response, COOKIE_REMEMBER_USER, a.getUsername(), maxAge);
        } else {
            clearCookie(request, response, COOKIE_REMEMBER_USER);
        }

        if ("ADMIN".equalsIgnoreCase(a.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/home");
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Integer accountId = (Integer) request.getSession().getAttribute("accountId");
        if (accountId == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String current = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");

        if (newPass == null || newPass.length() < 8 || confirm == null || !newPass.equals(confirm)) {
            request.setAttribute("error", "New password >= 8 ký tự và Confirm phải khớp.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
            return;
        }

        Account a = accountDAO.findById(accountId);
        if (a == null || current == null || !verifyPassword(current, a.getPasswordHash())) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
            return;
        }

        accountDAO.updatePasswordHash(accountId, hashPassword(newPass));
        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
    }
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String username = request.getParameter("username");
        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");

        if (isBlank(username) || newPass == null || newPass.length() < 8 || confirm == null || !newPass.equals(confirm)) {
            request.setAttribute("error", "Vui lòng nhập username và mật khẩu mới (>= 8 ký tự), xác nhận phải khớp.");
            request.setAttribute("oldUser", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp").forward(request, response);
            return;
        }

        Account a = accountDAO.findByUsername(username);
        if (a == null || !a.isActive()) {
            request.setAttribute("error", "Tài khoản không tồn tại hoặc đang bị khóa.");
            request.setAttribute("oldUser", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp").forward(request, response);
            return;
        }

        boolean ok = accountDAO.updatePasswordHash(a.getAccountId(), hashPassword(newPass));
        if (!ok) {
            request.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại.");
            request.setAttribute("oldUser", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/auth?action=login&msg=reset_success&username=" + username);
    }

}

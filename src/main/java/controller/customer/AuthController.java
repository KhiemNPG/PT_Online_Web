package controller.customer;

import dao.AccountDAO;
import model.entity.Account;
import dao.UserDAO;
import model.entity.User;
import utils.EmailService;

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
            case "verify":
                handleVerifyEmail(request, response);
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
            } else if ("verifyOtp".equals(action)) {
                handleVerifyOtp(request, response);
            }else if ("resetPassword".equals(action)) {
            handleResetPassword(request, response);
            }else {
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
        String email = request.getParameter("email");

        request.setAttribute("oldUsername", username);
        request.setAttribute("oldEmail", email);

        Account existUser = accountDAO.findByUsername(username);
        if (existUser != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
            return;
        }

        Account existEmail = accountDAO.findByEmail(email);
        if (existEmail != null) {
            request.setAttribute("error", "Email này đã được đăng ký.");
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
        a.setEmail(email);
        a.setPasswordHash(hashPassword(password));
        a.setRole("CUSTOMER");

        //account chưa active
        a.setActive(false);

        int newId = accountDAO.insert(a);

        if (newId <= 0) {
            request.setAttribute("error", "Đăng ký thất bại.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        User u = new User();
        u.setAccountId(newId);
        u.setName(username);

        userDAO.insert(u);

        //token verify
        String token = java.util.UUID.randomUUID().toString();

        HttpSession session = request.getSession();
        session.setAttribute("verifyToken", token);
        session.setAttribute("verifyAccountId", newId);

        String verifyLink =
                "http://localhost:8080/PT_Online/auth?action=verify&token=" + token;

        String subject = "Xác minh tài khoản Smart-PT";

        String content =
                "<div style='font-family:Arial;background:#111;padding:40px'>" +
                        "<div style='max-width:600px;margin:auto;background:#1c1c1c;border-radius:10px;padding:30px;color:white;text-align:center'>" +

                        "<h2 style='color:#ff2d2d'>Smart-PT</h2>" +

                        "<p>Xin chào <b>" + username + "</b>,</p>" +

                        "<p>Vui lòng xác minh email để kích hoạt tài khoản:</p>" +

                        "<a href='" + verifyLink + "' " +
                        "style='background:#ff2d2d;color:white;padding:12px 25px;text-decoration:none;border-radius:5px;font-weight:bold'>" +
                        "Xác minh Email</a>" +

                        "<p style='margin-top:30px;font-size:12px;color:#aaa'>© Smart-PT</p>" +

                        "</div></div>";

        EmailService.sendEmail(email, subject, content);

        response.sendRedirect(
                request.getContextPath()
                        + "/auth?action=login&msg=check_email"
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

        if (a == null) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/login.jsp").forward(request, response);
            return;
        }

        if (!a.isActive()) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt. Vui lòng kiểm tra email để xác minh.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/login.jsp").forward(request, response);
            return;
        }

        if (!verifyPassword(password, a.getPasswordHash())) {
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

        boolean ok = accountDAO.updatePasswordHash(accountId, hashPassword(newPass));

        if (!ok) {
            request.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
            return;
        }

        String subject = "Smart-PT - Password has been changed";

        String content =
                "<div style='font-family:Arial;background:#111;padding:40px'>" +
                        "<div style='max-width:600px;margin:auto;background:#1c1c1c;border-radius:10px;padding:30px;color:white;text-align:center'>" +

                        "<img src='https://res.cloudinary.com/dgnyskpc3/image/upload/v1771925947/8955c440-7287-4779-b81f-ada2c991d02c-removebg-preview_holdqj.png' style='width:70px;margin-bottom:20px'>" +

                        "<h2 style='color:#ff2d2d'>Smart-PT</h2>" +

                        "<p>Xin chào <b>" + a.getUsername() + "</b>,</p>" +

                        "<p>Mật khẩu tài khoản của bạn vừa được thay đổi thành công.</p>" +

                        "<p>Nếu đây không phải là bạn thực hiện, hãy đổi mật khẩu ngay lập tức hoặc liên hệ với chúng tôi.</p>" +

                        "<a href='http://localhost:8080/PT_Online' " +
                        "style='background:#ff2d2d;color:white;padding:12px 25px;text-decoration:none;border-radius:5px;font-weight:bold'>" +
                        "Truy cập Website</a>" +

                        "<p style='margin-top:30px;font-size:12px;color:#aaa'>© Smart-PT</p>" +

                        "</div></div>";

        EmailService.sendEmail(a.getEmail(), subject, content);

        request.setAttribute("success", "Đổi mật khẩu thành công.");
        request.getRequestDispatcher("/WEB-INF/View/customer/auth/change_password.jsp").forward(request, response);
    }
    private void handleForgotPassword(HttpServletRequest request,
                                      HttpServletResponse response) throws Exception {

        String email = request.getParameter("email");

        if (isBlank(email)) {
            request.setAttribute("error","Vui lòng nhập email.");
            request.setAttribute("step","email");

            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);

            return;
        }

        Account acc = accountDAO.findByEmail(email);

        if(acc == null){
            request.setAttribute("error","Email không tồn tại.");
            request.setAttribute("step","email");

            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);

            return;
        }

        String otp = String.valueOf((int)(Math.random()*900000)+100000);

        HttpSession session = request.getSession();

        session.setAttribute("resetOTP",otp);
        session.setAttribute("resetEmail",email);
        session.setAttribute("otpTime",System.currentTimeMillis());

        EmailService.sendEmail(
                email,
                "SmartPT - OTP Reset Password",
                "<h2>Mã OTP của bạn: "+otp+"</h2><p>Hết hạn sau 5 phút</p>"
        );

        request.setAttribute("step","otp");

        request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                .forward(request,response);
    }
    private void handleVerifyOtp(HttpServletRequest request,
                                 HttpServletResponse response) throws Exception {

        String inputOtp = request.getParameter("otp");

        HttpSession session = request.getSession();

        String realOtp = (String) session.getAttribute("resetOTP");
        Long otpTime = (Long) session.getAttribute("otpTime");

        if(realOtp == null || otpTime == null){

            request.setAttribute("error","OTP hết hạn.");
            request.setAttribute("step","email");

            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);

            return;
        }

        if(System.currentTimeMillis() - otpTime > 5*60*1000){

            request.setAttribute("error","OTP đã hết hạn.");
            request.setAttribute("step","email");

            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);

            return;
        }

        if(!realOtp.equals(inputOtp)){

            request.setAttribute("error","OTP không đúng.");
            request.setAttribute("step","otp");

            request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);

            return;
        }

        request.setAttribute("step","reset");

        request.getRequestDispatcher("/WEB-INF/View/customer/auth/forgot_password.jsp")
                .forward(request,response);
    }
    private void handleResetPassword(HttpServletRequest request,
                                     HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("resetEmail");

        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");
        if(newPass == null ||
                !newPass.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$")){
            request.setAttribute("error",
                    "Mật khẩu phải có chữ hoa, chữ thường, số và ký tự đặc biệt.");
            request.setAttribute("step","reset");
            request.getRequestDispatcher(
                            "/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);
            return;
        }
        if(!newPass.equals(confirm)){
            request.setAttribute("error","Mật khẩu xác nhận không khớp.");
            request.setAttribute("step","reset");
            request.getRequestDispatcher(
                            "/WEB-INF/View/customer/auth/forgot_password.jsp")
                    .forward(request,response);
            return;
        }
        Account acc = accountDAO.findByEmail(email);
        accountDAO.updatePasswordHash(
                acc.getAccountId(),
                hashPassword(newPass)
        );

        session.removeAttribute("resetOTP");
        session.removeAttribute("resetEmail");
        session.removeAttribute("otpTime");

        response.sendRedirect(
                request.getContextPath()
                        +"/auth?action=login&msg=reset_success"
        );
    }
    private void handleVerifyEmail(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        HttpSession session = request.getSession();

        String realToken = (String) session.getAttribute("verifyToken");
        Integer accountId =
                (Integer) session.getAttribute("verifyAccountId");

        if (realToken == null || !realToken.equals(token)) {
            response.getWriter().write("Link xác minh không hợp lệ.");
            return;
        }

        accountDAO.setActive(accountId, true);

        session.removeAttribute("verifyToken");
        session.removeAttribute("verifyAccountId");

        response.sendRedirect(
                request.getContextPath()
                        + "/auth?action=login&msg=email_verified"
        );
    }
}

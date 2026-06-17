package controller.customer;

import com.google.gson.JsonObject;
import dao.User.AccountDAO;
import dao.User.PaymentDAO;
import dao.User.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.payment.PaymentTransaction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment/create-order"})
public class PaymentServlet extends HttpServlet {

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

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PaymentDAO paymentDao = new PaymentDAO();
        AccountDAO accountDao = new AccountDAO();

        HttpSession session = request.getSession();
        Integer accountId = (Integer) session.getAttribute("accountId");

        if (accountId == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Bạn cần đăng nhập!\", \"requiresLogin\": true}");
            return;
        }

        // ✅ CHECK 1: Tài khoản đã là Pro chưa? (Check từ DB)
        List<Integer> allAccountProList = accountDao.getAllAccountPro();
        boolean isProAccount = allAccountProList.contains(accountId);

        // Lấy danh sách giao dịch của user
        List<PaymentTransaction> allTransactionListByIdList = paymentDao.allTransactionListById(accountId);

        // ✅ CHECK 2: Có giao dịch PENDING nào không?
        boolean hasPendingTransaction = false;
        String pendingOrderCode = null;

        for (PaymentTransaction pt : allTransactionListByIdList) {
            String status = pt.getStatus();
            if (status != null && status.contains("PENDING")) {
                hasPendingTransaction = true;
                pendingOrderCode = String.valueOf(pt.getOrderCode());
                break;
            }
        }

        String action = request.getParameter("action");

        // LUỒNG 1: Khởi tạo dữ liệu hiển thị (Action = 'create')
        if ("create".equals(action)) {

            // ✅ Chặn 1: Đã là tài khoản Pro
            if (isProAccount) {
                response.getWriter().write(
                        "{\"success\": false, \"message\": \"Tài khoản của bạn đã là Pro! Không thể mua thêm.\", \"isPro\": true}");
                return;
            }

            // ✅ Chặn 2: Đang có giao dịch PENDING
            if (hasPendingTransaction) {
                response.getWriter().write(String.format(
                        "{\"success\": false, \"message\": \"Bạn đang có giao dịch #%s đang chờ xác nhận. Vui lòng chờ admin xử lý trước khi tạo giao dịch mới!\", \"hasPending\": true, \"pendingOrderCode\": \"%s\"}",
                        pendingOrderCode, pendingOrderCode));
                return;
            }

            // ✅ OK - Cho phép tạo mới
            double amount = 250000.0;
            long orderCode = System.currentTimeMillis();
            String description = "PRO " + accountId + " " + orderCode;

            response.getWriter().write(String.format(
                    "{\"success\": true, \"amount\": %.2f, \"description\": \"%s\", \"orderId\": %d, \"hasPending\": false, \"isPro\": false}",
                    amount, description, orderCode));
            return;
        }

        // LUỒNG 2: Xác nhận thanh toán (Action = 'confirm')
        if ("confirm".equals(action)) {

            // ✅ Check lại lần nữa (phòng user bypass frontend)
            if (isProAccount) {
                response.getWriter().write("{\"success\": false, \"message\": \"Tài khoản đã là Pro!\"}");
                return;
            }

            if (hasPendingTransaction) {
                response.getWriter().write(String.format(
                        "{\"success\": false, \"message\": \"Bạn đang có giao dịch #%s chờ xác nhận!\"}", pendingOrderCode));
                return;
            }

            String senderName = request.getParameter("senderName");
            String senderContent = request.getParameter("senderContent");
            String orderId = request.getParameter("orderId");

            // Validate input
            if (senderName == null || senderName.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng nhập tên người gửi!\"}");
                return;
            }

            if (senderContent == null || senderContent.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng nhập nội dung chuyển khoản!\"}");
                return;
            }
            UserDAO userDao = new UserDAO();
            int userId = userDao.getUserIdByAccountId(accountId);
            // ✅ Gọi DAO để LƯU GIAO DỊCH MỚI vào DB
            boolean isInserted = paymentDao.createPaymentOrder(
                    userId,
                    Long.parseLong(orderId),
                    250000.0,
                    "BUY_PRO",
                    "PENDING_TRADING",
                    "PRO " + accountId + " " + orderId,
                    senderName,
                    senderContent
            );

            if (isInserted) {
                response.getWriter().write("{\"success\": true, \"message\": \"Đã gửi yêu cầu thành công! Vui lòng chờ admin xác nhận.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Lỗi lưu DB. Vui lòng thử lại!\"}");
            }
        }

    }
}

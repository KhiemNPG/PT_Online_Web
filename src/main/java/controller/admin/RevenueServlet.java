package controller.admin;

import dao.User.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.payment.PaymentTransaction;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "RevenueServlet", urlPatterns = {"/admin/revenue"})
public class RevenueServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/admin/revenue/index.jsp";
        PaymentDAO paymentDao = new PaymentDAO();
        double totalAmount = paymentDao.getTotalAmount();
        int TotalSuccessTrading = paymentDao.getTotalSuccessTrading();
        int totalTransaction = paymentDao.getTotalTransaction();
        int totalTransactionByProAccount = paymentDao.getTotalTransactionByProAccount();
        double totalRevenueBuyProAccount = paymentDao.getTotalRevenueBuyProAccount();

        String monthStr = request.getParameter("month");
        String yearStr = request.getParameter("year");

        int month, year;
        if (monthStr == null || yearStr == null) {
            java.util.Calendar cal = java.util.Calendar.getInstance();
            month = cal.get(java.util.Calendar.MONTH) + 1; // +1 vì Java đếm tháng từ 0 (0 = Tháng 1)
            year = cal.get(java.util.Calendar.YEAR);
        } else {
            month = Integer.parseInt(monthStr);
            year = Integer.parseInt(yearStr);
        }

        List<PaymentTransaction> revenueListForMonthAndYear = paymentDao.allTransactionSuccessListForMonthAdnYear(month, year);
        List<PaymentTransaction> paymentTransactionForMonthAndYear = paymentDao.allTransactionList(month, year);

        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("totalTransactionByProAccount", totalTransactionByProAccount);
        request.setAttribute("totalRevenueBuyProAccount", totalRevenueBuyProAccount);
        request.setAttribute("totalTransaction", totalTransaction);
        request.setAttribute("TotalSuccessTrading", TotalSuccessTrading);
        request.setAttribute("revenueListForMonthAndYear", revenueListForMonthAndYear);
        request.setAttribute("paymentTransactionForMonthAndYear", paymentTransactionForMonthAndYear);
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy parameters từ form
            int userId = Integer.parseInt(request.getParameter("userId"));
            long orderCode = Long.parseLong(request.getParameter("orderCode"));
            double amount = Double.parseDouble(request.getParameter("amount"));
            String transactionType = request.getParameter("transactionType");
            String status = request.getParameter("status");
            String senderName = request.getParameter("senderName");
            String transferContent = request.getParameter("transferContent");

            // Gọi DAO để tạo payment order
            PaymentDAO paymentDao = new PaymentDAO();
            boolean success = paymentDao.createPaymentOrder(
                    userId, orderCode, amount, transactionType,
                    status, null, senderName, transferContent
            );

            if (success) {
                // Redirect về trang với thông báo thành công
                response.sendRedirect(request.getContextPath() + "/admin/revenue?msg=added");
            } else {
                // Redirect với thông báo lỗi
                response.sendRedirect(request.getContextPath() + "/admin/revenue?error=add_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/revenue?error=server_error");
        }
    }
}

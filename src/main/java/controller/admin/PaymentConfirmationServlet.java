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
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "PaymentConfirmationServlet", urlPatterns = {"/admin/transactions"})
public class PaymentConfirmationServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/admin/paymentConfirmation/allPayment/index.jsp";
        PaymentDAO paymentDao = new PaymentDAO();
        double totalAmountForDay = paymentDao.getTotalAmountForToday();
        NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedAmount = formatter.format(totalAmountForDay) + " ₫";

        int totalSuccessTrading = paymentDao.getTotalSuccessTrading();
        int totalTransaction = paymentDao.getTotalTransaction();
        int totalPending = paymentDao.getTotalPendingTrading();

        List<PaymentTransaction> listPaymentTransactionList = paymentDao.allTransactionListPending();

        request.setAttribute("totalAmountForDay", formattedAmount);
        request.setAttribute("totalSuccessTrading", totalSuccessTrading);
        request.setAttribute("totalTransaction", totalTransaction);
        request.setAttribute("totalPendingTrading", totalPending);
        request.setAttribute("listPaymentTransactionList", listPaymentTransactionList);
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String transactionIdStr = request.getParameter("transactionId");

        if (transactionIdStr == null || transactionIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/transactions");
            return;
        }

        int transactionId;
        try {
            transactionId = Integer.parseInt(transactionIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/transactions");
            return;
        }

        PaymentDAO paymentDao = new PaymentDAO();

        try {
            if ("approve".equals(action)) {
                paymentDao.approveTransaction(transactionId);
            } else if ("reject".equals(action)) {
                paymentDao.rejectTransaction(transactionId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Quay về lại trang hiện tại để thấy cập nhật
        response.sendRedirect(request.getContextPath() + "/admin/transactions");
    }
}

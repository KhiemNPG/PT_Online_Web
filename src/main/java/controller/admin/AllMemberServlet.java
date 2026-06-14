package controller.admin;

import dao.Admin.AccountDAO;
import dao.Admin.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Account;
import model.entity.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author HP - Gia Khiêm
 */
@WebServlet(name = "AllMemberServlet", urlPatterns = {"/admin/users"})
public class AllMemberServlet extends HttpServlet {

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
        String jspPath = "/WEB-INF/View/admin/member/allMember/index.jsp";
        AccountDAO accountDao = new AccountDAO();
        UserDAO userDao = new UserDAO();
        List<Integer> userProList = userDao.allAccountIdPro();
        List<Account> customerAccountList = accountDao.allCustomerAccountList();
        int totalAccountPro = accountDao.numberAccountPro();
        List<User> userList = userDao.allCustomerList();

        request.setAttribute("customerAccountList", customerAccountList);
        request.setAttribute("totalAccountPro", totalAccountPro);
        request.setAttribute("userProList", userProList);
        request.setAttribute("userList", userList);
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}


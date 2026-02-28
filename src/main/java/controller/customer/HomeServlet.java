package controller.customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            Object goalSuccess = session.getAttribute("goalSuccess");
            Object profileIncomplete = session.getAttribute("profileIncomplete");

            if (goalSuccess != null) {
                request.setAttribute("goalSuccess", goalSuccess);
                request.setAttribute("profileIncomplete", profileIncomplete);

                session.removeAttribute("goalSuccess");
                session.removeAttribute("profileIncomplete");

            }
        }

        request.getRequestDispatcher("/WEB-INF/View/customer/homePage/index.jsp")
                .forward(request, response);
    }
}
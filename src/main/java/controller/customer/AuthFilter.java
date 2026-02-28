package controller.customer;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("accountId") != null);

        String uri = req.getRequestURI();

        boolean authRequest = uri.contains("/auth");
        boolean resourceRequest = uri.contains("/css")
                || uri.contains("/js")
                || uri.contains("/images");

        if (loggedIn || authRequest || resourceRequest) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/auth?action=login");
        }
    }
}
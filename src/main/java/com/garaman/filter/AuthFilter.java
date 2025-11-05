package com.garaman.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/serviceAndPart", "/importPart", "/addSupplier", "/addPart", "/purchaseReceipt", "/home"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        String path = req.getServletPath();
        String role = (String) session.getAttribute("role");
        if ((path.equals("/importPart") || path.equals("/addSupplier") || path.equals("/addPart") || path.equals("/purchaseReceipt"))
                && !"WAREHOUSE_STAFF".equals(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        chain.doFilter(request, response);
    }
}
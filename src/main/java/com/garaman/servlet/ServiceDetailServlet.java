package com.garaman.servlet;

import com.garaman.dao.ServiceDAO;
import com.garaman.model.Service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/serviceDetail")
public class ServiceDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try (ServiceDAO dao = new ServiceDAO()) {
            Service service = dao.getServiceByID(id);
            req.setAttribute("service", service);
            req.getRequestDispatcher("/serviceDetail.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
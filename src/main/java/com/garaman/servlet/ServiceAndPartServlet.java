package com.garaman.servlet;

import com.garaman.dao.ServiceDAO;
import com.garaman.dao.SparePartDAO;
import com.garaman.model.Service;
import com.garaman.model.SparePart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/serviceAndPart")
public class ServiceAndPartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        try (ServiceDAO serviceDAO = new ServiceDAO(); SparePartDAO partDAO = new SparePartDAO()) {
            List<Service> services;
            List<SparePart> parts;
            if (keyword != null && !keyword.trim().isEmpty()) {
                services = serviceDAO.getServicesByName(keyword);
                parts = partDAO.getSparePartsByName(keyword);
            } else {
                services = serviceDAO.getServices();
                parts = partDAO.getSpareParts();
            }
            req.setAttribute("services", services);
            req.setAttribute("parts", parts);
            req.getRequestDispatcher("/serviceAndPartFrame.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
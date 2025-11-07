package com.garaman.servlet;

import com.garaman.dao.SparePartDAO;
import com.garaman.model.SparePart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addPart")
public class AddPartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/addPart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int unitPrice = Integer.parseInt(req.getParameter("unitPrice"));
        int sellPrice = Integer.parseInt(req.getParameter("sellPrice"));
        SparePart part = new SparePart(0, name, quantity, unitPrice, sellPrice);
        try (SparePartDAO dao = new SparePartDAO()) {
            int id = dao.addSparePart(part);
            resp.sendRedirect(req.getContextPath() + "/importPart?msg=Part added");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
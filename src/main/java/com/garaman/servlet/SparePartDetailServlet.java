package com.garaman.servlet;

import com.garaman.dao.SparePartDAO;
import com.garaman.model.SparePart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/sparePartDetail")
public class SparePartDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        try (SparePartDAO dao = new SparePartDAO()) {
            SparePart part = dao.getSparePartByID(id);
            req.setAttribute("part", part);
            req.getRequestDispatcher("/sparePartDetail.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
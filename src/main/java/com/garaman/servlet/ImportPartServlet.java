package com.garaman.servlet;

import com.garaman.dao.SupplierDAO;
import com.garaman.dao.SparePartDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/importPart")
public class ImportPartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (SupplierDAO supplierDAO = new SupplierDAO();
             SparePartDAO partDAO = new SparePartDAO()) {

            List suppliers = supplierDAO.getSuppliers();
            List parts = partDAO.getSpareParts();

            req.setAttribute("suppliers", suppliers);
            req.setAttribute("parts", parts);
            req.getRequestDispatcher("/importPartFrame.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
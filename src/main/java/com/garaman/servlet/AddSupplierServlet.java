package com.garaman.servlet;

import com.garaman.dao.SupplierDAO;
import com.garaman.model.Address;
import com.garaman.model.Supplier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addSupplier")
public class AddSupplierServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/addSupplier.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String streetNum = req.getParameter("streetNumber");
        String streetName = req.getParameter("streetName");
        String ward = req.getParameter("ward");
        String district = req.getParameter("district");
        String province = req.getParameter("province");

        Address addr = new Address(0, streetNum, streetName, ward, district, province);
        Supplier supplier = new Supplier(0, name, phone, addr);

        try (SupplierDAO dao = new SupplierDAO()) {
            int id = dao.addSupplier(supplier);
            resp.sendRedirect(req.getContextPath() + "/importPart?msg=Supplier added");
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
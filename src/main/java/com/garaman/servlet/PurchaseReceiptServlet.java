package com.garaman.servlet;

import com.garaman.dao.*;
import com.garaman.model.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/purchaseReceipt")
public class PurchaseReceiptServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        int supplierId = Integer.parseInt(req.getParameter("supplierId"));
        String detailsJson = req.getParameter("details");
        int staffId = Integer.parseInt(req.getParameter("staffId"));

        Gson gson = new Gson();
        List<ImportDetail> details = gson.fromJson(detailsJson, new TypeToken<List<ImportDetail>>(){}.getType());

        double total = details.stream().mapToDouble(ImportDetail::getTotal).sum();

        try (SupplierDAO supplierDAO = new SupplierDAO();
             ImportReceiptDAO receiptDAO = new ImportReceiptDAO();
             ImportDetailDAO detailDAO = new ImportDetailDAO();
             SparePartDAO partDAO = new SparePartDAO()) {

            Supplier supplier = supplierDAO.getSupplierByID(supplierId);

            ImportReceipt receipt = new ImportReceipt();
            receipt.setSupplier(supplier);
            receipt.setTotalPrice(total);
            receipt.setWhWorkerId(staffId);

            int receiptId = receiptDAO.createReceipt(receipt);
            receipt.setIdReceipt(receiptId);

            for (ImportDetail detail : details) {
                detail.setIdReceipt(receiptId);
                detailDAO.addDetail(detail);
                partDAO.updateQuantity(detail.getPart().getIdPart(), detail.getQuantity());
            }

            receipt = receiptDAO.getReceiptByID(receiptId);
            req.setAttribute("receipt", receipt);
            req.getRequestDispatcher("/purchaseReceipt.jsp").forward(req, resp);

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
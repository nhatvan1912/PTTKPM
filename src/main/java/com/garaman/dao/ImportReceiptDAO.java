package com.garaman.dao;

import com.garaman.model.ImportReceipt;

import java.sql.*;

public class ImportReceiptDAO extends DAO {

    public int createReceipt(ImportReceipt receipt) throws SQLException {
        String sql = """
            INSERT INTO tblImportReceipt
                (totalPrice, tblSupplierid, tblWarehousetblStafftblUserid)
            VALUES (?,?,?)
            """;
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDouble(1, receipt.getTotalPrice());
            ps.setInt(2, receipt.getSupplier().getIdSupplier());
            ps.setInt(3, receipt.getWhWorkerId());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public ImportReceipt getReceiptByID(int id) throws SQLException {
        String sql = "SELECT * FROM tblImportReceipt WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ImportReceipt rec = new ImportReceipt();
                    rec.setIdReceipt(rs.getInt("id"));
                    rec.setCreatedAt(rs.getTimestamp("createAt"));
                    rec.setTotalPrice(rs.getDouble("totalPrice"));
                    rec.setWhWorkerId(rs.getInt("tblWarehousetblStafftblUserid"));
                    try (SupplierDAO supDAO = new SupplierDAO()) {
                        rec.setSupplier(supDAO.getSupplierByID(rs.getInt("tblSupplierid")));
                    }
                    try (ImportDetailDAO detailDAO = new ImportDetailDAO()) {
                        rec.setDetails(detailDAO.getDetailsByReceiptID(id));
                    }
                    return rec;
                }
            }
        }
        return null;
    }
}
package com.garaman.dao;

import com.garaman.model.ImportDetail;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImportDetailDAO extends DAO {

    public void addDetail(ImportDetail detail) throws SQLException {
        String sql = """
            INSERT INTO tblImportDetail (quantity, unitCost, tblSparePartid, tblImportReceiptid)
            VALUES (?,?,?,?)
            """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getQuantity());
            ps.setDouble(2, detail.getUnitCost());
            ps.setInt(3, detail.getPart().getIdPart());
            ps.setInt(4, detail.getIdReceipt());
            ps.executeUpdate();
        }
    }

    public List<ImportDetail> getDetailsByReceiptID(int receiptId) throws SQLException {
        List<ImportDetail> list = new ArrayList<>();
        String sql = """
            SELECT id, quantity, unitCost, tblSparePartid, tblImportReceiptid
            FROM tblImportDetail
            WHERE tblImportReceiptid = ?
            """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, receiptId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ImportDetail d = new ImportDetail();
                    d.setIdImportDetail(rs.getInt("id"));
                    d.setIdReceipt(rs.getInt("tblImportReceiptid"));
                    d.setQuantity(rs.getInt("quantity"));
                    d.setUnitCost(rs.getDouble("unitCost"));
                    try (SparePartDAO partDAO = new SparePartDAO()) {
                        d.setPart(partDAO.getSparePartByID(rs.getInt("tblSparePartid")));
                    }
                    list.add(d);
                }
            }
        }
        return list;
    }
}
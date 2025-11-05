package com.garaman.dao;

import com.garaman.model.SparePart;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SparePartDAO extends DAO {

    public List<SparePart> getSpareParts() throws SQLException {
        List<SparePart> list = new ArrayList<>();
        String sql = "SELECT id, name, quantity, unitPrice, sellPrice FROM tblSparePart";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<SparePart> getSparePartsByName(String keyword) throws SQLException {
        List<SparePart> list = new ArrayList<>();
        String sql = "SELECT id, name, quantity, unitPrice, sellPrice FROM tblSparePart WHERE name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public SparePart getSparePartByID(int id) throws SQLException {
        String sql = "SELECT id, name, quantity, unitPrice, sellPrice FROM tblSparePart WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        }
        return null;
    }

    public int addSparePart(SparePart part) throws SQLException {
        String sql = "INSERT INTO tblSparePart (name, quantity, unitPrice, sellPrice) VALUES (?,?,?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, part.getName());
            ps.setInt(2, part.getQuantity());
            ps.setDouble(3, part.getUnitPrice());
            ps.setDouble(4, part.getSellPrice());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        }
        return -1;
    }

    public void updateQuantity(int idPart, int additionalQty) throws SQLException {
        String sql = "UPDATE tblSparePart SET quantity = quantity + ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, additionalQty);
            ps.setInt(2, idPart);
            ps.executeUpdate();
        }
    }

    private SparePart map(ResultSet rs) throws SQLException {
        return new SparePart(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getInt("quantity"),
                rs.getDouble("unitPrice"),
                rs.getDouble("sellPrice")
        );
    }
}
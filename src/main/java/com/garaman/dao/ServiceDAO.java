package com.garaman.dao;

import com.garaman.model.Service;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO extends DAO {

    public List<Service> getServices() throws SQLException {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT id, name, description, price FROM tblService";
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public List<Service> getServicesByName(String keyword) throws SQLException {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT id, name, description, price FROM tblService WHERE name LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Service getServiceByID(int id) throws SQLException {
        String sql = "SELECT id, name, description, price FROM tblService WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        }
        return null;
    }

    private Service map(ResultSet rs) throws SQLException {
        return new Service(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getDouble("price")
        );
    }
}
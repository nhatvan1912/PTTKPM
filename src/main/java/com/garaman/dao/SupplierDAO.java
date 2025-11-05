package com.garaman.dao;

import com.garaman.model.Address;
import com.garaman.model.Supplier;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierDAO extends DAO {

    public List<Supplier> getSuppliers() throws SQLException {
        List<Supplier> list = new ArrayList<>();
        String sql = """
            SELECT s.id         AS s_id,
                   s.name       AS s_name,
                   s.phone      AS s_phone,
                   a.id         AS a_id,
                   a.streetNumber, a.streetName, a.ward, a.city, a.province
            FROM tblSupplier s
            LEFT JOIN tblAddress a ON s.tblAddressid = a.id
            """;
        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public Supplier getSupplierByID(int id) throws SQLException {
        String sql = """
            SELECT s.id         AS s_id,
                   s.name       AS s_name,
                   s.phone      AS s_phone,
                   a.id         AS a_id,
                   a.streetNumber, a.streetName, a.ward, a.city, a.province
            FROM tblSupplier s
            LEFT JOIN tblAddress a ON s.tblAddressid = a.id
            WHERE s.id = ?
            """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);
        }
        return null;
    }

    public int addSupplier(Supplier supplier) throws SQLException {
        conn.setAutoCommit(false);
        try {
            Integer addrId = null;
            if (supplier.getAddress() != null) {
                String insAddr = "INSERT INTO tblAddress (streetNumber, streetName, ward, city, province) VALUES (?,?,?,?,?)";
                try (PreparedStatement ps = conn.prepareStatement(insAddr, Statement.RETURN_GENERATED_KEYS)) {
                    Address a = supplier.getAddress();
                    ps.setString(1, a.getStreetNumber());
                    ps.setString(2, a.getStreetName());
                    ps.setString(3, a.getWard());
                    ps.setString(4, a.getCity());
                    ps.setString(5, a.getProvince());
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) addrId = rs.getInt(1);
                }
            }
            String insSup = "INSERT INTO tblSupplier (name, phone, tblAddressid) VALUES (?,?,?)";
            int supplierId = -1;
            try (PreparedStatement ps = conn.prepareStatement(insSup, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, supplier.getName());
                ps.setString(2, supplier.getPhone());
                if (addrId == null) ps.setNull(3, Types.INTEGER); else ps.setInt(3, addrId);
                ps.executeUpdate();
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) supplierId = rs.getInt(1);
            }
            conn.commit();
            return supplierId;
        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }
    }

    private Supplier map(ResultSet rs) throws SQLException {
        Address addr = null;
        int aId = rs.getInt("a_id");
        if (!rs.wasNull()) {
            addr = new Address(
                    aId,
                    rs.getString("streetNumber"),
                    rs.getString("streetName"),
                    rs.getString("ward"),
                    rs.getString("city"),
                    rs.getString("province")
            );
        }
        Supplier s = new Supplier();
        s.setIdSupplier(rs.getInt("s_id"));
        s.setName(rs.getString("s_name"));
        s.setPhone(rs.getString("s_phone"));
        s.setAddress(addr);
        return s;
    }
}
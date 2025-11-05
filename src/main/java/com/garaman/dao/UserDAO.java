package com.garaman.dao;

import com.garaman.model.User;

import java.sql.*;

public class UserDAO extends DAO {

    // Đăng nhập bằng mật khẩu thuần theo bảng tblAccount + tblUser
    public User authenticatePlain(String username, String plainPassword) throws SQLException {
        String sql = """
            SELECT u.*
            FROM tblAccount a
            JOIN tblUser u ON u.tblAccountid = a.id
            WHERE a.userName = ? AND a.passWord = ?
            """;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, plainPassword);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = mapUser(rs);
                // Suy ra role
                u.setRole(resolveRole(u.getIdUser()));
                return u;
            }
        }
        return null;
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM tblUser WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = mapUser(rs);
                u.setRole(resolveRole(u.getIdUser()));
                return u;
            }
        }
        return null;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setIdUser(rs.getInt("id"));
        u.setUsername(null); // username nằm ở tblAccount, không lấy ở đây
        u.setPasswordHash(null);
        u.setEmail(rs.getString("email"));
        u.setFullName(rs.getString("fullName"));
        u.setPhone(rs.getString("phone"));
        return u;
    }

    private User.UserRole resolveRole(int userId) throws SQLException {
        // Warehouse?
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM tblWarehouse WHERE tblStafftblUserid = ? LIMIT 1")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return User.UserRole.WAREHOUSE_STAFF;
            }
        }
        // Customer?
        try (PreparedStatement ps = conn.prepareStatement(
                "SELECT 1 FROM tblCustomer WHERE tblUserid = ? LIMIT 1")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return User.UserRole.CUSTOMER;
            }
        }
        // Mặc định: CUSTOMER (đủ cho 2 module hiện tại)
        return User.UserRole.CUSTOMER;
    }
}
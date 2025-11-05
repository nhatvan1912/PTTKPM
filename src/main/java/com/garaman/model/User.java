package com.garaman.model;

import java.sql.Timestamp;

public class User {
    private int idUser;
    private String username;
    private String passwordHash;
    private String email;
    private String fullName;
    private String phone;
    private UserRole role;
    private UserStatus status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public enum UserRole { CUSTOMER, WAREHOUSE_STAFF, SALES_STAFF, MANAGER, TECHNICIAN }
    public enum UserStatus { ACTIVE, INACTIVE }

    public User() {}

    public int getIdUser() { return idUser; }
    public void setIdUser(int idUser) { this.idUser = idUser; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public UserRole getRole() { return role; }
    public void setRole(UserRole role) { this.role = role; }
    public UserStatus getStatus() { return status; }
    public void setStatus(UserStatus status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}
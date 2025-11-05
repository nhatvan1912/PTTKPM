package com.garaman.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ImportReceipt {
    private int idReceipt;
    private Timestamp createdAt;
    private double totalPrice;
    private Supplier supplier;
    private int whWorkerId;
    private String whWorkerName;
    private List<ImportDetail> details = new ArrayList<>();

    public ImportReceipt() {}

    public int getIdReceipt() { return idReceipt; }
    public void setIdReceipt(int idReceipt) { this.idReceipt = idReceipt; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public Supplier getSupplier() { return supplier; }
    public void setSupplier(Supplier supplier) { this.supplier = supplier; }
    public int getWhWorkerId() { return whWorkerId; }
    public void setWhWorkerId(int whWorkerId) { this.whWorkerId = whWorkerId; }
    public String getWhWorkerName() { return whWorkerName; }
    public void setWhWorkerName(String whWorkerName) { this.whWorkerName = whWorkerName; }
    public List<ImportDetail> getDetails() { return details; }
    public void setDetails(List<ImportDetail> details) { this.details = details; }
}
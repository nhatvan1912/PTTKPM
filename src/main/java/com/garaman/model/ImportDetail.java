package com.garaman.model;

public class ImportDetail {
    private int idImportDetail;
    private int idReceipt;
    private SparePart part;
    private int quantity;
    private double unitCost;

    public ImportDetail() {}

    public ImportDetail(int idImportDetail, int idReceipt, SparePart part, int quantity, double unitCost) {
        this.idImportDetail = idImportDetail;
        this.idReceipt = idReceipt;
        this.part = part;
        this.quantity = quantity;
        this.unitCost = unitCost;
    }

    public int getIdImportDetail() { return idImportDetail; }
    public void setIdImportDetail(int idImportDetail) { this.idImportDetail = idImportDetail; }
    public int getIdReceipt() { return idReceipt; }
    public void setIdReceipt(int idReceipt) { this.idReceipt = idReceipt; }
    public SparePart getPart() { return part; }
    public void setPart(SparePart part) { this.part = part; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitCost() { return unitCost; }
    public void setUnitCost(double unitCost) { this.unitCost = unitCost; }

    public double getTotal() { return quantity * unitCost; }
}
package com.garaman.model;

public class SparePart {
    private int idPart;
    private String name;
    private int quantity;
    private double unitPrice;
    private double sellPrice;

    public SparePart() {}

    public SparePart(int idPart, String name, int quantity, double unitPrice, double sellPrice) {
        this.idPart = idPart;
        this.name = name;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.sellPrice = sellPrice;
    }

    public int getIdPart() { return idPart; }
    public void setIdPart(int idPart) { this.idPart = idPart; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    public double getSellPrice() { return sellPrice; }
    public void setSellPrice(double sellPrice) { this.sellPrice = sellPrice; }
}
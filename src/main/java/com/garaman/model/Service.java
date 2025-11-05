package com.garaman.model;

public class Service {
    private int idService;
    private String name;
    private String description;
    private double price;

    public Service() {}

    public Service(int idService, String name, String description, double price) {
        this.idService = idService;
        this.name = name;
        this.description = description;
        this.price = price;
    }

    public int getIdService() { return idService; }
    public void setIdService(int idService) { this.idService = idService; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
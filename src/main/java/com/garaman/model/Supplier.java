package com.garaman.model;

public class Supplier {
    private int idSupplier;
    private String name;
    private String phone;
    private Address address;

    public Supplier() {}

    public Supplier(int idSupplier, String name, String phone, Address address) {
        this.idSupplier = idSupplier;
        this.name = name;
        this.phone = phone;
        this.address = address;
    }

    public int getIdSupplier() { return idSupplier; }
    public void setIdSupplier(int idSupplier) { this.idSupplier = idSupplier; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Address getAddress() { return address; }
    public void setAddress(Address address) { this.address = address; }
}
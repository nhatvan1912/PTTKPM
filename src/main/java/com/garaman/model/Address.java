package com.garaman.model;

public class Address {
    private int idAddress;
    private String streetNumber;
    private String streetName;
    private String ward;
    private String district;
    private String province;

    public Address() {}

    public Address(int idAddress, String streetNumber, String streetName, String ward, String district, String province) {
        this.idAddress = idAddress;
        this.streetNumber = streetNumber;
        this.streetName = streetName;
        this.ward = ward;
        this.district = district;
        this.province = province;
    }

    public int getIdAddress() { return idAddress; }
    public void setIdAddress(int idAddress) { this.idAddress = idAddress; }
    public String getStreetNumber() { return streetNumber; }
    public void setStreetNumber(String streetNumber) { this.streetNumber = streetNumber; }
    public String getStreetName() { return streetName; }
    public void setStreetName(String streetName) { this.streetName = streetName; }
    public String getWard() { return ward; }
    public void setWard(String ward) { this.ward = ward; }
    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }
    public String getProvince() { return province; }
    public void setProvince(String province) { this.province = province; }

    @Override
    public String toString() {
        return streetNumber + " " + streetName + ", " + ward + ", " + district + ", " + province;
    }
}
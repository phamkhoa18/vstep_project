package com.vstep.model;

import java.sql.Timestamp;

public class CauHinh {
    private int id;
    private double mucGiamThiLai;
    private String emailHeThong;
    private String soDienThoaiHotline;
    private Timestamp ngayCapNhat;

    public CauHinh() {}

    public CauHinh(int id, double mucGiamThiLai, String emailHeThong, String soDienThoaiHotline, Timestamp ngayCapNhat) {
        this.id = id;
        this.mucGiamThiLai = mucGiamThiLai;
        this.emailHeThong = emailHeThong;
        this.soDienThoaiHotline = soDienThoaiHotline;
        this.ngayCapNhat = ngayCapNhat;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public double getMucGiamThiLai() { return mucGiamThiLai; }
    public void setMucGiamThiLai(double mucGiamThiLai) { this.mucGiamThiLai = mucGiamThiLai; }

    public String getEmailHeThong() { return emailHeThong; }
    public void setEmailHeThong(String emailHeThong) { this.emailHeThong = emailHeThong; }

    public String getSoDienThoaiHotline() { return soDienThoaiHotline; }
    public void setSoDienThoaiHotline(String soDienThoaiHotline) { this.soDienThoaiHotline = soDienThoaiHotline; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}

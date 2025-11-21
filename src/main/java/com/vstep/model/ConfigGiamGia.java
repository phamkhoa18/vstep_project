package com.vstep.model;

import java.sql.Timestamp;

public class ConfigGiamGia {
    private long id;
    private String loai; // "lop_on" hoặc "ca_thi"
    private long mucGiamThiLai; // Mức giảm giá cho thí sinh thi lại (VND)
    private String moTa;
    private String trangThai; // "active", "inactive"
    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getLoai() { return loai; }
    public void setLoai(String loai) { this.loai = loai; }

    public long getMucGiamThiLai() { return mucGiamThiLai; }
    public void setMucGiamThiLai(long mucGiamThiLai) { this.mucGiamThiLai = mucGiamThiLai; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}


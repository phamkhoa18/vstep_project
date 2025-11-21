package com.vstep.model;

import java.sql.Timestamp;

public class DangKyLop {
    private long id;
    private long nguoiDungId;
    private long lopOnId;
    private Timestamp ngayDangKy;
    private String ghiChu;
    private long soTienDaTra;
    private long mucGiam; // Tổng mức giảm giá (từ mã code hoặc chính sách)
    private String trangThai;
    private String maXacNhan;
    private String maCodeGiamGia; // Mã code giảm giá đã sử dụng

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getNguoiDungId() { return nguoiDungId; }
    public void setNguoiDungId(long nguoiDungId) { this.nguoiDungId = nguoiDungId; }

    public long getLopOnId() { return lopOnId; }
    public void setLopOnId(long lopOnId) { this.lopOnId = lopOnId; }

    public Timestamp getNgayDangKy() { return ngayDangKy; }
    public void setNgayDangKy(Timestamp ngayDangKy) { this.ngayDangKy = ngayDangKy; }

    public String getGhiChu() { return ghiChu; }
    public void setGhiChu(String ghiChu) { this.ghiChu = ghiChu; }

    public long getSoTienDaTra() { return soTienDaTra; }
    public void setSoTienDaTra(long soTienDaTra) { this.soTienDaTra = soTienDaTra; }

    public long getMucGiam() { return mucGiam; }
    public void setMucGiam(long mucGiam) { this.mucGiam = mucGiam; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public String getMaXacNhan() { return maXacNhan; }
    public void setMaXacNhan(String maXacNhan) { this.maXacNhan = maXacNhan; }

    public String getMaCodeGiamGia() { return maCodeGiamGia; }
    public void setMaCodeGiamGia(String maCodeGiamGia) { this.maCodeGiamGia = maCodeGiamGia; }
}

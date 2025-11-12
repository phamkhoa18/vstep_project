package com.vstep.model;

import java.sql.Timestamp;

public class DangKyLop {
    private long id;
    private long nguoiDungId;
    private long lopOnId;
    private Timestamp ngayDangKy;
    private String ghiChu;
    private long soTienDaTra;
    private String trangThai;
    private String maXacNhan;

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

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public String getMaXacNhan() { return maXacNhan; }
    public void setMaXacNhan(String maXacNhan) { this.maXacNhan = maXacNhan; }
}

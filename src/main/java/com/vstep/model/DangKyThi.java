package com.vstep.model;

import java.sql.Timestamp;

public class DangKyThi {
    private long id;
    private long nguoiDungId;
    private long caThiId;
    private boolean daTungThi;
    private long mucGiam;
    private long soTienPhaiTra;
    private String trangThai;
    private Timestamp ngayDangKy;
    private String maXacNhan;
    private String maCodeGiamGia; // Mã code giảm giá đã sử dụng

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public long getNguoiDungId() { return nguoiDungId; }
    public void setNguoiDungId(long nguoiDungId) { this.nguoiDungId = nguoiDungId; }

    public long getCaThiId() { return caThiId; }
    public void setCaThiId(long caThiId) { this.caThiId = caThiId; }

    public boolean isDaTungThi() { return daTungThi; }
    public void setDaTungThi(boolean daTungThi) { this.daTungThi = daTungThi; }

    public long getMucGiam() { return mucGiam; }
    public void setMucGiam(long mucGiam) { this.mucGiam = mucGiam; }

    public long getSoTienPhaiTra() { return soTienPhaiTra; }
    public void setSoTienPhaiTra(long soTienPhaiTra) { this.soTienPhaiTra = soTienPhaiTra; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayDangKy() { return ngayDangKy; }
    public void setNgayDangKy(Timestamp ngayDangKy) { this.ngayDangKy = ngayDangKy; }

    public String getMaXacNhan() { return maXacNhan; }
    public void setMaXacNhan(String maXacNhan) { this.maXacNhan = maXacNhan; }

    public String getMaCodeGiamGia() { return maCodeGiamGia; }
    public void setMaCodeGiamGia(String maCodeGiamGia) { this.maCodeGiamGia = maCodeGiamGia; }
}

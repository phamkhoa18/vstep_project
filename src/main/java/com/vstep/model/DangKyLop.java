package com.vstep.model;

import java.sql.Timestamp;

public class DangKyLop {
    private int id;
    private int idNguoiDung;
    private int idLop;
    private Timestamp ngayDangKy;
    private String trangThai;
    private boolean daThanhToan;
    private String maGiaoDich;

    public DangKyLop() {}

    public DangKyLop(int id, int idNguoiDung, int idLop, Timestamp ngayDangKy,
                     String trangThai, boolean daThanhToan, String maGiaoDich) {
        this.id = id;
        this.idNguoiDung = idNguoiDung;
        this.idLop = idLop;
        this.ngayDangKy = ngayDangKy;
        this.trangThai = trangThai;
        this.daThanhToan = daThanhToan;
        this.maGiaoDich = maGiaoDich;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }

    public int getIdLop() { return idLop; }
    public void setIdLop(int idLop) { this.idLop = idLop; }

    public Timestamp getNgayDangKy() { return ngayDangKy; }
    public void setNgayDangKy(Timestamp ngayDangKy) { this.ngayDangKy = ngayDangKy; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public boolean isDaThanhToan() { return daThanhToan; }
    public void setDaThanhToan(boolean daThanhToan) { this.daThanhToan = daThanhToan; }

    public String getMaGiaoDich() { return maGiaoDich; }
    public void setMaGiaoDich(String maGiaoDich) { this.maGiaoDich = maGiaoDich; }
}

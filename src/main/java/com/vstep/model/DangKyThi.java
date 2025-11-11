package com.vstep.model;

import java.sql.Timestamp;

public class DangKyThi {
    private int id;
    private int idNguoiDung;
    private int idCaThi;
    private Timestamp ngayDangKy;
    private String trangThai;
    private boolean laThiLai;
    private double lePhiThucTe;
    private boolean daThanhToan;
    private String maGiaoDich;

    public DangKyThi() {}

    public DangKyThi(int id, int idNguoiDung, int idCaThi, Timestamp ngayDangKy,
                     String trangThai, boolean laThiLai, double lePhiThucTe,
                     boolean daThanhToan, String maGiaoDich) {
        this.id = id;
        this.idNguoiDung = idNguoiDung;
        this.idCaThi = idCaThi;
        this.ngayDangKy = ngayDangKy;
        this.trangThai = trangThai;
        this.laThiLai = laThiLai;
        this.lePhiThucTe = lePhiThucTe;
        this.daThanhToan = daThanhToan;
        this.maGiaoDich = maGiaoDich;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getIdNguoiDung() { return idNguoiDung; }
    public void setIdNguoiDung(int idNguoiDung) { this.idNguoiDung = idNguoiDung; }

    public int getIdCaThi() { return idCaThi; }
    public void setIdCaThi(int idCaThi) { this.idCaThi = idCaThi; }

    public Timestamp getNgayDangKy() { return ngayDangKy; }
    public void setNgayDangKy(Timestamp ngayDangKy) { this.ngayDangKy = ngayDangKy; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public boolean isLaThiLai() { return laThiLai; }
    public void setLaThiLai(boolean laThiLai) { this.laThiLai = laThiLai; }

    public double getLePhiThucTe() { return lePhiThucTe; }
    public void setLePhiThucTe(double lePhiThucTe) { this.lePhiThucTe = lePhiThucTe; }

    public boolean isDaThanhToan() { return daThanhToan; }
    public void setDaThanhToan(boolean daThanhToan) { this.daThanhToan = daThanhToan; }

    public String getMaGiaoDich() { return maGiaoDich; }
    public void setMaGiaoDich(String maGiaoDich) { this.maGiaoDich = maGiaoDich; }
}

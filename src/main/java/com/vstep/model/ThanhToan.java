package com.vstep.model;

import java.sql.Timestamp;

public class ThanhToan {
    private long id;
    private String maGiaoDich;
    private long soTien;
    private String phuongThuc;
    private String trangThai;
    private Timestamp ngayTao;
    private Long dangKyLopId;
    private Long dangKyThiId;

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getMaGiaoDich() { return maGiaoDich; }
    public void setMaGiaoDich(String maGiaoDich) { this.maGiaoDich = maGiaoDich; }

    public long getSoTien() { return soTien; }
    public void setSoTien(long soTien) { this.soTien = soTien; }

    public String getPhuongThuc() { return phuongThuc; }
    public void setPhuongThuc(String phuongThuc) { this.phuongThuc = phuongThuc; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Long getDangKyLopId() { return dangKyLopId; }
    public void setDangKyLopId(Long dangKyLopId) { this.dangKyLopId = dangKyLopId; }

    public Long getDangKyThiId() { return dangKyThiId; }
    public void setDangKyThiId(Long dangKyThiId) { this.dangKyThiId = dangKyThiId; }
}

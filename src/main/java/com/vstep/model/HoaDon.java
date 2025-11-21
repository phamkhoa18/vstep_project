package com.vstep.model;

import java.sql.Timestamp;

public class HoaDon {
    private long id;
    private String soHoaDon;
    private long nguoiDungId;
    private String loai; // "lop_on" hoặc "ca_thi"
    private long dangKyId; // ID của DangKyLop hoặc DangKyThi
    private String filePath; // Đường dẫn file PDF
    private String fileName; // Tên file PDF
    private Timestamp ngayTao;
    private String trangThai; // "Đã tạo", "Đã gửi email", etc.

    // Getters & Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSoHoaDon() {
        return soHoaDon;
    }

    public void setSoHoaDon(String soHoaDon) {
        this.soHoaDon = soHoaDon;
    }

    public long getNguoiDungId() {
        return nguoiDungId;
    }

    public void setNguoiDungId(long nguoiDungId) {
        this.nguoiDungId = nguoiDungId;
    }

    public String getLoai() {
        return loai;
    }

    public void setLoai(String loai) {
        this.loai = loai;
    }

    public long getDangKyId() {
        return dangKyId;
    }

    public void setDangKyId(long dangKyId) {
        this.dangKyId = dangKyId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Timestamp getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}


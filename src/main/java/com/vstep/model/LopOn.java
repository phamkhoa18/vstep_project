package com.vstep.model;

import java.sql.Date;
import java.sql.Timestamp;

public class LopOn {
    private int id;
    private String tenLop;
    private String moTa;
    private String hinhThuc;
    private int siSoToiDa;
    private double hocPhi;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private String trangThai;
    private Timestamp ngayTao;

    public LopOn() {}

    public LopOn(int id, String tenLop, String moTa, String hinhThuc, int siSoToiDa, double hocPhi,
                 Date ngayBatDau, Date ngayKetThuc, String trangThai, Timestamp ngayTao) {
        this.id = id;
        this.tenLop = tenLop;
        this.moTa = moTa;
        this.hinhThuc = hinhThuc;
        this.siSoToiDa = siSoToiDa;
        this.hocPhi = hocPhi;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
        this.trangThai = trangThai;
        this.ngayTao = ngayTao;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenLop() { return tenLop; }
    public void setTenLop(String tenLop) { this.tenLop = tenLop; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public String getHinhThuc() { return hinhThuc; }
    public void setHinhThuc(String hinhThuc) { this.hinhThuc = hinhThuc; }

    public int getSiSoToiDa() { return siSoToiDa; }
    public void setSiSoToiDa(int siSoToiDa) { this.siSoToiDa = siSoToiDa; }

    public double getHocPhi() { return hocPhi; }
    public void setHocPhi(double hocPhi) { this.hocPhi = hocPhi; }

    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }
}

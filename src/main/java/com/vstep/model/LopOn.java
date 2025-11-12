package com.vstep.model;

import java.sql.Date;
import java.sql.Timestamp;

public class LopOn {
    private long id;
    private String tieuDe;
    private String moTaNgan;
    private String hinhThuc;
    private String nhipDo;
    private Date ngayKhaiGiang;
    private Date ngayHetHanDangKy;
    private int soBuoi;
    private double gioMoiBuoi;
    private long hocPhi;
    private int siSoToiDa;
    private String tinhTrang;
    private Timestamp ngayTao;
    private String noiDungChiTiet;

    public LopOn() {}

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getTieuDe() { return tieuDe; }
    public void setTieuDe(String tieuDe) { this.tieuDe = tieuDe; }

    public String getMoTaNgan() { return moTaNgan; }
    public void setMoTaNgan(String moTaNgan) { this.moTaNgan = moTaNgan; }

    public String getHinhThuc() { return hinhThuc; }
    public void setHinhThuc(String hinhThuc) { this.hinhThuc = hinhThuc; }

    public String getNhipDo() { return nhipDo; }
    public void setNhipDo(String nhipDo) { this.nhipDo = nhipDo; }

    public Date getNgayKhaiGiang() { return ngayKhaiGiang; }
    public void setNgayKhaiGiang(Date ngayKhaiGiang) { this.ngayKhaiGiang = ngayKhaiGiang; }

    public Date getNgayHetHanDangKy() { return ngayHetHanDangKy; }
    public void setNgayHetHanDangKy(Date ngayHetHanDangKy) { this.ngayHetHanDangKy = ngayHetHanDangKy; }

    public int getSoBuoi() { return soBuoi; }
    public void setSoBuoi(int soBuoi) { this.soBuoi = soBuoi; }

    public double getGioMoiBuoi() { return gioMoiBuoi; }
    public void setGioMoiBuoi(double gioMoiBuoi) { this.gioMoiBuoi = gioMoiBuoi; }

    public long getHocPhi() { return hocPhi; }
    public void setHocPhi(long hocPhi) { this.hocPhi = hocPhi; }

    public int getSiSoToiDa() { return siSoToiDa; }
    public void setSiSoToiDa(int siSoToiDa) { this.siSoToiDa = siSoToiDa; }

    public String getTinhTrang() { return tinhTrang; }
    public void setTinhTrang(String tinhTrang) { this.tinhTrang = tinhTrang; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public String getNoiDungChiTiet() {
        return noiDungChiTiet;
    }

    public void setNoiDungChiTiet(String noiDungChiTiet) {
        this.noiDungChiTiet = noiDungChiTiet;
    }
}

package com.vstep.model;

import java.sql.Date;
import java.sql.Timestamp;

public class MaGiamGia {
    private long id;
    private String maCode;
    private String loai; // "lop_on", "ca_thi", hoặc "all"
    private String loaiGiam; // "fixed" (số tiền cố định) hoặc "percent" (phần trăm)
    private long giaTriGiam; // Số tiền giảm (nếu fixed) hoặc phần trăm (nếu percent)
    private Long giaTriToiDa; // Giá trị giảm tối đa (nếu là percent)
    private Integer soLuongToiDa; // Số lượng sử dụng tối đa
    private int soLuongDaSuDung;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private String trangThai; // "active", "inactive", "expired"
    private String moTa;
    private Timestamp ngayTao;
    private Timestamp ngayCapNhat;

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getMaCode() { return maCode; }
    public void setMaCode(String maCode) { this.maCode = maCode; }

    public String getLoai() { return loai; }
    public void setLoai(String loai) { this.loai = loai; }

    public String getLoaiGiam() { return loaiGiam; }
    public void setLoaiGiam(String loaiGiam) { this.loaiGiam = loaiGiam; }

    public long getGiaTriGiam() { return giaTriGiam; }
    public void setGiaTriGiam(long giaTriGiam) { this.giaTriGiam = giaTriGiam; }

    public Long getGiaTriToiDa() { return giaTriToiDa; }
    public void setGiaTriToiDa(Long giaTriToiDa) { this.giaTriToiDa = giaTriToiDa; }

    public Integer getSoLuongToiDa() { return soLuongToiDa; }
    public void setSoLuongToiDa(Integer soLuongToiDa) { this.soLuongToiDa = soLuongToiDa; }

    public int getSoLuongDaSuDung() { return soLuongDaSuDung; }
    public void setSoLuongDaSuDung(int soLuongDaSuDung) { this.soLuongDaSuDung = soLuongDaSuDung; }

    public Date getNgayBatDau() { return ngayBatDau; }
    public void setNgayBatDau(Date ngayBatDau) { this.ngayBatDau = ngayBatDau; }

    public Date getNgayKetThuc() { return ngayKetThuc; }
    public void setNgayKetThuc(Date ngayKetThuc) { this.ngayKetThuc = ngayKetThuc; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public Timestamp getNgayCapNhat() { return ngayCapNhat; }
    public void setNgayCapNhat(Timestamp ngayCapNhat) { this.ngayCapNhat = ngayCapNhat; }
}


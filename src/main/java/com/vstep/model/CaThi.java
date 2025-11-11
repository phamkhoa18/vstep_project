package com.vstep.model;

import java.sql.Date;
import java.sql.Time;

public class CaThi {
    private int id;
    private String tenCa;
    private Date ngayThi;
    private Time gioBatDau;
    private Time gioKetThuc;
    private String diaDiem;
    private double lePhi;
    private Integer idLop;
    private String trangThai;

    public CaThi() {}

    public CaThi(int id, String tenCa, Date ngayThi, Time gioBatDau, Time gioKetThuc,
                 String diaDiem, double lePhi, Integer idLop, String trangThai) {
        this.id = id;
        this.tenCa = tenCa;
        this.ngayThi = ngayThi;
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
        this.diaDiem = diaDiem;
        this.lePhi = lePhi;
        this.idLop = idLop;
        this.trangThai = trangThai;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTenCa() { return tenCa; }
    public void setTenCa(String tenCa) { this.tenCa = tenCa; }

    public Date getNgayThi() { return ngayThi; }
    public void setNgayThi(Date ngayThi) { this.ngayThi = ngayThi; }

    public Time getGioBatDau() { return gioBatDau; }
    public void setGioBatDau(Time gioBatDau) { this.gioBatDau = gioBatDau; }

    public Time getGioKetThuc() { return gioKetThuc; }
    public void setGioKetThuc(Time gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public String getDiaDiem() { return diaDiem; }
    public void setDiaDiem(String diaDiem) { this.diaDiem = diaDiem; }

    public double getLePhi() { return lePhi; }
    public void setLePhi(double lePhi) { this.lePhi = lePhi; }

    public Integer getIdLop() { return idLop; }
    public void setIdLop(Integer idLop) { this.idLop = idLop; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}

package com.vstep.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class CaThi {
    private long id;
    private String maCaThi;
    private Date ngayThi;
    private Time gioBatDau;
    private Time gioKetThuc;
    private String diaDiem;
    private int sucChua;
    private long giaGoc;
    private Timestamp ngayTao;

    // Getters & Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getMaCaThi() { return maCaThi; }
    public void setMaCaThi(String maCaThi) { this.maCaThi = maCaThi; }

    public Date getNgayThi() { return ngayThi; }
    public void setNgayThi(Date ngayThi) { this.ngayThi = ngayThi; }

    public Time getGioBatDau() { return gioBatDau; }
    public void setGioBatDau(Time gioBatDau) { this.gioBatDau = gioBatDau; }

    public Time getGioKetThuc() { return gioKetThuc; }
    public void setGioKetThuc(Time gioKetThuc) { this.gioKetThuc = gioKetThuc; }

    public String getDiaDiem() { return diaDiem; }
    public void setDiaDiem(String diaDiem) { this.diaDiem = diaDiem; }

    public int getSucChua() { return sucChua; }
    public void setSucChua(int sucChua) { this.sucChua = sucChua; }

    public long getGiaGoc() { return giaGoc; }
    public void setGiaGoc(long giaGoc) { this.giaGoc = giaGoc; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }
}

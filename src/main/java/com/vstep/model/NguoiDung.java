package com.vstep.model;

import java.sql.Timestamp;

public class NguoiDung {
    private long id;
    private String hoTen;
    private String email;
    private String soDienThoai;
    private String donVi;
    private String matKhau;
    private String vaiTro;
    private boolean kichHoat;
    private String activationToken;
    private Timestamp ngayTao;

    public NguoiDung() {}

    public NguoiDung(long id, String hoTen, String email, String soDienThoai, String donVi,
                     String matKhau, String vaiTro, boolean kichHoat, Timestamp ngayTao) {
        this.id = id;
        this.hoTen = hoTen;
        this.email = email;
        this.soDienThoai = soDienThoai;
        this.donVi = donVi;
        this.matKhau = matKhau;
        this.vaiTro = vaiTro;
        this.kichHoat = kichHoat;
        this.ngayTao = ngayTao;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getDonVi() { return donVi; }
    public void setDonVi(String donVi) { this.donVi = donVi; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public boolean isKichHoat() { return kichHoat; }
    public void setKichHoat(boolean kichHoat) { this.kichHoat = kichHoat; }

    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }

    public String getActivationToken() { return activationToken; }
    public void setActivationToken(String activationToken) { this.activationToken = activationToken; }
}

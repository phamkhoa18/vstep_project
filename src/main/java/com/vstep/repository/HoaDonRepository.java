package com.vstep.repository;

import com.vstep.model.HoaDon;
import java.util.List;

public interface HoaDonRepository {
    boolean create(HoaDon hoaDon);
    HoaDon findById(long id);
    List<HoaDon> findByNguoiDungId(long nguoiDungId);
    List<HoaDon> findByNguoiDungIdAndLoai(long nguoiDungId, String loai);
    HoaDon findBySoHoaDon(String soHoaDon);
    HoaDon findByDangKyIdAndLoai(long dangKyId, String loai);
    boolean update(HoaDon hoaDon);
    boolean delete(long id);
}


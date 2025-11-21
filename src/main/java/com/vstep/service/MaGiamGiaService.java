package com.vstep.service;

import com.vstep.model.MaGiamGia;
import java.util.List;

public interface MaGiamGiaService {
    MaGiamGia findByMaCode(String maCode);
    MaGiamGia findById(long id);
    List<MaGiamGia> findAll();
    List<MaGiamGia> findByLoai(String loai);
    boolean create(MaGiamGia maGiamGia);
    boolean update(MaGiamGia maGiamGia);
    boolean deleteById(long id);
    boolean validateAndApply(String maCode, String loai, long giaGoc);
    long calculateDiscount(String maCode, String loai, long giaGoc);
}


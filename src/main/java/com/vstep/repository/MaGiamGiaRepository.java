package com.vstep.repository;

import com.vstep.model.MaGiamGia;
import java.util.List;

public interface MaGiamGiaRepository {
    MaGiamGia findByMaCode(String maCode);
    MaGiamGia findById(long id);
    List<MaGiamGia> findAll();
    List<MaGiamGia> findByLoai(String loai);
    boolean create(MaGiamGia maGiamGia);
    boolean update(MaGiamGia maGiamGia);
    boolean deleteById(long id);
    boolean incrementSoLuongDaSuDung(long id);
}


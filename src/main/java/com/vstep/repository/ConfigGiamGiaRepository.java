package com.vstep.repository;

import com.vstep.model.ConfigGiamGia;

public interface ConfigGiamGiaRepository {
    ConfigGiamGia findByLoai(String loai);
    boolean update(ConfigGiamGia config);
    boolean create(ConfigGiamGia config);
}


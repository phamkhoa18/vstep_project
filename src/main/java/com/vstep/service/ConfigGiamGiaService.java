package com.vstep.service;

import com.vstep.model.ConfigGiamGia;

public interface ConfigGiamGiaService {
    ConfigGiamGia getConfigByLoai(String loai);
    long getMucGiamThiLai(String loai);
    boolean updateConfig(ConfigGiamGia config);
}


package com.vstep.serviceImpl;

import com.vstep.model.ConfigGiamGia;
import com.vstep.repository.ConfigGiamGiaRepository;
import com.vstep.repositoryImpl.ConfigGiamGiaRepositoryImpl;
import com.vstep.service.ConfigGiamGiaService;

public class ConfigGiamGiaServiceImpl implements ConfigGiamGiaService {

    private ConfigGiamGiaRepository repository;

    public ConfigGiamGiaServiceImpl() {
        this.repository = new ConfigGiamGiaRepositoryImpl();
    }

    @Override
    public ConfigGiamGia getConfigByLoai(String loai) {
        ConfigGiamGia config = repository.findByLoai(loai);
        if (config == null) {
            // Tạo config mặc định nếu chưa có
            config = new ConfigGiamGia();
            config.setLoai(loai);
            config.setMucGiamThiLai(loai.equals("ca_thi") ? 500000 : 0);
            config.setTrangThai("active");
            repository.create(config);
        }
        return config;
    }

    @Override
    public long getMucGiamThiLai(String loai) {
        ConfigGiamGia config = getConfigByLoai(loai);
        if (config != null && "active".equals(config.getTrangThai())) {
            return config.getMucGiamThiLai();
        }
        return 0;
    }

    @Override
    public boolean updateConfig(ConfigGiamGia config) {
        ConfigGiamGia existing = repository.findByLoai(config.getLoai());
        if (existing != null) {
            config.setId(existing.getId());
            return repository.update(config);
        } else {
            return repository.create(config);
        }
    }
}


package com.vstep.serviceImpl;

import com.vstep.model.MaGiamGia;
import com.vstep.repository.MaGiamGiaRepository;
import com.vstep.repositoryImpl.MaGiamGiaRepositoryImpl;
import com.vstep.service.MaGiamGiaService;

import java.util.Date;
import java.util.List;

public class MaGiamGiaServiceImpl implements MaGiamGiaService {

    private MaGiamGiaRepository repository;

    public MaGiamGiaServiceImpl() {
        this.repository = new MaGiamGiaRepositoryImpl();
    }

    @Override
    public MaGiamGia findByMaCode(String maCode) {
        return repository.findByMaCode(maCode);
    }

    @Override
    public MaGiamGia findById(long id) {
        return repository.findById(id);
    }

    @Override
    public List<MaGiamGia> findAll() {
        return repository.findAll();
    }

    @Override
    public List<MaGiamGia> findByLoai(String loai) {
        return repository.findByLoai(loai);
    }

    @Override
    public boolean create(MaGiamGia maGiamGia) {
        return repository.create(maGiamGia);
    }

    @Override
    public boolean update(MaGiamGia maGiamGia) {
        return repository.update(maGiamGia);
    }

    @Override
    public boolean deleteById(long id) {
        return repository.deleteById(id);
    }

    @Override
    public boolean validateAndApply(String maCode, String loai, long giaGoc) {
        if (maCode == null || maCode.trim().isEmpty()) {
            return false;
        }

        MaGiamGia ma = repository.findByMaCode(maCode.trim().toUpperCase());
        if (ma == null) {
            return false;
        }

        // Kiểm tra trạng thái
        if (!"active".equals(ma.getTrangThai())) {
            return false;
        }

        // Kiểm tra loại (phải khớp hoặc là "all")
        if (!"all".equals(ma.getLoai()) && !ma.getLoai().equals(loai)) {
            return false;
        }

        // Kiểm tra ngày hiệu lực
        Date now = new Date();
        if (ma.getNgayBatDau() != null && now.before(ma.getNgayBatDau())) {
            return false;
        }
        if (ma.getNgayKetThuc() != null && now.after(ma.getNgayKetThuc())) {
            return false;
        }

        // Kiểm tra số lượng
        if (ma.getSoLuongToiDa() != null && ma.getSoLuongDaSuDung() >= ma.getSoLuongToiDa()) {
            return false;
        }

        return true;
    }

    @Override
    public long calculateDiscount(String maCode, String loai, long giaGoc) {
        if (!validateAndApply(maCode, loai, giaGoc)) {
            return 0;
        }

        MaGiamGia ma = repository.findByMaCode(maCode.trim().toUpperCase());
        if (ma == null) {
            return 0;
        }

        long discount = 0;
        if ("fixed".equals(ma.getLoaiGiam())) {
            // Giảm giá cố định
            discount = ma.getGiaTriGiam();
        } else if ("percent".equals(ma.getLoaiGiam())) {
            // Giảm giá theo phần trăm
            discount = (giaGoc * ma.getGiaTriGiam()) / 100;
            // Áp dụng giới hạn tối đa nếu có
            if (ma.getGiaTriToiDa() != null && discount > ma.getGiaTriToiDa()) {
                discount = ma.getGiaTriToiDa();
            }
        }

        return discount;
    }
}


package com.vstep.serviceImpl;

import com.vstep.model.HoaDon;
import com.vstep.repository.HoaDonRepository;
import com.vstep.repositoryImpl.HoaDonRepositoryImpl;
import com.vstep.service.HoaDonService;

import java.util.List;

public class HoaDonServiceImpl implements HoaDonService {
    private HoaDonRepository repository = new HoaDonRepositoryImpl();

    @Override
    public boolean create(HoaDon hoaDon) {
        return repository.create(hoaDon);
    }

    @Override
    public HoaDon findById(long id) {
        return repository.findById(id);
    }

    @Override
    public List<HoaDon> findByNguoiDungId(long nguoiDungId) {
        return repository.findByNguoiDungId(nguoiDungId);
    }

    @Override
    public List<HoaDon> findByNguoiDungIdAndLoai(long nguoiDungId, String loai) {
        return repository.findByNguoiDungIdAndLoai(nguoiDungId, loai);
    }

    @Override
    public HoaDon findBySoHoaDon(String soHoaDon) {
        return repository.findBySoHoaDon(soHoaDon);
    }

    @Override
    public HoaDon findByDangKyIdAndLoai(long dangKyId, String loai) {
        return repository.findByDangKyIdAndLoai(dangKyId, loai);
    }

    @Override
    public boolean update(HoaDon hoaDon) {
        return repository.update(hoaDon);
    }

    @Override
    public boolean delete(long id) {
        return repository.delete(id);
    }
}


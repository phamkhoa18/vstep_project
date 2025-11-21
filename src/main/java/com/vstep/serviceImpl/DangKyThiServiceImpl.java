package com.vstep.serviceImpl;

import java.util.List;

import com.vstep.model.DangKyThi;
import com.vstep.repositoryImpl.DangKyThiRepositoryImpl;
import com.vstep.service.DangKyThiService;

public class DangKyThiServiceImpl implements DangKyThiService {

    private final DangKyThiRepositoryImpl repository;

    public DangKyThiServiceImpl() {
        this.repository = new DangKyThiRepositoryImpl();
    }

    @Override
    public boolean create(DangKyThi dangKyThi) {
        return repository.create(dangKyThi);
    }

    @Override
    public List<DangKyThi> findAll() {
        return repository.findAll();
    }

    @Override
    public DangKyThi findById(long id) {
        return repository.findById((int) id);
    }

    @Override
    public boolean update(DangKyThi dangKyThi) {
        return repository.update(dangKyThi);
    }

    @Override
    public boolean deleteById(long id) {
        return repository.deleteById((int) id);
    }

    @Override
    public List<DangKyThi> findByNguoiDungId(long nguoiDungId) {
        return repository.findByNguoiDungId(nguoiDungId);
    }

    @Override
    public List<DangKyThi> findByCaThiId(long caThiId) {
        return repository.findByCaThiId(caThiId);
    }

    @Override
    public DangKyThi findByNguoiDungIdAndCaThiId(long nguoiDungId, long caThiId) {
        return repository.findByNguoiDungIdAndCaThiId(nguoiDungId, caThiId);
    }

    @Override
    public int countByCaThiId(long caThiId) {
        return repository.countByCaThiId(caThiId);
    }
}


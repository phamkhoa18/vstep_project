package com.vstep.serviceImpl;

import java.util.List;

import com.vstep.model.DangKyLop;
import com.vstep.repositoryImpl.DangKyLopRepositoryImpl;
import com.vstep.service.DangKyLopService;

public class DangKyLopServiceImpl implements DangKyLopService {

    private final DangKyLopRepositoryImpl repository;

    public DangKyLopServiceImpl() {
        this.repository = new DangKyLopRepositoryImpl();
    }

    @Override
    public boolean create(DangKyLop dangKyLop) {
        return repository.create(dangKyLop);
    }

    @Override
    public List<DangKyLop> findAll() {
        return repository.findAll();
    }

    @Override
    public DangKyLop findById(long id) {
        return repository.findById((int) id);
    }

    @Override
    public boolean update(DangKyLop dangKyLop) {
        return repository.update(dangKyLop);
    }

    @Override
    public boolean deleteById(long id) {
        return repository.deleteById((int) id);
    }

    @Override
    public List<DangKyLop> findByNguoiDungId(long nguoiDungId) {
        return repository.findByNguoiDungId(nguoiDungId);
    }

    @Override
    public List<DangKyLop> findByLopOnId(long lopOnId) {
        return repository.findByLopOnId(lopOnId);
    }

    @Override
    public DangKyLop findByNguoiDungIdAndLopOnId(long nguoiDungId, long lopOnId) {
        return repository.findByNguoiDungIdAndLopOnId(nguoiDungId, lopOnId);
    }

    @Override
    public int countByLopOnId(long lopOnId) {
        return repository.countByLopOnId(lopOnId);
    }

    @Override
    public boolean isUserRegistered(long nguoiDungId, long lopOnId) {
        DangKyLop existing = repository.findByNguoiDungIdAndLopOnId(nguoiDungId, lopOnId);
        return existing != null;
    }
}


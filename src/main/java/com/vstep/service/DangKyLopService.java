package com.vstep.service;

import java.util.List;

import com.vstep.model.DangKyLop;

public interface DangKyLopService {
    boolean create(DangKyLop dangKyLop);
    List<DangKyLop> findAll();
    DangKyLop findById(long id);
    boolean update(DangKyLop dangKyLop);
    boolean deleteById(long id);
    List<DangKyLop> findByNguoiDungId(long nguoiDungId);
    List<DangKyLop> findByLopOnId(long lopOnId);
    DangKyLop findByNguoiDungIdAndLopOnId(long nguoiDungId, long lopOnId);
    int countByLopOnId(long lopOnId);
    boolean isUserRegistered(long nguoiDungId, long lopOnId);
}


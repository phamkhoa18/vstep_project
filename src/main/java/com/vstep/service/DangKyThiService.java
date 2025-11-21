package com.vstep.service;

import java.util.List;

import com.vstep.model.DangKyThi;

public interface DangKyThiService {
    boolean create(DangKyThi dangKyThi);
    List<DangKyThi> findAll();
    DangKyThi findById(long id);
    boolean update(DangKyThi dangKyThi);
    boolean deleteById(long id);
    List<DangKyThi> findByNguoiDungId(long nguoiDungId);
    List<DangKyThi> findByCaThiId(long caThiId);
    DangKyThi findByNguoiDungIdAndCaThiId(long nguoiDungId, long caThiId);
    int countByCaThiId(long caThiId);
}


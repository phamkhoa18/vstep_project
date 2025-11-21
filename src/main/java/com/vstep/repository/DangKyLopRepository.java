package com.vstep.repository;

import java.util.List;

import com.vstep.model.DangKyLop;

public interface DangKyLopRepository extends Repository<DangKyLop> {
    List<DangKyLop> findByNguoiDungId(long nguoiDungId);
    List<DangKyLop> findByLopOnId(long lopOnId);
    DangKyLop findByNguoiDungIdAndLopOnId(long nguoiDungId, long lopOnId);
    int countByLopOnId(long lopOnId);
    boolean deleteByLopOnId(long lopOnId);
}


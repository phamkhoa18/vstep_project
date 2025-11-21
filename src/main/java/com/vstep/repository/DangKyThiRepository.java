package com.vstep.repository;

import com.vstep.model.DangKyThi;
import java.util.List;

public interface DangKyThiRepository extends Repository<DangKyThi> {
    List<DangKyThi> findByNguoiDungId(long nguoiDungId);
    List<DangKyThi> findByCaThiId(long caThiId);
    DangKyThi findByNguoiDungIdAndCaThiId(long nguoiDungId, long caThiId);
    int countByCaThiId(long caThiId);
    boolean deleteByCaThiId(long caThiId);
}


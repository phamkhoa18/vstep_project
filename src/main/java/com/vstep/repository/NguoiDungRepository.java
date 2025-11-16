package com.vstep.repository;

import com.vstep.model.NguoiDung;
import java.util.List;

public interface NguoiDungRepository extends Repository<NguoiDung> {
    List<NguoiDung> findByVaiTro(String vaiTro);
    NguoiDung findByActivationToken(String token);
}

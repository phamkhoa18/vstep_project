package com.vstep.service;

import com.vstep.model.NguoiDung;

import java.util.List;

public interface NguoiDungService {
    NguoiDung findByEmail(String email); // thay vì findByTitle, hợp lý hơn cho user
    boolean create(NguoiDung entity);
    List<NguoiDung> findAll();
    NguoiDung findById(long id);
    boolean update(NguoiDung entity);
    boolean deleteById(long id);
}
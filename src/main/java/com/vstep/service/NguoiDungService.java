package com.vstep.service;

import com.vstep.model.NguoiDung;

import java.util.List;

public interface NguoiDungService {
    NguoiDung findByTitle(String title);
    //    Book create(Book entity);
    boolean create(NguoiDung entity);
    List<NguoiDung> findAll();
    NguoiDung findById(int id);
    boolean update(NguoiDung entity);
    boolean deleteById(int id);
}

package com.vstep.serviceImpl;

import com.vstep.model.NguoiDung;
import com.vstep.service.NguoiDungService;

import java.util.List;

public class NguoiDungServiceImpl implements NguoiDungService {
    @Override
    public List<NguoiDung> findAll() {
        return List.of();
    }

    @Override
    public NguoiDung findById(int id) {
        return null;
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public NguoiDung findByTitle(String title) {
        return null;
    }

    @Override
    public boolean create(NguoiDung entity) {
        return false;
    }

    @Override
    public boolean update(NguoiDung entity) {
        return false;
    }
}

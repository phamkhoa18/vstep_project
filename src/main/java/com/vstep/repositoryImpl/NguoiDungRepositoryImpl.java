package com.vstep.repositoryImpl;

import com.vstep.model.NguoiDung;
import com.vstep.repository.NguoiDungRepository;

import java.util.List;

public class NguoiDungRepositoryImpl implements NguoiDungRepository {
    @Override
    public boolean create(NguoiDung nguoiDung) {
        return false;
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public boolean update(NguoiDung nguoiDung) {
        return false;
    }

    @Override
    public NguoiDung findById(int id) {
        return null;
    }

    @Override
    public List<NguoiDung> findAll() {
        return List.of();
    }
}

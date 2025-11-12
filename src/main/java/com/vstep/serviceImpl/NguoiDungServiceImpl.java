package com.vstep.serviceImpl;

import com.vstep.model.NguoiDung;
import com.vstep.repositoryImpl.NguoiDungRepositoryImpl;
import com.vstep.service.NguoiDungService;

import java.util.List;

public class NguoiDungServiceImpl implements NguoiDungService {

    private final NguoiDungRepositoryImpl repository;

    public NguoiDungServiceImpl() {
        this.repository = new NguoiDungRepositoryImpl();
    }

    @Override
    public boolean create(NguoiDung entity) {
        return repository.create(entity);
    }

    @Override
    public List<NguoiDung> findAll() {
        return repository.findAll();
    }

    @Override
    public NguoiDung findById(long id) {
        return repository.findById((int) id); // repository dùng int
    }

    @Override
    public boolean update(NguoiDung entity) {
        return repository.update(entity);
    }

    @Override
    public boolean deleteById(long id) {
        return repository.deleteById((int) id);
    }

    @Override
    public NguoiDung findByEmail(String email) {
        List<NguoiDung> list = repository.findAll();
        for (NguoiDung nd : list) {
            if (nd.getEmail() != null && nd.getEmail().equalsIgnoreCase(email)) {
                return nd;
            }
        }
        return null;
    }
}

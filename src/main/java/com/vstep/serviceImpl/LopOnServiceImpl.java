package com.vstep.serviceImpl;

import java.util.List;

import com.vstep.model.LopOn;
import com.vstep.repositoryImpl.LopOnRepositoryImpl;
import com.vstep.service.LopOnService;

public class LopOnServiceImpl implements LopOnService {

    private final LopOnRepositoryImpl repository;

    public LopOnServiceImpl() {
        this.repository = new LopOnRepositoryImpl();
    }

    @Override
    public boolean create(LopOn lopOn) {
        return repository.create(lopOn);
    }

    @Override
    public List<LopOn> findAll() {
        return repository.findAll();
    }

    @Override
    public LopOn findById(long id) {
        return repository.findById((int) id);
    }

    @Override
    public LopOn findBySlug(String slug) {
        return repository.findBySlug(slug);
    }

    @Override
    public boolean update(LopOn lopOn) {
        return repository.update(lopOn);
    }

    @Override
    public boolean deleteById(long id) {
        return repository.deleteById((int) id);
    }
}


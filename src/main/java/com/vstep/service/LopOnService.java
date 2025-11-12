package com.vstep.service;

import java.util.List;

import com.vstep.model.LopOn;

public interface LopOnService {
    boolean create(LopOn lopOn);
    List<LopOn> findAll();
    LopOn findById(long id);
    boolean update(LopOn lopOn);
    boolean deleteById(long id);
}


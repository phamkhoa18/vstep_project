package com.vstep.service;

import java.sql.SQLException;
import java.util.List;

import com.vstep.model.LopOn;

public interface LopOnService {
    boolean create(LopOn lopOn);
    List<LopOn> findAll();
    LopOn findById(long id);
    LopOn findBySlug(String slug);
    boolean update(LopOn lopOn);
    boolean deleteById(long id) throws SQLException;
}


package com.vstep.service;

import java.sql.SQLException;
import java.util.List;

import com.vstep.model.CaThi;

public interface CaThiService {
    boolean create(CaThi caThi);
    List<CaThi> findAll();
    CaThi findById(long id);
    boolean update(CaThi caThi);
    boolean deleteById(long id) throws SQLException;
}


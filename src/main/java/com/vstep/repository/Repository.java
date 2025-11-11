package com.vstep.repository;

import java.util.List;

public interface Repository<T> {
    boolean create(T t);
    List<T> findAll();
    T findById(int id);
    boolean update(T entity);
    boolean deleteById(int id);
}

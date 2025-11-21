package com.vstep.serviceImpl;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
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
    public boolean deleteById(long id) throws SQLException {
        try {
            return repository.deleteById((int) id);
        } catch (RuntimeException e) {
            // Unwrap SQLException từ RuntimeException
            Throwable cause = e.getCause();
            if (cause == null) {
                // Nếu không có cause, kiểm tra message
                if (e.getMessage() != null && e.getMessage().contains("Foreign key constraint violation")) {
                    // Tạo lại SQLIntegrityConstraintViolationException
                    SQLIntegrityConstraintViolationException sqlEx = new SQLIntegrityConstraintViolationException(
                        "Không thể xóa lớp ôn vì có ràng buộc khóa ngoại");
                    sqlEx.initCause(e);
                    throw sqlEx;
                }
                throw new SQLException("Lỗi khi xóa lớp ôn: " + e.getMessage(), e);
            }
            
            if (cause instanceof SQLIntegrityConstraintViolationException) {
                throw (SQLIntegrityConstraintViolationException) cause;
            } else if (cause instanceof SQLException) {
                throw (SQLException) cause;
            } else {
                // Nếu không phải SQLException, wrap lại
                throw new SQLException("Lỗi khi xóa lớp ôn", cause);
            }
        }
    }
}


package com.vstep.serviceImpl;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import com.vstep.model.CaThi;
import com.vstep.repositoryImpl.CaThiRepositoryImpl;
import com.vstep.service.CaThiService;

public class CaThiServiceImpl implements CaThiService {

    private final CaThiRepositoryImpl repository;

    public CaThiServiceImpl() {
        this.repository = new CaThiRepositoryImpl();
    }

    @Override
    public boolean create(CaThi caThi) {
        return repository.create(caThi);
    }

    @Override
    public List<CaThi> findAll() {
        return repository.findAll();
    }

    @Override
    public CaThi findById(long id) {
        return repository.findById((int) id);
    }

    @Override
    public boolean update(CaThi caThi) {
        return repository.update(caThi);
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
                        "Không thể xóa ca thi vì có ràng buộc khóa ngoại");
                    sqlEx.initCause(e);
                    throw sqlEx;
                }
                throw new SQLException("Lỗi khi xóa ca thi: " + e.getMessage(), e);
            }
            
            if (cause instanceof SQLIntegrityConstraintViolationException) {
                throw (SQLIntegrityConstraintViolationException) cause;
            } else if (cause instanceof SQLException) {
                throw (SQLException) cause;
            } else {
                // Nếu không phải SQLException, wrap lại
                throw new SQLException("Lỗi khi xóa ca thi", cause);
            }
        }
    }
}


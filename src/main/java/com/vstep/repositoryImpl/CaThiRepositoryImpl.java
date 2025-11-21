package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vstep.model.CaThi;
import com.vstep.repository.CaThiRepository;
import com.vstep.util.DataSourceUtil;

public class CaThiRepositoryImpl implements CaThiRepository {

    private static final Logger LOGGER = Logger.getLogger(CaThiRepositoryImpl.class.getName());

    @Override
    public boolean create(CaThi caThi) {
        String sql = """
                INSERT INTO ca_thi
                    (ma_ca_thi, ngay_thi, gio_bat_dau, gio_ket_thuc, dia_diem, suc_chua, gia_goc, ngay_tao)
                VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, caThi.getMaCaThi());
            setNullableDate(statement, 2, caThi.getNgayThi());
            statement.setTime(3, caThi.getGioBatDau());
            statement.setTime(4, caThi.getGioKetThuc());
            statement.setString(5, caThi.getDiaDiem());
            statement.setInt(6, caThi.getSucChua());
            statement.setLong(7, caThi.getGiaGoc());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo ca thi mới", e);
            return false;
        }
    }

    @Override
    public List<CaThi> findAll() {
        List<CaThi> result = new ArrayList<>();
        String sql = "SELECT * FROM ca_thi ORDER BY ngay_thi DESC, gio_bat_dau ASC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách ca thi", e);
        }

        return result;
    }

    @Override
    public CaThi findById(int id) {
        String sql = "SELECT * FROM ca_thi WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm ca thi có id=" + id, e);
        }
        return null;
    }

    @Override
    public boolean update(CaThi caThi) {
        String sql = """
                UPDATE ca_thi
                   SET ma_ca_thi = ?, ngay_thi = ?, gio_bat_dau = ?, gio_ket_thuc = ?, dia_diem = ?,
                       suc_chua = ?, gia_goc = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, caThi.getMaCaThi());
            setNullableDate(statement, 2, caThi.getNgayThi());
            statement.setTime(3, caThi.getGioBatDau());
            statement.setTime(4, caThi.getGioKetThuc());
            statement.setString(5, caThi.getDiaDiem());
            statement.setInt(6, caThi.getSucChua());
            statement.setLong(7, caThi.getGiaGoc());
            statement.setLong(8, caThi.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật ca thi", e);
            return false;
        }
    }

    @Override
    public boolean deleteById(int id) {
        // Sử dụng transaction để đảm bảo atomicity
        Connection connection = null;
        try {
            connection = DataSourceUtil.getConnection();
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Bước 1: Xóa tất cả đăng ký thi liên quan
            String deleteRegistrationsSql = "DELETE FROM dang_ky_thi WHERE ca_thi_id = ?";
            try (PreparedStatement deleteRegistrationsStmt = connection.prepareStatement(deleteRegistrationsSql)) {
                deleteRegistrationsStmt.setInt(1, id);
                int deletedCount = deleteRegistrationsStmt.executeUpdate();
                LOGGER.log(Level.INFO, "Đã xóa {0} đăng ký thi liên quan đến ca thi id={1}", 
                          new Object[]{deletedCount, id});
            }

            // Bước 2: Xóa ca thi
            String deleteCaThiSql = "DELETE FROM ca_thi WHERE id = ?";
            try (PreparedStatement deleteCaThiStmt = connection.prepareStatement(deleteCaThiSql)) {
                deleteCaThiStmt.setInt(1, id);
                int rowsAffected = deleteCaThiStmt.executeUpdate();
                
                if (rowsAffected == 0) {
                    connection.rollback();
                    LOGGER.log(Level.WARNING, "Không tìm thấy ca thi id={0} để xóa", id);
                    return false;
                }
                
                // Commit transaction nếu tất cả đều thành công
                connection.commit();
                LOGGER.log(Level.INFO, "Đã xóa ca thi id={0} và tất cả đăng ký liên quan", id);
                return true;
            }
        } catch (SQLException e) {
            // Rollback transaction nếu có lỗi
            if (connection != null) {
                try {
                    connection.rollback();
                    LOGGER.log(Level.SEVERE, "Đã rollback transaction khi xóa ca thi id=" + id, e);
                } catch (SQLException rollbackEx) {
                    LOGGER.log(Level.SEVERE, "Lỗi khi rollback transaction", rollbackEx);
                }
            }
            
            // Kiểm tra xem có phải foreign key constraint violation không
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            // MySQL error code 1451 = Cannot delete or update a parent row: a foreign key constraint fails
            if (sqlState != null && (sqlState.equals("23000") || errorCode == 1451)) {
                LOGGER.log(Level.SEVERE, "Không thể xoá ca thi có id=" + id + " - Foreign key constraint violation", e);
                // Tạo SQLIntegrityConstraintViolationException mới
                SQLIntegrityConstraintViolationException fkEx = new SQLIntegrityConstraintViolationException(
                    e.getMessage(), e.getSQLState(), errorCode);
                fkEx.setStackTrace(e.getStackTrace());
                throw new RuntimeException(fkEx);
            }
            LOGGER.log(Level.SEVERE, "Không thể xoá ca thi có id=" + id, e);
            throw new RuntimeException(e);
        } finally {
            // Đảm bảo connection được đóng
            if (connection != null) {
                try {
                    connection.setAutoCommit(true); // Reset auto-commit
                    connection.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Lỗi khi đóng connection", e);
                }
            }
        }
    }

    private CaThi mapResultSet(ResultSet rs) throws SQLException {
        CaThi caThi = new CaThi();
        caThi.setId(rs.getLong("id"));
        caThi.setMaCaThi(rs.getString("ma_ca_thi"));
        caThi.setNgayThi(rs.getDate("ngay_thi"));
        caThi.setGioBatDau(rs.getTime("gio_bat_dau"));
        caThi.setGioKetThuc(rs.getTime("gio_ket_thuc"));
        caThi.setDiaDiem(rs.getString("dia_diem"));
        caThi.setSucChua(rs.getInt("suc_chua"));
        caThi.setGiaGoc(rs.getLong("gia_goc"));
        Timestamp createdAt = rs.getTimestamp("ngay_tao");
        caThi.setNgayTao(createdAt);
        return caThi;
    }

    private void setNullableDate(PreparedStatement statement, int index, Date date) throws SQLException {
        if (date != null) {
            statement.setDate(index, date);
        } else {
            statement.setNull(index, java.sql.Types.DATE);
        }
    }
}


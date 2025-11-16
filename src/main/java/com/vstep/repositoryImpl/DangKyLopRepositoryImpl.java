package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vstep.model.DangKyLop;
import com.vstep.repository.DangKyLopRepository;
import com.vstep.util.DataSourceUtil;

public class DangKyLopRepositoryImpl implements DangKyLopRepository {

    private static final Logger LOGGER = Logger.getLogger(DangKyLopRepositoryImpl.class.getName());

    @Override
    public boolean create(DangKyLop dangKyLop) {
        String sql = """
                INSERT INTO dang_ky_lop 
                    (nguoi_dung_id, lop_on_id, ngay_dang_ky, ghi_chu, so_tien_da_tra, trang_thai, ma_xac_nhan)
                VALUES (?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setLong(1, dangKyLop.getNguoiDungId());
            statement.setLong(2, dangKyLop.getLopOnId());
            statement.setString(3, dangKyLop.getGhiChu());
            statement.setLong(4, dangKyLop.getSoTienDaTra());
            statement.setString(5, dangKyLop.getTrangThai() != null ? dangKyLop.getTrangThai() : "Chờ xác nhận");
            
            // Tạo mã xác nhận nếu chưa có
            String maXacNhan = dangKyLop.getMaXacNhan();
            if (maXacNhan == null || maXacNhan.isEmpty()) {
                maXacNhan = "DK" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            }
            statement.setString(6, maXacNhan);

            int affectedRows = statement.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        dangKyLop.setId(generatedKeys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo đăng ký lớp", e);
        }
        return false;
    }

    @Override
    public List<DangKyLop> findAll() {
        List<DangKyLop> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_lop ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách đăng ký lớp", e);
        }

        return result;
    }

    @Override
    public DangKyLop findById(int id) {
        String sql = "SELECT * FROM dang_ky_lop WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký lớp có id=" + id, e);
        }
        return null;
    }

    @Override
    public boolean update(DangKyLop dangKyLop) {
        String sql = """
                UPDATE dang_ky_lop
                   SET ghi_chu = ?, so_tien_da_tra = ?, trang_thai = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, dangKyLop.getGhiChu());
            statement.setLong(2, dangKyLop.getSoTienDaTra());
            statement.setString(3, dangKyLop.getTrangThai());
            statement.setLong(4, dangKyLop.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật đăng ký lớp", e);
        }
        return false;
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM dang_ky_lop WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá đăng ký lớp có id=" + id, e);
        }
        return false;
    }

    @Override
    public List<DangKyLop> findByNguoiDungId(long nguoiDungId) {
        List<DangKyLop> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_lop WHERE nguoi_dung_id = ? ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, nguoiDungId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký lớp của người dùng id=" + nguoiDungId, e);
        }
        return result;
    }

    @Override
    public List<DangKyLop> findByLopOnId(long lopOnId) {
        List<DangKyLop> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_lop WHERE lop_on_id = ? ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, lopOnId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký lớp của lớp id=" + lopOnId, e);
        }
        return result;
    }

    @Override
    public DangKyLop findByNguoiDungIdAndLopOnId(long nguoiDungId, long lopOnId) {
        String sql = "SELECT * FROM dang_ky_lop WHERE nguoi_dung_id = ? AND lop_on_id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, nguoiDungId);
            statement.setLong(2, lopOnId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký lớp", e);
        }
        return null;
    }

    @Override
    public int countByLopOnId(long lopOnId) {
        String sql = "SELECT COUNT(*) FROM dang_ky_lop WHERE lop_on_id = ? AND trang_thai IN ('Đã xác nhận', 'Chờ xác nhận', 'Đang học')";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, lopOnId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể đếm số đăng ký lớp", e);
        }
        return 0;
    }

    private DangKyLop mapResultSet(ResultSet rs) throws SQLException {
        DangKyLop dangKyLop = new DangKyLop();
        dangKyLop.setId(rs.getLong("id"));
        dangKyLop.setNguoiDungId(rs.getLong("nguoi_dung_id"));
        dangKyLop.setLopOnId(rs.getLong("lop_on_id"));
        dangKyLop.setNgayDangKy(rs.getTimestamp("ngay_dang_ky"));
        dangKyLop.setGhiChu(rs.getString("ghi_chu"));
        dangKyLop.setSoTienDaTra(rs.getLong("so_tien_da_tra"));
        dangKyLop.setTrangThai(rs.getString("trang_thai"));
        dangKyLop.setMaXacNhan(rs.getString("ma_xac_nhan"));
        return dangKyLop;
    }
}


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
                    (nguoi_dung_id, lop_on_id, ngay_dang_ky, ghi_chu, so_tien_da_tra, muc_giam, trang_thai, ma_xac_nhan, ma_code_giam_gia)
                VALUES (?, ?, CURRENT_TIMESTAMP, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setLong(1, dangKyLop.getNguoiDungId());
            statement.setLong(2, dangKyLop.getLopOnId());
            statement.setString(3, dangKyLop.getGhiChu());
            statement.setLong(4, dangKyLop.getSoTienDaTra());
            statement.setLong(5, dangKyLop.getMucGiam());
            statement.setString(6, dangKyLop.getTrangThai() != null ? dangKyLop.getTrangThai() : "Chờ xác nhận");
            
            // Tạo mã xác nhận nếu chưa có
            String maXacNhan = dangKyLop.getMaXacNhan();
            if (maXacNhan == null || maXacNhan.isEmpty()) {
                maXacNhan = "DK" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            }
            statement.setString(7, maXacNhan);
            statement.setString(8, dangKyLop.getMaCodeGiamGia());

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
        // CHỈ đếm những đăng ký ĐÃ THANH TOÁN (trạng thái "Đã duyệt" hoặc đã có số tiền đã trả > 0)
        // Không đếm những đăng ký "Chờ xác nhận" vì chưa thanh toán, slot vẫn còn
        String sql = """
                SELECT COUNT(*) FROM dang_ky_lop 
                WHERE lop_on_id = ? 
                AND (trang_thai = 'Đã duyệt' OR so_tien_da_tra > 0)
                """;

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

    @Override
    public boolean deleteByLopOnId(long lopOnId) {
        String sql = "DELETE FROM dang_ky_lop WHERE lop_on_id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, lopOnId);
            int rowsAffected = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Đã xóa {0} đăng ký lớp liên quan đến lớp id={1}", 
                       new Object[]{rowsAffected, lopOnId});
            return true; // Trả về true ngay cả khi không có đăng ký nào (rowsAffected = 0)
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá đăng ký lớp có lop_on_id=" + lopOnId, e);
            return false;
        }
    }

    private DangKyLop mapResultSet(ResultSet rs) throws SQLException {
        DangKyLop dangKyLop = new DangKyLop();
        dangKyLop.setId(rs.getLong("id"));
        dangKyLop.setNguoiDungId(rs.getLong("nguoi_dung_id"));
        dangKyLop.setLopOnId(rs.getLong("lop_on_id"));
        // Connection string đã được set timezone Asia/Ho_Chi_Minh, nên đọc timestamp trực tiếp
        dangKyLop.setNgayDangKy(rs.getTimestamp("ngay_dang_ky"));
        dangKyLop.setGhiChu(rs.getString("ghi_chu"));
        dangKyLop.setSoTienDaTra(rs.getLong("so_tien_da_tra"));
        
        // Xử lý muc_giam an toàn (có thể không tồn tại trong đăng ký cũ)
        java.sql.ResultSetMetaData metaData = rs.getMetaData();
        boolean hasMucGiam = false;
        boolean hasMaCodeGiamGia = false;
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
            String columnName = metaData.getColumnName(i);
            if ("muc_giam".equalsIgnoreCase(columnName)) {
                hasMucGiam = true;
            }
            if ("ma_code_giam_gia".equalsIgnoreCase(columnName)) {
                hasMaCodeGiamGia = true;
            }
        }
        
        if (hasMucGiam) {
            long mucGiam = rs.getLong("muc_giam");
            dangKyLop.setMucGiam(rs.wasNull() ? 0 : mucGiam);
        } else {
            dangKyLop.setMucGiam(0);
        }
        
        dangKyLop.setTrangThai(rs.getString("trang_thai"));
        dangKyLop.setMaXacNhan(rs.getString("ma_xac_nhan"));
        
        if (hasMaCodeGiamGia) {
            dangKyLop.setMaCodeGiamGia(rs.getString("ma_code_giam_gia"));
        } else {
            dangKyLop.setMaCodeGiamGia(null);
        }
        
        return dangKyLop;
    }
}


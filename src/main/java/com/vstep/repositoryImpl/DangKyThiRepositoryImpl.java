package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vstep.model.DangKyThi;
import com.vstep.repository.DangKyThiRepository;
import com.vstep.util.DataSourceUtil;

public class DangKyThiRepositoryImpl implements DangKyThiRepository {

    private static final Logger LOGGER = Logger.getLogger(DangKyThiRepositoryImpl.class.getName());

    @Override
    public boolean create(DangKyThi dangKyThi) {
        String sql = """
                INSERT INTO dang_ky_thi
                    (nguoi_dung_id, ca_thi_id, da_tung_thi, muc_giam, so_tien_phai_tra, trang_thai, ngay_dang_ky, ma_xac_nhan, ma_code_giam_gia)
                VALUES (?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            statement.setLong(1, dangKyThi.getNguoiDungId());
            statement.setLong(2, dangKyThi.getCaThiId());
            statement.setBoolean(3, dangKyThi.isDaTungThi());
            statement.setLong(4, dangKyThi.getMucGiam());
            statement.setLong(5, dangKyThi.getSoTienPhaiTra());
            statement.setString(6, dangKyThi.getTrangThai() != null ? dangKyThi.getTrangThai() : "Chờ xác nhận");
            
            // Tạo mã xác nhận nếu chưa có
            String maXacNhan = dangKyThi.getMaXacNhan();
            if (maXacNhan == null || maXacNhan.isEmpty()) {
                maXacNhan = "CT" + System.currentTimeMillis() + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            }
            statement.setString(7, maXacNhan);
            statement.setString(8, dangKyThi.getMaCodeGiamGia());

            int affectedRows = statement.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        dangKyThi.setId(generatedKeys.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo đăng ký thi", e);
        }
        return false;
    }

    @Override
    public List<DangKyThi> findAll() {
        List<DangKyThi> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_thi ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách đăng ký thi", e);
        }

        return result;
    }

    @Override
    public DangKyThi findById(int id) {
        String sql = "SELECT * FROM dang_ky_thi WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký thi có id=" + id, e);
        }
        return null;
    }

    @Override
    public boolean update(DangKyThi dangKyThi) {
        String sql = """
                UPDATE dang_ky_thi
                   SET da_tung_thi = ?, muc_giam = ?, so_tien_phai_tra = ?, trang_thai = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setBoolean(1, dangKyThi.isDaTungThi());
            statement.setLong(2, dangKyThi.getMucGiam());
            statement.setLong(3, dangKyThi.getSoTienPhaiTra());
            statement.setString(4, dangKyThi.getTrangThai());
            statement.setLong(5, dangKyThi.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật đăng ký thi", e);
        }
        return false;
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM dang_ky_thi WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá đăng ký thi có id=" + id, e);
        }
        return false;
    }

    @Override
    public List<DangKyThi> findByNguoiDungId(long nguoiDungId) {
        List<DangKyThi> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_thi WHERE nguoi_dung_id = ? ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, nguoiDungId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký thi của người dùng id=" + nguoiDungId, e);
        }
        return result;
    }

    @Override
    public List<DangKyThi> findByCaThiId(long caThiId) {
        List<DangKyThi> result = new ArrayList<>();
        String sql = "SELECT * FROM dang_ky_thi WHERE ca_thi_id = ? ORDER BY ngay_dang_ky DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, caThiId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký thi của ca thi id=" + caThiId, e);
        }
        return result;
    }

    @Override
    public DangKyThi findByNguoiDungIdAndCaThiId(long nguoiDungId, long caThiId) {
        String sql = "SELECT * FROM dang_ky_thi WHERE nguoi_dung_id = ? AND ca_thi_id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, nguoiDungId);
            statement.setLong(2, caThiId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm đăng ký thi", e);
        }
        return null;
    }

    @Override
    public int countByCaThiId(long caThiId) {
        // CHỈ đếm những đăng ký ĐÃ THANH TOÁN (trạng thái "Đã duyệt")
        // Không đếm những đăng ký "Chờ xác nhận" vì chưa thanh toán, slot vẫn còn
        String sql = """
                SELECT COUNT(*) FROM dang_ky_thi 
                WHERE ca_thi_id = ? 
                AND trang_thai = 'Đã duyệt'
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, caThiId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể đếm số đăng ký thi", e);
        }
        return 0;
    }

    @Override
    public boolean deleteByCaThiId(long caThiId) {
        String sql = "DELETE FROM dang_ky_thi WHERE ca_thi_id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, caThiId);
            int rowsAffected = statement.executeUpdate();
            LOGGER.log(Level.INFO, "Đã xóa {0} đăng ký thi liên quan đến ca thi id={1}", 
                       new Object[]{rowsAffected, caThiId});
            return true; // Trả về true ngay cả khi không có đăng ký nào (rowsAffected = 0)
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá đăng ký thi có ca_thi_id=" + caThiId, e);
            return false;
        }
    }

    private DangKyThi mapResultSet(ResultSet rs) throws SQLException {
        DangKyThi dangKyThi = new DangKyThi();
        dangKyThi.setId(rs.getLong("id"));
        dangKyThi.setNguoiDungId(rs.getLong("nguoi_dung_id"));
        dangKyThi.setCaThiId(rs.getLong("ca_thi_id"));
        dangKyThi.setDaTungThi(rs.getBoolean("da_tung_thi"));
        dangKyThi.setMucGiam(rs.getLong("muc_giam"));
        dangKyThi.setSoTienPhaiTra(rs.getLong("so_tien_phai_tra"));
        dangKyThi.setTrangThai(rs.getString("trang_thai"));
        dangKyThi.setNgayDangKy(rs.getTimestamp("ngay_dang_ky"));
        dangKyThi.setMaXacNhan(rs.getString("ma_xac_nhan"));
        
        // Xử lý ma_code_giam_gia an toàn (có thể không tồn tại trong đăng ký cũ)
        java.sql.ResultSetMetaData metaData = rs.getMetaData();
        boolean hasMaCodeGiamGia = false;
        for (int i = 1; i <= metaData.getColumnCount(); i++) {
            String columnName = metaData.getColumnName(i);
            if ("ma_code_giam_gia".equalsIgnoreCase(columnName)) {
                hasMaCodeGiamGia = true;
                break;
            }
        }
        
        if (hasMaCodeGiamGia) {
            dangKyThi.setMaCodeGiamGia(rs.getString("ma_code_giam_gia"));
        } else {
            dangKyThi.setMaCodeGiamGia(null);
        }
        
        return dangKyThi;
    }
}


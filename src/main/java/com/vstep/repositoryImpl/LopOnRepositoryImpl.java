package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vstep.model.LopOn;
import com.vstep.repository.LopOnRepository;
import com.vstep.util.DataSourceUtil;

public class LopOnRepositoryImpl implements LopOnRepository {

    private static final Logger LOGGER = Logger.getLogger(LopOnRepositoryImpl.class.getName());

    @Override
    public boolean create(LopOn lopOn) {
        String sql = """
                INSERT INTO lop_on
                    (ma_lop, tieu_de, slug, mo_ta_ngan, hinh_thuc, nhip_do, ngay_khai_giang, ngay_ket_thuc,
                     so_buoi, gio_moi_buoi, hoc_phi, si_so_toi_da, thoi_gian_hoc, tinh_trang, noi_dung_chi_tiet, ngay_tao)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, lopOn.getMaLop());
            statement.setString(2, lopOn.getTieuDe());
            statement.setString(3, lopOn.getSlug());
            statement.setString(4, lopOn.getMoTaNgan());
            statement.setString(5, lopOn.getHinhThuc());
            statement.setString(6, lopOn.getNhipDo());
            setNullableDate(statement, 7, lopOn.getNgayKhaiGiang());
            setNullableDate(statement, 8, lopOn.getNgayKetThuc());
            statement.setInt(9, lopOn.getSoBuoi());
            statement.setTime(10, lopOn.getGioMoiBuoi());
            statement.setLong(11, lopOn.getHocPhi());
            statement.setInt(12, lopOn.getSiSoToiDa());
            statement.setString(13, lopOn.getThoiGianHoc());
            statement.setString(14, lopOn.getTinhTrang());
            statement.setString(15, lopOn.getNoiDungChiTiet());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo lớp ôn mới", e);
            return false;
        }
    }

    @Override
    public List<LopOn> findAll() {
        List<LopOn> result = new ArrayList<>();
        String sql = "SELECT * FROM lop_on ORDER BY ngay_tao DESC";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách lớp ôn", e);
        }

        return result;
    }

    @Override
    public LopOn findById(int id) {
        String sql = "SELECT * FROM lop_on WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm lớp ôn có id=" + id, e);
        }
        return null;
    }

    @Override
    public LopOn findBySlug(String slug) {
        String sql = "SELECT * FROM lop_on WHERE slug = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, slug);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm lớp ôn có slug=" + slug, e);
        }
        return null;
    }

    @Override
    public boolean update(LopOn lopOn) {
        String sql = """
                UPDATE lop_on
                   SET tieu_de = ?, slug = ?, mo_ta_ngan = ?, hinh_thuc = ?, nhip_do = ?, ngay_khai_giang = ?,
                       ngay_ket_thuc = ?, so_buoi = ?, gio_moi_buoi = ?, hoc_phi = ?, si_so_toi_da = ?,
                       thoi_gian_hoc = ?, tinh_trang = ?, noi_dung_chi_tiet = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, lopOn.getTieuDe());
            statement.setString(2, lopOn.getSlug());
            statement.setString(3, lopOn.getMoTaNgan());
            statement.setString(4, lopOn.getHinhThuc());
            statement.setString(5, lopOn.getNhipDo());
            setNullableDate(statement, 6, lopOn.getNgayKhaiGiang());
            setNullableDate(statement, 7, lopOn.getNgayKetThuc());
            statement.setInt(8, lopOn.getSoBuoi());
            statement.setTime(9, lopOn.getGioMoiBuoi());
            statement.setLong(10, lopOn.getHocPhi());
            statement.setInt(11, lopOn.getSiSoToiDa());
            statement.setString(12, lopOn.getThoiGianHoc());
            statement.setString(13, lopOn.getTinhTrang());
            statement.setString(14, lopOn.getNoiDungChiTiet());
            statement.setLong(15, lopOn.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật lớp ôn", e);
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

            // Bước 1: Xóa tất cả đăng ký lớp liên quan
            String deleteRegistrationsSql = "DELETE FROM dang_ky_lop WHERE lop_on_id = ?";
            try (PreparedStatement deleteRegistrationsStmt = connection.prepareStatement(deleteRegistrationsSql)) {
                deleteRegistrationsStmt.setInt(1, id);
                int deletedCount = deleteRegistrationsStmt.executeUpdate();
                LOGGER.log(Level.INFO, "Đã xóa {0} đăng ký lớp liên quan đến lớp id={1}", 
                          new Object[]{deletedCount, id});
            }

            // Bước 2: Xóa lớp ôn
            String deleteLopOnSql = "DELETE FROM lop_on WHERE id = ?";
            try (PreparedStatement deleteLopOnStmt = connection.prepareStatement(deleteLopOnSql)) {
                deleteLopOnStmt.setInt(1, id);
                int rowsAffected = deleteLopOnStmt.executeUpdate();
                
                if (rowsAffected == 0) {
                    connection.rollback();
                    LOGGER.log(Level.WARNING, "Không tìm thấy lớp ôn id={0} để xóa", id);
                    return false;
                }
                
                // Commit transaction nếu tất cả đều thành công
                connection.commit();
                LOGGER.log(Level.INFO, "Đã xóa lớp ôn id={0} và tất cả đăng ký liên quan", id);
                return true;
            }
        } catch (SQLException e) {
            // Rollback transaction nếu có lỗi
            if (connection != null) {
                try {
                    connection.rollback();
                    LOGGER.log(Level.SEVERE, "Đã rollback transaction khi xóa lớp ôn id=" + id, e);
                } catch (SQLException rollbackEx) {
                    LOGGER.log(Level.SEVERE, "Lỗi khi rollback transaction", rollbackEx);
                }
            }
            
            // Kiểm tra xem có phải foreign key constraint violation không
            String sqlState = e.getSQLState();
            int errorCode = e.getErrorCode();
            // MySQL error code 1451 = Cannot delete or update a parent row: a foreign key constraint fails
            if (sqlState != null && (sqlState.equals("23000") || errorCode == 1451)) {
                LOGGER.log(Level.SEVERE, "Không thể xoá lớp ôn có id=" + id + " - Foreign key constraint violation", e);
                // Tạo SQLIntegrityConstraintViolationException mới
                SQLIntegrityConstraintViolationException fkEx = new SQLIntegrityConstraintViolationException(
                    e.getMessage(), e.getSQLState(), errorCode);
                fkEx.setStackTrace(e.getStackTrace());
                throw new RuntimeException(fkEx);
            }
            LOGGER.log(Level.SEVERE, "Không thể xoá lớp ôn có id=" + id, e);
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

    private LopOn mapResultSet(ResultSet rs) throws SQLException {
        LopOn lopOn = new LopOn();
        lopOn.setId(rs.getLong("id"));
        lopOn.setMaLop(rs.getString("ma_lop"));
        lopOn.setTieuDe(rs.getString("tieu_de"));
        lopOn.setSlug(rs.getString("slug"));
        lopOn.setMoTaNgan(rs.getString("mo_ta_ngan"));
        lopOn.setHinhThuc(rs.getString("hinh_thuc"));
        lopOn.setNhipDo(rs.getString("nhip_do"));
        lopOn.setNgayKhaiGiang(rs.getDate("ngay_khai_giang"));
        lopOn.setNgayKetThuc(rs.getDate("ngay_ket_thuc"));
        lopOn.setSoBuoi(rs.getInt("so_buoi"));
        lopOn.setGioMoiBuoi(rs.getTime("gio_moi_buoi"));
        lopOn.setHocPhi(rs.getLong("hoc_phi"));
        lopOn.setSiSoToiDa(rs.getInt("si_so_toi_da"));
        lopOn.setTinhTrang(rs.getString("tinh_trang"));
        Timestamp createdAt = rs.getTimestamp("ngay_tao");
        lopOn.setNgayTao(createdAt);
        lopOn.setNoiDungChiTiet(rs.getString("noi_dung_chi_tiet"));
        lopOn.setThoiGianHoc(rs.getString("thoi_gian_hoc"));
        return lopOn;
    }

    private void setNullableDate(PreparedStatement statement, int index, Date date) throws SQLException {
        if (date != null) {
            statement.setDate(index, date);
        } else {
            statement.setNull(index, java.sql.Types.DATE);
        }
    }
}


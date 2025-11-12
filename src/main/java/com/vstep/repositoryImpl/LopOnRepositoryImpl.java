package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
                    (tieu_de, mo_ta_ngan, hinh_thuc, nhip_do, ngay_khai_giang, ngay_het_han_dang_ky,
                     so_buoi, gio_moi_buoi, hoc_phi, si_so_toi_da, tinh_trang, noi_dung_chi_tiet, ngay_tao)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, lopOn.getTieuDe());
            statement.setString(2, lopOn.getMoTaNgan());
            statement.setString(3, lopOn.getHinhThuc());
            statement.setString(4, lopOn.getNhipDo());
            setNullableDate(statement, 5, lopOn.getNgayKhaiGiang());
            setNullableDate(statement, 6, lopOn.getNgayHetHanDangKy());
            statement.setInt(7, lopOn.getSoBuoi());
            statement.setDouble(8, lopOn.getGioMoiBuoi());
            statement.setLong(9, lopOn.getHocPhi());
            statement.setInt(10, lopOn.getSiSoToiDa());
            statement.setString(11, lopOn.getTinhTrang());
            statement.setString(12, lopOn.getNoiDungChiTiet());

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
    public boolean update(LopOn lopOn) {
        String sql = """
                UPDATE lop_on
                   SET tieu_de = ?, mo_ta_ngan = ?, hinh_thuc = ?, nhip_do = ?, ngay_khai_giang = ?,
                       ngay_het_han_dang_ky = ?, so_buoi = ?, gio_moi_buoi = ?, hoc_phi = ?,
                       si_so_toi_da = ?, tinh_trang = ?, noi_dung_chi_tiet = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, lopOn.getTieuDe());
            statement.setString(2, lopOn.getMoTaNgan());
            statement.setString(3, lopOn.getHinhThuc());
            statement.setString(4, lopOn.getNhipDo());
            setNullableDate(statement, 5, lopOn.getNgayKhaiGiang());
            setNullableDate(statement, 6, lopOn.getNgayHetHanDangKy());
            statement.setInt(7, lopOn.getSoBuoi());
            statement.setDouble(8, lopOn.getGioMoiBuoi());
            statement.setLong(9, lopOn.getHocPhi());
            statement.setInt(10, lopOn.getSiSoToiDa());
            statement.setString(11, lopOn.getTinhTrang());
            statement.setString(12, lopOn.getNoiDungChiTiet());
            statement.setLong(13, lopOn.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật lớp ôn", e);
            return false;
        }
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM lop_on WHERE id = ?";

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá lớp ôn có id=" + id, e);
            return false;
        }
    }

    private LopOn mapResultSet(ResultSet rs) throws SQLException {
        LopOn lopOn = new LopOn();
        lopOn.setId(rs.getLong("id"));
        lopOn.setTieuDe(rs.getString("tieu_de"));
        lopOn.setMoTaNgan(rs.getString("mo_ta_ngan"));
        lopOn.setHinhThuc(rs.getString("hinh_thuc"));
        lopOn.setNhipDo(rs.getString("nhip_do"));
        lopOn.setNgayKhaiGiang(rs.getDate("ngay_khai_giang"));
        lopOn.setNgayHetHanDangKy(rs.getDate("ngay_het_han_dang_ky"));
        lopOn.setSoBuoi(rs.getInt("so_buoi"));
        lopOn.setGioMoiBuoi(rs.getDouble("gio_moi_buoi"));
        lopOn.setHocPhi(rs.getLong("hoc_phi"));
        lopOn.setSiSoToiDa(rs.getInt("si_so_toi_da"));
        lopOn.setTinhTrang(rs.getString("tinh_trang"));
        Timestamp createdAt = rs.getTimestamp("ngay_tao");
        lopOn.setNgayTao(createdAt);
        lopOn.setNoiDungChiTiet(rs.getString("noi_dung_chi_tiet"));
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


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

import com.vstep.model.MaGiamGia;
import com.vstep.repository.MaGiamGiaRepository;
import com.vstep.util.DataSourceUtil;

public class MaGiamGiaRepositoryImpl implements MaGiamGiaRepository {

    private static final Logger LOGGER = Logger.getLogger(MaGiamGiaRepositoryImpl.class.getName());

    @Override
    public MaGiamGia findByMaCode(String maCode) {
        String sql = "SELECT * FROM ma_giam_gia WHERE ma_code = ?";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, maCode);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm mã giảm giá: " + maCode, e);
        }
        return null;
    }

    @Override
    public MaGiamGia findById(long id) {
        String sql = "SELECT * FROM ma_giam_gia WHERE id = ?";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setLong(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm mã giảm giá có id=" + id, e);
        }
        return null;
    }

    @Override
    public List<MaGiamGia> findAll() {
        List<MaGiamGia> result = new ArrayList<>();
        String sql = "SELECT * FROM ma_giam_gia ORDER BY ngay_tao DESC";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách mã giảm giá", e);
        }
        return result;
    }

    @Override
    public List<MaGiamGia> findByLoai(String loai) {
        List<MaGiamGia> result = new ArrayList<>();
        String sql = "SELECT * FROM ma_giam_gia WHERE loai = ? OR loai = 'all' ORDER BY ngay_tao DESC";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, loai);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                result.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể lấy danh sách mã giảm giá theo loại: " + loai, e);
        }
        return result;
    }

    @Override
    public boolean create(MaGiamGia maGiamGia) {
        String sql = """
                INSERT INTO ma_giam_gia 
                    (ma_code, loai, loai_giam, gia_tri_giam, gia_tri_toi_da, so_luong_toi_da, 
                     so_luong_da_su_dung, ngay_bat_dau, ngay_ket_thuc, trang_thai, mo_ta)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, maGiamGia.getMaCode());
            statement.setString(2, maGiamGia.getLoai());
            statement.setString(3, maGiamGia.getLoaiGiam());
            statement.setLong(4, maGiamGia.getGiaTriGiam());
            if (maGiamGia.getGiaTriToiDa() != null) {
                statement.setLong(5, maGiamGia.getGiaTriToiDa());
            } else {
                statement.setNull(5, java.sql.Types.BIGINT);
            }
            if (maGiamGia.getSoLuongToiDa() != null) {
                statement.setInt(6, maGiamGia.getSoLuongToiDa());
            } else {
                statement.setNull(6, java.sql.Types.INTEGER);
            }
            statement.setInt(7, maGiamGia.getSoLuongDaSuDung());
            setNullableDate(statement, 8, maGiamGia.getNgayBatDau());
            setNullableDate(statement, 9, maGiamGia.getNgayKetThuc());
            statement.setString(10, maGiamGia.getTrangThai());
            statement.setString(11, maGiamGia.getMoTa());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo mã giảm giá", e);
            return false;
        }
    }

    @Override
    public boolean update(MaGiamGia maGiamGia) {
        String sql = """
                UPDATE ma_giam_gia
                   SET ma_code = ?, loai = ?, loai_giam = ?, gia_tri_giam = ?, gia_tri_toi_da = ?,
                       so_luong_toi_da = ?, so_luong_da_su_dung = ?, ngay_bat_dau = ?, ngay_ket_thuc = ?,
                       trang_thai = ?, mo_ta = ?
                 WHERE id = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, maGiamGia.getMaCode());
            statement.setString(2, maGiamGia.getLoai());
            statement.setString(3, maGiamGia.getLoaiGiam());
            statement.setLong(4, maGiamGia.getGiaTriGiam());
            if (maGiamGia.getGiaTriToiDa() != null) {
                statement.setLong(5, maGiamGia.getGiaTriToiDa());
            } else {
                statement.setNull(5, java.sql.Types.BIGINT);
            }
            if (maGiamGia.getSoLuongToiDa() != null) {
                statement.setInt(6, maGiamGia.getSoLuongToiDa());
            } else {
                statement.setNull(6, java.sql.Types.INTEGER);
            }
            statement.setInt(7, maGiamGia.getSoLuongDaSuDung());
            setNullableDate(statement, 8, maGiamGia.getNgayBatDau());
            setNullableDate(statement, 9, maGiamGia.getNgayKetThuc());
            statement.setString(10, maGiamGia.getTrangThai());
            statement.setString(11, maGiamGia.getMoTa());
            statement.setLong(12, maGiamGia.getId());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật mã giảm giá", e);
            return false;
        }
    }

    @Override
    public boolean deleteById(long id) {
        String sql = "DELETE FROM ma_giam_gia WHERE id = ?";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setLong(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể xoá mã giảm giá có id=" + id, e);
            return false;
        }
    }

    @Override
    public boolean incrementSoLuongDaSuDung(long id) {
        String sql = "UPDATE ma_giam_gia SET so_luong_da_su_dung = so_luong_da_su_dung + 1 WHERE id = ?";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setLong(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tăng số lượng đã sử dụng cho mã giảm giá id=" + id, e);
            return false;
        }
    }

    private MaGiamGia mapResultSet(ResultSet rs) throws SQLException {
        MaGiamGia ma = new MaGiamGia();
        ma.setId(rs.getLong("id"));
        ma.setMaCode(rs.getString("ma_code"));
        ma.setLoai(rs.getString("loai"));
        ma.setLoaiGiam(rs.getString("loai_giam"));
        ma.setGiaTriGiam(rs.getLong("gia_tri_giam"));
        long giaTriToiDa = rs.getLong("gia_tri_toi_da");
        ma.setGiaTriToiDa(rs.wasNull() ? null : giaTriToiDa);
        int soLuongToiDa = rs.getInt("so_luong_toi_da");
        ma.setSoLuongToiDa(rs.wasNull() ? null : soLuongToiDa);
        ma.setSoLuongDaSuDung(rs.getInt("so_luong_da_su_dung"));
        ma.setNgayBatDau(rs.getDate("ngay_bat_dau"));
        ma.setNgayKetThuc(rs.getDate("ngay_ket_thuc"));
        ma.setTrangThai(rs.getString("trang_thai"));
        ma.setMoTa(rs.getString("mo_ta"));
        Timestamp ngayTao = rs.getTimestamp("ngay_tao");
        ma.setNgayTao(ngayTao);
        Timestamp ngayCapNhat = rs.getTimestamp("ngay_cap_nhat");
        ma.setNgayCapNhat(ngayCapNhat);
        return ma;
    }

    private void setNullableDate(PreparedStatement statement, int index, Date date) throws SQLException {
        if (date != null) {
            statement.setDate(index, date);
        } else {
            statement.setNull(index, java.sql.Types.DATE);
        }
    }
}


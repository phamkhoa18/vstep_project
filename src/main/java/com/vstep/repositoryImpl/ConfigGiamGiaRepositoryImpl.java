package com.vstep.repositoryImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.vstep.model.ConfigGiamGia;
import com.vstep.repository.ConfigGiamGiaRepository;
import com.vstep.util.DataSourceUtil;

public class ConfigGiamGiaRepositoryImpl implements ConfigGiamGiaRepository {

    private static final Logger LOGGER = Logger.getLogger(ConfigGiamGiaRepositoryImpl.class.getName());

    @Override
    public ConfigGiamGia findByLoai(String loai) {
        String sql = "SELECT * FROM config_giam_gia WHERE loai = ?";
        
        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, loai);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tìm cấu hình giảm giá cho loại: " + loai, e);
        }
        return null;
    }

    @Override
    public boolean update(ConfigGiamGia config) {
        String sql = """
                UPDATE config_giam_gia
                   SET muc_giam_thi_lai = ?, mo_ta = ?, trang_thai = ?
                 WHERE loai = ?
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, config.getMucGiamThiLai());
            statement.setString(2, config.getMoTa());
            statement.setString(3, config.getTrangThai());
            statement.setString(4, config.getLoai());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể cập nhật cấu hình giảm giá", e);
            return false;
        }
    }

    @Override
    public boolean create(ConfigGiamGia config) {
        String sql = """
                INSERT INTO config_giam_gia (loai, muc_giam_thi_lai, mo_ta, trang_thai)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection connection = DataSourceUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, config.getLoai());
            statement.setLong(2, config.getMucGiamThiLai());
            statement.setString(3, config.getMoTa());
            statement.setString(4, config.getTrangThai());

            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Không thể tạo cấu hình giảm giá", e);
            return false;
        }
    }

    private ConfigGiamGia mapResultSet(ResultSet rs) throws SQLException {
        ConfigGiamGia config = new ConfigGiamGia();
        config.setId(rs.getLong("id"));
        config.setLoai(rs.getString("loai"));
        config.setMucGiamThiLai(rs.getLong("muc_giam_thi_lai"));
        config.setMoTa(rs.getString("mo_ta"));
        config.setTrangThai(rs.getString("trang_thai"));
        Timestamp ngayTao = rs.getTimestamp("ngay_tao");
        config.setNgayTao(ngayTao);
        Timestamp ngayCapNhat = rs.getTimestamp("ngay_cap_nhat");
        config.setNgayCapNhat(ngayCapNhat);
        return config;
    }
}


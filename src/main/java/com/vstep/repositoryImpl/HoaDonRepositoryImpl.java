package com.vstep.repositoryImpl;

import com.vstep.model.HoaDon;
import com.vstep.repository.HoaDonRepository;
import com.vstep.util.DataSourceUtil;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HoaDonRepositoryImpl implements HoaDonRepository {
    private DataSource dataSource = DataSourceUtil.getDataSource();

    @Override
    public boolean create(HoaDon hoaDon) {
        String sql = "INSERT INTO hoa_don (so_hoa_don, nguoi_dung_id, loai, dang_ky_id, file_path, file_name, ngay_tao, trang_thai) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, hoaDon.getSoHoaDon());
            ps.setLong(2, hoaDon.getNguoiDungId());
            ps.setString(3, hoaDon.getLoai());
            ps.setLong(4, hoaDon.getDangKyId());
            ps.setString(5, hoaDon.getFilePath());
            ps.setString(6, hoaDon.getFileName());
            ps.setTimestamp(7, hoaDon.getNgayTao() != null ? hoaDon.getNgayTao() : new Timestamp(System.currentTimeMillis()));
            ps.setString(8, hoaDon.getTrangThai() != null ? hoaDon.getTrangThai() : "Đã tạo");
            
            int result = ps.executeUpdate();
            if (result > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        hoaDon.setId(rs.getLong(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public HoaDon findById(long id) {
        String sql = "SELECT * FROM hoa_don WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHoaDon(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<HoaDon> findByNguoiDungId(long nguoiDungId) {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT * FROM hoa_don WHERE nguoi_dung_id = ? ORDER BY ngay_tao DESC";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, nguoiDungId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToHoaDon(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<HoaDon> findByNguoiDungIdAndLoai(long nguoiDungId, String loai) {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT * FROM hoa_don WHERE nguoi_dung_id = ? AND loai = ? ORDER BY ngay_tao DESC";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, nguoiDungId);
            ps.setString(2, loai);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToHoaDon(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public HoaDon findBySoHoaDon(String soHoaDon) {
        String sql = "SELECT * FROM hoa_don WHERE so_hoa_don = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, soHoaDon);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHoaDon(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public HoaDon findByDangKyIdAndLoai(long dangKyId, String loai) {
        String sql = "SELECT * FROM hoa_don WHERE dang_ky_id = ? AND loai = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, dangKyId);
            ps.setString(2, loai);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToHoaDon(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(HoaDon hoaDon) {
        String sql = "UPDATE hoa_don SET so_hoa_don = ?, nguoi_dung_id = ?, loai = ?, dang_ky_id = ?, " +
                     "file_path = ?, file_name = ?, trang_thai = ? WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, hoaDon.getSoHoaDon());
            ps.setLong(2, hoaDon.getNguoiDungId());
            ps.setString(3, hoaDon.getLoai());
            ps.setLong(4, hoaDon.getDangKyId());
            ps.setString(5, hoaDon.getFilePath());
            ps.setString(6, hoaDon.getFileName());
            ps.setString(7, hoaDon.getTrangThai());
            ps.setLong(8, hoaDon.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(long id) {
        String sql = "DELETE FROM hoa_don WHERE id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private HoaDon mapResultSetToHoaDon(ResultSet rs) throws SQLException {
        HoaDon hoaDon = new HoaDon();
        hoaDon.setId(rs.getLong("id"));
        hoaDon.setSoHoaDon(rs.getString("so_hoa_don"));
        hoaDon.setNguoiDungId(rs.getLong("nguoi_dung_id"));
        hoaDon.setLoai(rs.getString("loai"));
        hoaDon.setDangKyId(rs.getLong("dang_ky_id"));
        hoaDon.setFilePath(rs.getString("file_path"));
        hoaDon.setFileName(rs.getString("file_name"));
        hoaDon.setNgayTao(rs.getTimestamp("ngay_tao"));
        hoaDon.setTrangThai(rs.getString("trang_thai"));
        return hoaDon;
    }
}


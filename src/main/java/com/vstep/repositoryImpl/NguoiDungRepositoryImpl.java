package com.vstep.repositoryImpl;

import com.vstep.model.NguoiDung;
import com.vstep.repository.NguoiDungRepository;
import com.vstep.util.DataSourceUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NguoiDungRepositoryImpl implements NguoiDungRepository {

    @Override
    public boolean create(NguoiDung nguoiDung) {
        String sql = "INSERT INTO nguoi_dung (ho_ten, email, so_dien_thoai, don_vi, mat_khau, vai_tro, kich_hoat, ngay_tao) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (Connection conn = DataSourceUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nguoiDung.getHoTen());
            ps.setString(2, nguoiDung.getEmail());
            ps.setString(3, nguoiDung.getSoDienThoai());
            ps.setString(4, nguoiDung.getDonVi());
            ps.setString(5, nguoiDung.getMatKhau());
            ps.setString(6, nguoiDung.getVaiTro());
            ps.setBoolean(7, nguoiDung.isKichHoat());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteById(int id) {
        String sql = "DELETE FROM nguoi_dung WHERE id = ?";
        try (Connection conn = DataSourceUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(NguoiDung nguoiDung) {
        String sql = "UPDATE nguoi_dung SET ho_ten=?, email=?, so_dien_thoai=?, don_vi=?, mat_khau=?, vai_tro=?, kich_hoat=? WHERE id=?";
        try (Connection conn = DataSourceUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nguoiDung.getHoTen());
            ps.setString(2, nguoiDung.getEmail());
            ps.setString(3, nguoiDung.getSoDienThoai());
            ps.setString(4, nguoiDung.getDonVi());
            ps.setString(5, nguoiDung.getMatKhau());
            ps.setString(6, nguoiDung.getVaiTro());
            ps.setBoolean(7, nguoiDung.isKichHoat());
            ps.setLong(8, nguoiDung.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public NguoiDung findById(int id) {
        String sql = "SELECT * FROM nguoi_dung WHERE id = ?";
        try (Connection conn = DataSourceUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToNguoiDung(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<NguoiDung> findAll() {
        List<NguoiDung> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung ORDER BY ngay_tao DESC";
        try (Connection conn = DataSourceUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToNguoiDung(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper function chuyển ResultSet → NguoiDung
    private NguoiDung mapResultSetToNguoiDung(ResultSet rs) throws SQLException {
        NguoiDung nd = new NguoiDung();
        nd.setId(rs.getLong("id"));
        nd.setHoTen(rs.getString("ho_ten"));
        nd.setEmail(rs.getString("email"));
        nd.setSoDienThoai(rs.getString("so_dien_thoai"));
        nd.setDonVi(rs.getString("don_vi"));
        nd.setMatKhau(rs.getString("mat_khau"));
        nd.setVaiTro(rs.getString("vai_tro"));
        nd.setKichHoat(rs.getBoolean("kich_hoat"));
        nd.setNgayTao(rs.getTimestamp("ngay_tao"));
        return nd;
    }
}

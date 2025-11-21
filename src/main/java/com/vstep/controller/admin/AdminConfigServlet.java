package com.vstep.controller.admin;

import java.io.IOException;

import com.vstep.model.ConfigGiamGia;
import com.vstep.model.MaGiamGia;
import com.vstep.service.ConfigGiamGiaService;
import com.vstep.service.MaGiamGiaService;
import com.vstep.serviceImpl.ConfigGiamGiaServiceImpl;
import com.vstep.serviceImpl.MaGiamGiaServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminConfigServlet", urlPatterns = {"/admin/config", "/admin/config/*"})
public class AdminConfigServlet extends HttpServlet {

    private ConfigGiamGiaService configGiamGiaService;
    private MaGiamGiaService maGiamGiaService;

    @Override
    public void init() throws ServletException {
        super.init();
        configGiamGiaService = new ConfigGiamGiaServiceImpl();
        maGiamGiaService = new MaGiamGiaServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Load dữ liệu cấu hình
        ConfigGiamGia configCaThi = configGiamGiaService.getConfigByLoai("ca_thi");
        ConfigGiamGia configLopOn = configGiamGiaService.getConfigByLoai("lop_on");
        
        req.setAttribute("configCaThi", configCaThi);
        req.setAttribute("configLopOn", configLopOn);
        
        // Load danh sách mã giảm giá
        java.util.List<MaGiamGia> allMaGiamGia = maGiamGiaService.findAll();
        req.setAttribute("allMaGiamGia", allMaGiamGia);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/admin-config.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số action.");
            return;
        }

        boolean success = false;
        String message = "";
        String type = "error";

        switch (action) {
            case "update-config-ca-thi" -> {
                ConfigGiamGia config = new ConfigGiamGia();
                config.setLoai("ca_thi");
                config.setMucGiamThiLai(parseLong(req.getParameter("mucGiamThiLai")));
                config.setMoTa(trimOrNull(req.getParameter("moTa")));
                config.setTrangThai(trimOrNull(req.getParameter("trangThai")));
                if (config.getTrangThai() == null) {
                    config.setTrangThai("active");
                }
                success = configGiamGiaService.updateConfig(config);
                type = success ? "success" : "error";
                message = success ? "Cập nhật cấu hình giảm giá ca thi thành công." : "Không thể cập nhật cấu hình.";
            }
            case "update-config-lop-on" -> {
                ConfigGiamGia config = new ConfigGiamGia();
                config.setLoai("lop_on");
                config.setMucGiamThiLai(parseLong(req.getParameter("mucGiamThiLai")));
                config.setMoTa(trimOrNull(req.getParameter("moTa")));
                config.setTrangThai(trimOrNull(req.getParameter("trangThai")));
                if (config.getTrangThai() == null) {
                    config.setTrangThai("active");
                }
                success = configGiamGiaService.updateConfig(config);
                type = success ? "success" : "error";
                message = success ? "Cập nhật cấu hình giảm giá lớp ôn thành công." : "Không thể cập nhật cấu hình.";
            }
            case "create-ma-giam-gia" -> {
                MaGiamGia ma = buildMaGiamGiaFromRequest(req, false);
                success = maGiamGiaService.create(ma);
                type = success ? "success" : "error";
                message = success ? "Tạo mã giảm giá thành công." : "Không thể tạo mã giảm giá.";
            }
            case "update-ma-giam-gia" -> {
                MaGiamGia ma = buildMaGiamGiaFromRequest(req, true);
                if (ma.getId() <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID mã giảm giá không hợp lệ.");
                    return;
                }
                success = maGiamGiaService.update(ma);
                type = success ? "success" : "error";
                message = success ? "Cập nhật mã giảm giá thành công." : "Không thể cập nhật mã giảm giá.";
            }
            case "delete-ma-giam-gia" -> {
                long id = parseLong(req.getParameter("id"));
                if (id <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID mã giảm giá không hợp lệ.");
                    return;
                }
                success = maGiamGiaService.deleteById(id);
                type = success ? "success" : "error";
                message = success ? "Xoá mã giảm giá thành công." : "Không thể xoá mã giảm giá.";
            }
            default -> {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không được hỗ trợ.");
                return;
            }
        }

        session.setAttribute("configFlashType", type);
        session.setAttribute("configFlashMessage", message);
        resp.sendRedirect(req.getContextPath() + "/admin/config");
    }

    private MaGiamGia buildMaGiamGiaFromRequest(HttpServletRequest req, boolean includeId) {
        MaGiamGia ma = new MaGiamGia();
        if (includeId) {
            ma.setId(parseLong(req.getParameter("id")));
        }
        ma.setMaCode(trimOrNull(req.getParameter("maCode")));
        ma.setLoai(trimOrNull(req.getParameter("loai")));
        ma.setLoaiGiam(trimOrNull(req.getParameter("loaiGiam")));
        ma.setGiaTriGiam(parseLong(req.getParameter("giaTriGiam")));
        String giaTriToiDaStr = trimOrNull(req.getParameter("giaTriToiDa"));
        if (giaTriToiDaStr != null && !giaTriToiDaStr.isEmpty()) {
            ma.setGiaTriToiDa(parseLong(giaTriToiDaStr));
        }
        String soLuongToiDaStr = trimOrNull(req.getParameter("soLuongToiDa"));
        if (soLuongToiDaStr != null && !soLuongToiDaStr.isEmpty()) {
            ma.setSoLuongToiDa(parseInt(soLuongToiDaStr));
        }
        ma.setNgayBatDau(parseSqlDate(req.getParameter("ngayBatDau")));
        ma.setNgayKetThuc(parseSqlDate(req.getParameter("ngayKetThuc")));
        ma.setTrangThai(trimOrNull(req.getParameter("trangThai")));
        if (ma.getTrangThai() == null) {
            ma.setTrangThai("active");
        }
        ma.setMoTa(trimOrNull(req.getParameter("moTa")));
        return ma;
    }

    private String trimOrNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private long parseLong(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            return Long.parseLong(value.replaceAll("[^0-9]", ""));
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private java.sql.Date parseSqlDate(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return java.sql.Date.valueOf(value);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }
}


package com.vstep.controller.admin;

import java.io.IOException;
import java.sql.Date;

import com.vstep.model.LopOn;
import com.vstep.service.LopOnService;
import com.vstep.serviceImpl.LopOnServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminLopOnServlet", urlPatterns = {"/admin/lop-on", "/admin/lop-on/*"})
public class AdminLopOnServlet extends HttpServlet {

    private LopOnService lopOnService;

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số action.");
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        boolean success;
        String message;
        String type;

        switch (action) {
            case "create" -> {
                LopOn lopOn = buildEntityFromRequest(req, false);
                success = lopOnService.create(lopOn);
                type = success ? "success" : "error";
                message = success ? "Tạo lớp ôn mới thành công." : "Không thể tạo lớp ôn. Vui lòng thử lại.";
            }
            case "update" -> {
                LopOn lopOn = buildEntityFromRequest(req, true);
                if (lopOn.getId() <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID lớp ôn không hợp lệ.");
                    return;
                }
                success = lopOnService.update(lopOn);
                type = success ? "success" : "error";
                message = success ? "Cập nhật thông tin lớp ôn thành công." : "Không thể cập nhật lớp ôn. Vui lòng thử lại.";
            }
            case "delete" -> {
                long id = parseLong(req.getParameter("id"));
                if (id <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID lớp ôn không hợp lệ.");
                    return;
                }
                success = lopOnService.deleteById(id);
                type = success ? "success" : "error";
                message = success ? "Xoá lớp ôn thành công." : "Không thể xoá lớp ôn. Vui lòng thử lại.";
            }
            default -> {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không được hỗ trợ.");
                return;
            }
        }

        session.setAttribute("classFlashType", type);
        session.setAttribute("classFlashMessage", message);

        resp.sendRedirect(req.getContextPath() + "/admin/classes");
    }

    private LopOn buildEntityFromRequest(HttpServletRequest req, boolean includeId) {
        LopOn lopOn = new LopOn();
        if (includeId) {
            lopOn.setId(parseLong(req.getParameter("id")));
        }
        lopOn.setTieuDe(trimOrNull(req.getParameter("tieuDe")));
        lopOn.setMoTaNgan(trimOrNull(req.getParameter("moTaNgan")));
        lopOn.setHinhThuc(trimOrNull(req.getParameter("hinhThuc")));
        lopOn.setNhipDo(trimOrNull(req.getParameter("nhipDo")));
        lopOn.setNgayKhaiGiang(parseSqlDate(req.getParameter("ngayKhaiGiang")));
        lopOn.setNgayHetHanDangKy(parseSqlDate(req.getParameter("ngayHetHanDangKy")));
        lopOn.setSoBuoi(parseInt(req.getParameter("soBuoi")));
        lopOn.setGioMoiBuoi(parseDouble(req.getParameter("gioMoiBuoi")));
        lopOn.setHocPhi(parseLong(req.getParameter("hocPhi")));
        lopOn.setSiSoToiDa(parseInt(req.getParameter("siSoToiDa")));
        lopOn.setTinhTrang(trimOrNull(req.getParameter("tinhTrang")));
        lopOn.setNoiDungChiTiet(req.getParameter("noiDungChiTiet"));
        return lopOn;
    }

    private String trimOrNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    private Date parseSqlDate(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return Date.valueOf(value);
        } catch (IllegalArgumentException ex) {
            return null;
        }
    }

    private long parseLong(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) {
            return 0;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException ex) {
            return 0;
        }
    }

    private double parseDouble(String value) {
        if (value == null || value.isBlank()) {
            return 0d;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException ex) {
            return 0d;
        }
    }
}


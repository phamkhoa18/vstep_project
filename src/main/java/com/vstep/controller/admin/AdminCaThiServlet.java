package com.vstep.controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Time;
import java.util.Random;

import com.vstep.model.CaThi;
import com.vstep.service.CaThiService;
import com.vstep.serviceImpl.CaThiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminCaThiServlet", urlPatterns = {"/admin/ca-thi", "/admin/ca-thi/*"})
public class AdminCaThiServlet extends HttpServlet {

    private CaThiService caThiService;

    @Override
    public void init() throws ServletException {
        super.init();
        caThiService = new CaThiServiceImpl();
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
                CaThi caThi = buildEntityFromRequest(req, false);
                success = caThiService.create(caThi);
                type = success ? "success" : "error";
                message = success ? "Tạo ca thi mới thành công." : "Không thể tạo ca thi. Vui lòng thử lại.";
            }
            case "update" -> {
                CaThi caThi = buildEntityFromRequest(req, true);
                if (caThi.getId() <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID ca thi không hợp lệ.");
                    return;
                }
                success = caThiService.update(caThi);
                type = success ? "success" : "error";
                message = success ? "Cập nhật thông tin ca thi thành công." : "Không thể cập nhật ca thi. Vui lòng thử lại.";
            }
            case "delete" -> {
                long id = parseLong(req.getParameter("id"));
                if (id <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID ca thi không hợp lệ.");
                    return;
                }
                try {
                    success = caThiService.deleteById(id);
                    type = success ? "success" : "error";
                    message = success ? "Xoá ca thi thành công. Tất cả đăng ký liên quan đã được xóa tự động." : "Không thể xoá ca thi. Vui lòng thử lại.";
                } catch (SQLIntegrityConstraintViolationException e) {
                    success = false;
                    type = "error";
                    message = "Không thể xoá ca thi này. Có lỗi xảy ra khi xóa các đăng ký liên quan.";
                } catch (SQLException e) {
                    success = false;
                    type = "error";
                    message = "Không thể xoá ca thi. Có lỗi xảy ra: " + e.getMessage();
                }
            }
            default -> {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Hành động không được hỗ trợ.");
                return;
            }
        }

        session.setAttribute("examFlashType", type);
        session.setAttribute("examFlashMessage", message);

        if ("create".equals(action)) {
            resp.sendRedirect(req.getContextPath() + "/admin/exams");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/exams");
        }
    }

    private static final Random RANDOM = new Random();

    private CaThi buildEntityFromRequest(HttpServletRequest req, boolean includeId) {
        CaThi caThi = new CaThi();
        if (includeId) {
            caThi.setId(parseLong(req.getParameter("id")));
            caThi.setMaCaThi(trimOrNull(req.getParameter("maCaThi")));
        } else {
            // Tự động tạo mã ca thi nếu không có
            String maCaThi = trimOrNull(req.getParameter("maCaThi"));
            if (maCaThi == null || maCaThi.isEmpty()) {
                caThi.setMaCaThi(generateMaCaThi());
            } else {
                caThi.setMaCaThi(maCaThi);
            }
        }
        caThi.setNgayThi(parseSqlDate(req.getParameter("ngayThi")));
        caThi.setGioBatDau(parseSqlTime(req.getParameter("gioBatDau")));
        caThi.setGioKetThuc(parseSqlTime(req.getParameter("gioKetThuc")));
        caThi.setDiaDiem(trimOrNull(req.getParameter("diaDiem")));
        caThi.setSucChua(parseInt(req.getParameter("sucChua")));
        caThi.setGiaGoc(parseLong(req.getParameter("giaGoc")));
        return caThi;
    }

    /**
     * Sinh mã ca thi duy nhất theo dạng "CA_123456789"
     */
    public static String generateMaCaThi() {
        long timestamp = System.currentTimeMillis();
        int randomSuffix = 100 + RANDOM.nextInt(900);
        return "CA_" + timestamp + randomSuffix;
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

    private Time parseSqlTime(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            // value phải dạng "HH:mm" hoặc "HH:mm:ss"
            if (!value.contains(":")) return null;
            String[] parts = value.split(":");
            int h = Integer.parseInt(parts[0]);
            int m = Integer.parseInt(parts[1]);
            int s = parts.length > 2 ? Integer.parseInt(parts[2]) : 0;
            String timeString = String.format("%02d:%02d:%02d", h, m, s);
            return Time.valueOf(timeString);
        } catch (NumberFormatException ex) {
            return null;
        }
    }
}


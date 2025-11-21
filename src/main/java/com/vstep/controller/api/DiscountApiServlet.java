package com.vstep.controller.api;

import java.io.IOException;

import com.vstep.service.ConfigGiamGiaService;
import com.vstep.service.MaGiamGiaService;
import com.vstep.serviceImpl.ConfigGiamGiaServiceImpl;
import com.vstep.serviceImpl.MaGiamGiaServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiscountApiServlet", urlPatterns = {"/api/config-giam-gia", "/api/validate-code"})
public class DiscountApiServlet extends HttpServlet {

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
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();
        String servletPath = req.getServletPath();

        try {
            if ("/api/config-giam-gia".equals(servletPath)) {
                // Lấy cấu hình giảm giá
                String loai = req.getParameter("loai");
                if (loai == null || loai.isEmpty()) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    resp.getWriter().write("{\"error\":\"Thiếu tham số loai\"}");
                    return;
                }

                com.vstep.model.ConfigGiamGia config = configGiamGiaService.getConfigByLoai(loai);
                if (config != null) {
                    resp.getWriter().write(String.format(
                        "{\"mucGiamThiLai\":%d,\"trangThai\":\"%s\",\"moTa\":\"%s\"}",
                        config.getMucGiamThiLai(),
                        config.getTrangThai() != null ? config.getTrangThai() : "active",
                        config.getMoTa() != null ? escapeJson(config.getMoTa()) : ""
                    ));
                } else {
                    resp.getWriter().write("{\"mucGiamThiLai\":500000,\"trangThai\":\"active\"}");
                }
            } else if ("/api/validate-code".equals(servletPath)) {
                // Validate mã code
                String code = req.getParameter("code");
                String loai = req.getParameter("loai");
                String giaGocStr = req.getParameter("giaGoc");

                if (code == null || code.isEmpty()) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    resp.getWriter().write("{\"valid\":false,\"message\":\"Thiếu mã code\"}");
                    return;
                }

                if (loai == null || loai.isEmpty()) {
                    resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    resp.getWriter().write("{\"valid\":false,\"message\":\"Thiếu tham số loai\"}");
                    return;
                }

                long giaGoc = 0;
                if (giaGocStr != null && !giaGocStr.isEmpty()) {
                    try {
                        giaGoc = Long.parseLong(giaGocStr.replaceAll("[^0-9]", ""));
                    } catch (NumberFormatException e) {
                        // Ignore
                    }
                }

                boolean valid = maGiamGiaService.validateAndApply(code, loai, giaGoc);
                if (valid) {
                    long discount = maGiamGiaService.calculateDiscount(code, loai, giaGoc);
                    resp.getWriter().write(String.format(
                        "{\"valid\":true,\"discount\":%d,\"message\":\"Mã code hợp lệ\"}",
                        discount
                    ));
                } else {
                    resp.getWriter().write("{\"valid\":false,\"discount\":0,\"message\":\"Mã code không hợp lệ hoặc đã hết hạn\"}");
                }
            }
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\":\"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}


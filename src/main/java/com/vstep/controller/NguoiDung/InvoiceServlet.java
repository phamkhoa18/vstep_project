package com.vstep.controller.NguoiDung;

import com.vstep.model.HoaDon;
import com.vstep.model.NguoiDung;
import com.vstep.service.HoaDonService;
import com.vstep.serviceImpl.HoaDonServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/invoice/*")
public class InvoiceServlet extends HttpServlet {
    private HoaDonService hoaDonService = new HoaDonServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("userLogin");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu ID hóa đơn");
            return;
        }

        // Lấy ID từ path: /invoice/123 -> 123
        String idStr = pathInfo.substring(1);
        try {
            long invoiceId = Long.parseLong(idStr);
            HoaDon hoaDon = hoaDonService.findById(invoiceId);

            if (hoaDon == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy hóa đơn");
                return;
            }

            // Kiểm tra quyền: chỉ chủ hóa đơn mới được xem
            if (hoaDon.getNguoiDungId() != user.getId()) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem hóa đơn này");
                return;
            }

            // Đọc file PDF
            String filePath = hoaDon.getFilePath();
            if (filePath == null || filePath.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File hóa đơn không tồn tại");
                return;
            }

            File file = new File(filePath);
            if (!file.exists() || !file.isFile()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "File hóa đơn không tồn tại");
                return;
            }

            // Set response headers
            resp.setContentType("application/pdf");
            resp.setHeader("Content-Disposition", "inline; filename=\"" + hoaDon.getFileName() + "\"");
            resp.setContentLengthLong(file.length());

            // Stream file to response
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream os = resp.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID hóa đơn không hợp lệ");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi đọc file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


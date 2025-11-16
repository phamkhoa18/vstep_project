package com.vstep.controller.NguoiDung;

import com.vstep.model.NguoiDung;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.NguoiDungServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/kich-hoat")
public class KichHoatTaiKhoanServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            // Không có token, chuyển đến trang đăng nhập với lỗi
            response.sendRedirect(request.getContextPath() + "/dang-nhap?error=invalid_token");
            return;
        }

        // Tìm người dùng theo activation token
        NguoiDung nd = nguoiDungService.findByActivationToken(token);

        if (nd == null) {
            // Token không hợp lệ hoặc không tìm thấy
            response.sendRedirect(request.getContextPath() + "/dang-nhap?error=invalid_token");
            return;
        }

        // Kiểm tra xem tài khoản đã được kích hoạt chưa
        if (nd.isKichHoat()) {
            // Tài khoản đã được kích hoạt rồi
            response.sendRedirect(request.getContextPath() + "/dang-nhap?success=already_activated");
            return;
        }

        // Kích hoạt tài khoản
        nd.setKichHoat(true);
        nd.setActivationToken(null); // Xóa token sau khi kích hoạt

        // Cập nhật vào database
        boolean updated = nguoiDungService.update(nd);

        if (updated) {
            // Kích hoạt thành công, chuyển đến trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/dang-nhap?success=activated");
        } else {
            // Lỗi khi cập nhật
            response.sendRedirect(request.getContextPath() + "/dang-nhap?error=activation_failed");
        }
    }
}




package com.vstep.controller.NguoiDung;

import com.vstep.model.NguoiDung;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dat-lai-mat-khau")
public class ResetPasswordServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        
        if (token == null || token.trim().isEmpty()) {
            req.getRequestDispatcher("/WEB-INF/views/public/reset-password.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra token có hợp lệ không
        NguoiDung user = nguoiDungService.findByActivationToken(token);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?error=invalid_token");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/public/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String token = req.getParameter("token");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (token == null || token.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?error=invalid_token");
            return;
        }

        // Tìm user theo token
        NguoiDung user = nguoiDungService.findByActivationToken(token);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?token=" + token + "&error=invalid_token");
            return;
        }

        // Validate mật khẩu
        if (newPassword == null || newPassword.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?token=" + token + "&error=password_short");
            return;
        }

        if (newPassword.length() < 6) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?token=" + token + "&error=password_short");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?token=" + token + "&error=password_mismatch");
            return;
        }

        // Hash mật khẩu mới
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setMatKhau(hashedPassword);
        
        // Xóa reset token sau khi đã sử dụng
        user.setActivationToken(null);

        // Cập nhật mật khẩu
        boolean updated = nguoiDungService.update(user);

        if (updated) {
            // Chuyển đến trang đăng nhập với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/dang-nhap?success=reset_password");
        } else {
            resp.sendRedirect(req.getContextPath() + "/dat-lai-mat-khau?token=" + token + "&error=server");
        }
    }
}


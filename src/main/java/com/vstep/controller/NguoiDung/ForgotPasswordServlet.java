package com.vstep.controller.NguoiDung;

import com.vstep.model.NguoiDung;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import com.vstep.util.EmailService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/quen-mat-khau")
public class ForgotPasswordServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/public/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        HttpSession session = req.getSession();

        String message = "";
        String type = "error";

        if (email == null || email.trim().isEmpty()) {
            message = "Vui lòng nhập email.";
        } else {
            // Tìm người dùng theo email
            NguoiDung user = nguoiDungService.findByEmail(email.trim());

            if (user == null) {
                // Vẫn hiển thị thành công để tránh email enumeration attack
                message = "Nếu email này đã được đăng ký, chúng tôi đã gửi link khôi phục mật khẩu đến email của bạn. Vui lòng kiểm tra hộp thư (bao gồm thư mục spam).";
                type = "success";
            } else {
                // Tạo reset token (sử dụng activationToken tạm thời)
                String resetToken = UUID.randomUUID().toString();
                user.setActivationToken(resetToken);

                // Cập nhật token vào database
                boolean updated = nguoiDungService.update(user);

                if (updated) {
                    // Tạo link reset password
                    String baseUrl = req.getScheme() + "://" + req.getServerName()
                            + (req.getServerPort() != 80 && req.getServerPort() != 443
                                ? ":" + req.getServerPort() : "")
                            + req.getContextPath();
                    String resetLink = baseUrl + "/dat-lai-mat-khau?token=" + resetToken;

                    // Gửi email
                    String hoTen = user.getHoTen() != null && !user.getHoTen().isEmpty() 
                            ? user.getHoTen() 
                            : "Người dùng";
                    boolean emailSent = EmailService.sendResetPasswordEmail(email, hoTen, resetLink);

                    if (emailSent) {
                        message = "Chúng tôi đã gửi link khôi phục mật khẩu đến email của bạn. Vui lòng kiểm tra hộp thư (bao gồm thư mục spam).";
                        type = "success";
                    } else {
                        message = "Không thể gửi email. Vui lòng thử lại sau hoặc liên hệ hỗ trợ.";
                    }
                } else {
                    message = "Có lỗi xảy ra. Vui lòng thử lại sau.";
                }
            }
        }

        // Lưu flash message vào session
        session.setAttribute("forgotPasswordFlashType", type);
        session.setAttribute("forgotPasswordFlashMessage", message);

        resp.sendRedirect(req.getContextPath() + "/quen-mat-khau");
    }
}


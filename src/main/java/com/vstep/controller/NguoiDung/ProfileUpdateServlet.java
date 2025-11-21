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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile/update")
public class ProfileUpdateServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        NguoiDung currentUser = (NguoiDung) session.getAttribute("userLogin");
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "update-profile"; // Default action
        }

        boolean success = false;
        String message = "";
        String type = "error";

        try {
            switch (action) {
                case "update-profile" -> {
                    // Cập nhật thông tin cá nhân
                    String hoTen = trimOrNull(req.getParameter("hoTen"));
                    String email = trimOrNull(req.getParameter("email"));
                    String soDienThoai = trimOrNull(req.getParameter("soDienThoai"));
                    String donVi = trimOrNull(req.getParameter("donVi"));

                    if (hoTen == null || hoTen.isEmpty()) {
                        message = "Họ và tên không được để trống.";
                        break;
                    }

                    if (email == null || email.isEmpty()) {
                        message = "Email không được để trống.";
                        break;
                    }

                    // Kiểm tra email có trùng với người khác không (trừ chính mình)
                    NguoiDung existingUser = nguoiDungService.findByEmail(email);
                    if (existingUser != null && existingUser.getId() != currentUser.getId()) {
                        message = "Email này đã được sử dụng bởi tài khoản khác.";
                        break;
                    }

                    // Lấy lại thông tin đầy đủ từ database để đảm bảo có đầy đủ dữ liệu
                    NguoiDung updatedUser = nguoiDungService.findById(currentUser.getId());
                    if (updatedUser == null) {
                        message = "Không tìm thấy thông tin người dùng.";
                        break;
                    }

                    // Cập nhật thông tin (giữ nguyên mật khẩu và các trường khác)
                    updatedUser.setHoTen(hoTen);
                    updatedUser.setEmail(email);
                    updatedUser.setSoDienThoai(soDienThoai != null ? soDienThoai : "");
                    updatedUser.setDonVi(donVi != null ? donVi : "");

                    success = nguoiDungService.update(updatedUser);
                    if (success) {
                        // Cập nhật lại session
                        session.setAttribute("userLogin", updatedUser);
                        message = "Cập nhật thông tin thành công.";
                        type = "success";
                    } else {
                        message = "Không thể cập nhật thông tin. Vui lòng thử lại.";
                    }
                }
                case "change-password" -> {
                    // Đổi mật khẩu
                    String currentPassword = req.getParameter("currentPassword");
                    String newPassword = req.getParameter("newPassword");
                    String confirmPassword = req.getParameter("confirmPassword");

                    if (currentPassword == null || currentPassword.isEmpty()) {
                        message = "Vui lòng nhập mật khẩu hiện tại.";
                        break;
                    }

                    if (newPassword == null || newPassword.isEmpty()) {
                        message = "Vui lòng nhập mật khẩu mới.";
                        break;
                    }

                    if (newPassword.length() < 6) {
                        message = "Mật khẩu mới phải có ít nhất 6 ký tự.";
                        break;
                    }

                    if (!newPassword.equals(confirmPassword)) {
                        message = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
                        break;
                    }

                    // Kiểm tra mật khẩu hiện tại
                    if (!BCrypt.checkpw(currentPassword, currentUser.getMatKhau())) {
                        message = "Mật khẩu hiện tại không đúng.";
                        break;
                    }

                    // Lấy lại thông tin đầy đủ từ database
                    NguoiDung updatedUser = nguoiDungService.findById(currentUser.getId());
                    if (updatedUser == null) {
                        message = "Không tìm thấy thông tin người dùng.";
                        break;
                    }

                    // Hash mật khẩu mới
                    String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                    updatedUser.setMatKhau(hashedPassword);

                    success = nguoiDungService.update(updatedUser);
                    if (success) {
                        // Cập nhật lại session
                        session.setAttribute("userLogin", updatedUser);
                        message = "Đổi mật khẩu thành công.";
                        type = "success";
                    } else {
                        message = "Không thể đổi mật khẩu. Vui lòng thử lại.";
                    }
                }
                default -> {
                    message = "Hành động không hợp lệ.";
                }
            }
        } catch (Exception e) {
            message = "Có lỗi xảy ra: " + e.getMessage();
            e.printStackTrace();
        }

        // Lưu flash message vào session
        session.setAttribute("profileFlashType", type);
        session.setAttribute("profileFlashMessage", message);

        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    private String trimOrNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}


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
import java.io.IOException;
import java.sql.Timestamp;
import java.util.UUID;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/dang-ky")
public class DangKyServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String hoTen = request.getParameter("fullName");
        String email = request.getParameter("email");
        String soDienThoai = request.getParameter("phone");
        String matKhau = request.getParameter("password");
        String confirmMatKhau = request.getParameter("confirmPassword");
        String vaiTro = "user"; // Mặc định là user, không phải admin

        // Kiểm tra mật khẩu xác nhận
        if (!matKhau.equals(confirmMatKhau)) {
            response.sendRedirect(request.getContextPath() + "/dang-ky?error=confirm");
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (nguoiDungService.findByEmail(email) != null) {
            response.sendRedirect(request.getContextPath() + "/dang-ky?error=exists");
            return;
        }

        // Tạo activation token
        String activationToken = UUID.randomUUID().toString();

        // Hash mật khẩu
        String hashedPassword = BCrypt.hashpw(matKhau, BCrypt.gensalt());

        // Tạo đối tượng người dùng
        NguoiDung nd = new NguoiDung();
        nd.setHoTen(hoTen);
        nd.setEmail(email);
        nd.setSoDienThoai(soDienThoai);
        nd.setMatKhau(hashedPassword);
        nd.setVaiTro(vaiTro);
        nd.setKichHoat(false); // Tài khoản chưa kích hoạt
        nd.setActivationToken(activationToken);
        nd.setNgayTao(new Timestamp(System.currentTimeMillis()));

        // Lưu người dùng vào database
        boolean created = nguoiDungService.create(nd);

        if (created) {
            // Tạo link kích hoạt
            String baseUrl = request.getScheme() + "://" + request.getServerName() 
                    + (request.getServerPort() != 80 && request.getServerPort() != 443 
                        ? ":" + request.getServerPort() : "") 
                    + request.getContextPath();
            String activationLink = baseUrl + "/kich-hoat?token=" + activationToken;

            // Gửi email kích hoạt
            boolean emailSent = EmailService.sendActivationEmail(email, hoTen, activationLink);

            if (emailSent) {
                // Chuyển đến trang đăng nhập với thông báo cần kích hoạt
                response.sendRedirect(request.getContextPath() + "/dang-nhap?success=register&message=activation");
            } else {
                // Nếu gửi email thất bại, vẫn thông báo thành công nhưng cảnh báo
                response.sendRedirect(request.getContextPath() + "/dang-ky?success=register&warning=email");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/dang-ky?error=server");
        }
    }
}


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
import java.sql.Timestamp;
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
        String vaiTro = "admin";

        if (!matKhau.equals(confirmMatKhau)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(request, response);
            return;
        }


        if (nguoiDungService.findByEmail(email) != null) {
            request.setAttribute("error", "Email đã được đăng ký!");
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(request, response);
            return;
        }
        String hashedPassword = BCrypt.hashpw(matKhau, BCrypt.gensalt());
        NguoiDung nd = new NguoiDung();
        nd.setHoTen(hoTen);
        nd.setEmail(email);
        nd.setSoDienThoai(soDienThoai);
        nd.setMatKhau(hashedPassword);
        nd.setVaiTro(vaiTro);
        nd.setKichHoat(true);
        nd.setNgayTao(new Timestamp(System.currentTimeMillis()));

        boolean created = nguoiDungService.create(nd);

        if (created) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap?success=1");
        } else {
            request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
            request.getRequestDispatcher("/WEB-INF/views/public/register.jsp").forward(request, response);
        }
    }
}


package com.vstep.controller.NguoiDung;

import com.vstep.model.NguoiDung;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.NguoiDungServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/dang-nhap")
public class DangNhapServlet extends HttpServlet {

    private final NguoiDungService nguoiDungService = new NguoiDungServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển tới trang login
        request.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");

        NguoiDung nd = nguoiDungService.findByEmail(email);

        if (nd == null) {
            request.setAttribute("error", "Email không tồn tại!");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu
        if (!BCrypt.checkpw(matKhau, nd.getMatKhau())) {
            request.setAttribute("error", "Mật khẩu không đúng!");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra kích hoạt tài khoản
        if (!nd.isKichHoat()) {
            request.setAttribute("error", "Tài khoản chưa được kích hoạt!");
            request.getRequestDispatcher("/WEB-INF/views/public/login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công, lưu vào session
        HttpSession session = request.getSession();
        session.setAttribute("userLogin", nd); // Lưu object NguoiDung vào session

        // Chuyển hướng đến trang chính (ví dụ: trang dashboard)
        if("admin".equalsIgnoreCase(nd.getVaiTro())){
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/");
    }
}

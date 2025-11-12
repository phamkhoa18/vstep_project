package com.vstep.controller.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dang-xuat")
public class DangXuatServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy session hiện tại, nếu không có thì null
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Xóa tất cả thông tin trong session
            session.invalidate();
        }

        // Chuyển hướng về trang đăng nhập hoặc trang chủ
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
    }

    // Nếu muốn, có thể handle POST tương tự
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

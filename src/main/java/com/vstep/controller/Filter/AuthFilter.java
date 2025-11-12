package com.vstep.controller.Filter;

import com.vstep.model.NguoiDung;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*") // Áp dụng cho tất cả URL
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length()).trim();

        // Các trang công khai
        String[] publicPages = {"/", "/dang-nhap", "/dang-ky", "/lop", "/ca", "/css/", "/js/", "/images/"};
        for(String p : publicPages){
            if(path.startsWith(p)){
                // Nếu đã login và vào login page → redirect theo vai trò
                if("/dang-nhap".equals(path) && session != null && session.getAttribute("userLogin") != null){
                    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
                    if("admin".equalsIgnoreCase(user.getVaiTro().trim())){
                        res.sendRedirect(req.getContextPath() + "/admin/dashboard");
                    } else {
                        res.sendRedirect(req.getContextPath() + "/");
                    }
                    return;
                }
                chain.doFilter(request, response);
                return;
            }
        }

        // Kiểm tra login
        if(session == null || session.getAttribute("userLogin") == null){
            res.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("userLogin");

        // Phân quyền admin
        if(path.startsWith("/admin") && !"admin".equalsIgnoreCase(user.getVaiTro().trim())){
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }

        // Cho phép tiếp tục
        chain.doFilter(request, response);
    }
}


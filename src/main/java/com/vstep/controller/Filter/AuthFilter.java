package com.vstep.controller.Filter;

import java.io.IOException;

import com.vstep.model.NguoiDung;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
        
        // Các trang cần đăng nhập nhưng không cần admin
        if (path.startsWith("/dang-ky-lop") || path.startsWith("/user/register-class") || 
            path.startsWith("/lop-da-dang-ky") || path.startsWith("/ca-da-dang-ky")) {
            if (session == null || session.getAttribute("userLogin") == null) {
                String redirectUrl = req.getRequestURI();
                if (req.getQueryString() != null) {
                    redirectUrl += "?" + req.getQueryString();
                }
                res.sendRedirect(req.getContextPath() + "/dang-nhap?redirect=" + 
                    java.net.URLEncoder.encode(redirectUrl, "UTF-8"));
                return;
            }
            chain.doFilter(request, response);
            return;
        }
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


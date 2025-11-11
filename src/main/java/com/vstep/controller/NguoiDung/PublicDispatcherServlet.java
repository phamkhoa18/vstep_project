package com.vstep.controller.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "PublicDispatcherServlet", urlPatterns = {"", "/", "/public/*"})
public class PublicDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();

    static {
        VIEW_MAP.put("", "/index.jsp");
        VIEW_MAP.put("/", "/index.jsp");
        VIEW_MAP.put("/index", "/index.jsp");
        VIEW_MAP.put("/lop", "/WEB-INF/views/public/lop-list.jsp");
        VIEW_MAP.put("/lop/chi-tiet", "/WEB-INF/views/public/lop-detail.jsp");
        VIEW_MAP.put("/ca", "/WEB-INF/views/public/ca-list.jsp");
        VIEW_MAP.put("/ca/chi-tiet", "/WEB-INF/views/public/ca-detail.jsp");
        VIEW_MAP.put("/dang-nhap", "/WEB-INF/views/public/login.jsp");
        VIEW_MAP.put("/dang-ky", "/WEB-INF/views/public/register.jsp");
        VIEW_MAP.put("/dang-ky-thanh-cong", "/WEB-INF/views/public/success.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();
        String pathInfo = req.getPathInfo();

        String key;
        if ("/public".equals(servletPath)) {
            key = pathInfo == null ? "" : pathInfo;
        } else {
            key = servletPath.equals("/") ? "" : servletPath;
        }

        String view = VIEW_MAP.get(key);
        if (view == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }
}


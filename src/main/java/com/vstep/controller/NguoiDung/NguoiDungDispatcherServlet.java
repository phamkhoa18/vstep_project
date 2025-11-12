package com.vstep.controller.NguoiDung;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.vstep.model.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/profile", "/lop-da-dang-ky", "/ca-da-dang-ky"})
public class NguoiDungDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();

    static {
        VIEW_MAP.put("/profile", "/WEB-INF/views/user/user-dashboard.jsp");
        VIEW_MAP.put("/lop-da-dang-ky", "/WEB-INF/views/user/user-register-class.jsp");
        VIEW_MAP.put("/ca-da-dang-ky", "/WEB-INF/views/user/user-register-exam.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        NguoiDung user = session != null ? (NguoiDung) session.getAttribute("userLogin") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        String servletPath = req.getServletPath();
        String view = VIEW_MAP.get(servletPath);

        if (view == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}


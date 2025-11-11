package com.vstep.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Simple dispatcher that routes /admin/* requests to the corresponding JSPs under WEB-INF.
 * Replace with proper authentication/authorization before using in production.
 */
@WebServlet(name = "AdminDispatcherServlet", urlPatterns = {"/admin/*"})
public class AdminDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();

    static {
        VIEW_MAP.put("", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/login", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/dashboard", "/WEB-INF/views/admin/admin-dashboard.jsp");
        VIEW_MAP.put("/classes", "/WEB-INF/views/admin/admin-classes.jsp");
        VIEW_MAP.put("/exams", "/WEB-INF/views/admin/admin-exams.jsp");
        VIEW_MAP.put("/registrations", "/WEB-INF/views/admin/admin-registrations.jsp");
        VIEW_MAP.put("/config", "/WEB-INF/views/admin/admin-config.jsp");
        VIEW_MAP.put("/statistics", "/WEB-INF/views/admin/admin-statistics.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "";
        }

        String view = VIEW_MAP.get(pathInfo);
        if (view == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }
}


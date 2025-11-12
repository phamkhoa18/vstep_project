package com.vstep.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.service.LopOnService;
import com.vstep.serviceImpl.LopOnServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminDispatcherServlet", urlPatterns = {"/admin/*"})
public class AdminDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();
    private LopOnService lopOnService;

    static {
        VIEW_MAP.put("", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/login", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/dashboard", "/WEB-INF/views/admin/admin-dashboard.jsp");
        VIEW_MAP.put("/classes", "/WEB-INF/views/admin/admin-classes.jsp");
        VIEW_MAP.put("/classes/create", "/WEB-INF/views/admin/admin-classes-create.jsp");
        VIEW_MAP.put("/exams", "/WEB-INF/views/admin/admin-exams.jsp");
        VIEW_MAP.put("/registrations", "/WEB-INF/views/admin/admin-registrations.jsp");
        VIEW_MAP.put("/config", "/WEB-INF/views/admin/admin-config.jsp");
        VIEW_MAP.put("/statistics", "/WEB-INF/views/admin/admin-statistics.jsp");
    }

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        NguoiDung user = session != null ? (NguoiDung) session.getAttribute("userLogin") : null;

        // Nếu chưa đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        // Kiểm tra vai trò (chỉ admin mới được vào)
        if (!"admin".equalsIgnoreCase(user.getVaiTro())) {
            resp.sendRedirect(req.getContextPath() + "/404");
            return;
        }

        String pathInfo = req.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "";
        }

        String view = VIEW_MAP.get(pathInfo);

        if (view == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        prepareFlashMessages(req, session);

        if ("/classes".equals(pathInfo)) {
            prepareClassManagementData(req);
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

    private void prepareClassManagementData(HttpServletRequest req) {
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        List<LopOn> lopOnList = lopOnService.findAll();
        req.setAttribute("lopOnList", lopOnList);

        int totalClasses = lopOnList.size();
        req.setAttribute("classCount", totalClasses);

        int totalCapacity = 0;
        int dangMoCount = 0;
        int sapMoCount = 0;
        int daKetThucCount = 0;
        int nearlyFullCount = 0;

        for (LopOn lop : lopOnList) {
            totalCapacity += lop.getSiSoToiDa();
            String normalizedStatus = normalizeStatus(lop.getTinhTrang());
            switch (normalizedStatus) {
                case "dangmo" -> dangMoCount++;
                case "sapmo" -> sapMoCount++;
                case "daketthuc", "ketthuc" -> daKetThucCount++;
                default -> {
                }
            }
            if (lop.getSiSoToiDa() >= 40) {
                nearlyFullCount++;
            }
        }

        double averageCapacity = totalClasses == 0 ? 0 : (double) totalCapacity / totalClasses;

        req.setAttribute("averageCapacity", averageCapacity);
        req.setAttribute("dangMoCount", dangMoCount);
        req.setAttribute("sapMoCount", sapMoCount);
        req.setAttribute("daKetThucCount", daKetThucCount);
        req.setAttribute("nearlyFullCount", nearlyFullCount);
    }

    private String normalizeStatus(String status) {
        if (status == null) {
            return "";
        }
        String value = status.trim()
                .replace('Đ', 'D')
                .replace('đ', 'd')
                .toLowerCase();
        value = value.replaceAll("[\\s_\\-]+", "");
        return value;
    }

    private void prepareFlashMessages(HttpServletRequest req, HttpSession session) {
        if (session == null) {
            return;
        }
        Object message = session.getAttribute("classFlashMessage");
        if (message != null) {
            req.setAttribute("classFlashMessage", message);
            Object type = session.getAttribute("classFlashType");
            req.setAttribute("classFlashType", type != null ? type : "info");
            session.removeAttribute("classFlashMessage");
            session.removeAttribute("classFlashType");
        }
    }
}

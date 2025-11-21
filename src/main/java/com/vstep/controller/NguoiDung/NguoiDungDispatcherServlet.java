package com.vstep.controller.NguoiDung;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.vstep.model.CaThi;
import com.vstep.model.DangKyLop;
import com.vstep.model.DangKyThi;
import com.vstep.model.HoaDon;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.repository.DangKyLopRepository;
import com.vstep.repository.DangKyThiRepository;
import com.vstep.repository.LopOnRepository;
import com.vstep.repositoryImpl.DangKyLopRepositoryImpl;
import com.vstep.repositoryImpl.DangKyThiRepositoryImpl;
import com.vstep.repositoryImpl.LopOnRepositoryImpl;
import com.vstep.service.CaThiService;
import com.vstep.service.HoaDonService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.HoaDonServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/profile", "/lop-da-dang-ky", "/ca-da-dang-ky"})
public class NguoiDungDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();
    private final DangKyLopRepository dangKyLopRepository = new DangKyLopRepositoryImpl();
    private final LopOnRepository lopOnRepository = new LopOnRepositoryImpl();
    private final DangKyThiRepository dangKyThiRepository = new DangKyThiRepositoryImpl();
    private final CaThiService caThiService = new CaThiServiceImpl();

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
        
        // Load dữ liệu cho trang profile (hóa đơn)
        if ("/profile".equals(servletPath)) {
            HoaDonService hoaDonService = new HoaDonServiceImpl();
            List<HoaDon> hoaDonList = hoaDonService.findByNguoiDungId(user.getId());
            req.setAttribute("hoaDonList", hoaDonList);
        }
        
        // Load dữ liệu cho trang lớp đã đăng ký
        if ("/lop-da-dang-ky".equals(servletPath)) {
            List<DangKyLop> dangKyLopList = dangKyLopRepository.findByNguoiDungId(user.getId());
            List<Map<String, Object>> lopDangKyList = new ArrayList<>();
            
            for (DangKyLop dangKyLop : dangKyLopList) {
                LopOn lopOn = lopOnRepository.findById((int) dangKyLop.getLopOnId());
                if (lopOn != null) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("dangKyLop", dangKyLop);
                    item.put("lopOn", lopOn);
                    lopDangKyList.add(item);
                }
            }
            
            req.setAttribute("lopDangKyList", lopDangKyList);
        }
        
        // Load dữ liệu cho trang ca thi đã đăng ký
        if ("/ca-da-dang-ky".equals(servletPath)) {
            List<DangKyThi> userRegistrations = dangKyThiRepository.findByNguoiDungId(user.getId());
            List<Map<String, Object>> userRegistrationsWithDetails = new ArrayList<>();
            
            if (userRegistrations != null) {
                for (DangKyThi dk : userRegistrations) {
                    if (dk != null) {
                        Map<String, Object> detail = new HashMap<>();
                        detail.put("dangKyThi", dk);
                        CaThi ct = caThiService.findById(dk.getCaThiId());
                        detail.put("caThi", ct != null ? ct : new CaThi());
                        userRegistrationsWithDetails.add(detail);
                    }
                }
            }
            
            req.setAttribute("userRegistrationsWithDetails", userRegistrationsWithDetails);
        }

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


package com.vstep.controller.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;

import com.vstep.filter.ClassFilters;
import com.vstep.model.DangKyLop;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.service.DangKyLopService;
import com.vstep.service.LopOnService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.DangKyLopServiceImpl;
import com.vstep.serviceImpl.LopOnServiceImpl;
import com.vstep.serviceImpl.NguoiDungServiceImpl;

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
    private DangKyLopService dangKyLopService;
    private NguoiDungService nguoiDungService;

    static {
        VIEW_MAP.put("", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/login", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/dashboard", "/WEB-INF/views/admin/admin-dashboard.jsp");
        VIEW_MAP.put("/classes", "/WEB-INF/views/admin/admin-classes.jsp");
        VIEW_MAP.put("/classes/create", "/WEB-INF/views/admin/admin-classes-create.jsp");
        VIEW_MAP.put("/classes/edit", "/WEB-INF/views/admin/admin-classes-edit.jsp");
        VIEW_MAP.put("/exams", "/WEB-INF/views/admin/admin-exams.jsp");
        VIEW_MAP.put("/registrations", "/WEB-INF/views/admin/admin-registrations.jsp");
        VIEW_MAP.put("/config", "/WEB-INF/views/admin/admin-config.jsp");
        VIEW_MAP.put("/statistics", "/WEB-INF/views/admin/admin-statistics.jsp");
    }

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
        dangKyLopService = new DangKyLopServiceImpl();
        nguoiDungService = new NguoiDungServiceImpl();
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
        } else if ("/classes/edit".equals(pathInfo)) {
            prepareEditClassData(req, resp, session);
            if (resp.isCommitted()) {
                return;
            }
        } else if ("/registrations".equals(pathInfo)) {
            prepareRegistrationsData(req);
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
        List<LopOn> allClasses = lopOnService.findAll();

        ClassFilters filters = ClassFilters.fromRequest(req);
        List<LopOn> filteredClasses = filters.apply(allClasses);

        // Phân trang
        int pageSize = parsePageSize(req.getParameter("pageSize"));
        int currentPage = parsePageNumber(req.getParameter("page"));
        int totalRecords = filteredClasses.size();
        int totalPages = totalRecords > 0 ? (int) Math.ceil((double) totalRecords / pageSize) : 1;
        
        // Đảm bảo currentPage hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        
        // Lấy dữ liệu cho trang hiện tại
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalRecords);
        List<LopOn> paginatedClasses = new ArrayList<>();
        if (startIndex < totalRecords) {
            paginatedClasses = filteredClasses.subList(startIndex, endIndex);
        }

        req.setAttribute("lopOnList", paginatedClasses);
        req.setAttribute("classFilterParams", filters);
        req.setAttribute("activeFilterChips",
                filters.toChips(req.getContextPath() + "/admin/classes"));
        req.setAttribute("hasActiveFilters", filters.hasActive());

        // Thông tin phân trang
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("startRecord", totalRecords > 0 ? startIndex + 1 : 0);
        req.setAttribute("endRecord", Math.min(endIndex, totalRecords));

        int totalClasses = filteredClasses.size();
        req.setAttribute("classCount", totalClasses);

        int totalCapacity = 0;
        int dangMoCount = 0;
        int sapMoCount = 0;
        int daKetThucCount = 0;
        int nearlyFullCount = 0;

        for (LopOn lop : filteredClasses) {
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

        req.setAttribute("formatOptions", extractDistinctOptions(allClasses, LopOn::getHinhThuc));
        req.setAttribute("paceOptions", extractDistinctOptions(allClasses, LopOn::getNhipDo));
        req.setAttribute("statusOptions", extractDistinctOptions(allClasses, LopOn::getTinhTrang));
    }

    private String normalizeStatus(String status) {
        return com.vstep.util.FilterUtils.normalizeForComparison(status);
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

    private void prepareEditClassData(HttpServletRequest req,
                                      HttpServletResponse resp,
                                      HttpSession session) throws IOException {
        String idParam = req.getParameter("id");
        long classId = parseLong(idParam);
        if (classId <= 0) {
            stashFlashAndRedirect(session, req, resp,
                    "error",
                    "Lớp ôn không tồn tại hoặc tham số không hợp lệ.");
            return;
        }

        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }

        LopOn lopOn = lopOnService.findById(classId);
        if (lopOn == null) {
            stashFlashAndRedirect(session, req, resp,
                    "error",
                    "Không tìm thấy lớp ôn với mã yêu cầu.");
            return;
        }

        req.setAttribute("lopOn", lopOn);
    }

    private void stashFlashAndRedirect(HttpSession session,
                                       HttpServletRequest req,
                                       HttpServletResponse resp,
                                       String type,
                                       String message) throws IOException {
        if (session != null) {
            session.setAttribute("classFlashType", type);
            session.setAttribute("classFlashMessage", message);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/classes");
    }

    private Set<String> extractDistinctOptions(List<LopOn> source, Function<LopOn, String> extractor) {
        Map<String, String> normalizedToOriginal = new LinkedHashMap<>();
        for (LopOn lop : source) {
            String rawValue = extractor.apply(lop);
            if (rawValue == null) {
                continue;
            }
            String value = rawValue.trim();
            if (value.isEmpty()) {
                continue;
            }
            String normalized = com.vstep.util.FilterUtils.normalizeForComparison(value);
            if (!normalized.isEmpty()) {
                normalizedToOriginal.putIfAbsent(normalized, value);
            }
        }
        return new LinkedHashSet<>(normalizedToOriginal.values());
    }

    private long parseLong(String value) {
        if (value == null || value.isBlank()) {
            return 0L;
        }
        try {
            return Long.parseLong(value.trim());
        } catch (NumberFormatException ex) {
            return 0L;
        }
    }

    private int parsePageNumber(String value) {
        if (value == null || value.isBlank()) {
            return 1;
        }
        try {
            int page = Integer.parseInt(value.trim());
            return page > 0 ? page : 1;
        } catch (NumberFormatException ex) {
            return 1;
        }
    }

    private int parsePageSize(String value) {
        if (value == null || value.isBlank()) {
            return 5; // Mặc định 5 items mỗi trang
        }
        try {
            int size = Integer.parseInt(value.trim());
            // Giới hạn pageSize từ 5 đến 50
            if (size < 5) {
                return 5;
            } else if (size > 50) {
                return 50;
            }
            return size;
        } catch (NumberFormatException ex) {
            return 5;
        }
    }

    private void prepareRegistrationsData(HttpServletRequest req) {
        if (dangKyLopService == null) {
            dangKyLopService = new DangKyLopServiceImpl();
        }
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        if (nguoiDungService == null) {
            nguoiDungService = new NguoiDungServiceImpl();
        }

        // Lấy tất cả đăng ký
        List<DangKyLop> allRegistrations = dangKyLopService.findAll();
        
        // Tạo danh sách với thông tin đầy đủ
        List<Map<String, Object>> registrationsWithDetails = new ArrayList<>();
        for (DangKyLop dk : allRegistrations) {
            Map<String, Object> detail = new HashMap<>();
            detail.put("dangKy", dk);
            
            // Load thông tin người dùng
            NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
            detail.put("nguoiDung", user);
            
            // Load thông tin lớp
            LopOn lop = lopOnService.findById(dk.getLopOnId());
            detail.put("lopOn", lop);
            
            registrationsWithDetails.add(detail);
        }

        // Filter theo trạng thái (nếu có)
        String trangThaiFilter = req.getParameter("trangThai");
        if (trangThaiFilter != null && !trangThaiFilter.isEmpty()) {
            List<Map<String, Object>> filtered = new ArrayList<>();
            for (Map<String, Object> reg : registrationsWithDetails) {
                DangKyLop dk = (DangKyLop) reg.get("dangKy");
                if (trangThaiFilter.equals(dk.getTrangThai())) {
                    filtered.add(reg);
                }
            }
            registrationsWithDetails = filtered;
        }

        // Search theo tên, email, mã đăng ký
        String searchQuery = req.getParameter("search");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String searchLower = searchQuery.toLowerCase().trim();
            List<Map<String, Object>> filtered = new ArrayList<>();
            for (Map<String, Object> reg : registrationsWithDetails) {
                DangKyLop dk = (DangKyLop) reg.get("dangKy");
                NguoiDung user = (NguoiDung) reg.get("nguoiDung");
                
                boolean matches = false;
                if (user != null) {
                    if (user.getHoTen() != null && user.getHoTen().toLowerCase().contains(searchLower)) {
                        matches = true;
                    }
                    if (user.getEmail() != null && user.getEmail().toLowerCase().contains(searchLower)) {
                        matches = true;
                    }
                }
                if (dk.getMaXacNhan() != null && dk.getMaXacNhan().toLowerCase().contains(searchLower)) {
                    matches = true;
                }
                
                if (matches) {
                    filtered.add(reg);
                }
            }
            registrationsWithDetails = filtered;
        }

        // Phân trang
        int pageSize = parsePageSize(req.getParameter("pageSize"));
        int currentPage = parsePageNumber(req.getParameter("page"));
        int totalRecords = registrationsWithDetails.size();
        int totalPages = totalRecords > 0 ? (int) Math.ceil((double) totalRecords / pageSize) : 1;
        
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalRecords);
        List<Map<String, Object>> paginatedRegistrations = new ArrayList<>();
        if (startIndex < totalRecords) {
            paginatedRegistrations = registrationsWithDetails.subList(startIndex, endIndex);
        }

        req.setAttribute("registrations", paginatedRegistrations);
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("startRecord", totalRecords > 0 ? startIndex + 1 : 0);
        req.setAttribute("endRecord", Math.min(endIndex, totalRecords));

        // Thống kê
        int totalRegistrations = allRegistrations.size();
        int choDuyetCount = 0;
        int daDuyetCount = 0;
        int daHuyCount = 0;
        long totalRevenue = 0;
        
        for (DangKyLop dk : allRegistrations) {
            String trangThai = dk.getTrangThai();
            if (trangThai != null) {
                if (trangThai.contains("Chờ") || trangThai.contains("chờ")) {
                    choDuyetCount++;
                } else if (trangThai.contains("Đã") || trangThai.contains("đã")) {
                    if (trangThai.contains("Hủy") || trangThai.contains("hủy")) {
                        daHuyCount++;
                    } else {
                        daDuyetCount++;
                    }
                }
            }
            totalRevenue += dk.getSoTienDaTra();
        }

        req.setAttribute("totalRegistrations", totalRegistrations);
        req.setAttribute("choDuyetCount", choDuyetCount);
        req.setAttribute("daDuyetCount", daDuyetCount);
        req.setAttribute("daHuyCount", daHuyCount);
        req.setAttribute("totalRevenue", totalRevenue);
        
        // Lấy danh sách trạng thái unique để filter
        Set<String> statusOptions = new LinkedHashSet<>();
        for (DangKyLop dk : allRegistrations) {
            if (dk.getTrangThai() != null && !dk.getTrangThai().isEmpty()) {
                statusOptions.add(dk.getTrangThai());
            }
        }
        req.setAttribute("statusOptions", statusOptions);
    }
}

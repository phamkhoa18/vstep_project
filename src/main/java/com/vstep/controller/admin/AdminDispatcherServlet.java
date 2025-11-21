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
import com.vstep.model.CaThi;
import com.vstep.model.DangKyLop;
import com.vstep.model.DangKyThi;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.service.CaThiService;
import com.vstep.service.DangKyLopService;
import com.vstep.service.DangKyThiService;
import com.vstep.service.LopOnService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.DangKyLopServiceImpl;
import com.vstep.serviceImpl.DangKyThiServiceImpl;
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
    private CaThiService caThiService;
    private DangKyThiService dangKyThiService;

    static {
        VIEW_MAP.put("", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/", "/WEB-INF/views/admin/admin-login.jsp");
        VIEW_MAP.put("/login", "/WEB-INF/views/admin/admin-login.jsp");
        // /dashboard được xử lý bởi AdminDashboardServlet riêng
        VIEW_MAP.put("/classes", "/WEB-INF/views/admin/admin-classes.jsp");
        VIEW_MAP.put("/classes/create", "/WEB-INF/views/admin/admin-classes-create.jsp");
        VIEW_MAP.put("/classes/edit", "/WEB-INF/views/admin/admin-classes-edit.jsp");
        VIEW_MAP.put("/exams", "/WEB-INF/views/admin/admin-exams.jsp");
        VIEW_MAP.put("/exams/create", "/WEB-INF/views/admin/admin-exams-create.jsp");
        VIEW_MAP.put("/registrations", "/WEB-INF/views/admin/admin-registrations.jsp");
        VIEW_MAP.put("/config", "/WEB-INF/views/admin/admin-config.jsp");
    }

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
        dangKyLopService = new DangKyLopServiceImpl();
        nguoiDungService = new NguoiDungServiceImpl();
        caThiService = new CaThiServiceImpl();
        dangKyThiService = new DangKyThiServiceImpl();
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
        } else if ("/exams".equals(pathInfo)) {
            prepareExamsData(req);
        } else if ("/registrations".equals(pathInfo)) {
            prepareRegistrationsData(req);
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "";
        }

        if ("/registrations".equals(pathInfo)) {
            handleRegistrationsPost(req, resp);
            return;
        }

        doGet(req, resp);
    }

    private void prepareClassManagementData(HttpServletRequest req) {
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        if (dangKyLopService == null) {
            dangKyLopService = new DangKyLopServiceImpl();
        }
        List<LopOn> allClasses = lopOnService.findAll();

        // Derive status from dates for every class
        for (LopOn lop : allClasses) {
            String derived = deriveLopStatus(lop);
            lop.setTinhTrang(derived);
        }

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

        // Đếm số người đăng ký hiện tại cho từng lớp trên trang
        java.util.Map<Long, Integer> registeredCounts = new java.util.HashMap<>();
        for (LopOn lop : paginatedClasses) {
            int count = dangKyLopService.countByLopOnId(lop.getId());
            registeredCounts.put(lop.getId(), count);
        }
        req.setAttribute("registeredCounts", registeredCounts);
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
            String status = lop.getTinhTrang() != null ? lop.getTinhTrang().trim() : "";
            String normalizedStatus = com.vstep.util.FilterUtils.normalizeForComparison(status);
            if ("đang mở".equalsIgnoreCase(status) || "dangmo".equals(normalizedStatus)) {
                dangMoCount++;
            } else if ("chuẩn bị".equalsIgnoreCase(status) || "sapmo".equals(normalizedStatus) || "chuanbi".equals(normalizedStatus)) {
                sapMoCount++;
            } else if ("kết thúc".equalsIgnoreCase(status) || "ketthuc".equals(normalizedStatus) || "daketthuc".equals(normalizedStatus)) {
                daKetThucCount++;
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
        
        // Flash messages cho exams
        Object examMessage = session.getAttribute("examFlashMessage");
        if (examMessage != null) {
            req.setAttribute("examFlashMessage", examMessage);
            Object examType = session.getAttribute("examFlashType");
            req.setAttribute("examFlashType", examType != null ? examType : "info");
            session.removeAttribute("examFlashMessage");
            session.removeAttribute("examFlashType");
        }
        
        // Flash messages cho config
        Object configMessage = session.getAttribute("configFlashMessage");
        if (configMessage != null) {
            req.setAttribute("configFlashMessage", configMessage);
            Object configType = session.getAttribute("configFlashType");
            req.setAttribute("configFlashType", configType != null ? configType : "info");
            session.removeAttribute("configFlashMessage");
            session.removeAttribute("configFlashType");
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
        try {
            if (dangKyLopService == null) {
                dangKyLopService = new DangKyLopServiceImpl();
            }
            if (dangKyThiService == null) {
                dangKyThiService = new DangKyThiServiceImpl();
            }
            if (lopOnService == null) {
                lopOnService = new LopOnServiceImpl();
            }
            if (caThiService == null) {
                caThiService = new CaThiServiceImpl();
            }
            if (nguoiDungService == null) {
                nguoiDungService = new NguoiDungServiceImpl();
            }

            // Lấy tất cả đăng ký lớp ôn
            List<DangKyLop> allRegistrationsLop = dangKyLopService.findAll();
            
            // Lấy tất cả đăng ký ca thi
            List<DangKyThi> allRegistrationsThi = dangKyThiService.findAll();
        
        // Tạo danh sách với thông tin đầy đủ (bao gồm cả lớp ôn và ca thi)
        List<Map<String, Object>> registrationsWithDetails = new ArrayList<>();
        
        // Xử lý đăng ký lớp ôn
        for (DangKyLop dk : allRegistrationsLop) {
            Map<String, Object> detail = new HashMap<>();
            detail.put("dangKy", dk);
            detail.put("loai", "lop"); // Đánh dấu là đăng ký lớp ôn
            
            // Load thông tin người dùng
            NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
            detail.put("nguoiDung", user);
            
            // Load thông tin lớp
            LopOn lop = lopOnService.findById(dk.getLopOnId());
            detail.put("lopOn", lop);
            if (lop != null) {
                detail.put("lopStatus", deriveLopStatus(lop));
            }
            
            registrationsWithDetails.add(detail);
        }
        
        // Xử lý đăng ký ca thi
        for (DangKyThi dk : allRegistrationsThi) {
            Map<String, Object> detail = new HashMap<>();
            detail.put("dangKyThi", dk);
            detail.put("loai", "thi"); // Đánh dấu là đăng ký ca thi
            
            // Load thông tin người dùng
            NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
            detail.put("nguoiDung", user);
            
            // Load thông tin ca thi
            CaThi caThi = caThiService.findById(dk.getCaThiId());
            detail.put("caThi", caThi);
            
            registrationsWithDetails.add(detail);
        }
        
        // Sắp xếp theo ngày đăng ký (mới nhất trước)
        registrationsWithDetails.sort((a, b) -> {
            java.sql.Timestamp dateA = null;
            java.sql.Timestamp dateB = null;
            
            if ("lop".equals(a.get("loai"))) {
                DangKyLop dk = (DangKyLop) a.get("dangKy");
                dateA = dk.getNgayDangKy();
            } else {
                DangKyThi dk = (DangKyThi) a.get("dangKyThi");
                dateA = dk.getNgayDangKy();
            }
            
            if ("lop".equals(b.get("loai"))) {
                DangKyLop dk = (DangKyLop) b.get("dangKy");
                dateB = dk.getNgayDangKy();
            } else {
                DangKyThi dk = (DangKyThi) b.get("dangKyThi");
                dateB = dk.getNgayDangKy();
            }
            
            if (dateA == null && dateB == null) return 0;
            if (dateA == null) return 1;
            if (dateB == null) return -1;
            return dateB.compareTo(dateA); // Mới nhất trước
        });

        // Áp dụng tất cả các filter
        String loaiFilter = req.getParameter("loai"); // "lop", "thi", hoặc empty (tất cả)
        String trangThaiFilter = req.getParameter("trangThai");
        String searchQuery = req.getParameter("search");
        String fromDate = req.getParameter("fromDate");
        String toDate = req.getParameter("toDate");
        String thanhToanFilter = req.getParameter("thanhToan"); // "daThanhToan", "choThanhToan", hoặc empty
        
        List<Map<String, Object>> filteredList = new ArrayList<>();
        
        for (Map<String, Object> reg : registrationsWithDetails) {
            boolean include = true;
            
            // Filter theo loại đăng ký
            if (include && loaiFilter != null && !loaiFilter.isEmpty() && !"all".equals(loaiFilter)) {
                String loai = (String) reg.get("loai");
                if (!loaiFilter.equals(loai)) {
                    include = false;
                }
            }
            
            // Filter theo trạng thái
            if (include && trangThaiFilter != null && !trangThaiFilter.isEmpty()) {
                String trangThai = null;
                if ("lop".equals(reg.get("loai"))) {
                    DangKyLop dk = (DangKyLop) reg.get("dangKy");
                    trangThai = dk.getTrangThai();
                } else {
                    DangKyThi dk = (DangKyThi) reg.get("dangKyThi");
                    trangThai = dk.getTrangThai();
                }
                if (!trangThaiFilter.equals(trangThai)) {
                    include = false;
                }
            }
            
            // Filter theo ngày đăng ký
            if (include && (fromDate != null && !fromDate.isEmpty() || toDate != null && !toDate.isEmpty())) {
                java.sql.Timestamp ngayDangKy = null;
                if ("lop".equals(reg.get("loai"))) {
                    DangKyLop dk = (DangKyLop) reg.get("dangKy");
                    ngayDangKy = dk.getNgayDangKy();
                } else {
                    DangKyThi dk = (DangKyThi) reg.get("dangKyThi");
                    ngayDangKy = dk.getNgayDangKy();
                }
                
                if (ngayDangKy != null) {
                    java.util.Date regDate = new java.util.Date(ngayDangKy.getTime());
                    java.util.Calendar regCal = java.util.Calendar.getInstance();
                    regCal.setTime(regDate);
                    regCal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                    regCal.set(java.util.Calendar.MINUTE, 0);
                    regCal.set(java.util.Calendar.SECOND, 0);
                    regCal.set(java.util.Calendar.MILLISECOND, 0);
                    
                    if (fromDate != null && !fromDate.isEmpty()) {
                        try {
                            java.sql.Date from = java.sql.Date.valueOf(fromDate);
                            if (regCal.getTime().before(from)) {
                                include = false;
                            }
                        } catch (IllegalArgumentException e) {
                            // Ignore invalid date
                        }
                    }
                    
                    if (include && toDate != null && !toDate.isEmpty()) {
                        try {
                            java.sql.Date to = java.sql.Date.valueOf(toDate);
                            java.util.Calendar toCal = java.util.Calendar.getInstance();
                            toCal.setTime(to);
                            toCal.set(java.util.Calendar.HOUR_OF_DAY, 23);
                            toCal.set(java.util.Calendar.MINUTE, 59);
                            toCal.set(java.util.Calendar.SECOND, 59);
                            toCal.set(java.util.Calendar.MILLISECOND, 999);
                            
                            if (regCal.getTime().after(toCal.getTime())) {
                                include = false;
                            }
                        } catch (IllegalArgumentException e) {
                            // Ignore invalid date
                        }
                    }
                } else {
                    include = false; // Không có ngày đăng ký thì loại bỏ
                }
            }
            
            // Filter theo thanh toán
            if (include && thanhToanFilter != null && !thanhToanFilter.isEmpty() && !"all".equals(thanhToanFilter)) {
                boolean daThanhToan = false;
                if ("lop".equals(reg.get("loai"))) {
                    DangKyLop dk = (DangKyLop) reg.get("dangKy");
                    daThanhToan = dk.getSoTienDaTra() > 0;
                } else {
                    DangKyThi dk = (DangKyThi) reg.get("dangKyThi");
                    daThanhToan = "Đã duyệt".equals(dk.getTrangThai()) || "Đã xác nhận".equals(dk.getTrangThai());
                }
                
                if ("daThanhToan".equals(thanhToanFilter) && !daThanhToan) {
                    include = false;
                } else if ("choThanhToan".equals(thanhToanFilter) && daThanhToan) {
                    include = false;
                }
            }
            
            // Search theo tên, email, mã đăng ký
            if (include && searchQuery != null && !searchQuery.trim().isEmpty()) {
                String searchLower = searchQuery.toLowerCase().trim();
                NguoiDung user = (NguoiDung) reg.get("nguoiDung");
                String maXacNhan = null;
                
                if ("lop".equals(reg.get("loai"))) {
                    DangKyLop dk = (DangKyLop) reg.get("dangKy");
                    maXacNhan = dk.getMaXacNhan();
                } else {
                    DangKyThi dk = (DangKyThi) reg.get("dangKyThi");
                    maXacNhan = dk.getMaXacNhan();
                }
                
                boolean matches = false;
                if (user != null) {
                    if (user.getHoTen() != null && user.getHoTen().toLowerCase().contains(searchLower)) {
                        matches = true;
                    }
                    if (user.getEmail() != null && user.getEmail().toLowerCase().contains(searchLower)) {
                        matches = true;
                    }
                    if (user.getSoDienThoai() != null && user.getSoDienThoai().contains(searchLower)) {
                        matches = true;
                    }
                }
                if (maXacNhan != null && maXacNhan.toLowerCase().contains(searchLower)) {
                    matches = true;
                }
                
                if (!matches) {
                    include = false;
                }
            }
            
            if (include) {
                filteredList.add(reg);
            }
        }
        
        registrationsWithDetails = filteredList;

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

        // Thống kê (bao gồm cả lớp ôn và ca thi)
        int totalRegistrations = allRegistrationsLop.size() + allRegistrationsThi.size();
        int choDuyetCount = 0;
        int daDuyetCount = 0;
        int daHuyCount = 0;
        long totalRevenue = 0;
        
        for (DangKyLop dk : allRegistrationsLop) {
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
        
        for (DangKyThi dk : allRegistrationsThi) {
            String trangThai = dk.getTrangThai();
            if (trangThai != null) {
                if (trangThai.contains("Chờ") || trangThai.contains("chờ")) {
                    choDuyetCount++;
                } else if (trangThai.contains("Đã") || trangThai.contains("đã")) {
                    if (trangThai.contains("Hủy") || trangThai.contains("hủy")) {
                        daHuyCount++;
                    } else {
                        daDuyetCount++;
                        // Chỉ tính doanh thu khi đã duyệt
                        if (trangThai.equals("Đã duyệt") || trangThai.equals("Đã xác nhận")) {
                            totalRevenue += dk.getSoTienPhaiTra();
                        }
                    }
                }
            }
        }

        req.setAttribute("totalRegistrations", totalRegistrations);
        req.setAttribute("choDuyetCount", choDuyetCount);
        req.setAttribute("daDuyetCount", daDuyetCount);
        req.setAttribute("daHuyCount", daHuyCount);
        req.setAttribute("totalRevenue", totalRevenue);
        
        // Lấy danh sách trạng thái unique để filter (từ cả lớp ôn và ca thi)
        Set<String> statusOptions = new LinkedHashSet<>();
        for (DangKyLop dk : allRegistrationsLop) {
            if (dk.getTrangThai() != null && !dk.getTrangThai().isEmpty()) {
                statusOptions.add(dk.getTrangThai());
            }
        }
        for (DangKyThi dk : allRegistrationsThi) {
            if (dk.getTrangThai() != null && !dk.getTrangThai().isEmpty()) {
                statusOptions.add(dk.getTrangThai());
            }
        }
        req.setAttribute("statusOptions", statusOptions);
        
        // Filter params để hiển thị lại trong form
        req.setAttribute("loaiFilter", loaiFilter != null ? loaiFilter : "all");
        req.setAttribute("trangThaiFilter", trangThaiFilter);
        req.setAttribute("searchQuery", searchQuery);
        req.setAttribute("fromDate", fromDate);
        req.setAttribute("toDate", toDate);
        req.setAttribute("thanhToanFilter", thanhToanFilter != null ? thanhToanFilter : "all");
        
        // Mốc cập nhật hiển thị trên trang
        req.setAttribute("lastUpdatedAt", new java.util.Date());
        } catch (Exception e) {
            // Xử lý lỗi và log
            java.util.logging.Logger.getLogger(AdminDispatcherServlet.class.getName())
                .log(java.util.logging.Level.SEVERE, "Lỗi khi chuẩn bị dữ liệu đăng ký", e);
            
            // Set giá trị mặc định để tránh lỗi JSP
            req.setAttribute("registrations", new java.util.ArrayList<>());
            req.setAttribute("totalRegistrations", 0);
            req.setAttribute("choDuyetCount", 0);
            req.setAttribute("daDuyetCount", 0);
            req.setAttribute("daHuyCount", 0);
            req.setAttribute("totalRevenue", 0);
            req.setAttribute("currentPage", 1);
            req.setAttribute("totalPages", 1);
            req.setAttribute("pageSize", 10);
            req.setAttribute("totalRecords", 0);
            req.setAttribute("startRecord", 0);
            req.setAttribute("endRecord", 0);
            req.setAttribute("statusOptions", new java.util.ArrayList<>());
            req.setAttribute("lastUpdatedAt", new java.util.Date());
        }
    }

    private void prepareExamsData(HttpServletRequest req) {
        if (caThiService == null) {
            caThiService = new CaThiServiceImpl();
        }
        if (dangKyThiService == null) {
            dangKyThiService = new DangKyThiServiceImpl();
        }

        // Lấy tất cả ca thi
        List<CaThi> allExams = caThiService.findAll();
        
        // Tạo danh sách với thông tin đầy đủ (bao gồm số lượng đăng ký)
        List<Map<String, Object>> examsWithDetails = new ArrayList<>();
        int totalRegistrations = 0;
        long totalRevenue = 0;
        java.util.Date now = new java.util.Date();
        
        for (CaThi caThi : allExams) {
            Map<String, Object> detail = new HashMap<>();
            detail.put("caThi", caThi);
            
            int count = dangKyThiService.countByCaThiId(caThi.getId());
            detail.put("soLuongDangKy", count);
            totalRegistrations += count;
            
            // Tính doanh thu từ đăng ký ca thi
            List<DangKyThi> registrations = dangKyThiService.findByCaThiId(caThi.getId());
            for (DangKyThi dk : registrations) {
                totalRevenue += dk.getSoTienPhaiTra();
            }
            
            // Xác định trạng thái ca thi
            boolean isFull = count >= caThi.getSucChua();
            boolean isAlmostFull = count > 0 && count >= caThi.getSucChua() * 0.8 && !isFull;
            boolean isPast = false;
            
            if (caThi.getNgayThi() != null && caThi.getGioKetThuc() != null) {
                java.util.Calendar examEndCal = java.util.Calendar.getInstance();
                examEndCal.setTime(caThi.getNgayThi());
                
                java.util.Calendar endTimeCal = java.util.Calendar.getInstance();
                endTimeCal.setTime(caThi.getGioKetThuc());
                
                examEndCal.set(java.util.Calendar.HOUR_OF_DAY, endTimeCal.get(java.util.Calendar.HOUR_OF_DAY));
                examEndCal.set(java.util.Calendar.MINUTE, endTimeCal.get(java.util.Calendar.MINUTE));
                examEndCal.set(java.util.Calendar.SECOND, endTimeCal.get(java.util.Calendar.SECOND));
                examEndCal.set(java.util.Calendar.MILLISECOND, 0);
                
                isPast = now.after(examEndCal.getTime());
            } else if (caThi.getNgayThi() != null) {
                java.util.Calendar examDateCal = java.util.Calendar.getInstance();
                examDateCal.setTime(caThi.getNgayThi());
                examDateCal.set(java.util.Calendar.HOUR_OF_DAY, 23);
                examDateCal.set(java.util.Calendar.MINUTE, 59);
                examDateCal.set(java.util.Calendar.SECOND, 59);
                examDateCal.set(java.util.Calendar.MILLISECOND, 999);
                
                isPast = now.after(examDateCal.getTime());
            }
            
            String status = isPast ? "Hoàn thành" : (isFull ? "Đã đầy" : (isAlmostFull ? "Gần đầy" : "Đang mở"));
            detail.put("trangThai", status);
            detail.put("isFull", isFull);
            detail.put("isPast", isPast);
            
            examsWithDetails.add(detail);
        }
        
        // Sắp xếp: mới nhất lên đầu (theo ngày thi, nếu cùng ngày thì theo ngày tạo)
        examsWithDetails.sort((a, b) -> {
            CaThi ca1 = (CaThi) a.get("caThi");
            CaThi ca2 = (CaThi) b.get("caThi");
            
            if (ca1.getNgayThi() != null && ca2.getNgayThi() != null) {
                int dateCompare = ca2.getNgayThi().compareTo(ca1.getNgayThi()); // DESC - mới nhất trước
                if (dateCompare != 0) {
                    return dateCompare;
                }
            } else if (ca1.getNgayThi() != null) {
                return -1;
            } else if (ca2.getNgayThi() != null) {
                return 1;
            }
            
            if (ca1.getNgayTao() != null && ca2.getNgayTao() != null) {
                return ca2.getNgayTao().compareTo(ca1.getNgayTao()); // DESC
            } else if (ca1.getNgayTao() != null) {
                return -1;
            } else if (ca2.getNgayTao() != null) {
                return 1;
            }
            
            return 0;
        });
        
        // Áp dụng filter
        String filterDate = req.getParameter("filterDate");
        String filterLocation = req.getParameter("filterLocation");
        String filterStatus = req.getParameter("filterStatus");
        String searchQuery = req.getParameter("search");
        
        List<Map<String, Object>> filteredList = new ArrayList<>();
        
        for (Map<String, Object> detail : examsWithDetails) {
            CaThi ct = (CaThi) detail.get("caThi");
            boolean include = true;
            
            // Filter theo ngày thi
            if (filterDate != null && !filterDate.isEmpty()) {
                if (ct.getNgayThi() == null) {
                    include = false;
                } else {
                    java.text.SimpleDateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd");
                    String examDateStr = df.format(ct.getNgayThi());
                    if (!examDateStr.equals(filterDate)) {
                        include = false;
                    }
                }
            }
            
            // Filter theo địa điểm
            if (include && filterLocation != null && !filterLocation.isEmpty()) {
                String diaDiem = ct.getDiaDiem() != null ? ct.getDiaDiem().toLowerCase() : "";
                if (!diaDiem.contains(filterLocation.toLowerCase())) {
                    include = false;
                }
            }
            
            // Filter theo trạng thái
            if (include && filterStatus != null && !filterStatus.isEmpty() && !"all".equals(filterStatus)) {
                String status = (String) detail.get("trangThai");
                if (!filterStatus.equalsIgnoreCase(status)) {
                    include = false;
                }
            }
            
            // Search query
            if (include && searchQuery != null && !searchQuery.isEmpty()) {
                String query = searchQuery.toLowerCase();
                String maCaThi = ct.getMaCaThi() != null ? ct.getMaCaThi().toLowerCase() : "";
                String diaDiem = ct.getDiaDiem() != null ? ct.getDiaDiem().toLowerCase() : "";
                
                if (!maCaThi.contains(query) && !diaDiem.contains(query)) {
                    include = false;
                }
            }
            
            if (include) {
                filteredList.add(detail);
            }
        }
        
        // Phân trang
        int pageSize = parsePageSize(req.getParameter("pageSize"));
        int currentPage = parsePageNumber(req.getParameter("page"));
        int totalRecords = filteredList.size();
        int totalPages = totalRecords > 0 ? (int) Math.ceil((double) totalRecords / pageSize) : 1;
        
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalRecords);
        List<Map<String, Object>> paginatedList = new ArrayList<>();
        if (startIndex < totalRecords) {
            paginatedList = filteredList.subList(startIndex, endIndex);
        }
        
        // Extract địa điểm duy nhất cho filter dropdown
        Set<String> locationOptions = new LinkedHashSet<>();
        for (CaThi ct : allExams) {
            if (ct.getDiaDiem() != null && !ct.getDiaDiem().trim().isEmpty()) {
                locationOptions.add(ct.getDiaDiem().trim());
            }
        }
        
        // Extract trạng thái duy nhất cho filter dropdown
        Set<String> statusOptions = new LinkedHashSet<>();
        statusOptions.add("Đang mở");
        statusOptions.add("Gần đầy");
        statusOptions.add("Đã đầy");
        statusOptions.add("Hoàn thành");

        req.setAttribute("examsWithDetails", paginatedList);
        req.setAttribute("totalExams", allExams.size());
        req.setAttribute("totalRegistrations", totalRegistrations);
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("lastUpdatedAt", new java.util.Date());
        
        // Filter params
        req.setAttribute("filterDate", filterDate);
        req.setAttribute("filterLocation", filterLocation);
        req.setAttribute("filterStatus", filterStatus != null ? filterStatus : "all");
        req.setAttribute("searchQuery", searchQuery);
        req.setAttribute("locationOptions", locationOptions);
        req.setAttribute("statusOptions", statusOptions);
        
        // Pagination info
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("startRecord", totalRecords > 0 ? startIndex + 1 : 0);
        req.setAttribute("endRecord", Math.min(endIndex, totalRecords));
    }

    private String deriveLopStatus(LopOn lop) {
        java.util.Date now = new java.util.Date();
        java.util.Date start = lop.getNgayKhaiGiang();
        java.util.Date end = lop.getNgayKetThuc();

        if (start != null && now.before(start)) {
            return "Chuẩn bị";
        }
        if (start != null && end != null) {
            boolean afterStart = !now.before(start);
            boolean beforeEnd = now.before(end) || now.equals(end);
            if (afterStart && beforeEnd) {
                return "Đang mở";
            }
        }
        if (end != null && now.after(end)) {
            return "Kết thúc";
        }
        // Fallback nếu thiếu dữ liệu ngày
        if (start == null && end == null) {
            return "Không xác định";
        }
        if (start != null && (end == null)) {
            return now.before(start) ? "Chuẩn bị" : "Đang mở";
        }
        return "Kết thúc";
    }

    private void handleRegistrationsPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        if (dangKyLopService == null) {
            dangKyLopService = new DangKyLopServiceImpl();
        }
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        if (nguoiDungService == null) {
            nguoiDungService = new NguoiDungServiceImpl();
        }

        String action = req.getParameter("action");
        if (action == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/registrations");
            return;
        }

        int success = 0;
        int total = 0;

        if ("approve".equals(action)) {
            String idStr = req.getParameter("id");
            total = 1;
            success = approveOne(idStr) ? 1 : 0;
        } else if ("approve-bulk".equals(action)) {
            String[] ids = req.getParameterValues("ids");
            if (ids != null && ids.length > 0) {
                total = ids.length;
                for (String idStr : ids) {
                    if (approveOne(idStr)) {
                        success++;
                    }
                }
            }
        }

        // Flash & redirect
        HttpSession session = req.getSession();
        session.setAttribute("classFlashType", success == total ? "success" : (success > 0 ? "warning" : "error"));
        if (total <= 1) {
            session.setAttribute("classFlashMessage", success == 1 ? "Duyệt đăng ký thành công." : "Duyệt đăng ký thất bại.");
        } else {
            session.setAttribute("classFlashMessage", "Duyệt hàng loạt: thành công " + success + "/" + total + " đăng ký.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/registrations");
    }

    private boolean approveOne(String idStr) {
        long id = parseLong(idStr);
        if (id <= 0) return false;

        DangKyLop dk = dangKyLopService.findById(id);
        if (dk == null) return false;

        // Cập nhật trạng thái
        dk.setTrangThai("Đã duyệt");
        // Không ghi đè thời gian đăng ký ban đầu

        // Nếu duyệt coi như đã thanh toán: cộng đủ học phí lớp
        LopOn lopForPayment = lopOnService.findById(dk.getLopOnId());
        if (lopForPayment != null) {
            long hocPhi = lopForPayment.getHocPhi();
            long currentPaid = dk.getSoTienDaTra();
            if (hocPhi > 0 && currentPaid < hocPhi) {
                dk.setSoTienDaTra(hocPhi);
            }
        }

        boolean updated = dangKyLopService.update(dk);
        if (!updated) return false;

        // Gửi email xác nhận
        NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
        LopOn lop = lopOnService.findById(dk.getLopOnId());
        if (user != null && user.getEmail() != null && !user.getEmail().isBlank()) {
            String scheduleText = lop != null ? buildScheduleText(lop) : "";
            Long totalFee = lop != null ? lop.getHocPhi() : null;
            String classCode = lop != null ? lop.getMaLop() : "";
            String classTitle = lop != null ? lop.getTieuDe() : "";
            com.vstep.util.EmailService.sendClassApprovalEmail(
                    user.getEmail(),
                    user.getHoTen(),
                    classTitle,
                    classCode,
                    scheduleText,
                    dk.getSoTienDaTra(),
                    totalFee,
                    dk.getMaXacNhan()
            );
        }
        return true;
    }

    private String buildScheduleText(LopOn lop) {
        StringBuilder sb = new StringBuilder();
        if (lop.getNgayKhaiGiang() != null) {
            sb.append("Khai giảng ").append(new java.text.SimpleDateFormat("dd/MM/yyyy").format(lop.getNgayKhaiGiang()));
        }
        if (lop.getThoiGianHoc() != null && !lop.getThoiGianHoc().isBlank()) {
            if (!sb.isEmpty()) sb.append(" · ");
            sb.append(lop.getThoiGianHoc());
        }
        if (lop.getHinhThuc() != null && !lop.getHinhThuc().isBlank()) {
            if (!sb.isEmpty()) sb.append(" · ");
            sb.append(lop.getHinhThuc());
        }
        return sb.toString();
    }
}


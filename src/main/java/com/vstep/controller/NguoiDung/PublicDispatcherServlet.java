package com.vstep.controller.NguoiDung;

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
import com.vstep.model.LopOn;
import com.vstep.service.CaThiService;
import com.vstep.service.DangKyThiService;
import com.vstep.service.LopOnService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.DangKyThiServiceImpl;
import com.vstep.serviceImpl.LopOnServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PublicDispatcherServlet", urlPatterns = {"", "/", "/public/*", "/lop", "/lop/*", "/ca", "/ca/*"})
public class PublicDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();
    private LopOnService lopOnService;
    private CaThiService caThiService;
    private DangKyThiService dangKyThiService;

    static {
        VIEW_MAP.put("", "/index.jsp");
        VIEW_MAP.put("/", "/index.jsp");
        VIEW_MAP.put("/index", "/index.jsp");
        VIEW_MAP.put("/lop", "/WEB-INF/views/public/lop-list.jsp");
        VIEW_MAP.put("/404", "/WEB-INF/views/public/404.jsp");
        VIEW_MAP.put("/lop/chi-tiet", "/WEB-INF/views/public/lop-detail.jsp");
        VIEW_MAP.put("/ca", "/WEB-INF/views/public/ca-list.jsp");
        VIEW_MAP.put("/ca/chi-tiet", "/WEB-INF/views/public/ca-detail.jsp");
        VIEW_MAP.put("/dang-ky-thanh-cong", "/WEB-INF/views/public/success.jsp");
    }

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
        caThiService = new CaThiServiceImpl();
        dangKyThiService = new DangKyThiServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Set encoding
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        
        String servletPath = req.getServletPath();
        String pathInfo = req.getPathInfo();

        String key;
        String slug = null;
        
        if ("/public".equals(servletPath)) {
            key = pathInfo == null ? "" : pathInfo;
        } else {
            // Xử lý route /lop/chi-tiet/{slug}
            if ("/lop".equals(servletPath) && pathInfo != null && pathInfo.startsWith("/chi-tiet/")) {
                key = "/lop/chi-tiet";
                // Extract slug từ pathInfo: "/chi-tiet/slug-value" -> "slug-value"
                slug = pathInfo.substring("/chi-tiet/".length());
            } else if ("/lop".equals(servletPath) && pathInfo != null && pathInfo.equals("/chi-tiet")) {
                // Fallback cho trường hợp /lop/chi-tiet (không có slug)
                key = "/lop/chi-tiet";
            } else if ("/ca".equals(servletPath) && pathInfo != null && pathInfo.startsWith("/chi-tiet")) {
                key = "/ca/chi-tiet";
            } else {
                key = servletPath.equals("/") ? "" : servletPath;
            }
        }

        String view = VIEW_MAP.get(key);
        if (view == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Load dữ liệu cho trang danh sách lớp
        if ("/lop".equals(key)) {
            prepareLopListData(req);
        }
        
        // Load dữ liệu cho trang danh sách ca thi
        if ("/ca".equals(key)) {
            prepareCaListData(req);
        }
        
        // Load dữ liệu cho trang chi tiết lớp
        if ("/lop/chi-tiet".equals(key)) {
            if (slug != null && !slug.isEmpty()) {
                prepareLopDetailData(req, slug);
            } else {
                // Nếu không có slug, thử lấy từ parameter (backward compatibility)
                String idParam = req.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    try {
                        long id = Long.parseLong(idParam);
                        LopOn lop = lopOnService.findById(id);
                        if (lop != null && lop.getSlug() != null) {
                            // Redirect đến URL với slug
                            resp.sendRedirect(req.getContextPath() + "/lop/chi-tiet/" + lop.getSlug());
                            return;
                        }
                    } catch (NumberFormatException e) {
                        // Ignore
                    }
                }
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }

        req.getRequestDispatcher(view).forward(req, resp);
    }

    private void prepareLopListData(HttpServletRequest req) {
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        com.vstep.service.DangKyLopService dangKyLopService = new com.vstep.serviceImpl.DangKyLopServiceImpl();
        
        List<LopOn> allClasses = new ArrayList<>();
        try {
            allClasses = lopOnService.findAll();
            if (allClasses == null) {
                allClasses = new ArrayList<>();
            }
        } catch (Exception e) {
            e.printStackTrace();
            allClasses = new ArrayList<>();
        }
        
        // Derive status by dates for all classes
        for (LopOn lop : allClasses) {
            try {
                String status = deriveLopStatus(lop);
                lop.setTinhTrang(status);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Áp dụng filter - xử lý trực tiếp giống như ca-list
        String keyword = req.getParameter("keyword");
        String format = req.getParameter("format");
        String pace = req.getParameter("pace");
        
        List<LopOn> filteredClasses = new ArrayList<>();
        
        for (LopOn lop : allClasses) {
            boolean include = true;
            
            // Filter theo keyword
            if (keyword != null && !keyword.isEmpty()) {
                String query = keyword.toLowerCase().trim();
                String tieuDe = lop.getTieuDe() != null ? lop.getTieuDe().toLowerCase() : "";
                String maLop = lop.getMaLop() != null ? lop.getMaLop().toLowerCase() : "";
                
                if (!tieuDe.contains(query) && !maLop.contains(query)) {
                    include = false;
                }
            }
            
            // Filter theo format
            if (include && format != null && !format.isEmpty()) {
                String hinhThuc = lop.getHinhThuc() != null ? lop.getHinhThuc().trim() : "";
                if (!hinhThuc.equalsIgnoreCase(format)) {
                    include = false;
                }
            }
            
            // Filter theo pace
            if (include && pace != null && !pace.isEmpty()) {
                String nhipDo = lop.getNhipDo() != null ? lop.getNhipDo().trim() : "";
                if (!nhipDo.equalsIgnoreCase(pace)) {
                    include = false;
                }
            }
            
            if (include) {
                filteredClasses.add(lop);
            }
        }

        // Phân trang
        int pageSize = parsePageSize(req.getParameter("pageSize"));
        int currentPage = parsePageNumber(req.getParameter("page"));
        int totalRecords = filteredClasses != null ? filteredClasses.size() : 0;
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
        if (filteredClasses != null && !filteredClasses.isEmpty() && startIndex >= 0 && startIndex < totalRecords) {
            try {
                paginatedClasses = filteredClasses.subList(startIndex, Math.min(endIndex, filteredClasses.size()));
            } catch (IndexOutOfBoundsException e) {
                e.printStackTrace();
                paginatedClasses = new ArrayList<>();
            } catch (Exception e) {
                e.printStackTrace();
                paginatedClasses = new ArrayList<>();
            }
        }

        req.setAttribute("lopOnList", paginatedClasses);

        // Đếm số người đăng ký hiện tại cho từng lớp trên trang
        java.util.Map<Long, Integer> registeredCounts = new java.util.HashMap<>();
        for (LopOn lop : paginatedClasses) {
            try {
                int count = dangKyLopService.countByLopOnId(lop.getId());
                registeredCounts.put(lop.getId(), count);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        req.setAttribute("registeredCounts", registeredCounts);
        
        // Set filter params cho JSP
        req.setAttribute("keyword", keyword);
        req.setAttribute("format", format);
        req.setAttribute("pace", pace);
        
        // Check if has active filters
        boolean hasActiveFilters = (keyword != null && !keyword.isEmpty()) ||
                                   (format != null && !format.isEmpty()) ||
                                   (pace != null && !pace.isEmpty());
        req.setAttribute("hasActiveFilters", hasActiveFilters);

        // Thông tin phân trang
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("startRecord", totalRecords > 0 ? startIndex + 1 : 0);
        req.setAttribute("endRecord", Math.min(endIndex, totalRecords));

        // Thống kê
        int dangMoCount = 0;
        int onlineCount = 0;
        int offlineCount = 0;
        for (LopOn lop : allClasses) {
            String status = lop.getTinhTrang() != null ? lop.getTinhTrang().trim() : "";
            String normalized = com.vstep.util.FilterUtils.normalizeForComparison(status);
            if ("đang mở".equalsIgnoreCase(status) || "dangmo".equals(normalized)) {
                dangMoCount++;
            }
            String formatValue = com.vstep.util.FilterUtils.normalizeForComparison(lop.getHinhThuc());
            if ("online".equals(formatValue)) {
                onlineCount++;
            } else if ("offline".equals(formatValue)) {
                offlineCount++;
            }
        }

        req.setAttribute("dangMoCount", dangMoCount);
        req.setAttribute("onlineCount", onlineCount);
        req.setAttribute("offlineCount", offlineCount);

        // Options cho filter dropdowns
        Set<String> formatOptions = extractDistinctOptions(allClasses, LopOn::getHinhThuc);
        Set<String> paceOptions = extractDistinctOptions(allClasses, LopOn::getNhipDo);
        req.setAttribute("formatOptions", formatOptions != null ? formatOptions : new LinkedHashSet<>());
        req.setAttribute("paceOptions", paceOptions != null ? paceOptions : new LinkedHashSet<>());
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
        if (start == null && end == null) {
            return "Không xác định";
        }
        if (start != null && end == null) {
            return now.before(start) ? "Chuẩn bị" : "Đang mở";
        }
        return "Kết thúc";
    }

    private void prepareLopDetailData(HttpServletRequest req, String slug) {
        if (lopOnService == null) {
            lopOnService = new LopOnServiceImpl();
        }
        
        LopOn lop = lopOnService.findBySlug(slug);
        if (lop == null) {
            req.setAttribute("notFound", true);
            return;
        }
        
        // Đếm số người đã đăng ký
        com.vstep.service.DangKyLopService dangKyLopService = new com.vstep.serviceImpl.DangKyLopServiceImpl();
        int soLuongDangKy = dangKyLopService.countByLopOnId(lop.getId());
        
        req.setAttribute("lop", lop);
        req.setAttribute("soLuongDangKy", soLuongDangKy);
        req.setAttribute("daDuCho", soLuongDangKy >= lop.getSiSoToiDa());
    }

    private Set<String> extractDistinctOptions(List<LopOn> source, Function<LopOn, String> extractor) {
        Map<String, String> normalizedToOriginal = new java.util.LinkedHashMap<>();
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
            return 6; // Mặc định 6 items mỗi trang cho public page
        }
        try {
            int size = Integer.parseInt(value.trim());
            // Giới hạn pageSize từ 6 đến 24
            if (size < 6) {
                return 6;
            } else if (size > 24) {
                return 24;
            }
            return size;
        } catch (NumberFormatException ex) {
            return 6;
        }
    }

    private void prepareCaListData(HttpServletRequest req) {
        if (caThiService == null) {
            caThiService = new CaThiServiceImpl();
        }
        if (dangKyThiService == null) {
            dangKyThiService = new DangKyThiServiceImpl();
        }

        // Lấy tất cả ca thi
        List<CaThi> allCaThi = caThiService.findAll();
        
        // Tính số lượng đăng ký cho mỗi ca thi và sắp xếp mới nhất lên đầu
        java.util.List<java.util.Map<String, Object>> caThiListWithDetails = new java.util.ArrayList<>();
        int totalRegistrations = 0;
        int totalAvailable = 0;
        java.util.Date now = new java.util.Date();
        
        for (CaThi ct : allCaThi) {
            java.util.Map<String, Object> detail = new java.util.HashMap<>();
            detail.put("caThi", ct);
            int count = dangKyThiService.countByCaThiId(ct.getId());
            detail.put("soLuongDangKy", count);
            int conCho = ct.getSucChua() - count;
            detail.put("conCho", conCho);
            detail.put("isFull", conCho <= 0);
            detail.put("isAlmostFull", conCho > 0 && conCho <= 5);
            
            // Xác định trạng thái
            boolean isUpcoming = ct.getNgayThi() != null && ct.getNgayThi().after(now);
            boolean isPast = ct.getNgayThi() != null && ct.getNgayThi().before(now);
            detail.put("isUpcoming", isUpcoming);
            detail.put("isPast", isPast);
            
            caThiListWithDetails.add(detail);
            
            totalRegistrations += count;
            if (conCho > 0) {
                totalAvailable += conCho;
            }
        }
        
        // Sắp xếp: mới nhất lên đầu (theo ngày thi, nếu cùng ngày thì theo ngày tạo)
        caThiListWithDetails.sort((a, b) -> {
            CaThi ca1 = (CaThi) a.get("caThi");
            CaThi ca2 = (CaThi) b.get("caThi");
            
            // Ưu tiên ngày thi
            if (ca1.getNgayThi() != null && ca2.getNgayThi() != null) {
                int dateCompare = ca2.getNgayThi().compareTo(ca1.getNgayThi()); // DESC - mới nhất trước
                if (dateCompare != 0) {
                    return dateCompare;
                }
            } else if (ca1.getNgayThi() != null) {
                return -1; // ca1 có ngày, ca2 không -> ca1 trước
            } else if (ca2.getNgayThi() != null) {
                return 1; // ca2 có ngày, ca1 không -> ca2 trước
            }
            
            // Nếu cùng ngày thi hoặc không có ngày thi, sắp xếp theo ngày tạo (mới nhất trước)
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
        String filterStatus = req.getParameter("filterStatus"); // "all", "available", "full", "almostFull"
        String filterLocation = req.getParameter("filterLocation");
        String searchQuery = req.getParameter("search");
        
        java.util.List<java.util.Map<String, Object>> filteredList = new java.util.ArrayList<>();
        
        for (java.util.Map<String, Object> detail : caThiListWithDetails) {
            CaThi ct = (CaThi) detail.get("caThi");
            boolean include = true;
            
            // Loại bỏ ca thi đã đầy
            boolean isFull = (Boolean) detail.get("isFull");
            if (isFull) {
                include = false;
            }
            
            // Loại bỏ ca thi đã hết thời gian (ngày thi + giờ kết thúc đã qua)
            if (include && ct.getNgayThi() != null && ct.getGioKetThuc() != null) {
                // Kết hợp ngày thi và giờ kết thúc để tạo thời điểm kết thúc ca thi
                java.util.Calendar examEndCal = java.util.Calendar.getInstance();
                examEndCal.setTime(ct.getNgayThi());
                
                java.util.Calendar endTimeCal = java.util.Calendar.getInstance();
                endTimeCal.setTime(ct.getGioKetThuc());
                
                examEndCal.set(java.util.Calendar.HOUR_OF_DAY, endTimeCal.get(java.util.Calendar.HOUR_OF_DAY));
                examEndCal.set(java.util.Calendar.MINUTE, endTimeCal.get(java.util.Calendar.MINUTE));
                examEndCal.set(java.util.Calendar.SECOND, endTimeCal.get(java.util.Calendar.SECOND));
                examEndCal.set(java.util.Calendar.MILLISECOND, 0);
                
                java.util.Date examEndTime = examEndCal.getTime();
                
                // Nếu thời gian kết thúc đã qua, loại bỏ ca thi này
                if (now.after(examEndTime)) {
                    include = false;
                }
            } else if (include && ct.getNgayThi() != null) {
                // Nếu chỉ có ngày thi mà không có giờ kết thúc, kiểm tra ngày thi
                // Nếu ngày thi đã qua (so sánh đến cuối ngày), loại bỏ
                java.util.Calendar examDateCal = java.util.Calendar.getInstance();
                examDateCal.setTime(ct.getNgayThi());
                examDateCal.set(java.util.Calendar.HOUR_OF_DAY, 23);
                examDateCal.set(java.util.Calendar.MINUTE, 59);
                examDateCal.set(java.util.Calendar.SECOND, 59);
                examDateCal.set(java.util.Calendar.MILLISECOND, 999);
                
                java.util.Date examEndOfDay = examDateCal.getTime();
                if (now.after(examEndOfDay)) {
                    include = false;
                }
            }
            
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
            
            // Filter theo trạng thái
            if (include && filterStatus != null && !filterStatus.isEmpty() && !"all".equals(filterStatus)) {
                boolean isAlmostFull = (Boolean) detail.get("isAlmostFull");
                
                if ("available".equals(filterStatus) && isFull) {
                    include = false;
                } else if ("full".equals(filterStatus) && !isFull) {
                    include = false;
                } else if ("almostFull".equals(filterStatus) && !isAlmostFull) {
                    include = false;
                }
            }
            
            // Filter theo địa điểm
            if (include && filterLocation != null && !filterLocation.isEmpty()) {
                String diaDiem = ct.getDiaDiem() != null ? ct.getDiaDiem().toLowerCase() : "";
                if (!diaDiem.contains(filterLocation.toLowerCase())) {
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
        
        // Đảm bảo currentPage hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        
        // Lấy dữ liệu cho trang hiện tại
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalRecords);
        java.util.List<java.util.Map<String, Object>> paginatedList = new java.util.ArrayList<>();
        if (startIndex < totalRecords) {
            paginatedList = filteredList.subList(startIndex, endIndex);
        }
        
        // Extract địa điểm duy nhất cho filter dropdown
        Set<String> locationOptions = extractDistinctLocations(allCaThi);

        req.setAttribute("caThiListWithDetails", paginatedList);
        req.setAttribute("totalExams", allCaThi.size());
        req.setAttribute("totalRegistrations", totalRegistrations);
        req.setAttribute("totalAvailable", totalAvailable);
        
        // Filter params
        req.setAttribute("filterDate", filterDate);
        req.setAttribute("filterStatus", filterStatus != null ? filterStatus : "all");
        req.setAttribute("filterLocation", filterLocation);
        req.setAttribute("searchQuery", searchQuery);
        req.setAttribute("locationOptions", locationOptions);
        
        // Pagination info
        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalRecords", totalRecords);
        req.setAttribute("startRecord", totalRecords > 0 ? startIndex + 1 : 0);
        req.setAttribute("endRecord", Math.min(endIndex, totalRecords));
    }
    
    private Set<String> extractDistinctLocations(List<CaThi> allCaThi) {
        Set<String> locations = new LinkedHashSet<>();
        for (CaThi ct : allCaThi) {
            if (ct.getDiaDiem() != null && !ct.getDiaDiem().trim().isEmpty()) {
                locations.add(ct.getDiaDiem().trim());
            }
        }
        return locations;
    }
}


package com.vstep.controller.NguoiDung;

import com.vstep.filter.ClassFilters;
import com.vstep.model.LopOn;
import com.vstep.service.LopOnService;
import com.vstep.serviceImpl.LopOnServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;

@WebServlet(name = "PublicDispatcherServlet", urlPatterns = {"", "/", "/public/*", "/lop", "/lop/*", "/ca", "/ca/*"})
public class PublicDispatcherServlet extends HttpServlet {

    private static final Map<String, String> VIEW_MAP = new HashMap<>();
    private LopOnService lopOnService;

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
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        List<LopOn> allClasses = lopOnService.findAll();

        // Áp dụng filter
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
        req.setAttribute("hasActiveFilters", filters.hasActive());

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
            String status = com.vstep.util.FilterUtils.normalizeForComparison(lop.getTinhTrang());
            if ("dangmo".equals(status)) {
                dangMoCount++;
            }
            String format = com.vstep.util.FilterUtils.normalizeForComparison(lop.getHinhThuc());
            if ("online".equals(format)) {
                onlineCount++;
            } else if ("offline".equals(format)) {
                offlineCount++;
            }
        }

        req.setAttribute("dangMoCount", dangMoCount);
        req.setAttribute("onlineCount", onlineCount);
        req.setAttribute("offlineCount", offlineCount);

        // Options cho filter dropdowns
        req.setAttribute("formatOptions", extractDistinctOptions(allClasses, LopOn::getHinhThuc));
        req.setAttribute("paceOptions", extractDistinctOptions(allClasses, LopOn::getNhipDo));
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
        
        req.setAttribute("lop", lop);
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
}


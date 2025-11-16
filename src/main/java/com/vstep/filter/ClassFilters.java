package com.vstep.filter;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import com.vstep.model.LopOn;
import com.vstep.util.FilterUtils;

import jakarta.servlet.http.HttpServletRequest;

/**
 * Filter class cho LopOn model.
 * Extends BaseFilter để tái sử dụng các phương thức chung.
 */
public class ClassFilters extends BaseFilter<LopOn> {
    
    private final String keyword;
    private final String keywordNormalized;
    private final String format;
    private final String formatNormalized;
    private final String pace;
    private final String paceNormalized;
    private final String status;
    private final String statusNormalized;
    private final LocalDate startFrom;
    private final LocalDate startTo;

    private ClassFilters(String keyword,
                        String format,
                        String pace,
                        String status,
                        LocalDate startFrom,
                        LocalDate startTo,
                        Map<String, String> paramSnapshot) {
        super(paramSnapshot);
        this.keyword = keyword;
        this.keywordNormalized = keyword != null ? normalizeForSearch(keyword) : null;
        this.format = format;
        this.formatNormalized = format != null ? normalizeForComparison(format) : null;
        this.pace = pace;
        this.paceNormalized = pace != null ? normalizeForComparison(pace) : null;
        this.status = status;
        this.statusNormalized = status != null ? normalizeForComparison(status) : null;
        this.startFrom = startFrom;
        this.startTo = startTo;
    }

    public static ClassFilters fromRequest(HttpServletRequest req) {
        String keyword = FilterUtils.trimToNull(req.getParameter("keyword"));
        String format = FilterUtils.trimToNull(req.getParameter("format"));
        String pace = FilterUtils.trimToNull(req.getParameter("pace"));
        String status = FilterUtils.trimToNull(req.getParameter("status"));
        LocalDate startFrom = FilterUtils.parseIsoDate(FilterUtils.trimToNull(req.getParameter("startFrom")));
        LocalDate startTo = FilterUtils.parseIsoDate(FilterUtils.trimToNull(req.getParameter("startTo")));

        Map<String, String> snapshot = new LinkedHashMap<>();
        snapshot.put("keyword", keyword);
        snapshot.put("format", format);
        snapshot.put("pace", pace);
        snapshot.put("status", status);
        snapshot.put("startFrom", startFrom != null ? startFrom.toString() : null);
        snapshot.put("startTo", startTo != null ? startTo.toString() : null);

        return new ClassFilters(keyword, format, pace, status, startFrom, startTo, snapshot);
    }

    @Override
    protected boolean matches(LopOn lop) {
        if (lop == null) {
            return false;
        }
        
        // Keyword search
        if (keywordNormalized != null) {
            boolean keywordMatched = false;
            if (lop.getTieuDe() != null) {
                keywordMatched = normalizeForSearch(lop.getTieuDe()).contains(keywordNormalized);
            }
            if (!keywordMatched && lop.getMaLop() != null) {
                keywordMatched = normalizeForSearch(lop.getMaLop()).contains(keywordNormalized);
            }
            if (!keywordMatched) {
                return false;
            }
        }
        
        // Format filter
        if (formatNormalized != null) {
            String value = normalizeForComparison(lop.getHinhThuc());
            if (!formatNormalized.equals(value)) {
                return false;
            }
        }
        
        // Pace filter
        if (paceNormalized != null) {
            String value = normalizeForComparison(lop.getNhipDo());
            if (!paceNormalized.equals(value)) {
                return false;
            }
        }
        
        // Status filter
        if (statusNormalized != null) {
            String value = normalizeForComparison(lop.getTinhTrang());
            if (!statusNormalized.equals(value)) {
                return false;
            }
        }
        
        // Date range filter
        if (startFrom != null || startTo != null) {
            LocalDate classStart = null;
            if (lop.getNgayKhaiGiang() != null) {
                classStart = lop.getNgayKhaiGiang().toLocalDate();
            }
            if (startFrom != null) {
                if (classStart == null || classStart.isBefore(startFrom)) {
                    return false;
                }
            }
            if (startTo != null) {
                if (classStart == null || classStart.isAfter(startTo)) {
                    return false;
                }
            }
        }
        
        return true;
    }

    @Override
    protected Map<String, String> getLabelMap() {
        Map<String, String> labels = new HashMap<>();
        labels.put("keyword", "Từ khóa");
        labels.put("format", "Hình thức");
        labels.put("pace", "Nhịp độ");
        labels.put("status", "Tình trạng");
        labels.put("startFrom", "Khai giảng từ");
        labels.put("startTo", "Khai giảng đến");
        return labels;
    }

    @Override
    protected Map<String, FilterValueFormatter> getFormatters() {
        Map<String, FilterValueFormatter> formatters = new HashMap<>();
        formatters.put("startFrom", value -> {
            LocalDate date = FilterUtils.parseIsoDate(value);
            return date != null ? FilterUtils.formatDisplayDate(date) : value;
        });
        formatters.put("startTo", value -> {
            LocalDate date = FilterUtils.parseIsoDate(value);
            return date != null ? FilterUtils.formatDisplayDate(date) : value;
        });
        return formatters;
    }

    // Getters cho các filter parameters
    public String getKeyword() {
        return keyword;
    }

    public String getFormat() {
        return format;
    }

    public String getPace() {
        return pace;
    }

    public String getStatus() {
        return status;
    }

    public String getStartFrom() {
        return startFrom != null ? startFrom.toString() : null;
    }

    public String getStartTo() {
        return startTo != null ? startTo.toString() : null;
    }
}


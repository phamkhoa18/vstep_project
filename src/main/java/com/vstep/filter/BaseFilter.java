package com.vstep.filter;

import com.vstep.util.FilterUtils;
import jakarta.servlet.http.HttpServletRequest;

import java.time.LocalDate;
import java.util.*;

/**
 * Abstract base class cho tất cả các filter.
 * Cung cấp các phương thức chung cho filtering và pagination.
 * 
 * @param <T> Loại model cần filter (ví dụ: LopOn, NguoiDung, CaThi...)
 */
public abstract class BaseFilter<T> {
    
    protected final Map<String, String> paramSnapshot;

    protected BaseFilter(Map<String, String> paramSnapshot) {
        this.paramSnapshot = paramSnapshot != null 
            ? new LinkedHashMap<>(paramSnapshot) 
            : new LinkedHashMap<>();
    }

    /**
     * Factory method để tạo filter từ HttpServletRequest
     */
    public static <T> BaseFilter<T> fromRequest(HttpServletRequest req, Class<T> modelClass) {
        throw new UnsupportedOperationException("Subclass must implement fromRequest");
    }

    /**
     * Apply filter lên danh sách items
     */
    public List<T> apply(List<T> source) {
        if (source == null || source.isEmpty()) {
            return source == null ? Collections.emptyList() : new ArrayList<>(source);
        }
        List<T> result = new ArrayList<>();
        for (T item : source) {
            if (matches(item)) {
                result.add(item);
            }
        }
        return result;
    }

    /**
     * Kiểm tra một item có match với filter không.
     * Subclass phải implement method này.
     */
    protected abstract boolean matches(T item);

    /**
     * Kiểm tra có filter nào đang active không
     */
    public boolean hasActive() {
        return paramSnapshot.values().stream()
            .anyMatch(value -> value != null && !value.isBlank());
    }

    /**
     * Lấy parameter snapshot (để build URL)
     */
    public Map<String, String> getParamSnapshot() {
        return new LinkedHashMap<>(paramSnapshot);
    }

    /**
     * Build query string với pagination
     */
    public String buildQueryString(int page, Integer pageSize) {
        return FilterUtils.buildQueryStringWithPagination(paramSnapshot, page, pageSize);
    }

    /**
     * Build query string loại trừ một parameter
     */
    public String buildQueryStringExcluding(String excludeKey) {
        return FilterUtils.buildQueryStringExcluding(paramSnapshot, excludeKey);
    }

    /**
     * Tạo danh sách FilterChip để hiển thị trong UI.
     * Subclass có thể override để customize labels và formatting.
     */
    public List<FilterChip> toChips(String basePath) {
        List<FilterChip> chips = new ArrayList<>();
        Map<String, String> labelMap = getLabelMap();
        Map<String, FilterValueFormatter> formatters = getFormatters();

        for (Map.Entry<String, String> entry : paramSnapshot.entrySet()) {
            String param = entry.getKey();
            String value = entry.getValue();
            if (value == null || value.isBlank()) {
                continue;
            }

            String label = labelMap.getOrDefault(param, param);
            FilterValueFormatter formatter = formatters.get(param);
            String displayValue = formatter != null 
                ? formatter.format(value) 
                : value;

            String removeQuery = buildQueryStringExcluding(param);
            String removeUrl = basePath + (removeQuery.isEmpty() ? "" : "?" + removeQuery);
            chips.add(new FilterChip(label, displayValue, removeUrl));
        }
        return chips;
    }

    /**
     * Map parameter names sang display labels (tiếng Việt).
     * Subclass phải override để cung cấp labels.
     */
    protected abstract Map<String, String> getLabelMap();

    /**
     * Map parameter names sang formatters (để format date, number...).
     * Subclass có thể override, mặc định trả về empty map.
     */
    protected Map<String, FilterValueFormatter> getFormatters() {
        return Collections.emptyMap();
    }

    /**
     * Interface để format giá trị filter
     */
    @FunctionalInterface
    public interface FilterValueFormatter {
        String format(String value);
    }

    // Helper methods từ FilterUtils
    protected String normalizeForComparison(String value) {
        return FilterUtils.normalizeForComparison(value);
    }

    protected String normalizeForSearch(String value) {
        return FilterUtils.normalizeForSearch(value);
    }

    protected String trimToNull(String value) {
        return FilterUtils.trimToNull(value);
    }

    protected LocalDate parseIsoDate(String value) {
        return FilterUtils.parseIsoDate(value);
    }
}


package com.vstep.util;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Utility class chứa các phương thức hỗ trợ cho filtering và pagination.
 * Có thể tái sử dụng cho tất cả các model.
 */
public class FilterUtils {

    private static final DateTimeFormatter DISPLAY_DATE = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    /**
     * Normalize string để so sánh (bỏ dấu, lowercase, remove spaces)
     */
    public static String normalizeForComparison(String value) {
        if (value == null || value.isBlank()) {
            return "";
        }
        try {
            String trimmed = value.trim();
            if (trimmed.isEmpty()) {
                return "";
            }
            String normalized = java.text.Normalizer.normalize(trimmed, java.text.Normalizer.Form.NFD)
                    .replaceAll("\\p{M}+", "")
                    .toLowerCase();
            return normalized.replaceAll("[\\s_\\-]+", "");
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * Normalize string để search (bỏ dấu, lowercase, giữ spaces)
     */
    public static String normalizeForSearch(String value) {
        if (value == null || value.isBlank()) {
            return "";
        }
        try {
            String normalized = java.text.Normalizer.normalize(value, java.text.Normalizer.Form.NFD)
                    .replaceAll("\\p{M}+", "")
                    .toLowerCase();
            return normalized.replaceAll("\\s+", " ").trim();
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * Trim string và trả về null nếu empty
     */
    public static String trimToNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }

    /**
     * Parse ISO date string (yyyy-MM-dd) thành LocalDate
     */
    public static LocalDate parseIsoDate(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return LocalDate.parse(value);
        } catch (DateTimeParseException ex) {
            return null;
        }
    }

    /**
     * Format LocalDate thành display string (dd/MM/yyyy)
     */
    public static String formatDisplayDate(LocalDate date) {
        if (date == null) {
            return null;
        }
        return DISPLAY_DATE.format(date);
    }

    /**
     * Build query string từ map parameters, loại trừ một key
     */
    public static String buildQueryStringExcluding(Map<String, String> source, String excludeKey) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> entry : source.entrySet()) {
            String key = entry.getKey();
            if (key.equals(excludeKey)) {
                continue;
            }
            String value = entry.getValue();
            if (value == null || value.isBlank()) {
                continue;
            }
            if (sb.length() > 0) {
                sb.append('&');
            }
            sb.append(URLEncoder.encode(key, StandardCharsets.UTF_8))
                    .append('=')
                    .append(URLEncoder.encode(value, StandardCharsets.UTF_8));
        }
        return sb.toString();
    }

    /**
     * Build query string từ map parameters
     */
    public static String buildQueryString(Map<String, String> params) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            if (value == null || value.isBlank()) {
                continue;
            }
            if (sb.length() > 0) {
                sb.append('&');
            }
            sb.append(URLEncoder.encode(key, StandardCharsets.UTF_8))
                    .append('=')
                    .append(URLEncoder.encode(value, StandardCharsets.UTF_8));
        }
        return sb.toString();
    }

    /**
     * Build query string từ map parameters + page + pageSize
     */
    public static String buildQueryStringWithPagination(Map<String, String> params, int page, Integer pageSize) {
        Map<String, String> combined = new LinkedHashMap<>(params);
        combined.put("page", String.valueOf(page));
        if (pageSize != null && pageSize > 0) {
            combined.put("pageSize", String.valueOf(pageSize));
        }
        return buildQueryString(combined);
    }
}


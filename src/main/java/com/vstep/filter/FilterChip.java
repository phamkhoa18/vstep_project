package com.vstep.filter;

/**
 * Class đại diện cho một filter chip trong UI.
 * Có thể tái sử dụng cho tất cả các model.
 */
public class FilterChip {
    private final String label;
    private final String value;
    private final String removeUrl;

    public FilterChip(String label, String value, String removeUrl) {
        this.label = label;
        this.value = value;
        this.removeUrl = removeUrl;
    }

    public String getLabel() {
        return label;
    }

    public String getValue() {
        return value;
    }

    public String getRemoveUrl() {
        return removeUrl;
    }
}


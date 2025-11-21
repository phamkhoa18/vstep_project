<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tổng quan hệ thống | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.44.0/dist/apexcharts.min.js"></script>
</head>
<body data-page="dashboard" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-8 pb-16">
            <!-- Header Section -->
            <section class="space-y-4">
                <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                    <div>
                        <h1 class="text-3xl font-bold text-slate-900 tracking-tight">Tổng quan hệ thống</h1>
                        <p class="text-sm text-slate-500 mt-1">Theo dõi tức thời hoạt động lớp ôn, ca thi và doanh thu</p>
                    </div>
                    <div class="flex flex-wrap items-center gap-3">
                        <a href="<%= request.getContextPath() %>/admin/export-dashboard?period=${period}" 
                           class="inline-flex items-center gap-2 rounded-xl border border-blue-200 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/60 hover:bg-primary/5 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5M16.5 12L12 16.5m0 0L7.5 12m4.5 4.5V3"/>
                            </svg>
                            Xuất báo cáo Excel
                        </a>
                        <div class="inline-flex items-center gap-2 rounded-xl border border-blue-200 bg-white px-4 py-2.5 text-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5"/>
                            </svg>
                            <select id="periodFilter" onchange="window.location.href='?period=' + this.value" 
                                    class="border-none bg-transparent text-sm font-semibold text-slate-700 focus:outline-none cursor-pointer">
                                <option value="today" ${period == 'today' ? 'selected' : ''}>Hôm nay</option>
                                <option value="week" ${period == 'week' ? 'selected' : ''}>7 ngày qua</option>
                                <option value="month" ${period == 'month' ? 'selected' : ''}>Tháng này</option>
                                <option value="all" ${period == 'all' ? 'selected' : ''}>Tất cả</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="flex flex-wrap gap-2 text-xs">
                    <span class="inline-flex items-center gap-2 rounded-full bg-blue-50 px-3 py-1.5 text-blue-700 font-medium border border-blue-100">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Cập nhật lúc <fmt:formatDate value="<%= new java.util.Date() %>" pattern="HH:mm" /> · 
                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy" />
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-emerald-50 px-3 py-1.5 text-emerald-600 font-medium border border-emerald-100">
                        <span class="h-2 w-2 rounded-full bg-emerald-500 animate-pulse"></span>
                        Hệ thống hoạt động ổn định
                    </span>
                </div>
            </section>

            <!-- Key Metrics Cards -->
            <section class="grid gap-5 md:grid-cols-2 xl:grid-cols-4">
                <!-- Total Students Card -->
                <div class="group rounded-2xl bg-gradient-to-br from-blue-50 to-blue-100/50 border border-blue-200/60 p-6 shadow-sm hover:shadow-md transition">
                    <div class="flex items-center justify-between mb-4">
                        <div class="h-12 w-12 rounded-xl bg-blue-500 flex items-center justify-center shadow-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z"/>
                            </svg>
                        </div>
                        <span class="text-xs font-semibold text-blue-600/70 uppercase tracking-wide">Học viên</span>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-bold text-slate-900"><fmt:formatNumber value="${totalStudents}" /></p>
                        <p class="text-xs text-slate-600">
                            <c:choose>
                                <c:when test="${totalClasses > 0}">
                                    ${totalClasses} lớp · ${activeClasses} đang hoạt động
                                </c:when>
                                <c:otherwise>Chưa có dữ liệu</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>

                <!-- Revenue Card -->
                <div class="group rounded-2xl bg-gradient-to-br from-emerald-50 to-emerald-100/50 border border-emerald-200/60 p-6 shadow-sm hover:shadow-md transition">
                    <div class="flex items-center justify-between mb-4">
                        <div class="h-12 w-12 rounded-xl bg-emerald-500 flex items-center justify-center shadow-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m-3-2.818l.879.659c1.171.879 3.07.879 4.242 0 1.172-.879 1.172-2.303 0-3.182C13.536 12.219 12.768 12 12 12c-.725 0-1.45-.22-2.003-.659-1.106-.879-1.106-2.303 0-3.182s2.9-.879 4.006 0l.415.33M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <span class="text-xs font-semibold text-emerald-600/70 uppercase tracking-wide">Doanh thu</span>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-bold text-slate-900">
                            <c:choose>
                                <c:when test="${totalRevenue >= 1000000}">
                                    <fmt:formatNumber value="${totalRevenue / 1000000}" maxFractionDigits="1" /> triệu
                                </c:when>
                                <c:when test="${totalRevenue >= 1000}">
                                    <fmt:formatNumber value="${totalRevenue / 1000}" maxFractionDigits="0" />k
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${totalRevenue}" />
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-xs text-slate-600">
                            Lớp: <fmt:formatNumber value="${classRevenue / 1000000}" maxFractionDigits="1" /> triệu · 
                            Ca thi: <fmt:formatNumber value="${examRevenue / 1000000}" maxFractionDigits="1" /> triệu
                        </p>
                    </div>
                </div>

                <!-- Upcoming Exams Card -->
                <div class="group rounded-2xl bg-gradient-to-br from-orange-50 to-orange-100/50 border border-orange-200/60 p-6 shadow-sm hover:shadow-md transition">
                    <div class="flex items-center justify-between mb-4">
                        <div class="h-12 w-12 rounded-xl bg-orange-500 flex items-center justify-center shadow-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75m-18 0v-7.5A2.25 2.25 0 015.25 9h13.5A2.25 2.25 0 0121 11.25v7.5"/>
                            </svg>
                        </div>
                        <span class="text-xs font-semibold text-orange-600/70 uppercase tracking-wide">Ca thi</span>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-bold text-slate-900">${upcomingExams}</p>
                        <p class="text-xs text-slate-600">
                            Tổng ${totalExams} ca thi · ${totalExamRegistrations} thí sinh đã đăng ký
                        </p>
                    </div>
                </div>

                <!-- Completion Rate Card -->
                <div class="group rounded-2xl bg-gradient-to-br from-purple-50 to-purple-100/50 border border-purple-200/60 p-6 shadow-sm hover:shadow-md transition">
                    <div class="flex items-center justify-between mb-4">
                        <div class="h-12 w-12 rounded-xl bg-purple-500 flex items-center justify-center shadow-sm">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                        <span class="text-xs font-semibold text-purple-600/70 uppercase tracking-wide">Hoàn thành</span>
                    </div>
                    <div class="space-y-1">
                        <p class="text-3xl font-bold text-slate-900">
                            <c:choose>
                                <c:when test="${totalClasses > 0}">
                                    <fmt:formatNumber value="${(activeClasses * 100.0) / totalClasses}" maxFractionDigits="0" />%
                                </c:when>
                                <c:otherwise>0%</c:otherwise>
                            </c:choose>
                        </p>
                        <p class="text-xs text-slate-600">
                            ${activeClasses}/${totalClasses} lớp đang hoạt động
                        </p>
                    </div>
                </div>
            </section>

            <!-- Charts Section -->
            <section class="grid gap-6 xl:grid-cols-3">
                <!-- Registration Trend Chart -->
                <div class="xl:col-span-2 rounded-2xl bg-white border border-blue-100/80 p-6 shadow-sm">
                    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 mb-6">
                        <div>
                            <h3 class="text-lg font-bold text-slate-900">Xu hướng đăng ký</h3>
                            <p class="text-xs text-slate-500 mt-1">
                                <c:choose>
                                    <c:when test="${period == 'today'}">Dữ liệu hôm nay</c:when>
                                    <c:when test="${period == 'week'}">Dữ liệu 7 ngày qua</c:when>
                                    <c:when test="${period == 'month'}">Dữ liệu tháng này</c:when>
                                    <c:otherwise>Dữ liệu 12 tuần gần nhất</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div class="flex items-center gap-2">
                            <div class="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-blue-50">
                                <span class="h-2 w-2 rounded-full bg-blue-500"></span>
                                <span class="text-xs font-medium text-slate-700">Lớp ôn</span>
                            </div>
                            <div class="flex items-center gap-2 px-3 py-1.5 rounded-lg bg-emerald-50">
                                <span class="h-2 w-2 rounded-full bg-emerald-500"></span>
                                <span class="text-xs font-medium text-slate-700">Ca thi</span>
                            </div>
                        </div>
                    </div>
                    <div class="h-80">
                        <div id="registrationChart"></div>
                    </div>
                </div>

                <!-- Fill Rate Chart -->
                <div class="rounded-2xl bg-white border border-blue-100/80 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <h3 class="text-lg font-bold text-slate-900">Tỉ lệ lấp đầy lớp</h3>
                            <p class="text-xs text-slate-500 mt-1">Theo danh mục</p>
                        </div>
                    </div>
                    <div class="h-64 mb-4">
                        <div id="fillRateChart"></div>
                    </div>
                    <div class="space-y-2">
                        <c:forEach var="item" items="${classFillRateData}">
                            <div class="flex items-center justify-between p-2 rounded-lg hover:bg-slate-50 transition">
                                <div class="flex items-center gap-2">
                                    <c:set var="categoryColor" value="#ec4899" />
                                    <c:if test="${item.category == 'Cơ bản'}"><c:set var="categoryColor" value="#3b82f6" /></c:if>
                                    <c:if test="${item.category == 'Nâng cao'}"><c:set var="categoryColor" value="#10b981" /></c:if>
                                    <c:if test="${item.category == 'Cấp tốc'}"><c:set var="categoryColor" value="#f97316" /></c:if>
                                    <c:if test="${item.category == 'Online'}"><c:set var="categoryColor" value="#8b5cf6" /></c:if>
                                    <span class="h-3 w-3 rounded-full" style="background-color: ${categoryColor}"></span>
                                    <span class="text-sm font-medium text-slate-700">${item.category}</span>
                                </div>
                                <div class="text-right">
                                    <span class="text-sm font-bold text-slate-900"><fmt:formatNumber value="${item.rate}" maxFractionDigits="0" />%</span>
                                    <p class="text-xs text-slate-500">${item.count}/${item.total}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- Revenue Chart -->
            <section class="rounded-2xl bg-white border border-blue-100/80 p-6 shadow-sm">
                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4 mb-6">
                    <div>
                        <h3 class="text-lg font-bold text-slate-900">Doanh thu theo ngày</h3>
                        <p class="text-xs text-slate-500 mt-1">
                            <c:choose>
                                <c:when test="${period == 'today'}">Dữ liệu hôm nay</c:when>
                                <c:when test="${period == 'week'}">Dữ liệu 7 ngày qua</c:when>
                                <c:when test="${period == 'month'}">Dữ liệu tháng này</c:when>
                                <c:otherwise>Dữ liệu 30 ngày gần nhất</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
                <div class="h-80">
                    <div id="revenueChart"></div>
                </div>
            </section>

            <!-- Tables Section -->
            <section class="grid gap-6 xl:grid-cols-2">
                <!-- Classes Table -->
                <div class="rounded-2xl bg-white border border-blue-100/80 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <h3 class="text-lg font-bold text-slate-900">Thống kê lớp ôn</h3>
                            <p class="text-xs text-slate-500 mt-1">Tổng ${totalClasses} lớp</p>
                        </div>
                        <a href="<%= request.getContextPath() %>/admin/classes" class="text-sm font-semibold text-primary hover:text-primary/80 transition">
                            Xem tất cả →
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead>
                                <tr class="border-b border-blue-100">
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Lớp</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Sĩ số</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Tỉ lệ</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-blue-50">
                                <c:forEach var="stat" items="${classStats}" begin="0" end="4">
                                    <tr class="hover:bg-blue-50/50 transition">
                                        <td class="py-3 px-4">
                                            <div>
                                                <p class="font-semibold text-slate-900">${stat.tieuDe}</p>
                                                <p class="text-xs text-slate-500">${stat.maLop}</p>
                                            </div>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <span class="font-medium text-slate-700">${stat.soLuongDangKy}/${stat.siSoToiDa}</span>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <div class="inline-flex items-center gap-2">
                                                <c:set var="fillRatePercent" value="${stat.fillRate}" />
                                                <fmt:formatNumber var="fillRatePercentFormatted" value="${fillRatePercent}" maxFractionDigits="0" />
                                                <div class="h-2 w-16 rounded-full bg-slate-200 overflow-hidden">
                                                    <div class="h-full bg-blue-500" style="width: ${fillRatePercentFormatted}%"></div>
                                                </div>
                                                <span class="text-xs font-medium text-slate-600"><fmt:formatNumber value="${stat.fillRate}" maxFractionDigits="0" />%</span>
                                            </div>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <c:choose>
                                                <c:when test="${stat.tinhTrang != null && (stat.tinhTrang.contains('Đang') || stat.tinhTrang.contains('Hoạt động'))}">
                                                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-semibold text-emerald-700">
                                                        <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
                                                        Đang hoạt động
                                                    </span>
                                                </c:when>
                                                <c:when test="${stat.tinhTrang != null && stat.tinhTrang.contains('Sắp')}">
                                                    <span class="inline-flex items-center gap-1 rounded-full bg-blue-100 px-2.5 py-1 text-xs font-semibold text-blue-700">
                                                        <span class="h-1.5 w-1.5 rounded-full bg-blue-500"></span>
                                                        Sắp khai giảng
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center gap-1 rounded-full bg-slate-100 px-2.5 py-1 text-xs font-semibold text-slate-600">
                                                        <span class="h-1.5 w-1.5 rounded-full bg-slate-400"></span>
                                                        ${stat.tinhTrang != null ? stat.tinhTrang : 'N/A'}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty classStats || classStats.size() == 0}">
                                    <tr>
                                        <td colspan="4" class="py-8 text-center text-slate-500">Chưa có dữ liệu lớp ôn</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Exams Table -->
                <div class="rounded-2xl bg-white border border-blue-100/80 p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-6">
                        <div>
                            <h3 class="text-lg font-bold text-slate-900">Thống kê ca thi</h3>
                            <p class="text-xs text-slate-500 mt-1">Tổng ${totalExams} ca thi</p>
                        </div>
                        <a href="<%= request.getContextPath() %>/admin/exams" class="text-sm font-semibold text-primary hover:text-primary/80 transition">
                            Xem tất cả →
                        </a>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm">
                            <thead>
                                <tr class="border-b border-blue-100">
                                    <th class="text-left py-3 px-4 font-semibold text-slate-700">Ca thi</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Thí sinh</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Tỉ lệ</th>
                                    <th class="text-center py-3 px-4 font-semibold text-slate-700">Còn lại</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-blue-50">
                                <c:forEach var="stat" items="${examStats}" begin="0" end="4">
                                    <tr class="hover:bg-blue-50/50 transition">
                                        <td class="py-3 px-4">
                                            <div>
                                                <p class="font-semibold text-slate-900">${stat.maCaThi}</p>
                                                <p class="text-xs text-slate-500">
                                                    <c:if test="${stat.ngayThi != null}">
                                                        <fmt:formatDate value="${stat.ngayThi}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                </p>
                                            </div>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <span class="font-medium text-slate-700">${stat.soLuongDangKy}/${stat.sucChua}</span>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <div class="inline-flex items-center gap-2">
                                                <c:set var="examFillRatePercent" value="${stat.fillRate}" />
                                                <fmt:formatNumber var="examFillRatePercentFormatted" value="${examFillRatePercent}" maxFractionDigits="0" />
                                                <div class="h-2 w-16 rounded-full bg-slate-200 overflow-hidden">
                                                    <div class="h-full bg-emerald-500" style="width: ${examFillRatePercentFormatted}%"></div>
                                                </div>
                                                <span class="text-xs font-medium text-slate-600"><fmt:formatNumber value="${stat.fillRate}" maxFractionDigits="0" />%</span>
                                            </div>
                                        </td>
                                        <td class="py-3 px-4 text-center">
                                            <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2.5 py-1 text-xs font-semibold text-orange-700">
                                                ${stat.choCon} chỗ
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty examStats || examStats.size() == 0}">
                                    <tr>
                                        <td colspan="4" class="py-8 text-center text-slate-500">Chưa có dữ liệu ca thi</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Kiểm tra ApexCharts đã load chưa
    if (typeof ApexCharts === 'undefined') {
        console.error('ApexCharts is not loaded!');
        return;
    }
    
    // ========== BIỂU ĐỒ XU HƯỚNG ĐĂNG KÝ ==========
    const weeklyData = [
        <c:choose>
        <c:when test="${not empty weeklyData}">
        <c:forEach var="week" items="${weeklyData}" varStatus="status">
        <c:set var="classRegs" value="${week.classRegistrations != null ? week.classRegistrations : 0}" />
        <c:set var="examRegs" value="${week.examRegistrations != null ? week.examRegistrations : 0}" />
        {
            label: "<c:out value="${week.label}" escapeXml="false" />",
            classRegs: <c:out value="${classRegs}" />,
            examRegs: <c:out value="${examRegs}" />
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
        </c:when>
        <c:otherwise>[]</c:otherwise>
        </c:choose>
    ];
    
    console.log('Weekly data:', weeklyData);
    
    const regChartEl = document.getElementById('registrationChart');
    if (regChartEl && typeof ApexCharts !== 'undefined') {
        const labels = weeklyData.length > 0 ? weeklyData.map(d => d.label) : ['Chưa có dữ liệu'];
        const classData = weeklyData.length > 0 ? weeklyData.map(d => d.classRegs) : [0];
        const examData = weeklyData.length > 0 ? weeklyData.map(d => d.examRegs) : [0];
        
        try {
            const registrationChart = new ApexCharts(regChartEl, {
                chart: {
                    type: 'line',
                    height: 320,
                    toolbar: { show: false },
                    zoom: { enabled: false }
                },
                series: [
                    {
                        name: 'Đăng ký lớp ôn',
                        data: classData
                    },
                    {
                        name: 'Đăng ký ca thi',
                        data: examData
                    }
                ],
                colors: ['#3b82f6', '#10b981'],
                stroke: {
                    curve: 'smooth',
                    width: 2
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shadeIntensity: 1,
                        opacityFrom: 0.7,
                        opacityTo: 0.3,
                        stops: [0, 90, 100]
                    }
                },
                markers: {
                    size: 4,
                    hover: {
                        size: 6
                    }
                },
                xaxis: {
                    categories: labels,
                    labels: {
                        style: {
                            colors: '#64748b',
                            fontSize: '12px'
                        }
                    }
                },
                yaxis: {
                    labels: {
                        style: {
                            colors: '#64748b',
                            fontSize: '12px'
                        }
                    },
                    forceNiceScale: true
                },
                grid: {
                    borderColor: '#e2e8f0',
                    strokeDashArray: 3,
                    xaxis: {
                        lines: {
                            show: false
                        }
                    }
                },
                legend: {
                    show: false
                },
                tooltip: {
                    theme: 'light',
                    style: {
                        fontSize: '12px'
                    }
                }
            });
            registrationChart.render();
        } catch (error) {
            console.error('Error creating registration chart:', error);
        }
    } else {
        console.warn('Registration chart element not found or ApexCharts not loaded');
    }
    
    // ========== BIỂU ĐỒ TỈ LỆ LẤP ĐẦY LỚP ==========
    const fillRateData = [
        <c:choose>
        <c:when test="${not empty classFillRateData}">
        <c:forEach var="item" items="${classFillRateData}" varStatus="status">
        <c:set var="itemRate" value="${item.rate != null ? item.rate : 0}" />
        <c:set var="itemCount" value="${item.count != null ? item.count : 0}" />
        <c:set var="itemTotal" value="${item.total != null ? item.total : 0}" />
        {
            category: "<c:out value="${item.category}" escapeXml="false" />",
            rate: <c:out value="${itemRate}" />,
            count: <c:out value="${itemCount}" />,
            total: <c:out value="${itemTotal}" />
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
        </c:when>
        <c:otherwise>[]</c:otherwise>
        </c:choose>
    ];
    
    console.log('Fill rate data:', fillRateData);
    
    const fillRateChartEl = document.getElementById('fillRateChart');
    if (fillRateChartEl && typeof ApexCharts !== 'undefined') {
        const colors = ['#3b82f6', '#10b981', '#f97316', '#8b5cf6', '#ec4899'];
        const labels = fillRateData.length > 0 ? fillRateData.map(d => d.category) : ['Chưa có dữ liệu'];
        const values = fillRateData.length > 0 ? fillRateData.map(d => d.rate) : [0];
        
        try {
            const fillRateChart = new ApexCharts(fillRateChartEl, {
                chart: {
                    type: 'donut',
                    height: 260
                },
                series: values,
                labels: labels,
                colors: colors.slice(0, labels.length),
                legend: {
                    show: false
                },
                plotOptions: {
                    pie: {
                        donut: {
                            size: '70%',
                            labels: {
                                show: true,
                                total: {
                                    show: true,
                                    label: 'Tổng',
                                    fontSize: '14px',
                                    fontWeight: 600,
                                    color: '#64748b'
                                }
                            }
                        }
                    }
                },
                tooltip: {
                    y: {
                        formatter: function(val, opts) {
                            const data = fillRateData[opts.dataPointIndex];
                            if (data) {
                                return data.category + ': ' + val + '% (' + data.count + '/' + data.total + ')';
                            }
                            return val + '%';
                        }
                    }
                }
            });
            fillRateChart.render();
        } catch (error) {
            console.error('Error creating fill rate chart:', error);
        }
    } else {
        console.warn('Fill rate chart element not found or ApexCharts not loaded');
    }
    
    // ========== BIỂU ĐỒ DOANH THU THEO NGÀY ==========
    const dailyRevenueData = [
        <c:choose>
        <c:when test="${not empty dailyRevenueData}">
        <c:forEach var="day" items="${dailyRevenueData}" varStatus="status">
        <c:set var="dayRevenue" value="${day.revenue != null ? day.revenue : 0}" />
        {
            date: "<c:out value="${day.date}" escapeXml="false" />",
            revenue: <c:out value="${dayRevenue}" />
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
        </c:when>
        <c:otherwise>[]</c:otherwise>
        </c:choose>
    ];
    
    console.log('Daily revenue data:', dailyRevenueData);
    
    const revenueChartEl = document.getElementById('revenueChart');
    if (revenueChartEl && typeof ApexCharts !== 'undefined') {
        const dates = dailyRevenueData.length > 0 ? dailyRevenueData.map(d => d.date) : ['Chưa có dữ liệu'];
        const revenues = dailyRevenueData.length > 0 ? dailyRevenueData.map(d => d.revenue) : [0];
        
        try {
            const revenueChart = new ApexCharts(revenueChartEl, {
                chart: {
                    type: 'bar',
                    height: 320,
                    toolbar: { show: false }
                },
                series: [{
                    name: 'Doanh thu',
                    data: revenues
                }],
                colors: ['#10b981'],
                plotOptions: {
                    bar: {
                        borderRadius: 6,
                        columnWidth: '60%'
                    }
                },
                xaxis: {
                    categories: dates,
                    labels: {
                        style: {
                            colors: '#64748b',
                            fontSize: '12px'
                        }
                    }
                },
                yaxis: {
                    labels: {
                        style: {
                            colors: '#64748b',
                            fontSize: '12px'
                        },
                        formatter: function(val) {
                            if (val >= 1000000) {
                                return (val / 1000000).toFixed(1) + 'M';
                            } else if (val >= 1000) {
                                return (val / 1000).toFixed(0) + 'k';
                            }
                            return val;
                        }
                    }
                },
                grid: {
                    borderColor: '#e2e8f0',
                    strokeDashArray: 3,
                    xaxis: {
                        lines: {
                            show: false
                        }
                    }
                },
                legend: {
                    show: false
                },
                tooltip: {
                    theme: 'light',
                    y: {
                        formatter: function(val) {
                            if (val >= 1000000) {
                                return 'Doanh thu: ' + (val / 1000000).toFixed(1) + ' triệu VNĐ';
                            } else if (val >= 1000) {
                                return 'Doanh thu: ' + (val / 1000).toFixed(0) + 'k VNĐ';
                            }
                            return 'Doanh thu: ' + val.toLocaleString('vi-VN') + ' VNĐ';
                        }
                    }
                }
            });
            revenueChart.render();
        } catch (error) {
            console.error('Error creating revenue chart:', error);
        }
    } else {
        console.warn('Revenue chart element not found or ApexCharts not loaded');
    }
});
</script>

</body>
</html>

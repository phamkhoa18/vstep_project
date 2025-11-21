<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đăng ký | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="registrations" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Quản lý đăng ký</h2>
                    <p class="text-sm text-slate-500 mt-1">Theo dõi đăng ký lớp ôn và ca thi, xử lý thanh toán kịp thời.</p>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    <c:out value="${not empty totalRegistrations ? totalRegistrations : 0}" /> đăng ký · cập nhật
                    <fmt:formatDate value="${lastUpdatedAt}" pattern="HH:mm" />
                </span>
                <c:if test="${not empty choDuyetCount && choDuyetCount > 0}">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                        <c:out value="${choDuyetCount}" /> đăng ký chờ duyệt
                    </span>
                </c:if>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng đăng ký</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${not empty totalRegistrations ? totalRegistrations : 0}" />
                    </p>
                </div>
                <p class="text-xs text-slate-400">Tất cả đăng ký trong hệ thống.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Đăng ký chờ duyệt</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${not empty choDuyetCount ? choDuyetCount : 0}" />
                    </p>
                    <c:if test="${choDuyetCount > 0}">
                        <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2.5 py-1 text-[11px] font-semibold text-orange-500">
                            Cần xử lý
                        </span>
                    </c:if>
                </div>
                <p class="text-xs text-slate-400">Ưu tiên xử lý sớm để xác nhận đăng ký.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Đã duyệt</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${not empty daDuyetCount ? daDuyetCount : 0}" />
                    </p>
                </div>
                <p class="text-xs text-slate-400">Đăng ký đã được xác nhận và duyệt.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng doanh thu</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <fmt:formatNumber value="${not empty totalRevenue ? totalRevenue : 0}" type="number" groupingUsed="true" />đ
                    </p>
                </div>
                <p class="text-xs text-slate-400">Tổng số tiền đã thu từ đăng ký.</p>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Bộ lọc đăng ký</h3>
                    <p class="text-xs text-slate-500 mt-1">Chọn loại đăng ký, trạng thái và tình trạng thanh toán.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <c:choose>
                        <c:when test="${not empty loaiFilter && loaiFilter != 'all' || not empty trangThaiFilter || not empty searchQuery || not empty fromDate || not empty toDate || (not empty thanhToanFilter && thanhToanFilter != 'all')}">
                            <c:if test="${not empty loaiFilter && loaiFilter != 'all'}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Loại</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${loaiFilter == 'lop' ? 'Lớp ôn' : 'Ca thi'}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/registrations?${fn:replace(fn:replace(pageContext.request.queryString, '&loai='.concat(loaiFilter), ''), 'loai='.concat(loaiFilter).concat('&'), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc loại">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty trangThaiFilter}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Trạng thái</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${trangThaiFilter}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/registrations?${fn:replace(fn:replace(pageContext.request.queryString, '&trangThai='.concat(fn:escapeXml(trangThaiFilter)), ''), 'trangThai='.concat(fn:escapeXml(trangThaiFilter)).concat('&'), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc trạng thái">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty fromDate || not empty toDate}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Ngày</span>
                                    <span class="text-slate-600 text-xs">
                                        <c:if test="${not empty fromDate}">
                                            <c:set var="fromDateParts" value="${fn:split(fromDate, '-')}" />
                                            <c:out value="${fromDateParts[2]}/${fromDateParts[1]}/${fromDateParts[0]}" />
                                        </c:if>
                                        <c:if test="${not empty fromDate && not empty toDate}"> - </c:if>
                                        <c:if test="${not empty toDate}">
                                            <c:set var="toDateParts" value="${fn:split(toDate, '-')}" />
                                            <c:out value="${toDateParts[2]}/${toDateParts[1]}/${toDateParts[0]}" />
                                        </c:if>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/admin/registrations?${fn:replace(fn:replace(fn:replace(pageContext.request.queryString, '&fromDate='.concat(fromDate), ''), 'fromDate='.concat(fromDate).concat('&'), ''), '&toDate='.concat(toDate), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc ngày">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty thanhToanFilter && thanhToanFilter != 'all'}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Thanh toán</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${thanhToanFilter == 'daThanhToan' ? 'Đã thanh toán' : 'Chờ thanh toán'}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/registrations?${fn:replace(fn:replace(pageContext.request.queryString, '&thanhToan='.concat(thanhToanFilter), ''), 'thanhToan='.concat(thanhToanFilter).concat('&'), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc thanh toán">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty searchQuery}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Tìm kiếm</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${searchQuery}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/registrations?${fn:replace(fn:replace(pageContext.request.queryString, '&search='.concat(fn:escapeXml(searchQuery)), ''), 'search='.concat(fn:escapeXml(searchQuery)).concat('&'), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc tìm kiếm">×</a>
                                </span>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/admin/registrations"
                               class="font-semibold text-primary hover:text-primary/80 transition">
                                Xoá tất cả
                            </a>
                        </c:when>
                        <c:otherwise>
                            <span class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-3 py-1 text-slate-500">
                                Chưa áp dụng bộ lọc nào
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <form id="registration-filter-form"
                  method="get"
                  action="${pageContext.request.contextPath}/admin/registrations"
                  class="space-y-5">
                <input type="hidden" name="page" value="1" />
                <c:if test="${not empty pageSize}">
                    <input type="hidden" name="pageSize" value="${pageSize}" />
                </c:if>
                <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-5">
                    <div>
                        <label for="filter-loai" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Loại đăng ký
                        </label>
                        <select id="filter-loai" name="loai"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="all">Tất cả</option>
                            <option value="lop" ${loaiFilter == 'lop' ? 'selected' : ''}>Lớp ôn</option>
                            <option value="thi" ${loaiFilter == 'thi' ? 'selected' : ''}>Ca thi</option>
                        </select>
                    </div>
                    <div>
                        <label for="filter-trangThai" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Trạng thái
                        </label>
                        <select id="filter-trangThai" name="trangThai"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="">Tất cả trạng thái</option>
                            <c:forEach var="status" items="${statusOptions}">
                                <option value="${status}" ${trangThaiFilter == status ? 'selected' : ''}>
                                    <c:out value="${status}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-fromDate" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Từ ngày
                        </label>
                        <input id="filter-fromDate"
                               name="fromDate"
                               type="date"
                               value="${fromDate}"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                    <div>
                        <label for="filter-toDate" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Đến ngày
                        </label>
                        <input id="filter-toDate"
                               name="toDate"
                               type="date"
                               value="${toDate}"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                    <div>
                        <label for="filter-thanhToan" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Thanh toán
                        </label>
                        <select id="filter-thanhToan" name="thanhToan"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="all">Tất cả</option>
                            <option value="daThanhToan" ${thanhToanFilter == 'daThanhToan' ? 'selected' : ''}>Đã thanh toán</option>
                            <option value="choThanhToan" ${thanhToanFilter == 'choThanhToan' ? 'selected' : ''}>Chờ thanh toán</option>
                        </select>
                    </div>
                </div>
                
                <div class="relative">
                    <div class="absolute inset-y-0 left-4 flex items-center text-slate-300 pointer-events-none">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <circle cx="11" cy="11" r="7"/>
                            <path d="M20 20l-3-3"/>
                        </svg>
                    </div>
                    <input id="filter-search"
                           name="search"
                           type="search"
                           value="${searchQuery}"
                           placeholder="Tìm theo tên học viên, mã đăng ký, email, SĐT..."
                           class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                
                <div class="flex items-center gap-3">
                    <a href="${pageContext.request.contextPath}/admin/registrations"
                       class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                        Đặt lại
                    </a>
                    <button type="submit"
                            class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Áp dụng
                    </button>
                </div>
            </form>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-6 py-4">
                            <input type="checkbox" id="select-all" class="h-4 w-4 rounded border-blue-200 text-primary focus:ring-primary/30">
                        </th>
                        <th class="px-6 py-4 text-left font-semibold">Học viên</th>
                        <th class="px-6 py-4 text-left font-semibold">Loại đăng ký</th>
                        <th class="px-6 py-4 text-left font-semibold">Đối tượng</th>
                        <th class="px-6 py-4 text-left font-semibold">Thanh toán</th>
                        <th class="px-6 py-4 text-left font-semibold">Thời gian</th>
                        <th class="px-6 py-4 text-left font-semibold">Trạng thái</th>
                        <th class="px-6 py-4 text-right font-semibold">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <c:choose>
                        <c:when test="${not empty registrations}">
                            <c:forEach var="reg" items="${registrations}">
                                <c:set var="loai" value="${reg.loai}" />
                                <c:set var="user" value="${reg.nguoiDung}" />
                                <c:choose>
                                    <c:when test="${loai == 'lop'}">
                                        <c:set var="dk" value="${reg.dangKy}" />
                                        <c:set var="lop" value="${reg.lopOn}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="dkThi" value="${reg.dangKyThi}" />
                                        <c:set var="caThi" value="${reg.caThi}" />
                                    </c:otherwise>
                                </c:choose>
                                <tr>
                                    <td class="px-6 py-5">
                                        <input type="checkbox" class="row-check h-4 w-4 rounded border-blue-200 text-primary focus:ring-primary/30" 
                                               value="${loai == 'lop' ? dk.id : dkThi.id}">
                                    </td>
                                    <td class="px-6 py-5">
                                        <p class="font-semibold text-slate-900">
                                            <c:out value="${not empty user ? user.hoTen : 'N/A'}" />
                                        </p>
                                        <p class="text-xs text-slate-400 mt-1">
                                            Mã ĐK: <c:out value="${loai == 'lop' ? (not empty dk.maXacNhan ? dk.maXacNhan : 'N/A') : (not empty dkThi.maXacNhan ? dkThi.maXacNhan : 'N/A')}" />
                                        </p>
                                        <c:if test="${not empty user}">
                                            <p class="text-xs text-slate-400">
                                                <c:out value="${user.email}" /> · <c:out value="${user.soDienThoai}" />
                                            </p>
                                        </c:if>
                                    </td>
                                    <td class="px-6 py-5">
                                        <c:choose>
                                            <c:when test="${loai == 'lop'}">
                                                <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                                    Lớp ôn
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-primary">
                                                    Ca thi
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-5">
                                        <c:choose>
                                            <c:when test="${loai == 'lop' && not empty lop}">
                                                <p class="font-semibold text-slate-800">
                                                    <c:out value="${lop.maLop}" /> · <c:out value="${lop.tieuDe}" />
                                                </p>
                                                <p class="text-xs text-slate-400">
                                                    <c:if test="${not empty lop.ngayKhaiGiang}">
                                                        <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    · <c:out value="${lop.hinhThuc}" />
                                                </p>
                                            </c:when>
                                            <c:when test="${loai == 'thi' && not empty caThi}">
                                                <p class="font-semibold text-slate-800">
                                                    Ca thi #<c:out value="${caThi.id}" />
                                                </p>
                                                <p class="text-xs text-slate-400">
                                                    <c:if test="${not empty caThi.ngayThi}">
                                                        <fmt:formatDate value="${caThi.ngayThi}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    <c:if test="${not empty caThi.gioBatDau}">
                                                        · <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                                    </c:if>
                                                    <c:if test="${not empty caThi.diaDiem}">
                                                        · <c:out value="${caThi.diaDiem}" />
                                                    </c:if>
                                                </p>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-5">
                                        <c:choose>
                                            <c:when test="${loai == 'lop'}">
                                                <c:choose>
                                                    <c:when test="${dk.soTienDaTra > 0}">
                                                        <p class="font-semibold text-emerald-500">Đã thanh toán</p>
                                                        <p class="text-xs text-slate-400">
                                                            <fmt:formatNumber value="${dk.soTienDaTra}" type="number" groupingUsed="true" />đ
                                                            <c:if test="${not empty lop}">
                                                                <c:set var="mucGiamValue" value="${not empty dk.mucGiam ? dk.mucGiam : 0}" />
                                                                <c:set var="soTienPhaiTra" value="${lop.hocPhi - mucGiamValue}" />
                                                                <c:if test="${lop.hocPhi > soTienPhaiTra}">
                                                                    / <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                                                    <c:if test="${mucGiamValue > 0}">
                                                                        <span class="text-emerald-600">(Giảm <fmt:formatNumber value="${mucGiamValue}" type="number" groupingUsed="true" />đ)</span>
                                                                    </c:if>
                                                                </c:if>
                                                            </c:if>
                                                        </p>
                                                        <c:if test="${not empty dk.maCodeGiamGia}">
                                                            <p class="text-xs text-blue-600">Mã code: <c:out value="${dk.maCodeGiamGia}" /></p>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="font-semibold text-orange-500">Chờ thanh toán</p>
                                                        <c:if test="${not empty lop}">
                                                            <c:set var="mucGiamValue" value="${not empty dk.mucGiam ? dk.mucGiam : 0}" />
                                                            <c:set var="soTienPhaiTra" value="${lop.hocPhi - mucGiamValue}" />
                                                            <p class="text-xs text-slate-400">
                                                                Học phí: <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                                                <c:if test="${mucGiamValue > 0}">
                                                                    <br>Giảm: -<fmt:formatNumber value="${mucGiamValue}" type="number" groupingUsed="true" />đ
                                                                    <br>Phải trả: <fmt:formatNumber value="${soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                                </c:if>
                                                            </p>
                                                            <c:if test="${not empty dk.maCodeGiamGia}">
                                                                <p class="text-xs text-blue-600">Mã code: <c:out value="${dk.maCodeGiamGia}" /></p>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${dkThi.trangThai == 'Đã duyệt' || dkThi.trangThai == 'Đã xác nhận'}">
                                                        <p class="font-semibold text-emerald-500">Đã thanh toán</p>
                                                        <p class="text-xs text-slate-400">
                                                            <fmt:formatNumber value="${dkThi.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                            <c:if test="${not empty caThi && caThi.giaGoc > dkThi.soTienPhaiTra}">
                                                                <c:set var="mucGiamThiValue" value="${not empty dkThi.mucGiam ? dkThi.mucGiam : 0}" />
                                                                <c:if test="${mucGiamThiValue > 0}">
                                                                    <span class="text-emerald-600">(Giảm <fmt:formatNumber value="${mucGiamThiValue}" type="number" groupingUsed="true" />đ)</span>
                                                                </c:if>
                                                            </c:if>
                                                        </p>
                                                        <c:if test="${not empty dkThi.maCodeGiamGia}">
                                                            <p class="text-xs text-blue-600">Mã code: <c:out value="${dkThi.maCodeGiamGia}" /></p>
                                                        </c:if>
                                                        <c:if test="${dkThi.daTungThi}">
                                                            <p class="text-xs text-slate-400">Đã từng thi</p>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="font-semibold text-orange-500">Chờ thanh toán</p>
                                                        <c:if test="${not empty caThi}">
                                                            <c:set var="mucGiamThiValue" value="${not empty dkThi.mucGiam ? dkThi.mucGiam : 0}" />
                                                            <p class="text-xs text-slate-400">
                                                                Giá gốc: <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                                                <c:if test="${mucGiamThiValue > 0}">
                                                                    <br>Giảm: -<fmt:formatNumber value="${mucGiamThiValue}" type="number" groupingUsed="true" />đ
                                                                    <br>Phải trả: <fmt:formatNumber value="${dkThi.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                                </c:if>
                                                            </p>
                                                            <c:if test="${not empty dkThi.maCodeGiamGia}">
                                                                <p class="text-xs text-blue-600">Mã code: <c:out value="${dkThi.maCodeGiamGia}" /></p>
                                                            </c:if>
                                                            <c:if test="${dkThi.daTungThi}">
                                                                <p class="text-xs text-slate-400">Đã từng thi</p>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-5">
                                        <c:choose>
                                            <c:when test="${loai == 'lop' && not empty dk.ngayDangKy}">
                                                <p class="font-semibold text-slate-800">
                                                    <fmt:formatDate value="${dk.ngayDangKy}" pattern="dd/MM/yyyy" />
                                                </p>
                                                <p class="text-xs text-slate-400">
                                                    <fmt:formatDate value="${dk.ngayDangKy}" pattern="HH:mm" />
                                                </p>
                                            </c:when>
                                            <c:when test="${loai == 'thi' && not empty dkThi.ngayDangKy}">
                                                <p class="font-semibold text-slate-800">
                                                    <fmt:formatDate value="${dkThi.ngayDangKy}" pattern="dd/MM/yyyy" />
                                                </p>
                                                <p class="text-xs text-slate-400">
                                                    <fmt:formatDate value="${dkThi.ngayDangKy}" pattern="HH:mm" />
                                                </p>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-5">
                                        <c:set var="trangThai" value="${loai == 'lop' ? dk.trangThai : dkThi.trangThai}" />
                                        <c:choose>
                                            <c:when test="${trangThai == 'Chờ xác nhận'}">
                                                <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">
                                                    <c:out value="${trangThai}" />
                                                </span>
                                            </c:when>
                                            <c:when test="${trangThai == 'Đã xác nhận' || trangThai == 'Đã duyệt'}">
                                                <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                                    <c:out value="${trangThai}" />
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-primary">
                                                    <c:out value="${trangThai}" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-5 text-right space-x-2">
                                        <button data-modal-target="detail-modal-${loai == 'lop' ? dk.id : dkThi.id}"
                                                type="button"
                                                class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                            Chi tiết
                                        </button>
                                        <c:set var="trangThai" value="${loai == 'lop' ? dk.trangThai : dkThi.trangThai}" />
                                        <c:if test="${trangThai == 'Chờ xác nhận'}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/registrations" style="display:inline">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="${loai == 'lop' ? dk.id : dkThi.id}">
                                                <input type="hidden" name="loai" value="${loai}">
                                                <button type="submit" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                                    Duyệt
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="px-6 py-12 text-center text-slate-400">
                                    <p class="text-sm">Chưa có đăng ký nào</p>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Render detail modals after the table to avoid nesting issues -->
            <c:if test="${not empty registrations}">
                <c:forEach var="reg" items="${registrations}">
                    <c:set var="loai" value="${reg.loai}" />
                    <c:choose>
                        <c:when test="${loai == 'lop'}">
                            <c:set var="dk" value="${reg.dangKy}" />
                            <c:set var="lop" value="${reg.lopOn}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="dkThi" value="${reg.dangKyThi}" />
                            <c:set var="caThi" value="${reg.caThi}" />
                        </c:otherwise>
                    </c:choose>
                    <c:set var="user" value="${reg.nguoiDung}" />
                    <c:set var="modalId" value="${loai == 'lop' ? dk.id : dkThi.id}" />
                    <div id="detail-modal-${modalId}" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
                        <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
                            <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
                                <div>
                                    <h3 class="text-xl font-semibold text-slate-900">Chi tiết đăng ký</h3>
                                    <p class="text-xs text-slate-500 mt-1">Thông tin học viên và đăng ký.</p>
                                </div>
                                <button data-modal-close="detail-modal-${modalId}"
                                        class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                                    ×
                                </button>
                            </div>
                            <div class="px-6 py-6 space-y-6">
                                <div class="grid gap-6 md:grid-cols-2">
                                    <div>
                                        <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Học viên</p>
                                        <p class="mt-2 text-sm font-semibold text-slate-900">
                                            <c:out value="${not empty user ? user.hoTen : 'N/A'}" />
                                        </p>
                                        <p class="text-xs text-slate-400">
                                            SĐT: <c:out value="${not empty user ? user.soDienThoai : 'N/A'}" /> ·
                                            Email: <c:out value="${not empty user ? user.email : 'N/A'}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Mã đăng ký</p>
                                        <p class="mt-2 text-sm font-semibold text-slate-900">
                                            <c:out value="${loai == 'lop' ? (not empty dk.maXacNhan ? dk.maXacNhan : 'N/A') : (not empty dkThi.maXacNhan ? dkThi.maXacNhan : 'N/A')}" />
                                        </p>
                                        <p class="text-xs text-slate-400">
                                            <c:choose>
                                                <c:when test="${loai == 'lop' && not empty dk.ngayDangKy}">
                                                    Tạo lúc <fmt:formatDate value="${dk.ngayDangKy}" pattern="dd/MM/yyyy · HH:mm" />
                                                </c:when>
                                                <c:when test="${loai == 'thi' && not empty dkThi.ngayDangKy}">
                                                    Tạo lúc <fmt:formatDate value="${dkThi.ngayDangKy}" pattern="dd/MM/yyyy · HH:mm" />
                                                </c:when>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4">
                                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Đối tượng</p>
                                    <c:choose>
                                        <c:when test="${loai == 'lop' && not empty lop}">
                                            <p class="mt-2 text-sm font-semibold text-slate-900">
                                                <c:out value="${lop.maLop}" /> · <c:out value="${lop.tieuDe}" />
                                            </p>
                                            <p class="text-xs text-slate-500 mt-1">
                                                <c:if test="${not empty lop.ngayKhaiGiang}">
                                                    <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" />
                                                </c:if>
                                                · <c:out value="${lop.hinhThuc}" />
                                                <c:if test="${not empty lop.thoiGianHoc}">
                                                    · <c:out value="${lop.thoiGianHoc}" />
                                                </c:if>
                                            </p>
                                        </c:when>
                                        <c:when test="${loai == 'thi' && not empty caThi}">
                                            <p class="mt-2 text-sm font-semibold text-slate-900">
                                                Ca thi #<c:out value="${caThi.id}" />
                                                <c:if test="${not empty caThi.maCaThi}">
                                                    · <c:out value="${caThi.maCaThi}" />
                                                </c:if>
                                            </p>
                                            <p class="text-xs text-slate-500 mt-1">
                                                <c:if test="${not empty caThi.ngayThi}">
                                                    <fmt:formatDate value="${caThi.ngayThi}" pattern="dd/MM/yyyy" />
                                                </c:if>
                                                <c:if test="${not empty caThi.gioBatDau}">
                                                    · <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                                </c:if>
                                                <c:if test="${not empty caThi.diaDiem}">
                                                    · <c:out value="${caThi.diaDiem}" />
                                                </c:if>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="mt-2 text-sm text-slate-500">Không có thông tin.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="grid gap-6 md:grid-cols-2">
                                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                                        <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Thanh toán</p>
                                        <c:choose>
                                            <c:when test="${loai == 'lop'}">
                                                <c:choose>
                                                    <c:when test="${dk.soTienDaTra > 0}">
                                                        <p class="mt-2 text-sm font-semibold text-emerald-500">Đã thanh toán</p>
                                                        <p class="text-xs text-slate-400 mt-1">
                                                            <fmt:formatNumber value="${dk.soTienDaTra}" type="number" groupingUsed="true" />đ
                                                            <c:if test="${not empty lop && lop.hocPhi > dk.soTienDaTra}">
                                                                / <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                                            </c:if>
                                                        </p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="mt-2 text-sm font-semibold text-orange-500">Chờ thanh toán</p>
                                                        <c:if test="${not empty lop}">
                                                            <p class="text-xs text-slate-400 mt-1">
                                                                Học phí: <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                                            </p>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${dkThi.trangThai == 'Đã duyệt' || dkThi.trangThai == 'Đã xác nhận'}">
                                                        <p class="mt-2 text-sm font-semibold text-emerald-500">Đã thanh toán</p>
                                                        <p class="text-xs text-slate-400 mt-1">
                                                            <fmt:formatNumber value="${dkThi.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                        </p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="mt-2 text-sm font-semibold text-orange-500">Chờ thanh toán</p>
                                                        <c:if test="${not empty caThi}">
                                                            <p class="text-xs text-slate-400 mt-1">
                                                                Giá gốc: <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                                                <br>Phải trả: <fmt:formatNumber value="${dkThi.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                            </p>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                                        <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Trạng thái</p>
                                        <c:set var="trangThaiModal" value="${loai == 'lop' ? dk.trangThai : dkThi.trangThai}" />
                                        <p class="mt-2 text-sm font-semibold
                                            ${trangThaiModal == 'Đã duyệt' ? 'text-emerald-500' : (trangThaiModal == 'Chờ xác nhận' ? 'text-orange-500' : 'text-primary')}">
                                            <c:out value="${trangThaiModal}" />
                                        </p>
                                        <c:if test="${trangThaiModal == 'Chờ xác nhận'}">
                                            <form method="post" action="${pageContext.request.contextPath}/admin/registrations" class="mt-3">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="${modalId}">
                                                <input type="hidden" name="loai" value="${loai}">
                                                <button type="submit"
                                                        class="rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                                    Duyệt đăng ký
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                                <c:if test="${loai == 'lop' && not empty dk.ghiChu}">
                                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                                        <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Ghi chú</p>
                                        <p class="text-sm text-slate-700"><c:out value="${dk.ghiChu}" /></p>
                                    </div>
                                </c:if>
                                <div class="flex items-center justify-end gap-3">
                                    <button data-modal-close="detail-modal-${modalId}"
                                            class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                        Đóng
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:set var="currentPage" value="${empty currentPage ? 1 : currentPage}" />
            <c:set var="totalPages" value="${empty totalPages ? 1 : totalPages}" />
            <c:set var="pageSize" value="${empty pageSize ? 10 : pageSize}" />
            <c:set var="totalRecords" value="${empty totalRecords ? 0 : totalRecords}" />
            <c:set var="startRecord" value="${empty startRecord ? 0 : startRecord}" />
            <c:set var="endRecord" value="${empty endRecord ? 0 : endRecord}" />
            
            <c:if test="${totalRecords > 0}">
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40">
                    <div class="flex items-center gap-4 text-xs text-slate-600">
                        <p>
                            Hiển thị <strong class="text-slate-900"><c:out value="${startRecord}" /></strong> - 
                            <strong class="text-slate-900"><c:out value="${endRecord}" /></strong> trong tổng số 
                            <strong class="text-slate-900"><c:out value="${totalRecords}" /></strong> đăng ký.
                        </p>
                        <div class="flex items-center gap-2">
                            <label for="page-size-select" class="text-slate-500">Hiển thị:</label>
                            <select id="page-size-select" 
                                    class="rounded-xl border border-blue-100 bg-white px-3 py-1.5 text-xs text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
                                <option value="20" <c:if test="${pageSize == 20}">selected</c:if>>20</option>
                                <option value="50" <c:if test="${pageSize == 50}">selected</c:if>>50</option>
                                <option value="100" <c:if test="${pageSize == 100}">selected</c:if>>100</option>
                            </select>
                        </div>
                    </div>
                    
                    <c:if test="${totalPages > 1}">
                        <nav class="flex items-center gap-2" aria-label="Phân trang">
                            <c:set var="basePath" value="${pageContext.request.contextPath}/admin/registrations" />
                            
                            <c:url var="prevUrl" value="/admin/registrations">
                                <c:param name="page" value="${currentPage > 1 ? currentPage - 1 : 1}"/>
                                <c:if test="${not empty loaiFilter && loaiFilter != 'all'}"><c:param name="loai" value="${loaiFilter}"/></c:if>
                                <c:if test="${not empty trangThaiFilter}"><c:param name="trangThai" value="${trangThaiFilter}"/></c:if>
                                <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}"/></c:if>
                                <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}"/></c:if>
                                <c:if test="${not empty thanhToanFilter && thanhToanFilter != 'all'}"><c:param name="thanhToan" value="${thanhToanFilter}"/></c:if>
                                <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                            </c:url>
                            
                            <a href="${prevUrl}"
                               class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-xs font-semibold text-slate-600 hover:bg-primary/5 hover:text-primary transition disabled:opacity-50 disabled:cursor-not-allowed ${currentPage == 1 ? 'opacity-50 cursor-not-allowed pointer-events-none' : ''}"
                               ${currentPage == 1 ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 19l-7-7 7-7"/>
                                </svg>
                                Trước
                            </a>
                            
                            <div class="flex items-center gap-1">
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <c:choose>
                                        <c:when test="${page == currentPage}">
                                            <span class="inline-flex items-center justify-center min-w-[2rem] h-8 rounded-xl bg-primary text-white text-xs font-semibold">
                                                <c:out value="${page}" />
                                            </span>
                                        </c:when>
                                        <c:when test="${totalPages <= 7 || page == 1 || page == totalPages || (page >= currentPage - 2 && page <= currentPage + 2)}">
                                            <c:url var="pageUrl" value="/admin/registrations">
                                                <c:param name="page" value="${page}"/>
                                                <c:if test="${not empty loaiFilter && loaiFilter != 'all'}"><c:param name="loai" value="${loaiFilter}"/></c:if>
                                                <c:if test="${not empty trangThaiFilter}"><c:param name="trangThai" value="${trangThaiFilter}"/></c:if>
                                                <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}"/></c:if>
                                                <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}"/></c:if>
                                                <c:if test="${not empty thanhToanFilter && thanhToanFilter != 'all'}"><c:param name="thanhToan" value="${thanhToanFilter}"/></c:if>
                                                <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                                <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                            </c:url>
                                            <a href="${pageUrl}"
                                               class="inline-flex items-center justify-center min-w-[2rem] h-8 rounded-xl border border-blue-100 bg-white px-2 text-xs font-semibold text-slate-600 hover:bg-primary/5 hover:text-primary transition">
                                                <c:out value="${page}" />
                                            </a>
                                        </c:when>
                                        <c:when test="${page == currentPage - 3 || page == currentPage + 3}">
                                            <span class="inline-flex items-center justify-center min-w-[2rem] h-8 text-xs text-slate-400">
                                                ...
                                            </span>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            
                            <c:url var="nextUrl" value="/admin/registrations">
                                <c:param name="page" value="${currentPage < totalPages ? currentPage + 1 : totalPages}"/>
                                <c:if test="${not empty loaiFilter && loaiFilter != 'all'}"><c:param name="loai" value="${loaiFilter}"/></c:if>
                                <c:if test="${not empty trangThaiFilter}"><c:param name="trangThai" value="${trangThaiFilter}"/></c:if>
                                <c:if test="${not empty fromDate}"><c:param name="fromDate" value="${fromDate}"/></c:if>
                                <c:if test="${not empty toDate}"><c:param name="toDate" value="${toDate}"/></c:if>
                                <c:if test="${not empty thanhToanFilter && thanhToanFilter != 'all'}"><c:param name="thanhToan" value="${thanhToanFilter}"/></c:if>
                                <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                            </c:url>
                            
                            <a href="${nextUrl}"
                               class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-xs font-semibold text-slate-600 hover:bg-primary/5 hover:text-primary transition disabled:opacity-50 disabled:cursor-not-allowed ${currentPage >= totalPages ? 'opacity-50 cursor-not-allowed pointer-events-none' : ''}"
                               ${currentPage >= totalPages ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                Sau
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 5l7 7-7 7"/>
                                </svg>
                            </a>
                        </nav>
                    </c:if>
                </div>
            </c:if>
        </section>

        </main>
    </div>
</div>

<!-- Detail modal template removed; using per-row modals -->

<!-- Reminder modal -->
<div id="reminder-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-lg w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Gửi nhắc phí</h3>
                <p class="text-xs text-slate-500 mt-1">Soạn nội dung nhắc thanh toán cho học viên.</p>
            </div>
            <button data-modal-close="reminder-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Gửi tới</label>
                <input type="text" value="Nguyễn Mỹ Duyên · duyennm@example.com" readonly
                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-primary.pale/40 px-4 py-3 text-sm text-slate-500">
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Chủ đề</label>
                <input type="text" value="[VSTEP] Nhắc thanh toán học phí lớp NE3 - Giao tiếp nâng cao"
                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nội dung</label>
                <textarea rows="6"
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">Chào Duyên,

Trung tâm VSTEP xin nhắc bạn hoàn tất thanh toán học phí lớp NE3 - Giao tiếp nâng cao trước 18:00 ngày 10/11 để giữ chỗ. Vui lòng chuyển khoản theo thông tin đã được gửi trước đó hoặc thanh toán trực tiếp tại quầy.

Nếu bạn đã thanh toán, vui lòng bỏ qua email này. Cảm ơn bạn!</textarea>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="reminder-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Đóng
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Gửi email
                </button>
            </div>
        </form>
    </div>
</div>



<%@ include file="layout/admin-scripts.jspf" %>
<script>
    (function() {
        const selectAll = document.getElementById('select-all');
        const rowChecks = document.querySelectorAll('.row-check');
        if (selectAll) {
            selectAll.addEventListener('change', function() {
                rowChecks.forEach(cb => cb.checked = selectAll.checked);
                updateBulkCount();
            });
        }
        rowChecks.forEach(cb => cb.addEventListener('change', updateBulkCount));
        function updateBulkCount() {
            const count = Array.from(rowChecks).filter(cb => cb.checked).length;
            const label = document.getElementById('bulk-count');
            if (label) label.textContent = 'Áp dụng cho ' + count + ' đăng ký đang chọn.';
        }
        // Hook open modal to fill hidden inputs
        const bulkBtn = document.querySelector('[data-modal-target="bulk-approve-modal"]');
        if (bulkBtn) {
            bulkBtn.addEventListener('click', function() {
                const container = document.getElementById('bulk-ids-container');
                if (container) {
                    container.innerHTML = '';
                    Array.from(document.querySelectorAll('.row-check'))
                        .filter(cb => cb.checked)
                        .forEach(cb => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = 'ids';
                            input.value = cb.value;
                            container.appendChild(input);
                        });
                }
            });
        }
        
        // Xử lý thay đổi pageSize
        const pageSizeSelect = document.getElementById('page-size-select');
        if (pageSizeSelect) {
            pageSizeSelect.addEventListener('change', function() {
                const newPageSize = this.value;
                const urlParams = new URLSearchParams(window.location.search);
                
                // Cập nhật pageSize và reset về trang 1
                urlParams.set('pageSize', newPageSize);
                urlParams.set('page', '1');
                
                // Chuyển hướng với params mới
                window.location.search = urlParams.toString();
            });
        }
    })();
</script>
</body>
</html>


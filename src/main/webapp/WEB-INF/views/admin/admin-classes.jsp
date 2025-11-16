<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý lớp ôn | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="classes" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
        <c:set var="classCountVal" value="${empty classCount ? 0 : classCount}" />
        <c:set var="avgCapacityVal" value="${empty averageCapacity ? 0 : averageCapacity}" />
        <c:set var="dangMoCountVal" value="${empty dangMoCount ? 0 : dangMoCount}" />
        <c:set var="sapMoCountVal" value="${empty sapMoCount ? 0 : sapMoCount}" />
        <c:set var="daKetThucCountVal" value="${empty daKetThucCount ? 0 : daKetThucCount}" />
        <c:set var="nearlyFullCountVal" value="${empty nearlyFullCount ? 0 : nearlyFullCount}" />
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Quản lý lớp ôn</h2>
                    <p class="text-sm text-slate-500 mt-1">Theo dõi tình trạng lớp học, sĩ số và lịch giảng dạy.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <button data-modal-target="class-import-modal" type="button"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 3v12"/>
                            <path d="M6 9h12"/>
                            <path d="M4 19h16"/>
                        </svg>
                        Nhập danh sách
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/classes/create"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v12"/>
                            <path d="M6 12h12"/>
                        </svg>
                        Tạo lớp mới
                    </a>
                </div>
            </div>
            <c:if test="${not empty classFlashMessage}">
                <c:set var="flashType" value="${empty classFlashType ? 'info' : classFlashType}" />
                <c:set var="flashClasses"
                       value="${flashType eq 'success' ? 'bg-emerald-50 border-emerald-200 text-emerald-700' :
                               flashType eq 'error' ? 'bg-rose-50 border-rose-200 text-rose-600' :
                               'bg-blue-50 border-blue-200 text-blue-600'}" />
                <div class="rounded-2xl border px-4 py-3 text-sm font-medium ${flashClasses}">
                    ${classFlashMessage}
                </div>
            </c:if>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng số lớp</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${classCountVal}" /> lớp
                    </p>
                </div>
                <p class="text-xs text-slate-400">
                    Sĩ số tối đa trung bình
                    <fmt:formatNumber value="${avgCapacityVal}" maxFractionDigits="1" minFractionDigits="0"/> học viên.
                </p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Lớp đang mở</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${dangMoCountVal}" /> lớp
                    </p>
                </div>
                <p class="text-xs text-slate-400">
                    <c:choose>
                        <c:when test="${nearlyFullCountVal > 0}">
                            Có <c:out value="${nearlyFullCountVal}" /> lớp đạt ≥ 40 chỗ.
                        </c:when>
                        <c:otherwise>
                            Chưa có lớp nào vượt ngưỡng sĩ số cao.
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Lớp sắp mở</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${sapMoCountVal}" /> lớp
                    </p>
                </div>
                <p class="text-xs text-slate-400">
                    Ưu tiên cập nhật lịch giảng viên và truyền thông trước khai giảng.
                </p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Lớp đã kết thúc</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${daKetThucCountVal}" /> lớp
                    </p>
                </div>
                <p class="text-xs text-slate-400">
                    Theo dõi phản hồi học viên và cân nhắc mở lớp kế tiếp.
                </p>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Bộ lọc lớp ôn</h3>
                    <p class="text-xs text-slate-500 mt-1">Sử dụng các tiêu chí thực tế của lớp để thu hẹp kết quả.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <c:choose>
                        <c:when test="${hasActiveFilters}">
                            <c:forEach var="chip" items="${activeFilterChips}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">${chip.label}</span>
                                    <span class="text-slate-600 text-xs">${chip.value}</span>
                                    <a href="${chip.removeUrl}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc ${chip.label}">×</a>
                                </span>
                            </c:forEach>
                            <a href="${pageContext.request.contextPath}/admin/classes"
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

            <form id="class-filter-form"
                  method="get"
                  action="${pageContext.request.contextPath}/admin/classes"
                  class="space-y-5">
                <input type="hidden" name="page" value="1" />
                <c:if test="${not empty pageSize}">
                    <input type="hidden" name="pageSize" value="${pageSize}" />
                </c:if>
                <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-5">
                    <div>
                        <label for="filter-format" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Hình thức
                        </label>
                        <select id="filter-format" name="format"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="">Tất cả hình thức</option>
                            <c:forEach var="option" items="${formatOptions}">
                                <option value="${option}"
                                        <c:if test="${not empty classFilterParams.format and fn:toLowerCase(option) eq fn:toLowerCase(classFilterParams.format)}">selected</c:if>>
                                    ${option}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-pace" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Nhịp độ lớp
                        </label>
                        <select id="filter-pace" name="pace"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="">Tất cả nhịp độ</option>
                            <c:forEach var="option" items="${paceOptions}">
                                <option value="${option}"
                                        <c:if test="${not empty classFilterParams.pace and fn:toLowerCase(option) eq fn:toLowerCase(classFilterParams.pace)}">selected</c:if>>
                                    ${option}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-status" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Tình trạng
                        </label>
                        <select id="filter-status" name="status"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="">Tất cả tình trạng</option>
                            <c:forEach var="option" items="${statusOptions}">
                                <option value="${option}"
                                        <c:if test="${not empty classFilterParams.status and fn:toLowerCase(option) eq fn:toLowerCase(classFilterParams.status)}">selected</c:if>>
                                    ${option}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-start-from" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Khai giảng từ
                        </label>
                        <input id="filter-start-from"
                               name="startFrom"
                               type="date"
                               value="${classFilterParams.startFrom}"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                    <div>
                        <label for="filter-start-to" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Khai giảng đến
                        </label>
                        <input id="filter-start-to"
                               name="startTo"
                               type="date"
                               value="${classFilterParams.startTo}"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                </div>

                <div class="flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
                    <div class="w-full md:max-w-md">
                        <label for="filter-keyword" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Từ khóa
                        </label>
                        <div class="relative mt-2">
                            <div class="absolute inset-y-0 left-4 flex items-center text-slate-300 pointer-events-none">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                    <circle cx="11" cy="11" r="7"/>
                                    <path d="M20 20l-3-3"/>
                                </svg>
                            </div>
                            <input id="filter-keyword"
                                   name="keyword"
                                   type="search"
                                   value="${classFilterParams.keyword}"
                                   placeholder="Tìm theo tên lớp, mã lớp..."
                                   class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <a href="${pageContext.request.contextPath}/admin/classes"
                           class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                            Đặt lại
                        </a>
                        <button type="submit"
                                class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Áp dụng
                        </button>
                    </div>
                </div>
            </form>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-[12px] uppercase text-slate-500">
                    <tr>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Lớp / Mô tả</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Hình thức</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Nhịp độ</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Thời gian</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Số buổi</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Sĩ số tối đa</th>
                        <th class="px-4 py-4 text-left font-semibold text-[12px]">Học phí</th>
                        <th class="px-4 py-4 text-right font-semibold text-[12px]">Tình trạng</th>
                        <th class="px-4 py-4 text-right font-semibold text-[12px]">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <c:if test="${empty lopOnList}">
                        <tr>
                            <td colspan="9" class="px-6 py-10 text-center text-sm text-slate-400">
                                Chưa có lớp ôn nào. Nhấn "Tạo lớp mới" để thêm dữ liệu đầu tiên.
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="lop" items="${lopOnList}">
                        <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" var="ngayKhaiGiangDisplay" />
                        <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="yyyy-MM-dd" var="ngayKhaiGiangIso" />
                        <fmt:formatDate value="${lop.ngayKetThuc}" pattern="dd/MM/yyyy" var="ngayKetThucDisplay" />
                        <fmt:formatDate value="${lop.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKetThucIso" />
                        <fmt:formatDate value="${lop.gioMoiBuoi}" pattern="HH:mm" var="gioMoiBuoiDisplay" />
                        <c:set var="statusText" value="${empty lop.tinhTrang ? 'Không xác định' : lop.tinhTrang}" />
                        <c:set var="statusLower" value="${fn:toLowerCase(statusText)}" />
                        <c:set var="statusBadgeClass" value="bg-slate-100 text-slate-600" />
                        <c:choose>
                            <c:when test="${fn:contains(statusLower, 'đang') or fn:contains(statusLower, 'dang')}">
                                <c:set var="statusBadgeClass" value="bg-emerald-100 text-emerald-600" />
                            </c:when>
                            <c:when test="${fn:contains(statusLower, 'sắp') or fn:contains(statusLower, 'sap')}">
                                <c:set var="statusBadgeClass" value="bg-orange-100 text-orange-500" />
                            </c:when>
                            <c:when test="${fn:contains(statusLower, 'kết') or fn:contains(statusLower, 'ket')}">
                                <c:set var="statusBadgeClass" value="bg-slate-200 text-slate-600" />
                            </c:when>
                        </c:choose>
                        <tr>
                            <td class="px-4 py-4">
                                <p class="font-semibold text-slate-900">
                                    <c:out value="${lop.tieuDe}" />
                                </p>
                                <div class="mt-1 space-y-1 text-xs text-slate-400">
                                    <p>Mã lớp: <c:out value="${lop.maLop}" /></p>
                                </div>
                            </td>
                            <td class="px-4 py-4">
                                <c:set var="formatLower" value="${fn:toLowerCase(empty lop.hinhThuc ? '' : lop.hinhThuc)}" />
                                <c:set var="formatLabel" value="${formatLower eq 'offline' ? 'Offline' :
                                                               formatLower eq 'online' ? 'Online' :
                                                               (empty lop.hinhThuc ? '—' : lop.hinhThuc)}" />
                                <c:set var="formatBadgeClass"
                                       value="${formatLower eq 'offline' ? 'bg-sky-100 text-sky-600' :
                                               formatLower eq 'online' ? 'bg-emerald-100 text-emerald-600' :
                                               'bg-slate-100 text-slate-600'}" />
                                <span class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-semibold ${formatBadgeClass}">
                                    <c:out value="${formatLabel}" />
                                </span>
                            </td>
                            <td class="px-4 py-4">
                                <c:set var="paceLower" value="${fn:toLowerCase(empty lop.nhipDo ? '' : lop.nhipDo)}" />
                                <c:set var="paceLabel" value="${paceLower eq 'cấp tốc' or paceLower eq 'cap toc' ? 'Cấp tốc' :
                                                               paceLower eq 'thường' or paceLower eq 'thuong' ? 'Thường' :
                                                               (empty lop.nhipDo ? '—' : lop.nhipDo)}" />
                                <c:set var="paceBadgeClass"
                                       value="${paceLower eq 'cấp tốc' or paceLower eq 'cap toc' ? 'bg-rose-100 text-rose-600' :
                                               paceLower eq 'thường' or paceLower eq 'thuong' ? 'bg-primary.pale text-primary' :
                                               'bg-slate-100 text-slate-600'}" />
                                <div class="flex flex-col gap-2">
                                    <span class="inline-flex items-center gap-2 rounded-full py-1 text-xs font-semibold ${paceBadgeClass}">
                                        <c:out value="${paceLabel}" />
                                    </span>
                                    <span class="text-xs text-slate-400">
                                        <c:out value="${empty gioMoiBuoiDisplay ? '--:--' : gioMoiBuoiDisplay}" /> giờ/buổi
                                    </span>
                                </div>
                            </td>
                            <td class="px-4 py-4">
                                <div class="space-y-1 text-sm">
                                    <p class="font-semibold text-slate-800">
                                        Bắt đầu: <c:out value="${empty ngayKhaiGiangDisplay ? '—' : ngayKhaiGiangDisplay}" />
                                    </p>
                                    <p class="text-xs text-slate-400">
                                        Kết thúc: <c:out value="${empty ngayKetThucDisplay ? '—' : ngayKetThucDisplay}" />
                                    </p>
                                    <c:if test="${not empty lop.thoiGianHoc}">
                                        <p class="text-xs text-slate-400">
                                            Lịch học: <c:out value="${lop.thoiGianHoc}" />
                                        </p>
                                    </c:if>
                                </div>
                            </td>
                            <td class="px-4 py-4">
                                <p class="font-semibold text-slate-800">
                                    <c:out value="${lop.soBuoi}" /> buổi
                                </p>
                            </td>
                            <td class="px-4 py-4">
                                <p class="font-semibold text-slate-800">
                                    <c:out value="${lop.siSoToiDa}" /> học viên
                                </p>
                            </td>
                            <td class="px-4 py-4">
                                <p class="font-semibold text-slate-800">
                                    <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />
                                    <span class="text-xs text-slate-500 ml-1">VND</span>
                                </p>
                            </td>
                            <td class="px-6 py-5 text-right">
                                <span class="inline-flex items-center justify-end gap-2 rounded-full px-2 py-1 text-[12px] font-semibold ${statusBadgeClass}">
                                    <c:out value="${statusText}" />
                                </span>
                            </td>
                            <td class="px-6 py-5 text-right space-x-2">
                                <a href="${pageContext.request.contextPath}/admin/classes/edit?id=${lop.id}"
                                        class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                    Sửa
                                </a>
                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/lop-on"
                                      class="inline js-delete-class-form"
                                      data-class-title="${fn:escapeXml(lop.tieuDe)}">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${lop.id}"/>
                                    <button type="submit"
                                            class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500 hover:bg-rose-100 transition"
                                            data-delete-trigger>
                                        Xoá
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:set var="currentPage" value="${empty currentPage ? 1 : currentPage}" />
            <c:set var="totalPages" value="${empty totalPages ? 1 : totalPages}" />
            <c:set var="pageSize" value="${empty pageSize ? 5 : pageSize}" />
            <c:set var="totalRecords" value="${empty totalRecords ? 0 : totalRecords}" />
            <c:set var="startRecord" value="${empty startRecord ? 0 : startRecord}" />
            <c:set var="endRecord" value="${empty endRecord ? 0 : endRecord}" />
            
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40">
                <div class="flex items-center gap-4 text-xs text-slate-600">
                    <p>
                        <c:choose>
                            <c:when test="${totalRecords > 0}">
                                Hiển thị <strong class="text-slate-900"><c:out value="${startRecord}" /></strong> - 
                                <strong class="text-slate-900"><c:out value="${endRecord}" /></strong> trong tổng số 
                                <strong class="text-slate-900"><c:out value="${totalRecords}" /></strong> lớp ôn.
                            </c:when>
                            <c:otherwise>
                                Không có dữ liệu để hiển thị.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${totalRecords > 0}">
                        <div class="flex items-center gap-2">
                            <label for="page-size-select" class="text-slate-500">Hiển thị:</label>
                            <select id="page-size-select" 
                                    class="rounded-xl border border-blue-100 bg-white px-3 py-1.5 text-xs text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option value="5" <c:if test="${pageSize == 5}">selected</c:if>>5</option>
                                <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10</option>
                                <option value="20" <c:if test="${pageSize == 20}">selected</c:if>>20</option>
                                <option value="50" <c:if test="${pageSize == 50}">selected</c:if>>50</option>
                            </select>
                        </div>
                    </c:if>
                </div>
                
                <c:if test="${totalRecords > 0}">
                    <nav class="flex items-center gap-2" aria-label="Phân trang">
                        <c:set var="basePath" value="${pageContext.request.contextPath}/admin/classes" />
                        <c:set var="queryString" value="${classFilterParams.buildQueryString(currentPage > 1 ? currentPage - 1 : 1, pageSize)}" />
                        <c:set var="prevUrl" value="${basePath}?${queryString}" />
                        
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
                                        <c:set var="pageQuery" value="${classFilterParams.buildQueryString(page, pageSize)}" />
                                        <c:set var="pageUrl" value="${basePath}?${pageQuery}" />
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
                        
                        <c:set var="nextQuery" value="${classFilterParams.buildQueryString(currentPage < totalPages ? currentPage + 1 : totalPages, pageSize)}" />
                        <c:set var="nextUrl" value="${basePath}?${nextQuery}" />
                        
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
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-slate-900">Tiến trình đào tạo nổi bật</h3>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Xuất báo cáo
                    </button>
                </div>
                <div class="grid gap-4 md:grid-cols-2">
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <span class="text-xs font-semibold uppercase tracking-widest text-primary/70">NE3 · Tuần 5</span>
                            <span class="text-xs font-semibold text-emerald-500">Tiến độ 45%</span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Chủ đề: Kỹ năng nghe nâng cao</h4>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• Đã hoàn thành 2/3 bài nghe</li>
                            <li>• Bổ sung tài liệu luyện phản xạ</li>
                            <li>• 4 học viên cần hỗ trợ thêm</li>
                        </ul>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <span class="text-xs font-semibold uppercase tracking-widest text-primary/70">CB1 · Tuần 7</span>
                            <span class="text-xs font-semibold text-emerald-500">Tiến độ 72%</span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Chủ đề: Từ vựng chủ đạo</h4>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• Hoàn thành 5/6 bài tập mới</li>
                            <li>• 12 học viên đã đăng ký ca thi</li>
                            <li>• Đề xuất kiểm tra giữa khóa</li>
                        </ul>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <span class="text-xs font-semibold uppercase tracking-widest text-primary/70">CT2 · Tuần 2</span>
                            <span class="text-xs font-semibold text-orange-500">Tiến độ 20%</span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Chủ đề: Luyện nghe chuyên sâu</h4>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• Tỉ lệ chuyên cần 98%</li>
                            <li>• Thi thử trung bình 6.5</li>
                            <li>• Cần bổ sung 5 bộ đề mẫu</li>
                        </ul>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <span class="text-xs font-semibold uppercase tracking-widest text-primary/70">ONL1 · Tuần 4</span>
                            <span class="text-xs font-semibold text-emerald-500">Tiến độ 60%</span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Chủ đề: Luyện nói online</h4>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• 3 buổi qua Zoom</li>
                            <li>• 94% học viên hoàn thành bài tập</li>
                            <li>• Feedback tích cực từ học viên</li>
                        </ul>
                    </article>
                </div>
            </div>

            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-5">
                <h3 class="text-lg font-semibold text-slate-900">Công việc ưu tiên trong tuần</h3>
                <div class="space-y-4 text-sm text-slate-600">
                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <p class="font-semibold text-slate-800">Xem xét mở thêm lớp cơ bản</p>
                        <p class="text-xs text-slate-400">Danh sách chờ 20 học viên · đề xuất lịch tối thứ 2-4-6.</p>
                    </div>
                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <p class="font-semibold text-slate-800">Cập nhật tài liệu NE3</p>
                        <p class="text-xs text-slate-400">Bổ sung bài nghe theo khung đề 2025 trước 12/11.</p>
                    </div>
                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <p class="font-semibold text-slate-800">Đào tạo giảng viên dự phòng</p>
                        <p class="text-xs text-slate-400">Chuẩn bị cho lớp cấp tốc tháng 12 · 2 giảng viên mới.</p>
                    </div>
                </div>
                <button class="w-full inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                    Xem thêm 6 công việc
                </button>
            </div>
        </section>
        </main>
    </div>
</div>

<!-- Import modal -->
<div id="class-import-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Nhập danh sách lớp</h3>
                <p class="text-xs text-slate-500 mt-1">Tải lên file Excel theo đúng định dạng của hệ thống.</p>
            </div>
            <button data-modal-close="class-import-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6">
            <div class="rounded-2xl border-2 border-dashed border-blue-100 bg-primary.pale/40 px-6 py-10 text-center">
                <p class="text-sm font-semibold text-slate-800">Kéo & thả file vào đây</p>
                <p class="text-xs text-slate-500 mt-2">Hỗ trợ .xlsx, .csv · dung lượng tối đa 10MB</p>
                <button class="mt-4 inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                    Chọn file từ máy
                </button>
            </div>
            <div class="flex items-start gap-3 text-xs text-slate-500">
                <span class="mt-0.5 inline-block h-2 w-2 rounded-full bg-primary"></span>
                Bạn có thể tải <a href="#" class="text-primary font-semibold hover:text-primary/80">mẫu template chuẩn</a> để đảm bảo dữ liệu hợp lệ.
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="class-import-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Nhập dữ liệu
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const deleteForms = document.querySelectorAll('.js-delete-class-form');
        if (!deleteForms.length || typeof Swal === 'undefined') {
            return;
        }

        deleteForms.forEach(form => {
            form.addEventListener('submit', (event) => {
                event.preventDefault();
                const className = form.dataset.classTitle || 'lớp này';

                Swal.fire({
                    title: 'Bạn chắc chắn?',
                    html: `<p class="text-sm text-slate-500">Bạn sắp xoá <span class="font-semibold text-slate-700">"${className}"</span> khỏi hệ thống.</p>
                           <p class="text-xs text-slate-400 mt-2">Thao tác này không thể hoàn tác.</p>`,
                    icon: 'warning',
                    showCancelButton: true,
                    focusCancel: true,
                    confirmButtonText: 'Xoá lớp',
                    cancelButtonText: 'Huỷ',
                    customClass: {
                        popup: 'rounded-3xl shadow-2xl border border-rose-100',
                        confirmButton: 'swal2-confirm-btn',
                        cancelButton: 'swal2-cancel-btn'
                    },
                    buttonsStyling: false,
                    didOpen: () => {
                        const confirmBtn = Swal.getConfirmButton();
                        const cancelBtn = Swal.getCancelButton();
                        if (confirmBtn) {
                            confirmBtn.className = 'rounded-full bg-rose-500 text-white px-5 py-2 text-sm font-semibold hover:bg-rose-600 transition';
                        }
                        if (cancelBtn) {
                            cancelBtn.className = 'rounded-full border border-slate-200 bg-white text-slate-600 px-5 py-2 text-sm font-semibold hover:text-primary transition';
                        }
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            }, { passive: false });
        });

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
    });
</script>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


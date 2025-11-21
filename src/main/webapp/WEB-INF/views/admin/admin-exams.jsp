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
    <title>Quản lý ca thi | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="exams" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Quản lý ca thi</h2>
                    <p class="text-sm text-slate-500 mt-1">Lập lịch thi, phân bổ phòng và điều phối giám sát viên.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <a href="${pageContext.request.contextPath}/admin/exams/create"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v12"/>
                            <path d="M6 12h12"/>
                        </svg>
                        Tạo ca thi
                    </a>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    <c:out value="${not empty totalExams ? totalExams : 0}" /> ca thi · cập nhật
                    <fmt:formatDate value="${lastUpdatedAt}" pattern="HH:mm" />
                </span>
                <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                    <c:out value="${not empty totalRegistrations ? totalRegistrations : 0}" /> đăng ký
                </span>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng ca thi</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${not empty totalExams ? totalExams : 0}" />
                    </p>
                </div>
                <p class="text-xs text-slate-400">Tất cả ca thi trong hệ thống.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Thí sinh đăng ký</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <c:out value="${not empty totalRegistrations ? totalRegistrations : 0}" />
                    </p>
                </div>
                <p class="text-xs text-slate-400">Tổng số đăng ký ca thi.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng doanh thu</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">
                        <fmt:formatNumber value="${not empty totalRevenue ? totalRevenue : 0}" type="number" groupingUsed="true" />đ
                    </p>
                </div>
                <p class="text-xs text-slate-400">Tổng số tiền từ đăng ký ca thi.</p>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Bộ lọc ca thi</h3>
                    <p class="text-xs text-slate-500 mt-1">Chọn ngày, địa điểm và tình trạng để lọc dữ liệu.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <c:choose>
                        <c:when test="${not empty filterDate || not empty filterLocation || (not empty filterStatus && filterStatus != 'all') || not empty searchQuery}">
                            <c:if test="${not empty filterDate}">
                                <c:set var="filterDateParts" value="${fn:split(filterDate, '-')}" />
                                <c:set var="filterDateFormatted" value="${filterDateParts[2]}/${filterDateParts[1]}/${filterDateParts[0]}" />
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Ngày thi</span>
                                    <span class="text-slate-600 text-xs">
                                        <c:out value="${filterDateFormatted}" />
                                    </span>
                                    <a href="${pageContext.request.contextPath}/admin/exams?${fn:replace(pageContext.request.queryString, '&filterDate='.concat(filterDate), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc ngày thi">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty filterLocation}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Địa điểm</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${filterLocation}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/exams?${fn:replace(pageContext.request.queryString, '&filterLocation='.concat(fn:escapeXml(filterLocation)), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc địa điểm">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty filterStatus && filterStatus != 'all'}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Trạng thái</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${filterStatus}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/exams?${fn:replace(pageContext.request.queryString, '&filterStatus='.concat(filterStatus), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc trạng thái">×</a>
                                </span>
                            </c:if>
                            <c:if test="${not empty searchQuery}">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                                    <span class="font-semibold uppercase tracking-widest text-[11px] text-primary/80">Tìm kiếm</span>
                                    <span class="text-slate-600 text-xs"><c:out value="${searchQuery}" /></span>
                                    <a href="${pageContext.request.contextPath}/admin/exams?${fn:replace(pageContext.request.queryString, '&search='.concat(fn:escapeXml(searchQuery)), '')}"
                                       class="hover:text-primary/70 transition"
                                       aria-label="Xoá bộ lọc tìm kiếm">×</a>
                                </span>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/admin/exams"
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

            <form id="exam-filter-form"
                  method="get"
                  action="${pageContext.request.contextPath}/admin/exams"
                  class="space-y-5">
                <input type="hidden" name="page" value="1" />
                <c:if test="${not empty pageSize}">
                    <input type="hidden" name="pageSize" value="${pageSize}" />
                </c:if>
                <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
                    <div>
                        <label for="filter-date" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Ngày thi
                        </label>
                        <input id="filter-date"
                               name="filterDate"
                               type="date"
                               value="${filterDate}"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                    <div>
                        <label for="filter-location" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Địa điểm
                        </label>
                        <select id="filter-location"
                                name="filterLocation"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="">Tất cả địa điểm</option>
                            <c:forEach var="option" items="${locationOptions}">
                                <option value="${option}"
                                        <c:if test="${not empty filterLocation and fn:toLowerCase(option) eq fn:toLowerCase(filterLocation)}">selected</c:if>>
                                    <c:out value="${option}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-status" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Tình trạng
                        </label>
                        <select id="filter-status"
                                name="filterStatus"
                                class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option value="all">Tất cả tình trạng</option>
                            <c:forEach var="option" items="${statusOptions}">
                                <option value="${option}"
                                        <c:if test="${not empty filterStatus and fn:toLowerCase(option) eq fn:toLowerCase(filterStatus)}">selected</c:if>>
                                    <c:out value="${option}" />
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <label for="filter-search" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                            Tìm kiếm
                        </label>
                        <div class="relative mt-2">
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
                                   placeholder="Tìm theo mã ca thi, địa điểm..."
                                   class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                    </div>
                </div>

                <div class="flex items-center gap-3">
                    <a href="${pageContext.request.contextPath}/admin/exams"
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

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex items-center justify-between">
                <h3 class="text-lg font-semibold text-slate-900">Danh sách ca thi</h3>
            </div>
            <div class="grid gap-4 md:grid-cols-2">
                <c:choose>
                    <c:when test="${not empty examsWithDetails}">
                        <c:forEach var="examDetail" items="${examsWithDetails}">
                            <c:set var="caThi" value="${examDetail.caThi}" />
                            <c:set var="soLuongDangKy" value="${examDetail.soLuongDangKy}" />
                            <c:set var="trangThai" value="${examDetail.trangThai}" />
                            <c:set var="isFull" value="${examDetail.isFull}" />
                            <article class="rounded-2xl border border-blue-50 ${isFull ? 'bg-slate-50' : 'bg-white'} px-4 py-4 shadow-sm space-y-3">
                                <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                                    <span>
                                        <c:if test="${not empty caThi.ngayThi}">
                                            <fmt:formatDate value="${caThi.ngayThi}" pattern="dd/MM/yyyy" />
                                        </c:if>
                                        <c:if test="${not empty caThi.gioBatDau}">
                                            <span class="ml-1">
                                                <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty caThi.gioKetThuc}">
                                            <span class="ml-1">- <fmt:formatDate value="${caThi.gioKetThuc}" pattern="HH:mm" /></span>
                                        </c:if>
                                    </span>
                                    <span class="inline-flex items-center gap-1 rounded-full ${trangThai == 'Đã đầy' ? 'bg-blue-100 text-primary' : (trangThai == 'Gần đầy' ? 'bg-orange-100 text-orange-500' : (trangThai == 'Hoàn thành' ? 'bg-slate-200 text-slate-600' : 'bg-emerald-100 text-emerald-600'))} px-2 py-1 text-[11px] font-semibold">
                                        <c:out value="${trangThai}" />
                                    </span>
                                </div>
                                <h4 class="text-sm font-semibold text-slate-900">
                                    <c:choose>
                                        <c:when test="${not empty caThi.maCaThi}">
                                            <c:out value="${caThi.maCaThi}" />
                                        </c:when>
                                        <c:otherwise>
                                            Ca thi #<c:out value="${caThi.id}" />
                                        </c:otherwise>
                                    </c:choose>
                                </h4>
                                <p class="text-xs text-slate-500">
                                    <c:out value="${not empty caThi.diaDiem ? caThi.diaDiem : 'Chưa có địa điểm'}" /> · 
                                    <c:out value="${soLuongDangKy}" />/<c:out value="${caThi.sucChua}" /> thí sinh
                                </p>
                                <div class="flex items-center justify-between text-xs text-slate-400">
                                    <span>
                                        <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                    </span>
                                    <div class="flex items-center gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/export-exam-students?caThiId=${caThi.id}"
                                           class="inline-flex items-center gap-1 rounded-full border border-emerald-100 bg-emerald-50 px-3 py-1.5 text-[11px] font-semibold text-emerald-600 hover:bg-emerald-100 transition"
                                           title="Xuất danh sách thí sinh ra Excel">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                <path d="M12 3v12m0 0l-5-5m5 5l5-5M3 21h18"/>
                                            </svg>
                                            Excel
                                        </a>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/ca-thi" style="display:inline" class="js-delete-exam-form" data-exam-id="${caThi.id}">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${caThi.id}">
                                            <button type="submit" 
                                                    class="text-red-500 font-semibold hover:text-red-700 text-xs">Xóa</button>
                                        </form>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-span-2 text-center py-12 text-slate-400">
                            <p class="text-sm">Chưa có ca thi nào</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <c:set var="currentPage" value="${empty currentPage ? 1 : currentPage}" />
            <c:set var="totalPages" value="${empty totalPages ? 1 : totalPages}" />
            <c:set var="pageSize" value="${empty pageSize ? 5 : pageSize}" />
            <c:set var="totalRecords" value="${empty totalRecords ? 0 : totalRecords}" />
            <c:set var="startRecord" value="${empty startRecord ? 0 : startRecord}" />
            <c:set var="endRecord" value="${empty endRecord ? 0 : endRecord}" />
            
            <c:if test="${totalRecords > 0}">
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 pt-6 border-t border-blue-50">
                    <div class="flex items-center gap-4 text-xs text-slate-600">
                        <p>
                            <c:choose>
                                <c:when test="${totalRecords > 0}">
                                    Hiển thị <strong class="text-slate-900"><c:out value="${startRecord}" /></strong> - 
                                    <strong class="text-slate-900"><c:out value="${endRecord}" /></strong> trong tổng số 
                                    <strong class="text-slate-900"><c:out value="${totalRecords}" /></strong> ca thi.
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
                    
                    <nav class="flex items-center gap-2" aria-label="Phân trang">
                        <c:set var="basePath" value="${pageContext.request.contextPath}/admin/exams" />
                        
                        <c:url var="prevUrl" value="/admin/exams">
                            <c:param name="page" value="${currentPage > 1 ? currentPage - 1 : 1}"/>
                            <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                            <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                            <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
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
                                        <c:url var="pageUrl" value="/admin/exams">
                                            <c:param name="page" value="${page}"/>
                                            <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                                            <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                                            <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
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
                        
                        <c:url var="nextUrl" value="/admin/exams">
                            <c:param name="page" value="${currentPage < totalPages ? currentPage + 1 : totalPages}"/>
                            <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                            <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                            <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
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
                </div>
            </c:if>
        </section>
        </main>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Kiểm tra SweetAlert2 đã được load
        if (typeof Swal === 'undefined') {
            console.error('SweetAlert2 chưa được load!');
            return;
        }

        // Xử lý xác nhận xóa ca thi
        const deleteForms = document.querySelectorAll('.js-delete-exam-form');
        deleteForms.forEach(form => {
            form.addEventListener('submit', (event) => {
                event.preventDefault();
                event.stopPropagation();
                const examId = form.dataset.examId || '';

                Swal.fire({
                    title: 'Bạn chắc chắn?',
                    html: `<p class="text-sm text-slate-500">Bạn sắp xoá ca thi <span class="font-semibold text-slate-700">#${examId}</span> khỏi hệ thống.</p>
                           <p class="text-xs text-slate-400 mt-2">Thao tác này không thể hoàn tác.</p>`,
                    icon: 'warning',
                    showCancelButton: true,
                    focusCancel: true,
                    confirmButtonText: 'Xoá ca thi',
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
                        // Tạo form mới để submit, tránh conflict
                        const formData = new FormData(form);
                        const action = form.getAttribute('action');
                        const method = form.getAttribute('method') || 'post';
                        
                        const hiddenForm = document.createElement('form');
                        hiddenForm.method = method;
                        hiddenForm.action = action;
                        hiddenForm.style.display = 'none';
                        
                        formData.forEach((value, key) => {
                            const input = document.createElement('input');
                            input.type = 'hidden';
                            input.name = key;
                            input.value = value;
                            hiddenForm.appendChild(input);
                        });
                        
                        document.body.appendChild(hiddenForm);
                        hiddenForm.submit();
                    }
                });
            });
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

        // Xử lý flash messages
        <c:if test="${not empty examFlashMessage}">
            const flashType = '${examFlashType}';
            const flashMessage = '${examFlashMessage}';
            const icon = flashType === 'success' ? 'success' : flashType === 'error' ? 'error' : 'info';
            
            Swal.fire({
                icon: icon,
                title: flashType === 'success' ? 'Thành công!' : flashType === 'error' ? 'Lỗi!' : 'Thông báo',
                text: flashMessage,
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 4000,
                timerProgressBar: true,
                customClass: {
                    popup: 'rounded-2xl shadow-lg'
                }
            });
        </c:if>
    });
</script>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách ca thi | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        .flatpickr-input {
            width: 100%;
            border-radius: 0.5rem;
            border: 1px solid rgba(59, 130, 246, 0.2);
            background-color: #ffffff;
            padding: 0.625rem 1rem;
            font-size: 0.875rem;
            line-height: 1.25rem;
            color: #1f2937;
            box-shadow: 0 1px 2px rgba(15, 23, 42, 0.05);
            transition: all 0.18s ease;
        }
        .flatpickr-input:focus {
            border-color: rgba(37, 99, 235, 0.45);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.18);
        }
        .flatpickr-calendar {
            border-radius: 1rem;
            border: 1px solid rgba(59, 130, 246, 0.08);
            box-shadow: 0 20px 45px rgba(15, 23, 42, 0.12);
        }
        .date-input-wrapper {
            position: relative;
        }
        .date-input-wrapper svg {
            position: absolute;
            right: 0.85rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            pointer-events: none;
            width: 1rem;
            height: 1rem;
        }
    </style>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Ca thi VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Đăng ký ca thi VSTEP và sẵn sàng chinh phục chứng chỉ
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed max-w-3xl">
                        Chọn ca thi phù hợp với lịch trình của bạn. Nếu bạn đã từng thi VSTEP, bạn sẽ được giảm giá 500.000đ tự động.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-100">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            <c:out value="${empty totalExams ? 0 : totalExams}" /> ca thi đang mở
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Giảm giá 500.000đ cho thí sinh thi lại
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Đăng ký nhanh chóng, xác nhận trong 24h
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-6 py-8 shadow-soft text-slate-700 bg-white/90">
                    <p class="text-sm font-semibold text-slate-900">Thống kê nhanh</p>
                    <ul class="mt-4 space-y-3 text-xs text-slate-600">
                        <li class="flex items-center justify-between">
                            <span>Tổng ca thi</span>
                            <span class="font-semibold text-slate-900"><c:out value="${empty totalExams ? 0 : totalExams}" /></span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Đã đăng ký</span>
                            <span class="font-semibold text-slate-900"><c:out value="${empty totalRegistrations ? 0 : totalRegistrations}" /></span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Còn chỗ</span>
                            <span class="font-semibold text-emerald-600"><c:out value="${empty totalAvailable ? 0 : totalAvailable}" /></span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-6xl mx-auto px-6 space-y-10">
            
            <!-- Filter Section -->
            <div class="glass rounded-2xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                <form method="get" action="${pageContext.request.contextPath}/ca" class="space-y-4">
                    <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                        <!-- Search -->
                        <div class="lg:col-span-2">
                            <label class="block text-xs font-semibold text-slate-700 mb-2">Tìm kiếm</label>
                            <input type="text" name="search" value="${searchQuery}" 
                                   placeholder="Tìm theo mã ca thi, địa điểm..."
                                   class="w-full rounded-lg border border-blue-200 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition">
                        </div>
                        
                        <!-- Filter by Date -->
                        <div>
                            <label class="block text-xs font-semibold text-slate-700 mb-2">Ngày thi</label>
                            <div class="date-input-wrapper mt-2">
                                <input type="text" id="filterDate" name="filterDate" 
                                       value="${filterDate != null ? filterDate : ''}"
                                       placeholder="Chọn ngày thi (dd/mm/yyyy)"
                                       class="w-full rounded-lg border border-blue-200 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition pr-10 cursor-pointer">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="M7 4V2M17 4V2M3 9h18M3 18h18M4 4h16v14H4z"/>
                                </svg>
                            </div>
                        </div>
                        
                        <!-- Filter by Status -->
                        <div>
                            <label class="block text-xs font-semibold text-slate-700 mb-2">Trạng thái</label>
                            <select name="filterStatus"
                                    class="w-full rounded-lg border border-blue-200 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition bg-white cursor-pointer">
                                <option value="all" ${filterStatus == 'all' || empty filterStatus ? 'selected' : ''}>Tất cả</option>
                                <option value="available" ${filterStatus == 'available' ? 'selected' : ''}>Còn chỗ</option>
                                <option value="almostFull" ${filterStatus == 'almostFull' ? 'selected' : ''}>Sắp đầy (≤5 chỗ)</option>
                                <option value="full" ${filterStatus == 'full' ? 'selected' : ''}>Đã đầy</option>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Second Row Filters -->
                    <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                        <!-- Filter by Location -->
                        <div>
                            <label class="block text-xs font-semibold text-slate-700 mb-2">Địa điểm</label>
                            <select name="filterLocation"
                                    class="w-full rounded-lg border border-blue-200 px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition bg-white cursor-pointer">
                                <option value="">Tất cả địa điểm</option>
                                <c:forEach var="location" items="${locationOptions}">
                                    <option value="${location}" ${filterLocation == location ? 'selected' : ''}>
                                        <c:out value="${location}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Filter Buttons -->
                        <div class="lg:col-span-2 flex items-end gap-2">
                            <button type="submit"
                                    class="flex-1 rounded-lg bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-primary/90 transition">
                                Lọc kết quả
                            </button>
                            <a href="${pageContext.request.contextPath}/ca"
                               class="flex items-center justify-center rounded-lg border border-blue-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 hover:bg-blue-50 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Preserve page parameter if exists -->
                    <c:if test="${not empty param.page}">
                        <input type="hidden" name="page" value="${param.page}">
                    </c:if>
                </form>
            </div>
            
            <!-- Results Info -->
            <div class="flex items-center justify-between text-sm text-slate-600">
                <div>
                    <span class="font-semibold text-slate-900"><c:out value="${empty totalRecords ? 0 : totalRecords}" /></span> ca thi được tìm thấy
                    <c:if test="${not empty searchQuery || not empty filterDate || (filterStatus != 'all' && not empty filterStatus) || not empty filterLocation}">
                        <span class="text-slate-400">· Đã áp dụng bộ lọc</span>
                    </c:if>
                </div>
                <c:if test="${not empty totalRecords && totalRecords > 0}">
                    <div class="text-slate-500">
                        Hiển thị <c:out value="${empty startRecord ? 0 : startRecord}" />-<c:out value="${empty endRecord ? 0 : endRecord}" /> trong tổng số <c:out value="${totalRecords}" /> ca thi
                    </div>
                </c:if>
            </div>
            
            <c:choose>
                <c:when test="${not empty caThiListWithDetails}">
                    <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                        <c:forEach var="detail" items="${caThiListWithDetails}">
                            <c:set var="caThi" value="${detail.caThi}" />
                            <c:set var="soLuongDangKy" value="${detail.soLuongDangKy}" />
                            <c:set var="conCho" value="${caThi.sucChua - soLuongDangKy}" />
                            <article class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft hover:shadow-xl transition ${soLuongDangKy >= caThi.sucChua ? 'opacity-60' : ''}">
                                <div class="space-y-4">
                                    <div class="flex items-center justify-between">
                                        <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                            <c:choose>
                                                <c:when test="${not empty caThi.maCaThi}">
                                                    <c:out value="${caThi.maCaThi}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Ca thi #<c:out value="${caThi.id}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                        <c:choose>
                                            <c:when test="${soLuongDangKy >= caThi.sucChua}">
                                                <span class="inline-flex items-center gap-1 rounded-full bg-red-100 px-2 py-1 text-[11px] font-semibold text-red-600">
                                                    Đã đầy
                                                </span>
                                            </c:when>
                                            <c:when test="${conCho <= 5}">
                                                <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2 py-1 text-[11px] font-semibold text-orange-500">
                                                    Còn <c:out value="${conCho}" /> chỗ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-600">
                                                    Còn chỗ
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <div class="space-y-2">
                                        <div class="flex items-center gap-2 text-sm text-slate-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                <path d="M7 4V2M17 4V2M3 9h18M3 18h18M4 4h16v14H4z"/>
                                            </svg>
                                            <c:if test="${not empty caThi.ngayThi}">
                                                <fmt:formatDate value="${caThi.ngayThi}" pattern="dd/MM/yyyy" />
                                            </c:if>
                                        </div>
                                        <div class="flex items-center gap-2 text-sm text-slate-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                <path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                            </svg>
                                            <c:if test="${not empty caThi.gioBatDau}">
                                                <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                            </c:if>
                                            <c:if test="${not empty caThi.gioKetThuc}">
                                                - <fmt:formatDate value="${caThi.gioKetThuc}" pattern="HH:mm" />
                                            </c:if>
                                        </div>
                                        <div class="flex items-center gap-2 text-sm text-slate-600">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                <path d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                                <path d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                            </svg>
                                            <c:out value="${not empty caThi.diaDiem ? caThi.diaDiem : 'Chưa có địa điểm'}" />
                                        </div>
                                    </div>

                                    <div class="space-y-2 pt-2 border-t border-blue-100">
                                        <div class="flex items-center justify-between text-sm">
                                            <span class="text-slate-500">Sức chứa:</span>
                                            <span class="font-semibold text-slate-900">
                                                <c:out value="${soLuongDangKy}" />/<c:out value="${caThi.sucChua}" />
                                            </span>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <span class="text-sm text-slate-500">Giá gốc:</span>
                                            <span class="text-lg font-bold text-primary">
                                                <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                            </span>
                                        </div>
                                        <div class="flex items-center justify-between text-xs text-emerald-600">
                                            <span>Giảm giá thi lại:</span>
                                            <span class="font-semibold">-500.000đ</span>
                                        </div>
                                    </div>

                                    <c:choose>
                                        <c:when test="${soLuongDangKy >= caThi.sucChua}">
                                            <button disabled
                                                    class="w-full rounded-full border border-slate-200 bg-slate-100 px-5 py-2.5 text-sm font-semibold text-slate-400 cursor-not-allowed">
                                                Đã đầy
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/dang-ky-thi?caThiId=${caThi.id}"
                                               class="block w-full text-center rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                                Đăng ký ngay
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                    
                    <!-- Pagination -->
                    <c:if test="${not empty totalPages && totalPages > 1}">
                        <c:set var="currentPageNum" value="${empty currentPage ? 1 : currentPage}" />
                        <c:set var="currentPageSize" value="${empty pageSize ? 6 : pageSize}" />
                        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mt-8">
                            <div class="flex flex-col sm:flex-row sm:items-center gap-4">
                                <p class="text-xs text-slate-500">
                                    <c:choose>
                                        <c:when test="${totalRecords > 0}">
                                            Hiển thị <strong><c:out value="${startRecord}" /></strong> - <strong><c:out value="${endRecord}" /></strong> trên <strong><c:out value="${totalRecords}" /></strong> ca thi
                                        </c:when>
                                        <c:otherwise>
                                            Không có dữ liệu để hiển thị
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <!-- Page Size Selector -->
                                <form method="get" action="${pageContext.request.contextPath}/ca" class="flex items-center gap-2">
                                    <label class="text-xs text-slate-500">Hiển thị:</label>
                                    <select name="pageSize" onchange="this.form.submit()"
                                            class="rounded-lg border border-blue-200 px-3 py-1.5 text-xs focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition bg-white cursor-pointer">
                                        <option value="6" ${currentPageSize == 6 ? 'selected' : ''}>6</option>
                                        <option value="9" ${currentPageSize == 9 ? 'selected' : ''}>9</option>
                                        <option value="12" ${currentPageSize == 12 ? 'selected' : ''}>12</option>
                                        <option value="18" ${currentPageSize == 18 ? 'selected' : ''}>18</option>
                                    </select>
                                    <input type="hidden" name="page" value="1">
                                    <c:if test="${not empty searchQuery}"><input type="hidden" name="search" value="${searchQuery}"></c:if>
                                    <c:if test="${not empty filterDate}"><input type="hidden" name="filterDate" value="${filterDate}"></c:if>
                                    <c:if test="${not empty filterStatus && filterStatus != 'all'}"><input type="hidden" name="filterStatus" value="${filterStatus}"></c:if>
                                    <c:if test="${not empty filterLocation}"><input type="hidden" name="filterLocation" value="${filterLocation}"></c:if>
                                </form>
                            </div>
                            <nav class="inline-flex items-center rounded-full border border-blue-100 bg-white shadow-sm">
                                <!-- Previous Button -->
                                <c:choose>
                                    <c:when test="${currentPageNum > 1}">
                                        <c:url var="prevUrl" value="/ca">
                                            <c:param name="page" value="${currentPageNum - 1}"/>
                                            <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                            <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                                            <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
                                            <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                                            <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                        </c:url>
                                        <a href="${prevUrl}"
                                           class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-l-full">
                                            Trước
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-2 text-slate-400 opacity-50 cursor-not-allowed pointer-events-none rounded-l-full">
                                            Trước
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                                
                                <!-- Page Numbers -->
                                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                    <c:choose>
                                        <c:when test="${pageNum == currentPageNum}">
                                            <span class="px-3 py-2 text-white bg-primary rounded-full shadow-soft">
                                                <c:out value="${pageNum}" />
                                            </span>
                                        </c:when>
                                        <c:when test="${totalPages <= 7 || pageNum == 1 || pageNum == totalPages || (pageNum >= currentPageNum - 2 && pageNum <= currentPageNum + 2)}">
                                            <c:url var="pageUrl" value="/ca">
                                                <c:param name="page" value="${pageNum}"/>
                                                <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                                <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                                                <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
                                                <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                                                <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                            </c:url>
                                            <a href="${pageUrl}" class="px-3 py-2 text-slate-400 hover:text-primary transition">
                                                <c:out value="${pageNum}" />
                                            </a>
                                        </c:when>
                                        <c:when test="${pageNum == currentPageNum - 3 || pageNum == currentPageNum + 3}">
                                            <span class="px-3 py-2 text-slate-400">...</span>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                                
                                <!-- Next Button -->
                                <c:choose>
                                    <c:when test="${currentPageNum < totalPages}">
                                        <c:url var="nextUrl" value="/ca">
                                            <c:param name="page" value="${currentPageNum + 1}"/>
                                            <c:if test="${not empty searchQuery}"><c:param name="search" value="${searchQuery}"/></c:if>
                                            <c:if test="${not empty filterDate}"><c:param name="filterDate" value="${filterDate}"/></c:if>
                                            <c:if test="${not empty filterStatus && filterStatus != 'all'}"><c:param name="filterStatus" value="${filterStatus}"/></c:if>
                                            <c:if test="${not empty filterLocation}"><c:param name="filterLocation" value="${filterLocation}"/></c:if>
                                            <c:if test="${not empty pageSize}"><c:param name="pageSize" value="${pageSize}"/></c:if>
                                        </c:url>
                                        <a href="${nextUrl}"
                                           class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-r-full">
                                            Sau
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="px-3 py-2 text-slate-400 opacity-50 cursor-not-allowed pointer-events-none rounded-r-full">
                                            Sau
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </nav>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="glass rounded-3xl border border-blue-100 px-6 py-12 text-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mx-auto text-slate-400 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        <p class="text-lg font-semibold text-slate-700 mb-2">Không tìm thấy ca thi nào</p>
                        <p class="text-sm text-slate-500 mb-4">
                            <c:choose>
                                <c:when test="${not empty searchQuery || not empty filterDate || (filterStatus != 'all' && not empty filterStatus) || not empty filterLocation}">
                                    Không có ca thi nào phù hợp với bộ lọc của bạn. Vui lòng thử lại với bộ lọc khác.
                                </c:when>
                                <c:otherwise>
                                    Hiện tại chưa có ca thi nào được mở đăng ký. Vui lòng quay lại sau.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <c:if test="${not empty searchQuery || not empty filterDate || (filterStatus != 'all' && not empty filterStatus) || not empty filterLocation}">
                            <a href="${pageContext.request.contextPath}/ca"
                               class="inline-flex items-center gap-2 rounded-lg bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-primary/90 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                                </svg>
                                Xóa bộ lọc
                            </a>
                        </c:if>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Date picker cho filter ngày thi
    const filterDateInput = document.getElementById('filterDate');
    if (filterDateInput && typeof flatpickr !== 'undefined') {
        <c:set var="defaultFilterDate" value="${filterDate != null && !filterDate.isEmpty() ? filterDate : ''}" />
        const defaultDate = '<c:out value="${defaultFilterDate}" />';
        
        const flatpickrOptions = {
            altInput: true,
            altFormat: 'd/m/Y',
            dateFormat: 'Y-m-d',
            allowInput: true,
            locale: {
                firstDayOfWeek: 1
            },
            onReady: function(selectedDates, dateStr, instance) {
                const altInput = instance.altInput;
                if (altInput) {
                    altInput.classList.add('pr-10');
                    altInput.placeholder = 'Chọn ngày thi (dd/mm/yyyy)';
                }
            },
            onChange: function(selectedDates, dateStr, instance) {
                // Cập nhật alt input khi thay đổi
                if (instance.altInput && dateStr) {
                    instance.altInput.value = instance.formatDate(selectedDates[0], 'd/m/Y');
                }
            }
        };
        
        if (defaultDate && defaultDate.trim() !== '') {
            flatpickrOptions.defaultDate = defaultDate;
        }
        
        const fpFilterDate = flatpickr(filterDateInput, flatpickrOptions);
    }
});
</script>

</body>
</html>

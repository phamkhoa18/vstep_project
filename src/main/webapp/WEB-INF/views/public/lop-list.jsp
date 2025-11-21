<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách lớp ôn | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
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
                        Lớp ôn VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Tìm lớp ôn phù hợp và sẵn sàng đạt chứng chỉ VSTEP
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed max-w-3xl">
                        Mỗi lớp học đều có lộ trình rõ ràng, giảng viên giàu kinh nghiệm và chế độ hỗ trợ cá nhân hóa.
                        Dễ dàng lọc theo hình thức, cấp độ và thời gian để lựa chọn chương trình phù hợp với bạn.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-100">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            <c:out value="${empty dangMoCount ? 0 : dangMoCount}" /> lớp đang mở
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            <c:out value="${empty onlineCount ? 0 : onlineCount}" /> lớp trực tuyến · <c:out value="${empty offlineCount ? 0 : offlineCount}" /> lớp trực tiếp
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Cam kết hỗ trợ đến khi đạt mục tiêu
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-6 py-8 shadow-soft text-slate-700 bg-white/90">
                    <p class="text-sm font-semibold text-slate-900">Thống kê nhanh</p>
                    <ul class="mt-4 space-y-3 text-xs text-slate-600">
                        <li class="flex items-center justify-between">
                            <span>Lớp trực tiếp</span>
                            <span class="font-semibold text-slate-900"><c:out value="${empty offlineCount ? 0 : offlineCount}" /></span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Lớp trực tuyến</span>
                            <span class="font-semibold text-slate-900"><c:out value="${empty onlineCount ? 0 : onlineCount}" /></span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Tổng số lớp</span>
                            <span class="font-semibold text-slate-900"><c:out value="${empty totalRecords ? 0 : totalRecords}" /></span>
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
                <form method="get" action="${pageContext.request.contextPath}/lop" class="space-y-4" id="filter-form">
                    <input type="hidden" name="page" value="1" />
                    <c:if test="${not empty pageSize}">
                        <input type="hidden" name="pageSize" value="${pageSize}" />
                    </c:if>
                    
                    <div class="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                        <!-- Search -->
                        <div class="lg:col-span-2">
                            <label for="filter-keyword" class="block text-xs font-semibold text-slate-700 mb-2">Tìm kiếm</label>
                            <div class="relative mt-2">
                                <div class="absolute inset-y-0 left-4 flex items-center text-slate-400 pointer-events-none">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <circle cx="11" cy="11" r="7"/>
                                        <path d="M20 20l-3-3"/>
                                    </svg>
                                </div>
                                <input id="filter-keyword" name="keyword" type="search" 
                                       value="${not empty classFilterParams ? classFilterParams.keyword : ''}"
                                       placeholder="Tên lớp, giảng viên, mã lớp..."
                                       class="w-full rounded-lg border border-blue-200 bg-white pl-12 pr-4 py-2.5 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition">
                            </div>
                        </div>
                        
                        <!-- Filter by Format -->
                        <div>
                            <label for="filter-format" class="block text-xs font-semibold text-slate-700 mb-2">Hình thức</label>
                            <select id="filter-format" name="format" 
                                    class="mt-2 w-full rounded-lg border border-blue-200 bg-white px-4 py-2.5 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition cursor-pointer">
                                <option value="">Tất cả</option>
                                <c:forEach var="option" items="${formatOptions}">
                                    <option value="${option}" <c:if test="${not empty classFilterParams and not empty classFilterParams.format and fn:toLowerCase(option) eq fn:toLowerCase(classFilterParams.format)}">selected</c:if>>
                                        ${option}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <!-- Filter by Pace -->
                        <div>
                            <label for="filter-pace" class="block text-xs font-semibold text-slate-700 mb-2">Nhịp độ</label>
                            <select id="filter-pace" name="pace" 
                                    class="mt-2 w-full rounded-lg border border-blue-200 bg-white px-4 py-2.5 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition cursor-pointer">
                                <option value="">Tất cả nhịp độ</option>
                                <c:forEach var="option" items="${paceOptions}">
                                    <option value="${option}" <c:if test="${not empty classFilterParams and not empty classFilterParams.pace and fn:toLowerCase(option) eq fn:toLowerCase(classFilterParams.pace)}">selected</c:if>>
                                        ${option}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    
                    <!-- Filter Buttons -->
                    <div class="flex items-end gap-2">
                        <button type="submit" 
                                class="flex-1 rounded-lg bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-primary/90 transition">
                            Lọc kết quả
                        </button>
                        <a href="${pageContext.request.contextPath}/lop" 
                           class="flex items-center justify-center rounded-lg border border-blue-200 bg-white px-5 py-2.5 text-sm font-semibold text-slate-700 hover:bg-blue-50 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                        </a>
                    </div>
                </form>
                
                <c:if test="${not empty classFilterParams and hasActiveFilters}">
                    <div class="flex flex-wrap items-center gap-2 pt-4 border-t border-blue-100">
                        <span class="text-xs text-slate-500">Bộ lọc đang áp dụng:</span>
                        <c:forEach var="chip" items="${classFilterParams.toChips(pageContext.request.contextPath + '/lop')}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 border border-primary/20 px-3 py-1 text-primary text-xs font-semibold shadow-sm">
                                <span class="text-[11px] uppercase tracking-widest text-primary/80">${chip.label}</span>
                                <span class="text-slate-700">${chip.value}</span>
                                <a href="${chip.removeUrl}" class="hover:text-primary/70 transition text-slate-500 hover:text-slate-700" aria-label="Xoá bộ lọc ${chip.label}">×</a>
                            </span>
                        </c:forEach>
                        <a href="${pageContext.request.contextPath}/lop" class="text-xs text-primary font-semibold hover:text-primary/80 transition">
                            Xoá tất cả
                        </a>
                    </div>
                </c:if>
            </div>
            
            <!-- Results Info -->
            <div class="flex items-center justify-between text-sm text-slate-600">
                <div>
                    <span class="font-semibold text-slate-900"><c:out value="${empty totalRecords ? 0 : totalRecords}" /></span> lớp ôn được tìm thấy
                    <c:if test="${not empty classFilterParams and hasActiveFilters}">
                        <span class="text-slate-400">· Đã áp dụng bộ lọc</span>
                    </c:if>
                </div>
                <c:if test="${not empty totalRecords && totalRecords > 0}">
                    <div class="text-slate-500">
                        Hiển thị <c:out value="${empty startRecord ? 0 : startRecord}" />-<c:out value="${empty endRecord ? 0 : endRecord}" /> trong tổng số <c:out value="${totalRecords}" /> lớp ôn
                    </div>
                </c:if>
            </div>

            <div class="space-y-6">
                <c:set var="currentPage" value="${empty currentPage ? 1 : currentPage}" />
                <c:set var="totalPages" value="${empty totalPages ? 1 : totalPages}" />
                <c:set var="pageSize" value="${empty pageSize ? 6 : pageSize}" />
                <c:set var="totalRecords" value="${empty totalRecords ? 0 : totalRecords}" />
                <c:set var="startRecord" value="${empty startRecord ? 0 : startRecord}" />
                <c:set var="endRecord" value="${empty endRecord ? 0 : endRecord}" />
                
                <c:if test="${empty lopOnList}">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-12 text-center">
                        <p class="text-sm text-slate-500">Không tìm thấy lớp ôn nào phù hợp với bộ lọc của bạn.</p>
                        <a href="${pageContext.request.contextPath}/lop" class="mt-4 inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Xem tất cả lớp
                        </a>
                    </div>
                </c:if>
                
                <c:if test="${not empty lopOnList}">
                    <div class="grid gap-6 lg:grid-cols-2">
                        <c:forEach var="lop" items="${lopOnList}">
                            <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" var="ngayKhaiGiangDisplay" />
                            <fmt:formatDate value="${lop.gioMoiBuoi}" pattern="HH:mm" var="gioMoiBuoiDisplay" />
                            <c:set var="statusLower" value="${fn:toLowerCase(empty lop.tinhTrang ? '' : lop.tinhTrang)}" />
                            <c:set var="statusBadgeClass" 
                                   value="${statusLower eq 'đang mở' or statusLower eq 'dang mo' or statusLower eq 'dangmo' ? 'bg-emerald-100 text-emerald-600' :
                                           statusLower eq 'chuẩn bị' or statusLower eq 'chuan bi' or statusLower eq 'chuanbi' or statusLower eq 'sapmo' ? 'bg-orange-100 text-orange-500' :
                                           statusLower eq 'kết thúc' or statusLower eq 'ket thuc' or statusLower eq 'ketthuc' ? 'bg-slate-200 text-slate-600' :
                                           'bg-slate-100 text-slate-600'}" />
                            <c:set var="paceLower" value="${fn:toLowerCase(empty lop.nhipDo ? '' : lop.nhipDo)}" />
                            <c:set var="paceBadgeClass" 
                                   value="${paceLower eq 'cấp tốc' or paceLower eq 'cap toc' ? 'bg-orange-100 text-orange-500' :
                                           paceLower eq 'thường' or paceLower eq 'thuong' ? 'bg-primary/10 text-primary' :
                                           'bg-emerald-100 text-emerald-600'}" />
                            <c:set var="paceLabel" 
                                   value="${paceLower eq 'cấp tốc' or paceLower eq 'cap toc' ? 'Cấp tốc' :
                                           paceLower eq 'thường' or paceLower eq 'thuong' ? 'Thường' :
                                           (empty lop.nhipDo ? '—' : lop.nhipDo)}" />
                            
                            <article class="group rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition-all">
                                <div class="flex items-start justify-between gap-4">
                                    <div>
                                        <h2 class="text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                                            <c:out value="${lop.tieuDe}" />
                                        </h2>
                                        <div class="mt-2">
                                            <span class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-semibold ${statusBadgeClass}">
                                                <c:out value="${empty lop.tinhTrang ? 'Không xác định' : lop.tinhTrang}" />
                                            </span>
                                        </div>
                                        <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                            <c:out value="${empty lop.moTaNgan ? 'Lớp ôn luyện VSTEP chất lượng cao' : lop.moTaNgan}" />
                                        </p>
                                    </div>
                                    <span class="inline-flex items-center gap-2 rounded-full px-3 py-1 text-xs font-semibold ${paceBadgeClass}">
                                        <c:out value="${paceLabel}" />
                                    </span>
                                </div>
                                <div class="mt-6 grid gap-4 md:grid-cols-2 text-sm text-slate-600">
                                    <div>
                                        <p class="text-xs text-slate-400 uppercase tracking-widest">Lịch học</p>
                                        <p class="mt-1 font-semibold text-slate-800">
                                            <c:out value="${empty lop.thoiGianHoc ? 'Chưa cập nhật' : lop.thoiGianHoc}" />
                                            <c:if test="${not empty gioMoiBuoiDisplay}">
                                                · <c:out value="${gioMoiBuoiDisplay}" />
                                            </c:if>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-xs text-slate-400 uppercase tracking-widest">Khai giảng</p>
                                        <p class="mt-1 font-semibold text-slate-800">
                                            <c:out value="${empty ngayKhaiGiangDisplay ? 'Chưa xác định' : ngayKhaiGiangDisplay}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-xs text-slate-400 uppercase tracking-widest">Hình thức</p>
                                        <p class="mt-1 font-semibold text-slate-800">
                                            <c:out value="${empty lop.hinhThuc ? '—' : lop.hinhThuc}" />
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-xs text-slate-400 uppercase tracking-widest">Sĩ số</p>
                                        <c:set var="currentRegistered" value="${registeredCounts[lop.id]}" />
                                        <p class="mt-1 font-semibold text-slate-800">
                                            <c:out value="${empty currentRegistered ? 0 : currentRegistered}" /> / <c:out value="${lop.siSoToiDa}" /> học viên
                                        </p>
                                    </div>
                                </div>
                                <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                                    <p class="text-2xl font-bold text-primary">
                                        <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                    </p>
                                    <div class="flex flex-wrap gap-2">
                                        <c:choose>
                                            <c:when test="${not empty lop.slug}">
                                                <a href="${pageContext.request.contextPath}/lop/chi-tiet/${lop.slug}"
                                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                                    Xem chi tiết
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                        <path d="M9 5l7 7-7 7"/>
                                                    </svg>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/lop/chi-tiet?id=${lop.id}"
                                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                                    Xem chi tiết
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                        <path d="M9 5l7 7-7 7"/>
                                                    </svg>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                            <c:when test="${not empty currentRegistered && currentRegistered >= lop.siSoToiDa}">
                                                <span class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500">
                                                    Đã đủ chỗ
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/dang-ky-lop?lopId=${lop.id}"
                                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                                    Đăng ký ngay
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                    
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <p class="text-xs text-slate-500">
                            <c:choose>
                                <c:when test="${totalRecords > 0}">
                                    Hiển thị <strong><c:out value="${startRecord}" /></strong> - <strong><c:out value="${endRecord}" /></strong> trên <strong><c:out value="${totalRecords}" /></strong> lớp
                                </c:when>
                                <c:otherwise>
                                    Không có dữ liệu để hiển thị
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <nav class="inline-flex items-center rounded-full border border-blue-100 bg-white shadow-sm">
                            <c:set var="basePath" value="${pageContext.request.contextPath}/lop" />
                            <c:choose>
                                <c:when test="${not empty classFilterParams}">
                                    <c:set var="prevQuery" value="${classFilterParams.buildQueryString(currentPage > 1 ? currentPage - 1 : 1, pageSize)}" />
                                    <c:set var="nextQuery" value="${classFilterParams.buildQueryString(currentPage < totalPages ? currentPage + 1 : totalPages, pageSize)}" />
                                </c:when>
                                <c:otherwise>
                                    <c:set var="prevQuery" value="page=${currentPage > 1 ? currentPage - 1 : 1}&pageSize=${pageSize}" />
                                    <c:set var="nextQuery" value="page=${currentPage < totalPages ? currentPage + 1 : totalPages}&pageSize=${pageSize}" />
                                </c:otherwise>
                            </c:choose>
                            <c:set var="prevUrl" value="${basePath}?${prevQuery}" />
                            <c:set var="nextUrl" value="${basePath}?${nextQuery}" />
                            
                            <a href="${prevUrl}"
                               class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-l-full ${currentPage == 1 ? 'opacity-50 cursor-not-allowed pointer-events-none' : ''}">
                                Trước
                            </a>
                            
                            <c:forEach begin="1" end="${totalPages}" var="page">
                                <c:choose>
                                    <c:when test="${page == currentPage}">
                                        <span class="px-3 py-2 text-white bg-primary rounded-full shadow-soft">
                                            <c:out value="${page}" />
                                        </span>
                                    </c:when>
                                    <c:when test="${totalPages <= 7 || page == 1 || page == totalPages || (page >= currentPage - 2 && page <= currentPage + 2)}">
                                        <c:choose>
                                            <c:when test="${not empty classFilterParams}">
                                                <c:set var="pageQuery" value="${classFilterParams.buildQueryString(page, pageSize)}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="pageQuery" value="page=${page}&pageSize=${pageSize}" />
                                            </c:otherwise>
                                        </c:choose>
                                        <c:set var="pageUrl" value="${basePath}?${pageQuery}" />
                                        <a href="${pageUrl}" class="px-3 py-2 text-slate-400 hover:text-primary transition">
                                            <c:out value="${page}" />
                                        </a>
                                    </c:when>
                                    <c:when test="${page == currentPage - 3 || page == currentPage + 3}">
                                        <span class="px-3 py-2 text-slate-400">...</span>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                            
                            <a href="${nextUrl}"
                               class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-r-full ${currentPage >= totalPages ? 'opacity-50 cursor-not-allowed pointer-events-none' : ''}">
                                Sau
                            </a>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


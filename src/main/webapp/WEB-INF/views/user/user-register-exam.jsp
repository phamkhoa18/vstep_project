<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setTimeZone value="Asia/Ho_Chi_Minh" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký ca thi | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-6xl mx-auto px-6 space-y-8">
        <c:choose>
            <c:when test="${empty caThi}">
                <!-- Danh sách ca thi để chọn -->
                <div class="space-y-4 text-center">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                        Đăng ký ca thi
                    </span>
                    <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Chọn ca thi để đăng ký</h1>
                    <p class="text-sm text-slate-500 max-w-2xl mx-auto">
                        Chọn một ca thi phù hợp với lịch trình của bạn. Nếu bạn đã từng thi, bạn sẽ được giảm giá 500.000đ.
                    </p>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
                        <c:out value="${errorMessage}" />
                    </div>
                </c:if>

                <!-- Hiển thị các đăng ký của user -->
                <c:choose>
                    <c:when test="${not empty userRegistrationsWithDetails and userRegistrationsWithDetails.size() > 0}">
                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                        <div class="flex items-center justify-between mb-4">
                            <h2 class="text-lg font-semibold text-slate-900">Các đăng ký của bạn</h2>
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                <c:out value="${userRegistrationsWithDetails.size()}" /> đăng ký
                            </span>
                        </div>
                        <div class="space-y-3">
                            <c:forEach var="regDetail" items="${userRegistrationsWithDetails}">
                                <c:set var="dk" value="${regDetail.dangKyThi}" />
                                <c:set var="ct" value="${regDetail.caThi}" />
                                <c:if test="${not empty dk}">
                                <div class="rounded-2xl border border-blue-100 bg-primary.pale/40 px-5 py-4 space-y-3">
                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <div class="flex items-center gap-3 mb-2">
                                                <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                                    <c:choose>
                                                        <c:when test="${not empty ct.maCaThi}">
                                                            <c:out value="${ct.maCaThi}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            Ca thi #<c:out value="${ct.id}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:choose>
                                                    <c:when test="${dk.trangThai == 'Đã duyệt' || dk.trangThai == 'Đã xác nhận'}">
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-600">
                                                            Đã duyệt
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${dk.trangThai == 'Chờ xác nhận'}">
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2 py-1 text-[11px] font-semibold text-orange-500">
                                                            Chờ xác nhận
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${dk.trangThai == 'Đã hủy'}">
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-red-100 px-2 py-1 text-[11px] font-semibold text-red-600">
                                                            Đã hủy
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-blue-100 px-2 py-1 text-[11px] font-semibold text-primary">
                                                            <c:out value="${dk.trangThai}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="space-y-1 text-sm text-slate-600">
                                                <p>
                                                    <span class="font-semibold">Ngày thi:</span>
                                                    <c:if test="${not empty ct.ngayThi}">
                                                        <fmt:formatDate value="${ct.ngayThi}" pattern="dd/MM/yyyy" />
                                                    </c:if>
                                                    <c:if test="${not empty ct.gioBatDau}">
                                                        · <fmt:formatDate value="${ct.gioBatDau}" pattern="HH:mm" />
                                                    </c:if>
                                                </p>
                                                <p>
                                                    <span class="font-semibold">Địa điểm:</span>
                                                    <c:out value="${not empty ct.diaDiem ? ct.diaDiem : 'Chưa có địa điểm'}" />
                                                </p>
                                                <c:if test="${not empty dk.maXacNhan}">
                                                    <p>
                                                        <span class="font-semibold">Mã đăng ký:</span>
                                                        <span class="font-mono text-primary"><c:out value="${dk.maXacNhan}" /></span>
                                                    </p>
                                                </c:if>
                                                <c:if test="${not empty dk.ngayDangKy}">
                                                    <p class="text-xs text-slate-400">
                                                        Đăng ký lúc: <fmt:formatDate value="${dk.ngayDangKy}" pattern="dd/MM/yyyy · HH:mm" />
                                                    </p>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="pt-3 border-t border-blue-100">
                                            <div class="flex items-center justify-between text-sm">
                                                <span class="text-slate-500">Số tiền phải trả:</span>
                                                <span class="text-lg font-bold text-primary">
                                                    <fmt:formatNumber value="${dk.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                </span>
                                            </div>
                                            <c:if test="${dk.mucGiam > 0}">
                                                <div class="flex items-center justify-between text-xs mt-1">
                                                    <span class="text-emerald-600">Đã giảm:</span>
                                                    <span class="text-emerald-600 font-semibold">
                                                        -<fmt:formatNumber value="${dk.mucGiam}" type="number" groupingUsed="true" />đ
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty dk.maCodeGiamGia}">
                                                <div class="flex items-center justify-between text-xs mt-1">
                                                    <span class="text-blue-600">Mã code:</span>
                                                    <span class="text-blue-600 font-semibold font-mono">
                                                        <c:out value="${dk.maCodeGiamGia}" />
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:if test="${dk.daTungThi}">
                                                <div class="text-xs text-slate-500 mt-1">
                                                    ✓ Đã từng thi (được giảm giá)
                                                </div>
                                            </c:if>
                                        </div>
                                        <c:if test="${dk.trangThai == 'Chờ xác nhận'}">
                                            <div class="pt-3 border-t border-blue-100">
                                                <a href="${pageContext.request.contextPath}/payment/start?dkId=${dk.id}&type=exam"
                                                   class="block w-full text-center rounded-full bg-primary px-4 py-2 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                                    Thanh toán ngay
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Không có đăng ký nào -->
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${not empty caThiListWithDetails}">
                        <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                            <c:forEach var="detail" items="${caThiListWithDetails}">
                                <c:set var="caThiItem" value="${detail.caThi}" />
                                <c:set var="soLuongDangKy" value="${detail.soLuongDangKy}" />
                                <c:set var="isLocked" value="${detail.isLocked}" />
                                <c:set var="conCho" value="${caThiItem.sucChua - soLuongDangKy}" />
                                <article class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft hover:shadow-xl transition ${soLuongDangKy >= caThiItem.sucChua || isLocked ? 'opacity-60' : ''}">
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                                <c:choose>
                                                    <c:when test="${not empty caThiItem.maCaThi}">
                                                        <c:out value="${caThiItem.maCaThi}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        Ca thi #<c:out value="${caThiItem.id}" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:choose>
                                                <c:when test="${isLocked}">
                                                    <span class="inline-flex items-center gap-1 rounded-full bg-red-100 px-2 py-1 text-[11px] font-semibold text-red-600">
                                                        Đã khóa
                                                    </span>
                                                </c:when>
                                                <c:when test="${soLuongDangKy >= caThiItem.sucChua}">
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
                                                <c:if test="${not empty caThiItem.ngayThi}">
                                                    <fmt:formatDate value="${caThiItem.ngayThi}" pattern="dd/MM/yyyy" />
                                                </c:if>
                                            </div>
                                            <div class="flex items-center gap-2 text-sm text-slate-600">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                    <path d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                </svg>
                                                <c:if test="${not empty caThiItem.gioBatDau}">
                                                    <fmt:formatDate value="${caThiItem.gioBatDau}" pattern="HH:mm" />
                                                </c:if>
                                                <c:if test="${not empty caThiItem.gioKetThuc}">
                                                    - <fmt:formatDate value="${caThiItem.gioKetThuc}" pattern="HH:mm" />
                                                </c:if>
                                            </div>
                                            <div class="flex items-center gap-2 text-sm text-slate-600">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                                    <path d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                                    <path d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                </svg>
                                                <c:out value="${not empty caThiItem.diaDiem ? caThiItem.diaDiem : 'Chưa có địa điểm'}" />
                                            </div>
                                        </div>

                                        <div class="space-y-2 pt-2 border-t border-blue-100">
                                            <div class="flex items-center justify-between text-sm">
                                                <span class="text-slate-500">Sức chứa:</span>
                                                <span class="font-semibold text-slate-900">
                                                    <c:out value="${soLuongDangKy}" />/<c:out value="${caThiItem.sucChua}" />
                                                </span>
                                            </div>
                                            <div class="flex items-center justify-between">
                                                <span class="text-sm text-slate-500">Giá gốc:</span>
                                                <span class="text-lg font-bold text-primary">
                                                    <fmt:formatNumber value="${caThiItem.giaGoc}" type="number" groupingUsed="true" />đ
                                                </span>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${isLocked}">
                                                <button disabled
                                                        class="w-full rounded-full border border-slate-200 bg-slate-100 px-5 py-2.5 text-sm font-semibold text-slate-400 cursor-not-allowed"
                                                        title="${detail.statusMessage}">
                                                    Đã khóa
                                                </button>
                                            </c:when>
                                            <c:when test="${soLuongDangKy >= caThiItem.sucChua}">
                                                <button disabled
                                                        class="w-full rounded-full border border-slate-200 bg-slate-100 px-5 py-2.5 text-sm font-semibold text-slate-400 cursor-not-allowed">
                                                    Đã đầy
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/dang-ky-thi?caThiId=${caThiItem.id}"
                                                   class="block w-full text-center rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                                    Chọn ca thi này
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="glass rounded-3xl border border-blue-100 px-6 py-12 text-center">
                            <p class="text-lg font-semibold text-slate-700 mb-4">Chưa có ca thi nào</p>
                            <p class="text-sm text-slate-500">Hiện tại chưa có ca thi nào được mở đăng ký.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <!-- Form đăng ký ca thi -->
                <div class="space-y-4 text-center">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                        Đăng ký ca thi
                    </span>
                    <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Đăng ký ca thi</h1>
                </div>

                <div class="grid gap-8 lg:grid-cols-[1fr,1fr]">
                    <!-- Form đăng ký -->
                    <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header>
                            <h2 class="text-xl font-semibold text-slate-900">Thông tin đăng ký</h2>
                            <p class="mt-2 text-sm text-slate-500">Vui lòng điền thông tin để hoàn tất đăng ký</p>
                        </header>

                        <c:if test="${not empty errorMessage}">
                            <div class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
                                <c:out value="${errorMessage}" />
                            </div>
                        </c:if>

                        <form method="post" action="${pageContext.request.contextPath}/dang-ky-thi" class="space-y-5">
                            <input type="hidden" name="caThiId" value="${caThi.id}" />
                            
                            <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-5 py-4 text-sm text-slate-600 space-y-2">
                                <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thông tin ca thi</p>
                                <div class="space-y-1">
                                    <p><span class="font-semibold">Ngày thi:</span> 
                                        <c:if test="${not empty caThi.ngayThi}">
                                            <fmt:formatDate value="${caThi.ngayThi}" pattern="dd/MM/yyyy" />
                                        </c:if>
                                    </p>
                                    <p><span class="font-semibold">Giờ thi:</span> 
                                        <c:if test="${not empty caThi.gioBatDau}">
                                            <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                        </c:if>
                                        <c:if test="${not empty caThi.gioKetThuc}">
                                            - <fmt:formatDate value="${caThi.gioKetThuc}" pattern="HH:mm" />
                                        </c:if>
                                    </p>
                                    <p><span class="font-semibold">Địa điểm:</span> <c:out value="${not empty caThi.diaDiem ? caThi.diaDiem : 'Chưa có địa điểm'}" /></p>
                                    <p><span class="font-semibold">Giá gốc:</span> <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ</p>
                                </div>
                            </div>

                            <div class="rounded-2xl border border-blue-100 bg-white px-5 py-4 space-y-3">
                                <label class="flex items-start gap-3 cursor-pointer">
                                    <input type="checkbox" name="daTungThi" value="true" id="daTungThi"
                                           class="mt-1 h-4 w-4 rounded border-blue-200 text-primary focus:ring-primary/30">
                                    <div class="flex-1">
                                        <p class="text-sm font-semibold text-slate-900">Bạn đã từng thi VSTEP chưa?</p>
                                        <p class="text-xs text-slate-500 mt-1">Nếu đã từng thi, bạn sẽ được giảm giá theo chính sách hiện tại</p>
                                    </div>
                                </label>
                            </div>

                            <div>
                                <label for="maCode" class="block text-sm font-semibold text-slate-700 mb-2">
                                    Mã code giảm giá (nếu có)
                                </label>
                                <div class="flex gap-2">
                                    <input type="text" id="maCode" name="maCode" 
                                           placeholder="Nhập mã code"
                                           class="flex-1 rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 uppercase focus:outline-none focus:ring-2 focus:ring-primary/30">
                                    <button type="button" id="apply-code-btn"
                                            class="rounded-full border border-blue-100 bg-white px-5 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                                        Áp dụng
                                    </button>
                                </div>
                                <p id="code-message" class="text-xs mt-2"></p>
                            </div>

                            <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-5 py-4 space-y-2">
                                <div class="flex items-center justify-between">
                                    <span class="text-sm text-slate-600">Giá gốc:</span>
                                    <span class="text-sm font-semibold text-slate-900" id="giaGoc-display">
                                        <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                    </span>
                                </div>
                                <div class="flex items-center justify-between" id="mucGiam-row" style="display: none;">
                                    <span class="text-sm text-emerald-600">Giảm giá (đã từng thi):</span>
                                    <span class="text-sm font-semibold text-emerald-600" id="mucGiam-display">
                                        -0đ
                                    </span>
                                </div>
                                <div class="flex items-center justify-between" id="code-discount-row" style="display: none;">
                                    <span class="text-sm text-blue-600">Giảm giá (mã code):</span>
                                    <span class="text-sm font-semibold text-blue-600" id="code-discount-display">
                                        -0đ
                                    </span>
                                </div>
                                <div class="pt-2 border-t border-blue-200 flex items-center justify-between">
                                    <span class="text-base font-semibold text-slate-900">Tổng cộng:</span>
                                    <span class="text-xl font-bold text-primary" id="tongCong-display">
                                        <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                    </span>
                                </div>
                            </div>

                            <div class="flex flex-col sm:flex-row gap-3">
                                <button type="submit" 
                                        class="flex-1 inline-flex items-center justify-center gap-2 rounded-full bg-primary px-5 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Xác nhận đăng ký
                                </button>
                                <a href="${pageContext.request.contextPath}/dang-ky-thi" 
                                   class="inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-3 text-sm font-semibold text-slate-600 hover:bg-blue-50 transition">
                                    Chọn ca khác
                                </a>
                            </div>
                        </form>
                    </div>

                    <!-- Thông tin ca thi -->
                    <div class="space-y-6">
                        <!-- Hiển thị các đăng ký của user -->
                        <c:if test="${not empty userRegistrationsWithDetails and userRegistrationsWithDetails.size() > 0}">
                            <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                                <div class="flex items-center justify-between mb-4">
                                    <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Các đăng ký của bạn</h3>
                                    <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-2 py-1 text-[10px] font-semibold text-primary">
                                        <c:out value="${userRegistrationsWithDetails.size()}" />
                                    </span>
                                </div>
                                <div class="space-y-3 max-h-96 overflow-y-auto">
                                    <c:forEach var="regDetail" items="${userRegistrationsWithDetails}">
                                        <c:set var="dk" value="${regDetail.dangKyThi}" />
                                        <c:set var="ct" value="${regDetail.caThi}" />
                                        <c:if test="${not empty dk}">
                                        <div class="rounded-2xl border border-blue-100 bg-primary.pale/40 px-4 py-3 space-y-2">
                                            <div class="flex items-center justify-between">
                                                <span class="text-xs font-semibold text-slate-900">
                                                    <c:choose>
                                                        <c:when test="${not empty ct.maCaThi}">
                                                            <c:out value="${ct.maCaThi}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            Ca thi #<c:out value="${ct.id}" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <c:choose>
                                                    <c:when test="${dk.trangThai == 'Đã duyệt' || dk.trangThai == 'Đã xác nhận'}">
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-0.5 text-[10px] font-semibold text-emerald-600">
                                                            Đã duyệt
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${dk.trangThai == 'Chờ xác nhận'}">
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2 py-0.5 text-[10px] font-semibold text-orange-500">
                                                            Chờ
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-1 rounded-full bg-blue-100 px-2 py-0.5 text-[10px] font-semibold text-primary">
                                                            <c:out value="${dk.trangThai}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="text-xs text-slate-600 space-y-1">
                                                <p>
                                                    <c:if test="${not empty ct.ngayThi}">
                                                        <fmt:formatDate value="${ct.ngayThi}" pattern="dd/MM" />
                                                    </c:if>
                                                    <c:if test="${not empty ct.gioBatDau}">
                                                        · <fmt:formatDate value="${ct.gioBatDau}" pattern="HH:mm" />
                                                    </c:if>
                                                </p>
                                                <p class="font-semibold text-primary">
                                                    <fmt:formatNumber value="${dk.soTienPhaiTra}" type="number" groupingUsed="true" />đ
                                                </p>
                                            </div>
                                            <c:if test="${dk.trangThai == 'Chờ xác nhận'}">
                                                <a href="${pageContext.request.contextPath}/payment/start?dkId=${dk.id}&type=exam"
                                                   class="block w-full text-center rounded-full bg-primary px-3 py-1.5 text-xs font-semibold text-white hover:bg-primary/90 transition">
                                                    Thanh toán
                                                </a>
                                            </c:if>
                                        </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                            <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500 mb-4">Chi tiết ca thi</h3>
                            <div class="space-y-3 text-sm text-slate-600">
                                <div class="flex items-center justify-between rounded-2xl bg-primary.pale/60 px-4 py-3">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Sức chứa</span>
                                    <span class="font-semibold text-slate-900">
                                        <c:out value="${not empty soLuongDangKy ? soLuongDangKy : 0}" /> / <c:out value="${caThi.sucChua}" /> thí sinh
                                    </span>
                                </div>
                                <c:if test="${not empty soLuongDangKy and soLuongDangKy >= caThi.sucChua}">
                                    <div class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-xs text-red-700">
                                        <p class="font-semibold">⚠️ Ca thi đã đầy</p>
                                        <p class="mt-1">Không thể đăng ký thêm</p>
                                    </div>
                                </c:if>
                                <c:if test="${not empty soLuongDangKy and soLuongDangKy < caThi.sucChua and (caThi.sucChua - soLuongDangKy) <= 5}">
                                    <div class="rounded-2xl border border-orange-200 bg-orange-50 px-4 py-3 text-xs text-orange-700">
                                        <p class="font-semibold">⚠️ Còn <c:out value="${caThi.sucChua - soLuongDangKy}" /> chỗ trống</p>
                                        <p class="mt-1">Vui lòng đăng ký sớm</p>
                                    </div>
                                </c:if>
                                <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Giá gốc</span>
                                    <span class="font-semibold text-slate-900">
                                        <fmt:formatNumber value="${caThi.giaGoc}" type="number" groupingUsed="true" />đ
                                    </span>
                                </div>
                                <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Giảm giá thi lại</span>
                                    <span class="font-semibold text-emerald-600">500.000đ</span>
                                </div>
                            </div>
                        </div>

                        <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                            <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500 mb-4">Lưu ý</h3>
                            <ul class="space-y-2 text-xs text-slate-600">
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                    <span>Đăng ký sẽ được xử lý trong vòng 24 giờ</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                    <span>Bạn sẽ nhận được email xác nhận với mã đăng ký sau khi đăng ký thành công</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                    <span>Nếu đã từng thi, bạn sẽ được giảm giá 500.000đ tự động</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                    <span>Nhớ mang CMND/CCCD và phiếu đăng ký khi đi thi</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const daTungThiCheckbox = document.getElementById('daTungThi');
        const mucGiamRow = document.getElementById('mucGiam-row');
        const codeDiscountRow = document.getElementById('code-discount-row');
        const tongCongDisplay = document.getElementById('tongCong-display');
        const maCodeInput = document.getElementById('maCode');
        const applyCodeBtn = document.getElementById('apply-code-btn');
        const codeMessage = document.getElementById('code-message');
        
        if (daTungThiCheckbox && tongCongDisplay) {
            const giaGoc = ${caThi.giaGoc};
            let mucGiamThiLai = 0; // Sẽ được load từ server
            let codeDiscount = 0;
            let currentCode = null;
            
            // Load mức giảm giá thi lại từ server (mặc định 500000)
            fetch('${pageContext.request.contextPath}/api/config-giam-gia?loai=ca_thi')
                .then(response => response.json())
                .then(data => {
                    if (data && data.mucGiamThiLai) {
                        mucGiamThiLai = data.mucGiamThiLai;
                        updateTotal();
                    }
                })
                .catch(() => {
                    mucGiamThiLai = 500000; // Fallback
                });
            
            function updateTotal() {
                let total = giaGoc;
                let totalDiscount = 0;
                
                // Áp dụng giảm giá thi lại
                if (daTungThiCheckbox.checked && mucGiamThiLai > 0) {
                    mucGiamRow.style.display = 'flex';
                    document.getElementById('mucGiam-display').textContent = 
                        '-' + new Intl.NumberFormat('vi-VN').format(mucGiamThiLai) + 'đ';
                    totalDiscount += mucGiamThiLai;
                } else {
                    mucGiamRow.style.display = 'none';
                }
                
                // Áp dụng giảm giá mã code
                if (codeDiscount > 0) {
                    codeDiscountRow.style.display = 'flex';
                    document.getElementById('code-discount-display').textContent = 
                        '-' + new Intl.NumberFormat('vi-VN').format(codeDiscount) + 'đ';
                    totalDiscount += codeDiscount;
                } else {
                    codeDiscountRow.style.display = 'none';
                }
                
                total = Math.max(0, total - totalDiscount);
                tongCongDisplay.textContent = new Intl.NumberFormat('vi-VN').format(total) + 'đ';
            }
            
            daTungThiCheckbox.addEventListener('change', () => {
                updateTotal();
            });
            
            // Xử lý áp dụng mã code
            if (applyCodeBtn && maCodeInput) {
                applyCodeBtn.addEventListener('click', () => {
                    const maCode = maCodeInput.value.trim().toUpperCase();
                    if (!maCode) {
                        codeMessage.textContent = 'Vui lòng nhập mã code';
                        codeMessage.className = 'text-xs mt-2 text-red-600';
                        return;
                    }
                    
                    // Validate mã code qua API
                    fetch('${pageContext.request.contextPath}/api/validate-code?code=' + encodeURIComponent(maCode) + '&loai=ca_thi&giaGoc=' + giaGoc)
                        .then(response => response.json())
                        .then(data => {
                            if (data.valid) {
                                codeDiscount = data.discount || 0;
                                currentCode = maCode;
                                codeMessage.textContent = data.message || 'Mã code hợp lệ';
                                codeMessage.className = 'text-xs mt-2 text-emerald-600';
                                updateTotal();
                            } else {
                                codeDiscount = 0;
                                currentCode = null;
                                codeMessage.textContent = data.message || 'Mã code không hợp lệ';
                                codeMessage.className = 'text-xs mt-2 text-red-600';
                                updateTotal();
                            }
                        })
                        .catch(() => {
                            codeMessage.textContent = 'Có lỗi xảy ra khi kiểm tra mã code';
                            codeMessage.className = 'text-xs mt-2 text-red-600';
                        });
                });
            }
        }
    });
</script>
</body>
</html>

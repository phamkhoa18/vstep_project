<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cấu hình ưu đãi | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="config" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="max-w-[1200px] mx-auto space-y-10 pb-16">
        <section class="space-y-4">
            <div class="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Cấu hình giảm giá</h2>
                    <p class="text-sm text-slate-500 mt-1">Thiết lập mức giảm giá cho thí sinh thi lại và quản lý mã code giảm giá.</p>
                </div>
            </div>
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 space-y-6">
                <!-- Cấu hình giảm giá cho ca thi -->
                <form method="post" action="${pageContext.request.contextPath}/admin/config" class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <input type="hidden" name="action" value="update-config-ca-thi">
                    <div>
                        <h3 class="text-lg font-semibold text-slate-900">Cấu hình giảm giá ca thi</h3>
                        <p class="text-xs text-slate-500 mt-1">Thiết lập mức giảm giá cho thí sinh thi lại ca thi.</p>
                    </div>
                    <div class="grid gap-6 md:grid-cols-2">
                        <div>
                            <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                                Mức giảm giá thi lại (VND)
                            </label>
                            <div class="relative mt-2">
                                <input type="text" name="mucGiamThiLai" 
                                       value="<fmt:formatNumber value="${not empty configCaThi ? configCaThi.mucGiamThiLai : 500000}" type="number" groupingUsed="true" />"
                                       inputmode="numeric"
                                       placeholder="500000"
                                       required
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 text-right pr-14 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <span class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none">VND</span>
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trạng thái</label>
                            <select name="trangThai" class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option value="active" ${not empty configCaThi && configCaThi.trangThai == 'active' ? 'selected' : ''}>Kích hoạt</option>
                                <option value="inactive" ${not empty configCaThi && configCaThi.trangThai == 'inactive' ? 'selected' : ''}>Tạm dừng</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mô tả</label>
                        <textarea name="moTa" rows="3" placeholder="Mô tả về chính sách giảm giá..."
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">${not empty configCaThi ? configCaThi.moTa : ''}</textarea>
                    </div>
                    <div class="flex items-center justify-end">
                        <button type="submit"
                                class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lưu cấu hình ca thi
                        </button>
                    </div>
                </form>

                <!-- Cấu hình giảm giá cho lớp ôn -->
                <form method="post" action="${pageContext.request.contextPath}/admin/config" class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <input type="hidden" name="action" value="update-config-lop-on">
                    <div>
                        <h3 class="text-lg font-semibold text-slate-900">Cấu hình giảm giá lớp ôn</h3>
                        <p class="text-xs text-slate-500 mt-1">Thiết lập mức giảm giá cho học viên đăng ký lại lớp ôn.</p>
                    </div>
                    <div class="grid gap-6 md:grid-cols-2">
                        <div>
                            <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                                Mức giảm giá (VND)
                            </label>
                            <div class="relative mt-2">
                                <input type="text" name="mucGiamThiLai" 
                                       value="<fmt:formatNumber value="${not empty configLopOn ? configLopOn.mucGiamThiLai : 0}" type="number" groupingUsed="true" />"
                                       inputmode="numeric"
                                       placeholder="0"
                                       required
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 text-right pr-14 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <span class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none">VND</span>
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trạng thái</label>
                            <select name="trangThai" class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option value="active" ${not empty configLopOn && configLopOn.trangThai == 'active' ? 'selected' : ''}>Kích hoạt</option>
                                <option value="inactive" ${not empty configLopOn && configLopOn.trangThai == 'inactive' ? 'selected' : ''}>Tạm dừng</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mô tả</label>
                        <textarea name="moTa" rows="3" placeholder="Mô tả về chính sách giảm giá..."
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">${not empty configLopOn ? configLopOn.moTa : ''}</textarea>
                    </div>
                    <div class="flex items-center justify-end">
                        <button type="submit"
                                class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lưu cấu hình lớp ôn
                        </button>
                    </div>
                </form>

                <!-- Quản lý mã code giảm giá -->
                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <h3 class="text-lg font-semibold text-slate-900">Quản lý mã code giảm giá</h3>
                            <p class="text-xs text-slate-500 mt-1">Tạo và quản lý các mã code giảm giá cho lớp ôn và ca thi.</p>
                        </div>
                        <button data-modal-target="create-code-modal"
                                class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                <path d="M12 6v12"/>
                                <path d="M6 12h12"/>
                            </svg>
                            Tạo mã code
                        </button>
                    </div>
                    <div class="overflow-hidden rounded-2xl border border-blue-50">
                        <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                            <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                            <tr>
                                <th class="px-4 py-3 text-left font-semibold">Mã code</th>
                                <th class="px-4 py-3 text-left font-semibold">Loại</th>
                                <th class="px-4 py-3 text-left font-semibold">Giá trị</th>
                                <th class="px-4 py-3 text-left font-semibold">Số lượng</th>
                                <th class="px-4 py-3 text-left font-semibold">Trạng thái</th>
                                <th class="px-4 py-3 text-right font-semibold">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody class="divide-y divide-blue-50 bg-white">
                            <c:choose>
                                <c:when test="${not empty allMaGiamGia}">
                                    <c:forEach var="ma" items="${allMaGiamGia}">
                                        <tr>
                                            <td class="px-4 py-3">
                                                <p class="font-semibold text-slate-900"><c:out value="${ma.maCode}" /></p>
                                            </td>
                                            <td class="px-4 py-3">
                                                <span class="inline-flex items-center gap-1 rounded-full px-2 py-1 text-xs font-semibold 
                                                    ${ma.loai == 'ca_thi' ? 'bg-blue-100 text-primary' : 
                                                      ma.loai == 'lop_on' ? 'bg-emerald-100 text-emerald-600' : 
                                                      'bg-slate-100 text-slate-600'}">
                                                    <c:choose>
                                                        <c:when test="${ma.loai == 'ca_thi'}">Ca thi</c:when>
                                                        <c:when test="${ma.loai == 'lop_on'}">Lớp ôn</c:when>
                                                        <c:otherwise>Tất cả</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="px-4 py-3">
                                                <c:choose>
                                                    <c:when test="${ma.loaiGiam == 'fixed'}">
                                                        <fmt:formatNumber value="${ma.giaTriGiam}" type="number" groupingUsed="true" />đ
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${ma.giaTriGiam}%
                                                        <c:if test="${not empty ma.giaTriToiDa}">
                                                            (tối đa <fmt:formatNumber value="${ma.giaTriToiDa}" type="number" groupingUsed="true" />đ)
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="px-4 py-3">
                                                <c:out value="${ma.soLuongDaSuDung}" />
                                                <c:if test="${not empty ma.soLuongToiDa}">
                                                    / <c:out value="${ma.soLuongToiDa}" />
                                                </c:if>
                                            </td>
                                            <td class="px-4 py-3">
                                                <span class="inline-flex items-center gap-1 rounded-full px-2 py-1 text-xs font-semibold 
                                                    ${ma.trangThai == 'active' ? 'bg-emerald-100 text-emerald-600' : 
                                                      ma.trangThai == 'expired' ? 'bg-red-100 text-red-600' : 
                                                      'bg-slate-100 text-slate-600'}">
                                                    <c:choose>
                                                        <c:when test="${ma.trangThai == 'active'}">Kích hoạt</c:when>
                                                        <c:when test="${ma.trangThai == 'expired'}">Hết hạn</c:when>
                                                        <c:otherwise>Tạm dừng</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            <td class="px-4 py-3 text-right space-x-2">
                                                <button data-modal-target="edit-code-modal-${ma.id}"
                                                        class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                                    Sửa
                                                </button>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/config" style="display:inline" class="js-delete-code-form" data-code="${fn:escapeXml(ma.maCode)}">
                                                    <input type="hidden" name="action" value="delete-ma-giam-gia">
                                                    <input type="hidden" name="id" value="${ma.id}">
                                                    <button type="submit" 
                                                            class="inline-flex items-center gap-2 rounded-full border border-red-100 bg-red-50 px-4 py-2 text-xs font-semibold text-red-500 hover:bg-red-100 transition">
                                                        Xóa
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="px-6 py-12 text-center text-slate-400">
                                            <p class="text-sm">Chưa có mã code nào. Nhấn "Tạo mã code" để thêm.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <aside class="space-y-6">
                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-4">
                    <h3 class="text-lg font-semibold text-slate-900">Thông tin cấu hình</h3>
                    <div class="space-y-3 text-xs text-slate-600">
                        <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-3">
                            <p class="font-semibold text-slate-800 mb-1">Ca thi</p>
                            <p>Giảm giá thi lại: <span class="font-semibold text-primary">
                                <fmt:formatNumber value="${not empty configCaThi ? configCaThi.mucGiamThiLai : 500000}" type="number" groupingUsed="true" />đ
                            </span></p>
                            <p class="text-slate-500 mt-1">${not empty configCaThi && not empty configCaThi.moTa ? configCaThi.moTa : 'Chưa có mô tả'}</p>
                        </div>
                        <div class="rounded-2xl border border-blue-50 bg-white px-4 py-3">
                            <p class="font-semibold text-slate-800 mb-1">Lớp ôn</p>
                            <p>Giảm giá: <span class="font-semibold text-primary">
                                <fmt:formatNumber value="${not empty configLopOn ? configLopOn.mucGiamThiLai : 0}" type="number" groupingUsed="true" />đ
                            </span></p>
                            <p class="text-slate-500 mt-1">${not empty configLopOn && not empty configLopOn.moTa ? configLopOn.moTa : 'Chưa có mô tả'}</p>
                        </div>
                    </div>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-4">
                    <h3 class="text-lg font-semibold text-slate-900">Thống kê mã code</h3>
                    <div class="space-y-2 text-xs text-slate-600">
                        <div class="flex items-center justify-between rounded-2xl bg-primary.pale/40 px-4 py-3">
                            <span>Tổng mã code</span>
                            <span class="font-semibold text-slate-900"><c:out value="${not empty allMaGiamGia ? allMaGiamGia.size() : 0}" /></span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-50 bg-white px-4 py-3">
                            <span>Đang kích hoạt</span>
                            <span class="font-semibold text-emerald-600">
                                <c:set var="activeCount" value="0" />
                                <c:forEach var="ma" items="${allMaGiamGia}">
                                    <c:if test="${ma.trangThai == 'active'}">
                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:out value="${activeCount}" />
                            </span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-50 bg-white px-4 py-3">
                            <span>Đã sử dụng</span>
                            <span class="font-semibold text-slate-900">
                                <c:set var="totalUsed" value="0" />
                                <c:forEach var="ma" items="${allMaGiamGia}">
                                    <c:set var="totalUsed" value="${totalUsed + ma.soLuongDaSuDung}" />
                                </c:forEach>
                                <c:out value="${totalUsed}" />
                            </span>
                        </div>
                    </div>
                </div>
            </aside>
        </section>
        </main>
    </div>
</div>

<!-- Create/Edit Code Modal -->
<div id="create-code-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Tạo mã code giảm giá</h3>
                <p class="text-xs text-slate-500 mt-1">Tạo mã code mới để áp dụng giảm giá cho lớp ôn hoặc ca thi.</p>
            </div>
            <button data-modal-close="create-code-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form method="post" action="${pageContext.request.contextPath}/admin/config" class="px-6 py-6 space-y-6">
            <input type="hidden" name="action" value="create-ma-giam-gia">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mã code *</label>
                    <input type="text" name="maCode" required placeholder="Ví dụ: VSTEP2025"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 uppercase focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Loại *</label>
                    <select name="loai" required
                            class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option value="all">Tất cả</option>
                        <option value="ca_thi">Ca thi</option>
                        <option value="lop_on">Lớp ôn</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Loại giảm giá *</label>
                    <select name="loaiGiam" required id="loaiGiam-select"
                            class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option value="fixed">Số tiền cố định</option>
                        <option value="percent">Phần trăm</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giá trị giảm *</label>
                    <div class="relative mt-2">
                        <input type="text" name="giaTriGiam" required inputmode="numeric" placeholder="500000 hoặc 10"
                               class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 text-right pr-14 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <span id="gia-tri-unit" class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none">VND</span>
                    </div>
                </div>
                <div id="gia-tri-toi-da-row" style="display: none;">
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giá trị tối đa (VND)</label>
                    <div class="relative mt-2">
                        <input type="text" name="giaTriToiDa" inputmode="numeric" placeholder="1000000"
                               class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 text-right pr-14 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <span class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none">VND</span>
                    </div>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số lượng tối đa</label>
                    <input type="number" name="soLuongToiDa" min="1" placeholder="Không giới hạn"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày bắt đầu</label>
                    <input type="date" name="ngayBatDau"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày kết thúc</label>
                    <input type="date" name="ngayKetThuc"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trạng thái</label>
                    <select name="trangThai"
                            class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option value="active" selected>Kích hoạt</option>
                        <option value="inactive">Tạm dừng</option>
                    </select>
                </div>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mô tả</label>
                <textarea name="moTa" rows="3" placeholder="Mô tả về mã code giảm giá..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="create-code-modal" type="button"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Tạo mã code
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Publish modal -->
<div id="publish-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Áp dụng cấu hình ưu đãi</h3>
                <p class="text-xs text-slate-500 mt-1">Kiểm tra kỹ trước khi áp dụng cho toàn hệ thống.</p>
            </div>
            <button data-modal-close="publish-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6 text-sm text-slate-600">
            <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 space-y-2">
                <p>• Thi lại lần đầu: <span class="font-semibold text-primary">30%</span> trong 30 ngày.</p>
                <p>• Thi lại lần hai: <span class="font-semibold text-primary">20%</span> trong 60 ngày.</p>
                <p>• Từ lần thứ ba: <span class="font-semibold text-primary">10%</span>.</p>
                <p>• Học viên thân thiết: <span class="font-semibold text-primary">+5%</span>.</p>
            </div>
            <div class="text-xs text-slate-500 space-y-2">
                <p>Việc áp dụng sẽ:</p>
                <p>• Cập nhật ưu đãi ngay lập tức cho các đăng ký mới.</p>
                <p>• Thông báo đến bộ phận tư vấn và kế toán qua email.</p>
                <p>• Lưu lại phiên bản trong lịch sử hệ thống.</p>
            </div>
            <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                Tôi xác nhận đã kiểm tra và đồng ý áp dụng cấu hình.
            </label>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="publish-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Áp dụng ngay
                </button>
            </div>
        </div>
    </div>
</div>

<!-- History modal -->
<div id="history-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Lịch sử cấu hình ưu đãi</h3>
                <p class="text-xs text-slate-500 mt-1">Theo dõi các lần chỉnh sửa gần đây.</p>
            </div>
            <button data-modal-close="history-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6">
            <div class="overflow-hidden rounded-2xl border border-blue-50">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-4 py-3 text-left font-semibold">Thời gian</th>
                        <th class="px-4 py-3 text-left font-semibold">Người chỉnh sửa</th>
                        <th class="px-4 py-3 text-left font-semibold">Thay đổi</th>
                        <th class="px-4 py-3 text-left font-semibold">Ghi chú</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <tr>
                        <td class="px-4 py-3">09/11/2025 · 10:15</td>
                        <td class="px-4 py-3">Nguyễn Thị Ánh</td>
                        <td class="px-4 py-3">Tăng giảm giá lần đầu lên 30%</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Theo đề xuất bộ phận tài chính</td>
                    </tr>
                    <tr>
                        <td class="px-4 py-3">05/11/2025 · 14:28</td>
                        <td class="px-4 py-3">Trần Minh Tâm</td>
                        <td class="px-4 py-3">Thêm điều kiện hoàn thành 6 buổi ôn</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Giảm rủi ro học viên bỏ dở</td>
                    </tr>
                    <tr>
                        <td class="px-4 py-3">28/10/2025 · 09:02</td>
                        <td class="px-4 py-3">Hệ thống</td>
                        <td class="px-4 py-3">Gia hạn áp dụng đến 10/01/2026</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Theo chính sách mới của trung tâm</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="flex items-center justify-between text-xs text-slate-500">
                <span>Hiển thị 1 – 3 trên 28 thay đổi</span>
                <button class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                    Tải xuống CSV
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Kiểm tra SweetAlert2 đã được load
        if (typeof Swal === 'undefined') {
            console.error('SweetAlert2 chưa được load!');
        }

        // Format giá trị giảm giá
        const formatCurrency = (value) => {
            if (!value) return '';
            const digits = value.replace(/\D/g, '');
            return digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        };

        // Format input giá trị giảm
        const giaTriGiamInputs = document.querySelectorAll('input[name="giaTriGiam"]');
        giaTriGiamInputs.forEach(input => {
            input.addEventListener('input', () => {
                const cursorPos = input.selectionStart;
                const raw = input.value.replace(/\D/g, '');
                input.value = formatCurrency(raw);
                input.setSelectionRange(cursorPos, cursorPos);
            });
        });

        // Format input giá trị tối đa
        const giaTriToiDaInputs = document.querySelectorAll('input[name="giaTriToiDa"]');
        giaTriToiDaInputs.forEach(input => {
            input.addEventListener('input', () => {
                const cursorPos = input.selectionStart;
                const raw = input.value.replace(/\D/g, '');
                input.value = formatCurrency(raw);
                input.setSelectionRange(cursorPos, cursorPos);
            });
        });

        // Format input mức giảm thi lại
        const mucGiamInputs = document.querySelectorAll('input[name="mucGiamThiLai"]');
        mucGiamInputs.forEach(input => {
            input.addEventListener('input', () => {
                const cursorPos = input.selectionStart;
                const raw = input.value.replace(/\D/g, '');
                input.value = formatCurrency(raw);
                input.setSelectionRange(cursorPos, cursorPos);
            });
        });

        // Xử lý thay đổi loại giảm giá
        const loaiGiamSelect = document.getElementById('loaiGiam-select');
        const giaTriToiDaRow = document.getElementById('gia-tri-toi-da-row');
        const giaTriUnit = document.getElementById('gia-tri-unit');
        
        if (loaiGiamSelect && giaTriToiDaRow && giaTriUnit) {
            loaiGiamSelect.addEventListener('change', () => {
                if (loaiGiamSelect.value === 'percent') {
                    giaTriToiDaRow.style.display = 'block';
                    giaTriUnit.textContent = '%';
                } else {
                    giaTriToiDaRow.style.display = 'none';
                    giaTriUnit.textContent = 'VND';
                }
            });
        }

        // Xử lý xác nhận xóa mã code - PHẢI ĐẶT TRƯỚC event listener chung
        const deleteCodeForms = document.querySelectorAll('.js-delete-code-form');
        if (deleteCodeForms.length > 0 && typeof Swal === 'undefined') {
            console.error('SweetAlert2 chưa được load! Không thể hiển thị xác nhận xóa.');
        }
        deleteCodeForms.forEach(form => {
            form.addEventListener('submit', (event) => {
                event.preventDefault();
                event.stopPropagation();
                
                if (typeof Swal === 'undefined') {
                    // Fallback về confirm nếu SweetAlert2 chưa load
                    if (!confirm('Bạn có chắc muốn xóa mã code này?')) {
                        return;
                    }
                    form.submit();
                    return;
                }
                
                const codeName = form.dataset.code || 'mã code này';

                Swal.fire({
                    title: 'Bạn chắc chắn?',
                    html: `<p class="text-sm text-slate-500">Bạn sắp xoá mã code <span class="font-semibold text-slate-700">"${codeName}"</span> khỏi hệ thống.</p>
                           <p class="text-xs text-slate-400 mt-2">Thao tác này không thể hoàn tác.</p>`,
                    icon: 'warning',
                    showCancelButton: true,
                    focusCancel: true,
                    confirmButtonText: 'Xoá mã code',
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
            }, { capture: true });
        });

        // Submit form - chuyển giá trị về số (loại trừ delete forms)
        const forms = document.querySelectorAll('form:not(.js-delete-code-form)');
        forms.forEach(form => {
            form.addEventListener('submit', () => {
                // Chuyển giá trị có dấu chấm về số
                const giaTriGiam = form.querySelector('input[name="giaTriGiam"]');
                if (giaTriGiam) {
                    const raw = giaTriGiam.value.replace(/\D/g, '');
                    giaTriGiam.value = raw;
                }
                
                const giaTriToiDa = form.querySelector('input[name="giaTriToiDa"]');
                if (giaTriToiDa && giaTriToiDa.value) {
                    const raw = giaTriToiDa.value.replace(/\D/g, '');
                    giaTriToiDa.value = raw;
                }
                
                const mucGiamThiLai = form.querySelector('input[name="mucGiamThiLai"]');
                if (mucGiamThiLai) {
                    const raw = mucGiamThiLai.value.replace(/\D/g, '');
                    mucGiamThiLai.value = raw;
                }
            });
        });

        // Xử lý flash messages
        <c:if test="${not empty configFlashMessage}">
            const flashType = '<c:out value="${configFlashType}" default="info" />';
            const flashMessage = '<c:out value="${configFlashMessage}" />';
            const icon = flashType === 'success' ? 'success' : flashType === 'error' ? 'error' : 'info';
            
            if (typeof Swal !== 'undefined') {
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
            } else {
                console.warn('SweetAlert2 chưa được load, không thể hiển thị flash message');
            }
        </c:if>
    });
</script>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


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
                    <a href="<c:url value='/admin/classes/create' />"
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
                    <h3 class="text-lg font-semibold text-slate-900">Bộ lọc nhanh</h3>
                    <p class="text-xs text-slate-500 mt-1">Kết hợp nhiều điều kiện để tìm lớp phù hợp.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                        Cơ bản
                        <button class="hover:text-primary/70" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100">
                        Nguyễn Phi
                        <button class="hover:text-primary" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <a href="#" class="font-semibold text-primary hover:text-primary/80 transition">Xoá tất cả</a>
                </div>
            </div>
            <div class="grid gap-4 md:grid-cols-3">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Cấp độ lớp</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả</option>
                        <option>Cơ bản</option>
                        <option>Trung cấp</option>
                        <option>Nâng cao</option>
                        <option>Cấp tốc</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giảng viên</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả giảng viên</option>
                        <option>Nguyễn Phi</option>
                        <option>Lê Thảo</option>
                        <option>Võ An</option>
                        <option>Đặng Nhi</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tình trạng</label>
                    <div class="mt-2 flex items-center gap-2 rounded-2xl border border-blue-100 bg-white p-2">
                        <button class="flex-1 rounded-xl bg-primary px-3 py-2 text-xs font-semibold text-white shadow-soft">Đang mở</button>
                        <button class="flex-1 rounded-xl px-3 py-2 text-xs font-semibold text-slate-500 hover:text-primary transition">Sắp mở</button>
                        <button class="flex-1 rounded-xl px-3 py-2 text-xs font-semibold text-slate-500 hover:text-primary transition">Đã kết thúc</button>
                    </div>
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
                <input type="search" placeholder="Tìm kiếm theo tên lớp, mã lớp, giảng viên..."
                       class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-6 py-4 text-left font-semibold">Lớp / Mô tả</th>
                        <th class="px-6 py-4 text-left font-semibold">Hình thức</th>
                        <th class="px-6 py-4 text-left font-semibold">Nhịp độ</th>
                        <th class="px-6 py-4 text-left font-semibold">Thời gian</th>
                        <th class="px-6 py-4 text-left font-semibold">Số buổi</th>
                        <th class="px-6 py-4 text-left font-semibold">Sĩ số tối đa</th>
                        <th class="px-6 py-4 text-left font-semibold">Học phí</th>
                        <th class="px-6 py-4 text-right font-semibold">Tình trạng</th>
                        <th class="px-6 py-4 text-right font-semibold">Thao tác</th>
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
                        <fmt:formatDate value="${lop.ngayHetHanDangKy}" pattern="dd/MM/yyyy" var="ngayHetHanDisplay" />
                        <fmt:formatDate value="${lop.ngayHetHanDangKy}" pattern="yyyy-MM-dd" var="ngayHetHanIso" />
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
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-900">
                                    <c:out value="${lop.tieuDe}" />
                                </p>
                                <c:if test="${not empty lop.moTaNgan}">
                                    <p class="text-xs text-slate-400 mt-1">
                                        <c:out value="${lop.moTaNgan}" />
                                    </p>
                                </c:if>
                            </td>
                            <td class="px-6 py-5">
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-xs font-semibold text-primary/80">
                                    <c:out value="${empty lop.hinhThuc ? '—' : lop.hinhThuc}" />
                                </span>
                            </td>
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-800">
                                    <c:out value="${empty lop.nhipDo ? '—' : lop.nhipDo}" />
                                </p>
                                <p class="text-xs text-slate-400 mt-1">
                                    <c:out value="${lop.gioMoiBuoi}" /> giờ/buổi
                                </p>
                            </td>
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-800">
                                    <c:choose>
                                        <c:when test="${not empty ngayKhaiGiangDisplay}">
                                            Bắt đầu: <c:out value="${ngayKhaiGiangDisplay}" />
                                        </c:when>
                                        <c:otherwise>
                                            Bắt đầu: —
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <p class="text-xs text-slate-400 mt-1">
                                    <c:choose>
                                        <c:when test="${not empty ngayHetHanDisplay}">
                                            Hạn đăng ký: <c:out value="${ngayHetHanDisplay}" />
                                        </c:when>
                                        <c:otherwise>
                                            Hạn đăng ký: —
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </td>
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-800">
                                    <c:out value="${lop.soBuoi}" /> buổi
                                </p>
                            </td>
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-800">
                                    <c:out value="${lop.siSoToiDa}" /> học viên
                                </p>
                            </td>
                            <td class="px-6 py-5">
                                <p class="font-semibold text-slate-800">
                                    <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />
                                    <span class="text-xs text-slate-500 ml-1">VND</span>
                                </p>
                            </td>
                            <td class="px-6 py-5 text-right">
                                <span class="inline-flex items-center justify-end gap-2 rounded-full px-3 py-1 text-xs font-semibold ${statusBadgeClass}">
                                    <c:out value="${statusText}" />
                                </span>
                            </td>
                            <td class="px-6 py-5 text-right space-x-2">
                                <button type="button"
                                        class="js-edit-class inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition"
                                        data-id="${lop.id}"
                                        data-tieu-de="${fn:escapeXml(lop.tieuDe)}"
                                        data-mo-ta-ngan="${fn:escapeXml(lop.moTaNgan)}"
                                        data-hinh-thuc="${fn:escapeXml(lop.hinhThuc)}"
                                        data-nhip-do="${fn:escapeXml(lop.nhipDo)}"
                                        data-ngay-khai-giang="${ngayKhaiGiangIso}"
                                        data-ngay-het-han="${ngayHetHanIso}"
                                        data-so-buoi="${lop.soBuoi}"
                                        data-gio-moi-buoi="${lop.gioMoiBuoi}"
                                        data-hoc-phi="${lop.hocPhi}"
                                        data-si-so="${lop.siSoToiDa}"
                                        data-tinh-trang="${fn:escapeXml(lop.tinhTrang)}"
                                        data-noi-dung="${fn:escapeXml(lop.noiDungChiTiet)}">
                                    Sửa
                                </button>
                                <form method="post" action="<c:url value='/admin/lop-on' />" class="inline">
                                    <input type="hidden" name="action" value="delete"/>
                                    <input type="hidden" name="id" value="${lop.id}"/>
                                    <button type="submit"
                                            class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500 hover:bg-rose-100 transition"
                                            onclick="return confirm('Bạn có chắc chắn muốn xoá lớp &quot;${fn:escapeXml(lop.tieuDe)}&quot;?');">
                                        Xoá
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40 text-xs text-slate-500">
                <p>Hiển thị <c:out value="${empty lopOnList ? 0 : fn:length(lopOnList)}" /> lớp ôn.</p>
                <p class="text-xs text-slate-400">Tính năng phân trang sẽ được cập nhật khi dữ liệu lớn hơn.</p>
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

<!-- Create/Edit class modal -->
<div id="class-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900" data-modal-title>Thêm hoặc chỉnh sửa lớp ôn</h3>
                <p class="text-xs text-slate-500 mt-1">Điền thông tin chi tiết để tạo mới hoặc cập nhật lớp học.</p>
            </div>
            <button data-modal-close="class-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form id="class-form" method="post" action="<c:url value='/admin/lop-on' />" class="px-6 py-6 space-y-6">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="id" value="">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label for="class-title" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tên lớp</label>
                    <input id="class-title" name="tieuDe" type="text" required
                           placeholder="Ví dụ: NE3 - Giao tiếp nâng cao"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-status" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tình trạng</label>
                    <select id="class-status" name="tinhTrang" required
                            class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option value="">Chọn tình trạng</option>
                        <option value="Đang mở">Đang mở</option>
                        <option value="Sắp mở">Sắp mở</option>
                        <option value="Đã kết thúc">Đã kết thúc</option>
                    </select>
                </div>
                <div>
                    <label for="class-format" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hình thức</label>
                    <input id="class-format" name="hinhThuc" type="text"
                           placeholder="Ví dụ: Offline · Online · Hybrid"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-pace" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nhịp độ / Lịch học</label>
                    <input id="class-pace" name="nhipDo" type="text"
                           placeholder="Ví dụ: Thứ 3 · 5 · 18:00 - 20:00"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-start" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày khai giảng</label>
                    <input id="class-start" name="ngayKhaiGiang" type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-deadline" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hạn đăng ký</label>
                    <input id="class-deadline" name="ngayHetHanDangKy" type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-sessions" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số buổi</label>
                    <input id="class-sessions" name="soBuoi" type="number" min="1" step="1"
                           placeholder="Ví dụ: 20"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-duration" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giờ mỗi buổi</label>
                    <input id="class-duration" name="gioMoiBuoi" type="number" min="0.5" step="0.5"
                           placeholder="Ví dụ: 2"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-fee" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Học phí (VND)</label>
                    <input id="class-fee" name="hocPhi" type="number" min="0" step="50000"
                           placeholder="Ví dụ: 4500000"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label for="class-capacity" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Sĩ số tối đa</label>
                    <input id="class-capacity" name="siSoToiDa" type="number" min="5" step="1"
                           placeholder="Ví dụ: 36"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
            </div>
            <div>
                <label for="class-description" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mô tả ngắn</label>
                <textarea id="class-description" name="moTaNgan" rows="3"
                          placeholder="Nhập mô tả nổi bật để hiển thị trong danh sách."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div>
                <label for="class-content-editor" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nội dung chi tiết</label>
                <textarea id="class-content-editor" name="noiDungChiTiet" rows="6"
                          placeholder="Soạn nội dung chi tiết cho lớp, hỗ trợ định dạng với CKEditor."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <p class="text-xs text-slate-500">
                    Các thay đổi sẽ hiển thị ngay trên bảng danh sách lớp ôn.
                </p>
                <div class="flex items-center gap-3">
                    <button data-modal-close="class-modal"
                            type="button"
                            class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                        Huỷ
                    </button>
                    <button type="submit" data-submit-label
                            class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Lưu thay đổi
                    </button>
                </div>
            </div>
        </form>
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

<script src="https://cdn.ckeditor.com/4.25.1-lts/standard/ckeditor.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const body = document.body;
        const modal = document.getElementById('class-modal');
        const form = document.getElementById('class-form');
        const actionInput = form.querySelector('input[name="action"]');
        const idInput = form.querySelector('input[name="id"]');
        const modalTitle = modal.querySelector('[data-modal-title]');
        const submitLabel = modal.querySelector('[data-submit-label]');
        const editButtons = document.querySelectorAll('.js-edit-class');
        const closeButtons = modal.querySelectorAll('[data-modal-close]');
        let editorInstance = null;

        const toggleModal = (show) => {
            if (show) {
                modal.classList.remove('hidden');
                modal.classList.add('flex');
                body.classList.add('overflow-hidden');
            } else {
                modal.classList.add('hidden');
                modal.classList.remove('flex');
                body.classList.remove('overflow-hidden');
            }
        };

        const resetForm = () => {
            form.reset();
            idInput.value = '';
            if (editorInstance) {
                editorInstance.setData('');
            }
        };

        const setFormMode = (mode, data = {}) => {
            resetForm();
            if (mode === 'create') {
                modalTitle.textContent = 'Tạo lớp ôn mới';
                submitLabel.textContent = 'Tạo lớp';
                actionInput.value = 'create';
            } else {
                modalTitle.textContent = 'Cập nhật lớp ôn';
                submitLabel.textContent = 'Lưu thay đổi';
                actionInput.value = 'update';
                idInput.value = data.id || '';
                form.querySelector('[name="tieuDe"]').value = data.tieuDe || '';
                form.querySelector('[name="moTaNgan"]').value = data.moTaNgan || '';
                form.querySelector('[name="hinhThuc"]').value = data.hinhThuc || '';
                form.querySelector('[name="nhipDo"]').value = data.nhipDo || '';
                form.querySelector('[name="ngayKhaiGiang"]').value = data.ngayKhaiGiang || '';
                form.querySelector('[name="ngayHetHanDangKy"]').value = data.ngayHetHan || '';
                form.querySelector('[name="soBuoi"]').value = data.soBuoi || '';
                form.querySelector('[name="gioMoiBuoi"]').value = data.gioMoiBuoi || '';
                form.querySelector('[name="hocPhi"]').value = data.hocPhi || '';
                form.querySelector('[name="siSoToiDa"]').value = data.siSo || '';
                form.querySelector('[name="tinhTrang"]').value = data.tinhTrang || '';
                if (editorInstance) {
                    editorInstance.setData(data.noiDungChiTiet || '');
                } else if (window.CKEDITOR && CKEDITOR.instances['class-content-editor']) {
                    CKEDITOR.instances['class-content-editor'].setData(data.noiDungChiTiet || '');
                } else {
                    form.querySelector('[name="noiDungChiTiet"]').value = data.noiDungChiTiet || '';
                }
            }
        };

        editButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const { id, tieuDe, moTaNgan, hinhThuc, nhipDo, ngayKhaiGiang, ngayHetHan, soBuoi, gioMoiBuoi, hocPhi, siSo, tinhTrang } = btn.dataset;
                const noiDungChiTiet = btn.dataset.noiDung || '';
                setFormMode('update', {
                    id,
                    tieuDe,
                    moTaNgan,
                    hinhThuc,
                    nhipDo,
                    ngayKhaiGiang,
                    ngayHetHan,
                    soBuoi,
                    gioMoiBuoi,
                    hocPhi,
                    siSo,
                    tinhTrang,
                    noiDungChiTiet
                });
                toggleModal(true);
            });
        });

        closeButtons.forEach(btn => {
            btn.addEventListener('click', () => toggleModal(false));
        });

        modal.addEventListener('click', (event) => {
            if (event.target === modal) {
                toggleModal(false);
            }
        });

        editorInstance = CKEDITOR.replace('class-content-editor', {
            height: 300,
            filebrowserUploadUrl: '<c:url value="/admin/upload-ckeditor" />',
            filebrowserUploadMethod: 'form'
        });
    });
</script>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


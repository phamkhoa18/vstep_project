<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <button data-modal-target="exam-import-modal"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 3v12"/>
                            <path d="M6 9h12"/>
                            <path d="M4 19h16"/>
                        </svg>
                        Nhập lịch thi
                    </button>
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
                    <p class="text-xs text-slate-500 mt-1">Chọn ngày, cơ sở, khung giờ và tình trạng để lọc dữ liệu.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                        13/11/2025
                        <button class="hover:text-primary/70" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100">
                        Cơ sở Thủ Đức
                        <button class="hover:text-primary" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <a href="#" class="font-semibold text-primary hover:text-primary/80 transition">Xoá tất cả</a>
                </div>
            </div>
            <div class="grid gap-4 md:grid-cols-4">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày thi</label>
                    <input type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Cơ sở</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả cơ sở</option>
                        <option>Quận 10</option>
                        <option>Thủ Đức</option>
                        <option>Bình Dương</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Khung giờ</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả</option>
                        <option>Sáng</option>
                        <option>Chiều</option>
                        <option>Tối</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tình trạng</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Đang mở đăng ký</option>
                        <option>Đã khoá</option>
                        <option>Hoàn thành</option>
                        <option>Cần bổ sung</option>
                    </select>
                </div>
            </div>
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-slate-900">Danh sách ca thi</h3>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Xuất danh sách
                    </button>
                </div>
                <div class="grid gap-4 md:grid-cols-2">
                    <c:choose>
                        <c:when test="${not empty examsWithDetails}">
                            <c:forEach var="examDetail" items="${examsWithDetails}">
                                <c:set var="caThi" value="${examDetail.caThi}" />
                                <c:set var="soLuongDangKy" value="${examDetail.soLuongDangKy}" />
                                <c:set var="trangThai" value="${soLuongDangKy >= caThi.sucChua ? 'Đã đầy' : (soLuongDangKy >= caThi.sucChua * 0.8 ? 'Gần đầy' : 'Đang mở')}" />
                                <article class="rounded-2xl border border-blue-50 ${soLuongDangKy >= caThi.sucChua ? 'bg-slate-50' : 'bg-white'} px-4 py-4 shadow-sm space-y-3">
                                    <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                                        <span>
                                            <c:if test="${not empty caThi.ngayThi}">
                                                <fmt:formatDate value="${caThi.ngayThi}" pattern="dd · MMM · " />
                                            </c:if>
                                            <c:if test="${not empty caThi.gioBatDau}">
                                                <fmt:formatDate value="${caThi.gioBatDau}" pattern="HH:mm" />
                                            </c:if>
                                        </span>
                                        <span class="inline-flex items-center gap-1 rounded-full ${trangThai == 'Đã đầy' ? 'bg-blue-100 text-primary' : (trangThai == 'Gần đầy' ? 'bg-orange-100 text-orange-500' : 'bg-emerald-100 text-emerald-600')} px-2 py-1 text-[11px] font-semibold">
                                            ${trangThai}
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
                                                        class="text-red-500 font-semibold hover:text-red-700">Xóa</button>
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
            </div>

            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-5">
                <h3 class="text-lg font-semibold text-slate-900">Bảng phân bổ phòng</h3>
                <div class="space-y-3 text-sm text-slate-600">
                    <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-1">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">A203 · Thi giấy · 50 chỗ</p>
                            <span class="text-xs font-semibold text-primary">100% sử dụng</span>
                        </div>
                        <p class="text-xs text-slate-400">Giám sát chính: Phạm Khánh · Dự phòng: Lý Hưng</p>
                    </div>
                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-1">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">B102 · Thi máy · 60 chỗ</p>
                            <span class="text-xs font-semibold text-orange-500">Thiếu 2 giám sát</span>
                        </div>
                        <p class="text-xs text-slate-400">Cần kiểm tra 6 máy trước 12/11 · kỹ thuật phụ trách: Đức Tín</p>
                    </div>
                    <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-1">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">C101 · Thi giấy · 60 chỗ</p>
                            <span class="text-xs font-semibold text-emerald-500">Ổn định</span>
                        </div>
                        <p class="text-xs text-slate-400">Giám sát: Vũ An · Dự phòng: Hồng Minh · Hạn báo cáo 10/11</p>
                    </div>
                    <button class="w-full inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                        Tải sơ đồ phòng
                    </button>
                </div>
            </div>
        </section>
        </main>
    </div>
</div>


<!-- Import exam modal -->
<div id="exam-import-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify_between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Nhập lịch thi</h3>
                <p class="text-xs text-slate-500 mt-1">Tải lên file Excel/CSV để đồng bộ ca thi hàng loạt.</p>
            </div>
            <button data-modal-close="exam-import-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6">
            <div class="rounded-2xl border-2 border-dashed border-blue-100 bg-primary.pale/40 px-6 py-10 text-center">
                <p class="text-sm font-semibold text-slate-800">Kéo & thả file vào đây</p>
                <p class="text-xs text-slate-500 mt-2">Hỗ trợ .xlsx, .csv · tối đa 10MB</p>
                <button class="mt-4 inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                    Chọn file từ máy
                </button>
            </div>
            <div class="text-xs text-slate-500 space-y-2">
                <p>• Cột bắt buộc: mã ca, ngày thi, giờ thi, phòng thi, hình thức, số lượng tối đa.</p>
                <p>• Bạn có thể tải <a href="#" class="text-primary font-semibold hover:text-primary/80">template chuẩn</a> để điền dữ liệu.</p>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="exam-import-modal"
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

<!-- Assign modal -->
<div id="assign-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Phân công giám sát viên</h3>
                <p class="text-xs text-slate-500 mt-1">Chọn giám sát chính và dự phòng cho ca thi.</p>
            </div>
        <button data-modal-close="assign-modal"
                class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
            ×
        </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ca thi</label>
                <input type="text" value="CA-1261 · 13/11/2025 · 13:30" readonly
                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-primary.pale/40 px-4 py-3 text-sm text-slate-500">
            </div>
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giám sát chính</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Chọn giám sát viên</option>
                        <option>Nguyễn Thảo</option>
                        <option>Trần Mẫn</option>
                        <option>Lê Hưng</option>
                        <option>Đặng Huệ</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giám sát dự phòng</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Chọn giám sát viên</option>
                        <option>Nguyễn Thảo</option>
                        <option>Trần Mẫn</option>
                        <option>Lê Hưng</option>
                        <option>Đặng Huệ</option>
                    </select>
                </div>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú</label>
                <textarea rows="3" placeholder="Nhập ghi chú thêm: kiểm tra máy tính trước giờ thi 60 phút..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="assign-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Lưu phân công
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>

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


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa lớp ôn | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
    <script src="https://cdn.ckeditor.com/4.25.1-lts/standard/ckeditor.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/airbnb.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <style>
        .sh-input {
            width: 100%;
            border-radius: 1rem;
            border: 1px solid rgba(59, 130, 246, 0.12);
            background-color: #ffffff;
            padding: 0.75rem 1rem;
            font-size: 0.875rem;
            line-height: 1.25rem;
            color: #1f2937;
            box-shadow: 0 1px 2px rgba(15, 23, 42, 0.05);
            transition: all 0.18s ease;
        }
        .sh-input:focus {
            border-color: rgba(37, 99, 235, 0.45);
            outline: none;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.18);
        }
        .sh-input:disabled {
            background-color: #f1f5f9;
            color: #94a3b8;
            cursor: not-allowed;
        }
        .sh-select {
            appearance: none;
            padding-right: 2.5rem;
            font-weight: 600;
            background: linear-gradient(180deg, #ffffff 0%, #f8fbff 100%);
        }
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-wrapper svg,
        .input-wrapper span[data-icon] {
            position: absolute;
            right: 0.85rem;
            color: #94a3b8;
            pointer-events: none;
            font-weight: 600;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
    </style>
</head>
<body data-page="classes" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<c:if test="${empty lopOn}">
    <div class="p-10 text-center text-rose-500 font-semibold">
        Không tìm thấy lớp ôn cần chỉnh sửa.
    </div>
</c:if>

<c:if test="${not empty lopOn}">
<c:set var="hinhThucLower" value="${fn:toLowerCase(lopOn.hinhThuc)}"/>
<c:set var="nhipDoLower" value="${fn:toLowerCase(lopOn.nhipDo)}"/>
<c:set var="tinhTrangLower" value="${fn:toLowerCase(lopOn.tinhTrang)}"/>
<fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="yyyy-MM-dd" var="ngayKhaiGiangIso"/>
<fmt:formatDate value="${lopOn.ngayKetThuc}" pattern="yyyy-MM-dd" var="ngayKetThucIso"/>
<fmt:formatDate value="${lopOn.gioMoiBuoi}" pattern="HH:mm" var="gioMoiBuoiDisplay"/>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
            <section class="space-y-4">
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin/classes"
                       class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                        ←
                    </a>
                    <div>
                        <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Chỉnh sửa lớp ôn</h2>
                        <p class="text-sm text-slate-500 mt-1">Cập nhật thông tin lớp ôn, lịch học và mô tả chi tiết.</p>
                    </div>
                </div>
                <div class="rounded-3xl bg-primary.pale/50 border border-blue-50 px-6 py-4 text-sm text-slate-600">
                    Mã lớp hiện tại: <span class="font-semibold text-primary">${lopOn.maLop}</span>. Thay đổi sẽ được áp dụng ngay sau khi lưu.
                </div>
            </section>

            <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8">
                <form method="post" action="${pageContext.request.contextPath}/admin/lop-on" class="space-y-8" id="edit-class-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${lopOn.id}">
                    <input type="hidden" name="maLop" value="${lopOn.maLop}">

                    <div class="grid gap-6 md:grid-cols-4">
                        <div>
                            <label for="edit-title" class="text-xs font-semibold uppercase text-slate-500">
                                Tên lớp <span class="text-rose-500">*</span>
                            </label>
                            <input id="edit-title" name="tieuDe" type="text" required
                                   value="${lopOn.tieuDe}"
                                   placeholder="Ví dụ: NE3 - Giao tiếp nâng cao"
                                   class="mt-2 sh-input">
                        </div>

                        <div>
                            <label for="edit-slug" class="text-xs font-semibold uppercase text-slate-500">
                                Slug
                            </label>
                            <div class="relative mt-2">
                                <input id="edit-slug" name="slug" type="text"
                                       value="${lopOn.slug}"
                                       placeholder="ne3-giao-tiep-nang-cao"
                                       class="sh-input w-full pr-10">
                                <button type="button" id="edit-generate-slug"
                                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                                        title="Tạo slug tự động">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M4 4v6h6M20 20v-6h-6M5 19a9 9 0 0114-7.5M19 5a9 9 0 00-14 7.5" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div>
                            <label for="edit-format" class="text-xs font-semibold uppercase text-slate-500">
                                Hình thức <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <select id="edit-format" name="hinhThuc" class="sh-input sh-select pr-10">
                                    <option value="" ${empty lopOn.hinhThuc ? "selected" : ""}>Chọn hình thức</option>
                                    <option value="Offline" ${hinhThucLower eq 'offline' ? "selected" : ""}>Offline (tại trung tâm)</option>
                                    <option value="Online" ${hinhThucLower eq 'online' ? "selected" : ""}>Online (qua nền tảng số)</option>
                                </select>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     class="pointer-events-none absolute right-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                                     fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="m6 9 6 6 6-6"/>
                                </svg>
                            </div>
                        </div>

                        <div>
                            <label for="edit-pace" class="text-xs font-semibold uppercase text-slate-500">
                                Nhịp độ lớp <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <select id="edit-pace" name="nhipDo" class="sh-input sh-select pr-10">
                                    <option value="">Chọn nhịp độ</option>
                                    <option value="thuong" ${nhipDoLower eq 'thuong' or nhipDoLower eq 'thường' ? "selected" : ""}>Thường</option>
                                    <option value="captoc" ${nhipDoLower eq 'captoc' or nhipDoLower eq 'cấp tốc' or nhipDoLower eq 'cap toc' ? "selected" : ""}>Cấp tốc</option>
                                </select>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     class="pointer-events-none absolute right-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                                     fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="m6 9 6 6 6-6"/>
                                </svg>
                            </div>
                        </div>

                        <div>
                            <label for="edit-start" class="text-xs font-semibold uppercase text-slate-500">Ngày khai giảng</label>
                            <div class="mt-2 input-wrapper">
                                <input id="edit-start" name="ngayKhaiGiang" type="text"
                                       value="${ngayKhaiGiangIso}"
                                       placeholder="dd/mm/yyyy"
                                       class="sh-input pr-10">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="M7 4V2M17 4V2M3 9h18"/>
                                    <rect width="18" height="18" x="3" y="4" rx="2"/>
                                </svg>
                            </div>
                        </div>

                        <div>
                            <label for="edit-deadline" class="text-xs font-semibold uppercase text-slate-500">Hạn đăng ký</label>
                            <div class="mt-2 input-wrapper">
                                <input id="edit-deadline" name="ngayKetThuc" type="text"
                                       value="${ngayKetThucIso}"
                                       placeholder="dd/mm/yyyy"
                                       class="sh-input pr-10">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="M7 4V2M17 4V2M3 9h18"/>
                                    <rect width="18" height="18" x="3" y="4" rx="2"/>
                                </svg>
                            </div>
                        </div>

                        <div>
                            <label for="edit-sessions" class="text-xs font-semibold uppercase text-slate-500">Số buổi</label>
                            <input id="edit-sessions" name="soBuoi" type="number" min="1" step="1"
                                   value="${lopOn.soBuoi}"
                                   placeholder="Ví dụ: 20"
                                   class="mt-2 sh-input">
                        </div>

                        <div class="relative">
                            <label for="edit-duration" class="text-xs font-semibold uppercase text-slate-500">
                                Giờ mỗi buổi (giờ : phút)
                            </label>
                            <div class="relative mt-2">
                                <input id="edit-duration" name="gioMoiBuoi" type="text"
                                       value="${gioMoiBuoiDisplay}"
                                       placeholder="Chọn giờ mỗi buổi (hh:mm)"
                                       class="sh-input w-full pr-10 cursor-pointer">
                                <button type="button" id="edit-toggle-duration"
                                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                                        title="Chọn giờ">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div>
                            <label for="edit-fee" class="text-xs font-semibold uppercase text-slate-500">
                                Học phí (VND)
                            </label>
                            <div class="relative mt-2">
                                <input id="edit-fee"
                                       name="hocPhi"
                                       type="text"
                                       inputmode="numeric"
                                       data-initial-fee="${lopOn.hocPhi}"
                                       placeholder="Ví dụ: 4.500.000"
                                       class="sh-input w-full text-right pr-14">
                                <span class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none">
                                    VND
                                </span>
                            </div>
                        </div>

                        <div>
                            <label for="edit-capacity" class="text-xs font-semibold uppercase text-slate-500">Sĩ số tối đa</label>
                            <input id="edit-capacity" name="siSoToiDa" type="number" min="5" step="1"
                                   value="${lopOn.siSoToiDa}"
                                   placeholder="Ví dụ: 36"
                                   class="mt-2 sh-input">
                        </div>

                        <div>
                            <label for="edit-schedule" class="text-xs font-semibold uppercase text-slate-500">Thời gian học</label>
                            <input id="edit-schedule" name="thoiGianHoc" type="text"
                                   value="${lopOn.thoiGianHoc}"
                                   placeholder="Ví dụ: Thứ 3 & Thứ 5 · 18:00 - 20:00"
                                   class="mt-2 sh-input">
                        </div>

                        <div>
                            <label for="edit-status" class="text-xs font-semibold uppercase text-slate-500">Tình trạng</label>
                            <select id="edit-status" name="tinhTrang" required class="mt-2 sh-input sh-select pr-10">
                                <option value="">Chọn tình trạng</option>
                                <option value="Đang mở" ${fn:contains(tinhTrangLower, 'đang') or fn:contains(tinhTrangLower, 'dang') ? "selected" : ""}>Đang mở</option>
                                <option value="Sắp mở" ${fn:contains(tinhTrangLower, 'sắp') or fn:contains(tinhTrangLower, 'sap') ? "selected" : ""}>Sắp mở</option>
                                <option value="Đã kết thúc" ${fn:contains(tinhTrangLower, 'kết thúc') or fn:contains(tinhTrangLower, 'ket thuc') ? "selected" : ""}>Đã kết thúc</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <label for="edit-description" class="text-xs font-semibold uppercase text-slate-500">Mô tả ngắn</label>
                        <textarea id="edit-description" name="moTaNgan" rows="4"
                                  placeholder="Nhập mô tả nổi bật để hiển thị trong danh sách lớp."
                                  class="mt-2 sh-input"><c:out value="${lopOn.moTaNgan}" /></textarea>
                    </div>

                    <div>
                        <label for="edit-content-editor" class="text-xs font-semibold uppercase text-slate-500">
                            Nội dung chi tiết
                        </label>
                        <textarea id="edit-content-editor" name="noiDungChiTiet" rows="8"
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30"><c:out value="${lopOn.noiDungChiTiet}" escapeXml="false" /></textarea>
                    </div>

                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <p class="text-xs text-slate-500">
                            Kiểm tra kỹ thông tin trước khi lưu. Thay đổi sẽ ảnh hưởng trực tiếp đến danh sách lớp.
                        </p>
                        <div class="flex items-center gap-3">
                            <a href="${pageContext.request.contextPath}/admin/classes"
                               class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                Huỷ
                            </a>
                            <button type="submit"
                                    class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Lưu thay đổi
                            </button>
                        </div>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>
</c:if>

<%@ include file="layout/admin-scripts.jspf" %>

<script>
    function toSlug(str) {
        if (!str) return '';
        return str
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/[^a-z0-9\s-]/g, '')
            .trim()
            .replace(/\s+/g, '-')
            .replace(/-+/g, '-');
    }

    document.addEventListener('DOMContentLoaded', () => {
        const titleInput = document.getElementById('edit-title');
        const slugInput = document.getElementById('edit-slug');
        const slugBtn = document.getElementById('edit-generate-slug');
        const feeInput = document.getElementById('edit-fee');
        const form = document.getElementById('edit-class-form');

        const datepickers = ['#edit-start', '#edit-deadline'];
        datepickers.forEach(selector => {
            const el = document.querySelector(selector);
            if (!el) return;
            flatpickr(el, {
                altInput: true,
                altFormat: 'd/m/Y',
                dateFormat: 'Y-m-d',
                defaultDate: el.value || null,
                allowInput: false,
                locale: {
                    firstDayOfWeek: 1
                },
                onReady: (_, __, fp) => {
                    const altInput = fp.altInput;
                    if (altInput) {
                        altInput.classList.add('sh-input', 'pr-10');
                        altInput.placeholder = 'dd/mm/yyyy';
                    }
                }
            });
        });

        const durationInput = document.getElementById('edit-duration');
        const toggleDurationBtn = document.getElementById('edit-toggle-duration');
        if (durationInput) {
            const durationPicker = flatpickr(durationInput, {
                enableTime: true,
                noCalendar: true,
                dateFormat: 'H:i',
                defaultDate: durationInput.value || null,
                time_24hr: true,
                minuteIncrement: 5,
                allowInput: true,
                onClose: function(selectedDates, dateStr) {
                    if (dateStr) {
                        durationInput.value = dateStr;
                    }
                }
            });
            if (toggleDurationBtn) {
                toggleDurationBtn.addEventListener('click', () => durationPicker.open());
            }
        }

        function formatCurrency(value) {
            if (!value) return '';
            const digits = value.replace(/\D/g, '');
            return digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        }

        if (feeInput) {
            const initial = feeInput.dataset.initialFee || '';
            if (initial) {
                feeInput.value = formatCurrency(initial);
            }
            feeInput.addEventListener('input', () => {
                const cursor = feeInput.selectionStart;
                const raw = feeInput.value.replace(/\D/g, '');
                feeInput.value = formatCurrency(raw);
                feeInput.setSelectionRange(cursor, cursor);
            });
        }

        if (titleInput && slugInput) {
            titleInput.addEventListener('input', () => {
                if (!slugInput.dataset.manual) {
                    slugInput.value = toSlug(titleInput.value);
                }
            });
            slugInput.addEventListener('input', () => {
                slugInput.dataset.manual = '1';
            });
        }
        if (slugBtn && slugInput && titleInput) {
            slugBtn.addEventListener('click', () => {
                slugInput.value = toSlug(titleInput.value);
                slugInput.dataset.manual = '1';
            });
        }

        if (typeof CKEDITOR !== 'undefined') {
            if (CKEDITOR.instances['edit-content-editor']) {
                CKEDITOR.instances['edit-content-editor'].destroy(true);
            }
            CKEDITOR.replace('edit-content-editor', {
                height: 360,
                filebrowserUploadUrl: '${pageContext.request.contextPath}/admin/upload-ckeditor',
                filebrowserUploadMethod: 'form'
            });
        }

        if (form) {
            form.addEventListener('submit', () => {
                if (typeof CKEDITOR !== 'undefined') {
                    Object.values(CKEDITOR.instances).forEach(instance => instance.updateElement());
                }
                if (feeInput) {
                    feeInput.value = feeInput.value.replace(/\D/g, '');
                }
            });
        }
    });
</script>

</body>
</html>


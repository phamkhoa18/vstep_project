<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo lớp ôn | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
    <script src="https://cdn.ckeditor.com/4.22.1/standard/ckeditor.js"></script>
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
        .sh-select option {
            font-weight: 600;
            color: #1f2937;
            background-color: #ffffff;
            padding: 0.5rem 0.75rem;
        }
        .sh-select option[value="Offline"],
        .sh-select option[value="Đang mở"],
        .sh-select option[value="Thường"] {
            background-color: #eff6ff;
        }
        .sh-select option[value="Online"],
        .sh-select option[value="Sắp mở"],
        .sh-select option[value="Cấp tốc"] {
            background-color: #f0fdf4;
        }
        .sh-select option[value="Đã kết thúc"] {
            background-color: #f8fafc;
            color: #475569;
        }
        .sh-select:focus option:checked {
            color: #1d4ed8;
            background-color: #e0ecff;
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
        .flatpickr-input {
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
        .schedule-wrapper {
            border-radius: 1.5rem;
            border: 1px dashed rgba(37, 99, 235, 0.2);
            background: #f8fbff;
            padding: 1.5rem;
        }
        .schedule-controls {
            display: grid;
            gap: 1rem;
        }
        @media (min-width: 768px) {
            .schedule-controls {
                grid-template-columns: repeat(4, minmax(0, 1fr));
                align-items: end;
            }
        }
        .schedule-list {
            display: grid;
            gap: 0.85rem;
        }
        .schedule-empty {
            display: flex;
            align-items: center;
            gap: 0.65rem;
            font-size: 0.85rem;
            color: #64748b;
            padding: 0.9rem 1.1rem;
            border-radius: 1rem;
            background: rgba(59, 130, 246, 0.08);
            border: 1px dashed rgba(59, 130, 246, 0.18);
        }
        .schedule-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
            padding: 0.9rem 1.1rem;
            border-radius: 1rem;
            border: 1px solid rgba(59, 130, 246, 0.12);
            background: #ffffff;
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.04);
        }
        .schedule-item__meta {
            display: flex;
            flex-direction: column;
            gap: 0.2rem;
        }
        .schedule-item__day {
            font-weight: 700;
            color: #1d4ed8;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .schedule-item__time {
            font-size: 0.85rem;
            color: #475569;
        }
        .schedule-remove {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 2.25rem;
            height: 2.25rem;
            border-radius: 999px;
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #ef4444;
            background: rgba(254, 242, 242, 0.7);
            transition: all 0.2s ease;
        }
        .schedule-remove:hover {
            background: #ef4444;
            color: #ffffff;
            border-color: rgba(239, 68, 68, 0.45);
            box-shadow: 0 10px 22px rgba(239, 68, 68, 0.18);
        }
        .schedule-helper {
            font-size: 0.75rem;
            color: #64748b;
        }
        .schedule-error {
            font-size: 0.75rem;
            color: #ef4444;
        }
    </style>
</head>
<body data-page="classes" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

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
                        <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Tạo lớp ôn mới</h2>
                        <p class="text-sm text-slate-500 mt-1">Điền đầy đủ thông tin để khởi tạo lớp ôn trong hệ thống.</p>
                    </div>
                </div>
                <div class="rounded-3xl bg-primary.pale/50 border border-blue-50 px-6 py-4 text-sm text-slate-600">
                    Thông tin lớp ôn sau khi tạo sẽ hiển thị ngay trong bảng quản lý. Bạn có thể chỉnh sửa lại bất cứ lúc nào.
                </div>
            </section>

            <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8">
                <form method="post" action="${pageContext.request.contextPath}/admin/lop-on" class="space-y-8">
                    <input type="hidden" name="action" value="create">

                    <div class="grid gap-6 md:grid-cols-4">
                        <div>
                            <label for="create-title" class="text-xs font-semibold uppercase text-slate-500">
                                Tên lớp <span class="text-rose-500">*</span>
                            </label>
                            <input id="create-title" name="tieuDe" type="text" required
                                   placeholder="Ví dụ: NE3 - Giao tiếp nâng cao"
                                   class="mt-2 sh-input">
                        </div>
                        <div>
                            <label for="create-slug" class="text-xs font-semibold uppercase text-slate-500">
                                Slug
                            </label>
                            <div class="relative mt-2">
                                <input id="create-slug" name="slug" type="text"
                                       placeholder="ne3-giao-tiep-nang-cao"
                                       class="sh-input w-full pr-10">
                                <button type="button" id="generate-slug"
                                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                                        title="Tạo slug tự động">
                                    <!-- icon refresh -->
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M4 4v6h6M20 20v-6h-6M5 19a9 9 0 0114-7.5M19 5a9 9 0 00-14 7.5" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                        <div>
                            <label for="create-format" class="text-xs font-semibold uppercase text-slate-500">
                                Hình thức <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <select id="create-format" name="hinhThuc"
                                        class="sh-input sh-select pr-10">
                                    <option value="offline" selected>Offline</option>
                                    <option value="online">Online</option>
                                </select>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     class="pointer-events-none absolute right-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                                     fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="m6 9 6 6 6-6"/>
                                </svg>
                            </div>
                        </div>
                        <div>
                            <label for="create-pace" class="text-xs font-semibold uppercase text-slate-500">
                                Nhịp độ lớp <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <select id="create-pace" name="nhipDo"
                                        class="sh-input sh-select pr-10">
                                    <option value="thuong" selected>Thường</option>
                                    <option value="captoc">Cấp tốc</option>
                                </select>
                                <svg xmlns="http://www.w3.org/2000/svg"
                                     class="pointer-events-none absolute right-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"
                                     fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <path d="m6 9 6 6 6-6"/>
                                </svg>
                            </div>
                        </div>
                        <div>
                            <label for="create-start" class="text-xs font-semibold uppercase text-slate-500">Ngày khai giảng</label>
                            <div class="mt-2 input-wrapper">
                                <input id="create-start" name="ngayKhaiGiang" type="text"
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
                            <label for="create-deadline" class="text-xs font-semibold uppercase text-slate-500">Hạn đăng ký</label>
                            <div class="mt-2 input-wrapper">
                                <input id="create-deadline" name="ngayKetThuc" type="text"
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
                            <label for="create-sessions" class="text-xs font-semibold uppercase text-slate-500">Số buổi</label>
                            <input id="create-sessions" name="soBuoi" type="number" min="1" step="1"
                                   placeholder="Ví dụ: 20"
                                   class="mt-2 sh-input">
                        </div>

                        <!-- Vùng input chọn thời lượng -->
                        <div class="relative">
                            <label for="create-duration" class="text-xs font-semibold uppercase text-slate-500">
                                Giờ mỗi buổi (giờ : phút)
                            </label>
                            <div class="relative mt-2">
                                <input id="create-duration" name="gioMoiBuoi" type="text"
                                       placeholder="Chọn giờ mỗi buổi (hh:mm)"
                                       class="sh-input w-full pr-10 cursor-pointer">
                                <button type="button" id="toggle-duration"
                                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                                        title="Chọn giờ">
                                    <!-- Icon đồng hồ -->
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <input type="hidden" id="hocPhiLong" name="hocPhi">

                        <div>
                            <label for="create-fee" class="text-xs font-semibold uppercase text-slate-500">
                                Học phí (VND)
                            </label>
                            <div class="relative mt-2">
                                <!-- input hiển thị -->
                                <input
                                        id="create-fee"
                                        name="hocPhi"
                                        type="text"
                                        inputmode="numeric"
                                        placeholder="Ví dụ: 4.500.000"
                                        class="sh-input w-full text-right pr-14"
                                >
                                <!-- đơn vị VND nằm trong input -->
                                <span
                                        class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none"
                                >VND</span>
                            </div>
                        </div>

                        <div>
                            <label for="create-capacity" class="text-xs font-semibold uppercase text-slate-500">Sĩ số tối đa</label>
                            <input id="create-capacity" name="siSoToiDa" type="number" min="1" step="1"
                                   placeholder="Ví dụ: 36"
                                   class="mt-2 sh-input">
                        </div>

                        <div>
                            <label for="create-capacity" class="text-xs font-semibold uppercase text-slate-500">Thời gian học</label>
                            <input id="create-capacity" name="thoiGianHoc" type="text"
                                   placeholder="Ví dụ: Thứ 3, Thứ 4 : 16PM - 18PM"
                                   class="mt-2 sh-input">
                        </div>


                    </div>


                    <div>
                        <label for="create-description" class="text-xs font-semibold uppercase text-slate-500">Mô tả ngắn</label>
                        <textarea id="create-description" name="moTaNgan" rows="4"
                                  placeholder="Nhập mô tả nổi bật để hiển thị trong danh sách lớp."
                                  class="mt-2 sh-input"></textarea>
                    </div>

                    <div>
                        <label for="create-content-editor" class="text-xs font-semibold uppercase text-slate-500">
                            Nội dung chi tiết
                        </label>
                        <!-- textarea sẽ biến thành CKEditor -->
                        <textarea id="create-content-editor" name="noiDungChiTiet" rows="8"
                                  placeholder="Soạn nội dung chi tiết cho lớp ôn."
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
                    </div>

                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <p class="text-xs text-slate-500">
                            Kiểm tra kỹ thông tin trước khi lưu. Bạn có thể chỉnh sửa lại trong trang danh sách lớp.
                        </p>
                        <div class="flex items-center gap-3">
                            <a href="${pageContext.request.contextPath}/admin/classes"
                               class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                Huỷ
                            </a>
                            <button type="submit"
                                    class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Tạo lớp
                            </button>
                        </div>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const form = document.querySelector('form');
        const scheduleHiddenInput = document.getElementById('schedule-data');
        const scheduleList = document.getElementById('schedule-list');
        const scheduleDaySelect = document.getElementById('schedule-day');
        const scheduleStartInput = document.getElementById('schedule-start');
        const scheduleEndInput = document.getElementById('schedule-end');
        const addScheduleBtn = document.getElementById('add-schedule');
        const clearScheduleBtn = document.getElementById('clear-schedule');
        const scheduleError = document.getElementById('schedule-error');

        const weekdayLabels = {
            MON: 'Thứ 2',
            TUE: 'Thứ 3',
            WED: 'Thứ 4',
            THU: 'Thứ 5',
            FRI: 'Thứ 6',
            SAT: 'Thứ 7',
            SUN: 'Chủ nhật'
        };

        const scheduleEntries = [];

        const hideScheduleError = () => {
            if (scheduleError) {
                scheduleError.textContent = '';
                scheduleError.classList.add('hidden');
            }
        };

        const showScheduleError = (message) => {
            if (scheduleError) {
                scheduleError.textContent = message;
                scheduleError.classList.remove('hidden');
            }
        };

        const toMinutes = (value) => {
            if (!value || value.indexOf(':') === -1) {
                return 0;
            }
            const parts = value.split(':');
            const hour = parseInt(parts[0], 10);
            const minute = parts.length > 1 ? parseInt(parts[1], 10) : 0;
            if (isNaN(hour) || isNaN(minute)) {
                return 0;
            }
            return hour * 60 + minute;
        };

        const updateScheduleHiddenInput = () => {
            if (!scheduleHiddenInput) {
                return;
            }
            scheduleHiddenInput.value = scheduleEntries.length ? JSON.stringify(scheduleEntries) : '';
        };

        const renderSchedule = () => {
            if (!scheduleList) {
                return;
            }

            scheduleList.innerHTML = '';

            if (!scheduleEntries.length) {
                const emptyState = document.createElement('div');
                emptyState.className = 'schedule-empty';
                emptyState.textContent = 'Chưa có lịch học nào. Thêm lịch bên dưới để hiển thị tại trang lớp.';
                scheduleList.appendChild(emptyState);
                return;
            }

            scheduleEntries.forEach((entry, index) => {
                const item = document.createElement('div');
                item.className = 'schedule-item';

                const meta = document.createElement('div');
                meta.className = 'schedule-item__meta';

                const dayEl = document.createElement('span');
                dayEl.className = 'schedule-item__day';
                dayEl.textContent = entry.dayLabel;

                const timeEl = document.createElement('span');
                timeEl.className = 'schedule-item__time';
                timeEl.textContent = `${entry.startTime} - ${entry.endTime}`;

                meta.appendChild(dayEl);
                meta.appendChild(timeEl);

                const dayInput = document.createElement('input');
                dayInput.type = 'hidden';
                dayInput.name = 'lichHocDay[]';
                dayInput.value = entry.day;

                const startInput = document.createElement('input');
                startInput.type = 'hidden';
                startInput.name = 'lichHocStart[]';
                startInput.value = entry.startTime;

                const endInput = document.createElement('input');
                endInput.type = 'hidden';
                endInput.name = 'lichHocEnd[]';
                endInput.value = entry.endTime;

                const removeBtn = document.createElement('button');
                removeBtn.type = 'button';
                removeBtn.className = 'schedule-remove';
                removeBtn.dataset.removeIndex = String(index);
                removeBtn.title = 'Xoá lịch này';
                removeBtn.innerHTML = `
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                `;

                item.appendChild(meta);
                item.appendChild(dayInput);
                item.appendChild(startInput);
                item.appendChild(endInput);
                item.appendChild(removeBtn);

                scheduleList.appendChild(item);
            });
        };

        const parseExistingSchedule = () => {
            if (!scheduleHiddenInput || !scheduleHiddenInput.value) {
                return;
            }
            try {
                const parsed = JSON.parse(scheduleHiddenInput.value);
                if (!Array.isArray(parsed)) {
                    scheduleHiddenInput.value = '';
                    return;
                }
                parsed.forEach(item => {
                    if (!item) return;
                    const day = typeof item.day === 'string' ? item.day.toUpperCase() : '';
                    const startTime = typeof item.startTime === 'string' ? item.startTime : '';
                    const endTime = typeof item.endTime === 'string' ? item.endTime : '';
                    if (!day || !startTime || !endTime) {
                        return;
                    }
                    scheduleEntries.push({
                        day,
                        dayLabel: weekdayLabels[day] || item.dayLabel || day,
                        startTime,
                        endTime
                    });
                });
            } catch (error) {
                console.warn('Không thể đọc dữ liệu lịch học đã lưu.', error);
                scheduleHiddenInput.value = '';
            }
        };

        parseExistingSchedule();
        renderSchedule();
        updateScheduleHiddenInput();

        if (addScheduleBtn) {
            addScheduleBtn.addEventListener('click', () => {
                hideScheduleError();

                const dayValue = scheduleDaySelect ? scheduleDaySelect.value : '';
                const startTime = scheduleStartInput ? scheduleStartInput.value : '';
                const endTime = scheduleEndInput ? scheduleEndInput.value : '';

                if (!dayValue || !startTime || !endTime) {
                    showScheduleError('Vui lòng chọn ngày học và nhập đầy đủ giờ bắt đầu/kết thúc.');
                    return;
                }

                if (toMinutes(endTime) <= toMinutes(startTime)) {
                    showScheduleError('Giờ kết thúc phải lớn hơn giờ bắt đầu.');
                    return;
                }

                const isDuplicated = scheduleEntries.some(entry =>
                    entry.day === dayValue &&
                    entry.startTime === startTime &&
                    entry.endTime === endTime
                );

                if (isDuplicated) {
                    showScheduleError('Lịch học này đã tồn tại.');
                    return;
                }

                scheduleEntries.push({
                    day: dayValue,
                    dayLabel: weekdayLabels[dayValue] || dayValue,
                    startTime,
                    endTime
                });

                renderSchedule();
                updateScheduleHiddenInput();

                if (scheduleDaySelect) {
                    scheduleDaySelect.value = '';
                }
                if (scheduleStartInput) {
                    scheduleStartInput.value = '';
                }
                if (scheduleEndInput) {
                    scheduleEndInput.value = '';
                }
            });
        }

        if (clearScheduleBtn) {
            clearScheduleBtn.addEventListener('click', () => {
                if (!scheduleEntries.length) {
                    return;
                }
                scheduleEntries.length = 0;
                renderSchedule();
                updateScheduleHiddenInput();
                hideScheduleError();
            });
        }

        if (scheduleList) {
            scheduleList.addEventListener('click', (event) => {
                var target = event.target;
                if (!(target instanceof Element)) {
                    return;
                }
                var removeBtn = target.closest('[data-remove-index]');
                if (!removeBtn) {
                    return;
                }
                var index = parseInt(removeBtn.getAttribute('data-remove-index') || '', 10);
                if (isNaN(index)) {
                    return;
                }
                scheduleEntries.splice(index, 1);
                renderSchedule();
                updateScheduleHiddenInput();
                hideScheduleError();
            });
        }

        [scheduleDaySelect, scheduleStartInput, scheduleEndInput].forEach(function (el) {
            if (!el) return;
            el.addEventListener('input', hideScheduleError);
            el.addEventListener('change', hideScheduleError);
        });

        if (typeof CKEDITOR !== 'undefined') {
            if (CKEDITOR.instances['create-content-editor']) {
                CKEDITOR.instances['create-content-editor'].destroy(true);
            }
            CKEDITOR.replace('create-content-editor', {
                height: 360,
                filebrowserUploadUrl: '${pageContext.request.contextPath}/admin/upload-ckeditor',
                filebrowserUploadMethod: 'form'
            });
        }

        if (form) {
            form.addEventListener('submit', () => {
                // Cập nhật CKEditor
                if (typeof CKEDITOR !== 'undefined') {
                    Object.values(CKEDITOR.instances).forEach(instance => instance.updateElement());
                }

                updateScheduleHiddenInput();

                // Chuyển học phí sang giá trị long
                const rawFee = feeInput.value.replace(/\D/g, ''); // bỏ dấu chấm
                document.getElementById('hocPhiLong').value = rawFee; // backend nhận long
            });
        }

        const datepickers = ['#create-start', '#create-deadline'];
        datepickers.forEach(selector => {
            const el = document.querySelector(selector);
            if (!el) return;
            flatpickr(el, {
                altInput: true,
                altFormat: 'd/m/Y',
                dateFormat: 'Y-m-d',
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
    });
</script>

<script>
    function toSlug(str) {
        return str
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/[^a-z0-9\s-]/g, '')
            .trim()
            .replace(/\s+/g, '-')
            .replace(/-+/g, '-');
    }

    const titleInput = document.getElementById('create-title');
    const slugInput = document.getElementById('create-slug');
    const generateBtn = document.getElementById('generate-slug');

    // Tự động tạo slug khi gõ tiêu đề
    titleInput.addEventListener('input', () => {
        slugInput.value = toSlug(titleInput.value);
    });

    // Nút icon tạo tự động
    generateBtn.addEventListener('click', () => {
        slugInput.value = toSlug(titleInput.value);
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        const input = document.getElementById("create-duration");
        const toggleBtn = document.getElementById("toggle-duration");

        // Khởi tạo Flatpickr chỉ dùng chọn giờ
        const fp = flatpickr(input, {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
            time_24hr: true,
            minuteIncrement: 5,
            allowInput: true,
            onClose: function(selectedDates, dateStr) {
                if (dateStr) {
                    input.value = dateStr; // đảm bảo hiển thị giá trị
                }
            }
        });

        // Khi nhấn icon đồng hồ thì mở Flatpickr
        toggleBtn.addEventListener("click", () => {
            fp.open();
        });
    });
</script>

<script>
    const feeInput = document.getElementById('create-fee');

    /**
     * Format giá trị có dấu chấm ngăn cách hàng nghìn
     * Ex: 4500000 => "4.500.000"
     */
    function formatCurrency(value) {
        if (!value) return '';
        const digits = value.replace(/\D/g, '');
        return digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
    }

    /**
     * Khi nhập, tự format và giữ con trỏ đúng chỗ
     */
    feeInput.addEventListener('input', () => {
        const cursorPos = feeInput.selectionStart;
        const raw = feeInput.value.replace(/\D/g, '');
        feeInput.value = formatCurrency(raw);
        feeInput.setSelectionRange(cursorPos, cursorPos);
    });

    /**
     * Khi submit form, bạn có thể lấy giá trị thực (không dấu chấm)
     * const feeValue = parseInt(feeInput.value.replace(/\./g, ''));
     */
</script>


</body>
</html>


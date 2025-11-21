<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo ca thi | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
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
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-wrapper svg {
            position: absolute;
            right: 0.85rem;
            color: #94a3b8;
            pointer-events: none;
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
    </style>
</head>
<body data-page="exams" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
            <section class="space-y-4">
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin/exams"
                       class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                        ←
                    </a>
                    <div>
                        <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Tạo ca thi mới</h2>
                        <p class="text-sm text-slate-500 mt-1">Điền đầy đủ thông tin để khởi tạo ca thi trong hệ thống.</p>
                    </div>
                </div>
                <div class="rounded-3xl bg-primary.pale/50 border border-blue-50 px-6 py-4 text-sm text-slate-600">
                    Thông tin ca thi sau khi tạo sẽ hiển thị ngay trong bảng quản lý. Bạn có thể chỉnh sửa lại bất cứ lúc nào.
                </div>
            </section>

            <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8">
                <form method="post" action="${pageContext.request.contextPath}/admin/ca-thi" class="space-y-8">
                    <input type="hidden" name="action" value="create">

                    <div class="grid gap-6 md:grid-cols-2">
                        <div>
                            <label for="create-maCaThi" class="text-xs font-semibold uppercase text-slate-500">
                                Mã ca thi
                            </label>
                            <div class="relative mt-2">
                                <input id="create-maCaThi" name="maCaThi" type="text"
                                       placeholder="Để trống để tự động tạo"
                                       class="sh-input">
                                <button type="button" id="generate-maCaThi"
                                        class="absolute inset-y-0 right-0 flex items-center pr-3 text-slate-400 hover:text-slate-600"
                                        title="Tạo mã tự động">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M4 4v6h6M20 20v-6h-6M5 19a9 9 0 0114-7.5M19 5a9 9 0 00-14 7.5" />
                                    </svg>
                                </button>
                            </div>
                            <p class="text-xs text-slate-400 mt-1">Để trống để hệ thống tự động tạo mã</p>
                        </div>

                        <div>
                            <label for="create-ngayThi" class="text-xs font-semibold uppercase text-slate-500">
                                Ngày thi <span class="text-rose-500">*</span>
                            </label>
                            <div class="mt-2 input-wrapper">
                                <input id="create-ngayThi" name="ngayThi" type="text" required
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
                            <label for="create-diaDiem" class="text-xs font-semibold uppercase text-slate-500">
                                Địa điểm / Phòng thi <span class="text-rose-500">*</span>
                            </label>
                            <input id="create-diaDiem" name="diaDiem" type="text" required
                                   placeholder="Ví dụ: Phòng A203, Cơ sở Quận 10"
                                   class="mt-2 sh-input">
                        </div>

                        <div>
                            <label for="create-gioBatDau" class="text-xs font-semibold uppercase text-slate-500">
                                Giờ bắt đầu <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <input id="create-gioBatDau" name="gioBatDau" type="text" required
                                       placeholder="Chọn giờ bắt đầu (HH:mm)"
                                       class="sh-input w-full pr-10 cursor-pointer">
                                <button type="button" id="toggle-gioBatDau"
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
                            <label for="create-gioKetThuc" class="text-xs font-semibold uppercase text-slate-500">
                                Giờ kết thúc <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <input id="create-gioKetThuc" name="gioKetThuc" type="text" required
                                       placeholder="Chọn giờ kết thúc (HH:mm)"
                                       class="sh-input w-full pr-10 cursor-pointer">
                                <button type="button" id="toggle-gioKetThuc"
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
                            <label for="create-sucChua" class="text-xs font-semibold uppercase text-slate-500">
                                Sức chứa <span class="text-rose-500">*</span>
                            </label>
                            <input id="create-sucChua" name="sucChua" type="number" min="1" max="200" required
                                   placeholder="Ví dụ: 50"
                                   class="mt-2 sh-input">
                        </div>

                        <input type="hidden" id="giaGocLong" name="giaGoc">

                        <div>
                            <label for="create-giaGoc" class="text-xs font-semibold uppercase text-slate-500">
                                Giá gốc (VND) <span class="text-rose-500">*</span>
                            </label>
                            <div class="relative mt-2">
                                <input
                                        id="create-giaGoc"
                                        name="giaGoc"
                                        type="text"
                                        inputmode="numeric"
                                        placeholder="Ví dụ: 1.500.000"
                                        required
                                        class="sh-input w-full text-right pr-14"
                                >
                                <span
                                        class="absolute inset-y-0 right-3 flex items-center text-xs font-semibold text-slate-500 select-none"
                                >VND</span>
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <p class="text-xs text-slate-500">
                            Kiểm tra kỹ thông tin trước khi lưu. Bạn có thể chỉnh sửa lại trong trang danh sách ca thi.
                        </p>
                        <div class="flex items-center gap-3">
                            <a href="${pageContext.request.contextPath}/admin/exams"
                               class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                Huỷ
                            </a>
                            <button type="submit"
                                    class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Tạo ca thi
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

        // Date picker cho ngày thi
        const ngayThiInput = document.querySelector('#create-ngayThi');
        if (ngayThiInput) {
            flatpickr(ngayThiInput, {
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
        }

        // Time picker cho giờ bắt đầu
        const gioBatDauInput = document.getElementById('create-gioBatDau');
        const toggleGioBatDau = document.getElementById('toggle-gioBatDau');
        if (gioBatDauInput && toggleGioBatDau) {
            const fpGioBatDau = flatpickr(gioBatDauInput, {
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",
                time_24hr: true,
                minuteIncrement: 5,
                allowInput: true,
                onClose: function(selectedDates, dateStr) {
                    if (dateStr) {
                        gioBatDauInput.value = dateStr;
                    }
                }
            });
            toggleGioBatDau.addEventListener('click', () => {
                fpGioBatDau.open();
            });
        }

        // Time picker cho giờ kết thúc
        const gioKetThucInput = document.getElementById('create-gioKetThuc');
        const toggleGioKetThuc = document.getElementById('toggle-gioKetThuc');
        if (gioKetThucInput && toggleGioKetThuc) {
            const fpGioKetThuc = flatpickr(gioKetThucInput, {
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",
                time_24hr: true,
                minuteIncrement: 5,
                allowInput: true,
                onClose: function(selectedDates, dateStr) {
                    if (dateStr) {
                        gioKetThucInput.value = dateStr;
                    }
                }
            });
            toggleGioKetThuc.addEventListener('click', () => {
                fpGioKetThuc.open();
            });
        }

        // Format giá tiền
        const giaGocInput = document.getElementById('create-giaGoc');
        function formatCurrency(value) {
            if (!value) return '';
            const digits = value.replace(/\D/g, '');
            return digits.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
        }

        if (giaGocInput) {
            giaGocInput.addEventListener('input', () => {
                const cursorPos = giaGocInput.selectionStart;
                const raw = giaGocInput.value.replace(/\D/g, '');
                giaGocInput.value = formatCurrency(raw);
                giaGocInput.setSelectionRange(cursorPos, cursorPos);
            });
        }

        // Generate mã ca thi tự động
        const generateMaCaThiBtn = document.getElementById('generate-maCaThi');
        const maCaThiInput = document.getElementById('create-maCaThi');
        if (generateMaCaThiBtn && maCaThiInput) {
            generateMaCaThiBtn.addEventListener('click', () => {
                const timestamp = Date.now();
                const randomSuffix = Math.floor(Math.random() * 900) + 100;
                maCaThiInput.value = 'CA_' + timestamp + randomSuffix;
            });
        }

        // Submit form
        if (form) {
            form.addEventListener('submit', () => {
                // Chuyển giá gốc sang giá trị long
                const rawGiaGoc = giaGocInput.value.replace(/\D/g, '');
                document.getElementById('giaGocLong').value = rawGiaGoc;
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


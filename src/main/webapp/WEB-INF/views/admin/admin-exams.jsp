<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@ include file="layout/admin-sidebar.jspf" %>

<div class="pt-[90px] lg:pl-[14rem]">
    <main class="max-w-[1440px] mx-auto px-4 sm:px-6 lg:px-10 pb-16 space-y-10">
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
                    <button data-modal-target="exam-modal"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v12"/>
                            <path d="M6 12h12"/>
                        </svg>
                        Tạo ca thi
                    </button>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    18 ca thi trong tháng 11 · cập nhật lúc 14:45
                </span>
                <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                    3 ca cần bổ sung giám sát viên
                </span>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Ca thi tháng này</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">18 ca</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +4 ca mới
                    </span>
                </div>
                <p class="text-xs text-slate-400">Từ 01/11 đến 30/11 · gồm 11 ca thi giấy, 7 ca thi máy.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Thí sinh đăng ký</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">952</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +12.6%
                    </span>
                </div>
                <p class="text-xs text-slate-400">Tỉ lệ lấp đầy đạt 92% · 48 thí sinh đang chờ thanh toán.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Ca cần xử lý</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">03 ca</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2.5 py-1 text-[11px] font-semibold text-orange-500">
                        Ưu tiên hôm nay
                    </span>
                </div>
                <p class="text-xs text-slate-400">Thiếu giám sát viên hoặc phòng thi dự phòng.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Đánh giá thí sinh</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">4.6 / 5</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +0.3 điểm
                    </span>
                </div>
                <p class="text-xs text-slate-400">Khảo sát 428 thí sinh · tăng 8% so với kỳ trước.</p>
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
                    <article class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>12 · Thg 11 · 08:00</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-600">
                                Đang mở
                            </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Ca thi CA-1254 · Thi giấy</h4>
                        <p class="text-xs text-slate-500">Phòng A203 · 48/50 thí sinh · Giám sát: Phạm Khánh</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Đăng ký trước 10/11</span>
                            <div class="flex items-center gap-2">
                                <button data-modal-target="exam-modal" class="text-primary font-semibold">Cập nhật</button>
                                <button data-modal-target="assign-modal" class="text-primary font-semibold">Phân công</button>
                            </div>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>13 · Thg 11 · 13:30</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2 py-1 text-[11px] font-semibold text-orange-500">
                                Cần bổ sung
                            </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Ca thi CA-1261 · Thi máy</h4>
                        <p class="text-xs text-slate-500">Phòng B102 · 52/60 thí sinh · Giám sát: Chưa phân</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Hạn xử lý 12/11 · 17:00</span>
                            <button data-modal-target="assign-modal" class="text-primary font-semibold">Phân công</button>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>11 · Thg 11 · 14:00</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-blue-100 px-2 py-1 text-[11px] font-semibold text-primary">
                                Đã khoá
                            </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Ca thi CA-1248 · Thi giấy</h4>
                        <p class="text-xs text-slate-500">Phòng C101 · 60/60 thí sinh · Giám sát: Vũ An</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>In danh sách trước 10/11</span>
                            <button class="text-primary font-semibold">Xuất danh sách</button>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>15 · Thg 11 · 09:00</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-600">
                                Đang mở
                            </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-900">Ca thi CA-1263 · Thi máy</h4>
                        <p class="text-xs text-slate-500">Phòng D205 · 35/45 thí sinh · Giám sát: Lâm Dung</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Còn 10 suất · ưu tiên học viên thi lại</span>
                            <button class="text-primary font-semibold">Gửi thông báo</button>
                        </div>
                    </article>
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

<!-- Create/Edit exam modal -->
<div id="exam-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Thêm hoặc chỉnh sửa ca thi</h3>
                <p class="text-xs text-slate-500 mt-1">Điền thông tin chi tiết để lên lịch thi mới.</p>
            </div>
            <button data-modal-close="exam-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mã ca thi</label>
                    <input type="text" placeholder="CA-XXXX"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đợt thi</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tháng 11/2025</option>
                        <option>Tháng 12/2025</option>
                        <option>Tháng 01/2026</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày thi</label>
                    <input type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giờ bắt đầu</label>
                    <input type="time"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hình thức</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Thi giấy</option>
                        <option>Thi trên máy</option>
                        <option>Kết hợp</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Phòng thi</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>A203 · 50 chỗ</option>
                        <option>B102 · 60 chỗ</option>
                        <option>C101 · 60 chỗ</option>
                        <option>D205 · 45 chỗ</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số lượng tối đa</label>
                    <input type="number" min="10" max="120" value="50"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giám sát chính</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Phạm Khánh</option>
                        <option>Vũ An</option>
                        <option>Lý Hưng</option>
                        <option>Lâm Dung</option>
                    </select>
                </div>
            </div>
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đề thi</label>
                    <input type="text" placeholder="Phiếu nghe số 04, phiếu đọc số 07"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú chuẩn bị</label>
                    <input type="text" placeholder="Chuẩn bị tivi, máy chiếu dự phòng"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thông điệp gửi thí sinh</label>
                <textarea rows="3" placeholder="Nhập hướng dẫn chi tiết, thời gian có mặt, giấy tờ cần mang theo..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                    <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                    Tự động gửi email thông báo cho thí sinh
                </label>
                <div class="flex items-center gap-3">
                    <button data-modal-close="exam-modal"
                            type="button"
                            class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                        Huỷ
                    </button>
                    <button type="submit"
                            class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Lưu ca thi
                    </button>
                </div>
            </div>
        </form>
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
</body>
</html>


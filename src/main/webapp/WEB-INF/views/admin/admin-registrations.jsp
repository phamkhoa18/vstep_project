<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đăng ký | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="registrations" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>
<%@ include file="layout/admin-sidebar.jspf" %>

<div class="pt-[90px] lg:pl-[14rem]">
    <main class="max-w-[1440px] mx-auto px-4 sm:px-6 lg:px-10 pb-16 space-y-10">
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Quản lý đăng ký</h2>
                    <p class="text-sm text-slate-500 mt-1">Theo dõi đăng ký lớp ôn và ca thi, xử lý thanh toán kịp thời.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <button data-modal-target="bulk-approve-modal"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M5 13l4 4L19 7"/>
                        </svg>
                        Duyệt hàng loạt
                    </button>
                    <button data-modal-target="new-registration-modal"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v12"/>
                            <path d="M6 12h12"/>
                        </svg>
                        Tạo đăng ký thủ công
                    </button>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    1.482 đăng ký trong 30 ngày · cập nhật 15:10
                </span>
                <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                    32 đăng ký chờ duyệt · 43 đăng ký đang nợ phí
                </span>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng đăng ký (30 ngày)</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">1.482</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +14.5%
                    </span>
                </div>
                <p class="text-xs text-slate-400">62% đăng ký ca thi · 38% đăng ký lớp ôn.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Đăng ký chờ duyệt</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">32</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2.5 py-1 text-[11px] font-semibold text-orange-500">
                        +6 so với hôm qua
                    </span>
                </div>
                <p class="text-xs text-slate-400">Ưu tiên xử lý trước 16:00 · 18 lớp ôn, 14 ca thi.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tỉ lệ thanh toán đủ</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">91%</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +3.2%
                    </span>
                </div>
                <p class="text-xs text-slate-400">43 đăng ký cần nhắc phí · 12 đăng ký dùng trả góp.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Yêu cầu hỗ trợ</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">06</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-rose-100 px-2.5 py-1 text-[11px] font-semibold text-rose-500">
                        Cần xử lý
                    </span>
                </div>
                <p class="text-xs text-slate-400">Hoàn phí · chuyển lớp · cập nhật thông tin thí sinh.</p>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Bộ lọc đăng ký</h3>
                    <p class="text-xs text-slate-500 mt-1">Chọn loại đăng ký, trạng thái và tình trạng thanh toán.</p>
                </div>
                <div class="flex flex-wrap items-center gap-2 text-xs text-slate-500">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                        Chờ duyệt
                        <button class="hover:text-primary/70" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100">
                        Ca thi tháng 11
                        <button class="hover:text-primary" aria-label="Xoá bộ lọc">×</button>
                    </span>
                    <a href="#" class="font-semibold text-primary hover:text-primary/80 transition">Xoá tất cả</a>
                </div>
            </div>
            <div class="grid gap-4 md:grid-cols-4">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Loại đăng ký</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả</option>
                        <option>Lớp ôn</option>
                        <option>Ca thi</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trạng thái</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Đã duyệt</option>
                        <option>Chờ duyệt</option>
                        <option>Đang chờ thanh toán</option>
                        <option>Đã huỷ</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Từ ngày</label>
                    <input type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thanh toán</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tất cả</option>
                        <option>Đã thanh toán</option>
                        <option>Chờ thanh toán</option>
                        <option>Trả góp</option>
                    </select>
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
                <input type="search" placeholder="Tìm theo tên học viên, mã đăng ký, email..."
                       class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-6 py-4 text-left font-semibold">Học viên</th>
                        <th class="px-6 py-4 text-left font-semibold">Loại đăng ký</th>
                        <th class="px-6 py-4 text-left font-semibold">Đối tượng</th>
                        <th class="px-6 py-4 text-left font-semibold">Thanh toán</th>
                        <th class="px-6 py-4 text-left font-semibold">Thời gian</th>
                        <th class="px-6 py-4 text-left font-semibold">Trạng thái</th>
                        <th class="px-6 py-4 text-right font-semibold">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">Trần Gia Khang</p>
                            <p class="text-xs text-slate-400 mt-1">Mã ĐK: DK-20251109-1023</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-xs font-semibold text-primary">
                                Ca thi
                            </span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">CA-1254 · 12/11 - 08:00</p>
                            <p class="text-xs text-slate-400">Phòng A203 · Thi giấy</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-emerald-500">Đã thanh toán</p>
                            <p class="text-xs text-slate-400">Chuyển khoản · 1.800.000đ</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">09/11/2025</p>
                            <p class="text-xs text-slate-400">13:24</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                Đã duyệt
                            </span>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button data-modal-target="detail-modal"
                                    class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Chi tiết
                            </button>
                            <button class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500 hover:bg-rose-100 transition">
                                Huỷ
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">Nguyễn Mỹ Duyên</p>
                            <p class="text-xs text-slate-400 mt-1">Mã ĐK: DK-20251109-0955</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                Lớp ôn
                            </span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">NE3 · Giao tiếp nâng cao</p>
                            <p class="text-xs text-slate-400">Bắt đầu 14/11 · GV: Lê Thảo</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-orange-500">Chờ thanh toán</p>
                            <p class="text-xs text-slate-400">Học phí: 3.200.000đ</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">09/11/2025</p>
                            <p class="text-xs text-slate-400">09:45</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">
                                Chờ duyệt
                            </span>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Duyệt
                            </button>
                            <button data-modal-target="reminder-modal"
                                    class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Nhắc phí
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">Phạm Tuấn Khải</p>
                            <p class="text-xs text-slate-400 mt-1">Mã ĐK: DK-20251108-2214</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-xs font-semibold text-primary">
                                Ca thi
                            </span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">CA-1261 · 13/11 - 13:30</p>
                            <p class="text-xs text-slate-400">Thi máy · Phòng B102</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-emerald-500">Đã thanh toán</p>
                            <p class="text-xs text-slate-400">Ví điện tử · 1.800.000đ</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">08/11/2025</p>
                            <p class="text-xs text-slate-400">22:14</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-primary">
                                Chờ phân phòng
                            </span>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Gán phòng
                            </button>
                            <button class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500 hover:bg-rose-100 transition">
                                Huỷ
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40 text-xs text-slate-500">
                <p>Hiển thị 1 – 10 trên 1.482 đăng ký</p>
                <div class="inline-flex items-center rounded-full border border-blue-100 bg-white shadow-sm">
                    <button class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-l-full">Trước</button>
                    <button class="px-3 py-2 text-white bg-primary rounded-full shadow-soft">1</button>
                    <button class="px-3 py-2 text-slate-400 hover:text-primary transition">2</button>
                    <button class="px-3 py-2 text-slate-400 hover:text-primary transition">3</button>
                    <button class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-r-full">Sau</button>
                </div>
            </div>
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-slate-900">Phễu đăng ký</h3>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Tải báo cáo
                    </button>
                </div>
                <div class="grid gap-4 md:grid-cols-2">
                    <article class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between">
                            <p class="text-sm font-semibold text-slate-800">Lớp ôn</p>
                            <span class="text-xs font-semibold text-primary">Tỉ lệ chuyển đổi 48%</span>
                        </div>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• Đăng ký: 563</li>
                            <li>• Đã thanh toán: 454</li>
                            <li>• Chờ thanh toán: 79</li>
                            <li>• Đã huỷ: 30</li>
                        </ul>
                        <div class="h-2 rounded-full bg-white">
                            <div class="h-full rounded-full bg-primary" style="width:48%;"></div>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-3">
                        <div class="flex items-center justify_between">
                            <p class="text-sm font-semibold text-slate-800">Ca thi</p>
                            <span class="text-xs font-semibold text-primary">Tỉ lệ chuyển đổi 63%</span>
                        </div>
                        <ul class="text-xs text-slate-500 space-y-1">
                            <li>• Đăng ký: 919</li>
                            <li>• Đã thanh toán: 770</li>
                            <li>• Chờ thanh toán: 41</li>
                            <li>• Đã huỷ: 22</li>
                        </ul>
                        <div class="h-2 rounded-full bg-primary.pale">
                            <div class="h-full rounded-full bg-emerald-500" style="width:63%;"></div>
                        </div>
                    </article>
                </div>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-5">
                <h3 class="text-lg font-semibold text-slate-900">Yêu cầu hỗ trợ nổi bật</h3>
                <div class="space-y-4 text-sm text-slate-600">
                    <article class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">Hoàn phí do trùng lịch</p>
                            <span class="text-xs font-semibold text-primary">Hạn 11/11</span>
                        </div>
                        <p class="text-xs text-slate-400">Mã: DK-20251107-1889 · Phụ trách: Ngọc Minh</p>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">Chuyển lớp sang NE2</p>
                            <span class="text-xs font-semibold text-primary">Hạn 12/11</span>
                        </div>
                        <p class="text-xs text-slate-400">Mã: DK-20251108-0231 · Phụ trách: Phương Anh</p>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                        <div class="flex items-center justify-between">
                            <p class="font-semibold text-slate-800">Cập nhật thông tin thí sinh</p>
                            <span class="text-xs font-semibold text-primary">Hạn 10/11</span>
                        </div>
                        <p class="text-xs text-slate-400">Mã: DK-20251106-1458 · Phụ trách: Minh Hằng</p>
                    </article>
                </div>
            </div>
        </section>
    </main>
</div>

<!-- Detail modal -->
<div id="detail-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Chi tiết đăng ký</h3>
                <p class="text-xs text-slate-500 mt-1">Thông tin học viên và lịch sử xử lý.</p>
            </div>
            <button data-modal-close="detail-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Học viên</p>
                    <p class="mt-2 text-sm font-semibold text-slate-900">Trần Gia Khang</p>
                    <p class="text-xs text-slate-400">SĐT: 0902 345 678 · Email: khang.tg@example.com</p>
                </div>
                <div>
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Mã đăng ký</p>
                    <p class="mt-2 text-sm font-semibold text-slate-900">DK-20251109-1023</p>
                    <p class="text-xs text-slate-400">Tạo lúc 09/11/2025 · 13:24</p>
                </div>
            </div>
            <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4">
                <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Đăng ký</p>
                <p class="mt-2 text-sm font-semibold text-slate-900">Ca thi CA-1254 · 12/11 - 08:00</p>
                <p class="text-xs text-slate-500 mt-1">Phòng A203 · Thi giấy · Giám sát: Phạm Khánh</p>
            </div>
            <div class="grid gap-6 md:grid-cols-2">
                <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Thanh toán</p>
                    <p class="mt-2 text-sm font-semibold text-emerald-500">Đã thanh toán · 1.800.000đ</p>
                    <p class="text-xs text-slate-400 mt-1">Chuyển khoản ngân hàng · 09/11/2025</p>
                </div>
                <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Trạng thái</p>
                    <p class="mt-2 text-sm font-semibold text-emerald-500">Đã duyệt</p>
                    <p class="text-xs text-slate-400 mt-1">Người duyệt: Nguyễn Thị Ánh · 09/11/2025 14:02</p>
                </div>
            </div>
            <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-3">
                <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Lịch sử xử lý</p>
                <div class="text-xs text-slate-500 space-y-2">
                    <p>• 09/11 · 13:24 - Học viên hoàn tất đăng ký trực tuyến.</p>
                    <p>• 09/11 · 13:28 - Hệ thống xác nhận thanh toán.</p>
                    <p>• 09/11 · 14:02 - Quản trị viên duyệt đăng ký.</p>
                </div>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="detail-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Đóng
                </button>
                <button class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    In xác nhận
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Reminder modal -->
<div id="reminder-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-lg w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Gửi nhắc phí</h3>
                <p class="text-xs text-slate-500 mt-1">Soạn nội dung nhắc thanh toán cho học viên.</p>
            </div>
            <button data-modal-close="reminder-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Gửi tới</label>
                <input type="text" value="Nguyễn Mỹ Duyên · duyennm@example.com" readonly
                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-primary.pale/40 px-4 py-3 text-sm text-slate-500">
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Chủ đề</label>
                <input type="text" value="[VSTEP] Nhắc thanh toán học phí lớp NE3 - Giao tiếp nâng cao"
                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nội dung</label>
                <textarea rows="6"
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">Chào Duyên,

Trung tâm VSTEP xin nhắc bạn hoàn tất thanh toán học phí lớp NE3 - Giao tiếp nâng cao trước 18:00 ngày 10/11 để giữ chỗ. Vui lòng chuyển khoản theo thông tin đã được gửi trước đó hoặc thanh toán trực tiếp tại quầy.

Nếu bạn đã thanh toán, vui lòng bỏ qua email này. Cảm ơn bạn!</textarea>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="reminder-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Đóng
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Gửi email
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Bulk approve modal -->
<div id="bulk-approve-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Duyệt đăng ký hàng loạt</h3>
                <p class="text-xs text-slate-500 mt-1">Áp dụng cho 18 đăng ký đang chọn.</p>
            </div>
            <button data-modal-close="bulk-approve-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div class="text-sm text-slate-600 space-y-2">
                <p>• Tự động gửi email xác nhận tới học viên.</p>
                <p>• Cập nhật trạng thái: <span class="font-semibold text-emerald-500">Đã duyệt</span>.</p>
                <p>• Ghi chú được lưu trong lịch sử xử lý.</p>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú nội bộ</label>
                <textarea rows="3" placeholder="Nhập ghi chú nếu cần..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                Đồng thời gửi SMS nhắc nhở học viên
            </label>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="bulk-approve-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Xác nhận duyệt
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Manual registration modal -->
<div id="new-registration-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Tạo đăng ký thủ công</h3>
                <p class="text-xs text-slate-500 mt-1">Nhập thông tin học viên và lựa chọn khóa học hoặc ca thi.</p>
            </div>
            <button data-modal-close="new-registration-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tên học viên</label>
                    <input type="text" placeholder="Họ và tên"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số điện thoại</label>
                    <input type="tel" placeholder="098x xxx xxx"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Email</label>
                    <input type="email" placeholder="example@email.com"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Loại đăng ký</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Chọn loại</option>
                        <option>Lớp ôn</option>
                        <option>Ca thi</option>
                    </select>
                </div>
            </div>
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Chọn lớp / ca thi</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>NE3 - Giao tiếp nâng cao</option>
                        <option>CB1 - Nền tảng VSTEP</option>
                        <option>CA-1254 · 12/11 - 08:00</option>
                        <option>CA-1261 · 13/11 - 13:30</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tình trạng thanh toán</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Đã thanh toán</option>
                        <option>Chờ thanh toán</option>
                        <option>Trả góp</option>
                    </select>
                </div>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú</label>
                <textarea rows="3" placeholder="Nhập ghi chú, ví dụ: chuyển từ lớp CB1 sang NE2..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="new-registration-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Lưu đăng ký
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


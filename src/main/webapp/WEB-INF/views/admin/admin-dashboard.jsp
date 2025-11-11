<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tổng quan hệ thống | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="dashboard" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="w-full flex pt-[90px]">
    <%@ include file="layout/admin-sidebar.jspf" %>

    <div class="lg:pl-[14rem]">
        <main class="max-w-[1440px] mx-auto px-4 sm:px-6 lg:px-10 pb-16 space-y-10">
            <section class="space-y-4">
                <div class="flex flex-col gap-3">
                    <div class="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-3">
                        <div>
                            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Tổng quan hệ thống</h2>
                            <p class="text-sm text-slate-500">Theo dõi tức thời hoạt động lớp ôn, ca thi và doanh thu.</p>
                        </div>
                        <div class="flex flex-wrap items-center gap-3">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                    <path d="M12 5v14"/>
                                    <path d="M5 12h14"/>
                                </svg>
                                Tạo báo cáo nhanh
                            </button>
                            <div class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-sm text-slate-600">
                                <span class="text-xs uppercase tracking-widest text-primary/70 font-semibold">Khoảng thời gian</span>
                                <span class="inline-flex items-center gap-2 text-sm font-medium text-slate-700">
                                10/10/2025
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-300" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                    <path d="M19 9l-7 7-7-7"/>
                                </svg>
                                09/11/2025
                            </span>
                            </div>
                        </div>
                    </div>
                    <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                        <span class="h-2 w-2 rounded-full bg-primary"></span> Cập nhật lúc 14:32 · 09/11/2025
                    </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/80 px-3 py-1 border border-blue-100 text-slate-500">
                        <span class="h-2 w-2 rounded-full bg-emerald-400"></span> Hệ thống ổn định
                    </span>
                    </div>
                </div>
            </section>

            <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-4">
                    <div class="flex items-center justify-between gap-3">
                        <p class="text-sm font-semibold text-slate-500 uppercase tracking-wide">Học viên đang theo học</p>
                        <span class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-primary.pale text-primary">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M4 7h16"/>
                            <path d="M4 12h16"/>
                            <path d="M4 17h16"/>
                        </svg>
                    </span>
                    </div>
                    <div class="flex items-end gap-3">
                        <p class="text-3xl font-semibold text-slate-900">425</p>
                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-semibold text-emerald-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M5 12l5 5L20 7"/>
                        </svg>
                        +12.4%
                    </span>
                    </div>
                    <p class="text-xs text-slate-500">Tăng 47 học viên so với cùng kỳ tuần trước.</p>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-4">
                    <div class="flex items-center justify-between gap-3">
                        <p class="text-sm font-semibold text-slate-500 uppercase tracking-wide">Doanh thu tháng này</p>
                        <span class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-yellow-100 text-yellow-600">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 3v18"/>
                            <path d="M17 8.5C17 6 15.21 4 12.5 4H10a2 2 0 0 0-2 2"/>
                            <path d="M7 15.5C7 18 8.79 20 11.5 20H14a2 2 0 0 0 2-2"/>
                        </svg>
                    </span>
                    </div>
                    <div class="flex items-end gap-3">
                        <p class="text-3xl font-semibold text-slate-900">312 triệu</p>
                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-semibold text-emerald-600">
                    +18.1%
                </span>
                    </div>
                    <p class="text-xs text-slate-500">Đã bao gồm giảm giá thi lại & ưu đãi học viên thân thiết.</p>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-4">
                    <div class="flex items-center justify-between gap-3">
                        <p class="text-sm font-semibold text-slate-500 uppercase tracking-wide">Ca thi sắp diễn ra</p>
                        <span class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-orange-100 text-orange-500">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M6 2v4"/>
                            <path d="M18 2v4"/>
                            <path d="M3 10h18"/>
                            <path d="M5 18h2"/>
                            <path d="M11 18h2"/>
                            <path d="M17 18h2"/>
                        </svg>
                    </span>
                    </div>
                    <div class="flex items-end gap-3">
                        <p class="text-3xl font-semibold text-slate-900">08</p>
                        <span class="text-xs font-medium text-slate-500">12/11 → 25/11</span>
                    </div>
                    <p class="text-xs text-slate-500">2 ca thi hôm nay · 3 ca chưa phân đủ giám sát viên.</p>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-4">
                    <div class="flex items-center justify-between gap-3">
                        <p class="text-sm font-semibold text-slate-500 uppercase tracking-wide">Tỉ lệ hoàn thành</p>
                        <span class="inline-flex h-10 w-10 items-center justify-center rounded-full bg-emerald-100 text-emerald-500">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v6l3.5 1.5"/>
                            <path d="M4 12a8 8 0 1 1 16 0 8 8 0 0 1-16 0Z"/>
                        </svg>
                    </span>
                    </div>
                    <div class="flex items-end gap-3">
                        <p class="text-3xl font-semibold text-slate-900">94%</p>
                        <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-xs font-semibold text-emerald-600">
                        +2.1%
                    </span>
                    </div>
                    <p class="text-xs text-slate-500">Theo dõi lớp ôn & thi · mục tiêu tháng 11 ≥ 95%.</p>
                </div>
            </section>

            <section class="grid gap-6 xl:grid-cols-3">
                <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6">
                    <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
                        <div>
                            <h3 class="text-lg font-semibold text-slate-900">Xu hướng đăng ký lớp & thi</h3>
                            <p class="text-xs text-slate-500 mt-1">Dữ liệu 12 tuần gần nhất · cập nhật theo giờ.</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option>12 tuần gần nhất</option>
                                <option>6 tháng gần nhất</option>
                                <option>12 tháng</option>
                            </select>
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                    <path d="M4 4v16h16"/>
                                    <path d="M8 16l4-4 3 3 5-6"/>
                                </svg>
                                Tải dữ liệu
                            </button>
                        </div>
                    </div>
                    <div class="mt-6 h-72 rounded-2xl border border-dashed border-blue-100 bg-primary.pale/60 flex items-center justify-center text-sm text-slate-400">
                        Biểu đồ đường (line chart) sẽ hiển thị tại đây.
                    </div>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <div class="flex items-center justify-between">
                        <h3 class="text-lg font-semibold text-slate-900">Tỉ lệ lấp đầy lớp</h3>
                        <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>Tháng này</option>
                            <option>Quý này</option>
                        </select>
                    </div>
                    <div class="h-64 rounded-2xl border border-dashed border-blue-100 bg-primary.pale/60 flex flex-col items-center justify-center text-sm text-slate-400 space-y-4">
                        <span>Biểu đồ tròn (donut chart) sẽ hiển thị tại đây.</span>
                        <div class="grid grid-cols-2 gap-4 text-xs text-slate-500">
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-primary"></span> Lớp cơ bản · 78%
                            </div>
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-emerald-400"></span> Nâng cao · 92%
                            </div>
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-orange-400"></span> Cấp tốc · 65%
                            </div>
                            <div class="flex items-center gap-2">
                                <span class="h-2 w-2 rounded-full bg-pink-400"></span> Online · 88%
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="grid gap-6 xl:grid-cols-3">
                <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6">
                    <div class="flex items-center justify-between">
                        <h3 class="text-lg font-semibold text-slate-900">Hoạt động gần đây</h3>
                        <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Xem tất cả</a>
                    </div>
                    <div class="mt-6 space-y-5">
                        <article class="flex items-start gap-4 rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                            <div class="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-primary/10 text-primary font-semibold">LN</div>
                            <div class="flex-1 space-y-1">
                                <p class="text-sm font-semibold text-slate-800">Lê Nam đăng ký lớp ôn cấp tốc</p>
                                <p class="text-xs text-slate-500">Ca thi 12/12 · Mã ĐK: DK-20251109-1023</p>
                            </div>
                            <span class="text-xs font-medium text-slate-400">5 phút trước</span>
                        </article>
                        <article class="flex items-start gap-4 rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                            <div class="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-emerald-100 text-emerald-500 font-semibold">ML</div>
                            <div class="flex-1 space-y-1">
                                <p class="text-sm font-semibold text-slate-800">Minh Long cập nhật sĩ số lớp NE3</p>
                                <p class="text-xs text-slate-500">Thêm 3 học viên chuyển từ NE2 · buổi 4/20</p>
                            </div>
                            <span class="text-xs font-medium text-slate-400">32 phút trước</span>
                        </article>
                        <article class="flex items-start gap-4 rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                            <div class="inline-flex h-11 w-11 items-center justify-center rounded-xl bg-orange-100 text-orange-500 font-semibold">HQ</div>
                            <div class="flex-1 space-y-1">
                                <p class="text-sm font-semibold text-slate-800">Hoàng Quân kích hoạt lại ưu đãi thi lại</p>
                                <p class="text-xs text-slate-500">Giảm 20% cho học viên thi lại trong 30 ngày.</p>
                            </div>
                            <span class="text-xs font-medium text-slate-400">1 giờ trước</span>
                        </article>
                    </div>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-5">
                    <div class="flex items-center justify-between">
                        <h3 class="text-lg font-semibold text-slate-900">Tiến độ công việc</h3>
                        <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Xem lịch</a>
                    </div>
                    <div class="space-y-4">
                        <div class="space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-700">Chuẩn bị đề thi mới</p>
                                <span class="text-xs font-semibold text-emerald-500">80%</span>
                            </div>
                            <div class="h-2 w-full rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-primary" style="width:80%;"></div>
                            </div>
                            <p class="text-[11px] text-slate-400">Đã hoàn tất 12/15 bộ đề · hạn 15/11.</p>
                        </div>
                        <div class="space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-700">Kiểm kê thiết bị phòng thi</p>
                                <span class="text-xs font-semibold text-orange-500">48%</span>
                            </div>
                            <div class="h-2 w-full rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-orange-400" style="width:48%;"></div>
                            </div>
                            <p class="text-[11px] text-slate-400">Cần bổ sung 6 micro dự phòng trước 12/11.</p>
                        </div>
                        <div class="space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-700">Thống kê kết quả thi quý IV</p>
                                <span class="text-xs font-semibold text-pink-500">32%</span>
                            </div>
                            <div class="h-2 w-full rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-pink-400" style="width:32%;"></div>
                            </div>
                            <p class="text-[11px] text-slate-400">Đang chờ dữ liệu từ cơ sở Thủ Đức.</p>
                        </div>
                        <button class="w-full inline-flex items-center justify-center gap-2 rounded-xl border border-blue-100 bg-white px-4 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                            Xem tất cả 12 nhiệm vụ
                        </button>
                    </div>
                </div>
            </section>

            <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
                    <div>
                        <h3 class="text-lg font-semibold text-slate-900">Lịch ca thi & lớp ôn sắp tới</h3>
                        <p class="text-xs text-slate-500 mt-1">Theo dõi các hoạt động quan trọng 7 ngày tới.</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 hover:bg-primary/5 transition">
                            Tuần này
                        </button>
                        <button class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                <path d="M4 4h16v16H4z"/>
                                <path d="M16 2v4"/>
                                <path d="M8 2v4"/>
                                <path d="M4 10h16"/>
                            </svg>
                            Xuất lịch
                        </button>
                    </div>
                </div>
                <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
                    <article class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-400 uppercase tracking-wide">
                            <span>12 · Thg 11 · 2025</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-500">
                            Sẵn sàng
                        </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-800">Ca thi 12/11 - 08:00</h4>
                        <p class="text-xs text-slate-500">Phòng A203 · 48/50 thí sinh · Giám sát: Phạm Khánh</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Mã ca: CA-1254</span>
                            <button class="text-primary font-semibold">Chi tiết</button>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-400 uppercase tracking-wide">
                            <span>13 · Thg 11 · 2025</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2 py-1 text-[11px] font-semibold text-orange-500">
                            Cần cập nhật
                        </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-800">NE3 - Buổi 4</h4>
                        <p class="text-xs text-slate-500">Phòng B205 · 32 học viên · GV: Lê Thảo</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Mã lớp: LOP-NE3-2025</span>
                            <button class="text-primary font-semibold">Cập nhật</button>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-400 uppercase tracking-wide">
                            <span>15 · Thg 11 · 2025</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-blue-100 px-2 py-1 text-[11px] font-semibold text-primary">
                            Chuẩn bị
                        </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-800">Ca thi 15/11 - 14:00</h4>
                        <p class="text-xs text-slate-500">Phòng C101 · 60 thí sinh · Giám sát: Vũ An</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Mã ca: CA-1278</span>
                            <button class="text-primary font-semibold">Nhắc nhở</button>
                        </div>
                    </article>
                    <article class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm space-y-3">
                        <div class="flex items-center justify-between text-xs text-slate-400 uppercase tracking-wide">
                            <span>16 · Thg 11 · 2025</span>
                            <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-1 text-[11px] font-semibold text-emerald-500">
                            Đã gửi tài liệu
                        </span>
                        </div>
                        <h4 class="text-sm font-semibold text-slate-800">Lớp ôn online - Ca tối</h4>
                        <p class="text-xs text-slate-500">47 học viên · Zoom ID: 823 456 221 · GV: Ngô Tín</p>
                        <div class="flex items-center justify-between text-xs text-slate-400">
                            <span>Mã lớp: LOP-ONL-2205</span>
                            <button class="text-primary font-semibold">Xem Zoom</button>
                        </div>
                    </article>
                </div>
            </section>
        </main>
    </div>
</div>>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>

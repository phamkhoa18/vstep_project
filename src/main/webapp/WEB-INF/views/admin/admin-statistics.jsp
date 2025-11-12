<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê & Doanh thu | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="statistics" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Thống kê sĩ số & doanh thu</h2>
                    <p class="text-sm text-slate-500 mt-1">Tổng hợp số liệu theo thời gian, cấp độ lớp và kỳ thi.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <div class="inline-flex items-center rounded-full border border-blue-100 bg-white px-4 py-2 text-xs text-slate-500">
                        <span class="uppercase tracking-widest text-primary/70 font-semibold mr-3">Khoảng thời gian</span>
                        <span class="inline-flex items-center gap-2 text-sm font-semibold text-slate-700">
                            10/10/2025
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-300" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                                <path d="M19 9l-7 7-7-7"/>
                            </svg>
                            09/11/2025
                        </span>
                    </div>
                    <button data-modal-target="export-modal"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 3v12"/>
                            <path d="M6 9h12"/>
                            <path d="M5 21h14"/>
                        </svg>
                        Xuất báo cáo
                    </button>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    Cập nhật dữ liệu lúc 15:20 · Nguồn: CRM nội bộ & hệ thống thanh toán
                </span>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <div class="flex items-center justify-between">
                    <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Doanh thu tổng</p>
                    <select class="rounded-full border border-blue-100 bg-white px-3 py-1 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tháng</option>
                        <option>Quý</option>
                        <option>Năm</option>
                    </select>
                </div>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">4.12 tỷ</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +15.2%
                    </span>
                </div>
                <p class="text-xs text-slate-400">So với cùng kỳ năm trước · gồm lớp ôn, ca thi, học liệu.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Sĩ số học viên</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">2.836</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +11.4%
                    </span>
                </div>
                <p class="text-xs text-slate-400">1.716 lớp ôn · 1.120 thí sinh thi lại.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tỉ lệ đỗ trung bình</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">74%</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +3.5%
                    </span>
                </div>
                <p class="text-xs text-slate-400">Mục tiêu quý IV ≥ 78% · tập trung cải thiện phần nói.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Chi phí vận hành</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">1.28 tỷ</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-rose-100 px-2.5 py-1 text-[11px] font-semibold text-rose-500">
                        +6.2%
                    </span>
                </div>
                <p class="text-xs text-slate-400">Tập trung tối ưu thiết bị ca thi và nhân sự part-time.</p>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
            <div class="flex flex-col xl:flex-row xl:items-center xl:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Phân tích đa chiều</h3>
                    <p class="text-xs text-slate-500 mt-1">So sánh sĩ số, doanh thu và tỉ lệ đỗ theo phân khúc.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Phân khúc theo cấp độ</option>
                        <option>Phân khúc theo cơ sở</option>
                        <option>Phân khúc theo giảng viên</option>
                    </select>
                    <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Đơn vị tiền tệ: VND</option>
                        <option>USD</option>
                    </select>
                    <div class="inline-flex rounded-full border border-blue-100 bg-white p-1 text-xs font-semibold text-slate-500">
                        <button class="rounded-full bg-primary px-3 py-1.5 text-white shadow-soft">Lớp</button>
                        <button class="rounded-full px-3 py-1.5 hover:text-primary transition">Thi</button>
                        <button class="rounded-full px-3 py-1.5 hover:text-primary transition">Tổng hợp</button>
                    </div>
                </div>
            </div>
            <div class="grid gap-4 md:grid-cols-3">
                <article class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-2">
                    <div class="flex items-center justify-between">
                        <p class="text-sm font-semibold text-slate-800">Cấp độ cơ bản</p>
                        <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">+12%</span>
                    </div>
                    <p class="text-xs text-slate-500">Sĩ số 1.024 · Doanh thu 1.12 tỷ · Tỉ lệ đỗ 68%.</p>
                    <p class="text-xs text-emerald-500">Chiến dịch quảng bá mang lại 280 học viên mới.</p>
                </article>
                <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                    <div class="flex items-center justify-between">
                        <p class="text-sm font-semibold text-slate-800">Cấp độ nâng cao</p>
                        <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">+18%</span>
                    </div>
                    <p class="text-xs text-slate-500">Sĩ số 742 · Doanh thu 1.48 tỷ · Tỉ lệ đỗ 81%.</p>
                    <p class="text-xs text-slate-400">Tỉ lệ hài lòng 4.7/5 · 64 đánh giá.</p>
                </article>
                <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                    <div class="flex items-center justify-between">
                        <p class="text-sm font-semibold text-slate-800">Khóa cấp tốc</p>
                        <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">-6%</span>
                    </div>
                    <p class="text-xs text-slate-500">Sĩ số 326 · Doanh thu 520 triệu · Tỉ lệ đỗ 62%.</p>
                    <p class="text-xs text-rose-500">Cần bổ sung tài liệu luyện nghe và kỹ năng viết.</p>
                </article>
            </div>
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-lg font-semibold text-slate-900">Doanh thu theo tuần</h3>
                        <p class="text-xs text-slate-500 mt-1">Bao gồm lớp ôn và ca thi · cập nhật từng giờ.</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>12 tuần gần nhất</option>
                            <option>6 tháng gần nhất</option>
                        </select>
                        <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Xem dữ liệu
                        </button>
                    </div>
                </div>
                <div class="h-72 rounded-2xl border border-dashed border-blue-100 bg-primary.pale/40 flex items-center justify-center text-sm text-slate-400">
                    Biểu đồ đường (line chart) sẽ hiển thị tại đây.
                </div>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-slate-900">Nguồn học viên</h3>
                    <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Tháng này</option>
                        <option>Quý này</option>
                    </select>
                </div>
                <div class="h-64 rounded-2xl border border-dashed border-blue-100 bg-primary.pale/40 flex flex-col items-center justify-center text-sm text-slate-400 space-y-4">
                    <span>Biểu đồ tròn (donut chart) sẽ hiển thị tại đây.</span>
                    <div class="grid grid-cols-2 gap-3 text-xs text-slate-500">
                        <div class="flex items-center gap-2">
                            <span class="h-2 w-2 rounded-full bg-primary"></span> Digital marketing · 34%
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="h-2 w-2 rounded-full bg-emerald-400"></span> Giới thiệu · 27%
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="h-2 w-2 rounded-full bg-orange-400"></span> Đối tác · 22%
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="h-2 w-2 rounded-full bg-pink-400"></span> Quảng cáo offline · 17%
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="rounded-3xl bg-white shadow-soft border border-blue-50 overflow-hidden">
            <div class="px-6 py-6 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <div>
                    <h3 class="text-lg font-semibold text-slate-900">Bảng thống kê chi tiết</h3>
                    <p class="text-xs text-slate-500 mt-1">Số liệu theo từng cơ sở trong khoảng thời gian đã chọn.</p>
                </div>
                <div class="flex items-center gap-3">
                    <select class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Nhóm theo cơ sở</option>
                        <option>Nhóm theo giảng viên</option>
                        <option>Nhóm theo cấp độ</option>
                    </select>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Tuỳ chỉnh cột
                    </button>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-6 py-4 text-left font-semibold">Cơ sở</th>
                        <th class="px-6 py-4 text-left font-semibold">Sĩ số lớp</th>
                        <th class="px-6 py-4 text-left font-semibold">Số ca thi</th>
                        <th class="px-6 py-4 text-left font-semibold">Doanh thu</th>
                        <th class="px-6 py-4 text-left font-semibold">Chi phí</th>
                        <th class="px-6 py-4 text-left font-semibold">Lợi nhuận</th>
                        <th class="px-6 py-4 text-left font-semibold">Tỉ lệ đỗ</th>
                        <th class="px-6 py-4 text-left font-semibold">Ưu đãi</th>
                        <th class="px-6 py-4 text-right font-semibold">Chi tiết</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">Cơ sở Quận 10</p>
                            <p class="text-xs text-slate-400 mt-1">193 Nguyễn Tri Phương</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">1.046</p>
                            <p class="text-xs text-slate-400">32 lớp đang hoạt động</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">24 ca</p>
                            <p class="text-xs text-slate-400">14 thi giấy · 10 thi máy</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">1.56 tỷ</p>
                            <span class="text-xs font-semibold text-emerald-500">+18%</span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">430 triệu</p>
                            <p class="text-xs text-slate-400">Nhân sự & CSVC</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-emerald-500">1.13 tỷ</p>
                            <p class="text-xs text-slate-400">Biên lợi nhuận 72%</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                78%
                            </span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">23 triệu</p>
                            <p class="text-xs text-slate-400">Ưu đãi thi lại</p>
                        </td>
                        <td class="px-6 py-5 text-right">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Xem
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">Cơ sở Thủ Đức</p>
                            <p class="text-xs text-slate-400 mt-1">55 Võ Văn Ngân</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">782</p>
                            <p class="text-xs text-slate-400">24 lớp đang hoạt động</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">18 ca</p>
                            <p class="text-xs text-slate-400">10 thi giấy · 8 thi máy</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">1.08 tỷ</p>
                            <span class="text-xs font-semibold text-emerald-500">+9%</span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">320 triệu</p>
                            <p class="text-xs text-slate-400">Thuê phòng thi máy</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-emerald-500">760 triệu</p>
                            <p class="text-xs text-slate-400">Biên lợi nhuận 70%</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-primary">
                                72%
                            </span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">18 triệu</p>
                            <p class="text-xs text-slate-400">Ưu đãi kết hợp lớp ôn</p>
                        </td>
                        <td class="px-6 py-5 text-right">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Xem
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40 text-xs text-slate-500">
                <p>Hiển thị 1 – 10 trên 36 cơ sở / phân khu</p>
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
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-3">
                <h3 class="text-lg font-semibold text-slate-900">Điểm nhấn</h3>
                <ul class="space-y-2 text-sm text-slate-600">
                    <li>• Doanh thu lớp nâng cao tăng mạnh nhờ gói kết hợp thi thử.</li>
                    <li>• Cơ sở Quận 10 vượt KPI cả sĩ số và tỉ lệ đỗ.</li>
                    <li>• Khóa cấp tốc cần bổ sung tài liệu nghe và kỹ năng viết.</li>
                </ul>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-3">
                <h3 class="text-lg font-semibold text-slate-900">Rủi ro cần theo dõi</h3>
                <ul class="space-y-2 text-sm text-slate-600">
                    <li>• Tỉ lệ đỗ ca thi B102 còn 64% · kiểm tra thiết bị thi máy.</li>
                    <li>• Lớp cấp tốc cuối tuần có tỷ lệ bỏ học 9%.</li>
                    <li>• Ngân sách marketing đối tác vượt 12% so với kế hoạch.</li>
                </ul>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-3">
                <h3 class="text-lg font-semibold text-slate-900">Đề xuất hành động</h3>
                <ul class="space-y-2 text-sm text-slate-600">
                    <li>• Triển khai chương trình mentoring cho học viên cấp tốc.</li>
                    <li>• Điều phối thêm 4 giám sát viên cho ca thi máy.</li>
                    <li>• Tăng ưu đãi học lại kết hợp lớp nâng cao.</li>
                </ul>
            </div>
        </section>
        </main>
    </div>
</div>

<!-- Export modal -->
<div id="export-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Xuất báo cáo thống kê</h3>
                <p class="text-xs text-slate-500 mt-1">Chọn định dạng và phạm vi dữ liệu cần xuất.</p>
            </div>
            <button data-modal-close="export-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Định dạng</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Excel (.xlsx)</option>
                        <option>CSV (.csv)</option>
                        <option>PDF (.pdf)</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Phạm vi dữ liệu</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Theo tháng</option>
                        <option>Theo quý</option>
                        <option>Tùy chỉnh</option>
                    </select>
                </div>
            </div>
            <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 text-sm text-slate-600 space-y-2">
                <p class="font-semibold text-slate-800">Báo cáo bao gồm:</p>
                <p>• Doanh thu lớp ôn & ca thi, chi phí, lợi nhuận.</p>
                <p>• Sĩ số học viên, tỉ lệ đỗ, ưu đãi thi lại.</p>
                <p>• Thống kê theo cơ sở, cấp độ, giảng viên.</p>
            </div>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="export-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover	text-primary transition">
                    Huỷ
                </button>
                <button type="submit"
                        class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Xuất ngay
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


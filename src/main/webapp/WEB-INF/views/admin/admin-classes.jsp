<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%@ include file="layout/admin-sidebar.jspf" %>

<div class="pt-[90px] lg:pl-[14rem]">
    <main class="max-w-[1440px] mx-auto px-4 sm:px-6 lg:px-10 pb-16 space-y-10">
        <section class="space-y-4">
            <div class="flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Quản lý lớp ôn</h2>
                    <p class="text-sm text-slate-500 mt-1">Theo dõi tình trạng lớp học, sĩ số và lịch giảng dạy.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <button data-modal-target="class-import-modal"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 3v12"/>
                            <path d="M6 9h12"/>
                            <path d="M4 19h16"/>
                        </svg>
                        Nhập danh sách
                    </button>
                    <button data-modal-target="class-modal"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M12 6v12"/>
                            <path d="M6 12h12"/>
                        </svg>
                        Tạo lớp mới
                    </button>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    Cập nhật 09/11/2025 · 14:30
                </span>
                <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                    4 lớp cần quan tâm ngay lập tức
                </span>
            </div>
        </section>

        <section class="grid gap-6 md:grid-cols-2 xl:grid-cols-4">
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tổng lớp đang mở</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">26 lớp</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +3 lớp mới
                    </span>
                </div>
                <p class="text-xs text-slate-400">Bao gồm 8 lớp cơ bản · 10 nâng cao · 4 cấp tốc · 4 online.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Sĩ số trung bình</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">34 học viên</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +6%
                    </span>
                </div>
                <p class="text-xs text-slate-400">Giới hạn chuẩn 40 học viên · 6 lớp vượt 90% sức chứa.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Lớp sắp đầy</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">4 lớp</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-orange-100 px-2.5 py-1 text-[11px] font-semibold text-orange-500">
                        Ưu tiên cập nhật
                    </span>
                </div>
                <p class="text-xs text-slate-400">CB1-B · NE3-A · ONL-2205 · CT-6W cần cân nhắc mở thêm lịch.</p>
            </div>
            <div class="rounded-3xl bg-white shadow-soft border border-blue-50 px-6 py-5 space-y-3">
                <p class="text-xs font-semibold uppercase tracking-widest text-primary/70">Tỉ lệ giữ chân</p>
                <div class="flex items-end gap-3">
                    <p class="text-3xl font-semibold text-slate-900">86%</p>
                    <span class="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2.5 py-1 text-[11px] font-semibold text-emerald-600">
                        +4.2%
                    </span>
                </div>
                <p class="text-xs text-slate-400">52 học viên đăng ký tiếp khóa nâng cao trong 7 ngày.</p>
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
                        <th class="px-6 py-4 text-left font-semibold">Lớp / Mã lớp</th>
                        <th class="px-6 py-4 text-left font-semibold">Cấp độ</th>
                        <th class="px-6 py-4 text-left font-semibold">Giảng viên</th>
                        <th class="px-6 py-4 text-left font-semibold">Sĩ số</th>
                        <th class="px-6 py-4 text-left font-semibold">Lịch học</th>
                        <th class="px-6 py-4 text-left font-semibold">Tiến độ</th>
                        <th class="px-6 py-4 text-right font-semibold">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">NE3 · Giao tiếp nâng cao</p>
                            <p class="text-xs text-slate-400 mt-1">Mã: LOP-NE3-2025</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-xs font-semibold text-primary">Nâng cao</span>
                        </td>
                        <td class="px-6 py-5 space-y-1">
                            <p class="font-semibold text-slate-800">Lê Thảo</p>
                            <p class="text-xs text-slate-400">0987 123 456 · lethao@vstep.edu.vn</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">32 / 36</p>
                            <span class="text-xs font-semibold text-emerald-500">Còn 4 chỗ</span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">Thứ 3 · 5 · 18:00 - 20:00</p>
                            <p class="text-xs text-slate-400">Phòng B205 · 09/10 → 12/12</p>
                        </td>
                        <td class="px-6 py-5">
                            <div class="w-40 h-2 rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-primary" style="width: 45%;"></div>
                            </div>
                            <p class="text-xs text-slate-400 mt-2">Hoàn thành 9/20 buổi</p>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button data-modal-target="class-modal"
                                    class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Sửa
                            </button>
                            <button class="inline-flex items-center gap-2 rounded-full border border-rose-100 bg-rose-50 px-4 py-2 text-xs font-semibold text-rose-500 hover:bg-rose-100 transition">
                                Xoá
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">CB1 · Nền tảng VSTEP</p>
                            <p class="text-xs text-slate-400 mt-1">Mã: LOP-CB1-2025</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">Cơ bản</span>
                        </td>
                        <td class="px-6 py-5 space-y-1">
                            <p class="font-semibold text-slate-800">Nguyễn Phi</p>
                            <p class="text-xs text-slate-400">0974 555 999 · nguyenphi@vstep.edu.vn</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">40 / 40</p>
                            <span class="text-xs font-semibold text-orange-500">Đã đầy</span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">Thứ 2 · 4 · 6 · 08:00 - 10:00</p>
                            <p class="text-xs text-slate-400">Phòng A103 · 04/10 → 18/12</p>
                        </td>
                        <td class="px-6 py-5">
                            <div class="w-40 h-2 rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-emerald-400" style="width: 72%;"></div>
                            </div>
                            <p class="text-xs text-slate-400 mt-2">Hoàn thành 14/20 buổi</p>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button data-modal-target="class-modal"
                                    class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Sửa
                            </button>
                            <button class="inline-flex items-center gap-2 rounded-full border border-orange-100 bg-orange-50 px-4 py-2 text-xs font-semibold text-orange-500 hover:bg-orange-100 transition">
                                Mở thêm
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-900">CT2 · Cấp tốc 6 tuần</p>
                            <p class="text-xs text-slate-400 mt-1">Mã: LOP-CT2-2025</p>
                        </td>
                        <td class="px-6 py-5">
                            <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">Cấp tốc</span>
                        </td>
                        <td class="px-6 py-5 space-y-1">
                            <p class="font-semibold text-slate-800">Võ An</p>
                            <p class="text-xs text-slate-400">0907 888 221 · voan@vstep.edu.vn</p>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">28 / 30</p>
                            <span class="text-xs font-semibold text-emerald-500">Còn 2 chỗ</span>
                        </td>
                        <td class="px-6 py-5">
                            <p class="font-semibold text-slate-800">Thứ 7 · CN · 13:00 - 17:00</p>
                            <p class="text-xs text-slate-400">Phòng C201 · 20/10 → 01/12</p>
                        </td>
                        <td class="px-6 py-5">
                            <div class="w-40 h-2 rounded-full bg-primary.pale">
                                <div class="h-full rounded-full bg-orange-400" style="width: 20%;"></div>
                            </div>
                            <p class="text-xs text-slate-400 mt-2">Hoàn thành 2/10 buổi</p>
                        </td>
                        <td class="px-6 py-5 text-right space-x-2">
                            <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Sửa
                            </button>
                            <button class="inline-flex items-center gap-2 rounded-full border border-emerald-100 bg-emerald-50 px-4 py-2 text-xs font-semibold text-emerald-500 hover:bg-emerald-100 transition">
                                Gửi nhắc
                            </button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 px-6 py-4 border-t border-blue-50 bg-primary.pale/40 text-xs text-slate-500">
                <p>Hiển thị 1 – 10 trên 26 lớp</p>
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
                        <div class="flex items-center justify_between">
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

<!-- Create/Edit class modal -->
<div id="class-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Thêm hoặc chỉnh sửa lớp ôn</h3>
                <p class="text-xs text-slate-500 mt-1">Điền thông tin chi tiết để tạo mới hoặc cập nhật lớp học.</p>
            </div>
            <button data-modal-close="class-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <form class="px-6 py-6 space-y-6">
            <div class="grid gap-6 md:grid-cols-2">
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tên lớp</label>
                    <input type="text" placeholder="Ví dụ: NE3 - Giao tiếp nâng cao"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mã lớp</label>
                    <input type="text" placeholder="LOP-NE3-2025"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Cấp độ</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Chọn cấp độ</option>
                        <option>Cơ bản</option>
                        <option>Trung cấp</option>
                        <option>Nâng cao</option>
                        <option>Cấp tốc</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giảng viên phụ trách</label>
                    <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        <option>Chọn giảng viên</option>
                        <option>Nguyễn Phi</option>
                        <option>Lê Thảo</option>
                        <option>Võ An</option>
                        <option>Đặng Nhi</option>
                    </select>
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Sĩ số tối đa</label>
                    <input type="number" min="10" max="60" value="36"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
                <div>
                    <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày khai giảng</label>
                    <input type="date"
                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                </div>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Lịch học</label>
                <textarea rows="3" placeholder="Ví dụ: Thứ 3 - 5 (18:00 - 20:00) · Phòng B205"
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div>
                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú nội bộ</label>
                <textarea rows="3" placeholder="Nhập thông tin cần nhắc nhở giảng viên, học viên..."
                          class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
            </div>
            <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                    <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                    Tự động đồng bộ với danh sách đăng ký liên quan
                </label>
                <div class="flex items-center gap-3">
                    <button data-modal-close="class-modal"
                            type="button"
                            class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                        Huỷ
                    </button>
                    <button type="submit"
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

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


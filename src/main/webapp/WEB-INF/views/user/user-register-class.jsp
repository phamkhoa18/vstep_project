<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vstep.model.NguoiDung" %>
<%
    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
    String displayName = user != null && user.getHoTen() != null && !user.getHoTen().isEmpty()
            ? user.getHoTen()
            : "Học viên";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lớp đã đăng ký | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-6xl mx-auto px-6 space-y-12">
        <div class="space-y-4 text-center">
            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                Lớp đã đăng ký
            </span>
            <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Lớp ôn luyện của <%= displayName %></h1>
            <p class="text-sm text-slate-500 max-w-2xl mx-auto">
                Theo dõi lịch học, tiến độ và tài liệu của từng lớp. Bạn có thể xin nghỉ, đổi buổi hoặc gia hạn ngay tại đây.
            </p>
        </div>

        <div class="grid gap-8 lg:grid-cols-[1fr,2fr]">
            <aside class="space-y-6">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tóm tắt</p>
                    <div class="space-y-2 text-sm text-slate-600">
                        <div class="flex items-center justify-between rounded-2xl bg-primary/10 px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Tổng số lớp</span>
                            <span class="font-semibold text-slate-900">03</span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Đang học</span>
                            <span class="font-semibold text-primary">02</span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Đã hoàn thành</span>
                            <span class="font-semibold text-emerald-500">01</span>
                        </div>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hành động nhanh</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/lop" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Đăng ký lớp mới
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Yêu cầu đổi buổi học
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                            Tải thời khóa biểu tuần
                        </a>
                    </div>
                </div>
            </aside>

            <section class="space-y-6">
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-8">
                    <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đang tham gia</p>
                            <h2 class="text-2xl font-semibold text-slate-900">Lịch học tuần này</h2>
                        </div>
                        <div class="inline-flex rounded-full border border-blue-100 bg-white px-4 py-2 text-xs text-slate-500">
                            Hiển thị tuần: 10/11 - 16/11/2025
                        </div>
                    </header>

                    <div class="space-y-6">
                        <article class="rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition">
                            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                                <div class="space-y-3">
                                    <div class="flex flex-wrap gap-2 text-xs text-slate-400 uppercase tracking-widest">
                                        <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 font-semibold text-primary">
                                            Đang học
                                        </span>
                                        <span>NE3 · Giao tiếp nâng cao</span>
                                    </div>
                                    <h3 class="text-xl font-semibold text-slate-900">Luyện Speaking nâng cao · Giảng viên ThS. Lê Thảo</h3>
                                    <p class="text-sm text-slate-500 leading-relaxed">
                                        Luyện phản xạ theo đề thi mới, 02 buổi mock test, feedback cá nhân hoá. Buổi tới sẽ luyện Speaking Part 3.
                                    </p>
                                </div>
                                <div class="flex-shrink-0 text-right space-y-2 text-sm text-slate-600">
                                    <p class="font-semibold text-slate-900">Thứ 3 & Thứ 5 · 18:00 - 20:00</p>
                                    <p class="text-xs text-slate-500">Cơ sở Quận 10 · Phòng A203</p>
                                    <p class="text-xs text-emerald-500 font-semibold">Sĩ số: 32/36 (Còn 4 chỗ)</p>
                                </div>
                            </div>
                            <div class="mt-6 flex flex-wrap gap-3 text-xs text-slate-600">
                                <a href="#" class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Vào lớp online
                                </a>
                                <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                    Tài liệu & bài tập
                                </a>
                                <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                                    Xin nghỉ / bù buổi
                                </a>
                            </div>
                            <div class="mt-6 grid gap-4 md:grid-cols-3 text-xs text-slate-500">
                                <div class="rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3">
                                    <p class="font-semibold text-slate-700">Buổi tiếp theo</p>
                                    <p class="mt-1">Thứ 3 · 12/11/2025</p>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                    <p class="font-semibold text-slate-700">Tiến độ</p>
                                    <p class="mt-1">Hoàn thành 60% · 9/15 buổi</p>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                    <p class="font-semibold text-slate-700">Ghi chú giảng viên</p>
                                    <p class="mt-1">Cần luyện thêm phần nối ý ở Speaking Part 3.</p>
                                </div>
                            </div>
                        </article>

                        <article class="rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition">
                            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                                <div class="space-y-3">
                                    <div class="flex flex-wrap gap-2 text-xs text-slate-400 uppercase tracking-widest">
                                        <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 font-semibold text-orange-500">
                                            Chuẩn bị khai giảng
                                        </span>
                                        <span>CB1 · Nền tảng VSTEP</span>
                                    </div>
                                    <h3 class="text-xl font-semibold text-slate-900">Ôn luyện tổng hợp 4 kỹ năng cho người mới bắt đầu</h3>
                                    <p class="text-sm text-slate-500 leading-relaxed">
                                        Hỗ trợ trực tuyến 24/7, tài liệu cập nhật theo khung B1. Buổi đầu tiên giới thiệu chiến lược Reading.
                                    </p>
                                </div>
                                <div class="flex-shrink-0 text-right space-y-2 text-sm text-slate-600">
                                    <p class="font-semibold text-slate-900">Thứ 2 · 4 · 6 · 08:00 - 10:00</p>
                                    <p class="text-xs text-slate-500">Online trên LMS</p>
                                    <p class="text-xs text-orange-500 font-semibold">Khai giảng: 05/12/2025</p>
                                </div>
                            </div>
                            <div class="mt-6 flex flex-wrap gap-3 text-xs text-slate-600">
                                <a href="#" class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Xem tài liệu khởi động
                                </a>
                                <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                    Tham gia nhóm lớp
                                </a>
                                <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                                    Huỷ đăng ký
                                </a>
                            </div>
                        </article>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                    <header>
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đã hoàn thành</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-900">Lịch sử lớp học</h2>
                    </header>
                    <div class="overflow-hidden rounded-3xl border border-blue-100">
                        <table class="w-full text-sm text-slate-600">
                            <thead class="bg-primary/10 text-xs uppercase tracking-widest text-slate-500">
                            <tr>
                                <th class="px-4 py-3 text-left font-semibold">Lớp</th>
                                <th class="px-4 py-3 text-left font-semibold">Thời gian</th>
                                <th class="px-4 py-3 text-left font-semibold">Giảng viên</th>
                                <th class="px-4 py-3 text-left font-semibold">Kết quả</th>
                                <th class="px-4 py-3 text-left font-semibold">Chứng nhận</th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-blue-50">
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-4 py-3">
                                    <p class="font-semibold text-slate-800">CT2 · Cấp tốc 6 tuần</p>
                                    <p class="text-xs text-slate-500 mt-1">Hoàn thành ngày 28/09/2025</p>
                                </td>
                                <td class="px-4 py-3">15/08/2025 - 28/09/2025</td>
                                <td class="px-4 py-3">Võ An</td>
                                <td class="px-4 py-3">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                        Xuất sắc
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Tải chứng nhận</a>
                                </td>
                            </tr>
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-4 py-3">
                                    <p class="font-semibold text-slate-800">Writing Booster</p>
                                    <p class="text-xs text-slate-500 mt-1">Hoàn thành ngày 12/06/2025</p>
                                </td>
                                <td class="px-4 py-3">01/05/2025 - 12/06/2025</td>
                                <td class="px-4 py-3">Nguyễn Phi</td>
                                <td class="px-4 py-3">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-blue-700">
                                        Hoàn thành
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Chi tiết phản hồi</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

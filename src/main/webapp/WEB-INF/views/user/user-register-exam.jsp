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
    <title>Ca thi đã đăng ký | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-6xl mx-auto px-6 space-y-12">
        <div class="space-y-4 text-center">
            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                Ca thi VSTEP
            </span>
            <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Ca thi của <%= displayName %></h1>
            <p class="text-sm text-slate-500 max-w-2xl mx-auto">
                Kiểm tra lịch thi, địa điểm và giấy tờ cần mang theo. Bạn có thể yêu cầu đổi ca hoặc tải phiếu báo danh trực tiếp.
            </p>
        </div>

        <div class="grid gap-8 lg:grid-cols-[1fr,2fr]">
            <aside class="space-y-6">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tổng quan</p>
                    <div class="space-y-2 text-sm text-slate-600">
                        <div class="flex items-center justify-between rounded-2xl bg-primary/10 px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Ca thi sắp diễn ra</span>
                            <span class="font-semibold text-slate-900">01</span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Ca thi đã hoàn thành</span>
                            <span class="font-semibold text-emerald-500">02</span>
                        </div>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hành động nhanh</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/ca" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Đăng ký ca thi mới
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Xin đổi ca thi
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                            Liên hệ hỗ trợ
                        </a>
                    </div>
                </div>
            </aside>

            <section class="space-y-6">
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-8">
                    <header class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ca thi sắp diễn ra</p>
                            <h2 class="text-2xl font-semibold text-slate-900">Chuẩn bị cho ngày thi</h2>
                        </div>
                        <div class="inline-flex rounded-full border border-blue-100 bg-white px-4 py-2 text-xs text-slate-500">
                            Check-in lúc 07:15 · 07/12/2025
                        </div>
                    </header>

                    <article class="rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition">
                        <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                            <div class="space-y-3">
                                <div class="flex flex-wrap gap-2 text-xs text-slate-400 uppercase tracking-widest">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 font-semibold text-primary">
                                        Đã xác nhận
                                    </span>
                                    <span>CA-1254 · Thi giấy</span>
                                </div>
                                <h3 class="text-xl font-semibold text-slate-900">VSTEP · Level B2 · Trung tâm khảo thí HCMUTE</h3>
                                <p class="text-sm text-slate-500 leading-relaxed">
                                    Phòng thi đạt chuẩn quốc gia, kiểm tra RFID, hỗ trợ gửi đồ miễn phí. Nhớ mang CMND/CCCD, phiếu đăng ký và ảnh 4x6.
                                </p>
                            </div>
                            <div class="flex-shrink-0 text-right space-y-2 text-sm text-slate-600">
                                <p class="font-semibold text-slate-900">07/12/2025 · 08:00 - 15:00</p>
                                <p class="text-xs text-slate-500">Cơ sở Quận 10 · Phòng A203</p>
                                <p class="text-xs text-emerald-500 font-semibold">Mã đăng ký: VST-B2-231110</p>
                            </div>
                        </div>
                        <div class="mt-6 grid gap-4 md:grid-cols-3 text-xs text-slate-500">
                            <div class="rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3">
                                <p class="font-semibold text-slate-700">Check-in</p>
                                <p class="mt-1">07:15 - 07:45 · Mang CMND/CCCD</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                <p class="font-semibold text-slate-700">Speaking</p>
                                <p class="mt-1">13:00 - 15:00 · Lịch sẽ gửi email trước 1 ngày</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                <p class="font-semibold text-slate-700">Giấy tờ bắt buộc</p>
                                <p class="mt-1">CMND/CCCD · Phiếu đăng ký · 02 ảnh 4x6</p>
                            </div>
                        </div>
                        <div class="mt-6 flex flex-wrap gap-3 text-xs text-slate-600">
                            <a href="#" class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Tải phiếu báo danh
                            </a>
                            <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                Hướng dẫn dự thi
                            </a>
                            <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                                Xin đổi ca
                            </a>
                        </div>
                    </article>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                    <header>
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ca thi đã hoàn thành</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-900">Lịch sử đăng ký</h2>
                    </header>

                    <div class="overflow-hidden rounded-3xl border border-blue-100">
                        <table class="w-full text-sm text-slate-600">
                            <thead class="bg-primary/10 text-xs uppercase tracking-widest text-slate-500">
                            <tr>
                                <th class="px-4 py-3 text-left font-semibold">Ca thi</th>
                                <th class="px-4 py-3 text-left font-semibold">Thời gian</th>
                                <th class="px-4 py-3 text-left font-semibold">Địa điểm</th>
                                <th class="px-4 py-3 text-left font-semibold">Kết quả</th>
                                <th class="px-4 py-3 text-left font-semibold">Tài liệu</th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-blue-50">
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-4 py-3">
                                    <p class="font-semibold text-slate-800">CA-1178 · Thi trên máy</p>
                                    <p class="text-xs text-slate-500 mt-1">Hoàn thành ngày 25/07/2025</p>
                                </td>
                                <td class="px-4 py-3">25/07/2025 · 08:00 - 14:30</td>
                                <td class="px-4 py-3">Cơ sở Thủ Đức · Phòng Lab 202</td>
                                <td class="px-4 py-3">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                        Đạt B2
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Tải bảng điểm</a>
                                </td>
                            </tr>
                            <tr class="hover:bg-blue-50/50 transition">
                                <td class="px-4 py-3">
                                    <p class="font-semibold text-slate-800">CA-1105 · Thi giấy</p>
                                    <p class="text-xs text-slate-500 mt-1">Hoàn thành ngày 10/04/2025</p>
                                </td>
                                <td class="px-4 py-3">10/04/2025 · 08:00 - 15:00</td>
                                <td class="px-4 py-3">Cơ sở Quận 3 · Hội trường B</td>
                                <td class="px-4 py-3">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-blue-700">
                                        Đã thi
                                    </span>
                                </td>
                                <td class="px-4 py-3">
                                    <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Xem phản hồi</a>
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

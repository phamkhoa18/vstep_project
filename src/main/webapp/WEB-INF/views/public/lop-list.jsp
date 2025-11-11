<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách lớp ôn | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Lớp ôn VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Tìm lớp ôn phù hợp và sẵn sàng đạt chứng chỉ VSTEP
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed max-w-3xl">
                        Mỗi lớp học đều có lộ trình rõ ràng, giảng viên giàu kinh nghiệm và chế độ hỗ trợ cá nhân hóa.
                        Dễ dàng lọc theo hình thức, cấp độ và thời gian để lựa chọn chương trình phù hợp với bạn.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-100">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            26 lớp đang mở
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            12 lớp khai giảng trong 14 ngày
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Cam kết hỗ trợ đến khi đạt mục tiêu
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-6 py-8 shadow-soft text-slate-700 bg-white/90">
                    <p class="text-sm font-semibold text-slate-900">Thống kê nhanh</p>
                    <ul class="mt-4 space-y-3 text-xs text-slate-600">
                        <li class="flex items-center justify-between">
                            <span>Lớp trực tiếp</span>
                            <span class="font-semibold text-slate-900">14</span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Lớp trực tuyến</span>
                            <span class="font-semibold text-slate-900">8</span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Lớp kết hợp</span>
                            <span class="font-semibold text-slate-900">4</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-6xl mx-auto px-6 space-y-10">
            <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                <div class="flex flex-col md:flex-row md:items-end md:justify-between gap-6">
                    <div class="space-y-2">
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Bộ lọc nhanh</p>
                        <p class="text-sm text-slate-500">Kết hợp nhiều điều kiện để thu hẹp danh sách lớp phù hợp.</p>
                    </div>
                    <div class="rounded-full bg-white px-4 py-2 text-xs text-primary font-semibold shadow-sm border border-blue-100">
                        Có thể dùng đồng thời ba bộ lọc
                    </div>
                </div>
                <div class="grid gap-4 md:grid-cols-3">
                    <div class="md:col-span-1">
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Từ khóa</label>
                        <div class="mt-2 relative">
                            <div class="absolute inset-y-0 left-4 flex items-center text-slate-300 pointer-events-none">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                    <circle cx="11" cy="11" r="7"/>
                                    <path d="M20 20l-3-3"/>
                                </svg>
                            </div>
                            <input type="search" placeholder="Tên lớp, giảng viên, mã lớp..."
                                   class="w-full rounded-full border border-blue-100 bg-white pl-12 pr-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hình thức</label>
                        <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>Tất cả</option>
                            <option>Trực tiếp</option>
                            <option>Trực tuyến</option>
                            <option>Kết hợp</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Cấp độ</label>
                        <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>Tất cả cấp độ</option>
                            <option>Cơ bản</option>
                            <option>Trung cấp</option>
                            <option>Nâng cao</option>
                            <option>Cấp tốc</option>
                        </select>
                    </div>
                </div>
                <div class="flex flex-wrap gap-2 text-xs">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary font-semibold shadow-sm">
                        Đang mở
                        <button class="hover:text-primary/70" aria-label="Loại bỏ lọc">×</button>
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500 shadow-sm">
                        Trực tuyến
                        <button class="hover:text-primary" aria-label="Loại bỏ lọc">×</button>
                    </span>
                    <a href="#" class="text-primary font-semibold hover:text-primary/80 transition">Xoá tất cả</a>
                </div>
            </div>

            <div class="space-y-6">
                <div class="grid gap-6 lg:grid-cols-2">
                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-start justify-between gap-4">
                            <div>
                                <h2 class="text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                                    NE3 · Giao tiếp nâng cao
                                </h2>
                                <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                    Luyện phản xạ nghe - nói theo đề thi mới, giảng viên ThS. Lê Thảo. 02 buổi mock test miễn phí, feedback cá nhân.
                                </p>
                            </div>
                            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                Nâng cao
                            </span>
                        </div>
                        <div class="mt-6 grid gap-4 md:grid-cols-2 text-sm text-slate-600">
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Lịch học</p>
                                <p class="mt-1 font-semibold text-slate-800">Thứ 3 · 5 · 18:00 - 20:00</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Khai giảng</p>
                                <p class="mt-1 font-semibold text-slate-800">12/11/2025 · Cơ sở Quận 10</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Giảng viên</p>
                                <p class="mt-1 font-semibold text-slate-800">ThS. Lê Thảo · IELTS 8.5</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Sĩ số</p>
                                <p class="mt-1 font-semibold text-slate-800">32 / 36 · <span class="text-emerald-500">Còn 4 chỗ</span></p>
                            </div>
                        </div>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-2xl font-bold text-primary">3.200.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/lop/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-class.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký ngay
                                </a>
                            </div>
                        </div>
                    </article>

                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-start justify-between gap-4">
                            <div>
                                <h2 class="text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                                    CB1 · Nền tảng VSTEP
                                </h2>
                                <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                    Ôn luyện tổng hợp 4 kỹ năng cho người mới bắt đầu. Bài tập theo khung B1, hỗ trợ trực tuyến 24/7.
                                </p>
                            </div>
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                Cơ bản
                            </span>
                        </div>
                        <div class="mt-6 grid gap-4 md:grid-cols-2 text-sm text-slate-600">
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Lịch học</p>
                                <p class="mt-1 font-semibold text-slate-800">Thứ 2 · 4 · 6 · 08:00 - 10:00</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Khai giảng</p>
                                <p class="mt-1 font-semibold text-slate-800">05/12/2025 · Online trên LMS</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Giảng viên</p>
                                <p class="mt-1 font-semibold text-slate-800">Nguyễn Phi · ThS TESOL</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Sĩ số</p>
                                <p class="mt-1 font-semibold text-slate-800">40 / 40 · <span class="text-orange-500">Đang chờ</span></p>
                            </div>
                        </div>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-2xl font-bold text-primary">2.450.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/lop/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-class.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký ngay
                                </a>
                            </div>
                        </div>
                    </article>

                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-start justify-between gap-4">
                            <div>
                                <h2 class="text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                                    CT2 · Cấp tốc 6 tuần
                                </h2>
                                <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                    Lộ trình cấp tốc với mentoring 1:1, tập trung luyện đề và chiến thuật làm bài theo từng kỹ năng.
                                </p>
                            </div>
                            <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">
                                Cấp tốc
                            </span>
                        </div>
                        <div class="mt-6 grid gap-4 md:grid-cols-2 text-sm text-slate-600">
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Lịch học</p>
                                <p class="mt-1 font-semibold text-slate-800">Thứ 7 · CN · 13:00 - 17:00</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Khai giảng</p>
                                <p class="mt-1 font-semibold text-slate-800">22/11/2025 · Phòng C201</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Giảng viên</p>
                                <p class="mt-1 font-semibold text-slate-800">Võ An · Chuyên gia cấp tốc</p>
                            </div>
                            <div>
                                <p class="text-xs text-slate-400 uppercase tracking-widest">Sĩ số</p>
                                <p class="mt-1 font-semibold text-slate-800">28 / 30 · <span class="text-emerald-500">Còn 2 chỗ</span></p>
                            </div>
                        </div>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-2xl font-bold text-primary">4.500.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/lop/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-class.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký ngay
                                </a>
                            </div>
                        </div>
                    </article>
                </div>

                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <p class="text-xs text-slate-500">Hiển thị 1 - 3 trên 26 lớp</p>
                    <div class="inline-flex items-center rounded-full border border-blue-100 bg-white shadow-sm">
                        <button class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-l-full">Trước</button>
                        <button class="px-3 py-2 text-white bg-primary rounded-full shadow-soft">1</button>
                        <button class="px-3 py-2 text-slate-400 hover:text-primary transition">2</button>
                        <button class="px-3 py-2 text-slate-400 hover:text-primary transition">3</button>
                        <button class="px-3 py-2 text-slate-400 hover:text-primary transition rounded-r-full">Sau</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


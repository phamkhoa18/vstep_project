<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách ca thi | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5 max-w-3xl">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Ca thi VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Chọn ca thi phù hợp và hoàn tất chứng chỉ VSTEP
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Lịch thi được cập nhật liên tục tại nhiều cơ sở. Đăng ký sớm để có chỗ ngồi tốt, nhận email hướng dẫn và chuẩn bị kỹ lưỡng trước ngày thi.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            18 ca trong tháng 11
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            7 ca thi máy · 11 ca thi giấy
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Giảm 20% cho thí sinh thi lại
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-8 shadow-soft text-slate-700 bg-white/90 w-full max-w-xs">
                    <p class="text-sm font-semibold text-slate-900">Lịch hỗ trợ trung tâm</p>
                    <ul class="mt-4 space-y-3 text-xs text-slate-500">
                        <li class="flex items-center justify-between">
                            <span>Hotline</span>
                            <span class="font-semibold text-slate-800">028 3456 789</span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Email tư vấn</span>
                            <span class="font-semibold text-slate-800">support@vstep.vn</span>
                        </li>
                        <li class="flex items-center justify-between">
                            <span>Giờ hỗ trợ</span>
                            <span class="font-semibold text-slate-800">08:00 - 21:00</span>
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
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Bộ lọc ca thi</p>
                        <p class="text-sm text-slate-500">Kết hợp ngày, khung giờ, cơ sở và trạng thái để tìm ca thi nhanh.</p>
                    </div>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Tải lịch thi PDF
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                            <path d="M12 4v16m8-8H4"/>
                        </svg>
                    </button>
                </div>
                <div class="grid gap-4 md:grid-cols-4">
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày thi</label>
                        <input type="date"
                               class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Khung giờ</label>
                        <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>Tất cả</option>
                            <option>Buổi sáng</option>
                            <option>Buổi chiều</option>
                            <option>Buổi tối</option>
                        </select>
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
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trạng thái</label>
                        <select class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            <option>Đang mở đăng ký</option>
                            <option>Đã khoá</option>
                            <option>Cần bổ sung</option>
                        </select>
                    </div>
                </div>
                <div class="flex flex-wrap gap-2 text-xs">
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary font-semibold shadow-sm">
                        Đang mở đăng ký
                        <button class="hover:text-primary/70" aria-label="Loại bỏ lọc">×</button>
                    </span>
                    <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500 shadow-sm">
                        Cơ sở Quận 10
                        <button class="hover:text-primary" aria-label="Loại bỏ lọc">×</button>
                    </span>
                    <a href="#" class="text-primary font-semibold hover:text-primary/80 transition">Xoá tất cả</a>
                </div>
            </div>

            <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                <header class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h2 class="text-xl font-semibold text-slate-900">Danh sách ca thi nổi bật</h2>
                        <p class="text-sm text-slate-500">Ưu tiên các ca gần nhất và còn nhiều chỗ trống.</p>
                    </div>
                    <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                        Nhận nhắc lịch qua email
                    </button>
                </header>

                <div class="grid gap-6 lg:grid-cols-2">
                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>12 · Thg 11 · 08:00</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-emerald-600 font-semibold">Đang mở</span>
                        </div>
                        <h2 class="mt-4 text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                            CA-1254 · Thi giấy
                        </h2>
                        <p class="mt-3 text-sm text-slate-500 leading-relaxed">
                            Phòng A203 · Cơ sở Quận 10 · 48/50 thí sinh. Phòng thi tiêu chuẩn, check-in tự động, hỗ trợ gửi đồ.
                        </p>
                        <dl class="mt-4 grid gap-3 text-xs text-slate-500 sm:grid-cols-2">
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Đăng ký trước</dt>
                                <dd class="mt-1 font-semibold text-slate-700">10/11/2025</dd>
                            </div>
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Giám sát</dt>
                                <dd class="mt-1 font-semibold text-slate-700">Phạm Khánh · Lý Hưng</dd>
                            </div>
                        </dl>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-xl font-bold text-primary">1.800.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/ca/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-exam.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký thi
                                </a>
                            </div>
                        </div>
                    </article>

                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>13 · Thg 11 · 13:30</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-orange-500 font-semibold">Cần bổ sung</span>
                        </div>
                        <h2 class="mt-4 text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                            CA-1261 · Thi máy
                        </h2>
                        <p class="mt-3 text-sm text-slate-500 leading-relaxed">
                            Phòng B102 · Cơ sở Thủ Đức · 52/60 thí sinh. Phòng máy chuẩn Bộ GD, cần bổ sung 02 giám sát viên dự phòng.
                        </p>
                        <dl class="mt-4 grid gap-3 text-xs text-slate-500 sm:grid-cols-2">
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Hạn xử lý</dt>
                                <dd class="mt-1 font-semibold text-slate-700">12/11/2025 · 17:00</dd>
                            </div>
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Hình thức</dt>
                                <dd class="mt-1 font-semibold text-slate-700">Thi trên máy</dd>
                            </div>
                        </dl>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-xl font-bold text-primary">1.800.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/ca/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-exam.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký thi
                                </a>
                            </div>
                        </div>
                    </article>

                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>15 · Thg 11 · 09:00</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-primary font-semibold">Đã khoá</span>
                        </div>
                        <h2 class="mt-4 text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                            CA-1263 · Thi máy
                        </h2>
                        <p class="mt-3 text-sm text-slate-500 leading-relaxed">
                            Phòng D205 · Cơ sở Bình Dương · 60/60 thí sinh. Đã gửi checklist và bản đồ di chuyển qua email.
                        </p>
                        <dl class="mt-4 grid gap-3 text-xs text-slate-500 sm:grid-cols-2">
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Giám sát</dt>
                                <dd class="mt-1 font-semibold text-slate-700">Lâm Dung · Vũ An</dd>
                            </div>
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Nhắc nhở</dt>
                                <dd class="mt-1 font-semibold text-slate-700">Đến sớm 45 phút để check-in</dd>
                            </div>
                        </dl>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-xl font-bold text-primary">1.800.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/ca/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-exam.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký thi
                                </a>
                            </div>
                        </div>
                    </article>

                    <article class="group rounded-3xl border border-blue-100 bg-white px-6 py-7 shadow-soft hover:shadow-xl transition-all">
                        <div class="flex items-center justify-between text-xs text-slate-500 uppercase tracking-wide">
                            <span>18 · Thg 11 · 18:00</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-emerald-600 font-semibold">Đang mở</span>
                        </div>
                        <h2 class="mt-4 text-xl font-semibold text-slate-900 group-hover:text-primary transition">
                            CA-1270 · Thi máy buổi tối
                        </h2>
                        <p class="mt-3 text-sm text-slate-500 leading-relaxed">
                            Phòng Lab HQ · Cơ sở Quận 1 · 30/40 thí sinh. Ca tối dành cho người đi làm, hỗ trợ gửi xe miễn phí.
                        </p>
                        <dl class="mt-4 grid gap-3 text-xs text-slate-500 sm:grid-cols-2">
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Đăng ký trước</dt>
                                <dd class="mt-1 font-semibold text-slate-700">16/11/2025</dd>
                            </div>
                            <div>
                                <dt class="text-slate-400 uppercase tracking-widest">Hỗ trợ</dt>
                                <dd class="mt-1 font-semibold text-slate-700">Parking · Nước uống</dd>
                            </div>
                        </dl>
                        <div class="mt-6 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                            <p class="text-xl font-bold text-primary">1.900.000đ</p>
                            <div class="flex flex-wrap gap-2">
                                <a href="<%= request.getContextPath() %>/ca/chi-tiet"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                                    Xem chi tiết
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                        <path d="M9 5l7 7-7 7"/>
                                    </svg>
                                </a>
                                <a href="../user/user-register-exam.jsp"
                                   class="inline-flex items-center gap-2 rounded-full bg-primary px-4 py-2 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đăng ký thi
                                </a>
                            </div>
                        </div>
                    </article>
                </div>

                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 rounded-3xl border border-blue-100 bg-white px-6 py-4 shadow-soft">
                    <p class="text-xs text-slate-500">Hiển thị 1 - 4 trên 18 ca thi</p>
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


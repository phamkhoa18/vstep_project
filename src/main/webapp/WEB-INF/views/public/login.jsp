<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-10">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5 max-w-3xl">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Đăng nhập VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Chào mừng quay lại nền tảng VSTEP
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Truy cập bảng điều khiển để đăng ký lớp ôn, đặt ca thi và theo dõi trạng thái hồ sơ. Một tài khoản duy nhất dùng cho cả thí sinh và quản trị viên (nếu được cấp quyền).
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Theo dõi tiến độ học tập
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Đăng ký ca thi nhanh chóng
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Nhận email nhắc lịch tự động
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-7 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm">
                    <p class="text-sm font-semibold text-slate-900">Hỗ trợ</p>
                    <ul class="mt-4 space-y-2 text-xs text-slate-500">
                        <li>• Quên mật khẩu? Liên hệ <span class="font-semibold text-slate-800">support@vstep.edu.vn</span>.</li>
                        <li>• Quản trị viên được cấp tài khoản riêng từ phòng đào tạo.</li>
                        <li>• Tạo tài khoản mới chỉ mất 1 phút nếu bạn là thí sinh.</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-5xl mx-auto px-6">
            <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-12 py-12 shadow-soft grid gap-10 lg:grid-cols-[1fr_1fr]">
                <div class="space-y-6">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft space-y-4">
                        <div class="flex items-center gap-3">
                            <div class="flex-1 bg-white px-4 py-2 text-lg text-center font-semibold text-slate-500 hover:text-primary transition">
                                Đăng nhập vào hệ thống
                            </div>
                        </div>
                        <form action="<%= request.getContextPath() %>/dang-nhap" method="post" class="space-y-5">
                            <div>
                                <label for="email" class="text-sm font-semibold text-slate-700">Email</label>
                                <div class="mt-2 relative">
                                    <input id="email" name="email" type="email" required
                                           class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="example@vstep.edu.vn">
                                    <div class="pointer-events-none absolute inset-y-0 right-4 flex items-center text-slate-300">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                            <path d="M2.94 6.34a2 2 0 0 1 .66-.5l6-3a2 2 0 0 1 1.8 0l6 3a2 2 0 0 1 1.1 1.78V13a2 2 0 0 1-2 2h-12a2 2 0 0 1-2-2V7.58a2 2 0 0 1 .44-1.24Zm7.06-2.67L4.75 6.5 10 9.45l5.25-2.95-5.25-2.83ZM4 8.3V13h12V8.3l-5.46 3.07a2 2 0 0 1-1.92 0L4 8.29Z"/>
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <div class="flex items-center justify-between">
                                    <label for="password" class="text-sm font-semibold text-slate-700">Mật khẩu</label>
                                    <a href="#" class="text-xs font-semibold text-primary hover:text-primary/80 transition">Quên mật khẩu?</a>
                                </div>
                                <div class="mt-2 relative">
                                    <input id="password" name="password" type="password" required
                                           class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="••••••••">
                                    <button type="button"
                                            class="absolute inset-y-0 right-4 flex items-center text-slate-300 hover:text-primary transition"
                                            aria-label="Hiện mật khẩu">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                            <path d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.432 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z"/>
                                            <path d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
                                        </svg>
                                    </button>
                                </div>
                            </div>

                            <% if(request.getAttribute("error") != null) { %>
                            <div class="flex items-start gap-2 rounded-lg my-4 border border-red-300 bg-red-50 px-4 py-3 text-red-700 shadow-sm animate-fade-in">
                                <!-- Icon lỗi -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 flex-shrink-0" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M6 18L18 6M6 6l12 12"/>
                                </svg>
                                <span class="text-sm"><%= request.getAttribute("error") %></span>
                            </div>
                            <% } %>

                            <% if(request.getAttribute("success") != null) { %>
                            <div class="flex items-start gap-2 rounded-lg my-4 border border-green-300 bg-green-50 px-4 py-3 text-green-700 shadow-sm animate-fade-in">
                                <!-- Icon thành công -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 flex-shrink-0" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M5 13l4 4L19 7"/>
                                </svg>
                                <span class="text-sm"><%= request.getAttribute("success") %></span>
                            </div>
                            <% } %>

                            <button type="submit"
                                    class="w-full inline-flex items-center justify-center gap-2 rounded-2xl bg-primary px-4 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Đăng nhập
                            </button>
                        </form>
                    </div>
                </div>
                <div class="space-y-6">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft space-y-4">
                        <h2 class="text-lg font-semibold text-slate-900">Còn chưa có tài khoản?</h2>
                        <p class="text-sm text-slate-500 leading-relaxed">
                            Đăng ký miễn phí để mở khóa toàn bộ tính năng: đăng ký lớp ôn, ca thi, nhận thông báo email và theo dõi lịch sử học tập.
                        </p>
                        <ul class="space-y-3 text-xs text-slate-500">
                            <li class="flex items-start gap-3">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                <span>Lưu hồ sơ đăng ký và cập nhật trạng thái tự động.</span>
                            </li>
                            <li class="flex items-start gap-3">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                <span>Nhận nhắc lịch học, lịch thi qua email & SMS.</span>
                            </li>
                            <li class="flex items-start gap-3">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                <span>Quản lý thông tin cá nhân, cập nhật hồ sơ nhanh chóng.</span>
                            </li>
                        </ul>
                        <a href="<%= request.getContextPath() %>/dang-ky"
                           class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                            Tạo tài khoản ngay
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                <path d="M9 5l7 7-7 7"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


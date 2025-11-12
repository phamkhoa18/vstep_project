<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản | VSTEP</title>
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
                        Tạo tài khoản VSTEP
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Bắt đầu hành trình chinh phục VSTEP
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Đăng ký miễn phí để đặt lớp ôn, đăng ký ca thi và theo dõi tiến độ học tập cá nhân. Chỉ mất 1 phút để hoàn tất và bạn có thể đăng nhập ngay.
                    </p>
                    <div class="grid gap-3 text-xs text-blue-50 sm:grid-cols-2">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Lưu lịch học & nhắc lịch qua email
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Theo dõi trạng thái đăng ký realtime
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Hỗ trợ ưu đãi cho thí sinh thi lại
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Quản lý hồ sơ cá nhân dễ dàng
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-7 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm">
                    <p class="text-sm font-semibold text-slate-900">Bạn cần chuẩn bị:</p>
                    <ul class="mt-4 space-y-2 text-xs text-slate-500">
                        <li>• Email cá nhân để nhận thông tin xác nhận.</li>
                        <li>• Số điện thoại dùng cho các thông báo khẩn.</li>
                        <li>• Mật khẩu tối thiểu 8 ký tự, kết hợp chữ cái và số.</li>
                        <li>• Đồng ý với điều khoản sử dụng hệ thống VSTEP.</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-6xl mx-auto px-6">
            <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-12 py-12 shadow-soft grid gap-12 lg:grid-cols-[1.1fr_0.9fr]">
                <div class="space-y-6">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft">

                        <form action="<%= request.getContextPath() %>/dang-ky" method="post">
                            <div class="grid gap-4 sm:grid-cols-2">
                                <div>
                                    <label for="fullName" class="text-sm font-semibold text-slate-700">Họ và tên</label>
                                    <input id="fullName" name="fullName" type="text" required
                                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="Nguyễn Văn A">
                                </div>
                                <div>
                                    <label for="phone" class="text-sm font-semibold text-slate-700">Số điện thoại</label>
                                    <input id="phone" name="phone" type="tel" required
                                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="09xx xxx xxx">
                                </div>
                            </div>
                            <div>
                                <label for="email" class="text-sm font-semibold text-slate-700">Email</label>
                                <input id="email" name="email" type="email" required
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="example@vstep.edu.vn">
                            </div>
                            <div class="grid gap-4 sm:grid-cols-2">
                                <div>
                                    <label for="password" class="text-sm font-semibold text-slate-700">Mật khẩu</label>
                                    <input id="password" name="password" type="password" required
                                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="••••••••">
                                </div>
                                <div>
                                    <label for="confirmPassword" class="text-sm font-semibold text-slate-700">Xác nhận mật khẩu</label>
                                    <input id="confirmPassword" name="confirmPassword" type="password" required
                                           class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                           placeholder="••••••••">
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
                                    class="w-full inline-flex mt-4 items-center justify-center gap-2 rounded-2xl bg-primary px-4 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Tạo tài khoản
                            </button>
                        </form>
                    </div>
                </div>
                <div class="space-y-6">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft space-y-4">
                        <h2 class="text-lg font-semibold text-slate-900">Quy trình trong 3 bước</h2>
                        <ul class="space-y-4 text-sm text-slate-600">
                            <li class="flex items-start gap-3">
                                <span class="mt-1 inline-flex h-6 w-6 items-center justify-center rounded-full bg-primary/10 text-primary">1</span>
                                <div>
                                    <p class="font-semibold text-slate-800">Nhập thông tin cá nhân</p>
                                    <p class="text-xs text-slate-500">Họ tên, email, số điện thoại để trung tâm liên hệ khi cần.</p>
                                </div>
                            </li>
                            <li class="flex items-start gap-3">
                                <span class="mt-1 inline-flex h-6 w-6 items-center justify-center rounded-full bg-primary/10 text-primary">2</span>
                                <div>
                                    <p class="font-semibold text-slate-800">Thiết lập bảo mật</p>
                                    <p class="text-xs text-slate-500">Tạo mật khẩu mạnh để bảo vệ tài khoản và xác nhận lại lần nữa.</p>
                                </div>
                            </li>
                            <li class="flex items-start gap-3">
                                <span class="mt-1 inline-flex h-6 w-6 items-center justify-center rounded-full bg-primary/10 text-primary">3</span>
                                <div>
                                    <p class="font-semibold text-slate-800">Xác minh email</p>
                                    <p class="text-xs text-slate-500">Nhận email kích hoạt, hoàn tất và đăng nhập ngay.</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="rounded-3xl border border-blue-100 bg-primary.pale/60 px-6 py-6 shadow-soft text-xs text-slate-600 space-y-3">
                        <p class="font-semibold text-slate-800">Đã có tài khoản?</p>
                        <p>Đăng nhập để tiếp tục đăng ký lớp ôn, đặt ca thi hoặc quản lý hồ sơ của bạn.</p>
                        <a href="<%= request.getContextPath() %>/dang-nhap"
                           class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition shadow-sm">
                            Đăng nhập ngay
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


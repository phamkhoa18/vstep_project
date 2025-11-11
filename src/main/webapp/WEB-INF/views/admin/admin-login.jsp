<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập quản trị | VSTEP</title>
    <link rel="stylesheet" href="https://fonts.cdnfonts.com/css/sf-pro-display">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#2563eb',
                        accent: '#fbbf24'
                    },
                    boxShadow: {
                        soft: '0 20px 40px rgba(37, 99, 235, 0.08)'
                    }
                }
            }
        };
    </script>
    <style>
        body {
            font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(145deg, #f3f7ff 0%, #ffffff 45%, #f8faff 100%);
            color: #1f2937;
        }
        .glass {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(18px);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4 py-12">
<div class="max-w-6xl w-full grid lg:grid-cols-2 gap-10 items-center">
    <div class="hidden lg:flex flex-col gap-10">
        <div class="glass rounded-3xl border border-blue-100 px-10 py-12 shadow-soft">
            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold text-primary uppercase tracking-[0.35em]">
                VSTEP ADMIN
            </span>
            <h1 class="mt-6 text-4xl font-bold text-slate-900 leading-tight">Quản trị hệ thống chủ động & hiệu quả</h1>
            <p class="mt-4 text-sm text-slate-500 leading-relaxed">
                Theo dõi sĩ số lớp, ca thi, doanh thu và cấu hình ưu đãi trong một bảng điều khiển duy nhất.
                Giao diện mới với tốc độ nhanh hơn, màu sắc sáng và thân thiện.
            </p>
            <div class="mt-8 grid gap-4 sm:grid-cols-2">
                <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                    <p class="text-2xl font-semibold text-primary">24/7</p>
                    <p class="text-xs text-slate-500 mt-2">Hỗ trợ vận hành liên tục, giám sát trạng thái hệ thống theo thời gian thực.</p>
                </div>
                <div class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm">
                    <p class="text-2xl font-semibold text-primary">99%</p>
                    <p class="text-xs text-slate-500 mt-2">Độ chính xác dữ liệu, đồng bộ với hệ thống đăng ký và thanh toán.</p>
                </div>
            </div>
        </div>
        <div class="glass rounded-3xl border border-blue-100 px-8 py-6 shadow-soft">
            <h2 class="text-lg font-semibold text-slate-900">Các tiện ích nổi bật</h2>
            <ul class="mt-4 space-y-3 text-sm text-slate-500">
                <li>• Giao diện sáng, font chữ Apple SF Pro Display đồng bộ với trang chủ.</li>
                <li>• Header & sidebar cố định, hiển thị mượt trên di động với nút toggle.</li>
                <li>• Tích hợp báo cáo nhanh, biểu đồ và bộ lọc thông minh.</li>
            </ul>
        </div>
    </div>

    <div class="glass rounded-3xl border border-blue-100 px-6 py-8 sm:px-10 sm:py-12 shadow-soft">
        <div class="flex flex-col gap-3">
            <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Đăng nhập quản trị</h2>
            <p class="text-sm text-slate-500">Sử dụng tài khoản nội bộ do phòng đào tạo cung cấp.</p>
        </div>
        <form class="mt-8 space-y-6">
            <div>
                <label for="email" class="text-sm font-semibold text-slate-700">Email</label>
                <div class="mt-2 relative">
                    <input id="email" name="email" type="email" required
                           class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                           placeholder="admin@vstep.edu.vn">
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
            <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                Ghi nhớ đăng nhập trên thiết bị này
            </label>
            <button type="submit"
                    class="w-full inline-flex items-center justify-center gap-2 rounded-2xl bg-primary px-4 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                Đăng nhập
            </button>
        </form>
        <div class="mt-8 border-t border-blue-100 pt-6 text-xs text-slate-400">
            <p>Cần cấp tài khoản quản trị? Liên hệ phòng đào tạo hoặc gửi email tới support@vstep.edu.vn.</p>
        </div>
    </div>
</div>
</body>
</html>


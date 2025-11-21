<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                        Khôi phục mật khẩu
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Quên mật khẩu?
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Nhập email đã đăng ký tài khoản của bạn. Chúng tôi sẽ gửi link khôi phục mật khẩu qua email để bạn có thể đặt lại mật khẩu mới.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Link có hiệu lực 24 giờ
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Kiểm tra hộp thư spam
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Bảo mật an toàn
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-7 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm">
                    <p class="text-sm font-semibold text-slate-900">Hỗ trợ</p>
                    <ul class="mt-4 space-y-2 text-xs text-slate-500">
                        <li>• Không nhận được email? Kiểm tra hộp thư spam hoặc thư mục quảng cáo.</li>
                        <li>• Link khôi phục chỉ có hiệu lực trong 24 giờ.</li>
                        <li>• Nếu vẫn gặp vấn đề, liên hệ <span class="font-semibold text-slate-800">support@vstep.edu.vn</span>.</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-5xl mx-auto px-6">
            <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-12 py-12 shadow-soft">
                <div class="max-w-md mx-auto space-y-6">
                    <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft space-y-4">
                        <div class="flex items-center gap-3">
                            <div class="flex-1 bg-white px-4 py-2 text-lg text-center font-semibold text-slate-500">
                                Nhập email của bạn
                            </div>
                        </div>
                        <form id="forgot-password-form" action="<%= request.getContextPath() %>/quen-mat-khau" method="post" class="space-y-5">
                            <div>
                                <label for="email" class="text-sm font-semibold text-slate-700">Email đã đăng ký</label>
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

                            <button type="submit"
                                    class="w-full inline-flex items-center justify-center gap-2 rounded-2xl bg-primary px-4 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Gửi link khôi phục
                            </button>
                        </form>
                    </div>

                    <div class="text-center">
                        <a href="<%= request.getContextPath() %>/dang-nhap"
                           class="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:text-primary/80 transition">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                <path d="M15 19l-7-7 7-7"/>
                            </svg>
                            Quay lại đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Xử lý flash messages
        <%
            String flashType = (String) session.getAttribute("forgotPasswordFlashType");
            String flashMessage = (String) session.getAttribute("forgotPasswordFlashMessage");
            if (flashType != null && flashMessage != null) {
                session.removeAttribute("forgotPasswordFlashType");
                session.removeAttribute("forgotPasswordFlashMessage");
        %>
            const flashType = '<%= flashType %>';
            const flashMessage = '<%= flashMessage.replace("'", "\\'") %>';
            const icon = flashType === 'success' ? 'success' : flashType === 'error' ? 'error' : 'info';
            
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    icon: icon,
                    title: flashType === 'success' ? 'Thành công!' : flashType === 'error' ? 'Lỗi!' : 'Thông báo',
                    text: flashMessage,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 5000,
                    timerProgressBar: true,
                    customClass: {
                        popup: 'rounded-2xl shadow-lg'
                    }
                });
            } else {
                alert(flashMessage);
            }
        <%
            }
        %>
    });
</script>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


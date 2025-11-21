<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu | VSTEP</title>
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
                        Đặt lại mật khẩu
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Tạo mật khẩu mới
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Nhập mật khẩu mới cho tài khoản của bạn. Mật khẩu phải có ít nhất 6 ký tự để đảm bảo tính bảo mật.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Tối thiểu 6 ký tự
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Bảo mật cao
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-7 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm">
                    <p class="text-sm font-semibold text-slate-900">Lưu ý</p>
                    <ul class="mt-4 space-y-2 text-xs text-slate-500">
                        <li>• Mật khẩu mới sẽ thay thế mật khẩu cũ ngay lập tức.</li>
                        <li>• Sau khi đặt lại, bạn cần đăng nhập lại với mật khẩu mới.</li>
                        <li>• Link đặt lại mật khẩu chỉ có hiệu lực một lần.</li>
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
                                Nhập mật khẩu mới
                            </div>
                        </div>
                        <%
                            String token = request.getParameter("token");
                            String error = request.getParameter("error");
                            if (token == null || token.isEmpty()) {
                        %>
                            <div class="flex items-start gap-2 rounded-lg my-4 border border-red-300 bg-red-50 px-4 py-3 text-red-700 shadow-sm">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 flex-shrink-0" fill="none"
                                     viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                          d="M6 18L18 6M6 6l12 12"/>
                                </svg>
                                <span class="text-sm">Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.</span>
                            </div>
                            <div class="text-center">
                                <a href="<%= request.getContextPath() %>/quen-mat-khau"
                                   class="inline-flex items-center gap-2 text-sm font-semibold text-primary hover:text-primary/80 transition">
                                    Yêu cầu link mới
                                </a>
                            </div>
                        <%
                            } else {
                        %>
                            <form id="reset-password-form" action="<%= request.getContextPath() %>/dat-lai-mat-khau" method="post" class="space-y-5">
                                <input type="hidden" name="token" value="<%= token %>">
                                
                                <% if (error != null) { %>
                                <div class="flex items-start gap-2 rounded-lg my-4 border border-red-300 bg-red-50 px-4 py-3 text-red-700 shadow-sm">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 flex-shrink-0" fill="none"
                                         viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                              d="M6 18L18 6M6 6l12 12"/>
                                    </svg>
                                    <span class="text-sm">
                                        <% 
                                            switch(error) {
                                                case "invalid_token":
                                                    out.print("Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
                                                    break;
                                                case "password_mismatch":
                                                    out.print("Mật khẩu mới và xác nhận mật khẩu không khớp.");
                                                    break;
                                                case "password_short":
                                                    out.print("Mật khẩu phải có ít nhất 6 ký tự.");
                                                    break;
                                                default:
                                                    out.print("Có lỗi xảy ra. Vui lòng thử lại.");
                                            }
                                        %>
                                    </span>
                                </div>
                                <% } %>

                                <div>
                                    <label for="newPassword" class="text-sm font-semibold text-slate-700">Mật khẩu mới</label>
                                    <div class="mt-2 relative">
                                        <input id="newPassword" name="newPassword" type="password" required minlength="6"
                                               class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                               placeholder="••••••••">
                                    </div>
                                </div>

                                <div>
                                    <label for="confirmPassword" class="text-sm font-semibold text-slate-700">Xác nhận mật khẩu</label>
                                    <div class="mt-2 relative">
                                        <input id="confirmPassword" name="confirmPassword" type="password" required minlength="6"
                                               class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                               placeholder="••••••••">
                                    </div>
                                </div>

                                <button type="submit"
                                        class="w-full inline-flex items-center justify-center gap-2 rounded-2xl bg-primary px-4 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đặt lại mật khẩu
                                </button>
                            </form>
                        <%
                            }
                        %>
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
        const form = document.getElementById('reset-password-form');
        if (form) {
            form.addEventListener('submit', (event) => {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (newPassword !== confirmPassword) {
                    event.preventDefault();
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: 'Mật khẩu mới và xác nhận mật khẩu không khớp.',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            customClass: {
                                popup: 'rounded-2xl shadow-lg'
                            }
                        });
                    } else {
                        alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                    }
                    return false;
                }

                if (newPassword.length < 6) {
                    event.preventDefault();
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: 'Mật khẩu phải có ít nhất 6 ký tự.',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            customClass: {
                                popup: 'rounded-2xl shadow-lg'
                            }
                        });
                    } else {
                        alert('Mật khẩu phải có ít nhất 6 ký tự.');
                    }
                    return false;
                }
            });
        }
    });
</script>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


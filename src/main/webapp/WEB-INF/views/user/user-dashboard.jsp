<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vstep.model.NguoiDung" %>
<%
    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
    String displayName = user != null && user.getHoTen() != null && !user.getHoTen().isEmpty()
            ? user.getHoTen()
            : "Học viên VSTEP";
    String email = user != null && user.getEmail() != null ? user.getEmail() : "";
    String phone = user != null && user.getSoDienThoai() != null ? user.getSoDienThoai() : "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pb-24">
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-14 pt-24">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-4">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Hồ sơ học viên
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Xin chào, <span class="text-yellow-300"><%= displayName %></span>
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed max-w-2xl">
                        Cập nhật thông tin cá nhân, chi tiết liên hệ và bảo mật để việc đăng ký lớp và ca thi diễn ra suôn sẻ.
                        Mọi thay đổi sẽ được lưu ngay lập tức và áp dụng trên toàn hệ thống.
                    </p>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-6 py-6 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm space-y-4">
                    <div class="flex items-center gap-4">
                        <div class="flex h-16 w-16 items-center justify-center rounded-full bg-primary/10 text-primary font-semibold text-lg uppercase">
                            <%= displayName.substring(0, Math.min(2, displayName.length())).toUpperCase() %>
                        </div>
                        <div>
                            <p class="text-sm font-semibold text-slate-900 uppercase tracking-widest">Tài khoản</p>
                            <p class="text-sm text-slate-600"><%= email.isEmpty() ? "Chưa cập nhật email" : email %></p>
                        </div>
                    </div>
                    <div class="grid gap-3 text-xs text-slate-600">
                        <div class="flex items-center justify-between">
                            <span>Trạng thái kích hoạt</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                Đã kích hoạt
                            </span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span>Ngày tham gia</span>
                            <span class="font-semibold text-slate-800">10/11/2025</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="max-w-6xl mx-auto px-6 mt-12 space-y-10">
        <div class="grid gap-8 lg:grid-cols-[1fr,2fr]">
            <aside class="space-y-4">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tổng quan</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="#personal" class="flex items-center justify-between rounded-2xl bg-primary/10 px-4 py-3 font-semibold text-primary">
                            Thông tin cá nhân
                            <span>→</span>
                        </a>
                        <a href="#contact" class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition">
                            Liên hệ & địa chỉ
                            <span>→</span>
                        </a>
                        <a href="#security" class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition">
                            Bảo mật tài khoản
                            <span>→</span>
                        </a>
                        <a href="#documents" class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition">
                            Tài liệu & giấy tờ
                            <span>→</span>
                        </a>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Liên kết nhanh</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/lop-da-dang-ky" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lớp đã đăng ký
                        </a>
                        <a href="<%= request.getContextPath() %>/ca-da-dang-ky" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Ca thi đã đăng ký
                        </a>
                        <a href="<%= request.getContextPath() %>/dang-xuat" class="inline-flex items-center gap-2 rounded-full border border-red-100 bg-white px-5 py-2.5 text-xs font-semibold text-red-600 hover:bg-red-50 transition">
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </aside>

            <section class="space-y-10">
                <form action="<%= request.getContextPath() %>/profile/update" method="post" class="space-y-10">
                    <div id="personal" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thông tin cá nhân</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Chỉnh sửa dữ liệu cơ bản</h2>
                            <p class="mt-2 text-sm text-slate-500">Tên sẽ xuất hiện trên biên lai, chứng chỉ và thông báo hệ thống.</p>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Họ và tên</label>
                                <input type="text" name="fullName" value="<%= displayName %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Nguyễn Văn A" required>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày sinh</label>
                                <input type="date" name="dob"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                            </div>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giới tính</label>
                                <div class="mt-2 flex flex-wrap gap-4 text-sm text-slate-600">
                                    <label class="inline-flex items-center gap-2">
                                        <input type="radio" name="gender" value="male" class="h-4 w-4 text-primary">
                                        Nam
                                    </label>
                                    <label class="inline-flex items-center gap-2">
                                        <input type="radio" name="gender" value="female" class="h-4 w-4 text-primary">
                                        Nữ
                                    </label>
                                    <label class="inline-flex items-center gap-2">
                                        <input type="radio" name="gender" value="other" class="h-4 w-4 text-primary">
                                        Khác
                                    </label>
                                </div>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Trình độ mục tiêu</label>
                                <select name="targetLevel"
                                        class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                    <option value="B1">B1</option>
                                    <option value="B2" selected>B2</option>
                                    <option value="C1">C1</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div id="contact" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Liên hệ & địa chỉ</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Đảm bảo thông tin liên lạc chính xác</h2>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Email</label>
                                <input type="email" name="email" value="<%= email %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="email@domain.com" required>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số điện thoại</label>
                                <input type="tel" name="phone" value="<%= phone %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="09xx xxx xxx" required>
                            </div>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Phụ huynh/người liên hệ khẩn</label>
                                <input type="text" name="emergencyName"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Nguyễn Thị B">
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số điện thoại khẩn</label>
                                <input type="tel" name="emergencyPhone"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="09xx xxx xxx">
                            </div>
                        </div>
                    </div>

                    <div id="security" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Bảo mật tài khoản</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Đổi mật khẩu & bật bảo mật</h2>
                            <p class="mt-2 text-sm text-slate-500">Nên đặt mật khẩu ít nhất 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt.</p>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mật khẩu hiện tại</label>
                                <input type="password" name="currentPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••">
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mật khẩu mới</label>
                                <input type="password" name="newPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••">
                            </div>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Xác nhận mật khẩu</label>
                                <input type="password" name="confirmPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••">
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Xác thực hai lớp</label>
                                <div class="mt-3 flex items-center gap-3 text-sm text-slate-600">
                                    <input type="checkbox" name="enable2FA" class="h-4 w-4 text-primary">
                                    <span>Bật xác thực qua email/SMS mỗi khi đăng nhập.</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="documents" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tài liệu & giấy tờ</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Quản lý giấy tờ liên quan</h2>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div class="rounded-2xl border border-dashed border-blue-200 bg-blue-50/40 px-6 py-6 text-center text-sm text-slate-500 space-y-3">
                                <p>Upload CMND/CCCD, thẻ sinh viên hoặc giấy tờ khác để hoàn tất hồ sơ.</p>
                                <label class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition cursor-pointer">
                                    <input type="file" name="identityDoc" class="hidden" accept=".pdf,.jpg,.jpeg,.png">
                                    Tải lên giấy tờ
                                </label>
                                <p class="text-[11px] text-slate-400">Dung lượng tối đa 10MB · Định dạng PDF/JPG/PNG</p>
                            </div>
                            <div class="space-y-3 text-sm text-slate-600">
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4">
                                    <p class="font-semibold text-slate-900">Biên lai học phí mới nhất</p>
                                    <p class="text-xs text-slate-500 mt-1">Cập nhật ngày 05/11/2025 · Đã xác thực</p>
                                    <a href="#" class="mt-3 inline-flex items-center gap-2 text-xs font-semibold text-primary hover:text-primary/80 transition">
                                        Tải về
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                            <path d="M12 5v14m0 0l-5-5m5 5l5-5"/>
                                        </svg>
                                    </a>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4">
                                    <p class="font-semibold text-slate-900">Giấy xác nhận sinh viên</p>
                                    <p class="text-xs text-slate-500 mt-1">Chưa tải lên</p>
                                    <button type="button" class="mt-3 inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                                        Gửi yêu cầu hỗ trợ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3">
                        <button type="submit" class="inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lưu thay đổi
                        </button>
                        <button type="reset" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-6 py-3 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Hoàn tác
                        </button>
                        <a href="<%= request.getContextPath() %>/dang-xuat" class="inline-flex items-center gap-2 rounded-full border border-red-100 bg-white px-6 py-3 text-xs font-semibold text-red-600 hover:bg-red-50 transition">
                            Đăng xuất tài khoản
                        </a>
                    </div>
                </form>
            </section>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

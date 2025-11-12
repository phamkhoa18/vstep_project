<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vstep.model.NguoiDung" %>
<%
    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
    String displayName = user != null && user.getHoTen() != null && !user.getHoTen().isEmpty()
            ? user.getHoTen()
            : "học viên";
    String email = user != null && user.getEmail() != null && !user.getEmail().isEmpty()
            ? user.getEmail()
            : "email@domain.com";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận email | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-4xl mx-auto px-6">
        <div class="glass rounded-3xl border border-blue-100 px-8 py-10 shadow-soft space-y-10">
            <div class="space-y-4 text-center">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                    Bước quan trọng tiếp theo
                </span>
                <h1 class="text-3xl font-extrabold text-slate-900">Hoàn tất xác nhận email</h1>
                <p class="text-sm text-slate-500 max-w-2xl mx-auto">
                    Xin chào <span class="font-semibold text-slate-700"><%= displayName %></span>, chúng tôi đã gửi một liên kết xác nhận đến địa chỉ
                    <span class="font-semibold text-primary"><%= email %></span>. Vui lòng kiểm tra hộp thư đến (và mục Spam/Quảng cáo) để kích hoạt tài khoản.
                </p>
            </div>

            <div class="grid gap-6 md:grid-cols-3">
                <div class="rounded-3xl border border-blue-100 bg-white px-6 py-8 text-center space-y-4">
                    <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-primary font-semibold text-lg">
                        1
                    </div>
                    <h2 class="text-lg font-semibold text-slate-900">Kiểm tra email</h2>
                    <p class="text-sm text-slate-500">
                        Mở email có tiêu đề “Xác nhận tài khoản VSTEP”. Nếu không thấy, thử tìm với từ khóa “VSTEP”.
                    </p>
                </div>
                <div class="rounded-3xl border border-blue-100 bg-white px-6 py-8 text-center space-y-4">
                    <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-primary font-semibold text-lg">
                        2
                    </div>
                    <h2 class="text-lg font-semibold text-slate-900">Nhấp vào liên kết</h2>
                    <p class="text-sm text-slate-500">
                        Bấm nút “Xác nhận ngay” trong email để hoàn tất. Liên kết có hiệu lực trong 24 giờ.
                    </p>
                </div>
                <div class="rounded-3xl border border-blue-100 bg-white px-6 py-8 text-center space-y-4">
                    <div class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-primary font-semibold text-lg">
                        3
                    </div>
                    <h2 class="text-lg font-semibold text-slate-900">Quay lại hệ thống</h2>
                    <p class="text-sm text-slate-500">
                        Sau khi xác nhận, đăng nhập lại để tiếp tục đăng ký lớp và ca thi không bị gián đoạn.
                    </p>
                </div>
            </div>

            <div class="rounded-3xl border border-blue-100 bg-blue-50/60 px-6 py-6 space-y-4">
                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                    <div>
                        <p class="text-sm font-semibold uppercase tracking-widest text-slate-500">Không nhận được email?</p>
                        <p class="text-sm text-slate-600 mt-1">Bạn có thể yêu cầu gửi lại, cập nhật địa chỉ email, hoặc liên hệ đội hỗ trợ.</p>
                    </div>
                    <div class="flex flex-wrap gap-3">
                        <form action="<%= request.getContextPath() %>/user/email/resend" method="post" class="inline-flex">
                            <button type="submit" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Gửi lại email
                            </button>
                        </form>
                        <a href="<%= request.getContextPath() %>/profile" class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Cập nhật email khác
                        </a>
                        <a href="mailto:support@vstep.edu.vn" class="inline-flex items-center gap-2 rounded-full border border-blue-200 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                            Liên hệ hỗ trợ
                        </a>
                    </div>
                </div>
            </div>

            <div class="space-y-4">
                <h2 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Câu hỏi thường gặp</h2>
                <div class="space-y-3 text-sm text-slate-600">
                    <details class="rounded-2xl border border-blue-100 bg-white px-5 py-4">
                        <summary class="cursor-pointer font-semibold text-slate-900">Liên kết xác nhận đã hết hạn thì sao?</summary>
                        <p class="mt-3 text-sm text-slate-500">Nhấn “Gửi lại email” để nhận liên kết mới. Mỗi liên kết mới sẽ vô hiệu hóa liên kết cũ để đảm bảo bảo mật.</p>
                    </details>
                    <details class="rounded-2xl border border-blue-100 bg-white px-5 py-4">
                        <summary class="cursor-pointer font-semibold text-slate-900">Tôi đã xác nhận nhưng vẫn bị yêu cầu xác nhận email?</summary>
                        <p class="mt-3 text-sm text-slate-500">Hãy đăng xuất và đăng nhập lại. Nếu tình trạng vẫn tiếp tục, liên hệ hỗ trợ để chúng tôi kiểm tra trạng thái tài khoản của bạn.</p>
                    </details>
                    <details class="rounded-2xl border border-blue-100 bg-white px-5 py-4">
                        <summary class="cursor-pointer font-semibold text-slate-900">Có thể thay đổi địa chỉ email đăng ký không?</summary>
                        <p class="mt-3 text-sm text-slate-500">Có, chọn “Cập nhật email khác” để chuyển đến trang hồ sơ và đổi địa chỉ email mới, sau đó yêu cầu gửi lại email xác nhận.</p>
                    </details>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

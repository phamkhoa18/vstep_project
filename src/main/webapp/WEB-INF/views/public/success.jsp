<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành công | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-20">
    <section class="max-w-4xl mx-auto px-6">
        <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-12 py-12 shadow-soft space-y-10 text-center">
            <div class="mx-auto flex h-20 w-20 items-center justify-center rounded-full bg-emerald-100 text-emerald-500 shadow-soft">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none"
                     viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
                </svg>
            </div>
            <div>
                <h1 class="text-3xl sm:text-4xl font-bold text-slate-900 tracking-tight">Đăng ký thành công!</h1>
                <p class="mt-3 text-sm text-slate-500 leading-relaxed">
                    Cảm ơn bạn đã tin tưởng VSTEP. Chúng tôi đã gửi email xác nhận kèm thông tin chi tiết về đăng ký của bạn.
                    Vui lòng kiểm tra hộp thư trong vòng vài phút (kiểm tra cả mục Spam/Quảng cáo nếu chưa thấy).
                </p>
            </div>
            <div class="rounded-3xl border border-blue-100 bg-white px-6 py-6 shadow-soft text-left space-y-4">
                <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                    <p class="text-sm font-semibold text-slate-800 uppercase tracking-widest">Mã đăng ký</p>
                    <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-sm font-semibold text-primary">
                        DK-20251109-1023
                    </span>
                </div>
                <dl class="grid gap-4 sm:grid-cols-2 text-sm text-slate-600">
                    <div>
                        <dt class="text-slate-400">Họ và tên</dt>
                        <dd class="font-semibold text-slate-800">Trần Gia Khang</dd>
                    </div>
                    <div>
                        <dt class="text-slate-400">Email</dt>
                        <dd class="font-semibold text-slate-800">khang.tg@example.com</dd>
                    </div>
                    <div>
                        <dt class="text-slate-400">Loại đăng ký</dt>
                        <dd class="font-semibold text-slate-800">Ca thi CA-1254 · Thi giấy</dd>
                    </div>
                    <div>
                        <dt class="text-slate-400">Thời gian</dt>
                        <dd class="font-semibold text-slate-800">12/11/2025 · 08:00</dd>
                    </div>
                </dl>
            </div>
            <div class="space-y-4 text-sm text-slate-600">
                <div class="rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm text-left">
                    <p class="font-semibold text-slate-800">Bước tiếp theo</p>
                    <ul class="mt-2 space-y-1 text-xs text-slate-500">
                        <li>• Kiểm tra email để xác nhận thông tin và tải phiếu hướng dẫn.</li>
                        <li>• Hoàn tất thanh toán (nếu còn) trước hạn thông báo.</li>
                        <li>• Liên hệ hotline <span class="font-semibold text-primary">(028) 1234 5678</span> nếu cần hỗ trợ.</li>
                    </ul>
                </div>
                <div class="flex flex-wrap justify-center gap-3">
                    <a href="ca-list.jsp"
                       class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                        Xem thêm ca thi khác
                    </a>
                    <a href="lop-list.jsp"
                       class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Đăng ký lớp ôn
                    </a>
                </div>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


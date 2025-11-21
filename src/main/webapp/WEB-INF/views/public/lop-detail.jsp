<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${not empty lop ? lop.tieuDe : 'Chi tiết lớp ôn'}" /> | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<c:if test="${notFound}">
    <main>
        <section class="max-w-6xl mx-auto px-6 py-24 text-center">
            <h1 class="text-4xl font-bold text-slate-900 mb-4">Không tìm thấy lớp ôn</h1>
            <p class="text-slate-500 mb-6">Lớp ôn bạn đang tìm không tồn tại hoặc đã bị xóa.</p>
            <a href="${pageContext.request.contextPath}/lop" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                Quay lại danh sách lớp
            </a>
        </section>
    </main>
    <%@ include file="../layout/public-footer.jspf" %>
</body>
</html>
</c:if>

<c:if test="${empty notFound and not empty lop}">

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5 max-w-3xl">
                    <div class="flex flex-wrap items-center gap-3 text-xs">
                        <c:if test="${not empty lop.nhipDo}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 font-semibold uppercase tracking-[0.3em]">
                                <c:out value="${lop.nhipDo}" />
                            </span>
                        </c:if>
                        <c:if test="${not empty lop.ngayKhaiGiang}">
                            <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" var="ngayKhaiGiangDisplay" />
                            <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-3 py-1 font-semibold">
                                Khai giảng <c:out value="${ngayKhaiGiangDisplay}" />
                            </span>
                        </c:if>
                        <c:if test="${not empty lop.tinhTrang}">
                            <c:set var="statusLower" value="${fn:toLowerCase(lop.tinhTrang)}" />
                            <c:choose>
                                <c:when test="${fn:contains(statusLower, 'dang mo') or fn:contains(statusLower, 'dangmo')}">
                                    <span class="inline-flex items-center gap-2 rounded-full bg-emerald-400/20 px-3 py-1 font-semibold text-emerald-50 border border-emerald-200/40">
                                        Đang mở đăng ký
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-3 py-1 font-semibold">
                                        <c:out value="${lop.tinhTrang}" />
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        <c:out value="${lop.tieuDe}" />
                    </h1>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <c:if test="${not empty lop.thoiGianHoc}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                                <c:out value="${lop.thoiGianHoc}" />
                                <c:if test="${not empty lop.gioMoiBuoi}">
                                    <fmt:formatDate value="${lop.gioMoiBuoi}" pattern="HH:mm" var="gioMoiBuoiDisplay" />
                                    · <c:out value="${gioMoiBuoiDisplay}" />
                                </c:if>
                            </span>
                        </c:if>
                        <c:if test="${lop.soBuoi > 0}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                                <c:out value="${lop.soBuoi}" /> buổi
                            </span>
                        </c:if>
                        <c:if test="${not empty lop.hinhThuc}">
                            <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                                <c:out value="${lop.hinhThuc}" />
                            </span>
                        </c:if>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-8 shadow-soft text-slate-700 bg-white/90 w-full max-w-xs">
                    <p class="text-sm font-semibold text-slate-900">Học phí trọn khóa</p>
                    <p class="mt-2 text-3xl font-bold text-primary">
                        <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                    </p>
                    <div class="mt-4 space-y-3 text-xs text-slate-500">
                        <c:if test="${not empty lop.maLop}">
                            <div class="flex items-center justify-between">
                                <span>Mã lớp</span>
                                <span class="font-semibold text-slate-800"><c:out value="${lop.maLop}" /></span>
                            </div>
                        </c:if>
                        <div class="flex items-center justify-between">
                            <span>Sĩ số</span>
                            <span class="font-semibold text-slate-800">
                                <c:out value="${empty soLuongDangKy ? 0 : soLuongDangKy}" /> / <c:out value="${lop.siSoToiDa}" /> học viên
                            </span>
                        </div>
                        <c:if test="${not empty soLuongDangKy and soLuongDangKy < lop.siSoToiDa}">
                            <div class="flex items-center justify-between">
                                <span>Còn chỗ</span>
                                <span class="font-semibold text-emerald-600">
                                    <c:out value="${lop.siSoToiDa - soLuongDangKy}" /> chỗ trống
                                </span>
                            </div>
                        </c:if>
                        <div class="flex items-center justify-between">
                            <span>Hỗ trợ</span>
                            <span class="font-semibold text-slate-800">Tư vấn 24/7</span>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${daDuCho}">
                            <span class="mt-5 block text-center rounded-full border border-rose-100 bg-rose-50 px-5 py-3 text-sm font-semibold text-rose-500 cursor-not-allowed">
                                Đã đủ chỗ
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/dang-ky-lop?lopId=${lop.id}"
                               class="mt-5 block text-center rounded-full bg-primary px-5 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Đăng ký ngay
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <p class="mt-3 text-[11px] text-center text-slate-400">
                        Giữ chỗ trong 24h. Học viên thi lại được giảm thêm 10% tự động.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-6xl mx-auto px-6">
            <div class="grid gap-8 lg:grid-cols-[2fr,1fr]">
                <div class="space-y-8">
                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header class="space-y-3">
                            <h2 class="text-xl font-semibold text-slate-900">Tổng quan khóa học</h2>
                            <p class="text-sm text-slate-500 leading-relaxed">
                                <c:out value="${not empty lop.moTaNgan ? lop.moTaNgan : 'Lớp ôn luyện VSTEP chất lượng cao với lộ trình rõ ràng và giảng viên giàu kinh nghiệm.'}" />
                            </p>
                        </header>

                        <div class="rounded-2xl border border-dashed border-blue-200 px-5 py-4 text-sm text-slate-600 space-y-2">
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Điểm nổi bật</p>
                            <ul class="space-y-2 text-xs">
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>Classroom studio với micro riêng từng nhóm, thu âm và phân tích lỗi phát âm.</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>02 buổi mock test toàn diện, giám khảo chấm trực tiếp theo rubric VSTEP.</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>Hệ thống LMS cá nhân hóa: giao bài, nhắc lịch, báo cáo tiến độ hàng tuần.</span>
                                </li>
                            </ul>
                        </div>
                    </article>

                    <c:if test="${not empty lop.noiDungChiTiet}">
                        <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                            <header>
                                <h2 class="text-xl font-semibold text-slate-900">Nội dung chi tiết</h2>
                            </header>
                            <div class="prose prose-slate max-w-none text-sm text-slate-600 leading-relaxed">
                                <c:out value="${lop.noiDungChiTiet}" escapeXml="false" />
                            </div>
                        </article>

                        <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                            <header>
                                <h2 class="text-xl font-semibold text-slate-900">Tài nguyên & hỗ trợ</h2>
                                <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                    Toàn bộ tài nguyên được update hàng tuần theo đề thi mới nhất.
                                </p>
                            </header>
                            <div class="grid gap-4 md:grid-cols-2">
                                <div class="rounded-2xl border border-blue-100 bg-primary.pale/50 px-4 py-4 text-sm text-slate-600 space-y-2">
                                    <p class="font-semibold text-slate-800">Tài liệu độc quyền</p>
                                    <p class="text-xs text-slate-500">12 bộ đề chuẩn hóa, audio luyện nghe, flashcard online.</p>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-sm text-slate-600 space-y-2 shadow-sm">
                                    <p class="font-semibold text-slate-800">Mentoring cá nhân</p>
                                    <p class="text-xs text-slate-500">1 buổi 1:1 mỗi 2 tuần để rà tiến độ và chỉnh lỗi.</p>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-sm text-slate-600 space-y-2 shadow-sm">
                                    <p class="font-semibold text-slate-800">Community học viên</p>
                                    <p class="text-xs text-slate-500">Group Zalo riêng, luyện speaking hàng tối với trợ giảng.</p>
                                </div>
                                <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-4 py-4 text-sm text-slate-600 space-y-2">
                                    <p class="font-semibold text-slate-800">Hỗ trợ đăng ký thi</p>
                                    <p class="text-xs text-slate-500">Được ưu tiên chọn ca thi nội bộ, giảm 5% phí đăng ký.</p>
                                </div>
                            </div>
                        </article>
                    </c:if>

                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header>
                            <h2 class="text-xl font-semibold text-slate-900">Câu hỏi thường gặp</h2>
                        </header>
                        <div class="space-y-4 text-sm text-slate-600">
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify-between cursor-pointer font-semibold text-slate-800">
                                    Tôi có được xem lại bài giảng không?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Có. Video ghi hình được lưu trên LMS 30 ngày sau buổi học, kèm tài liệu và bài tập ôn luyện.
                                </p>
                            </details>
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify-between cursor-pointer font-semibold text-slate-800">
                                    Nếu tôi nghỉ 1 buổi thì có được bù?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Trung tâm hỗ trợ lớp học bù online và gửi bài tập có feedback riêng. Báo trước 4 giờ để giữ quyền lợi.
                                </p>
                            </details>
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify_between cursor-pointer font-semibold text-slate-800">
                                    Có hỗ trợ đăng ký ca thi không?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Giảng viên sẽ tư vấn chọn ca thi phù hợp. Học viên NE3 được ưu tiên đặt chỗ ca thi nội bộ và nhận email nhắc lịch.
                                </p>
                            </details>
                        </div>
                    </article>
                </div>

                <aside class="space-y-6">

                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white space-y-4">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Thông tin nhanh</h3>
                        <div class="space-y-3 text-sm text-slate-600">
                            <c:if test="${not empty lop.hinhThuc}">
                                <div class="flex items-center justify-between rounded-2xl bg-primary.pale/60 px-4 py-3">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Hình thức</span>
                                    <span class="font-semibold text-slate-800"><c:out value="${lop.hinhThuc}" /></span>
                                </div>
                            </c:if>
                            <c:if test="${lop.soBuoi > 0}">
                                <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Số buổi</span>
                                    <span class="font-semibold text-slate-800"><c:out value="${lop.soBuoi}" /> buổi</span>
                                </div>
                            </c:if>
                            <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Sĩ số</span>
                                <span class="font-semibold text-slate-800">
                                    <c:out value="${empty soLuongDangKy ? 0 : soLuongDangKy}" /> / <c:out value="${lop.siSoToiDa}" /> học viên
                                </span>
                            </div>
                            <c:if test="${not empty soLuongDangKy and soLuongDangKy < lop.siSoToiDa}">
                                <div class="flex items-center justify-between rounded-2xl bg-emerald-50 px-4 py-3 border border-emerald-100">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Còn chỗ</span>
                                    <span class="font-semibold text-emerald-600">
                                        <c:out value="${lop.siSoToiDa - soLuongDangKy}" /> chỗ
                                    </span>
                                </div>
                            </c:if>
                            <c:if test="${daDuCho}">
                                <div class="flex items-center justify-between rounded-2xl bg-rose-50 px-4 py-3 border border-rose-100">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Trạng thái</span>
                                    <span class="font-semibold text-rose-600">Đã đủ chỗ</span>
                                </div>
                            </c:if>
                            <c:if test="${not empty lop.nhipDo}">
                                <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Nhịp độ</span>
                                    <span class="font-semibold text-slate-800"><c:out value="${lop.nhipDo}" /></span>
                                </div>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/lop"
                           class="inline-flex items-center gap-2 text-xs font-semibold text-primary hover:text-primary/80 transition">
                            Xem thêm lớp khác
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                <path d="M9 5l7 7-7 7"/>
                            </svg>
                        </a>
                    </div>

                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white space-y-5">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Học viên nói gì?</h3>
                        <div class="space-y-4">
                            <figure class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-4 py-4 text-xs text-slate-600 space-y-2">
                                <p class="italic text-slate-700">“Sau 8 tuần mình từ B1 lên B2. Feedback rất chi tiết, đặc biệt là phần speaking mock test.”</p>
                                <figcaption class="text-[11px] font-semibold text-slate-500">Thuỳ Trang · Đạt B2 (2025)</figcaption>
                            </figure>
                            <figure class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-xs text-slate-600 space-y-2 shadow-sm">
                                <p class="italic text-slate-700">“LMS tiện, nhắc lịch đều. Giảng viên sửa lỗi phát âm từng âm, rất sát đề thi thật.”</p>
                                <figcaption class="text-[11px] font-semibold text-slate-500">Đức Long · Đạt B2 (2024)</figcaption>
                            </figure>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</c:if>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký lớp ôn | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-4xl mx-auto px-6 space-y-8">
        <c:if test="${empty lop}">
            <div class="glass rounded-3xl border border-red-100 px-6 py-12 text-center bg-red-50">
                <p class="text-lg font-semibold text-red-700 mb-4">Không tìm thấy lớp ôn</p>
                <p class="text-sm text-red-600 mb-6">Lớp ôn bạn đang tìm không tồn tại hoặc đã bị xóa.</p>
                <a href="${pageContext.request.contextPath}/lop" 
                   class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Quay lại danh sách lớp
                </a>
            </div>
        </c:if>

        <c:if test="${not empty lop}">
            <div class="space-y-4 text-center">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                    Đăng ký lớp ôn
                </span>
                <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Đăng ký lớp: <c:out value="${lop.tieuDe}" /></h1>
            </div>

            <div class="grid gap-8 lg:grid-cols-[1fr,1fr]">
                <!-- Form đăng ký -->
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                    <header>
                        <h2 class="text-xl font-semibold text-slate-900">Thông tin đăng ký</h2>
                        <p class="mt-2 text-sm text-slate-500">Vui lòng điền thông tin để hoàn tất đăng ký</p>
                    </header>

                    <c:if test="${not empty errorMessage}">
                        <div class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
                            <c:out value="${errorMessage}" />
                        </div>
                    </c:if>

                    <c:if test="${not empty successMessage}">
                        <div class="rounded-2xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm text-emerald-700">
                            <c:out value="${successMessage}" />
                        </div>
                    </c:if>

                    <form method="post" action="${pageContext.request.contextPath}/dang-ky-lop" class="space-y-5">
                        <input type="hidden" name="lopId" value="${lop.id}" />
                        
                        <div class="space-y-4">
                            <div>
                                <label for="hoTen" class="block text-sm font-semibold text-slate-700 mb-2">
                                    Họ và tên <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="hoTen" name="hoTen" 
                                       value="${not empty user ? user.hoTen : ''}"
                                       required
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Nhập họ và tên">
                            </div>

                            <div>
                                <label for="email" class="block text-sm font-semibold text-slate-700 mb-2">
                                    Email <span class="text-red-500">*</span>
                                </label>
                                <input type="email" id="email" name="email" 
                                       value="${not empty user ? user.email : ''}"
                                       required
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="example@email.com">
                            </div>

                            <div>
                                <label for="soDienThoai" class="block text-sm font-semibold text-slate-700 mb-2">
                                    Số điện thoại <span class="text-red-500">*</span>
                                </label>
                                <input type="tel" id="soDienThoai" name="soDienThoai" 
                                       value="${not empty user ? user.soDienThoai : ''}"
                                       required
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="0123456789">
                            </div>

                            <div>
                                <label for="donVi" class="block text-sm font-semibold text-slate-700 mb-2">
                                    Đơn vị/Lớp <span class="text-xs text-slate-500">(nếu là sinh viên)</span>
                                </label>
                                <input type="text" id="donVi" name="donVi" 
                                       value="${not empty user ? user.donVi : ''}"
                                       class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Ví dụ: Lớp 21DTH1, Khoa CNTT...">
                            </div>

                            <div>
                                <label for="ghiChu" class="block text-sm font-semibold text-slate-700 mb-2">Ghi chú (tùy chọn)</label>
                                <textarea id="ghiChu" name="ghiChu" rows="4" 
                                          placeholder="Ví dụ: Tôi muốn học buổi tối, hoặc có yêu cầu đặc biệt..."
                                          class="w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30 resize-none"></textarea>
                            </div>
                        </div>

                        <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-5 py-4 text-sm text-slate-600 space-y-2">
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thông tin lớp</p>
                            <div class="space-y-1">
                                <p><span class="font-semibold">Học phí:</span> <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ</p>
                                <p><span class="font-semibold">Hình thức:</span> <c:out value="${lop.hinhThuc}" /></p>
                                <p><span class="font-semibold">Nhịp độ:</span> <c:out value="${lop.nhipDo}" /></p>
                                <c:if test="${not empty lop.ngayKhaiGiang}">
                                    <fmt:formatDate value="${lop.ngayKhaiGiang}" pattern="dd/MM/yyyy" var="ngayKhaiGiangDisplay" />
                                    <p><span class="font-semibold">Khai giảng:</span> <c:out value="${ngayKhaiGiangDisplay}" /></p>
                                </c:if>
                            </div>
                        </div>

                        <div class="flex flex-col sm:flex-row gap-3">
                            <button type="submit" 
                                    class="flex-1 inline-flex items-center justify-center gap-2 rounded-full bg-primary px-5 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Xác nhận đăng ký
                            </button>
                            <a href="${pageContext.request.contextPath}/lop/chi-tiet/${lop.slug}" 
                               class="inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-3 text-sm font-semibold text-slate-600 hover:bg-blue-50 transition">
                                Quay lại
                            </a>
                        </div>
                    </form>
                </div>

                <!-- Thông tin lớp -->
                <div class="space-y-6">
                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500 mb-4">Chi tiết lớp học</h3>
                        <div class="space-y-3 text-sm text-slate-600">
                            <div class="flex items-center justify-between rounded-2xl bg-primary.pale/60 px-4 py-3">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Học phí</span>
                                <span class="font-semibold text-slate-900">
                                    <fmt:formatNumber value="${lop.hocPhi}" type="number" groupingUsed="true" />đ
                                </span>
                            </div>
                            <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Sĩ số</span>
                                <span class="font-semibold text-slate-900">
                                    <c:out value="${not empty soLuongDangKy ? soLuongDangKy : 0}" /> / <c:out value="${lop.siSoToiDa}" /> học viên
                                </span>
                            </div>
                            <c:if test="${not empty soLuongDangKy and soLuongDangKy >= lop.siSoToiDa}">
                                <div class="rounded-2xl border border-red-200 bg-red-50 px-4 py-3 text-xs text-red-700">
                                    <p class="font-semibold">⚠️ Lớp đã đầy</p>
                                    <p class="mt-1">Không thể đăng ký thêm</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty soLuongDangKy and soLuongDangKy < lop.siSoToiDa and (lop.siSoToiDa - soLuongDangKy) <= 5}">
                                <div class="rounded-2xl border border-orange-200 bg-orange-50 px-4 py-3 text-xs text-orange-700">
                                    <p class="font-semibold">⚠️ Còn <c:out value="${lop.siSoToiDa - soLuongDangKy}" /> chỗ trống</p>
                                    <p class="mt-1">Vui lòng đăng ký sớm</p>
                                </div>
                            </c:if>
                            <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Số buổi</span>
                                <span class="font-semibold text-slate-900"><c:out value="${lop.soBuoi}" /> buổi</span>
                            </div>
                            <c:if test="${not empty lop.thoiGianHoc}">
                                <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                    <span class="text-xs text-slate-500 uppercase tracking-widest">Lịch học</span>
                                    <span class="font-semibold text-slate-900"><c:out value="${lop.thoiGianHoc}" /></span>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500 mb-4">Lưu ý</h3>
                        <ul class="space-y-2 text-xs text-slate-600">
                            <li class="flex items-start gap-2">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                <span>Đăng ký sẽ được xử lý trong vòng 24 giờ</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                <span>Bạn sẽ nhận được email xác nhận sau khi đăng ký thành công</span>
                            </li>
                            <li class="flex items-start gap-2">
                                <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary flex-shrink-0"></span>
                                <span>Có thể hủy đăng ký trước 5 ngày khai giảng</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


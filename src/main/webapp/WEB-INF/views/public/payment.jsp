<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán | VSTEP</title>
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
                    fontFamily: {
                        sans: ['SF Pro Display', 'ui-sans-serif', 'system-ui', 'Segoe UI', 'Roboto', 'Arial']
                    }
                }
            }
        }
    </script>
</head>
<body class="min-h-screen bg-slate-50 font-sans">
<div class="max-w-3xl mx-auto px-4 py-10">
    <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 md:p-8 space-y-6">
        <div class="flex items-center justify-between">
            <h1 class="text-2xl font-bold text-slate-900">Thanh toán bằng QR</h1>
            <span class="inline-flex items-center rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                Hết hạn sau <span id="countdown" class="ml-1">--:--</span>
            </span>
        </div>

        <div class="grid gap-6 md:grid-cols-2">
            <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 p-6 text-center space-y-4">
                <img src="${qrUrl}" alt="QR thanh toán" class="mx-auto rounded-2xl border border-blue-100 shadow-sm">
                <p class="text-sm text-slate-500">Quét QR để xác nhận thanh toán tự động.</p>
                <a href="${confirmUrl}" class="text-xs text-primary hover:underline">Hoặc nhấn vào đây nếu bạn đang thanh toán trên thiết bị này</a>
            </div>
            <div class="space-y-4">
                <div>
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Mã đăng ký</p>
                    <p class="mt-1 text-lg font-semibold text-slate-900"><c:out value="${dangKy.maXacNhan}" /></p>
                </div>
                <div class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm">
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Thông tin lớp</p>
                    <c:choose>
                        <c:when test="${not empty lopOn}">
                            <p class="mt-1 text-sm font-semibold text-slate-800">
                                <c:out value="${lopOn.maLop}" /> · <c:out value="${lopOn.tieuDe}" />
                            </p>
                            <p class="text-xs text-slate-500">
                                <c:if test="${not empty lopOn.ngayKhaiGiang}">
                                    Khai giảng <fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="dd/MM/yyyy" />
                                </c:if>
                                · <c:out value="${lopOn.hinhThuc}" />
                                <c:if test="${not empty lopOn.thoiGianHoc}">
                                    · <c:out value="${lopOn.thoiGianHoc}" />
                                </c:if>
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p class="mt-1 text-sm text-slate-600">Không có thông tin lớp.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="rounded-2xl border border-blue-50 bg-white p-4 shadow-sm space-y-2">
                    <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Số tiền cần thanh toán</p>
                    <c:choose>
                        <c:when test="${isExam}">
                            <c:set var="giaGoc" value="${caThi.giaGoc}" />
                            <c:if test="${giaGoc > soTienPhaiTra}">
                                <div class="text-xs text-slate-500">
                                    <p>Giá gốc: <fmt:formatNumber value="${giaGoc}" type="number" groupingUsed="true" />đ</p>
                                    <c:if test="${mucGiam > 0}">
                                        <p class="text-emerald-600">Giảm giá: -<fmt:formatNumber value="${mucGiam}" type="number" groupingUsed="true" />đ</p>
                                        <c:if test="${not empty maCodeGiamGia}">
                                            <p class="text-xs text-slate-400">Mã code: <c:out value="${maCodeGiamGia}" /></p>
                                        </c:if>
                                    </c:if>
                                </div>
                            </c:if>
                            <p class="mt-1 text-lg font-semibold text-emerald-600">
                                <fmt:formatNumber value="${soTienPhaiTra}" type="number" groupingUsed="true" />đ
                            </p>
                        </c:when>
                        <c:otherwise>
                            <c:set var="hocPhi" value="${lopOn.hocPhi}" />
                            <c:if test="${hocPhi > soTienPhaiTra}">
                                <div class="text-xs text-slate-500">
                                    <p>Học phí: <fmt:formatNumber value="${hocPhi}" type="number" groupingUsed="true" />đ</p>
                                    <c:if test="${mucGiam > 0}">
                                        <p class="text-emerald-600">Giảm giá: -<fmt:formatNumber value="${mucGiam}" type="number" groupingUsed="true" />đ</p>
                                        <c:if test="${not empty maCodeGiamGia}">
                                            <p class="text-xs text-slate-400">Mã code: <c:out value="${maCodeGiamGia}" /></p>
                                        </c:if>
                                    </c:if>
                                </div>
                            </c:if>
                            <p class="mt-1 text-lg font-semibold text-emerald-600">
                                <fmt:formatNumber value="${soTienPhaiTra}" type="number" groupingUsed="true" />đ
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="text-xs text-slate-500">
                    Nếu QR hết hạn, hãy tải lại trang để tạo mã mới.
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    (function() {
        const expiresAt = Number('${expiresAt}');
        const countdownEl = document.getElementById('countdown');
        function updateCountdown() {
            const now = Date.now();
            const remaining = Math.max(0, expiresAt - now);
            const mm = String(Math.floor(remaining / 60000)).padStart(2, '0');
            const ss = String(Math.floor((remaining % 60000) / 1000)).padStart(2, '0');
            countdownEl.textContent = mm + ':' + ss;
            if (remaining <= 0) {
                clearInterval(timer);
                countdownEl.textContent = '00:00';
            }
        }
        updateCountdown();
        const timer = setInterval(updateCountdown, 1000);
    })();
</script>
</body>
</html>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán thành công | VSTEP</title>
    <link rel="stylesheet" href="https://fonts.cdnfonts.com/css/sf-pro-display">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-slate-50">
<div class="max-w-xl mx-auto px-4 py-12">
    <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8 text-center space-y-4">
        <div class="mx-auto h-14 w-14 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/>
            </svg>
        </div>
        <h1 class="text-2xl font-bold text-slate-900">Thanh toán thành công</h1>
        <p class="text-sm text-slate-500">Đăng ký của bạn đã được duyệt.</p>

        <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 p-4 text-left space-y-1">
            <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold">Mã đăng ký</p>
            <p class="text-sm font-semibold"><c:out value="${dangKy != null ? dangKy.maXacNhan : ''}" /></p>
            <c:if test="${lopOn != null}">
                <p class="text-xs uppercase tracking-widest text-slate-500 font-semibold mt-3">Lớp</p>
                <p class="text-sm font-semibold"><c:out value="${lopOn.maLop}" /> · <c:out value="${lopOn.tieuDe}" /></p>
            </c:if>
        </div>

        <a href="${pageContext.request.contextPath}/user/dashboard"
           class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
            Về trang cá nhân
        </a>
    </div>
</div>
</body>
</html>



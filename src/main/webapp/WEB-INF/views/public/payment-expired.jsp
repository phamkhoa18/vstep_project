<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR đã hết hạn | VSTEP</title>
    <link rel="stylesheet" href="https://fonts.cdnfonts.com/css/sf-pro-display">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-slate-50">
<div class="max-w-xl mx-auto px-4 py-12">
    <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8 text-center space-y-4">
        <div class="mx-auto h-14 w-14 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01M12 5a7 7 0 100 14 7 7 0 000-14z"/>
            </svg>
        </div>
        <h1 class="text-2xl font-bold text-slate-900">QR đã hết hạn</h1>
        <p class="text-sm text-slate-500">Vui lòng quay lại trang thanh toán để tạo mã mới và thử lại.</p>
        <a href="${pageContext.request.contextPath}/"
           class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
            Về trang chủ
        </a>
    </div>
</div>
</body>
</html>



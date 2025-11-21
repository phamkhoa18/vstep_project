<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản lý Ôn & Thi VSTEP</title>
    <%@ include file="WEB-INF/views/layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">

<%@ include file="WEB-INF/views/layout/public-header.jspf" %>

<!-- Hero Section -->
<section class="pt-32 pb-20 bg-gradient-to-r from-blue-700 to-blue-500 text-white text-center relative overflow-hidden">
    <div class="absolute inset-0 opacity-20 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
    <div class="relative max-w-4xl mx-auto px-6">
        <h2 class="text-5xl md:text-6xl font-extrabold mb-6 tracking-tight leading-tight">
            Hệ thống Quản lý Ôn & Thi VSTEP
        </h2>
        <p class="text-lg md:text-xl mb-8 opacity-90">
            Đăng ký lớp ôn luyện và ca thi VSTEP nhanh chóng, tiện lợi, tự động hóa toàn diện.
        </p>
        <div class="space-x-4">
            <a href="<%= request.getContextPath() %>/lop"
               class="bg-yellow-400 hover:bg-yellow-500 text-black font-semibold px-8 py-3 rounded-full transition-all shadow-lg">
                Xem lớp ôn
            </a>
            <a href="<%= request.getContextPath() %>/lop"
               class="bg-white hover:bg-gray-100 text-blue-700 font-semibold px-8 py-3 rounded-full transition-all shadow-lg">
                Xem ca thi
            </a>
        </div>
    </div>
</section>

<!-- Giới thiệu -->
<section class="py-20 max-w-6xl mx-auto px-6">
    <h3 class="text-3xl md:text-4xl font-bold text-center mb-12 text-gray-800">Tại sao nên chọn hệ thống VSTEP?</h3>
    <div class="grid md:grid-cols-3 gap-10">
        <div class="bg-white p-8 rounded-3xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" alt="class" class="w-16 mx-auto mb-4">
            <h4 class="text-xl font-semibold text-center mb-3 text-blue-700">Đa dạng lớp ôn</h4>
            <p class="text-gray-600 text-center">Lựa chọn lớp học Online/Offline, Thường hoặc Cấp tốc phù hợp thời gian cá nhân.</p>
        </div>

        <div class="bg-white p-8 rounded-3xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
            <img src="https://cdn-icons-png.flaticon.com/512/3106/3106773.png" alt="exam" class="w-16 mx-auto mb-4">
            <h4 class="text-xl font-semibold text-center mb-3 text-blue-700">Đăng ký thi dễ dàng</h4>
            <p class="text-gray-600 text-center">Chọn ca thi linh hoạt, áp dụng giảm giá tự động cho thí sinh thi lại.</p>
        </div>

        <div class="bg-white p-8 rounded-3xl shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1">
            <img src="https://cdn-icons-png.flaticon.com/512/889/889199.png" alt="email" class="w-16 mx-auto mb-4">
            <h4 class="text-xl font-semibold text-center mb-3 text-blue-700">Tự động & Thống kê</h4>
            <p class="text-gray-600 text-center">Xác nhận qua email và thống kê học viên, doanh thu theo thời gian thực.</p>
        </div>
    </div>
</section>

<!-- Thống kê -->
<section class="bg-blue-50 py-20">
    <div class="max-w-6xl mx-auto px-6">
        <h3 class="text-3xl md:text-4xl font-bold text-center mb-14 text-gray-800">Thống kê hệ thống</h3>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
            <div class="bg-white p-8 rounded-2xl shadow hover:scale-105 transition">
                <p class="text-4xl font-bold text-blue-600">120+</p>
                <p class="text-gray-700 mt-2">Lớp ôn luyện</p>
            </div>
            <div class="bg-white p-8 rounded-2xl shadow hover:scale-105 transition">
                <p class="text-4xl font-bold text-blue-600">3,000+</p>
                <p class="text-gray-700 mt-2">Thí sinh đăng ký</p>
            </div>
            <div class="bg-white p-8 rounded-2xl shadow hover:scale-105 transition">
                <p class="text-4xl font-bold text-blue-600">98%</p>
                <p class="text-gray-700 mt-2">Hài lòng người dùng</p>
            </div>
            <div class="bg-white p-8 rounded-2xl shadow hover:scale-105 transition">
                <p class="text-4xl font-bold text-blue-600">100%</p>
                <p class="text-gray-700 mt-2">Tự động hóa</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA -->
<section class="py-20 bg-gradient-to-r from-blue-600 to-blue-800 text-white text-center">
    <h3 class="text-3xl md:text-4xl font-bold mb-6">Sẵn sàng bắt đầu hành trình VSTEP?</h3>
    <p class="mb-8 text-lg opacity-90">Tham gia ngay hôm nay để luyện tập hiệu quả và đạt chứng chỉ cao nhất!</p>
    <a href="<%= request.getContextPath() %>/login"
       class="bg-yellow-400 hover:bg-yellow-500 text-black font-semibold px-10 py-4 rounded-full transition shadow-lg">
        Đăng nhập ngay
    </a>
</section>

<%@ include file="WEB-INF/views/layout/public-footer.jspf" %>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 | Trang không tồn tại - VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">

<%@ include file="../layout/public-header.jspf" %>

<!-- 404 Section -->
<section class="min-h-[80vh] flex flex-col items-center justify-center text-center relative overflow-hidden bg-gradient-to-r from-blue-700 to-blue-500 text-white">
    <div class="absolute inset-0 opacity-10 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>

    <div class="relative z-10 px-6">
        <h1 class="text-[6rem] md:text-[8rem] font-bold leading-none mb-4">404</h1>
        <h2 class="text-3xl md:text-4xl font-semibold mb-4">Rất tiếc! Trang bạn tìm không tồn tại.</h2>
        <p class="text-lg md:text-xl opacity-90 mb-10 max-w-2xl mx-auto">
            Có thể liên kết đã bị hỏng hoặc trang này đã bị xóa.
            Hãy quay lại trang chủ hoặc khám phá các lớp ôn và ca thi khác.
        </p>
    </div>

</section>

<!-- CTA -->
<section class="py-20 bg-blue-50 text-center">
    <h3 class="text-2xl md:text-3xl font-bold mb-6 text-gray-800">Vẫn chưa tìm được điều bạn cần?</h3>
    <p class="text-gray-600 mb-8 max-w-xl mx-auto">
        Hãy quay về trang chủ để bắt đầu lại hoặc liên hệ đội ngũ hỗ trợ của chúng tôi để được giúp đỡ nhanh nhất.
    </p>
    <a href="${pageContext.request.contextPath}/contact.jsp"
       class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-10 py-4 rounded-full transition-all shadow-lg">
        Liên hệ hỗ trợ
    </a>
</section>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

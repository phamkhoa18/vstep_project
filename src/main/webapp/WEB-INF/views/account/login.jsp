<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - VSTEP System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://fonts.cdnfonts.com/css/sf-pro-display">
    <script src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        .glass { background: rgba(255,255,255,0.7); backdrop-filter: blur(12px); }
    </style>
</head>
<body class="bg-gradient-to-b from-gray-50 to-white flex items-center justify-center min-h-screen">

<div class="w-full max-w-md p-8 glass rounded-3xl shadow-xl">
    <h2 class="text-3xl font-bold text-blue-700 text-center mb-6">Đăng nhập VSTEP</h2>

    <form action="NguoiDungServlet" method="post" class="space-y-5">
        <input type="hidden" name="action" value="login">
        <div>
            <label for="email" class="block text-gray-700 font-medium mb-1">Email</label>
            <input type="email" id="email" name="email" placeholder="example@vstep.edu.vn"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition" required>
        </div>
        <div>
            <label for="password" class="block text-gray-700 font-medium mb-1">Mật khẩu</label>
            <input type="password" id="password" name="password" placeholder="••••••••"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition" required>
        </div>
        <button type="submit"
                class="w-full bg-blue-700 hover:bg-blue-800 text-white font-semibold py-3 rounded-full shadow-lg transition">
            Đăng nhập
        </button>
    </form>

    <p class="text-center text-gray-600 mt-5">Chưa có tài khoản?
        <a href="register" class="text-blue-700 font-medium hover:underline">Đăng ký ngay</a>
    </p>
</div>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const params = new URLSearchParams(window.location.search);
        let message = '', type = '';

        if(params.get('success') === 'register') {
            message = 'Đăng ký thành công! Vui lòng đăng nhập.';
            type = 'success';
        } else if(params.get('error')) {
            type = 'error';
            switch(params.get('error')) {
                case 'invalid': message = 'Email hoặc mật khẩu không đúng!'; break;
                case 'server': message = 'Có lỗi xảy ra! Vui lòng thử lại.'; break;
            }
        }

        if(message) {
            Swal.fire({
                icon: type,
                title: type === 'success' ? 'Thành công!' : 'Lỗi!',
                text: message,
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 4000,
                timerProgressBar: true,
                customClass: {
                    popup: 'rounded-2xl shadow-lg'
                }
            });
        }
    });
</script>

</body>
</html>

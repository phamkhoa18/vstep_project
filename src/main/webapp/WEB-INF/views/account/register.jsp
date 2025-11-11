<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - VSTEP System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://fonts.cdnfonts.com/css/sf-pro-display">
    <style>
        body { font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; }
        .glass { background: rgba(255,255,255,0.7); backdrop-filter: blur(14px); }
        .toast {
            position: fixed; top: 1.5rem; right: 1.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 0.75rem;
            font-weight: 500; font-size: 0.875rem;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            opacity: 0; transform: translateY(-20px);
            transition: all 0.4s ease;
            display: flex; align-items: center; gap: 0.5rem;
        }
        .toast.show { opacity: 1; transform: translateY(0); }
        .toast-success { background-color: #22c55e; color: white; }
        .toast-error { background-color: #ef4444; color: white; }
    </style>
</head>
<body class="bg-gradient-to-b from-gray-50 to-white flex items-center justify-center min-h-screen px-4">

<!-- Toast -->
<div id="toast" class="toast"></div>

<div class="w-full max-w-md p-8 glass rounded-3xl shadow-2xl">
    <h2 class="text-3xl font-bold text-blue-700 text-center mb-6 tracking-wide">Đăng ký VSTEP</h2>

    <!-- Form gửi đến servlet /register -->
    <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-5">
        <div>
            <label for="fullname" class="block text-gray-700 font-medium mb-1">Họ và tên</label>
            <input type="text" id="fullname" name="fullname" placeholder="Nguyễn Văn A"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition duration-200" required>
        </div>

        <div>
            <label for="email" class="block text-gray-700 font-medium mb-1">Email</label>
            <input type="email" id="email" name="email" placeholder="example@vstep.edu.vn"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition duration-200" required>
        </div>

        <div>
            <label for="password" class="block text-gray-700 font-medium mb-1">Mật khẩu</label>
            <input type="password" id="password" name="password" placeholder="••••••••"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition duration-200" required>
        </div>

        <div>
            <label for="confirm_password" class="block text-gray-700 font-medium mb-1">Xác nhận mật khẩu</label>
            <input type="password" id="confirm_password" name="confirm_password" placeholder="••••••••"
                   class="w-full px-4 py-3 rounded-xl border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none transition duration-200" required>
        </div>

        <button type="submit"
                class="w-full bg-yellow-400 hover:bg-yellow-500 text-black font-semibold py-3 rounded-full shadow-lg transition duration-300 hover:shadow-xl">
            Đăng ký
        </button>
    </form>

    <p class="text-center text-gray-600 mt-5 text-sm">Đã có tài khoản?
        <a href="${pageContext.request.contextPath}/login" class="text-blue-700 font-medium hover:underline">Đăng nhập</a>
    </p>
</div>

<!-- Hiển thị toast sau redirect -->
<script>
    const params = new URLSearchParams(window.location.search);
    const toast = document.getElementById("toast");
    let message = '', type = '';

    if(params.get('success') === 'register') {
        message = '✅ Đăng ký thành công! Vui lòng đăng nhập.';
        type = 'success';
    } else if(params.get('error')) {
        type = 'error';
        switch(params.get('error')) {
            case 'confirm': message = '❌ Mật khẩu không khớp!'; break;
            case 'exists': message = '❌ Email đã tồn tại!'; break;
            case 'server': message = '⚠️ Có lỗi xảy ra! Vui lòng thử lại.'; break;
        }
    }

    if(message) {
        toast.textContent = message;
        toast.classList.add(type === 'success' ? 'toast-success' : 'toast-error', 'show');
        setTimeout(() => toast.classList.remove('show'), 4000);
    }
</script>

</body>
</html>

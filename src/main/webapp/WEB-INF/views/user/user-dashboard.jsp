<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vstep.model.NguoiDung" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
    String displayName = user != null && user.getHoTen() != null && !user.getHoTen().isEmpty()
            ? user.getHoTen()
            : "Học viên VSTEP";
    String email = user != null && user.getEmail() != null ? user.getEmail() : "";
    String phone = user != null && user.getSoDienThoai() != null ? user.getSoDienThoai() : "";
    String donVi = user != null && user.getDonVi() != null ? user.getDonVi() : "";
    String ngayTaoStr = "";
    if (user != null && user.getNgayTao() != null) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        ngayTaoStr = sdf.format(user.getNgayTao());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pb-24">
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-14 pt-24">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-4">
                    <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em]">
                        Hồ sơ học viên
                    </span>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        Xin chào, <span class="text-yellow-300"><%= displayName %></span>
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed max-w-2xl">
                        Cập nhật thông tin cá nhân, chi tiết liên hệ và bảo mật để việc đăng ký lớp và ca thi diễn ra suôn sẻ.
                        Mọi thay đổi sẽ được lưu ngay lập tức và áp dụng trên toàn hệ thống.
                    </p>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-6 py-6 shadow-soft text-slate-700 bg-white/90 w-full max-w-sm space-y-4">
                    <div class="flex items-center gap-4">
                        <div class="flex h-16 w-16 items-center justify-center rounded-full bg-primary/10 text-primary font-semibold text-lg uppercase">
                            <%= displayName.substring(0, Math.min(2, displayName.length())).toUpperCase() %>
                        </div>
                        <div>
                            <p class="text-sm font-semibold text-slate-900 uppercase tracking-widest">Tài khoản</p>
                            <p class="text-sm text-slate-600"><%= email.isEmpty() ? "Chưa cập nhật email" : email %></p>
                        </div>
                    </div>
                    <div class="grid gap-3 text-xs text-slate-600">
                        <div class="flex items-center justify-between">
                            <span>Trạng thái kích hoạt</span>
                            <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                Đã kích hoạt
                            </span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span>Ngày tham gia</span>
                            <span class="font-semibold text-slate-800"><%= ngayTaoStr.isEmpty() ? "Chưa có" : ngayTaoStr %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="max-w-6xl mx-auto px-6 mt-12 space-y-10">
        <div class="grid gap-8 lg:grid-cols-[1fr,2fr]">
            <aside class="space-y-4">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tổng quan</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="#personal" class="flex items-center justify-between rounded-2xl bg-primary/10 px-4 py-3 font-semibold text-primary">
                            Thông tin cá nhân
                            <span>→</span>
                        </a>
                        <a href="#contact" class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition">
                            Liên hệ & địa chỉ
                            <span>→</span>
                        </a>
                        <a href="#security" class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition">
                            Bảo mật tài khoản
                            <span>→</span>
                        </a>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Liên kết nhanh</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/lop-da-dang-ky" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lớp đã đăng ký
                        </a>
                        <a href="<%= request.getContextPath() %>/ca-da-dang-ky" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Ca thi đã đăng ký
                        </a>
                        <a href="<%= request.getContextPath() %>/dang-xuat" class="inline-flex items-center gap-2 rounded-full border border-red-100 bg-white px-5 py-2.5 text-xs font-semibold text-red-600 hover:bg-red-50 transition">
                            Đăng xuất
                        </a>
                    </div>
                </div>
                
                <!-- Danh sách hóa đơn -->
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <c:if test="${not empty hoaDonList}">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hóa đơn gần đây</p>
                    <div class="space-y-2 max-h-64 overflow-y-auto">
                        <c:forEach var="hoaDon" items="${hoaDonList}" begin="0" end="4">
                            <a href="<%= request.getContextPath() %>/invoice/${hoaDon.id}" target="_blank"
                               class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3 hover:bg-blue-50 transition group">
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-900 truncate">
                                        <c:out value="${hoaDon.soHoaDon}" />
                                    </p>
                                    <p class="text-[10px] text-slate-500 mt-1">
                                        <c:choose>
                                            <c:when test="${hoaDon.loai == 'lop_on'}">Lớp ôn</c:when>
                                            <c:when test="${hoaDon.loai == 'ca_thi'}">Ca thi</c:when>
                                            <c:otherwise><c:out value="${hoaDon.loai}" /></c:otherwise>
                                        </c:choose>
                                        <c:if test="${not empty hoaDon.ngayTao}">
                                            · <fmt:formatDate value="${hoaDon.ngayTao}" pattern="dd/MM/yyyy" />
                                        </c:if>
                                    </p>
                                </div>
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-slate-400 group-hover:text-primary transition flex-shrink-0 ml-2" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                                </svg>
                            </a>
                        </c:forEach>
                    </div>
                    <c:if test="${hoaDonList.size() > 5}">
                        <a href="#invoices" class="text-xs font-semibold text-primary hover:text-primary/80 transition text-center block">
                            Xem tất cả (${hoaDonList.size()})
                        </a>
                    </c:if>
                </div>
                </c:if>
            </aside>

            <section class="space-y-10">
                <!-- Form cập nhật thông tin cá nhân -->
                <form id="profile-form" action="<%= request.getContextPath() %>/profile/update" method="post" class="space-y-10">
                    <input type="hidden" name="action" value="update-profile">
                    
                    <div id="personal" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Thông tin cá nhân</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Chỉnh sửa dữ liệu cơ bản</h2>
                            <p class="mt-2 text-sm text-slate-500">Tên sẽ xuất hiện trên biên lai, chứng chỉ và thông báo hệ thống.</p>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Họ và tên <span class="text-red-500">*</span></label>
                                <input type="text" name="hoTen" value="<%= displayName %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Nguyễn Văn A" required>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đơn vị</label>
                                <input type="text" name="donVi" value="<%= donVi %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="Ví dụ: Trường ĐH Sư phạm Kỹ thuật">
                            </div>
                        </div>
                    </div>

                    <div id="contact" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Liên hệ</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Đảm bảo thông tin liên lạc chính xác</h2>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Email <span class="text-red-500">*</span></label>
                                <input type="email" name="email" value="<%= email %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="email@domain.com" required>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số điện thoại</label>
                                <input type="tel" name="soDienThoai" value="<%= phone %>"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="09xx xxx xxx">
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-wrap items-center gap-3">
                        <button type="submit" class="inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Lưu thông tin
                        </button>
                        <button type="reset" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-6 py-3 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Hoàn tác
                        </button>
                    </div>
                </form>

                <!-- Form đổi mật khẩu -->
                <form id="password-form" action="<%= request.getContextPath() %>/profile/update" method="post" class="space-y-10">
                    <input type="hidden" name="action" value="change-password">
                    
                    <div id="security" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Bảo mật tài khoản</p>
                            <h2 class="mt-2 text-2xl font-semibold text-slate-900">Đổi mật khẩu</h2>
                            <p class="mt-2 text-sm text-slate-500">Nên đặt mật khẩu ít nhất 6 ký tự để bảo mật tài khoản.</p>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mật khẩu hiện tại <span class="text-red-500">*</span></label>
                                <input type="password" name="currentPassword" id="currentPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••" required>
                            </div>
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mật khẩu mới <span class="text-red-500">*</span></label>
                                <input type="password" name="newPassword" id="newPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••" minlength="6" required>
                            </div>
                        </div>
                        <div class="grid gap-6 md:grid-cols-2">
                            <div>
                                <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Xác nhận mật khẩu <span class="text-red-500">*</span></label>
                                <input type="password" name="confirmPassword" id="confirmPassword"
                                       class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"
                                       placeholder="••••••••" minlength="6" required>
                            </div>
                            <div class="flex items-end">
                                <button type="submit" class="inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                    Đổi mật khẩu
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
                
                <!-- Danh sách hóa đơn -->
                <c:if test="${not empty hoaDonList}">
                <div id="invoices" class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                    <div>
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hóa đơn</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-900">Danh sách hóa đơn</h2>
                        <p class="mt-2 text-sm text-slate-500">Xem và tải xuống các hóa đơn đã được tạo.</p>
                    </div>
                    <div class="space-y-3">
                        <c:forEach var="hoaDon" items="${hoaDonList}">
                            <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-5 py-4 hover:bg-blue-50 transition">
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center gap-3 mb-2">
                                        <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">
                                            <c:out value="${hoaDon.soHoaDon}" />
                                        </span>
                                        <span class="inline-flex items-center gap-1 rounded-full px-2 py-1 text-[11px] font-semibold 
                                            <c:choose>
                                                <c:when test="${hoaDon.loai == 'lop_on'}">bg-blue-100 text-blue-600</c:when>
                                                <c:when test="${hoaDon.loai == 'ca_thi'}">bg-emerald-100 text-emerald-600</c:when>
                                                <c:otherwise>bg-slate-100 text-slate-600</c:otherwise>
                                            </c:choose>">
                                            <c:choose>
                                                <c:when test="${hoaDon.loai == 'lop_on'}">Lớp ôn</c:when>
                                                <c:when test="${hoaDon.loai == 'ca_thi'}">Ca thi</c:when>
                                                <c:otherwise><c:out value="${hoaDon.loai}" /></c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <p class="text-xs text-slate-500">
                                        <c:if test="${not empty hoaDon.ngayTao}">
                                            <fmt:formatDate value="${hoaDon.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
                                        </c:if>
                                    </p>
                                </div>
                                <a href="<%= request.getContextPath() %>/invoice/${hoaDon.id}" target="_blank"
                                   class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition ml-4">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                                    </svg>
                                    Xem PDF
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                </c:if>
            </section>
        </div>
    </section>
</main>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        // Kiểm tra SweetAlert2 đã được load
        if (typeof Swal === 'undefined') {
            console.error('SweetAlert2 chưa được load!');
        }

        // Xử lý flash messages
        <%
            String profileFlashType = (String) session.getAttribute("profileFlashType");
            String profileFlashMessage = (String) session.getAttribute("profileFlashMessage");
            if (profileFlashType != null && profileFlashMessage != null) {
                // Xóa flash message sau khi hiển thị
                session.removeAttribute("profileFlashType");
                session.removeAttribute("profileFlashMessage");
        %>
            const flashType = '<%= profileFlashType %>';
            const flashMessage = '<%= profileFlashMessage.replace("'", "\\'") %>';
            const icon = flashType === 'success' ? 'success' : flashType === 'error' ? 'error' : 'info';
            
            if (typeof Swal !== 'undefined') {
                Swal.fire({
                    icon: icon,
                    title: flashType === 'success' ? 'Thành công!' : flashType === 'error' ? 'Lỗi!' : 'Thông báo',
                    text: flashMessage,
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 4000,
                    timerProgressBar: true,
                    customClass: {
                        popup: 'rounded-2xl shadow-lg'
                    }
                });
            } else {
                alert(flashMessage);
            }
        <%
            }
        %>

        // Xử lý form đổi mật khẩu - validate trước khi submit
        const passwordForm = document.getElementById('password-form');
        if (passwordForm) {
            passwordForm.addEventListener('submit', (event) => {
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                if (newPassword !== confirmPassword) {
                    event.preventDefault();
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: 'Mật khẩu mới và xác nhận mật khẩu không khớp.',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            customClass: {
                                popup: 'rounded-2xl shadow-lg'
                            }
                        });
                    } else {
                        alert('Mật khẩu mới và xác nhận mật khẩu không khớp.');
                    }
                    return false;
                }

                if (newPassword.length < 6) {
                    event.preventDefault();
                    if (typeof Swal !== 'undefined') {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: 'Mật khẩu mới phải có ít nhất 6 ký tự.',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 3000,
                            customClass: {
                                popup: 'rounded-2xl shadow-lg'
                            }
                        });
                    } else {
                        alert('Mật khẩu mới phải có ít nhất 6 ký tự.');
                    }
                    return false;
                }
            });
        }
    });
</script>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

</html>

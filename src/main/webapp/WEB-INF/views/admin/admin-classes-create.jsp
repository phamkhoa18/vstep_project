<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo lớp ôn | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="classes" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>

<div class="admin-layout">
    <%@ include file="layout/admin-sidebar.jspf" %>
    <div class="admin-main-wrapper">
        <main class="space-y-10 pb-16">
            <section class="space-y-4">
                <div class="flex items-center gap-4">
                    <a href="<c:url value='/admin/classes' />"
                       class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                        ←
                    </a>
                    <div>
                        <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Tạo lớp ôn mới</h2>
                        <p class="text-sm text-slate-500 mt-1">Điền đầy đủ thông tin để khởi tạo lớp ôn trong hệ thống.</p>
                    </div>
                </div>
                <div class="rounded-3xl bg-primary.pale/50 border border-blue-50 px-6 py-4 text-sm text-slate-600">
                    Thông tin lớp ôn sau khi tạo sẽ hiển thị ngay trong bảng quản lý. Bạn có thể chỉnh sửa lại bất cứ lúc nào.
                </div>
            </section>

            <section class="rounded-3xl bg-white shadow-soft border border-blue-50 p-8">
                <form method="post" action="<c:url value='/admin/lop-on' />" class="space-y-8">
                    <input type="hidden" name="action" value="create">

                    <div class="grid gap-6 md:grid-cols-2">
                        <div>
                            <label for="create-title" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                                Tên lớp <span class="text-rose-500">*</span>
                            </label>
                            <input id="create-title" name="tieuDe" type="text" required
                                   placeholder="Ví dụ: NE3 - Giao tiếp nâng cao"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-status" class="text-xs font-semibold uppercase tracking-widest text-slate-500">
                                Tình trạng <span class="text-rose-500">*</span>
                            </label>
                            <select id="create-status" name="tinhTrang" required
                                    class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                                <option value="">Chọn tình trạng</option>
                                <option value="Đang mở">Đang mở</option>
                                <option value="Sắp mở">Sắp mở</option>
                                <option value="Đã kết thúc">Đã kết thúc</option>
                            </select>
                        </div>
                        <div>
                            <label for="create-format" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hình thức</label>
                            <input id="create-format" name="hinhThuc" type="text"
                                   placeholder="Ví dụ: Offline · Online · Hybrid"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-pace" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nhịp độ / Lịch học</label>
                            <input id="create-pace" name="nhipDo" type="text"
                                   placeholder="Ví dụ: Thứ 3 · 5 · 18:00 - 20:00"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-start" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ngày khai giảng</label>
                            <input id="create-start" name="ngayKhaiGiang" type="date"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-deadline" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hạn đăng ký</label>
                            <input id="create-deadline" name="ngayHetHanDangKy" type="date"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-sessions" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Số buổi</label>
                            <input id="create-sessions" name="soBuoi" type="number" min="1" step="1"
                                   placeholder="Ví dụ: 20"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-duration" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giờ mỗi buổi</label>
                            <input id="create-duration" name="gioMoiBuoi" type="number" min="0.5" step="0.5"
                                   placeholder="Ví dụ: 2"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-fee" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Học phí (VND)</label>
                            <input id="create-fee" name="hocPhi" type="number" min="0" step="50000"
                                   placeholder="Ví dụ: 4500000"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                        <div>
                            <label for="create-capacity" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Sĩ số tối đa</label>
                            <input id="create-capacity" name="siSoToiDa" type="number" min="5" step="1"
                                   placeholder="Ví dụ: 36"
                                   class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30">
                        </div>
                    </div>

                    <div>
                        <label for="create-description" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Mô tả ngắn</label>
                        <textarea id="create-description" name="moTaNgan" rows="4"
                                  placeholder="Nhập mô tả nổi bật để hiển thị trong danh sách lớp."
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
                    </div>
                <div>
                    <label for="create-content-editor" class="text-xs font-semibold uppercase tracking-widest text-slate-500">Nội dung chi tiết</label>
                    <textarea id="create-content-editor" name="noiDungChiTiet" rows="8"
                              placeholder="Soạn nội dung chi tiết cho lớp ôn. Bạn có thể chèn hình ảnh, định dạng văn bản bằng CKEditor."
                              class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-700 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
                </div>

                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                        <p class="text-xs text-slate-500">
                            Kiểm tra kỹ thông tin trước khi lưu. Bạn có thể chỉnh sửa lại trong trang danh sách lớp.
                        </p>
                        <div class="flex items-center gap-3">
                            <a href="<c:url value='/admin/classes' />"
                               class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                Huỷ
                            </a>
                            <button type="submit"
                                    class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Tạo lớp
                            </button>
                        </div>
                    </div>
                </form>
            </section>
        </main>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>
<script src="https://cdn.ckeditor.com/4.25.1-lts/standard/ckeditor.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', () => {
        CKEDITOR.replace('create-content-editor', {
            height: 360,
            filebrowserUploadUrl: '<c:url value="/admin/upload-ckeditor" />',
            filebrowserUploadMethod: 'form'
        });
    });
</script>
</body>
</html>


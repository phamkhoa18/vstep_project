<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cấu hình ưu đãi | VSTEP Admin</title>
    <%@ include file="layout/admin-theme.jspf" %>
</head>
<body data-page="config" class="admin-shell">
<%@ include file="layout/admin-header.jspf" %>
<%@ include file="layout/admin-sidebar.jspf" %>

<div class="pt-[90px] lg:pl-[14rem]">
    <main class="max-w-[1200px] mx-auto px-4 sm:px-6 lg:px-10 pb-16 space-y-10">
        <section class="space-y-4">
            <div class="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h2 class="text-3xl font-bold text-slate-900 tracking-tight">Cấu hình ưu đãi thi lại</h2>
                    <p class="text-sm text-slate-500 mt-1">Thiết lập mức giảm giá theo số lần thi và thời gian quay lại.</p>
                </div>
                <div class="flex flex-wrap items-center gap-3">
                    <button data-modal-target="history-modal"
                            class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-primary shadow-sm hover:border-primary/40 hover:bg-primary/5 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M3 12a9 9 0 1 1 9 9"/>
                            <path d="M9 12h6"/>
                            <path d="M12 9v6"/>
                        </svg>
                        Lịch sử cấu hình
                    </button>
                    <button data-modal-target="publish-modal"
                            class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none"
                             viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.8">
                            <path d="M5 12h14"/>
                            <path d="M12 5l7 7-7 7"/>
                        </svg>
                        Áp dụng cấu hình
                    </button>
                </div>
            </div>
            <div class="flex flex-wrap gap-3 text-xs text-slate-500">
                <span class="inline-flex items-center gap-2 rounded-full bg-primary.pale px-3 py-1 text-primary">
                    Phiên bản hiện tại v2.1.0 · cập nhật 09/11/2025 · 10:15
                </span>
                <span class="inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 border border-blue-100 text-slate-500">
                    Ngân sách ưu đãi còn 42 triệu (68% hạn mức)
                </span>
            </div>
        </section>

        <section class="grid gap-6 xl:grid-cols-3">
            <div class="xl:col-span-2 space-y-6">
                <form class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <div>
                        <h3 class="text-lg font-semibold text-slate-900">Thiết lập mức giảm</h3>
                        <p class="text-xs text-slate-500 mt-1">Đặt ưu đãi theo mốc thời gian và số lần thi lại.</p>
                    </div>
                    <div class="grid gap-6 md:grid-cols-2">
                        <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-5 space-y-4 shadow-sm">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Thi lại lần đầu</p>
                                <span class="text-xs font-semibold text-primary">Trong 30 ngày</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <input type="range" min="0" max="50" value="30" class="w-full accent-primary">
                                <div class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-sm font-semibold text-slate-700">
                                    <input type="number" min="0" max="50" value="30"
                                           class="w-12 border-none text-right focus:outline-none">%
                                </div>
                            </div>
                            <p class="text-xs text-slate-500">Áp dụng trên lệ phí thi gốc · thêm voucher học liệu 200.000đ.</p>
                        </div>
                        <div class="rounded-2xl border border-blue-50 bg-white px-4 py-5 space-y-4 shadow-sm">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Thi lại lần thứ hai</p>
                                <span class="text-xs font-semibold text-primary">Trong 60 ngày</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <input type="range" min="0" max="40" value="20" class="w-full accent-primary">
                                <div class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-sm font-semibold text-slate-700">
                                    <input type="number" min="0" max="40" value="20"
                                           class="w-12 border-none text-right focus:outline-none">%
                                </div>
                            </div>
                            <p class="text-xs text-slate-500">Khuyến khích quay lại sớm · tặng gói hỗ trợ luyện đề.</p>
                        </div>
                        <div class="rounded-2xl border border-blue-50 bg-white px-4 py-5 space-y-4 shadow-sm">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Từ lần thứ ba</p>
                                <span class="text-xs font-semibold text-primary">Sau 60 ngày</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <input type="range" min="0" max="30" value="10" class="w-full accent-primary">
                                <div class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-sm font-semibold text-slate-700">
                                    <input type="number" min="0" max="30" value="10"
                                           class="w-12 border-none text-right focus:outline-none">%
                                </div>
                            </div>
                            <p class="text-xs text-slate-500">Khuyến nghị kèm gói học lại 1:1 với giảng viên.</p>
                        </div>
                        <div class="rounded-2xl border border-blue-50 bg-white px-4 py-5 space-y-4 shadow-sm">
                            <div class="flex items-center justify_between">
                                <p class="text-sm font-semibold text-slate-800">Ưu đãi học viên thân thiết</p>
                                <span class="text-xs font-semibold text-primary">Điểm tích lũy ≥ 500</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <input type="range" min="0" max="20" value="5" class="w-full accent-primary">
                                <div class="inline-flex items-center gap-1 rounded-xl border border-blue-100 bg-white px-3 py-2 text-sm font-semibold text-slate-700">
                                    <input type="number" min="0" max="20" value="5"
                                           class="w-12 border-none text-right focus:outline-none">%
                                </div>
                            </div>
                            <p class="text-xs text-slate-500">Cộng dồn tối đa 5% với các ưu đãi khác.</p>
                        </div>
                    </div>
                    <div>
                        <label class="text-xs font-semibold uppercase tracking-widest text-slate-500">Ghi chú nội bộ</label>
                        <textarea rows="3" placeholder="Ghi chú dành cho bộ phận tư vấn khi áp dụng ưu đãi..."
                                  class="mt-2 w-full rounded-2xl border border-blue-100 bg-white px-4 py-3 text-sm text-slate-600 focus:outline-none focus:ring-2 focus:ring-primary/30"></textarea>
                    </div>
                    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3">
                        <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                            <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                            Tự động gửi thông báo cập nhật tới bộ phận tư vấn
                        </label>
                        <div class="flex items-center gap-3">
                            <button type="reset"
                                    class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                                Khôi phục mặc định
                            </button>
                            <button type="submit"
                                    class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                                Lưu nháp
                            </button>
                        </div>
                    </div>
                </form>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-6">
                    <div class="flex items-center justify-between">
                        <h3 class="text-lg font-semibold text-slate-900">Điều kiện áp dụng</h3>
                        <button class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            + Thêm điều kiện
                        </button>
                    </div>
                    <div class="grid gap-4 md:grid-cols-2">
                        <article class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 shadow-sm space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Điều kiện 01</p>
                                <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 text-xs font-semibold text-primary">Bắt buộc</span>
                            </div>
                            <p class="text-xs text-slate-500">Áp dụng cho học viên thi lại cùng kỹ năng trong vòng 30 ngày kể từ ngày xuất kết quả.</p>
                        </article>
                        <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Điều kiện 02</p>
                                <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-500">Tùy chọn</span>
                            </div>
                            <p class="text-xs text-slate-500">Học viên cam kết hoàn thành tối thiểu 6 buổi ôn trước kỳ thi lại.</p>
                        </article>
                        <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Điều kiện 03</p>
                                <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-500">Kiểm soát</span>
                            </div>
                            <p class="text-xs text-slate-500">Không áp dụng đồng thời với ưu đãi đối tác hoặc mã giảm giá Corporate.</p>
                        </article>
                        <article class="rounded-2xl border border-blue-50 bg-white px-4 py-4 shadow-sm space-y-2">
                            <div class="flex items-center justify-between">
                                <p class="text-sm font-semibold text-slate-800">Điều kiện 04</p>
                                <span class="inline-flex items-center gap-2 rounded-full bg-blue-100 px-3 py-1 text-xs font-semibold text-primary">Khuyến nghị</span>
                            </div>
                            <p class="text-xs text-slate-500">Khuyến khích đăng ký gói ôn luyện kèm để duy trì ưu đãi ở mức cao nhất.</p>
                        </article>
                    </div>
                </div>
            </div>

            <aside class="space-y-6">
                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-4">
                    <h3 class="text-lg font-semibold text-slate-900">Thông báo xem trước</h3>
                    <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 text-sm text-slate-600 space-y-3">
                        <p class="font-semibold text-slate-800">Ưu đãi thi lại trong 30 ngày</p>
                        <p>Hoàn lại kỳ thi VSTEP với mức ưu đãi <span class="font-semibold text-primary">30%</span> khi đăng ký thi lại trong vòng 30 ngày kể từ ngày nhận kết quả.</p>
                        <p>Học viên hoàn thành tối thiểu 6 buổi ôn sẽ được tặng voucher học liệu trị giá 200.000đ.</p>
                        <p class="text-xs text-slate-400">Áp dụng từ 10/11/2025 đến 10/01/2026.</p>
                    </div>
                    <button class="w-full inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                        Gửi email kiểm tra
                    </button>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-4">
                    <h3 class="text-lg font-semibold text-slate-900">Ảnh hưởng doanh thu</h3>
                    <div class="h-40 rounded-2xl border border-dashed border-blue-100 bg-primary.pale/40 flex items-center justify-center text-sm text-slate-400">
                        Biểu đồ dự báo doanh thu sẽ hiển thị tại đây.
                    </div>
                    <ul class="text-xs text-slate-500 space-y-2">
                        <li>• Dự kiến tăng 18% tỷ lệ quay lại thi trong 60 ngày.</li>
                        <li>• Ngân sách ưu đãi còn đủ cho 120 lượt thi lại.</li>
                        <li>• Đề xuất giảm giá lớp ôn đi kèm còn 15%.</li>
                    </ul>
                </div>

                <div class="rounded-3xl bg-white shadow-soft border border-blue-50 p-6 space-y-4">
                    <h3 class="text-lg font-semibold text-slate-900">Nhật ký thay đổi</h3>
                    <div class="space-y-3 text-xs text-slate-500">
                        <div>
                            <p class="text-sm font-semibold text-slate-800">09/11/2025 · 10:15</p>
                            <p>Nguyễn Thị Ánh chỉnh mức giảm lần đầu lên 30%.</p>
                        </div>
                        <div>
                            <p class="text-sm font-semibold text-slate-800">05/11/2025 · 14:28</p>
                            <p>Trần Minh Tâm thêm điều kiện hoàn thành 6 buổi ôn.</p>
                        </div>
                        <div>
                            <p class="text-sm font-semibold text-slate-800">28/10/2025 · 09:02</p>
                            <p>Hệ thống gia hạn áp dụng đến 10/01/2026.</p>
                        </div>
                    </div>
                    <button class="w-full inline-flex items-center justify-center gap-2 rounded-full border border-blue-100 bg-white px-4 py-3 text-sm font-semibold text-primary hover:bg-primary/5 transition">
                        Xem toàn bộ
                    </button>
                </div>
            </aside>
        </section>
    </main>
</div>

<!-- Publish modal -->
<div id="publish-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Áp dụng cấu hình ưu đãi</h3>
                <p class="text-xs text-slate-500 mt-1">Kiểm tra kỹ trước khi áp dụng cho toàn hệ thống.</p>
            </div>
            <button data-modal-close="publish-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6 text-sm text-slate-600">
            <div class="rounded-2xl border border-blue-50 bg-primary.pale/40 px-4 py-4 space-y-2">
                <p>• Thi lại lần đầu: <span class="font-semibold text-primary">30%</span> trong 30 ngày.</p>
                <p>• Thi lại lần hai: <span class="font-semibold text-primary">20%</span> trong 60 ngày.</p>
                <p>• Từ lần thứ ba: <span class="font-semibold text-primary">10%</span>.</p>
                <p>• Học viên thân thiết: <span class="font-semibold text-primary">+5%</span>.</p>
            </div>
            <div class="text-xs text-slate-500 space-y-2">
                <p>Việc áp dụng sẽ:</p>
                <p>• Cập nhật ưu đãi ngay lập tức cho các đăng ký mới.</p>
                <p>• Thông báo đến bộ phận tư vấn và kế toán qua email.</p>
                <p>• Lưu lại phiên bản trong lịch sử hệ thống.</p>
            </div>
            <label class="inline-flex items-center gap-3 text-xs text-slate-500">
                <input type="checkbox" class="h-4 w-4 rounded border-blue-100 text-primary focus:ring-primary/30">
                Tôi xác nhận đã kiểm tra và đồng ý áp dụng cấu hình.
            </label>
            <div class="flex items-center justify-end gap-3">
                <button data-modal-close="publish-modal"
                        class="rounded-full border border-blue-100 bg-white px-5 py-2.5 text-sm font-semibold text-slate-600 hover:text-primary transition">
                    Huỷ
                </button>
                <button class="rounded-full bg-primary px-5 py-2.5 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                    Áp dụng ngay
                </button>
            </div>
        </div>
    </div>
</div>

<!-- History modal -->
<div id="history-modal" class="fixed inset-0 z-40 hidden items-center justify-center bg-slate-900/30 backdrop-blur">
    <div class="max-w-3xl w-full mx-4 rounded-3xl bg-white shadow-2xl border border-blue-50 overflow-hidden">
        <div class="flex items-center justify-between px-6 py-5 border-b border-blue-50 bg-primary.pale/60">
            <div>
                <h3 class="text-xl font-semibold text-slate-900">Lịch sử cấu hình ưu đãi</h3>
                <p class="text-xs text-slate-500 mt-1">Theo dõi các lần chỉnh sửa gần đây.</p>
            </div>
            <button data-modal-close="history-modal"
                    class="h-10 w-10 rounded-full border border-blue-100 bg-white text-slate-500 hover:text-primary transition">
                ×
            </button>
        </div>
        <div class="px-6 py-6 space-y-6">
            <div class="overflow-hidden rounded-2xl border border-blue-50">
                <table class="min-w-full divide-y divide-blue-50 text-sm text-slate-600">
                    <thead class="bg-primary.pale/60 text-xs uppercase text-slate-500 tracking-widest">
                    <tr>
                        <th class="px-4 py-3 text-left font-semibold">Thời gian</th>
                        <th class="px-4 py-3 text-left font-semibold">Người chỉnh sửa</th>
                        <th class="px-4 py-3 text-left font-semibold">Thay đổi</th>
                        <th class="px-4 py-3 text-left font-semibold">Ghi chú</th>
                    </tr>
                    </thead>
                    <tbody class="divide-y divide-blue-50 bg-white">
                    <tr>
                        <td class="px-4 py-3">09/11/2025 · 10:15</td>
                        <td class="px-4 py-3">Nguyễn Thị Ánh</td>
                        <td class="px-4 py-3">Tăng giảm giá lần đầu lên 30%</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Theo đề xuất bộ phận tài chính</td>
                    </tr>
                    <tr>
                        <td class="px-4 py-3">05/11/2025 · 14:28</td>
                        <td class="px-4 py-3">Trần Minh Tâm</td>
                        <td class="px-4 py-3">Thêm điều kiện hoàn thành 6 buổi ôn</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Giảm rủi ro học viên bỏ dở</td>
                    </tr>
                    <tr>
                        <td class="px-4 py-3">28/10/2025 · 09:02</td>
                        <td class="px-4 py-3">Hệ thống</td>
                        <td class="px-4 py-3">Gia hạn áp dụng đến 10/01/2026</td>
                        <td class="px-4 py-3 text-xs text-slate-400">Theo chính sách mới của trung tâm</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="flex items-center justify-between text-xs text-slate-500">
                <span>Hiển thị 1 – 3 trên 28 thay đổi</span>
                <button class="rounded-full border border-blue-100 bg-white px-4 py-2 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                    Tải xuống CSV
                </button>
            </div>
        </div>
    </div>
</div>

<%@ include file="layout/admin-scripts.jspf" %>
</body>
</html>


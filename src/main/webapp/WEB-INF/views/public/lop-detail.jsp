<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NE3 · Giao tiếp nâng cao | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main>
    <section class="relative overflow-hidden bg-gradient-to-r from-blue-700 via-blue-600 to-blue-500 text-white">
        <div class="absolute inset-0 opacity-30 bg-[url('https://www.transparenttextures.com/patterns/white-wall-3.png')]"></div>
        <div class="relative max-w-6xl mx-auto px-6 py-24 space-y-8">
            <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-10">
                <div class="space-y-5 max-w-3xl">
                    <div class="flex flex-wrap items-center gap-3 text-xs">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-4 py-2 font-semibold uppercase tracking-[0.3em]">
                            Lớp nâng cao
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/15 px-3 py-1 font-semibold">
                            Khai giảng 12/11/2025
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-emerald-400/20 px-3 py-1 font-semibold text-emerald-50 border border-emerald-200/40">
                            Còn 4 chỗ
                        </span>
                    </div>
                    <h1 class="text-4xl sm:text-5xl font-extrabold tracking-tight">
                        NE3 · Giao tiếp nâng cao
                    </h1>
                    <p class="text-sm sm:text-base text-white/80 leading-relaxed">
                        Luyện giao tiếp phản xạ theo chuẩn đề thi VSTEP 2025 cùng giảng viên đầu ngành. Lộ trình 8 tuần, mỗi học viên được kèm sát và nhận phản hồi cá nhân hóa sau từng buổi học.
                    </p>
                    <div class="flex flex-wrap gap-3 text-xs text-blue-50">
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Thứ 3 · 5 · 18:00 - 20:00
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            20 buổi · 40 giờ học
                        </span>
                        <span class="inline-flex items-center gap-2 rounded-full bg-white/10 px-3 py-1 font-semibold">
                            Cơ sở Quận 10 · Studio Live
                        </span>
                    </div>
                </div>
                <div class="glass rounded-3xl border border-white/30 px-7 py-8 shadow-soft text-slate-700 bg-white/90 w-full max-w-xs">
                    <p class="text-sm font-semibold text-slate-900">Học phí trọn khóa</p>
                    <p class="mt-2 text-3xl font-bold text-primary">3.200.000đ</p>
                    <div class="mt-4 space-y-3 text-xs text-slate-500">
                        <div class="flex items-center justify-between">
                            <span>Mã lớp</span>
                            <span class="font-semibold text-slate-800">LOP-NE3-2025</span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span>Sĩ số hiện tại</span>
                            <span class="font-semibold text-slate-800">32 / 36</span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span>Hỗ trợ</span>
                            <span class="font-semibold text-slate-800">Tư vấn 24/7</span>
                        </div>
                    </div>
                    <a href="../user/user-register-class.jsp"
                       class="mt-5 block text-center rounded-full bg-primary px-5 py-3 text-sm font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Đăng ký ngay
                    </a>
                    <p class="mt-3 text-[11px] text-center text-slate-400">
                        Giữ chỗ trong 24h. Học viên thi lại được giảm thêm 10% tự động.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <section class="relative -mt-16 pb-24">
        <div class="max-w-6xl mx-auto px-6">
            <div class="grid gap-8 lg:grid-cols-[2fr,1fr]">
                <div class="space-y-8">
                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header class="space-y-3">
                            <h2 class="text-xl font-semibold text-slate-900">Tổng quan khóa học</h2>
                            <p class="text-sm text-slate-500 leading-relaxed">
                                Khóa học tập trung vào kỹ năng Speaking & Listening nâng cao với phương pháp phản xạ nhanh. Học viên được chia nhóm nhỏ, thực hành với tình huống sát đề thi và nhận feedback chi tiết sau từng buổi học.
                            </p>
                        </header>
                        <div class="grid gap-4 sm:grid-cols-2">
                            <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-5 py-4 text-sm text-slate-600 space-y-2">
                                <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Giảng viên phụ trách</p>
                                <p class="font-semibold text-slate-800">ThS. Lê Thảo</p>
                                <p class="text-xs text-slate-500">IELTS 8.5 Speaking · 10+ năm đào tạo VSTEP</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-white px-5 py-4 text-sm text-slate-600 space-y-2 shadow-sm">
                                <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Cam kết đầu ra</p>
                                <p class="font-semibold text-slate-800">Đạt tối thiểu B2</p>
                                <p class="text-xs text-slate-500">Học lại miễn phí 50% thời lượng nếu chưa đạt</p>
                            </div>
                        </div>
                        <div class="rounded-2xl border border-dashed border-blue-200 px-5 py-4 text-sm text-slate-600 space-y-2">
                            <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Điểm nổi bật</p>
                            <ul class="space-y-2 text-xs">
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>Classroom studio với micro riêng từng nhóm, thu âm và phân tích lỗi phát âm.</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>02 buổi mock test toàn diện, giám khảo chấm trực tiếp theo rubric VSTEP.</span>
                                </li>
                                <li class="flex items-start gap-2">
                                    <span class="mt-1 h-1.5 w-1.5 rounded-full bg-primary"></span>
                                    <span>Hệ thống LMS cá nhân hóa: giao bài, nhắc lịch, báo cáo tiến độ hàng tuần.</span>
                                </li>
                            </ul>
                        </div>
                    </article>

                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header>
                            <h2 class="text-xl font-semibold text-slate-900">Lịch học chi tiết</h2>
                            <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                Lịch học linh hoạt kết hợp lý thuyết, thực hành và đánh giá tiến bộ.
                            </p>
                        </header>
                        <div class="overflow-hidden rounded-2xl border border-blue-100">
                            <table class="w-full text-sm text-slate-600">
                                <thead class="bg-primary.pale/60 text-xs uppercase tracking-widest text-slate-500">
                                <tr>
                                    <th class="px-4 py-3 text-left font-semibold">Tuần</th>
                                    <th class="px-4 py-3 text-left font-semibold">Chủ đề</th>
                                    <th class="px-4 py-3 text-left font-semibold">Kết quả mong đợi</th>
                                </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-blue-50">
                                <tr class="hover:bg-blue-50/50 transition">
                                    <td class="px-4 py-3 font-semibold text-slate-800">1 - 2</td>
                                    <td class="px-4 py-3">Nền tảng phát âm, nghe chủ động</td>
                                    <td class="px-4 py-3 text-xs text-slate-500">Sửa lỗi phát âm cơ bản, tăng tốc độ phản xạ.</td>
                                </tr>
                                <tr class="hover:bg-blue-50/50 transition">
                                    <td class="px-4 py-3 font-semibold text-slate-800">3 - 4</td>
                                    <td class="px-4 py-3">Speaking Part 2 · Story-telling</td>
                                    <td class="px-4 py-3 text-xs text-slate-500">Xây dựng ý nhanh, diễn đạt 2 phút tự tin.</td>
                                </tr>
                                <tr class="hover:bg-blue-50/50 transition">
                                    <td class="px-4 py-3 font-semibold text-slate-800">5 - 6</td>
                                    <td class="px-4 py-3">Speaking Part 3 · Debate & Opinion</td>
                                    <td class_n="px-4 py-3 text-xs text-slate-500">Phát triển lập luận, sử dụng cấu trúc nâng cao.</td>
                                </tr>
                                <tr class="hover:bg-blue-50/50 transition">
                                    <td class="px-4 py-3 font-semibold text-slate-800">7 - 8</td>
                                    <td class="px-4 py-3">Mock test · Feedback cá nhân</td>
                                    <td class="px-4 py-3 text-xs text-slate-500">Hoàn thiện điểm yếu, chốt chiến thuật thi.</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="rounded-2xl border border-blue-100 bg-white px-5 py-4 text-xs text-slate-500 space-y-2 shadow-sm">
                            <p class="font-semibold text-slate-700">Chính sách linh hoạt</p>
                            <p>• Học viên nghỉ buổi được hỗ trợ học bù online hoặc gửi bài tập + feedback riêng.</p>
                            <p>• Miễn phí chuyển lớp khi báo trước 5 ngày và còn chỗ trống.</p>
                        </div>
                    </article>

                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header>
                            <h2 class="text-xl font-semibold text-slate-900">Tài nguyên & hỗ trợ</h2>
                            <p class="mt-2 text-sm text-slate-500 leading-relaxed">
                                Toàn bộ tài nguyên được update hàng tuần theo đề thi mới nhất.
                            </p>
                        </header>
                        <div class="grid gap-4 md:grid-cols-2">
                            <div class="rounded-2xl border border-blue-100 bg-primary.pale/50 px-4 py-4 text-sm text-slate-600 space-y-2">
                                <p class="font-semibold text-slate-800">Tài liệu độc quyền</p>
                                <p class="text-xs text-slate-500">12 bộ đề chuẩn hóa, audio luyện nghe, flashcard online.</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-sm text-slate-600 space-y-2 shadow-sm">
                                <p class="font-semibold text-slate-800">Mentoring cá nhân</p>
                                <p class="text-xs text-slate-500">1 buổi 1:1 mỗi 2 tuần để rà tiến độ và chỉnh lỗi.</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-sm text-slate-600 space-y-2 shadow-sm">
                                <p class="font-semibold text-slate-800">Community học viên</p>
                                <p class="text-xs text-slate-500">Group Zalo riêng, luyện speaking hàng tối với trợ giảng.</p>
                            </div>
                            <div class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-4 py-4 text-sm text-slate-600 space-y-2">
                                <p class="font-semibold text-slate-800">Hỗ trợ đăng ký thi</p>
                                <p class="text-xs text-slate-500">Được ưu tiên chọn ca thi nội bộ, giảm 5% phí đăng ký.</p>
                            </div>
                        </div>
                    </article>

                    <article class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                        <header>
                            <h2 class="text-xl font-semibold text-slate-900">Câu hỏi thường gặp</h2>
                        </header>
                        <div class="space-y-4 text-sm text-slate-600">
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify-between cursor-pointer font-semibold text-slate-800">
                                    Tôi có được xem lại bài giảng không?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Có. Video ghi hình được lưu trên LMS 30 ngày sau buổi học, kèm tài liệu và bài tập ôn luyện.
                                </p>
                            </details>
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify-between cursor-pointer font-semibold text-slate-800">
                                    Nếu tôi nghỉ 1 buổi thì có được bù?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Trung tâm hỗ trợ lớp học bù online và gửi bài tập có feedback riêng. Báo trước 4 giờ để giữ quyền lợi.
                                </p>
                            </details>
                            <details class="group rounded-2xl border border-blue-100 bg-white px-5 py-4 shadow-sm transition">
                                <summary class="flex items-center justify_between cursor-pointer font-semibold text-slate-800">
                                    Có hỗ trợ đăng ký ca thi không?
                                    <span class="text-slate-400 group-open:rotate-180 transition-transform">⌃</span>
                                </summary>
                                <p class="mt-2 text-xs text-slate-500">
                                    Giảng viên sẽ tư vấn chọn ca thi phù hợp. Học viên NE3 được ưu tiên đặt chỗ ca thi nội bộ và nhận email nhắc lịch.
                                </p>
                            </details>
                        </div>
                    </article>
                </div>

                <aside class="space-y-6">
                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Hồ sơ giảng viên</h3>
                        <div class="mt-4 flex items-center gap-4">
                            <img src="https://i.pravatar.cc/120?img=57" alt="Giảng viên" class="h-14 w-14 rounded-full border border-blue-100">
                            <div>
                                <p class="text-sm font-semibold text-slate-800">ThS. Lê Thảo</p>
                                <p class="text-xs text-slate-500">IELTS Speaking 8.5 · Giảng viên ĐH Sư phạm</p>
                            </div>
                        </div>
                        <p class="mt-4 text-xs text-slate-500 leading-relaxed">
                            10+ năm huấn luyện VSTEP · Coach cho đội tuyển học sinh giỏi tiếng Anh TP.HCM · Đã đồng hành cùng 300+ học viên đạt B2 - C1.
                        </p>
                        <div class="mt-4 space-y-2 text-xs text-slate-500">
                            <p class="font-semibold text-slate-700">Thành tích nổi bật</p>
                            <ul class="space-y-1">
                                <li>• Diễn giả khách mời VSTEP Summit 2024</li>
                                <li>• Tác giả ebook “Chiến thuật Speaking VSTEP”</li>
                            </ul>
                        </div>
                    </div>

                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white space-y-4">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Thông tin nhanh</h3>
                        <div class="space-y-3 text-sm text-slate-600">
                            <div class="flex items-center justify-between rounded-2xl bg-primary.pale/60 px-4 py-3">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Hình thức</span>
                                <span class="font-semibold text-slate-800">Trực tiếp</span>
                            </div>
                            <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Số buổi</span>
                                <span class="font-semibold text-slate-800">20 buổi</span>
                            </div>
                            <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Sĩ số tối đa</span>
                                <span class="font-semibold text-slate-800">36 học viên</span>
                            </div>
                            <div class="flex items-center justify-between rounded-2xl bg-white px-4 py-3 border border-blue-100">
                                <span class="text-xs text-slate-500 uppercase tracking-widest">Ưu đãi</span>
                                <span class="font-semibold text-primary">Giảm 10% cho học viên cũ</span>
                            </div>
                        </div>
                        <a href="<%= request.getContextPath() %>/lop"
                           class="inline-flex items-center gap-2 text-xs font-semibold text-primary hover:text-primary/80 transition">
                            Xem thêm lớp khác
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
                                 viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.6">
                                <path d="M9 5l7 7-7 7"/>
                            </svg>
                        </a>
                    </div>

                    <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft bg-white space-y-5">
                        <h3 class="text-sm font-semibold uppercase tracking-widest text-slate-500">Học viên nói gì?</h3>
                        <div class="space-y-4">
                            <figure class="rounded-2xl border border-blue-100 bg-primary.pale/60 px-4 py-4 text-xs text-slate-600 space-y-2">
                                <p class="italic text-slate-700">“Sau 8 tuần mình từ B1 lên B2. Feedback rất chi tiết, đặc biệt là phần speaking mock test.”</p>
                                <figcaption class="text-[11px] font-semibold text-slate-500">Thuỳ Trang · Đạt B2 (2025)</figcaption>
                            </figure>
                            <figure class="rounded-2xl border border-blue-100 bg-white px-4 py-4 text-xs text-slate-600 space-y-2 shadow-sm">
                                <p class="italic text-slate-700">“LMS tiện, nhắc lịch đều. Giảng viên sửa lỗi phát âm từng âm, rất sát đề thi thật.”</p>
                                <figcaption class="text-[11px] font-semibold text-slate-500">Đức Long · Đạt B2 (2024)</figcaption>
                            </figure>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>


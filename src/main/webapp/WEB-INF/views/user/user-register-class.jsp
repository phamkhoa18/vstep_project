<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.vstep.model.NguoiDung" %>
<%@ page import="com.vstep.model.DangKyLop" %>
<%@ page import="com.vstep.model.LopOn" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
    String displayName = user != null && user.getHoTen() != null && !user.getHoTen().isEmpty()
            ? user.getHoTen()
            : "Học viên";
    
    List<Map<String, Object>> lopDangKyList = (List<Map<String, Object>>) request.getAttribute("lopDangKyList");
    if (lopDangKyList == null) {
        lopDangKyList = new ArrayList<>();
    }
    
    // Phân loại theo trạng thái
    List<Map<String, Object>> lopDangHoc = new ArrayList<>();
    List<Map<String, Object>> lopDaHoanThanh = new ArrayList<>();
    List<Map<String, Object>> lopChoXacNhan = new ArrayList<>();
    
    for (Map<String, Object> item : lopDangKyList) {
        DangKyLop dk = (DangKyLop) item.get("dangKyLop");
        String trangThai = dk.getTrangThai();
        if (trangThai != null) {
            if (trangThai.contains("Đang học") || trangThai.contains("Đã xác nhận") || trangThai.contains("Đã duyệt")) {
                lopDangHoc.add(item);
            } else if (trangThai.contains("Hoàn thành") || trangThai.contains("Đã hoàn thành")) {
                lopDaHoanThanh.add(item);
            } else {
                lopChoXacNhan.add(item);
            }
        } else {
            lopChoXacNhan.add(item);
        }
    }
    
    pageContext.setAttribute("lopDangHoc", lopDangHoc);
    pageContext.setAttribute("lopDaHoanThanh", lopDaHoanThanh);
    pageContext.setAttribute("lopChoXacNhan", lopChoXacNhan);
    pageContext.setAttribute("tongSoLop", lopDangKyList.size());
    pageContext.setAttribute("soLopDangHoc", lopDangHoc.size());
    pageContext.setAttribute("soLopDaHoanThanh", lopDaHoanThanh.size());
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lớp đã đăng ký | VSTEP</title>
    <%@ include file="../layout/public-theme.jspf" %>
</head>
<body class="text-gray-800">
<%@ include file="../layout/public-header.jspf" %>

<main class="pt-32 pb-24">
    <section class="max-w-6xl mx-auto px-6 space-y-12">
        <div class="space-y-4 text-center">
            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.3em] text-primary">
                Lớp đã đăng ký
            </span>
            <h1 class="text-3xl sm:text-4xl font-extrabold text-slate-900">Lớp ôn luyện của <%= displayName %></h1>
            <p class="text-sm text-slate-500 max-w-2xl mx-auto">
                Theo dõi lịch học, tiến độ và tài liệu của từng lớp. Bạn có thể xin nghỉ, đổi buổi hoặc gia hạn ngay tại đây.
            </p>
        </div>

        <div class="grid gap-8 lg:grid-cols-[1fr,2fr]">
            <aside class="space-y-6">
                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Tóm tắt</p>
                    <div class="space-y-2 text-sm text-slate-600">
                        <div class="flex items-center justify-between rounded-2xl bg-primary/10 px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Tổng số lớp</span>
                            <span class="font-semibold text-slate-900">${tongSoLop}</span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Đang học</span>
                            <span class="font-semibold text-primary">${soLopDangHoc}</span>
                        </div>
                        <div class="flex items-center justify-between rounded-2xl border border-blue-100 bg-white px-4 py-3">
                            <span class="text-xs uppercase tracking-widest text-slate-500">Đã hoàn thành</span>
                            <span class="font-semibold text-emerald-500">${soLopDaHoanThanh}</span>
                        </div>
                    </div>
                </div>

                <div class="glass rounded-3xl border border-blue-100 px-6 py-6 shadow-soft space-y-4">
                    <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Hành động nhanh</p>
                    <div class="space-y-3 text-sm text-slate-600">
                        <a href="<%= request.getContextPath() %>/lop" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                            Đăng ký lớp mới
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-primary hover:bg-primary/5 transition">
                            Yêu cầu đổi buổi học
                        </a>
                        <a href="#" class="inline-flex items-center gap-2 rounded-full border border-blue-100 bg-white px-5 py-2.5 text-xs font-semibold text-slate-600 hover:bg-blue-50 transition">
                            Tải thời khóa biểu tuần
                        </a>
                    </div>
                </div>
            </aside>

            <section class="space-y-6">
                <c:if test="${not empty lopDangHoc or not empty lopChoXacNhan}">
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-8">
                    <header>
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đang tham gia</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-900">Lớp đã đăng ký</h2>
                    </header>

                    <div class="space-y-6">
                        <c:forEach var="item" items="${lopDangHoc}">
                            <c:set var="dangKyLop" value="${item.dangKyLop}" />
                            <c:set var="lopOn" value="${item.lopOn}" />
                            <article class="rounded-3xl border border-blue-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition">
                                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                                    <div class="space-y-3">
                                        <div class="flex flex-wrap gap-2 text-xs text-slate-400 uppercase tracking-widest">
                                            <span class="inline-flex items-center gap-2 rounded-full bg-primary/10 px-3 py-1 font-semibold text-primary">
                                                ${dangKyLop.trangThai}
                                            </span>
                                            <c:if test="${not empty lopOn.maLop}">
                                                <span>${lopOn.maLop}</span>
                                            </c:if>
                                        </div>
                                        <h3 class="text-xl font-semibold text-slate-900">${lopOn.tieuDe}</h3>
                                        <c:if test="${not empty lopOn.moTaNgan}">
                                            <p class="text-sm text-slate-500 leading-relaxed">${lopOn.moTaNgan}</p>
                                        </c:if>
                                    </div>
                                    <div class="flex-shrink-0 text-right space-y-2 text-sm text-slate-600">
                                        <c:if test="${not empty lopOn.thoiGianHoc}">
                                            <p class="font-semibold text-slate-900">${lopOn.thoiGianHoc}</p>
                                        </c:if>
                                        <c:if test="${not empty lopOn.hinhThuc}">
                                            <p class="text-xs text-slate-500">${lopOn.hinhThuc}</p>
                                        </c:if>
                                        <c:if test="${lopOn.ngayKhaiGiang != null}">
                                            <p class="text-xs text-primary font-semibold">
                                                Khai giảng: <fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="dd/MM/yyyy" />
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mt-6 grid gap-4 md:grid-cols-3 text-xs text-slate-500">
                                    <c:if test="${lopOn.ngayKhaiGiang != null}">
                                        <div class="rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3">
                                            <p class="font-semibold text-slate-700">Ngày khai giảng</p>
                                            <p class="mt-1"><fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="dd/MM/yyyy" /></p>
                                        </div>
                                    </c:if>
                                    <c:if test="${lopOn.ngayKetThuc != null}">
                                        <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                            <p class="font-semibold text-slate-700">Ngày kết thúc</p>
                                            <p class="mt-1"><fmt:formatDate value="${lopOn.ngayKetThuc}" pattern="dd/MM/yyyy" /></p>
                                        </div>
                                    </c:if>
                                    <c:if test="${lopOn.soBuoi > 0}">
                                        <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                            <p class="font-semibold text-slate-700">Số buổi</p>
                                            <p class="mt-1">${lopOn.soBuoi} buổi</p>
                                        </div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty dangKyLop.ghiChu}">
                                    <div class="mt-4 rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3 text-xs text-slate-600">
                                        <p class="font-semibold text-slate-700 mb-1">Ghi chú</p>
                                        <p>${dangKyLop.ghiChu}</p>
                                    </div>
                                </c:if>
                            </article>
                        </c:forEach>
                        
                        <c:forEach var="item" items="${lopChoXacNhan}">
                            <c:set var="dangKyLop" value="${item.dangKyLop}" />
                            <c:set var="lopOn" value="${item.lopOn}" />
                            <article class="rounded-3xl border border-orange-100 bg-white px-6 sm:px-8 py-7 shadow-soft hover:shadow-xl transition">
                                <div class="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
                                    <div class="space-y-3">
                                        <div class="flex flex-wrap gap-2 text-xs text-slate-400 uppercase tracking-widest">
                                            <span class="inline-flex items-center gap-2 rounded-full bg-orange-100 px-3 py-1 font-semibold text-orange-500">
                                                ${dangKyLop.trangThai != null ? dangKyLop.trangThai : 'Chờ xác nhận'}
                                            </span>
                                            <c:if test="${not empty lopOn.maLop}">
                                                <span>${lopOn.maLop}</span>
                                            </c:if>
                                        </div>
                                        <h3 class="text-xl font-semibold text-slate-900">${lopOn.tieuDe}</h3>
                                        <c:if test="${not empty lopOn.moTaNgan}">
                                            <p class="text-sm text-slate-500 leading-relaxed">${lopOn.moTaNgan}</p>
                                        </c:if>
                                    </div>
                                    <div class="flex-shrink-0 text-right space-y-2 text-sm text-slate-600">
                                        <c:if test="${not empty lopOn.thoiGianHoc}">
                                            <p class="font-semibold text-slate-900">${lopOn.thoiGianHoc}</p>
                                        </c:if>
                                        <c:if test="${not empty lopOn.hinhThuc}">
                                            <p class="text-xs text-slate-500">${lopOn.hinhThuc}</p>
                                        </c:if>
                                        <c:if test="${lopOn.ngayKhaiGiang != null}">
                                            <p class="text-xs text-orange-500 font-semibold">
                                                Khai giảng: <fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="dd/MM/yyyy" />
                                            </p>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mt-6 grid gap-4 md:grid-cols-3 text-xs text-slate-500">
                                    <c:if test="${dangKyLop.ngayDangKy != null}">
                                        <div class="rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3">
                                            <p class="font-semibold text-slate-700">Ngày đăng ký</p>
                                            <p class="mt-1"><fmt:formatDate value="${dangKyLop.ngayDangKy}" pattern="dd/MM/yyyy HH:mm" /></p>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty dangKyLop.maXacNhan}">
                                        <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                            <p class="font-semibold text-slate-700">Mã xác nhận</p>
                                            <p class="mt-1">${dangKyLop.maXacNhan}</p>
                                        </div>
                                    </c:if>
                                    <c:if test="${dangKyLop.soTienDaTra > 0}">
                                        <div class="rounded-2xl border border-blue-100 bg-white px-4 py-3">
                                            <p class="font-semibold text-slate-700">Số tiền đã trả</p>
                                            <p class="mt-1"><fmt:formatNumber value="${dangKyLop.soTienDaTra}" type="number" /> đ</p>
                                        </div>
                                    </c:if>
                                </div>
                                <c:if test="${not empty dangKyLop.ghiChu}">
                                    <div class="mt-4 rounded-2xl border border-blue-100 bg-blue-50/60 px-4 py-3 text-xs text-slate-600">
                                        <p class="font-semibold text-slate-700 mb-1">Ghi chú</p>
                                        <p>${dangKyLop.ghiChu}</p>
                                    </div>
                                </c:if>
                            </article>
                        </c:forEach>
                    </div>
                </div>
                </c:if>

                <c:if test="${not empty lopDaHoanThanh}">
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-8 shadow-soft space-y-6">
                    <header>
                        <p class="text-xs font-semibold uppercase tracking-widest text-slate-500">Đã hoàn thành</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-900">Lịch sử lớp học</h2>
                    </header>
                    <div class="overflow-hidden rounded-3xl border border-blue-100">
                        <table class="w-full text-sm text-slate-600">
                            <thead class="bg-primary/10 text-xs uppercase tracking-widest text-slate-500">
                            <tr>
                                <th class="px-4 py-3 text-left font-semibold">Lớp</th>
                                <th class="px-4 py-3 text-left font-semibold">Thời gian</th>
                                <th class="px-4 py-3 text-left font-semibold">Hình thức</th>
                                <th class="px-4 py-3 text-left font-semibold">Trạng thái</th>
                                <th class="px-4 py-3 text-left font-semibold">Mã xác nhận</th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-blue-50">
                            <c:forEach var="item" items="${lopDaHoanThanh}">
                                <c:set var="dangKyLop" value="${item.dangKyLop}" />
                                <c:set var="lopOn" value="${item.lopOn}" />
                                <tr class="hover:bg-blue-50/50 transition">
                                    <td class="px-4 py-3">
                                        <p class="font-semibold text-slate-800">
                                            <c:if test="${not empty lopOn.maLop}">${lopOn.maLop} · </c:if>${lopOn.tieuDe}
                                        </p>
                                        <c:if test="${lopOn.ngayKetThuc != null}">
                                            <p class="text-xs text-slate-500 mt-1">
                                                Hoàn thành ngày <fmt:formatDate value="${lopOn.ngayKetThuc}" pattern="dd/MM/yyyy" />
                                            </p>
                                        </c:if>
                                    </td>
                                    <td class="px-4 py-3">
                                        <c:if test="${lopOn.ngayKhaiGiang != null and lopOn.ngayKetThuc != null}">
                                            <fmt:formatDate value="${lopOn.ngayKhaiGiang}" pattern="dd/MM/yyyy" /> - 
                                            <fmt:formatDate value="${lopOn.ngayKetThuc}" pattern="dd/MM/yyyy" />
                                        </c:if>
                                    </td>
                                    <td class="px-4 py-3">${lopOn.hinhThuc != null ? lopOn.hinhThuc : '-'}</td>
                                    <td class="px-4 py-3">
                                        <span class="inline-flex items-center gap-2 rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-600">
                                            ${dangKyLop.trangThai}
                                        </span>
                                    </td>
                                    <td class="px-4 py-3">
                                        <c:if test="${not empty dangKyLop.maXacNhan}">
                                            <span class="text-xs font-semibold text-slate-600">${dangKyLop.maXacNhan}</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                </c:if>
                
                <c:if test="${empty lopDangKyList or (empty lopDangHoc and empty lopChoXacNhan and empty lopDaHoanThanh)}">
                <div class="glass rounded-3xl border border-blue-100 px-6 sm:px-10 py-12 shadow-soft text-center">
                    <p class="text-slate-500 mb-4">Bạn chưa đăng ký lớp học nào.</p>
                    <a href="<%= request.getContextPath() %>/lop" class="inline-flex items-center gap-2 rounded-full bg-primary px-5 py-2.5 text-xs font-semibold text-white shadow-soft hover:bg-primary/90 transition">
                        Đăng ký lớp mới
                    </a>
                </div>
                </c:if>
            </section>
        </div>
    </section>
</main>

<%@ include file="../layout/public-footer.jspf" %>
</body>
</html>

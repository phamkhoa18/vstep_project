package com.vstep.controller.payment;

import java.io.IOException;

import com.vstep.model.CaThi;
import com.vstep.model.DangKyLop;
import com.vstep.model.DangKyThi;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.payment.PaymentStore;
import com.vstep.service.CaThiService;
import com.vstep.service.DangKyLopService;
import com.vstep.service.DangKyThiService;
import com.vstep.service.LopOnService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.DangKyLopServiceImpl;
import com.vstep.serviceImpl.DangKyThiServiceImpl;
import com.vstep.serviceImpl.LopOnServiceImpl;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import com.vstep.util.EmailService;
import com.vstep.util.InvoicePdfService;
import com.vstep.util.InvoiceFileUtil;
import com.vstep.service.HoaDonService;
import com.vstep.serviceImpl.HoaDonServiceImpl;
import com.vstep.model.HoaDon;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/payment/*"})
public class PaymentServlet extends HttpServlet {

    private DangKyLopService dangKyLopService;
    private DangKyThiService dangKyThiService;
    private LopOnService lopOnService;
    private CaThiService caThiService;
    private NguoiDungService nguoiDungService;

    @Override
    public void init() throws ServletException {
        super.init();
        dangKyLopService = new DangKyLopServiceImpl();
        dangKyThiService = new DangKyThiServiceImpl();
        lopOnService = new LopOnServiceImpl();
        caThiService = new CaThiServiceImpl();
        nguoiDungService = new NguoiDungServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        switch (pathInfo) {
            case "/start" -> startPayment(req, resp);
            case "/confirm" -> confirmPayment(req, resp);
            default -> resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void startPayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("dkId");
        String type = req.getParameter("type"); // "exam" hoặc null (lớp ôn)
        long dkId = parseLong(idStr);
        if (dkId <= 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu hoặc sai tham số dkId");
            return;
        }

        boolean isExam = "exam".equals(type);
        Object dangKyObj = null;
        LopOn lop = null;
        CaThi caThi = null;
        long soTienPhaiTra = 0;
        long mucGiam = 0;
        String maCodeGiamGia = null;

        if (isExam) {
            DangKyThi dk = dangKyThiService.findById(dkId);
            if (dk == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đăng ký");
                return;
            }
            // Kiểm tra lại sức chứa trước khi thanh toán (vì có thể slot đã bị chiếm bởi người khác đã thanh toán)
            caThi = caThiService.findById(dk.getCaThiId());
            if (caThi != null) {
                int soLuongDangKy = dangKyThiService.countByCaThiId(caThi.getId());
                if (soLuongDangKy >= caThi.getSucChua()) {
                    // Slot đã đầy, hủy đăng ký này
                    dk.setTrangThai("Đã hủy");
                    dangKyThiService.update(dk);
                    req.setAttribute("errorMessage", "Ca thi đã đầy, đăng ký của bạn đã bị hủy. Vui lòng chọn ca thi khác.");
                    req.getRequestDispatcher("/WEB-INF/views/public/payment-expired.jsp").forward(req, resp);
                    return;
                }
            }
            dangKyObj = dk;
            soTienPhaiTra = dk.getSoTienPhaiTra();
            mucGiam = dk.getMucGiam();
            maCodeGiamGia = dk.getMaCodeGiamGia();
        } else {
            DangKyLop dk = dangKyLopService.findById(dkId);
            if (dk == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đăng ký");
                return;
            }
            // Kiểm tra lại sĩ số trước khi thanh toán (vì có thể slot đã bị chiếm bởi người khác đã thanh toán)
            lop = lopOnService.findById(dk.getLopOnId());
            if (lop != null) {
                int soLuongDangKy = dangKyLopService.countByLopOnId(lop.getId());
                if (soLuongDangKy >= lop.getSiSoToiDa()) {
                    // Lớp đã đầy, hủy đăng ký này
                    dk.setTrangThai("Đã hủy");
                    dangKyLopService.update(dk);
                    req.setAttribute("errorMessage", "Lớp đã đầy, đăng ký của bạn đã bị hủy. Vui lòng chọn lớp khác.");
                    req.getRequestDispatcher("/WEB-INF/views/public/payment-expired.jsp").forward(req, resp);
                    return;
                }
            }
            dangKyObj = dk;
            // Tính số tiền phải trả = học phí - mức giảm
            if (lop != null) {
                soTienPhaiTra = Math.max(0, lop.getHocPhi() - dk.getMucGiam());
            }
            mucGiam = dk.getMucGiam();
            maCodeGiamGia = dk.getMaCodeGiamGia();
        }

        PaymentStore.PaymentSession session = PaymentStore.create(dkId, isExam);
        String confirmUrl = req.getRequestURL().toString().replace("/start", "/confirm") + "?token=" + session.getToken();
        String qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=240x240&data=" + java.net.URLEncoder.encode(confirmUrl, java.nio.charset.StandardCharsets.UTF_8);

        req.setAttribute("dangKy", dangKyObj);
        req.setAttribute("lopOn", lop);
        req.setAttribute("caThi", caThi);
        req.setAttribute("isExam", isExam);
        req.setAttribute("soTienPhaiTra", soTienPhaiTra);
        req.setAttribute("mucGiam", mucGiam);
        req.setAttribute("maCodeGiamGia", maCodeGiamGia);
        req.setAttribute("token", session.getToken());
        req.setAttribute("expiresAt", session.getExpiresAtEpochMillis());
        req.setAttribute("confirmUrl", confirmUrl);
        req.setAttribute("qrUrl", qrUrl);

        req.getRequestDispatcher("/WEB-INF/views/public/payment.jsp").forward(req, resp);
    }

    private void confirmPayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        PaymentStore.PaymentSession session = PaymentStore.get(token);
        if (session == null || session.isExpired()) {
            if (session != null) {
                // Payment session hết hạn - tự động hủy đăng ký nếu chưa thanh toán
                cleanupExpiredRegistration(session);
                PaymentStore.invalidate(token);
            }
            req.getRequestDispatcher("/WEB-INF/views/public/payment-expired.jsp").forward(req, resp);
            return;
        }
        if (session.isUsed()) {
            req.getRequestDispatcher("/WEB-INF/views/public/payment-success.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra lại sức chứa/sĩ số trước khi xác nhận thanh toán
        boolean isExamCheck = session.isExam();
        if (isExamCheck) {
            DangKyThi dk = dangKyThiService.findById(session.getRegistrationId());
            if (dk != null && "Chờ xác nhận".equals(dk.getTrangThai())) {
                CaThi ct = caThiService.findById(dk.getCaThiId());
                if (ct != null) {
                    int soLuongDangKy = dangKyThiService.countByCaThiId(ct.getId());
                    if (soLuongDangKy >= ct.getSucChua()) {
                        // Slot đã đầy, hủy đăng ký này
                        dk.setTrangThai("Đã hủy");
                        dangKyThiService.update(dk);
                        PaymentStore.invalidate(token);
                        req.setAttribute("errorMessage", "Ca thi đã đầy, đăng ký của bạn đã bị hủy.");
                        req.getRequestDispatcher("/WEB-INF/views/public/payment-expired.jsp").forward(req, resp);
                        return;
                    }
                }
            }
        } else {
            DangKyLop dk = dangKyLopService.findById(session.getRegistrationId());
            if (dk != null && "Chờ xác nhận".equals(dk.getTrangThai())) {
                LopOn lop = lopOnService.findById(dk.getLopOnId());
                if (lop != null) {
                    int soLuongDangKy = dangKyLopService.countByLopOnId(lop.getId());
                    if (soLuongDangKy >= lop.getSiSoToiDa()) {
                        // Lớp đã đầy, hủy đăng ký này
                        dk.setTrangThai("Đã hủy");
                        dangKyLopService.update(dk);
                        PaymentStore.invalidate(token);
                        req.setAttribute("errorMessage", "Lớp đã đầy, đăng ký của bạn đã bị hủy.");
                        req.getRequestDispatcher("/WEB-INF/views/public/payment-expired.jsp").forward(req, resp);
                        return;
                    }
                }
            }
        }

        // Mark registration as paid and approved
        boolean isExamFinal = session.isExam();
        if (isExamFinal) {
            DangKyThi dk = dangKyThiService.findById(session.getRegistrationId());
            if (dk == null) {
                PaymentStore.invalidate(token);
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Đăng ký không tồn tại");
                return;
            }
            // soTienPhaiTra đã là số tiền phải trả sau khi giảm giá, đánh dấu đã thanh toán
            dk.setTrangThai("Đã duyệt");
            dangKyThiService.update(dk);
            
            // Tạo và lưu hóa đơn PDF khi thanh toán thành công
            java.util.concurrent.CompletableFuture.runAsync(() -> {
                try {
                    NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
                    CaThi ct = caThiService.findById(dk.getCaThiId());
                    if (user != null && ct != null && user.getEmail() != null && !user.getEmail().isBlank()) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                        java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
                        java.text.SimpleDateFormat regDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                        
                        String examDateStr = ct.getNgayThi() != null ? dateFormat.format(ct.getNgayThi()) : "";
                        String examTimeStr = ct.getGioBatDau() != null ? timeFormat.format(ct.getGioBatDau()) : "";
                        if (ct.getGioKetThuc() != null) {
                            examTimeStr += " - " + timeFormat.format(ct.getGioKetThuc());
                        }
                        String registrationDateStr = dk.getNgayDangKy() != null 
                            ? regDateFormat.format(dk.getNgayDangKy()) 
                            : "N/A";
                        
                        String examCode = ct.getMaCaThi() != null ? ct.getMaCaThi() : "Ca thi #" + ct.getId();
                        String registrationCode = dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "N/A";
                        String invoiceNumber = "INV-EXAM-" + dk.getId() + "-" + 
                            new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                        
                        // Tạo PDF hóa đơn thanh toán
                        byte[] pdfBytes = InvoicePdfService.generateExamInvoicePdf(
                            invoiceNumber,
                            user.getHoTen(),
                            user.getEmail(),
                            user.getSoDienThoai(),
                            user.getDonVi(),
                            examCode,
                            examDateStr,
                            examTimeStr,
                            ct.getDiaDiem(),
                            registrationCode,
                            registrationDateStr,
                            ct.getGiaGoc(),
                            dk.getMucGiam(),
                            dk.getSoTienPhaiTra(),
                            dk.isDaTungThi(),
                            dk.getMaCodeGiamGia()
                        );
                        
                        // Lưu file PDF vào thư mục
                        String fileName = "Hoa_don_thanh_toan_ca_thi_" + examCode.replaceAll("[^a-zA-Z0-9]", "_") + "_" + 
                            new java.text.SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".pdf";
                        String filePath = InvoiceFileUtil.saveInvoiceFile(pdfBytes, fileName);
                        
                        // Lưu thông tin hóa đơn vào database
                        HoaDon hoaDon = new HoaDon();
                        hoaDon.setSoHoaDon(invoiceNumber);
                        hoaDon.setNguoiDungId(user.getId());
                        hoaDon.setLoai("ca_thi");
                        hoaDon.setDangKyId(dk.getId());
                        hoaDon.setFilePath(filePath);
                        hoaDon.setFileName(fileName);
                        hoaDon.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
                        hoaDon.setTrangThai("Đã thanh toán");
                        
                        HoaDonService hoaDonService = new HoaDonServiceImpl();
                        hoaDonService.create(hoaDon);
                        
                        // Gửi email với PDF hóa đơn
                        String htmlBody = EmailService.buildExamRegistrationEmailBody(
                            user.getHoTen(), examCode, examDateStr, examTimeStr, 
                            ct.getDiaDiem(), registrationCode, dk.getSoTienPhaiTra(), 
                            dk.getMucGiam(), dk.isDaTungThi(), dk.getMaCodeGiamGia());
                        String subject = "[VSTEP] Xác nhận thanh toán ca thi - " + examCode;
                        
                        EmailService.sendEmailWithAttachment(
                            user.getEmail(),
                            subject,
                            htmlBody,
                            true,
                            pdfBytes,
                            fileName
                        );
                    }
                } catch (Exception e) {
                    java.util.logging.Logger.getLogger(PaymentServlet.class.getName())
                        .log(java.util.logging.Level.SEVERE, "Lỗi khi tạo hóa đơn PDF cho ca thi", e);
                }
            });
            
            req.setAttribute("dangKyThi", dk);
            req.setAttribute("caThi", caThiService.findById(dk.getCaThiId()));
        } else {
            DangKyLop dk = dangKyLopService.findById(session.getRegistrationId());
            if (dk == null) {
                PaymentStore.invalidate(token);
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Đăng ký không tồn tại");
                return;
            }
            LopOn lop = lopOnService.findById(dk.getLopOnId());
            // Tính số tiền phải trả = học phí - mức giảm
            long soTienPhaiTra = (lop != null) ? Math.max(0, lop.getHocPhi() - dk.getMucGiam()) : dk.getSoTienDaTra();
            if (soTienPhaiTra > 0 && dk.getSoTienDaTra() < soTienPhaiTra) {
                dk.setSoTienDaTra(soTienPhaiTra);
            }
            dk.setTrangThai("Đã duyệt");
            dangKyLopService.update(dk);

            // Tạo và lưu hóa đơn PDF khi thanh toán thành công
            java.util.concurrent.CompletableFuture.runAsync(() -> {
                try {
                    NguoiDung user = nguoiDungService.findById(dk.getNguoiDungId());
                    if (user != null && lop != null && user.getEmail() != null && !user.getEmail().isBlank()) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                        java.text.SimpleDateFormat regDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                        
                        String startDateStr = lop.getNgayKhaiGiang() != null ? dateFormat.format(lop.getNgayKhaiGiang()) : "";
                        String endDateStr = lop.getNgayKetThuc() != null ? dateFormat.format(lop.getNgayKetThuc()) : "";
                        String registrationDateStr = dk.getNgayDangKy() != null 
                            ? regDateFormat.format(dk.getNgayDangKy()) 
                            : "N/A";
                        
                        String invoiceNumber = "INV-CLASS-" + dk.getId() + "-" + 
                            new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                        
                        // Tạo PDF hóa đơn thanh toán
                        byte[] pdfBytes = InvoicePdfService.generateClassInvoicePdf(
                            invoiceNumber,
                            user.getHoTen(),
                            user.getEmail(),
                            user.getSoDienThoai(),
                            user.getDonVi(),
                            lop.getMaLop() != null ? lop.getMaLop() : "N/A",
                            lop.getTieuDe() != null ? lop.getTieuDe() : "",
                            lop.getHinhThuc(),
                            lop.getNhipDo(),
                            startDateStr,
                            endDateStr,
                            lop.getThoiGianHoc(),
                            dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "N/A",
                            registrationDateStr,
                            lop.getHocPhi(),
                            dk.getMucGiam(),
                            dk.getSoTienDaTra(),
                            dk.getMaCodeGiamGia()
                        );
                        
                        // Lưu file PDF vào thư mục
                        String fileName = "Hoa_don_thanh_toan_lop_" + (lop.getMaLop() != null ? lop.getMaLop().replaceAll("[^a-zA-Z0-9]", "_") : "lop") + "_" + 
                            new java.text.SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".pdf";
                        String filePath = InvoiceFileUtil.saveInvoiceFile(pdfBytes, fileName);
                        
                        // Lưu thông tin hóa đơn vào database
                        HoaDon hoaDon = new HoaDon();
                        hoaDon.setSoHoaDon(invoiceNumber);
                        hoaDon.setNguoiDungId(user.getId());
                        hoaDon.setLoai("lop_on");
                        hoaDon.setDangKyId(dk.getId());
                        hoaDon.setFilePath(filePath);
                        hoaDon.setFileName(fileName);
                        hoaDon.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
                        hoaDon.setTrangThai("Đã thanh toán");
                        
                        HoaDonService hoaDonService = new HoaDonServiceImpl();
                        hoaDonService.create(hoaDon);
                        
                        // Gửi email với PDF hóa đơn
                        String classCode = lop.getMaLop() != null ? lop.getMaLop() : "";
                        String classTitle = lop.getTieuDe() != null ? lop.getTieuDe() : "";
                        String scheduleText = "";
                        StringBuilder sb = new StringBuilder();
                        if (lop.getNgayKhaiGiang() != null) {
                            sb.append(dateFormat.format(lop.getNgayKhaiGiang()));
                        }
                        if (lop.getThoiGianHoc() != null && !lop.getThoiGianHoc().isBlank()) {
                            if (!sb.isEmpty()) sb.append(" · ");
                            sb.append(lop.getThoiGianHoc());
                        }
                        if (lop.getHinhThuc() != null && !lop.getHinhThuc().isBlank()) {
                            if (!sb.isEmpty()) sb.append(" · ");
                            sb.append(lop.getHinhThuc());
                        }
                        scheduleText = sb.toString();
                        
                        String htmlBody = "<html><body>" +
                            "<h2>Xác nhận thanh toán thành công</h2>" +
                            "<p>Xin chào <strong>" + escapeHtml(user.getHoTen()) + "</strong>,</p>" +
                            "<p>Thanh toán của bạn đã được xác nhận. Vui lòng xem hóa đơn đính kèm.</p>" +
                            "<p>Mã đăng ký: <strong>" + escapeHtml(dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "N/A") + "</strong></p>" +
                            "<p>Cảm ơn bạn đã sử dụng dịch vụ của VSTEP!</p>" +
                            "</body></html>";
                        
                        String subject = "[VSTEP] Xác nhận thanh toán lớp - " + classCode;
                        
                        EmailService.sendEmailWithAttachment(
                            user.getEmail(),
                            subject,
                            htmlBody,
                            true,
                            pdfBytes,
                            fileName
                        );
                    }
                } catch (Exception e) {
                    java.util.logging.Logger.getLogger(PaymentServlet.class.getName())
                        .log(java.util.logging.Level.SEVERE, "Lỗi khi tạo hóa đơn PDF cho lớp ôn", e);
                }
            });
            
            req.setAttribute("dangKy", dk);
            req.setAttribute("lopOn", lop);
        }

        session.markUsed();
        PaymentStore.invalidate(token);
        req.setAttribute("isExam", isExamFinal);
        req.getRequestDispatcher("/WEB-INF/views/public/payment-success.jsp").forward(req, resp);
    }

    /**
     * Tự động hủy đăng ký nếu payment session hết hạn mà chưa thanh toán
     */
    private void cleanupExpiredRegistration(PaymentStore.PaymentSession session) {
        try {
            boolean isExam = session.isExam();
            if (isExam) {
                DangKyThi dk = dangKyThiService.findById(session.getRegistrationId());
                if (dk != null && "Chờ xác nhận".equals(dk.getTrangThai())) {
                    // Chỉ hủy nếu vẫn còn trạng thái "Chờ xác nhận" (chưa thanh toán)
                    dk.setTrangThai("Đã hủy");
                    dangKyThiService.update(dk);
                }
            } else {
                DangKyLop dk = dangKyLopService.findById(session.getRegistrationId());
                if (dk != null && "Chờ xác nhận".equals(dk.getTrangThai()) && dk.getSoTienDaTra() == 0) {
                    // Chỉ hủy nếu vẫn còn trạng thái "Chờ xác nhận" và chưa thanh toán
                    dk.setTrangThai("Đã hủy");
                    dangKyLopService.update(dk);
                }
            }
        } catch (Exception e) {
            // Log error nhưng không throw để không ảnh hưởng đến flow chính
            java.util.logging.Logger.getLogger(PaymentServlet.class.getName())
                .log(java.util.logging.Level.WARNING, "Lỗi khi cleanup expired registration", e);
        }
    }

    private long parseLong(String v) {
        if (v == null || v.isBlank()) return 0L;
        try {
            return Long.parseLong(v.trim());
        } catch (NumberFormatException ex) {
            return 0L;
        }
    }
    
    private String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}



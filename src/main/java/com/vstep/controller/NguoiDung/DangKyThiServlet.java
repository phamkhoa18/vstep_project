package com.vstep.controller.NguoiDung;

import java.io.IOException;
import java.util.List;

import com.vstep.model.CaThi;
import com.vstep.model.DangKyThi;
import com.vstep.model.NguoiDung;
import com.vstep.service.CaThiService;
import com.vstep.service.DangKyThiService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.DangKyThiServiceImpl;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import com.vstep.util.CaThiUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DangKyThiServlet", urlPatterns = {"/dang-ky-thi", "/user/register-exam"})
public class DangKyThiServlet extends HttpServlet {

    private CaThiService caThiService;
    private DangKyThiService dangKyThiService;
    private NguoiDungService nguoiDungService;

    @Override
    public void init() throws ServletException {
        super.init();
        caThiService = new CaThiServiceImpl();
        dangKyThiService = new DangKyThiServiceImpl();
        nguoiDungService = new NguoiDungServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("userLogin");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap?redirect=" + 
                java.net.URLEncoder.encode(req.getRequestURI() + "?" + req.getQueryString(), "UTF-8"));
            return;
        }

        // Lấy danh sách đăng ký của user
        List<DangKyThi> userRegistrations = dangKyThiService.findByNguoiDungId(user.getId());
        java.util.List<java.util.Map<String, Object>> userRegistrationsWithDetails = new java.util.ArrayList<>();
        if (userRegistrations != null) {
            for (DangKyThi dk : userRegistrations) {
                if (dk != null) {
                    java.util.Map<String, Object> detail = new java.util.HashMap<>();
                    detail.put("dangKyThi", dk);
                    CaThi ct = caThiService.findById(dk.getCaThiId());
                    detail.put("caThi", ct != null ? ct : new CaThi()); // Đảm bảo không null
                    userRegistrationsWithDetails.add(detail);
                }
            }
        }
        req.setAttribute("userRegistrationsWithDetails", userRegistrationsWithDetails);
        // Debug log
        System.out.println("DEBUG: Loaded " + userRegistrationsWithDetails.size() + " registrations for user " + user.getId());

        // Lấy caThiId từ parameter
        String caThiIdParam = req.getParameter("caThiId");
        if (caThiIdParam == null || caThiIdParam.isEmpty()) {
            // Nếu không có caThiId, hiển thị danh sách ca thi để chọn
            List<CaThi> caThiList = caThiService.findAll();
            // Tính số lượng đăng ký cho mỗi ca thi và kiểm tra trạng thái khóa
            java.util.List<java.util.Map<String, Object>> caThiListWithDetails = new java.util.ArrayList<>();
            for (CaThi ct : caThiList) {
                java.util.Map<String, Object> detail = new java.util.HashMap<>();
                detail.put("caThi", ct);
                int count = dangKyThiService.countByCaThiId(ct.getId());
                detail.put("soLuongDangKy", count);
                // Kiểm tra ca thi có bị khóa không
                boolean isLocked = CaThiUtil.isLocked(ct);
                detail.put("isLocked", isLocked);
                detail.put("statusMessage", CaThiUtil.getStatusMessage(ct));
                caThiListWithDetails.add(detail);
            }
            req.setAttribute("caThiListWithDetails", caThiListWithDetails);
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
            return;
        }

        try {
            long caThiId = Long.parseLong(caThiIdParam);
            CaThi caThi = caThiService.findById(caThiId);
            
            if (caThi == null) {
                req.setAttribute("errorMessage", "Không tìm thấy ca thi");
                List<CaThi> caThiList = caThiService.findAll();
                req.setAttribute("caThiList", caThiList);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra xem user đã đăng ký chưa
            DangKyThi existing = dangKyThiService.findByNguoiDungIdAndCaThiId(user.getId(), caThiId);
            if (existing != null) {
                req.setAttribute("errorMessage", "Bạn đã đăng ký ca thi này rồi");
                req.setAttribute("caThi", caThi);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra ca thi có bị khóa không
            if (CaThiUtil.isLocked(caThi)) {
                req.setAttribute("errorMessage", "Ca thi này đã bị khóa. " + CaThiUtil.getStatusMessage(caThi));
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.setAttribute("isLocked", true);
                req.setAttribute("soLuongDangKy", dangKyThiService.countByCaThiId(caThiId));
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }
            
            // Kiểm tra sức chứa
            int soLuongDangKy = dangKyThiService.countByCaThiId(caThiId);
            if (soLuongDangKy >= caThi.getSucChua()) {
                req.setAttribute("errorMessage", "Ca thi đã đầy (" + soLuongDangKy + "/" + caThi.getSucChua() + "), không thể đăng ký thêm");
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.setAttribute("soLuongDangKy", soLuongDangKy);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("caThi", caThi);
            req.setAttribute("user", user);
            req.setAttribute("soLuongDangKy", soLuongDangKy);
            // Đảm bảo userRegistrationsWithDetails đã được set ở đầu method
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã ca thi không hợp lệ");
            List<CaThi> caThiList = caThiService.findAll();
            req.setAttribute("caThiList", caThiList);
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập
        NguoiDung user = (NguoiDung) req.getSession().getAttribute("userLogin");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        // Lấy danh sách đăng ký của user (để hiển thị trong mọi trường hợp)
        List<DangKyThi> userRegistrations = dangKyThiService.findByNguoiDungId(user.getId());
        java.util.List<java.util.Map<String, Object>> userRegistrationsWithDetails = new java.util.ArrayList<>();
        for (DangKyThi dk : userRegistrations) {
            if (dk != null) {
                java.util.Map<String, Object> detail = new java.util.HashMap<>();
                detail.put("dangKyThi", dk);
                CaThi ct = caThiService.findById(dk.getCaThiId());
                detail.put("caThi", ct != null ? ct : new CaThi()); // Đảm bảo không null
                userRegistrationsWithDetails.add(detail);
            }
        }
        req.setAttribute("userRegistrationsWithDetails", userRegistrationsWithDetails);

        // Lấy thông tin từ form
        String caThiIdParam = req.getParameter("caThiId");
        String daTungThiParam = req.getParameter("daTungThi");

        // Validate thông tin bắt buộc
        if (caThiIdParam == null || caThiIdParam.isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng chọn ca thi để đăng ký");
            // Load danh sách ca thi để hiển thị
            List<CaThi> caThiList = caThiService.findAll();
            java.util.List<java.util.Map<String, Object>> caThiListWithDetails = new java.util.ArrayList<>();
            for (CaThi ct : caThiList) {
                java.util.Map<String, Object> detail = new java.util.HashMap<>();
                detail.put("caThi", ct);
                int count = dangKyThiService.countByCaThiId(ct.getId());
                detail.put("soLuongDangKy", count);
                boolean isLocked = CaThiUtil.isLocked(ct);
                detail.put("isLocked", isLocked);
                detail.put("statusMessage", CaThiUtil.getStatusMessage(ct));
                caThiListWithDetails.add(detail);
            }
            req.setAttribute("caThiListWithDetails", caThiListWithDetails);
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
            return;
        }

        try {
            long caThiId = Long.parseLong(caThiIdParam);
            CaThi caThi = caThiService.findById(caThiId);
            
            if (caThi == null) {
                req.setAttribute("errorMessage", "Không tìm thấy ca thi");
                // Load danh sách ca thi để hiển thị
                List<CaThi> caThiList = caThiService.findAll();
                java.util.List<java.util.Map<String, Object>> caThiListWithDetails = new java.util.ArrayList<>();
                for (CaThi ct : caThiList) {
                    java.util.Map<String, Object> detail = new java.util.HashMap<>();
                    detail.put("caThi", ct);
                    int count = dangKyThiService.countByCaThiId(ct.getId());
                    detail.put("soLuongDangKy", count);
                    boolean isLocked = CaThiUtil.isLocked(ct);
                    detail.put("isLocked", isLocked);
                    detail.put("statusMessage", CaThiUtil.getStatusMessage(ct));
                    caThiListWithDetails.add(detail);
                }
                req.setAttribute("caThiListWithDetails", caThiListWithDetails);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra xem user đã đăng ký chưa
            DangKyThi existing = dangKyThiService.findByNguoiDungIdAndCaThiId(user.getId(), caThiId);
            if (existing != null) {
                req.setAttribute("errorMessage", "Bạn đã đăng ký ca thi này rồi");
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra ca thi có bị khóa không
            if (CaThiUtil.isLocked(caThi)) {
                req.setAttribute("errorMessage", "Ca thi này đã bị khóa. " + CaThiUtil.getStatusMessage(caThi));
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.setAttribute("isLocked", true);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }
            
            // Kiểm tra sức chứa
            int soLuongDangKy = dangKyThiService.countByCaThiId(caThiId);
            if (soLuongDangKy >= caThi.getSucChua()) {
                req.setAttribute("errorMessage", "Ca thi đã đầy (" + soLuongDangKy + "/" + caThi.getSucChua() + "), không thể đăng ký thêm");
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
                return;
            }

            // Tính toán giá
            boolean daTungThi = "true".equals(daTungThiParam) || "on".equals(daTungThiParam);
            long mucGiam = 0;
            long soTienPhaiTra = caThi.getGiaGoc();
            
            // Lấy cấu hình giảm giá từ service
            com.vstep.service.ConfigGiamGiaService configGiamGiaService = new com.vstep.serviceImpl.ConfigGiamGiaServiceImpl();
            
            // Nếu đã từng thi thì giảm giá theo cấu hình
            if (daTungThi) {
                mucGiam = configGiamGiaService.getMucGiamThiLai("ca_thi");
                soTienPhaiTra = Math.max(0, caThi.getGiaGoc() - mucGiam); // Không âm
            }
            
            // Áp dụng mã code giảm giá nếu có
            String maCodeParam = req.getParameter("maCode");
            String maCode = null;
            if (maCodeParam != null && !maCodeParam.trim().isEmpty()) {
                maCode = maCodeParam.trim().toUpperCase();
                com.vstep.service.MaGiamGiaService maGiamGiaService = new com.vstep.serviceImpl.MaGiamGiaServiceImpl();
                long discountFromCode = maGiamGiaService.calculateDiscount(maCode, "ca_thi", soTienPhaiTra);
                if (discountFromCode > 0) {
                    mucGiam += discountFromCode;
                    soTienPhaiTra = Math.max(0, soTienPhaiTra - discountFromCode);
                    
                    // Tăng số lượng đã sử dụng của mã code
                    com.vstep.model.MaGiamGia ma = maGiamGiaService.findByMaCode(maCode);
                    if (ma != null) {
                        ma.setSoLuongDaSuDung(ma.getSoLuongDaSuDung() + 1);
                        maGiamGiaService.update(ma);
                    }
                }
            }

            // Tạo đăng ký mới
            DangKyThi dangKyThi = new DangKyThi();
            dangKyThi.setNguoiDungId(user.getId());
            dangKyThi.setCaThiId(caThiId);
            dangKyThi.setDaTungThi(daTungThi);
            dangKyThi.setMucGiam(mucGiam);
            dangKyThi.setSoTienPhaiTra(soTienPhaiTra);
            dangKyThi.setTrangThai("Chờ xác nhận");
            if (maCode != null) {
                dangKyThi.setMaCodeGiamGia(maCode);
            }

            boolean success = dangKyThiService.create(dangKyThi);
            
            if (success) {
                // Không gửi email cho học viên khi đăng ký - chỉ gửi email và hóa đơn khi thanh toán thành công
                // Email và hóa đơn sẽ được gửi trong PaymentServlet khi thanh toán thành công
                
                // Gửi email thông báo cho admin (để admin biết có đăng ký mới)
                try {
                    List<NguoiDung> admins = nguoiDungService.findByVaiTro("admin");
                    if (admins != null && !admins.isEmpty()) {
                        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
                        java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
                        String examDateStr = caThi.getNgayThi() != null ? dateFormat.format(caThi.getNgayThi()) : "Chưa có thông tin";
                        String examTimeStr = caThi.getGioBatDau() != null ? timeFormat.format(caThi.getGioBatDau()) : "Chưa có thông tin";
                        if (caThi.getGioKetThuc() != null) {
                            examTimeStr += " - " + timeFormat.format(caThi.getGioKetThuc());
                        }
                        
                        java.text.SimpleDateFormat regDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                        String registrationDate = dangKyThi.getNgayDangKy() != null 
                            ? regDateFormat.format(dangKyThi.getNgayDangKy()) 
                            : "N/A";
                        
                        String examCode = caThi.getMaCaThi() != null ? caThi.getMaCaThi() : "Ca thi #" + caThi.getId();
                        String registrationCode = dangKyThi.getMaXacNhan() != null ? dangKyThi.getMaXacNhan() : "N/A";
                        
                        for (NguoiDung admin : admins) {
                            if (admin.getEmail() != null && !admin.getEmail().trim().isEmpty()) {
                                com.vstep.util.EmailService.sendExamRegistrationNotificationToAdmin(
                                    admin.getEmail(),
                                    user.getHoTen(),
                                    user.getEmail(),
                                    user.getSoDienThoai(),
                                    examCode,
                                    examDateStr,
                                    examTimeStr,
                                    registrationCode,
                                    registrationDate
                                );
                            }
                        }
                    }
                } catch (java.lang.Exception e) {
                    // Log lỗi nhưng không ảnh hưởng đến flow chính
                    java.util.logging.Logger.getLogger(DangKyThiServlet.class.getName())
                        .log(java.util.logging.Level.WARNING, "Lỗi khi gửi email thông báo cho admin", e);
                }
                
                // Sau khi đăng ký thành công -> chuyển đến trang thanh toán QR
                resp.sendRedirect(req.getContextPath() + "/payment/start?dkId=" + dangKyThi.getId() + "&type=exam");
            } else {
                req.setAttribute("errorMessage", "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại.");
                req.setAttribute("caThi", caThi);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã ca thi không hợp lệ");
            // Load danh sách ca thi để hiển thị
            List<CaThi> caThiList = caThiService.findAll();
            java.util.List<java.util.Map<String, Object>> caThiListWithDetails = new java.util.ArrayList<>();
            for (CaThi ct : caThiList) {
                java.util.Map<String, Object> detail = new java.util.HashMap<>();
                detail.put("caThi", ct);
                int count = dangKyThiService.countByCaThiId(ct.getId());
                detail.put("soLuongDangKy", count);
                boolean isLocked = CaThiUtil.isLocked(ct);
                detail.put("isLocked", isLocked);
                detail.put("statusMessage", CaThiUtil.getStatusMessage(ct));
                caThiListWithDetails.add(detail);
            }
            req.setAttribute("caThiListWithDetails", caThiListWithDetails);
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            try {
                long caThiId = Long.parseLong(caThiIdParam);
                CaThi ct = caThiService.findById(caThiId);
                req.setAttribute("caThi", ct);
                if (ct != null) {
                    int soLuongDangKy = dangKyThiService.countByCaThiId(ct.getId());
                    req.setAttribute("soLuongDangKy", soLuongDangKy);
                }
            } catch (Exception ex) {
                // Ignore
            }
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/user-register-exam.jsp").forward(req, resp);
        }
    }
}


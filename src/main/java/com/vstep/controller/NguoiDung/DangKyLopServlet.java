package com.vstep.controller.NguoiDung;

import com.vstep.model.DangKyLop;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.service.DangKyLopService;
import com.vstep.service.LopOnService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.DangKyLopServiceImpl;
import com.vstep.serviceImpl.LopOnServiceImpl;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import com.vstep.util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@WebServlet(name = "DangKyLopServlet", urlPatterns = {"/dang-ky-lop", "/user/register-class"})
public class DangKyLopServlet extends HttpServlet {

    private LopOnService lopOnService;
    private DangKyLopService dangKyLopService;
    private NguoiDungService nguoiDungService;

    @Override
    public void init() throws ServletException {
        super.init();
        lopOnService = new LopOnServiceImpl();
        dangKyLopService = new DangKyLopServiceImpl();
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

        // Lấy lopId từ parameter
        String lopIdParam = req.getParameter("lopId");
        if (lopIdParam == null || lopIdParam.isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng chọn lớp để đăng ký");
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            return;
        }

        try {
            long lopId = Long.parseLong(lopIdParam);
            LopOn lop = lopOnService.findById(lopId);
            
            if (lop == null) {
                req.setAttribute("errorMessage", "Không tìm thấy lớp ôn");
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra xem user đã đăng ký chưa
            DangKyLop existing = dangKyLopService.findByNguoiDungIdAndLopOnId(user.getId(), lopId);
            if (existing != null) {
                req.setAttribute("errorMessage", "Bạn đã đăng ký lớp này rồi");
                req.setAttribute("lop", lop);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra sĩ số
            int soLuongDangKy = dangKyLopService.countByLopOnId(lopId);
            if (soLuongDangKy >= lop.getSiSoToiDa()) {
                req.setAttribute("errorMessage", "Lớp đã đầy (" + soLuongDangKy + "/" + lop.getSiSoToiDa() + "), không thể đăng ký thêm");
                req.setAttribute("lop", lop);
                req.setAttribute("user", user);
                req.setAttribute("soLuongDangKy", soLuongDangKy);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("lop", lop);
            req.setAttribute("user", user); // Set user để form có thể hiển thị thông tin
            req.setAttribute("soLuongDangKy", soLuongDangKy); // Để hiển thị số lượng đã đăng ký
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã lớp không hợp lệ");
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
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

        // Lấy thông tin từ form
        String lopIdParam = req.getParameter("lopId");
        String hoTen = req.getParameter("hoTen");
        String email = req.getParameter("email");
        String soDienThoai = req.getParameter("soDienThoai");
        String donVi = req.getParameter("donVi");
        String ghiChu = req.getParameter("ghiChu");

        // Validate thông tin bắt buộc
        if (lopIdParam == null || lopIdParam.isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng chọn lớp để đăng ký");
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            return;
        }

        if (hoTen == null || hoTen.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng nhập họ và tên");
            req.setAttribute("lop", lopOnService.findById(Long.parseLong(lopIdParam)));
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng nhập email");
            req.setAttribute("lop", lopOnService.findById(Long.parseLong(lopIdParam)));
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            return;
        }

        if (soDienThoai == null || soDienThoai.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Vui lòng nhập số điện thoại");
            req.setAttribute("lop", lopOnService.findById(Long.parseLong(lopIdParam)));
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            return;
        }

        try {
            long lopId = Long.parseLong(lopIdParam);
            LopOn lop = lopOnService.findById(lopId);
            
            if (lop == null) {
                req.setAttribute("errorMessage", "Không tìm thấy lớp ôn");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra xem user đã đăng ký chưa
            DangKyLop existing = dangKyLopService.findByNguoiDungIdAndLopOnId(user.getId(), lopId);
            if (existing != null) {
                req.setAttribute("errorMessage", "Bạn đã đăng ký lớp này rồi");
                req.setAttribute("lop", lop);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            // Kiểm tra sĩ số - CHẶN VƯỢT SĨ SỐ
            int soLuongDangKy = dangKyLopService.countByLopOnId(lopId);
            if (soLuongDangKy >= lop.getSiSoToiDa()) {
                req.setAttribute("errorMessage", "Lớp đã đầy (" + soLuongDangKy + "/" + lop.getSiSoToiDa() + "), không thể đăng ký thêm");
                req.setAttribute("lop", lop);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
                return;
            }

            // Cập nhật thông tin user nếu có thay đổi
            // Lưu ý: user từ session đã có password (đã hash), nên khi update sẽ giữ nguyên password
            boolean userUpdated = false;
            boolean hasChanges = false;
            
            if (user.getHoTen() == null || !hoTen.trim().equals(user.getHoTen())) {
                user.setHoTen(hoTen.trim());
                hasChanges = true;
            }
            if (user.getEmail() == null || !email.trim().equals(user.getEmail())) {
                user.setEmail(email.trim());
                hasChanges = true;
            }
            if (user.getSoDienThoai() == null || !soDienThoai.trim().equals(user.getSoDienThoai())) {
                user.setSoDienThoai(soDienThoai.trim());
                hasChanges = true;
            }
            String donViValue = (donVi != null && !donVi.trim().isEmpty()) ? donVi.trim() : null;
            if ((user.getDonVi() == null && donViValue != null) || 
                (user.getDonVi() != null && !user.getDonVi().equals(donViValue))) {
                user.setDonVi(donViValue);
                hasChanges = true;
            }
            
            if (hasChanges) {
                // Reload user từ database để đảm bảo có đầy đủ thông tin (bao gồm password đã hash)
                NguoiDung userFromDb = nguoiDungService.findById(user.getId());
                if (userFromDb != null) {
                    // Giữ nguyên password từ database
                    String savedPassword = userFromDb.getMatKhau();
                    // Cập nhật các trường thay đổi
                    userFromDb.setHoTen(user.getHoTen());
                    userFromDb.setEmail(user.getEmail());
                    userFromDb.setSoDienThoai(user.getSoDienThoai());
                    userFromDb.setDonVi(user.getDonVi());
                    // Đảm bảo password không bị mất
                    if (savedPassword != null && !savedPassword.isEmpty()) {
                        userFromDb.setMatKhau(savedPassword);
                    }
                    
                    userUpdated = nguoiDungService.update(userFromDb);
                    if (userUpdated) {
                        // Cập nhật lại session với thông tin mới
                        req.getSession().setAttribute("userLogin", userFromDb);
                        user = userFromDb; // Cập nhật biến local
                    }
                }
            }

            // Tạo đăng ký mới
            DangKyLop dangKyLop = new DangKyLop();
            dangKyLop.setNguoiDungId(user.getId());
            dangKyLop.setLopOnId(lopId);
            dangKyLop.setGhiChu(ghiChu != null && !ghiChu.trim().isEmpty() ? ghiChu.trim() : null);
            dangKyLop.setSoTienDaTra(0); // Chưa thanh toán
            dangKyLop.setTrangThai("Chờ xác nhận");

            boolean success = dangKyLopService.create(dangKyLop);
            
            if (success) {
                // Gửi email thông báo cho admin (chạy bất đồng bộ để không làm chậm response)
                sendRegistrationNotificationToAdmins(user, lop, dangKyLop);
                
                // Redirect đến trang thành công hoặc trang lớp đã đăng ký
                resp.sendRedirect(req.getContextPath() + "/lop-da-dang-ky?success=registered&lopId=" + lopId);
            } else {
                req.setAttribute("errorMessage", "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại.");
                req.setAttribute("lop", lop);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã lớp không hợp lệ");
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            try {
                long lopId = Long.parseLong(lopIdParam);
                req.setAttribute("lop", lopOnService.findById(lopId));
            } catch (Exception ex) {
                // Ignore
            }
            req.setAttribute("user", user);
            req.getRequestDispatcher("/WEB-INF/views/user/register-class-form.jsp").forward(req, resp);
        }
    }

    /**
     * Gửi email thông báo đăng ký mới cho tất cả admin
     */
    private void sendRegistrationNotificationToAdmins(NguoiDung student, LopOn lop, DangKyLop registration) {
        // Chạy bất đồng bộ để không làm chậm response
        CompletableFuture.runAsync(() -> {
            try {
                // Lấy danh sách tất cả admin
                List<NguoiDung> admins = nguoiDungService.findByVaiTro("admin");
                
                if (admins == null || admins.isEmpty()) {
                    return;
                }

                // Format ngày đăng ký
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                String registrationDate = registration.getNgayDangKy() != null 
                    ? dateFormat.format(registration.getNgayDangKy()) 
                    : "N/A";

                // Gửi email cho từng admin
                for (NguoiDung admin : admins) {
                    if (admin.getEmail() != null && !admin.getEmail().trim().isEmpty()) {
                        EmailService.sendRegistrationNotificationToAdmin(
                            admin.getEmail(),
                            student.getHoTen(),
                            student.getEmail(),
                            student.getSoDienThoai(),
                            lop.getTieuDe(),
                            lop.getMaLop() != null ? lop.getMaLop() : "N/A",
                            registration.getMaXacNhan() != null ? registration.getMaXacNhan() : "N/A",
                            registrationDate
                        );
                    }
                }
            } catch (Exception e) {
                // Log lỗi nhưng không ảnh hưởng đến flow chính
                java.util.logging.Logger.getLogger(DangKyLopServlet.class.getName())
                    .log(java.util.logging.Level.WARNING, "Lỗi khi gửi email thông báo cho admin", e);
            }
        });
    }
}


package com.vstep.controller.admin;

import com.vstep.model.NguoiDung;
import com.vstep.repository.DangKyLopRepository;
import com.vstep.repository.DangKyThiRepository;
import com.vstep.repository.LopOnRepository;
import com.vstep.repositoryImpl.DangKyLopRepositoryImpl;
import com.vstep.repositoryImpl.DangKyThiRepositoryImpl;
import com.vstep.repositoryImpl.LopOnRepositoryImpl;
import com.vstep.service.CaThiService;
import com.vstep.serviceImpl.CaThiServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private LopOnRepository lopOnRepository = new LopOnRepositoryImpl();
    private DangKyLopRepository dangKyLopRepository = new DangKyLopRepositoryImpl();
    private CaThiService caThiService = new CaThiServiceImpl();
    private DangKyThiRepository dangKyThiRepository = new DangKyThiRepositoryImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập admin
        HttpSession session = req.getSession(false);
        NguoiDung admin = session != null ? (NguoiDung) session.getAttribute("userLogin") : null;
        if (admin == null || !"admin".equals(admin.getVaiTro())) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }
        
        // Lấy tham số lọc (nếu có)
        String period = req.getParameter("period"); // "today", "week", "month", "all"
        if (period == null || period.isEmpty()) {
            period = "month"; // Mặc định tháng này
        }
        
        Date startDate = null;
        Date endDate = null;
        LocalDate now = LocalDate.now();
        
        switch (period) {
            case "today":
                startDate = Date.valueOf(now);
                endDate = Date.valueOf(now);
                break;
            case "week":
                startDate = Date.valueOf(now.minusDays(7));
                endDate = Date.valueOf(now);
                break;
            case "month":
                startDate = Date.valueOf(now.withDayOfMonth(1));
                endDate = Date.valueOf(now);
                break;
            case "all":
            default:
                startDate = null;
                endDate = null;
                break;
        }
        
        // ========== THỐNG KÊ LỚP ÔN ==========
        List<com.vstep.model.LopOn> allClasses = lopOnRepository.findAll();
        int totalClasses = allClasses != null ? allClasses.size() : 0;
        
        // Đếm số lớp đang hoạt động
        int activeClasses = 0;
        int totalStudents = 0;
        List<Map<String, Object>> classStats = new ArrayList<>();
        
        if (allClasses != null) {
            for (com.vstep.model.LopOn lop : allClasses) {
                String tinhTrang = lop.getTinhTrang();
                if (tinhTrang != null && 
                    (tinhTrang.contains("Đang") || tinhTrang.contains("Sắp") || 
                     tinhTrang.contains("Hoạt động") || tinhTrang.contains("Sắp khai giảng"))) {
                    activeClasses++;
                }
                
                int soLuongDangKy = dangKyLopRepository.countByLopOnId(lop.getId());
                int siSoToiDa = lop.getSiSoToiDa();
                double fillRate = siSoToiDa > 0 ? (soLuongDangKy * 100.0 / siSoToiDa) : 0;
                
                Map<String, Object> classStat = new HashMap<>();
                classStat.put("lopId", lop.getId());
                classStat.put("maLop", lop.getMaLop());
                classStat.put("tieuDe", lop.getTieuDe());
                classStat.put("soLuongDangKy", soLuongDangKy);
                classStat.put("siSoToiDa", siSoToiDa);
                classStat.put("fillRate", Math.round(fillRate * 10.0) / 10.0);
                classStat.put("tinhTrang", lop.getTinhTrang());
                classStats.add(classStat);
                
                totalStudents += soLuongDangKy;
            }
        }
        
        // ========== THỐNG KÊ CA THI ==========
        List<com.vstep.model.CaThi> allExams = caThiService.findAll();
        int totalExams = allExams != null ? allExams.size() : 0;
        
        // Đếm ca thi sắp diễn ra (trong 14 ngày tới)
        int upcomingExams = 0;
        int totalExamRegistrations = 0;
        List<Map<String, Object>> examStats = new ArrayList<>();
        
        LocalDate twoWeeksLater = now.plusDays(14);
        
        if (allExams != null) {
            for (com.vstep.model.CaThi caThi : allExams) {
                if (caThi.getNgayThi() != null) {
                    LocalDate examDate = caThi.getNgayThi().toLocalDate();
                    if (examDate.isAfter(now.minusDays(1)) && examDate.isBefore(twoWeeksLater)) {
                        upcomingExams++;
                    }
                }
                
                int soLuongDangKy = dangKyThiRepository.countByCaThiId(caThi.getId());
                int sucChua = caThi.getSucChua();
                int choCon = Math.max(0, sucChua - soLuongDangKy);
                double fillRate = sucChua > 0 ? (soLuongDangKy * 100.0 / sucChua) : 0;
                
                Map<String, Object> examStat = new HashMap<>();
                examStat.put("caThiId", caThi.getId());
                examStat.put("maCaThi", caThi.getMaCaThi());
                examStat.put("ngayThi", caThi.getNgayThi());
                examStat.put("soLuongDangKy", soLuongDangKy);
                examStat.put("sucChua", sucChua);
                examStat.put("choCon", choCon);
                examStat.put("fillRate", Math.round(fillRate * 10.0) / 10.0);
                examStats.add(examStat);
                
                totalExamRegistrations += soLuongDangKy;
            }
        }
        
        // ========== THỐNG KÊ DOANH THU ==========
        long totalRevenue = 0;
        long classRevenue = 0;
        long examRevenue = 0;
        
        // Doanh thu từ lớp ôn
        List<com.vstep.model.DangKyLop> classRegistrations = dangKyLopRepository.findAll();
        if (classRegistrations != null) {
            for (com.vstep.model.DangKyLop dk : classRegistrations) {
                if ("Đã duyệt".equals(dk.getTrangThai())) {
                    long amount = dk.getSoTienDaTra();
                    if (startDate != null && endDate != null && dk.getNgayDangKy() != null) {
                        Date regDate = new Date(dk.getNgayDangKy().getTime());
                        if (regDate.compareTo(startDate) >= 0 && regDate.compareTo(endDate) <= 0) {
                            classRevenue += amount;
                        }
                    } else {
                        classRevenue += amount;
                    }
                }
            }
        }
        
        // Doanh thu từ ca thi
        List<com.vstep.model.DangKyThi> examRegistrations = dangKyThiRepository.findAll();
        if (examRegistrations != null) {
            for (com.vstep.model.DangKyThi dk : examRegistrations) {
                if ("Đã duyệt".equals(dk.getTrangThai())) {
                    long amount = dk.getSoTienPhaiTra();
                    if (startDate != null && endDate != null && dk.getNgayDangKy() != null) {
                        Date regDate = new Date(dk.getNgayDangKy().getTime());
                        if (regDate.compareTo(startDate) >= 0 && regDate.compareTo(endDate) <= 0) {
                            examRevenue += amount;
                        }
                    } else {
                        examRevenue += amount;
                    }
                }
            }
        }
        
        totalRevenue = classRevenue + examRevenue;
        
        // ========== DỮ LIỆU CHO BIỂU ĐỒ ==========
        // Dữ liệu đăng ký theo tuần (tùy theo period)
        List<Map<String, Object>> weeklyData = getWeeklyRegistrationData(period, startDate, endDate);
        if (weeklyData == null) {
            weeklyData = new ArrayList<>();
        }
        
        // Dữ liệu doanh thu theo ngày (tùy theo period)
        List<Map<String, Object>> dailyRevenueData = getDailyRevenueData(period, startDate, endDate);
        if (dailyRevenueData == null) {
            dailyRevenueData = new ArrayList<>();
        }
        
        // Dữ liệu tỉ lệ lấp đầy lớp
        List<Map<String, Object>> classFillRateData = getClassFillRateData();
        if (classFillRateData == null) {
            classFillRateData = new ArrayList<>();
        }
        
        // Set attributes
        req.setAttribute("period", period);
        req.setAttribute("startDate", startDate);
        req.setAttribute("endDate", endDate);
        
        req.setAttribute("totalClasses", totalClasses);
        req.setAttribute("activeClasses", activeClasses);
        req.setAttribute("totalStudents", totalStudents);
        req.setAttribute("classStats", classStats);
        
        req.setAttribute("totalExams", totalExams);
        req.setAttribute("upcomingExams", upcomingExams);
        req.setAttribute("totalExamRegistrations", totalExamRegistrations);
        req.setAttribute("examStats", examStats);
        
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("classRevenue", classRevenue);
        req.setAttribute("examRevenue", examRevenue);
        
        req.setAttribute("weeklyData", weeklyData);
        req.setAttribute("dailyRevenueData", dailyRevenueData);
        req.setAttribute("classFillRateData", classFillRateData);
        
        req.getRequestDispatcher("/WEB-INF/views/admin/admin-dashboard.jsp").forward(req, resp);
    }
    
    /**
     * Lấy dữ liệu đăng ký theo tuần/ngày (tùy theo period)
     */
    private List<Map<String, Object>> getWeeklyRegistrationData(String period, Date startDate, Date endDate) {
        List<Map<String, Object>> data = new ArrayList<>();
        LocalDate now = LocalDate.now();
        LocalDate chartStartDate;
        LocalDate chartEndDate = now;
        boolean useDaily = false; // true nếu hiển thị theo ngày thay vì tuần
        
        // Xác định khoảng thời gian và cách hiển thị
        if ("today".equals(period)) {
            chartStartDate = now;
            chartEndDate = now;
            useDaily = true;
        } else if ("week".equals(period)) {
            chartStartDate = now.minusDays(6);
            chartEndDate = now;
            useDaily = true;
        } else if ("month".equals(period)) {
            chartStartDate = now.withDayOfMonth(1);
            chartEndDate = now;
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate);
            useDaily = daysBetween <= 31; // Nếu <= 31 ngày thì hiển thị theo ngày
        } else if (startDate != null && endDate != null) {
            chartStartDate = startDate.toLocalDate();
            chartEndDate = endDate.toLocalDate();
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate);
            useDaily = daysBetween <= 31;
        } else {
            // "all" - hiển thị tất cả dữ liệu, tìm ngày sớm nhất có dữ liệu
            chartStartDate = now.minusMonths(6); // Hiển thị 6 tháng gần nhất
            chartEndDate = now;
            useDaily = false; // Hiển thị theo tuần cho "all"
        }
        
        // Tối ưu: Chỉ load dữ liệu một lần thay vì load trong mỗi vòng lặp
        List<com.vstep.model.DangKyLop> allClassRegistrations = dangKyLopRepository.findAll();
        List<com.vstep.model.DangKyThi> allExamRegistrations = dangKyThiRepository.findAll();
        
        if (useDaily) {
            // Hiển thị theo ngày
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate);
            int days = (int) daysBetween + 1;
            if (days < 1) days = 1;
            
            for (int i = 0; i < days; i++) {
                LocalDate date = chartStartDate.plusDays(i);
                if (date.isAfter(chartEndDate)) break;
                Date sqlDate = Date.valueOf(date);
                
                // Đếm đăng ký lớp trong ngày
                int classRegs = 0;
                if (allClassRegistrations != null) {
                    for (com.vstep.model.DangKyLop dk : allClassRegistrations) {
                        if (dk.getNgayDangKy() != null) {
                            // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                            LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                    .atZone(java.time.ZoneId.systemDefault())
                                    .toLocalDate();
                            if (regLocalDate.equals(date)) {
                                classRegs++;
                            }
                        }
                    }
                }
                
                // Đếm đăng ký ca thi trong ngày
                int examRegs = 0;
                if (allExamRegistrations != null) {
                    for (com.vstep.model.DangKyThi dk : allExamRegistrations) {
                        if (dk.getNgayDangKy() != null) {
                            // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                            LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                    .atZone(java.time.ZoneId.systemDefault())
                                    .toLocalDate();
                            if (regLocalDate.equals(date)) {
                                examRegs++;
                            }
                        }
                    }
                }
                
                Map<String, Object> dayData = new HashMap<>();
                dayData.put("week", "Ngày " + (i + 1));
                dayData.put("label", new SimpleDateFormat("dd/MM").format(sqlDate));
                dayData.put("classRegistrations", classRegs);
                dayData.put("examRegistrations", examRegs);
                dayData.put("total", classRegs + examRegs);
                data.add(dayData);
            }
        } else {
            // Hiển thị theo tuần
            long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate);
            int weeks = (int) Math.ceil(daysBetween / 7.0);
            if (weeks < 1) weeks = 1;
            if (weeks > 12) weeks = 12;
            
            for (int i = weeks - 1; i >= 0; i--) {
                LocalDate weekStart = chartEndDate.minusWeeks(i).with(java.time.DayOfWeek.MONDAY);
                if (weekStart.isBefore(chartStartDate)) {
                    weekStart = chartStartDate;
                }
                LocalDate weekEnd = weekStart.plusDays(6);
                if (weekEnd.isAfter(chartEndDate)) {
                    weekEnd = chartEndDate;
                }
                
                Date start = Date.valueOf(weekStart);
                Date end = Date.valueOf(weekEnd);
                
                // Đếm đăng ký lớp trong tuần
                int classRegs = 0;
                if (allClassRegistrations != null) {
                    for (com.vstep.model.DangKyLop dk : allClassRegistrations) {
                        if (dk.getNgayDangKy() != null) {
                            // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                            LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                    .atZone(java.time.ZoneId.systemDefault())
                                    .toLocalDate();
                            // Kiểm tra nằm trong khoảng tuần
                            if ((regLocalDate.isAfter(weekStart.minusDays(1)) || regLocalDate.equals(weekStart)) 
                                    && (regLocalDate.isBefore(weekEnd.plusDays(1)) || regLocalDate.equals(weekEnd))) {
                                classRegs++;
                            }
                        }
                    }
                }
                
                // Đếm đăng ký ca thi trong tuần
                int examRegs = 0;
                if (allExamRegistrations != null) {
                    for (com.vstep.model.DangKyThi dk : allExamRegistrations) {
                        if (dk.getNgayDangKy() != null) {
                            // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                            LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                    .atZone(java.time.ZoneId.systemDefault())
                                    .toLocalDate();
                            // Kiểm tra nằm trong khoảng tuần
                            if ((regLocalDate.isAfter(weekStart.minusDays(1)) || regLocalDate.equals(weekStart)) 
                                    && (regLocalDate.isBefore(weekEnd.plusDays(1)) || regLocalDate.equals(weekEnd))) {
                                examRegs++;
                            }
                        }
                    }
                }
                
                Map<String, Object> weekData = new HashMap<>();
                weekData.put("week", "Tuần " + (weeks - i));
                weekData.put("label", new SimpleDateFormat("dd/MM").format(start) + " - " + new SimpleDateFormat("dd/MM").format(end));
                weekData.put("classRegistrations", classRegs);
                weekData.put("examRegistrations", examRegs);
                weekData.put("total", classRegs + examRegs);
                data.add(weekData);
            }
        }
        
        return data;
    }
    
    /**
     * Lấy dữ liệu doanh thu theo ngày (tùy theo period)
     */
    private List<Map<String, Object>> getDailyRevenueData(String period, Date startDate, Date endDate) {
        List<Map<String, Object>> data = new ArrayList<>();
        LocalDate now = LocalDate.now();
        LocalDate chartStartDate = now.minusDays(29);
        LocalDate chartEndDate = now;
        int days = 30;
        
        // Điều chỉnh khoảng thời gian dựa trên period
        if (startDate != null && endDate != null) {
            chartStartDate = startDate.toLocalDate();
            chartEndDate = endDate.toLocalDate();
            days = (int) java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate) + 1;
            if (days < 1) days = 1;
            if (days > 90) days = 90; // Giới hạn tối đa 90 ngày
        } else if ("today".equals(period)) {
            chartStartDate = now;
            chartEndDate = now;
            days = 1;
        } else if ("week".equals(period)) {
            chartStartDate = now.minusDays(6);
            chartEndDate = now;
            days = 7;
        } else if ("month".equals(period)) {
            chartStartDate = now.withDayOfMonth(1);
            chartEndDate = now;
            days = (int) java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate) + 1;
        }
        
        // Tối ưu: Chỉ load dữ liệu một lần
        List<com.vstep.model.DangKyLop> allClassRegistrations = dangKyLopRepository.findAll();
        List<com.vstep.model.DangKyThi> allExamRegistrations = dangKyThiRepository.findAll();
        
        // Tạo dữ liệu theo ngày
        for (int i = 0; i < days; i++) {
            LocalDate date = chartStartDate.plusDays(i);
            if (date.isAfter(chartEndDate)) {
                break;
            }
            Date sqlDate = Date.valueOf(date);
            
            long dailyRevenue = 0;
            
            // Doanh thu từ lớp
            if (allClassRegistrations != null) {
                for (com.vstep.model.DangKyLop dk : allClassRegistrations) {
                    if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                        // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        if (regLocalDate.equals(date)) {
                            dailyRevenue += dk.getSoTienDaTra();
                        }
                    }
                }
            }
            
            // Doanh thu từ ca thi
            if (allExamRegistrations != null) {
                for (com.vstep.model.DangKyThi dk : allExamRegistrations) {
                    if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                        // Convert Timestamp to LocalDate để so sánh chỉ phần ngày
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        if (regLocalDate.equals(date)) {
                            dailyRevenue += dk.getSoTienPhaiTra();
                        }
                    }
                }
            }
            
            Map<String, Object> dayData = new HashMap<>();
            dayData.put("date", new SimpleDateFormat("dd/MM").format(sqlDate));
            dayData.put("revenue", dailyRevenue);
            data.add(dayData);
        }
        
        return data;
    }
    
    /**
     * Lấy dữ liệu tỉ lệ lấp đầy lớp
     */
    private List<Map<String, Object>> getClassFillRateData() {
        List<Map<String, Object>> data = new ArrayList<>();
        List<com.vstep.model.LopOn> allClasses = lopOnRepository.findAll();
        
        if (allClasses != null) {
            Map<String, Integer> categoryCount = new HashMap<>();
            Map<String, Integer> categoryTotal = new HashMap<>();
            
            for (com.vstep.model.LopOn lop : allClasses) {
                String category = "Khác";
                if (lop.getNhipDo() != null) {
                    if (lop.getNhipDo().contains("Cơ bản")) category = "Cơ bản";
                    else if (lop.getNhipDo().contains("Nâng cao")) category = "Nâng cao";
                    else if (lop.getNhipDo().contains("Cấp tốc")) category = "Cấp tốc";
                }
                if (lop.getHinhThuc() != null && lop.getHinhThuc().contains("Online")) {
                    category = "Online";
                }
                
                int soLuongDangKy = dangKyLopRepository.countByLopOnId(lop.getId());
                int siSoToiDa = lop.getSiSoToiDa();
                
                categoryCount.put(category, categoryCount.getOrDefault(category, 0) + soLuongDangKy);
                categoryTotal.put(category, categoryTotal.getOrDefault(category, 0) + siSoToiDa);
            }
            
            for (String category : categoryTotal.keySet()) {
                int count = categoryCount.getOrDefault(category, 0);
                int total = categoryTotal.get(category);
                double rate = total > 0 ? (count * 100.0 / total) : 0;
                
                Map<String, Object> categoryData = new HashMap<>();
                categoryData.put("category", category);
                categoryData.put("count", count);
                categoryData.put("total", total);
                categoryData.put("rate", Math.round(rate * 10.0) / 10.0);
                data.add(categoryData);
            }
        }
        
        return data;
    }
}


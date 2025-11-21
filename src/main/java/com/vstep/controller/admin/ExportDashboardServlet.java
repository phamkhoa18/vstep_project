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

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.sql.Date;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@WebServlet("/admin/export-dashboard")
public class ExportDashboardServlet extends HttpServlet {
    
    private LopOnRepository lopOnRepository = new LopOnRepositoryImpl();
    private DangKyLopRepository dangKyLopRepository = new DangKyLopRepositoryImpl();
    private CaThiService caThiService = new CaThiServiceImpl();
    private DangKyThiRepository dangKyThiRepository = new DangKyThiRepositoryImpl();
    
    private static final NumberFormat currencyFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    
    static {
        currencyFormat.setMaximumFractionDigits(0);
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra đăng nhập admin
        HttpSession session = req.getSession(false);
        NguoiDung admin = session != null ? (NguoiDung) session.getAttribute("userLogin") : null;
        if (admin == null || !"admin".equals(admin.getVaiTro())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String period = req.getParameter("period");
        if (period == null || period.isEmpty()) {
            period = "month";
        }
        
        // Tính toán startDate và endDate theo period
        Date startDate = null;
        Date endDate = null;
        LocalDate now = LocalDate.now();
        
        switch (period) {
            case "today":
                startDate = Date.valueOf(now);
                endDate = Date.valueOf(now);
                break;
            case "week":
                startDate = Date.valueOf(now.minusDays(6));
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
        
        // Tạo workbook
        XSSFWorkbook workbook = new XSSFWorkbook();
        
        // Tạo các sheet
        createCoverSheet(workbook, period, startDate, endDate);
        createSummarySheet(workbook, period, startDate, endDate);
        createClassStatsSheet(workbook, period, startDate, endDate);
        createExamStatsSheet(workbook, period, startDate, endDate);
        createRevenueSheet(workbook, period, startDate, endDate);
        createDailyRevenueSheet(workbook, period, startDate, endDate);
        
        // Set response headers
        String periodLabel = getPeriodLabel(period);
        String fileName = "Bao_cao_VSTEP_" + periodLabel.replaceAll("\\s+", "_") + "_" + 
                         new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".xlsx";
        resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        resp.setCharacterEncoding("UTF-8");
        
        // Write workbook to response
        workbook.write(resp.getOutputStream());
        workbook.close();
    }
    
    private void createCoverSheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Trang bìa");
        
        // Styles
        CellStyle titleStyle = createTitleStyle(workbook);
        CellStyle subtitleStyle = createSubtitleStyle(workbook);
        CellStyle infoStyle = createInfoStyle(workbook);
        
        int rowNum = 0;
        
        // Empty rows
        for (int i = 0; i < 5; i++) {
            sheet.createRow(rowNum++);
        }
        
        // Company/System Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(2);
        titleCell.setCellValue("HỆ THỐNG QUẢN LÝ ÔN & THI VSTEP");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 2, 6));
        
        rowNum++;
        
        // Report Title
        Row reportRow = sheet.createRow(rowNum++);
        Cell reportCell = reportRow.createCell(2);
        reportCell.setCellValue("BÁO CÁO TỔNG HỢP");
        reportCell.setCellStyle(subtitleStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 2, 6));
        
        rowNum += 2;
        
        // Period Info
        Row periodRow = sheet.createRow(rowNum++);
        Cell periodLabelCell = periodRow.createCell(2);
        periodLabelCell.setCellValue("Khoảng thời gian:");
        periodLabelCell.setCellStyle(infoStyle);
        
        Cell periodValueCell = periodRow.createCell(3);
        periodValueCell.setCellValue(getPeriodLabel(period) + getDateRange(startDate, endDate));
        periodValueCell.setCellStyle(infoStyle);
        
        // Date Range
        Row dateRow = sheet.createRow(rowNum++);
        Cell dateLabelCell = dateRow.createCell(2);
        dateLabelCell.setCellValue("Ngày xuất báo cáo:");
        dateLabelCell.setCellStyle(infoStyle);
        
        Cell dateValueCell = dateRow.createCell(3);
        dateValueCell.setCellValue(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()));
        dateValueCell.setCellStyle(infoStyle);
        
        rowNum += 3;
        
        // Summary boxes
        Map<String, Object> stats = calculateStatistics(period, startDate, endDate);
        
        createInfoBox(sheet, rowNum, 2, "Tổng số lớp", String.valueOf(stats.get("totalClasses")), workbook);
        createInfoBox(sheet, rowNum, 4, "Tổng học viên", String.valueOf(stats.get("totalStudents")), workbook);
        createInfoBox(sheet, rowNum, 6, "Tổng ca thi", String.valueOf(stats.get("totalExams")), workbook);
        
        rowNum += 3;
        
        createInfoBox(sheet, rowNum, 2, "Doanh thu lớp ôn", formatCurrency((Long) stats.get("classRevenue")), workbook);
        createInfoBox(sheet, rowNum, 4, "Doanh thu ca thi", formatCurrency((Long) stats.get("examRevenue")), workbook);
        createInfoBox(sheet, rowNum, 6, "Tổng doanh thu", formatCurrency((Long) stats.get("totalRevenue")), workbook);
        
        // Auto-size columns
        for (int i = 0; i < 10; i++) {
            sheet.autoSizeColumn(i);
        }
    }
    
    private void createSummarySheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Tổng quan");
        
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle titleStyle = createTitleStyle(workbook);
        CellStyle currencyStyle = createCurrencyStyle(workbook);
        CellStyle numberStyle = createNumberStyle(workbook);
        CellStyle labelStyle = createLabelStyle(workbook);
        
        int rowNum = 0;
        
        // Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("BÁO CÁO TỔNG QUAN HỆ THỐNG");
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        
        rowNum++;
        
        // Period info
        Row periodRow = sheet.createRow(rowNum++);
        periodRow.createCell(0).setCellValue("Khoảng thời gian:");
        Cell periodCell = periodRow.createCell(1);
        periodCell.setCellValue(getPeriodLabel(period) + getDateRange(startDate, endDate));
        periodCell.setCellStyle(labelStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 1, 3));
        
        rowNum++;
        
        // Calculate statistics
        Map<String, Object> stats = calculateStatistics(period, startDate, endDate);
        
        // Header
        Row headerRow = sheet.createRow(rowNum++);
        String[] headers = {"Chỉ số", "Giá trị", "Ghi chú"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
        
        // Data rows
        createMetricRow(sheet, rowNum++, "Tổng số lớp ôn", String.valueOf(stats.get("totalClasses")), "", numberStyle);
        createMetricRow(sheet, rowNum++, "Lớp đang hoạt động", String.valueOf(stats.get("activeClasses")), "", numberStyle);
        createMetricRow(sheet, rowNum++, "Tổng học viên", formatNumber((Integer) stats.get("totalStudents")), "", numberStyle);
        createMetricRow(sheet, rowNum++, "Tổng số ca thi", String.valueOf(stats.get("totalExams")), "", numberStyle);
        createMetricRow(sheet, rowNum++, "Ca thi sắp diễn ra", String.valueOf(stats.get("upcomingExams")), "", numberStyle);
        createMetricRow(sheet, rowNum++, "Tổng thí sinh đăng ký", formatNumber((Integer) stats.get("totalExamRegs")), "", numberStyle);
        
        rowNum++;
        
        // Revenue section
        Row revenueHeaderRow = sheet.createRow(rowNum++);
        Cell revenueHeaderCell = revenueHeaderRow.createCell(0);
        revenueHeaderCell.setCellValue("DOANH THU");
        revenueHeaderCell.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum - 1, rowNum - 1, 0, 2));
        
        createMetricRow(sheet, rowNum++, "Doanh thu từ lớp ôn", formatCurrency((Long) stats.get("classRevenue")), "VNĐ", currencyStyle);
        createMetricRow(sheet, rowNum++, "Doanh thu từ ca thi", formatCurrency((Long) stats.get("examRevenue")), "VNĐ", currencyStyle);
        
        Row totalRow = sheet.createRow(rowNum++);
        Cell totalLabelCell = totalRow.createCell(0);
        totalLabelCell.setCellValue("TỔNG DOANH THU");
        totalLabelCell.setCellStyle(createBoldStyle(workbook));
        Cell totalValueCell = totalRow.createCell(1);
        totalValueCell.setCellValue(formatCurrency((Long) stats.get("totalRevenue")));
        totalValueCell.setCellStyle(createBoldCurrencyStyle(workbook));
        totalRow.createCell(2).setCellValue("VNĐ");
        
        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
            sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 2000);
        }
    }
    
    private void createClassStatsSheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Thống kê lớp ôn");
        
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle numberStyle = createNumberStyle(workbook);
        CellStyle percentStyle = createPercentStyle(workbook);
        CellStyle textStyle = createTextStyle(workbook);
        
        int rowNum = 0;
        
        // Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("THỐNG KÊ LỚP ÔN LUYỆN");
        titleCell.setCellStyle(createTitleStyle(workbook));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));
        
        rowNum++;
        
        // Header
        Row headerRow = sheet.createRow(rowNum++);
        String[] headers = {"STT", "Mã lớp", "Tên lớp", "Sĩ số đăng ký", "Sĩ số tối đa", "Tỉ lệ lấp đầy (%)", "Tình trạng", "Ghi chú"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
        
        // Data
        List<com.vstep.model.LopOn> allClasses = lopOnRepository.findAll();
        if (allClasses != null) {
            int stt = 1;
            for (com.vstep.model.LopOn lop : allClasses) {
                Row row = sheet.createRow(rowNum++);
                int soLuongDangKy = dangKyLopRepository.countByLopOnId(lop.getId());
                int siSoToiDa = lop.getSiSoToiDa();
                double fillRate = siSoToiDa > 0 ? (soLuongDangKy * 100.0 / siSoToiDa) : 0;
                
                row.createCell(0).setCellValue(stt++);
                row.getCell(0).setCellStyle(numberStyle);
                
                row.createCell(1).setCellValue(lop.getMaLop() != null ? lop.getMaLop() : "");
                row.getCell(1).setCellStyle(textStyle);
                
                row.createCell(2).setCellValue(lop.getTieuDe() != null ? lop.getTieuDe() : "");
                row.getCell(2).setCellStyle(textStyle);
                
                Cell regCell = row.createCell(3);
                regCell.setCellValue(soLuongDangKy);
                regCell.setCellStyle(numberStyle);
                
                Cell maxCell = row.createCell(4);
                maxCell.setCellValue(siSoToiDa);
                maxCell.setCellStyle(numberStyle);
                
                Cell rateCell = row.createCell(5);
                rateCell.setCellValue(Math.round(fillRate * 10.0) / 10.0);
                rateCell.setCellStyle(percentStyle);
                
                row.createCell(6).setCellValue(lop.getTinhTrang() != null ? lop.getTinhTrang() : "");
                row.getCell(6).setCellStyle(textStyle);
                
                row.createCell(7).setCellValue(""); // Ghi chú
                row.getCell(7).setCellStyle(textStyle);
                
                // Conditional formatting - highlight low fill rate
                if (fillRate < 50 && siSoToiDa > 0) {
                    applyConditionalFormatting(row, percentStyle);
                }
            }
        }
        
        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
            if (i == 2) { // Tên lớp column
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
            }
        }
    }
    
    private void createExamStatsSheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Thống kê ca thi");
        
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle numberStyle = createNumberStyle(workbook);
        CellStyle percentStyle = createPercentStyle(workbook);
        CellStyle dateStyle = createDateStyle(workbook);
        CellStyle textStyle = createTextStyle(workbook);
        
        int rowNum = 0;
        
        // Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("THỐNG KÊ CA THI");
        titleCell.setCellStyle(createTitleStyle(workbook));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 8));
        
        rowNum++;
        
        // Header
        Row headerRow = sheet.createRow(rowNum++);
        String[] headers = {"STT", "Mã ca thi", "Ngày thi", "Giờ thi", "Số lượng đăng ký", "Sức chứa", "Chỗ còn lại", "Tỉ lệ lấp đầy (%)", "Ghi chú"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
        
        // Data
        List<com.vstep.model.CaThi> allExams = caThiService.findAll();
        if (allExams != null) {
            int stt = 1;
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            
            for (com.vstep.model.CaThi caThi : allExams) {
                Row row = sheet.createRow(rowNum++);
                int soLuongDangKy = dangKyThiRepository.countByCaThiId(caThi.getId());
                int sucChua = caThi.getSucChua();
                int choCon = Math.max(0, sucChua - soLuongDangKy);
                double fillRate = sucChua > 0 ? (soLuongDangKy * 100.0 / sucChua) : 0;
                
                row.createCell(0).setCellValue(stt++);
                row.getCell(0).setCellStyle(numberStyle);
                
                row.createCell(1).setCellValue(caThi.getMaCaThi() != null ? caThi.getMaCaThi() : "");
                row.getCell(1).setCellStyle(textStyle);
                
                if (caThi.getNgayThi() != null) {
                    Cell dateCell = row.createCell(2);
                    dateCell.setCellValue(dateFormat.format(caThi.getNgayThi()));
                    dateCell.setCellStyle(dateStyle);
                }
                
                if (caThi.getGioBatDau() != null) {
                    Cell timeCell = row.createCell(3);
                    timeCell.setCellValue(timeFormat.format(caThi.getGioBatDau()));
                    timeCell.setCellStyle(textStyle);
                }
                
                Cell regCell = row.createCell(4);
                regCell.setCellValue(soLuongDangKy);
                regCell.setCellStyle(numberStyle);
                
                Cell capCell = row.createCell(5);
                capCell.setCellValue(sucChua);
                capCell.setCellStyle(numberStyle);
                
                Cell remainCell = row.createCell(6);
                remainCell.setCellValue(choCon);
                remainCell.setCellStyle(numberStyle);
                
                Cell rateCell = row.createCell(7);
                rateCell.setCellValue(Math.round(fillRate * 10.0) / 10.0);
                rateCell.setCellStyle(percentStyle);
                
                row.createCell(8).setCellValue(""); // Ghi chú
                row.getCell(8).setCellStyle(textStyle);
            }
        }
        
        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }
    }
    
    private void createRevenueSheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Chi tiết doanh thu");
        
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle currencyStyle = createCurrencyStyle(workbook);
        CellStyle dateStyle = createDateStyle(workbook);
        
        int rowNum = 0;
        
        // Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("CHI TIẾT DOANH THU");
        titleCell.setCellStyle(createTitleStyle(workbook));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));
        
        rowNum++;
        
        // Header
        Row headerRow = sheet.createRow(rowNum++);
        String[] headers = {"STT", "Loại", "Mã đăng ký", "Ngày đăng ký", "Số tiền (VND)", "Trạng thái"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
        
        // Data
        int stt = 1;
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        long totalRevenue = 0;
        
        // Filter data by period
        List<com.vstep.model.DangKyLop> allClassRegs = dangKyLopRepository.findAll();
        List<com.vstep.model.DangKyThi> allExamRegs = dangKyThiRepository.findAll();
        
        // Class revenue
        if (allClassRegs != null) {
            for (com.vstep.model.DangKyLop dk : allClassRegs) {
                if (!"Đã duyệt".equals(dk.getTrangThai())) continue;
                if (dk.getNgayDangKy() == null) continue;
                
                // Filter by period
                if (startDate != null && endDate != null) {
                    LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                            .atZone(java.time.ZoneId.systemDefault())
                            .toLocalDate();
                    LocalDate startLocal = startDate.toLocalDate();
                    LocalDate endLocal = endDate.toLocalDate();
                    if (regLocalDate.isBefore(startLocal) || regLocalDate.isAfter(endLocal)) {
                        continue;
                    }
                }
                
                    Row row = sheet.createRow(rowNum++);
                    row.createCell(0).setCellValue(stt++);
                    row.createCell(1).setCellValue("Lớp ôn");
                    row.createCell(2).setCellValue(dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "");
                row.createCell(3).setCellValue(dateFormat.format(dk.getNgayDangKy()));
                row.getCell(3).setCellStyle(dateStyle);
                
                    Cell amountCell = row.createCell(4);
                    amountCell.setCellValue(dk.getSoTienDaTra());
                    amountCell.setCellStyle(currencyStyle);
                totalRevenue += dk.getSoTienDaTra();
                
                row.createCell(5).setCellValue(dk.getTrangThai());
            }
        }
        
        // Exam revenue
        if (allExamRegs != null) {
            for (com.vstep.model.DangKyThi dk : allExamRegs) {
                if (!"Đã duyệt".equals(dk.getTrangThai())) continue;
                if (dk.getNgayDangKy() == null) continue;
                
                // Filter by period
                if (startDate != null && endDate != null) {
                    LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                            .atZone(java.time.ZoneId.systemDefault())
                            .toLocalDate();
                    LocalDate startLocal = startDate.toLocalDate();
                    LocalDate endLocal = endDate.toLocalDate();
                    if (regLocalDate.isBefore(startLocal) || regLocalDate.isAfter(endLocal)) {
                        continue;
                    }
                }
                
                    Row row = sheet.createRow(rowNum++);
                    row.createCell(0).setCellValue(stt++);
                    row.createCell(1).setCellValue("Ca thi");
                    row.createCell(2).setCellValue(dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "");
                row.createCell(3).setCellValue(dateFormat.format(dk.getNgayDangKy()));
                row.getCell(3).setCellStyle(dateStyle);
                
                    Cell amountCell = row.createCell(4);
                    amountCell.setCellValue(dk.getSoTienPhaiTra());
                    amountCell.setCellStyle(currencyStyle);
                totalRevenue += dk.getSoTienPhaiTra();
                
                row.createCell(5).setCellValue(dk.getTrangThai());
            }
        }
        
        // Total row
        rowNum++;
        Row totalRow = sheet.createRow(rowNum++);
        Cell totalLabelCell = totalRow.createCell(3);
        totalLabelCell.setCellValue("TỔNG CỘNG:");
        totalLabelCell.setCellStyle(createBoldStyle(workbook));
        
        Cell totalCell = totalRow.createCell(4);
        totalCell.setCellValue(totalRevenue);
        totalCell.setCellStyle(createBoldCurrencyStyle(workbook));
        
        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
            if (i == 2) { // Mã đăng ký
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 2000);
            }
        }
    }
    
    private void createDailyRevenueSheet(XSSFWorkbook workbook, String period, Date startDate, Date endDate) {
        Sheet sheet = workbook.createSheet("Doanh thu theo ngày");
        
        CellStyle headerStyle = createHeaderStyle(workbook);
        CellStyle currencyStyle = createCurrencyStyle(workbook);
        CellStyle dateStyle = createDateStyle(workbook);
        
        int rowNum = 0;
        
        // Title
        Row titleRow = sheet.createRow(rowNum++);
        Cell titleCell = titleRow.createCell(0);
        titleCell.setCellValue("DOANH THU THEO NGÀY");
        titleCell.setCellStyle(createTitleStyle(workbook));
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 3));
        
        rowNum++;
        
        // Header
        Row headerRow = sheet.createRow(rowNum++);
        String[] headers = {"Ngày", "Doanh thu lớp ôn", "Doanh thu ca thi", "Tổng doanh thu"};
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }
        
        // Calculate daily revenue
        LocalDate now = LocalDate.now();
        LocalDate chartStartDate;
        LocalDate chartEndDate = now;
        
        if (startDate != null && endDate != null) {
            chartStartDate = startDate.toLocalDate();
            chartEndDate = endDate.toLocalDate();
        } else if ("today".equals(period)) {
            chartStartDate = now;
            chartEndDate = now;
        } else if ("week".equals(period)) {
            chartStartDate = now.minusDays(6);
            chartEndDate = now;
        } else if ("month".equals(period)) {
            chartStartDate = now.withDayOfMonth(1);
            chartEndDate = now;
        } else {
            chartStartDate = now.minusDays(29);
            chartEndDate = now;
        }
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        long grandTotal = 0;
        
        List<com.vstep.model.DangKyLop> allClassRegs = dangKyLopRepository.findAll();
        List<com.vstep.model.DangKyThi> allExamRegs = dangKyThiRepository.findAll();
        
        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(chartStartDate, chartEndDate);
        int days = (int) daysBetween + 1;
        if (days < 1) days = 1;
        
        for (int i = 0; i < days; i++) {
            LocalDate date = chartStartDate.plusDays(i);
            if (date.isAfter(chartEndDate)) break;
            
            long classRevenue = 0;
            long examRevenue = 0;
            
            // Calculate class revenue for this day
            if (allClassRegs != null) {
                for (com.vstep.model.DangKyLop dk : allClassRegs) {
                    if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        if (regLocalDate.equals(date)) {
                            classRevenue += dk.getSoTienDaTra();
                        }
                    }
                }
            }
            
            // Calculate exam revenue for this day
            if (allExamRegs != null) {
                for (com.vstep.model.DangKyThi dk : allExamRegs) {
                    if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        if (regLocalDate.equals(date)) {
                            examRevenue += dk.getSoTienPhaiTra();
                        }
                    }
                }
            }
            
            if (classRevenue > 0 || examRevenue > 0) {
                Row row = sheet.createRow(rowNum++);
                Cell dateCell = row.createCell(0);
                dateCell.setCellValue(dateFormat.format(Date.valueOf(date)));
                dateCell.setCellStyle(dateStyle);
                
                Cell classCell = row.createCell(1);
                classCell.setCellValue(classRevenue);
                classCell.setCellStyle(currencyStyle);
                
                Cell examCell = row.createCell(2);
                examCell.setCellValue(examRevenue);
                examCell.setCellStyle(currencyStyle);
                
                Cell totalCell = row.createCell(3);
                long dayTotal = classRevenue + examRevenue;
                totalCell.setCellValue(dayTotal);
                totalCell.setCellStyle(currencyStyle);
                
                grandTotal += dayTotal;
            }
        }
        
        // Total row
        rowNum++;
        Row totalRow = sheet.createRow(rowNum++);
        Cell totalLabelCell = totalRow.createCell(2);
        totalLabelCell.setCellValue("TỔNG CỘNG:");
        totalLabelCell.setCellStyle(createBoldStyle(workbook));
        
        Cell totalCell = totalRow.createCell(3);
        totalCell.setCellValue(grandTotal);
        totalCell.setCellStyle(createBoldCurrencyStyle(workbook));
        
        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }
    }
    
    // Helper methods for statistics
    private Map<String, Object> calculateStatistics(String period, Date startDate, Date endDate) {
        Map<String, Object> stats = new HashMap<>();
        
        List<com.vstep.model.LopOn> allClasses = lopOnRepository.findAll();
        int totalClasses = allClasses != null ? allClasses.size() : 0;
        int activeClasses = 0;
        int totalStudents = 0;
        
        if (allClasses != null) {
            for (com.vstep.model.LopOn lop : allClasses) {
                String tinhTrang = lop.getTinhTrang();
                if (tinhTrang != null && 
                    (tinhTrang.contains("Đang") || tinhTrang.contains("Sắp") || 
                     tinhTrang.contains("Hoạt động") || tinhTrang.contains("Sắp khai giảng"))) {
                    activeClasses++;
                }
                totalStudents += dangKyLopRepository.countByLopOnId(lop.getId());
            }
        }
        
        List<com.vstep.model.CaThi> allExams = caThiService.findAll();
        int totalExams = allExams != null ? allExams.size() : 0;
        int upcomingExams = 0;
        int totalExamRegs = 0;
        
        LocalDate now = LocalDate.now();
        LocalDate twoWeeksLater = now.plusDays(14);
        
        if (allExams != null) {
            for (com.vstep.model.CaThi caThi : allExams) {
                if (caThi.getNgayThi() != null) {
                    LocalDate examDate = caThi.getNgayThi().toLocalDate();
                    if (examDate.isAfter(now.minusDays(1)) && examDate.isBefore(twoWeeksLater)) {
                        upcomingExams++;
                    }
                }
                totalExamRegs += dangKyThiRepository.countByCaThiId(caThi.getId());
            }
        }
        
        // Calculate revenue with period filter
        long classRevenue = 0;
        long examRevenue = 0;
        
        List<com.vstep.model.DangKyLop> classRegs = dangKyLopRepository.findAll();
        if (classRegs != null) {
            for (com.vstep.model.DangKyLop dk : classRegs) {
                if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                    if (startDate != null && endDate != null) {
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        LocalDate startLocal = startDate.toLocalDate();
                        LocalDate endLocal = endDate.toLocalDate();
                        if (!regLocalDate.isBefore(startLocal) && !regLocalDate.isAfter(endLocal)) {
                            classRevenue += dk.getSoTienDaTra();
                        }
                    } else {
                        classRevenue += dk.getSoTienDaTra();
                    }
                }
            }
        }
        
        List<com.vstep.model.DangKyThi> examRegs = dangKyThiRepository.findAll();
        if (examRegs != null) {
            for (com.vstep.model.DangKyThi dk : examRegs) {
                if ("Đã duyệt".equals(dk.getTrangThai()) && dk.getNgayDangKy() != null) {
                    if (startDate != null && endDate != null) {
                        LocalDate regLocalDate = dk.getNgayDangKy().toInstant()
                                .atZone(java.time.ZoneId.systemDefault())
                                .toLocalDate();
                        LocalDate startLocal = startDate.toLocalDate();
                        LocalDate endLocal = endDate.toLocalDate();
                        if (!regLocalDate.isBefore(startLocal) && !regLocalDate.isAfter(endLocal)) {
                            examRevenue += dk.getSoTienPhaiTra();
                        }
                    } else {
                        examRevenue += dk.getSoTienPhaiTra();
                    }
                }
            }
        }
        
        stats.put("totalClasses", totalClasses);
        stats.put("activeClasses", activeClasses);
        stats.put("totalStudents", totalStudents);
        stats.put("totalExams", totalExams);
        stats.put("upcomingExams", upcomingExams);
        stats.put("totalExamRegs", totalExamRegs);
        stats.put("classRevenue", classRevenue);
        stats.put("examRevenue", examRevenue);
        stats.put("totalRevenue", classRevenue + examRevenue);
        
        return stats;
    }
    
    // Style creation methods
    private CellStyle createHeaderStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 11);
        font.setColor(IndexedColors.WHITE.getIndex());
        style.setFont(font);
        
        // Professional blue background
        style.setFillForegroundColor(new XSSFColor(new byte[]{(byte)31, (byte)81, (byte)140}, null));
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // Borders
        style.setBorderBottom(BorderStyle.MEDIUM);
        style.setBorderTop(BorderStyle.MEDIUM);
        style.setBorderLeft(BorderStyle.MEDIUM);
        style.setBorderRight(BorderStyle.MEDIUM);
        // Note: Border color is set automatically in POI 5.x
        
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setWrapText(true);
        return style;
    }
    
    private CellStyle createTitleStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 18);
        font.setColor(IndexedColors.DARK_BLUE.getIndex());
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        return style;
    }
    
    private CellStyle createSubtitleStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 14);
        font.setColor(IndexedColors.DARK_BLUE.getIndex());
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.CENTER);
        return style;
    }
    
    private CellStyle createInfoStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);
        return style;
    }
    
    private CellStyle createCurrencyStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        style.setDataFormat(format.getFormat("#,##0"));
        style.setAlignment(HorizontalAlignment.RIGHT);
        return style;
    }
    
    private CellStyle createBoldCurrencyStyle(XSSFWorkbook workbook) {
        CellStyle style = createCurrencyStyle(workbook);
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 12);
        font.setColor(IndexedColors.DARK_GREEN.getIndex());
        style.setFont(font);
        style.setFillForegroundColor(new XSSFColor(new byte[]{(byte)220, (byte)237, (byte)200}, null));
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        return style;
    }
    
    private CellStyle createNumberStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        style.setDataFormat(format.getFormat("#,##0"));
        style.setAlignment(HorizontalAlignment.RIGHT);
        return style;
    }
    
    private CellStyle createPercentStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        style.setDataFormat(format.getFormat("0.0%"));
        style.setAlignment(HorizontalAlignment.RIGHT);
        return style;
    }
    
    private CellStyle createDateStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        DataFormat format = workbook.createDataFormat();
        style.setDataFormat(format.getFormat("dd/mm/yyyy"));
        return style;
    }
    
    private CellStyle createTextStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.LEFT);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        style.setWrapText(true);
        return style;
    }
    
    private CellStyle createLabelStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        style.setFont(font);
        return style;
    }
    
    private CellStyle createBoldStyle(XSSFWorkbook workbook) {
        CellStyle style = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 11);
        style.setFont(font);
        style.setAlignment(HorizontalAlignment.RIGHT);
        return style;
    }
    
    // Helper methods
    private void createMetricRow(Sheet sheet, int rowNum, String label, String value, String note, CellStyle valueStyle) {
        Row row = sheet.createRow(rowNum);
        row.createCell(0).setCellValue(label);
        Cell valueCell = row.createCell(1);
        valueCell.setCellValue(value);
        if (valueStyle != null) {
            valueCell.setCellStyle(valueStyle);
        }
        if (note != null && !note.isEmpty()) {
            row.createCell(2).setCellValue(note);
        }
    }
    
    private void createInfoBox(Sheet sheet, int rowNum, int colNum, String label, String value, XSSFWorkbook workbook) {
        // Label
        Row labelRow = sheet.createRow(rowNum);
        Cell labelCell = labelRow.createCell(colNum);
        labelCell.setCellValue(label);
        CellStyle labelStyle = workbook.createCellStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        font.setFontHeightInPoints((short) 10);
        labelStyle.setFont(font);
        labelStyle.setAlignment(HorizontalAlignment.CENTER);
        labelCell.setCellStyle(labelStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum, rowNum, colNum, colNum + 1));
        
        // Value
        Row valueRow = sheet.createRow(rowNum + 1);
        Cell valueCell = valueRow.createCell(colNum);
        valueCell.setCellValue(value);
        CellStyle valueStyle = workbook.createCellStyle();
        Font valueFont = workbook.createFont();
        valueFont.setFontHeightInPoints((short) 12);
        valueFont.setBold(true);
        valueStyle.setFont(valueFont);
        valueStyle.setAlignment(HorizontalAlignment.CENTER);
        valueStyle.setFillForegroundColor(new XSSFColor(new byte[]{(byte)230, (byte)242, (byte)255}, null));
        valueStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        valueStyle.setBorderBottom(BorderStyle.THIN);
        valueStyle.setBorderTop(BorderStyle.THIN);
        valueStyle.setBorderLeft(BorderStyle.THIN);
        valueStyle.setBorderRight(BorderStyle.THIN);
        valueCell.setCellStyle(valueStyle);
        sheet.addMergedRegion(new CellRangeAddress(rowNum + 1, rowNum + 1, colNum, colNum + 1));
    }
    
    private void applyConditionalFormatting(Row row, CellStyle style) {
        for (int i = 0; i < row.getLastCellNum(); i++) {
            Cell cell = row.getCell(i);
            if (cell != null) {
                CellStyle cellStyle = cell.getSheet().getWorkbook().createCellStyle();
                cellStyle.cloneStyleFrom(cell.getCellStyle());
                cellStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
                cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                cell.setCellStyle(cellStyle);
            }
        }
    }
    
    private String getPeriodLabel(String period) {
        switch (period) {
            case "today": return "Hôm nay";
            case "week": return "7 ngày qua";
            case "month": return "Tháng này";
            case "all": return "Tất cả";
            default: return "Tháng này";
        }
    }
    
    private String getDateRange(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            return "";
        }
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        if (startDate.equals(endDate)) {
            return " (" + df.format(startDate) + ")";
        }
        return " (Từ " + df.format(startDate) + " đến " + df.format(endDate) + ")";
    }
    
    private String formatCurrency(long amount) {
        return currencyFormat.format(amount);
    }
    
    private String formatNumber(int number) {
        return currencyFormat.format(number);
    }
}

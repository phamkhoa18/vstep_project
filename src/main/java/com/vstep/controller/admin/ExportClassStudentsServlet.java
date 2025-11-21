package com.vstep.controller.admin;

import com.vstep.model.DangKyLop;
import com.vstep.model.LopOn;
import com.vstep.model.NguoiDung;
import com.vstep.service.DangKyLopService;
import com.vstep.service.LopOnService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.DangKyLopServiceImpl;
import com.vstep.serviceImpl.LopOnServiceImpl;
import com.vstep.serviceImpl.NguoiDungServiceImpl;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/admin/export-class-students")
public class ExportClassStudentsServlet extends HttpServlet {

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
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("userLogin");
        if (user == null || !"admin".equalsIgnoreCase(user.getVaiTro())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
            return;
        }

        // Lấy ID lớp từ parameter
        String lopIdParam = req.getParameter("lopId");
        if (lopIdParam == null || lopIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số lopId.");
            return;
        }

        try {
            long lopId = Long.parseLong(lopIdParam);
            LopOn lopOn = lopOnService.findById(lopId);

            if (lopOn == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy lớp ôn.");
                return;
            }

            // Lấy danh sách đăng ký của lớp
            List<DangKyLop> danhSachDangKy = dangKyLopService.findByLopOnId(lopId);

            // Tạo file Excel
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Danh sách học viên");

            // Tạo style cho header
            CellStyle headerStyle = workbook.createCellStyle();
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 12);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerStyle.setFont(headerFont);
            headerStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);

            // Tạo style cho title
            CellStyle titleStyle = workbook.createCellStyle();
            Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleStyle.setFont(titleFont);
            titleStyle.setAlignment(HorizontalAlignment.LEFT);
            titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            // Tạo style cho số tiền
            CellStyle currencyStyle = workbook.createCellStyle();
            DataFormat format = workbook.createDataFormat();
            currencyStyle.setDataFormat(format.getFormat("#,##0"));
            currencyStyle.setBorderBottom(BorderStyle.THIN);
            currencyStyle.setBorderTop(BorderStyle.THIN);
            currencyStyle.setBorderLeft(BorderStyle.THIN);
            currencyStyle.setBorderRight(BorderStyle.THIN);
            currencyStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            // Tạo style cho cells
            CellStyle cellStyle = workbook.createCellStyle();
            cellStyle.setBorderBottom(BorderStyle.THIN);
            cellStyle.setBorderTop(BorderStyle.THIN);
            cellStyle.setBorderLeft(BorderStyle.THIN);
            cellStyle.setBorderRight(BorderStyle.THIN);
            cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            int currentRow = 0;

            // Thêm thông tin lớp
            Row titleRow = sheet.createRow(currentRow++);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("DANH SÁCH HỌC VIÊN - " + (lopOn.getTieuDe() != null ? lopOn.getTieuDe().toUpperCase() : "LỚP ÔN"));
            titleCell.setCellStyle(titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));

            Row infoRow1 = sheet.createRow(currentRow++);
            infoRow1.createCell(0).setCellValue("Mã lớp: " + (lopOn.getMaLop() != null ? lopOn.getMaLop() : "N/A"));
            infoRow1.createCell(5).setCellValue("Sĩ số: " + danhSachDangKy.size() + "/" + lopOn.getSiSoToiDa());

            Row infoRow2 = sheet.createRow(currentRow++);
            if (lopOn.getNgayKhaiGiang() != null) {
                infoRow2.createCell(0).setCellValue("Ngày khai giảng: " + new SimpleDateFormat("dd/MM/yyyy").format(lopOn.getNgayKhaiGiang()));
            }
            if (lopOn.getNgayKetThuc() != null) {
                infoRow2.createCell(5).setCellValue("Ngày kết thúc: " + new SimpleDateFormat("dd/MM/yyyy").format(lopOn.getNgayKetThuc()));
            }

            // Dòng trống
            currentRow++;

            // Tạo row header
            Row headerRow = sheet.createRow(currentRow++);
            String[] headers = {"STT", "Họ và tên", "Email", "Số điện thoại", "Đơn vị", 
                                "Mã xác nhận", "Ngày đăng ký", "Trạng thái", "Số tiền đã trả", "Mức giảm", "Ghi chú"};
            
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Điền dữ liệu
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            int rowNum = currentRow;
            int stt = 1;

            for (DangKyLop dk : danhSachDangKy) {
                NguoiDung nguoiDung = nguoiDungService.findById(dk.getNguoiDungId());
                if (nguoiDung == null) {
                    continue; // Bỏ qua nếu không tìm thấy người dùng
                }

                Row row = sheet.createRow(rowNum++);
                
                // STT
                Cell cell0 = row.createCell(0);
                cell0.setCellValue(stt++);
                cell0.setCellStyle(cellStyle);
                
                // Họ và tên
                Cell cell1 = row.createCell(1);
                cell1.setCellValue(nguoiDung.getHoTen() != null ? nguoiDung.getHoTen() : "");
                cell1.setCellStyle(cellStyle);
                
                // Email
                Cell cell2 = row.createCell(2);
                cell2.setCellValue(nguoiDung.getEmail() != null ? nguoiDung.getEmail() : "");
                cell2.setCellStyle(cellStyle);
                
                // Số điện thoại
                Cell cell3 = row.createCell(3);
                cell3.setCellValue(nguoiDung.getSoDienThoai() != null ? nguoiDung.getSoDienThoai() : "");
                cell3.setCellStyle(cellStyle);
                
                // Đơn vị
                Cell cell4 = row.createCell(4);
                cell4.setCellValue(nguoiDung.getDonVi() != null ? nguoiDung.getDonVi() : "");
                cell4.setCellStyle(cellStyle);
                
                // Mã xác nhận
                Cell cell5 = row.createCell(5);
                cell5.setCellValue(dk.getMaXacNhan() != null ? dk.getMaXacNhan() : "");
                cell5.setCellStyle(cellStyle);
                
                // Ngày đăng ký
                Cell cell6 = row.createCell(6);
                cell6.setCellValue(dk.getNgayDangKy() != null ? dateFormat.format(dk.getNgayDangKy()) : "");
                cell6.setCellStyle(cellStyle);
                
                // Trạng thái
                Cell cell7 = row.createCell(7);
                cell7.setCellValue(dk.getTrangThai() != null ? dk.getTrangThai() : "");
                cell7.setCellStyle(cellStyle);
                
                // Số tiền đã trả
                Cell cell8 = row.createCell(8);
                cell8.setCellValue(dk.getSoTienDaTra());
                cell8.setCellStyle(currencyStyle);
                
                // Mức giảm
                Cell cell9 = row.createCell(9);
                cell9.setCellValue(dk.getMucGiam());
                cell9.setCellStyle(currencyStyle);
                
                // Ghi chú
                Cell cell10 = row.createCell(10);
                cell10.setCellValue(dk.getGhiChu() != null ? dk.getGhiChu() : "");
                cell10.setCellStyle(cellStyle);
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
                // Tăng độ rộng một chút để dễ đọc
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 1000);
            }

            // Set header row height
            headerRow.setHeightInPoints(20);

            // Tạo tên file
            String fileName = "Danh_sach_hoc_vien_" + 
                            (lopOn.getMaLop() != null ? lopOn.getMaLop() : "lop_" + lopId) + 
                            "_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".xlsx";
            
            // Set response headers
            resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            resp.setCharacterEncoding("UTF-8");

            // Write workbook to response
            workbook.write(resp.getOutputStream());
            workbook.close();

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID lớp không hợp lệ.");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi xuất file Excel: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


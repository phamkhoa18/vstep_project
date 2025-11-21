package com.vstep.controller.admin;

import com.vstep.model.CaThi;
import com.vstep.model.DangKyThi;
import com.vstep.model.NguoiDung;
import com.vstep.service.CaThiService;
import com.vstep.service.DangKyThiService;
import com.vstep.service.NguoiDungService;
import com.vstep.serviceImpl.CaThiServiceImpl;
import com.vstep.serviceImpl.DangKyThiServiceImpl;
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

@WebServlet("/admin/export-exam-students")
public class ExportExamStudentsServlet extends HttpServlet {

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

        // Lấy ID ca thi từ parameter
        String caThiIdParam = req.getParameter("caThiId");
        if (caThiIdParam == null || caThiIdParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tham số caThiId.");
            return;
        }

        try {
            long caThiId = Long.parseLong(caThiIdParam);
            CaThi caThi = caThiService.findById(caThiId);

            if (caThi == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy ca thi.");
                return;
            }

            // Lấy danh sách đăng ký của ca thi
            List<DangKyThi> danhSachDangKy = dangKyThiService.findByCaThiId(caThiId);

            // Tạo file Excel
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Danh sách thí sinh");

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

            // Thêm thông tin ca thi
            Row titleRow = sheet.createRow(currentRow++);
            Cell titleCell = titleRow.createCell(0);
            String caThiTitle = (caThi.getMaCaThi() != null ? caThi.getMaCaThi() : "Ca thi #" + caThi.getId());
            titleCell.setCellValue("DANH SÁCH THÍ SINH - " + caThiTitle.toUpperCase());
            titleCell.setCellStyle(titleStyle);
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 11));

            Row infoRow1 = sheet.createRow(currentRow++);
            infoRow1.createCell(0).setCellValue("Mã ca thi: " + caThiTitle);
            infoRow1.createCell(5).setCellValue("Số lượng đăng ký: " + danhSachDangKy.size() + "/" + caThi.getSucChua());

            Row infoRow2 = sheet.createRow(currentRow++);
            if (caThi.getNgayThi() != null) {
                infoRow2.createCell(0).setCellValue("Ngày thi: " + new SimpleDateFormat("dd/MM/yyyy").format(caThi.getNgayThi()));
            }
            if (caThi.getGioBatDau() != null) {
                infoRow2.createCell(5).setCellValue("Giờ thi: " + new SimpleDateFormat("HH:mm").format(caThi.getGioBatDau()));
            }

            Row infoRow3 = sheet.createRow(currentRow++);
            if (caThi.getDiaDiem() != null && !caThi.getDiaDiem().isEmpty()) {
                infoRow3.createCell(0).setCellValue("Địa điểm: " + caThi.getDiaDiem());
            }
            java.text.NumberFormat numberFormat = java.text.NumberFormat.getNumberInstance();
            infoRow3.createCell(5).setCellValue("Giá gốc: " + numberFormat.format(caThi.getGiaGoc()) + " VND");

            // Dòng trống
            currentRow++;

            // Tạo row header
            Row headerRow = sheet.createRow(currentRow++);
            String[] headers = {"STT", "Họ và tên", "Email", "Số điện thoại", "Đơn vị", 
                                "Mã xác nhận", "Ngày đăng ký", "Trạng thái", "Số tiền phải trả", 
                                "Mức giảm", "Đã từng thi", "Mã code giảm giá"};
            
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Điền dữ liệu
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            int rowNum = currentRow;
            int stt = 1;

            for (DangKyThi dk : danhSachDangKy) {
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
                
                // Số tiền phải trả
                Cell cell8 = row.createCell(8);
                cell8.setCellValue(dk.getSoTienPhaiTra());
                cell8.setCellStyle(currencyStyle);
                
                // Mức giảm
                Cell cell9 = row.createCell(9);
                cell9.setCellValue(dk.getMucGiam());
                cell9.setCellStyle(currencyStyle);
                
                // Đã từng thi
                Cell cell10 = row.createCell(10);
                cell10.setCellValue(dk.isDaTungThi() ? "Có" : "Không");
                cell10.setCellStyle(cellStyle);
                
                // Mã code giảm giá
                Cell cell11 = row.createCell(11);
                cell11.setCellValue(dk.getMaCodeGiamGia() != null ? dk.getMaCodeGiamGia() : "");
                cell11.setCellStyle(cellStyle);
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
            String fileName = "Danh_sach_thi_sinh_" + 
                            caThiTitle.replaceAll("[^a-zA-Z0-9]", "_") + 
                            "_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date()) + ".xlsx";
            
            // Set response headers
            resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            resp.setCharacterEncoding("UTF-8");

            // Write workbook to response
            workbook.write(resp.getOutputStream());
            workbook.close();

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID ca thi không hợp lệ.");
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi xuất file Excel: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


package com.vstep.util;

import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Div;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;

public class InvoicePdfService {
    
    private static final NumberFormat currencyFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
    
    static {
        currencyFormat.setMaximumFractionDigits(0);
    }
    
    /**
     * Tạo font hỗ trợ tiếng Việt (Unicode)
     */
    private static PdfFont createVietnameseFont(boolean bold) throws IOException {
        // Danh sách font paths để thử (theo thứ tự ưu tiên)
        String[] fontPaths = bold 
            ? new String[]{
                "C:/Windows/Fonts/arialbd.ttf",
                "C:/Windows/Fonts/timesbd.ttf",
                "C:/Windows/Fonts/calibrib.ttf"
            }
            : new String[]{
                "C:/Windows/Fonts/arial.ttf",
                "C:/Windows/Fonts/times.ttf",
                "C:/Windows/Fonts/calibri.ttf"
            };
        
        // Thử từng font path
        for (String fontPath : fontPaths) {
            try {
                java.io.File fontFile = new java.io.File(fontPath);
                if (fontFile.exists()) {
                    // Sử dụng "Identity-H" encoding để hỗ trợ Unicode đầy đủ
                    // Font sẽ được embed tự động khi dùng file TTF
                    return PdfFontFactory.createFont(fontPath, "Identity-H");
                }
            } catch (Exception e) {
                // Tiếp tục thử font tiếp theo
            }
        }
        
        // Nếu không tìm thấy font hệ thống, dùng font mặc định
        // Lưu ý: Font mặc định có thể không hiển thị đúng tiếng Việt
        String fontName = bold ? StandardFonts.HELVETICA_BOLD : StandardFonts.HELVETICA;
        return PdfFontFactory.createFont(fontName);
    }
    
    /**
     * Tạo hóa đơn PDF cho đăng ký lớp ôn
     */
    public static byte[] generateClassInvoicePdf(String invoiceNumber,
                                                  String studentName,
                                                  String studentEmail,
                                                  String studentPhone,
                                                  String studentUnit,
                                                  String classCode,
                                                  String className,
                                                  String classFormat,
                                                  String classPace,
                                                  String startDate,
                                                  String endDate,
                                                  String schedule,
                                                  String registrationCode,
                                                  String registrationDate,
                                                  long originalPrice,
                                                  long discount,
                                                  long amountPaid,
                                                  String discountCode) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        document.setMargins(40, 50, 40, 50);
        
        try {
            PdfFont fontBold = createVietnameseFont(true);
            PdfFont fontRegular = createVietnameseFont(false);
            
            // ========== HEADER ==========
            // Tiêu đề hóa đơn
            Paragraph title = new Paragraph("HÓA ĐƠN THANH TOÁN")
                    .setFont(fontBold)
                    .setFontSize(24)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(5);
            document.add(title);
            
            Paragraph subtitle = new Paragraph("(Lớp ôn)")
                    .setFont(fontRegular)
                    .setFontSize(12)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(subtitle);
            
            // Thông tin công ty và khách hàng (2 cột)
            Table headerTable = new Table(UnitValue.createPercentArray(new float[]{1, 1})).useAllAvailableWidth();
            headerTable.setMarginBottom(15);
            
            // Cột trái: Thông tin công ty
            Cell companyCell = new Cell();
            companyCell.setBorder(Border.NO_BORDER);
            companyCell.add(new Paragraph("CÔNG TY TNHH VSTEP").setFont(fontBold).setFontSize(14).setMarginBottom(3));
            companyCell.add(new Paragraph("Địa chỉ: 01 Võ Văn Ngân, P. Linh Chiểu, Q. Thủ Đức, TP. HCM").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("MST: 0312345678").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("Điện thoại: (028) 1234 5678").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("Email: info@vstep.edu.vn").setFont(fontRegular).setFontSize(9));
            headerTable.addCell(companyCell);
            
            // Cột phải: Thông tin hóa đơn và khách hàng
            Cell invoiceInfoCell = new Cell();
            invoiceInfoCell.setBorder(Border.NO_BORDER);
            invoiceInfoCell.setTextAlignment(TextAlignment.RIGHT);
            invoiceInfoCell.add(new Paragraph("Số hóa đơn:").setFont(fontRegular).setFontSize(9).setMarginBottom(2));
            invoiceInfoCell.add(new Paragraph(invoiceNumber).setFont(fontBold).setFontSize(11).setMarginBottom(5));
            invoiceInfoCell.add(new Paragraph("Ngày xuất:").setFont(fontRegular).setFontSize(9).setMarginBottom(2));
            invoiceInfoCell.add(new Paragraph(registrationDate).setFont(fontRegular).setFontSize(9));
            headerTable.addCell(invoiceInfoCell);
            
            document.add(headerTable);
            
            // Đường kẻ ngang
            document.add(new Paragraph("").setMarginBottom(10));
            Div divider = new Div();
            divider.setHeight(2);
            divider.setBackgroundColor(ColorConstants.GRAY);
            document.add(divider);
            document.add(new Paragraph("").setMarginBottom(15));
            
            // Thông tin khách hàng
            Paragraph customerTitle = new Paragraph("THÔNG TIN KHÁCH HÀNG")
                    .setFont(fontBold)
                    .setFontSize(12)
                    .setMarginBottom(5);
            document.add(customerTitle);
            
            Table customerTable = new Table(2).useAllAvailableWidth();
            customerTable.addCell(createCell("Họ và tên:", fontRegular, 10, false));
            customerTable.addCell(createCell(studentName, fontRegular, 10, false));
            customerTable.addCell(createCell("Email:", fontRegular, 10, false));
            customerTable.addCell(createCell(studentEmail != null ? studentEmail : "", fontRegular, 10, false));
            customerTable.addCell(createCell("Số điện thoại:", fontRegular, 10, false));
            customerTable.addCell(createCell(studentPhone != null ? studentPhone : "", fontRegular, 10, false));
            if (studentUnit != null && !studentUnit.isEmpty()) {
                customerTable.addCell(createCell("Đơn vị:", fontRegular, 10, false));
                customerTable.addCell(createCell(studentUnit, fontRegular, 10, false));
            }
            document.add(customerTable);
            document.add(new Paragraph("\n"));
            
            // ========== CHI TIẾT DỊCH VỤ ==========
            Paragraph serviceTitle = new Paragraph("CHI TIẾT DỊCH VỤ")
                    .setFont(fontBold)
                    .setFontSize(11)
                    .setMarginBottom(8)
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                    .setPadding(5);
            document.add(serviceTitle);
            
            // Bảng chi tiết dịch vụ
            Table serviceTable = new Table(UnitValue.createPercentArray(new float[]{0.5f, 2f, 0.8f, 0.7f, 1f})).useAllAvailableWidth();
            serviceTable.setMarginBottom(15);
            
            // Header row
            serviceTable.addHeaderCell(createCell("STT", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Mô tả dịch vụ", fontBold, 10, true).setPadding(8));
            serviceTable.addHeaderCell(createCell("Đơn vị", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Số lượng", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Thành tiền", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.RIGHT));
            
            // Data row
            StringBuilder serviceDesc = new StringBuilder();
            serviceDesc.append("Đăng ký lớp ôn: ").append(className != null ? className : "");
            if (classCode != null && !classCode.isEmpty()) {
                serviceDesc.append(" (").append(classCode).append(")");
            }
            serviceDesc.append("\n");
            if (classFormat != null && !classFormat.isEmpty()) {
                serviceDesc.append("Hình thức: ").append(classFormat);
            }
            if (classPace != null && !classPace.isEmpty()) {
                if (serviceDesc.length() > 0) serviceDesc.append(" | ");
                serviceDesc.append("Nhịp độ: ").append(classPace);
            }
            if (startDate != null && !startDate.isEmpty()) {
                serviceDesc.append("\nNgày khai giảng: ").append(startDate);
            }
            if (endDate != null && !endDate.isEmpty()) {
                serviceDesc.append(" - ").append(endDate);
            }
            if (schedule != null && !schedule.isEmpty()) {
                serviceDesc.append("\nLịch học: ").append(schedule);
            }
            serviceDesc.append("\nMã đăng ký: ").append(registrationCode != null ? registrationCode : "");
            
            serviceTable.addCell(createCell("1", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell(serviceDesc.toString(), fontRegular, 9, false).setPadding(8));
            serviceTable.addCell(createCell("Lớp", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell("1", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell(formatCurrency(originalPrice), fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.RIGHT));
            
            document.add(serviceTable);
            
            // ========== TỔNG KẾT THANH TOÁN ==========
            Table summaryTable = new Table(UnitValue.createPercentArray(new float[]{0.7f, 0.3f})).useAllAvailableWidth();
            summaryTable.setMarginBottom(20);
            
            // Tổng tiền dịch vụ
            summaryTable.addCell(createCell("Tổng tiền dịch vụ:", fontRegular, 10, false)
                    .setPadding(8).setBorderRight(Border.NO_BORDER));
            summaryTable.addCell(createCell(formatCurrency(originalPrice), fontRegular, 10, false)
                    .setPadding(8).setTextAlignment(TextAlignment.RIGHT).setBorderLeft(Border.NO_BORDER));
            
            // Giảm giá
            if (discount > 0) {
                if (discountCode != null && !discountCode.isEmpty()) {
                    summaryTable.addCell(createCell("Giảm giá (Mã: " + discountCode + "):", fontRegular, 10, false)
                            .setPadding(8).setBorderRight(Border.NO_BORDER));
                } else {
                    summaryTable.addCell(createCell("Giảm giá:", fontRegular, 10, false)
                            .setPadding(8).setBorderRight(Border.NO_BORDER));
                }
                summaryTable.addCell(createCell("-" + formatCurrency(discount), fontRegular, 10, false)
                        .setPadding(8).setTextAlignment(TextAlignment.RIGHT)
                        .setFontColor(ColorConstants.GREEN).setBorderLeft(Border.NO_BORDER));
            }
            
            // Đường kẻ trước tổng cộng
            summaryTable.addCell(new Cell(1, 2).add(new Paragraph("")).setBorder(Border.NO_BORDER).setHeight(5));
            
            // Tổng cộng
            summaryTable.addCell(createCell("TỔNG CỘNG:", fontBold, 12, false)
                    .setPadding(10)
                    .setBackgroundColor(ColorConstants.DARK_GRAY)
                    .setFontColor(ColorConstants.WHITE)
                    .setBorderRight(Border.NO_BORDER));
            summaryTable.addCell(createCell(formatCurrency(amountPaid), fontBold, 12, false)
                    .setPadding(10)
                    .setTextAlignment(TextAlignment.RIGHT)
                    .setBackgroundColor(ColorConstants.DARK_GRAY)
                    .setFontColor(ColorConstants.WHITE)
                    .setBorderLeft(Border.NO_BORDER));
            
            document.add(summaryTable);
            
            // ========== FOOTER ==========
            document.add(new Paragraph("").setMarginTop(30));
            
            // Đường kẻ ngang
            Div footerDivider = new Div();
            footerDivider.setHeight(1);
            footerDivider.setBackgroundColor(ColorConstants.GRAY);
            document.add(footerDivider);
            document.add(new Paragraph("").setMarginBottom(10));
            
            // Thông tin thanh toán
            Paragraph paymentInfo = new Paragraph("Đã thanh toán: " + formatCurrency(amountPaid) + " (Bằng chuyển khoản)")
                    .setFont(fontRegular)
                    .setFontSize(9)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(5);
            document.add(paymentInfo);
            
            // Lời cảm ơn
            Paragraph thankYou = new Paragraph("Cảm ơn Quý khách đã sử dụng dịch vụ của VSTEP!")
                    .setFont(fontBold)
                    .setFontSize(11)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(15);
            document.add(thankYou);
            
            // Thông tin liên hệ
            Table footerTable = new Table(UnitValue.createPercentArray(new float[]{1})).useAllAvailableWidth();
            footerTable.setBorder(Border.NO_BORDER);
            Cell footerCell = new Cell();
            footerCell.setBorder(Border.NO_BORDER);
            footerCell.setTextAlignment(TextAlignment.CENTER);
            footerCell.add(new Paragraph("Mọi thắc mắc vui lòng liên hệ:").setFont(fontRegular).setFontSize(8).setMarginBottom(2));
            footerCell.add(new Paragraph("Hotline: (028) 1234 5678 | Email: info@vstep.edu.vn | Website: www.vstep.edu.vn").setFont(fontRegular).setFontSize(8));
            footerTable.addCell(footerCell);
            document.add(footerTable);
            
            document.close();
            return baos.toByteArray();
            
        } catch (Exception e) {
            document.close();
            throw new IOException("Lỗi khi tạo PDF: " + e.getMessage(), e);
        }
    }
    
    /**
     * Tạo hóa đơn PDF cho đăng ký ca thi
     */
    public static byte[] generateExamInvoicePdf(String invoiceNumber,
                                                String studentName,
                                                String studentEmail,
                                                String studentPhone,
                                                String studentUnit,
                                                String examCode,
                                                String examDate,
                                                String examTime,
                                                String examLocation,
                                                String registrationCode,
                                                String registrationDate,
                                                long originalPrice,
                                                long discount,
                                                long amountToPay,
                                                boolean daTungThi,
                                                String discountCode) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf, PageSize.A4);
        document.setMargins(40, 50, 40, 50);
        
        try {
            PdfFont fontBold = createVietnameseFont(true);
            PdfFont fontRegular = createVietnameseFont(false);
            
            // ========== HEADER ==========
            // Tiêu đề hóa đơn
            Paragraph title = new Paragraph("HÓA ĐƠN THANH TOÁN")
                    .setFont(fontBold)
                    .setFontSize(24)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(5);
            document.add(title);
            
            Paragraph subtitle = new Paragraph("(Ca thi)")
                    .setFont(fontRegular)
                    .setFontSize(12)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(20);
            document.add(subtitle);
            
            // Thông tin công ty và khách hàng (2 cột)
            Table headerTable = new Table(UnitValue.createPercentArray(new float[]{1, 1})).useAllAvailableWidth();
            headerTable.setMarginBottom(15);
            
            // Cột trái: Thông tin công ty
            Cell companyCell = new Cell();
            companyCell.setBorder(Border.NO_BORDER);
            companyCell.add(new Paragraph("CÔNG TY TNHH VSTEP").setFont(fontBold).setFontSize(14).setMarginBottom(3));
            companyCell.add(new Paragraph("Địa chỉ: 01 Võ Văn Ngân, P. Linh Chiểu, Q. Thủ Đức, TP. HCM").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("MST: 0312345678").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("Điện thoại: (028) 1234 5678").setFont(fontRegular).setFontSize(9));
            companyCell.add(new Paragraph("Email: info@vstep.edu.vn").setFont(fontRegular).setFontSize(9));
            headerTable.addCell(companyCell);
            
            // Cột phải: Thông tin hóa đơn và khách hàng
            Cell invoiceInfoCell = new Cell();
            invoiceInfoCell.setBorder(Border.NO_BORDER);
            invoiceInfoCell.setTextAlignment(TextAlignment.RIGHT);
            invoiceInfoCell.add(new Paragraph("Số hóa đơn:").setFont(fontRegular).setFontSize(9).setMarginBottom(2));
            invoiceInfoCell.add(new Paragraph(invoiceNumber).setFont(fontBold).setFontSize(11).setMarginBottom(5));
            invoiceInfoCell.add(new Paragraph("Ngày xuất:").setFont(fontRegular).setFontSize(9).setMarginBottom(2));
            invoiceInfoCell.add(new Paragraph(registrationDate).setFont(fontRegular).setFontSize(9));
            headerTable.addCell(invoiceInfoCell);
            
            document.add(headerTable);
            
            // Đường kẻ ngang
            document.add(new Paragraph("").setMarginBottom(10));
            Div divider = new Div();
            divider.setHeight(2);
            divider.setBackgroundColor(ColorConstants.GRAY);
            document.add(divider);
            document.add(new Paragraph("").setMarginBottom(15));
            
            // ========== THÔNG TIN KHÁCH HÀNG ==========
            Paragraph customerTitle = new Paragraph("THÔNG TIN KHÁCH HÀNG")
                    .setFont(fontBold)
                    .setFontSize(11)
                    .setMarginBottom(8)
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                    .setPadding(5);
            document.add(customerTitle);
            
            Table customerTable = new Table(UnitValue.createPercentArray(new float[]{0.3f, 0.7f})).useAllAvailableWidth();
            customerTable.setMarginBottom(15);
            customerTable.addCell(createCell("Họ và tên:", fontRegular, 10, false).setPadding(5));
            customerTable.addCell(createCell(studentName, fontBold, 10, false).setPadding(5));
            customerTable.addCell(createCell("Email:", fontRegular, 10, false).setPadding(5));
            customerTable.addCell(createCell(studentEmail != null ? studentEmail : "", fontRegular, 10, false).setPadding(5));
            customerTable.addCell(createCell("Số điện thoại:", fontRegular, 10, false).setPadding(5));
            customerTable.addCell(createCell(studentPhone != null ? studentPhone : "", fontRegular, 10, false).setPadding(5));
            if (studentUnit != null && !studentUnit.isEmpty()) {
                customerTable.addCell(createCell("Đơn vị:", fontRegular, 10, false).setPadding(5));
                customerTable.addCell(createCell(studentUnit, fontRegular, 10, false).setPadding(5));
            }
            document.add(customerTable);
            
            // ========== CHI TIẾT DỊCH VỤ ==========
            Paragraph serviceTitle = new Paragraph("CHI TIẾT DỊCH VỤ")
                    .setFont(fontBold)
                    .setFontSize(11)
                    .setMarginBottom(8)
                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                    .setPadding(5);
            document.add(serviceTitle);
            
            // Bảng chi tiết dịch vụ
            Table serviceTable = new Table(UnitValue.createPercentArray(new float[]{0.5f, 2f, 0.8f, 0.7f, 1f})).useAllAvailableWidth();
            serviceTable.setMarginBottom(15);
            
            // Header row
            serviceTable.addHeaderCell(createCell("STT", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Mô tả dịch vụ", fontBold, 10, true).setPadding(8));
            serviceTable.addHeaderCell(createCell("Đơn vị", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Số lượng", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addHeaderCell(createCell("Thành tiền", fontBold, 10, true).setPadding(8).setTextAlignment(TextAlignment.RIGHT));
            
            // Data row
            StringBuilder serviceDesc = new StringBuilder();
            serviceDesc.append("Đăng ký ca thi: ").append(examCode != null ? examCode : "");
            serviceDesc.append("\nNgày thi: ").append(examDate != null ? examDate : "");
            serviceDesc.append(" | Giờ thi: ").append(examTime != null ? examTime : "");
            if (examLocation != null && !examLocation.isEmpty()) {
                serviceDesc.append("\nĐịa điểm: ").append(examLocation);
            }
            if (daTungThi) {
                serviceDesc.append("\nĐã từng thi VSTEP (được giảm giá)");
            }
            serviceDesc.append("\nMã đăng ký: ").append(registrationCode != null ? registrationCode : "");
            
            serviceTable.addCell(createCell("1", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell(serviceDesc.toString(), fontRegular, 9, false).setPadding(8));
            serviceTable.addCell(createCell("Ca thi", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell("1", fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.CENTER));
            serviceTable.addCell(createCell(formatCurrency(originalPrice), fontRegular, 10, false).setPadding(8).setTextAlignment(TextAlignment.RIGHT));
            
            document.add(serviceTable);
            
            // ========== TỔNG KẾT THANH TOÁN ==========
            Table summaryTable = new Table(UnitValue.createPercentArray(new float[]{0.7f, 0.3f})).useAllAvailableWidth();
            summaryTable.setMarginBottom(20);
            
            // Tổng tiền dịch vụ
            summaryTable.addCell(createCell("Tổng tiền dịch vụ:", fontRegular, 10, false)
                    .setPadding(8).setBorderRight(Border.NO_BORDER));
            summaryTable.addCell(createCell(formatCurrency(originalPrice), fontRegular, 10, false)
                    .setPadding(8).setTextAlignment(TextAlignment.RIGHT).setBorderLeft(Border.NO_BORDER));
            
            // Giảm giá
            if (discount > 0) {
                String discountLabel = "Giảm giá:";
                if (daTungThi) {
                    discountLabel = "Giảm giá (Đã từng thi";
                    if (discountCode != null && !discountCode.isEmpty()) {
                        discountLabel += " + Mã: " + discountCode;
                    }
                    discountLabel += "):";
                } else if (discountCode != null && !discountCode.isEmpty()) {
                    discountLabel = "Giảm giá (Mã: " + discountCode + "):";
                }
                
                summaryTable.addCell(createCell(discountLabel, fontRegular, 10, false)
                        .setPadding(8).setBorderRight(Border.NO_BORDER));
                summaryTable.addCell(createCell("-" + formatCurrency(discount), fontRegular, 10, false)
                        .setPadding(8).setTextAlignment(TextAlignment.RIGHT)
                        .setFontColor(ColorConstants.GREEN).setBorderLeft(Border.NO_BORDER));
            }
            
            // Đường kẻ trước tổng cộng
            summaryTable.addCell(new Cell(1, 2).add(new Paragraph("")).setBorder(Border.NO_BORDER).setHeight(5));
            
            // Tổng cộng
            summaryTable.addCell(createCell("TỔNG CỘNG:", fontBold, 12, false)
                    .setPadding(10)
                    .setBackgroundColor(ColorConstants.DARK_GRAY)
                    .setFontColor(ColorConstants.WHITE)
                    .setBorderRight(Border.NO_BORDER));
            summaryTable.addCell(createCell(formatCurrency(amountToPay), fontBold, 12, false)
                    .setPadding(10)
                    .setTextAlignment(TextAlignment.RIGHT)
                    .setBackgroundColor(ColorConstants.DARK_GRAY)
                    .setFontColor(ColorConstants.WHITE)
                    .setBorderLeft(Border.NO_BORDER));
            
            document.add(summaryTable);
            
            // ========== FOOTER ==========
            document.add(new Paragraph("").setMarginTop(30));
            
            // Đường kẻ ngang
            Div footerDivider = new Div();
            footerDivider.setHeight(1);
            footerDivider.setBackgroundColor(ColorConstants.GRAY);
            document.add(footerDivider);
            document.add(new Paragraph("").setMarginBottom(10));
            
            // Thông tin thanh toán
            Paragraph paymentInfo = new Paragraph("Đã thanh toán: " + formatCurrency(amountToPay) + " (Bằng chuyển khoản)")
                    .setFont(fontRegular)
                    .setFontSize(9)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(5);
            document.add(paymentInfo);
            
            // Lời cảm ơn
            Paragraph thankYou = new Paragraph("Cảm ơn Quý khách đã sử dụng dịch vụ của VSTEP!")
                    .setFont(fontBold)
                    .setFontSize(11)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setMarginBottom(15);
            document.add(thankYou);
            
            // Thông tin liên hệ
            Table footerTable = new Table(UnitValue.createPercentArray(new float[]{1})).useAllAvailableWidth();
            footerTable.setBorder(Border.NO_BORDER);
            Cell footerCell = new Cell();
            footerCell.setBorder(Border.NO_BORDER);
            footerCell.setTextAlignment(TextAlignment.CENTER);
            footerCell.add(new Paragraph("Mọi thắc mắc vui lòng liên hệ:").setFont(fontRegular).setFontSize(8).setMarginBottom(2));
            footerCell.add(new Paragraph("Hotline: (028) 1234 5678 | Email: info@vstep.edu.vn | Website: www.vstep.edu.vn").setFont(fontRegular).setFontSize(8));
            footerTable.addCell(footerCell);
            document.add(footerTable);
            
            document.close();
            return baos.toByteArray();
            
        } catch (Exception e) {
            document.close();
            throw new IOException("Lỗi khi tạo PDF: " + e.getMessage(), e);
        }
    }
    
    private static Cell createCell(String text, PdfFont font, float fontSize, boolean isHeader) {
        Cell cell = new Cell().add(new Paragraph(text).setFont(font).setFontSize(fontSize));
        if (isHeader) {
            cell.setBackgroundColor(ColorConstants.LIGHT_GRAY);
            cell.setBold();
        }
        return cell;
    }
    
    private static String formatCurrency(long amount) {
        return currencyFormat.format(amount) + " VND";
    }
}


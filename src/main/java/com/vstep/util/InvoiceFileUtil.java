package com.vstep.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class InvoiceFileUtil {
    
    // Thư mục lưu hóa đơn (tương đối với webapp root hoặc absolute path)
    private static final String INVOICE_DIR = "invoices";
    
    /**
     * Lưu file PDF hóa đơn vào thư mục
     * @param pdfBytes Nội dung PDF
     * @param fileName Tên file
     * @return Đường dẫn file đã lưu (relative hoặc absolute)
     */
    public static String saveInvoiceFile(byte[] pdfBytes, String fileName) throws IOException {
        // Tạo thư mục nếu chưa tồn tại
        String baseDir = getInvoiceBaseDirectory();
        File invoiceDir = new File(baseDir);
        if (!invoiceDir.exists()) {
            invoiceDir.mkdirs();
        }
        
        // Tạo file path
        String filePath = baseDir + File.separator + fileName;
        File file = new File(filePath);
        
        // Ghi file
        try (FileOutputStream fos = new FileOutputStream(file)) {
            fos.write(pdfBytes);
            fos.flush();
        }
        
        // Trả về đường dẫn file (absolute path để dễ truy cập)
        return file.getAbsolutePath();
    }
    
    /**
     * Lấy thư mục base để lưu hóa đơn
     */
    private static String getInvoiceBaseDirectory() {
        // Thử lấy từ system property hoặc dùng thư mục mặc định
        String customDir = System.getProperty("vstep.invoice.dir");
        if (customDir != null && !customDir.isEmpty()) {
            return customDir;
        }
        
        // Dùng thư mục trong user home hoặc temp
        String userHome = System.getProperty("user.home");
        if (userHome != null) {
            return userHome + File.separator + "vstep_invoices";
        }
        
        // Fallback: dùng temp directory
        String tempDir = System.getProperty("java.io.tmpdir");
        return tempDir + File.separator + "vstep_invoices";
    }
    
    /**
     * Xóa file hóa đơn
     */
    public static boolean deleteInvoiceFile(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        
        try {
            File file = new File(filePath);
            if (file.exists() && file.isFile()) {
                return file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Kiểm tra file có tồn tại không
     */
    public static boolean fileExists(String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }
        
        File file = new File(filePath);
        return file.exists() && file.isFile();
    }
}


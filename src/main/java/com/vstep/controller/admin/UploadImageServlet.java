package com.vstep.controller.admin;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "AdminUploadImageServlet", urlPatterns = {"/admin/upload-ckeditor"})
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)
public class UploadImageServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "/uploads/ckeditor";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Set encoding
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        
        try {
            // CKEditor có thể gửi file với name "upload" hoặc "file"
            Part filePart = req.getPart("upload");
            if (filePart == null) {
                filePart = req.getPart("file");
            }
            if (filePart == null && req.getParts() != null) {
                // Nếu không tìm thấy, lấy part đầu tiên
                for (Part part : req.getParts()) {
                    if (part.getSize() > 0 && part.getContentType() != null && part.getContentType().startsWith("image/")) {
                        filePart = part;
                        break;
                    }
                }
            }
            
            String funcNum = req.getParameter("CKEditorFuncNum");

            if (filePart == null || filePart.getSize() == 0) {
                writeError(resp, funcNum, "Không tìm thấy tệp tải lên. Vui lòng chọn một file ảnh.");
                return;
            }

            // Validate file size
            if (filePart.getSize() > 10 * 1024 * 1024) {
                writeError(resp, funcNum, "Kích thước file quá lớn. Tối đa 10MB");
                return;
            }

            String contentType = filePart.getContentType();
            if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
                writeError(resp, funcNum, "Chỉ hỗ trợ tải ảnh (JPG, PNG, GIF, etc.)");
                return;
            }

            // Validate file extension
            String submittedName = filePart.getSubmittedFileName();
            if (submittedName == null || submittedName.isEmpty()) {
                submittedName = "image";
            }
            
            String fileName = Paths.get(submittedName).getFileName().toString();
            String extension = "";
            int dotIndex = fileName.lastIndexOf('.');
            if (dotIndex >= 0 && dotIndex < fileName.length() - 1) {
                extension = fileName.substring(dotIndex).toLowerCase();
                // Validate extension
                String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp"};
                boolean validExtension = false;
                for (String ext : allowedExtensions) {
                    if (extension.equals(ext)) {
                        validExtension = true;
                        break;
                    }
                }
                if (!validExtension) {
                    writeError(resp, funcNum, "Định dạng file không được hỗ trợ. Chỉ chấp nhận: JPG, PNG, GIF, WEBP, BMP");
                    return;
                }
            } else {
                // Nếu không có extension, thử dựa vào content type
                if (contentType.contains("jpeg")) {
                    extension = ".jpg";
                } else if (contentType.contains("png")) {
                    extension = ".png";
                } else if (contentType.contains("gif")) {
                    extension = ".gif";
                } else {
                    extension = ".jpg"; // default
                }
            }

            String safeName = UUID.randomUUID().toString().replace("-", "") + extension;

            // Get upload directory
            String realPath = getServletContext().getRealPath(UPLOAD_DIR);
            if (realPath == null) {
                // Fallback: try to use absolute path
                realPath = System.getProperty("user.home") + "/vstep_uploads/ckeditor";
            }
            
            Path uploadRoot = Paths.get(realPath);
            try {
                Files.createDirectories(uploadRoot);
            } catch (Exception e) {
                writeError(resp, funcNum, "Không thể tạo thư mục lưu trữ: " + e.getMessage());
                return;
            }

            // Copy file
            try (InputStream input = filePart.getInputStream()) {
                Path targetFile = uploadRoot.resolve(safeName);
                Files.copy(input, targetFile, StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                writeError(resp, funcNum, "Không thể lưu file: " + e.getMessage());
                return;
            }

            // Build public URL - đảm bảo URL đúng
            String contextPath = req.getContextPath();
            String uploadPath = UPLOAD_DIR.startsWith("/") ? UPLOAD_DIR : "/" + UPLOAD_DIR;
            String publicUrl = contextPath + uploadPath + "/" + URLEncoder.encode(safeName, StandardCharsets.UTF_8);
            // Đảm bảo URL không có double slash
            publicUrl = publicUrl.replaceAll("/+", "/");

            // Response to CKEditor
            if (funcNum != null && !funcNum.isEmpty()) {
                resp.setContentType("text/html; charset=UTF-8");
                String response = "<script type=\"text/javascript\">" +
                                 "window.parent.CKEDITOR.tools.callFunction(" +
                                 funcNum + ", '" + escapeJs(publicUrl) + "', '');" +
                                 "</script>";
                resp.getWriter().print(response);
                resp.getWriter().flush();
            } else {
                // JSON response for newer CKEditor versions
                resp.setContentType("application/json; charset=UTF-8");
                String jsonResponse = "{\"uploaded\":1,\"fileName\":\"" + escapeJson(safeName) + 
                                      "\",\"url\":\"" + escapeJson(publicUrl) + "\"}";
                resp.getWriter().print(jsonResponse);
                resp.getWriter().flush();
            }
        } catch (Exception e) {
            String funcNum = req.getParameter("CKEditorFuncNum");
            writeError(resp, funcNum, "Lỗi khi upload file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void writeError(HttpServletResponse resp, String funcNum, String message) throws IOException {
        resp.setCharacterEncoding("UTF-8");
        
        if (funcNum != null && !funcNum.isEmpty()) {
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().print(
                    "<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" +
                    funcNum + ", '', '" + escapeJs(message) + "');</script>"
            );
        } else {
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().print("{\"uploaded\":0,\"error\":{\"message\":\"" + escapeJson(message) + "\"}}");
        }
    }

    private String escapeJs(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                   .replace("'", "\\'")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("</script>", "<\\/script>");
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}


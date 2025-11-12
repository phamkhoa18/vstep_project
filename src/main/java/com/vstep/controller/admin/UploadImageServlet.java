package com.vstep.controller.admin;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
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
        Part filePart = req.getPart("upload");
        String funcNum = req.getParameter("CKEditorFuncNum");

        if (filePart == null || filePart.getSize() == 0) {
            writeError(resp, funcNum, "Không tìm thấy tệp tải lên");
            return;
        }

        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("image/")) {
            writeError(resp, funcNum, "Chỉ hỗ trợ tải ảnh");
            return;
        }

        String submittedName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String extension = "";
        int dotIndex = submittedName.lastIndexOf('.');
        if (dotIndex >= 0) {
            extension = submittedName.substring(dotIndex).toLowerCase();
        }

        String safeName = UUID.randomUUID().toString().replace("-", "") + extension;

        String realPath = getServletContext().getRealPath(UPLOAD_DIR);
        if (realPath == null) {
            writeError(resp, funcNum, "Máy chủ chưa cấu hình thư mục lưu trữ cho CKEditor");
            return;
        }
        Path uploadRoot = Paths.get(realPath);
        Files.createDirectories(uploadRoot);

        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, uploadRoot.resolve(safeName), StandardCopyOption.REPLACE_EXISTING);
        }

        String publicUrl = req.getContextPath() + UPLOAD_DIR + "/" + URLEncoder.encode(safeName, "UTF-8");

        if (funcNum != null) {
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().printf(
                    "<script>window.parent.CKEDITOR.tools.callFunction(%s,'%s','');</script>",
                    funcNum, escapeJs(publicUrl)
            );
        } else {
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().printf("{\"uploaded\":1,\"fileName\":\"%s\",\"url\":\"%s\"}",
                    escapeJson(safeName), escapeJson(publicUrl));
        }
    }

    private void writeError(HttpServletResponse resp, String funcNum, String message) throws IOException {
        if (funcNum != null) {
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().printf(
                    "<script>window.parent.CKEDITOR.tools.callFunction(%s,'','%s');</script>",
                    funcNum, escapeJs(message)
            );
        } else {
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().printf("{\"uploaded\":0,\"error\":{\"message\":\"%s\"}}", escapeJson(message));
        }
    }

    private String escapeJs(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("'", "\\'");
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}


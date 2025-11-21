package com.vstep.util;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.util.ByteArrayDataSource;

public class EmailService {
    private static final Logger LOGGER = Logger.getLogger(EmailService.class.getName());
    
    // Cấu hình email - có thể đọc từ file config hoặc environment variables
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_USERNAME = "thongtinkhachhangphaply@gmail.com"; // Email đăng nhập SMTP
    private static final String SMTP_PASSWORD = "pjqa putc clox xvew"; // App password
    private static final String FROM_EMAIL = "thongtinkhachhangphaply@gmail.com"; // Email gửi đi (hiển thị người gửi)
    private static final String FROM_NAME = "VSTEP - Hệ thống đăng ký lớp ôn";
    
    /**
     * Gửi email kích hoạt tài khoản cho người dùng mới đăng ký
     */
    public static boolean sendActivationEmail(String toEmail, String hoTen, String activationLink) {
        String subject = "[VSTEP] Kích hoạt tài khoản của bạn";
        String htmlBody = buildActivationEmailBody(hoTen, activationLink);
        return sendEmail(toEmail, subject, htmlBody, true);
    }
    
    /**
     * Gửi email thông báo đăng ký lớp mới cho admin
     */
    public static boolean sendRegistrationNotificationToAdmin(String adminEmail, 
                                                               String studentName,
                                                               String studentEmail,
                                                               String studentPhone,
                                                               String className,
                                                               String classCode,
                                                               String registrationCode,
                                                               String registrationDate) {
        String subject = "[VSTEP] Thông báo đăng ký lớp ôn mới - " + classCode;
        
        String htmlBody = buildRegistrationEmailBody(studentName, studentEmail, studentPhone, 
                                                     className, classCode, registrationCode, registrationDate);
        
        return sendEmail(adminEmail, subject, htmlBody, true);
    }
    
    /**
     * Gửi email xác nhận duyệt đăng ký lớp cho học viên
     */
    public static boolean sendClassApprovalEmail(String toEmail,
                                                 String studentName,
                                                 String classTitle,
                                                 String classCode,
                                                 String scheduleText,
                                                 long amountPaid,
                                                 Long totalFee,
                                                 String registrationCode) {
        String subject = "[VSTEP] Xác nhận đăng ký lớp thành công - " + (classCode != null ? classCode : "");
        String body = buildClassApprovalEmailBody(studentName, classTitle, classCode, scheduleText,
                                                  amountPaid, totalFee, registrationCode);
        return sendEmail(toEmail, subject, body, true);
    }
    
    /**
     * Gửi email khôi phục mật khẩu
     */
    public static boolean sendResetPasswordEmail(String toEmail, String hoTen, String resetLink) {
        String subject = "[VSTEP] Khôi phục mật khẩu";
        String htmlBody = buildResetPasswordEmailBody(hoTen, resetLink);
        return sendEmail(toEmail, subject, htmlBody, true);
    }
    
    /**
     * Gửi email xác nhận đăng ký ca thi cho học viên
     */
    public static boolean sendExamRegistrationEmail(String toEmail,
                                                    String studentName,
                                                    String examCode,
                                                    String examDate,
                                                    String examTime,
                                                    String examLocation,
                                                    String registrationCode,
                                                    long amountToPay,
                                                    long discount,
                                                    boolean daTungThi,
                                                    String discountCode) {
        String subject = "[VSTEP] Xác nhận đăng ký ca thi - " + (examCode != null ? examCode : "");
        String htmlBody = buildExamRegistrationEmailBody(studentName, examCode, examDate, examTime, 
                                                         examLocation, registrationCode, amountToPay, 
                                                         discount, daTungThi, discountCode);
        return sendEmail(toEmail, subject, htmlBody, true);
    }
    
    /**
     * Gửi email thông báo đăng ký ca thi mới cho admin
     */
    public static boolean sendExamRegistrationNotificationToAdmin(String adminEmail,
                                                               String studentName,
                                                               String studentEmail,
                                                               String studentPhone,
                                                               String examCode,
                                                               String examDate,
                                                               String examTime,
                                                               String registrationCode,
                                                               String registrationDate) {
        String subject = "[VSTEP] Thông báo đăng ký ca thi mới - " + (examCode != null ? examCode : "");
        String htmlBody = buildExamRegistrationNotificationEmailBody(studentName, studentEmail, studentPhone,
                                                                   examCode, examDate, examTime, 
                                                                   registrationCode, registrationDate);
        return sendEmail(adminEmail, subject, htmlBody, true);
    }
    
    /**
     * Gửi email đơn giản
     */
    public static boolean sendEmail(String toEmail, String subject, String body, boolean isHtml) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            
            if (isHtml) {
                message.setContent(body, "text/html; charset=UTF-8");
            } else {
                message.setText(body);
            }
            
            Transport.send(message);
            LOGGER.info("Email đã được gửi thành công đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi gửi email đến " + toEmail, e);
            return false;
        }
    }
    
    /**
     * Gửi email với file đính kèm PDF
     */
    public static boolean sendEmailWithAttachment(String toEmail, String subject, String body, 
                                                  boolean isHtml, byte[] pdfAttachment, 
                                                  String attachmentFileName) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SMTP_USERNAME, SMTP_PASSWORD);
                }
            });
            
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            
            // Tạo multipart message
            Multipart multipart = new MimeMultipart();
            
            // Phần nội dung email
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            if (isHtml) {
                messageBodyPart.setContent(body, "text/html; charset=UTF-8");
            } else {
                messageBodyPart.setText(body);
            }
            multipart.addBodyPart(messageBodyPart);
            
            // Phần đính kèm PDF
            if (pdfAttachment != null && pdfAttachment.length > 0) {
                MimeBodyPart attachmentPart = new MimeBodyPart();
                jakarta.mail.util.ByteArrayDataSource dataSource = new jakarta.mail.util.ByteArrayDataSource(
                    pdfAttachment, "application/pdf");
                attachmentPart.setDataHandler(new jakarta.activation.DataHandler(dataSource));
                attachmentPart.setFileName(attachmentFileName != null ? attachmentFileName : "invoice.pdf");
                multipart.addBodyPart(attachmentPart);
            }
            
            message.setContent(multipart);
            
            Transport.send(message);
            LOGGER.info("Email với file đính kèm đã được gửi thành công đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi gửi email với file đính kèm đến " + toEmail, e);
            return false;
        }
    }
    
    /**
     * Xây dựng nội dung email thông báo đăng ký
     */
    private static String buildRegistrationEmailBody(String studentName, String studentEmail, 
                                                   String studentPhone, String className, 
                                                   String classCode, String registrationCode,
                                                   String registrationDate) {
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: white; padding: 20px; border-radius: 8px 8px 0 0; }
                    .content { background: #f9fafb; padding: 30px; border: 1px solid #e5e7eb; }
                    .info-box { background: white; padding: 15px; margin: 15px 0; border-radius: 6px; border-left: 4px solid #2563eb; }
                    .info-row { margin: 10px 0; }
                    .label { font-weight: bold; color: #4b5563; }
                    .value { color: #111827; }
                    .footer { background: #f3f4f6; padding: 15px; text-align: center; font-size: 12px; color: #6b7280; border-radius: 0 0 8px 8px; }
                    .button { display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 6px; margin-top: 20px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h2 style="margin: 0;">🔔 Thông báo đăng ký lớp ôn mới</h2>
                    </div>
                    <div class="content">
                        <p>Xin chào Quản trị viên,</p>
                        <p>Có một học viên mới đã đăng ký lớp ôn. Vui lòng xem thông tin chi tiết bên dưới:</p>
                        
                        <div class="info-box">
                            <h3 style="margin-top: 0; color: #2563eb;">Thông tin học viên</h3>
                            <div class="info-row">
                                <span class="label">Họ và tên:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Email:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Số điện thoại:</span>
                                <span class="value">%s</span>
                            </div>
                        </div>
                        
                        <div class="info-box">
                            <h3 style="margin-top: 0; color: #2563eb;">Thông tin lớp đăng ký</h3>
                            <div class="info-row">
                                <span class="label">Mã lớp:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Tên lớp:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Mã đăng ký:</span>
                                <span class="value"><strong>%s</strong></span>
                            </div>
                            <div class="info-row">
                                <span class="label">Thời gian đăng ký:</span>
                                <span class="value">%s</span>
                            </div>
                        </div>
                        
                        <p style="margin-top: 25px;">
                            <a href="#" class="button">Xem chi tiết đăng ký</a>
                        </p>
                        
                        <p style="margin-top: 25px; color: #6b7280; font-size: 14px;">
                            <em>Vui lòng đăng nhập vào hệ thống quản trị để xử lý đăng ký này.</em>
                        </p>
                    </div>
                    <div class="footer">
                        <p>Email này được gửi tự động từ hệ thống VSTEP.</p>
                        <p>Vui lòng không trả lời email này.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                escapeHtml(studentName),
                escapeHtml(studentEmail),
                escapeHtml(studentPhone),
                escapeHtml(classCode),
                escapeHtml(className),
                escapeHtml(registrationCode),
                escapeHtml(registrationDate)
            );
    }
    
    /**
     * Xây dựng nội dung email kích hoạt tài khoản
     */
    private static String buildActivationEmailBody(String hoTen, String activationLink) {
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: white; padding: 20px; border-radius: 8px 8px 0 0; }
                    .content { background: #f9fafb; padding: 30px; border: 1px solid #e5e7eb; }
                    .button { display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 6px; margin: 20px 0; }
                    .button:hover { background: #1e40af; }
                    .footer { background: #f3f4f6; padding: 15px; text-align: center; font-size: 12px; color: #6b7280; border-radius: 0 0 8px 8px; }
                    .warning { color: #dc2626; font-size: 14px; margin-top: 20px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h2 style="margin: 0;">🔐 Kích hoạt tài khoản VSTEP</h2>
                    </div>
                    <div class="content">
                        <p>Xin chào <strong>%s</strong>,</p>
                        <p>Cảm ơn bạn đã đăng ký tài khoản tại hệ thống VSTEP!</p>
                        <p>Để hoàn tất việc đăng ký và sử dụng tài khoản, vui lòng nhấp vào nút bên dưới để kích hoạt tài khoản của bạn:</p>
                        
                        <div style="text-align: center; margin: 30px 0;">
                            <a href="%s" class="button">Kích hoạt tài khoản</a>
                        </div>
                        
                        <p>Hoặc bạn có thể sao chép và dán đường dẫn sau vào trình duyệt:</p>
                        <p style="word-break: break-all; color: #2563eb; background: #f0f9ff; padding: 10px; border-radius: 4px; font-size: 12px;">%s</p>
                        
                        <p class="warning">
                            <strong>Lưu ý:</strong> Link kích hoạt này chỉ có hiệu lực trong 24 giờ. 
                            Nếu bạn không kích hoạt trong thời gian này, vui lòng liên hệ với quản trị viên.
                        </p>
                        
                        <p style="margin-top: 25px; color: #6b7280; font-size: 14px;">
                            Nếu bạn không đăng ký tài khoản này, vui lòng bỏ qua email này.
                        </p>
                    </div>
                    <div class="footer">
                        <p>Email này được gửi tự động từ hệ thống VSTEP.</p>
                        <p>Vui lòng không trả lời email này.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                escapeHtml(hoTen),
                activationLink,
                activationLink
            );
    }
    
    /**
     * Xây dựng nội dung email xác nhận duyệt đăng ký lớp
     */
    private static String buildClassApprovalEmailBody(String studentName,
                                                      String classTitle,
                                                      String classCode,
                                                      String scheduleText,
                                                      long amountPaid,
                                                      Long totalFee,
                                                      String registrationCode) {
        String amountPaidStr = String.format("%,dđ", amountPaid).replace(',', '.');
        String totalFeeStr = totalFee != null ? String.format("%,dđ", totalFee).replace(',', '.') : "";
        String paidLine = totalFee != null && totalFee > amountPaid
                ? "Đã thanh toán: <strong>" + escapeHtml(amountPaidStr) + "</strong> / " + escapeHtml(totalFeeStr)
                : "Số tiền đã thanh toán: <strong>" + escapeHtml(amountPaidStr) + "</strong>";
        
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #111827; background: #f9fafb; }
                    .container { max-width: 640px; margin: 0 auto; padding: 24px; }
                    .card { background: #ffffff; border: 1px solid #e5e7eb; border-radius: 10px; overflow: hidden; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: #fff; padding: 20px; }
                    .header h2 { margin: 0; font-size: 20px; }
                    .content { padding: 22px; }
                    .row { margin: 8px 0; }
                    .label { color: #6b7280; font-size: 13px; display: block; }
                    .value { font-size: 15px; font-weight: 600; color: #0f172a; }
                    .footer { background: #f3f4f6; padding: 14px 20px; color: #6b7280; font-size: 12px; }
                    .success { color: #10b981; font-weight: 700; }
                    .code { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, \"Liberation Mono\", \"Courier New\", monospace; background: #f1f5f9; padding: 4px 8px; border-radius: 6px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="card">
                        <div class="header">
                            <h2>✅ Xác nhận đăng ký lớp thành công</h2>
                        </div>
                        <div class="content">
                            <p>Xin chào <strong>%s</strong>,</p>
                            <p class="row">Đăng ký lớp của bạn đã được <span class="success">DUYỆT</span>.</p>
                            <div class="row">
                                <span class="label">Mã đăng ký</span>
                                <span class="value code">%s</span>
                            </div>
                            <div class="row">
                                <span class="label">Lớp học</span>
                                <span class="value">%s · %s</span>
                            </div>
                            %s
                            %s
                            <p style="margin-top: 18px; color: #334155; font-size: 14px;">
                                Vui lòng theo dõi email này để cập nhật thông tin mới nhất về lớp. Cảm ơn bạn đã tin tưởng VSTEP!
                            </p>
                        </div>
                        <div class="footer">
                            Email này được gửi tự động từ hệ thống VSTEP. Vui lòng không trả lời email này.
                        </div>
                    </div>
                </div>
            </body>
            </html>
        """.formatted(
                escapeHtml(studentName != null ? studentName : ""),
                escapeHtml(registrationCode != null ? registrationCode : ""),
                escapeHtml(classCode != null ? classCode : ""),
                escapeHtml(classTitle != null ? classTitle : ""),
                scheduleText != null && !scheduleText.isBlank()
                        ? "<div class=\"row\"><span class=\"label\">Lịch học</span><span class=\"value\">" + escapeHtml(scheduleText) + "</span></div>"
                        : "",
                "<div class=\"row\"><span class=\"label\">Thanh toán</span><span class=\"value\">" + paidLine + "</span></div>"
        );
    }
    
    /**
     * Xây dựng nội dung email khôi phục mật khẩu
     */
    private static String buildResetPasswordEmailBody(String hoTen, String resetLink) {
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: white; padding: 20px; border-radius: 8px 8px 0 0; }
                    .content { background: #f9fafb; padding: 30px; border: 1px solid #e5e7eb; }
                    .button { display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 6px; margin: 20px 0; }
                    .button:hover { background: #1e40af; }
                    .footer { background: #f3f4f6; padding: 15px; text-align: center; font-size: 12px; color: #6b7280; border-radius: 0 0 8px 8px; }
                    .warning { color: #dc2626; font-size: 14px; margin-top: 20px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h2 style="margin: 0;">🔒 Khôi phục mật khẩu VSTEP</h2>
                    </div>
                    <div class="content">
                        <p>Xin chào <strong>%s</strong>,</p>
                        <p>Chúng tôi nhận được yêu cầu khôi phục mật khẩu cho tài khoản của bạn.</p>
                        <p>Để đặt lại mật khẩu mới, vui lòng nhấp vào nút bên dưới:</p>
                        
                        <div style="text-align: center; margin: 30px 0;">
                            <a href="%s" class="button">Đặt lại mật khẩu</a>
                        </div>
                        
                        <p>Hoặc bạn có thể sao chép và dán đường dẫn sau vào trình duyệt:</p>
                        <p style="word-break: break-all; color: #2563eb; background: #f0f9ff; padding: 10px; border-radius: 4px; font-size: 12px;">%s</p>
                        
                        <p class="warning">
                            <strong>Lưu ý quan trọng:</strong>
                            <ul style="margin-top: 10px; padding-left: 20px;">
                                <li>Link này chỉ có hiệu lực trong 24 giờ.</li>
                                <li>Link chỉ có thể sử dụng một lần duy nhất.</li>
                                <li>Nếu bạn không yêu cầu khôi phục mật khẩu, vui lòng bỏ qua email này.</li>
                            </ul>
                        </p>
                        
                        <p style="margin-top: 25px; color: #6b7280; font-size: 14px;">
                            Nếu bạn không thực hiện yêu cầu này, mật khẩu của bạn sẽ không thay đổi.
                        </p>
                    </div>
                    <div class="footer">
                        <p>Email này được gửi tự động từ hệ thống VSTEP.</p>
                        <p>Vui lòng không trả lời email này.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                escapeHtml(hoTen),
                resetLink,
                resetLink
            );
    }
    
    /**
     * Xây dựng nội dung email xác nhận đăng ký ca thi (public để có thể dùng ở servlet)
     */
    public static String buildExamRegistrationEmailBody(String studentName,
                                                         String examCode,
                                                         String examDate,
                                                         String examTime,
                                                         String examLocation,
                                                         String registrationCode,
                                                         long amountToPay,
                                                         long discount,
                                                         boolean daTungThi,
                                                         String discountCode) {
        String amountStr = String.format("%,dđ", amountToPay).replace(',', '.');
        String discountStr = discount > 0 ? String.format("%,dđ", discount).replace(',', '.') : "";
        String originalPriceStr = String.format("%,dđ", amountToPay + discount).replace(',', '.');
        
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #111827; background: #f9fafb; }
                    .container { max-width: 640px; margin: 0 auto; padding: 24px; }
                    .card { background: #ffffff; border: 1px solid #e5e7eb; border-radius: 10px; overflow: hidden; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: #fff; padding: 20px; }
                    .header h2 { margin: 0; font-size: 20px; }
                    .content { padding: 22px; }
                    .row { margin: 8px 0; }
                    .label { color: #6b7280; font-size: 13px; display: block; }
                    .value { font-size: 15px; font-weight: 600; color: #0f172a; }
                    .footer { background: #f3f4f6; padding: 14px 20px; color: #6b7280; font-size: 12px; }
                    .success { color: #10b981; font-weight: 700; }
                    .code { font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace; background: #f1f5f9; padding: 4px 8px; border-radius: 6px; }
                    .info-box { background: #f0f9ff; border-left: 4px solid #2563eb; padding: 12px; margin: 12px 0; border-radius: 4px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="card">
                        <div class="header">
                            <h2>✅ Xác nhận đăng ký ca thi thành công</h2>
                        </div>
                        <div class="content">
                            <p>Xin chào <strong>%s</strong>,</p>
                            <p class="row">Đăng ký ca thi của bạn đã được <span class="success">TIẾP NHẬN</span>.</p>
                            
                            <div class="row">
                                <span class="label">Mã đăng ký</span>
                                <span class="value code">%s</span>
                            </div>
                            
                            <div class="row">
                                <span class="label">Mã ca thi</span>
                                <span class="value">%s</span>
                            </div>
                            
                            <div class="row">
                                <span class="label">Ngày thi</span>
                                <span class="value">%s</span>
                            </div>
                            
                            <div class="row">
                                <span class="label">Giờ thi</span>
                                <span class="value">%s</span>
                            </div>
                            
                            <div class="row">
                                <span class="label">Địa điểm</span>
                                <span class="value">%s</span>
                            </div>
                            
                            <div class="info-box">
                                <div class="row">
                                    <span class="label">Giá gốc</span>
                                    <span class="value">%s</span>
                                </div>
                                %s
                                %s
                                <div class="row" style="margin-top: 8px; padding-top: 8px; border-top: 1px solid #cbd5e1;">
                                    <span class="label" style="font-weight: 700; color: #0f172a;">Số tiền phải trả</span>
                                    <span class="value" style="font-size: 18px; color: #2563eb;">%s</span>
                                </div>
                            </div>
                            
                            <p style="margin-top: 18px; color: #334155; font-size: 14px;">
                                <strong>Lưu ý:</strong> Vui lòng thanh toán để hoàn tất đăng ký. Sau khi thanh toán, đăng ký của bạn sẽ được duyệt và bạn sẽ nhận được email xác nhận.
                            </p>
                            
                            <p style="margin-top: 18px; color: #334155; font-size: 14px;">
                                Vui lòng theo dõi email này để cập nhật thông tin mới nhất về ca thi. Cảm ơn bạn đã tin tưởng VSTEP!
                            </p>
                        </div>
                        <div class="footer">
                            Email này được gửi tự động từ hệ thống VSTEP. Vui lòng không trả lời email này.
                        </div>
                    </div>
                </div>
            </body>
            </html>
        """.formatted(
                escapeHtml(studentName != null ? studentName : ""),
                escapeHtml(registrationCode != null ? registrationCode : ""),
                escapeHtml(examCode != null ? examCode : ""),
                escapeHtml(examDate != null ? examDate : "Chưa có thông tin"),
                escapeHtml(examTime != null ? examTime : "Chưa có thông tin"),
                escapeHtml(examLocation != null && !examLocation.isEmpty() ? examLocation : "Chưa có địa điểm"),
                originalPriceStr,
                discount > 0 
                    ? "<div class=\"row\"><span class=\"label\">Giảm giá</span><span class=\"value\" style=\"color: #10b981;\">-" + discountStr + "</span></div>"
                    : "",
                daTungThi 
                    ? "<div class=\"row\"><span class=\"label\">Đã từng thi</span><span class=\"value\" style=\"color: #10b981;\">✓ Có (được giảm giá)</span></div>"
                    : "",
                amountStr
        );
    }
    
    /**
     * Xây dựng nội dung email thông báo đăng ký ca thi cho admin
     */
    private static String buildExamRegistrationNotificationEmailBody(String studentName,
                                                                     String studentEmail,
                                                                     String studentPhone,
                                                                     String examCode,
                                                                     String examDate,
                                                                     String examTime,
                                                                     String registrationCode,
                                                                     String registrationDate) {
        return """
            <!DOCTYPE html>
            <html lang="vi">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #2563eb 0%%, #1e40af 100%%); color: white; padding: 20px; border-radius: 8px 8px 0 0; }
                    .content { background: #f9fafb; padding: 30px; border: 1px solid #e5e7eb; }
                    .info-box { background: white; padding: 15px; margin: 15px 0; border-radius: 6px; border-left: 4px solid #2563eb; }
                    .info-row { margin: 10px 0; }
                    .label { font-weight: bold; color: #4b5563; }
                    .value { color: #111827; }
                    .footer { background: #f3f4f6; padding: 15px; text-align: center; font-size: 12px; color: #6b7280; border-radius: 0 0 8px 8px; }
                    .button { display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 6px; margin-top: 20px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h2 style="margin: 0;">🔔 Thông báo đăng ký ca thi mới</h2>
                    </div>
                    <div class="content">
                        <p>Xin chào Quản trị viên,</p>
                        <p>Có một thí sinh mới đã đăng ký ca thi. Vui lòng xem thông tin chi tiết bên dưới:</p>
                        
                        <div class="info-box">
                            <h3 style="margin-top: 0; color: #2563eb;">Thông tin thí sinh</h3>
                            <div class="info-row">
                                <span class="label">Họ và tên:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Email:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Số điện thoại:</span>
                                <span class="value">%s</span>
                            </div>
                        </div>
                        
                        <div class="info-box">
                            <h3 style="margin-top: 0; color: #2563eb;">Thông tin ca thi đăng ký</h3>
                            <div class="info-row">
                                <span class="label">Mã ca thi:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Ngày thi:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Giờ thi:</span>
                                <span class="value">%s</span>
                            </div>
                            <div class="info-row">
                                <span class="label">Mã đăng ký:</span>
                                <span class="value"><strong>%s</strong></span>
                            </div>
                            <div class="info-row">
                                <span class="label">Thời gian đăng ký:</span>
                                <span class="value">%s</span>
                            </div>
                        </div>
                        
                        <p style="margin-top: 25px;">
                            <a href="#" class="button">Xem chi tiết đăng ký</a>
                        </p>
                        
                        <p style="margin-top: 25px; color: #6b7280; font-size: 14px;">
                            <em>Vui lòng đăng nhập vào hệ thống quản trị để xử lý đăng ký này.</em>
                        </p>
                    </div>
                    <div class="footer">
                        <p>Email này được gửi tự động từ hệ thống VSTEP.</p>
                        <p>Vui lòng không trả lời email này.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(
                escapeHtml(studentName),
                escapeHtml(studentEmail),
                escapeHtml(studentPhone),
                escapeHtml(examCode != null ? examCode : "N/A"),
                escapeHtml(examDate != null ? examDate : "Chưa có thông tin"),
                escapeHtml(examTime != null ? examTime : "Chưa có thông tin"),
                escapeHtml(registrationCode != null ? registrationCode : "N/A"),
                escapeHtml(registrationDate)
            );
    }
    
    /**
     * Escape HTML để tránh XSS
     */
    private static String escapeHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
}


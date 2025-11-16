package com.vstep.util;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

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


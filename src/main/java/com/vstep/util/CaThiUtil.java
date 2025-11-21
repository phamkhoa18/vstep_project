package com.vstep.util;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import com.vstep.model.CaThi;

public class CaThiUtil {
    
    /**
     * Kiểm tra ca thi có bị khóa không
     * Ca thi bị khóa nếu:
     * - Đã diễn ra (thời gian bắt đầu đã qua)
     * - Còn 30 phút nữa là bắt đầu
     * 
     * @param caThi Ca thi cần kiểm tra
     * @return true nếu ca thi bị khóa, false nếu còn có thể đăng ký
     */
    public static boolean isLocked(CaThi caThi) {
        if (caThi == null) {
            return true;
        }
        
        Date ngayThi = caThi.getNgayThi();
        Time gioBatDau = caThi.getGioBatDau();
        
        if (ngayThi == null || gioBatDau == null) {
            return false; // Nếu không có thông tin thời gian, không khóa
        }
        
        // Chuyển đổi sang LocalDateTime
        LocalDate date = ngayThi.toLocalDate();
        LocalTime time = gioBatDau.toLocalTime();
        LocalDateTime thoiGianBatDau = LocalDateTime.of(date, time);
        
        // Thời gian hiện tại
        LocalDateTime now = LocalDateTime.now();
        
        // Thời gian bắt đầu trừ 30 phút (deadline để đăng ký)
        LocalDateTime deadline = thoiGianBatDau.minusMinutes(30);
        
        // Khóa nếu đã qua thời gian bắt đầu hoặc đã qua deadline (còn 30 phút nữa)
        return now.isAfter(deadline) || now.isAfter(thoiGianBatDau);
    }
    
    /**
     * Lấy thông báo trạng thái ca thi
     * @param caThi Ca thi cần kiểm tra
     * @return Thông báo trạng thái
     */
    public static String getStatusMessage(CaThi caThi) {
        if (caThi == null) {
            return "Không có thông tin";
        }
        
        if (isLocked(caThi)) {
            Date ngayThi = caThi.getNgayThi();
            Time gioBatDau = caThi.getGioBatDau();
            
            if (ngayThi == null || gioBatDau == null) {
                return "Đã khóa";
            }
            
            LocalDate date = ngayThi.toLocalDate();
            LocalTime time = gioBatDau.toLocalTime();
            LocalDateTime thoiGianBatDau = LocalDateTime.of(date, time);
            LocalDateTime now = LocalDateTime.now();
            
            if (now.isAfter(thoiGianBatDau)) {
                return "Đã diễn ra";
            } else {
                return "Đã khóa (còn 30 phút nữa)";
            }
        }
        
        return "Có thể đăng ký";
    }
}


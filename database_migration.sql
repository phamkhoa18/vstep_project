-- Migration script: Thêm cột activation_token vào bảng nguoi_dung
-- Chạy script này để hỗ trợ chức năng kích hoạt tài khoản qua email

ALTER TABLE nguoi_dung 
ADD COLUMN activation_token VARCHAR(255) NULL AFTER kich_hoat;

-- Đảm bảo index cho tìm kiếm nhanh theo token
CREATE INDEX idx_activation_token ON nguoi_dung(activation_token);




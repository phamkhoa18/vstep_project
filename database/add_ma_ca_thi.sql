-- Thêm cột ma_ca_thi vào bảng ca_thi
ALTER TABLE ca_thi 
ADD COLUMN ma_ca_thi VARCHAR(100) NULL AFTER id;

-- Tạo index cho ma_ca_thi để tìm kiếm nhanh hơn
CREATE INDEX idx_ma_ca_thi ON ca_thi(ma_ca_thi);

-- Cập nhật các ca thi hiện có với mã tự động (nếu cần)
-- UPDATE ca_thi SET ma_ca_thi = CONCAT('CA_', UNIX_TIMESTAMP(ngay_tao) * 1000, FLOOR(RAND() * 900) + 100) WHERE ma_ca_thi IS NULL;


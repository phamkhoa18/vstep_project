-- Thêm cột ma_code_giam_gia vào bảng dang_ky_lop
ALTER TABLE dang_ky_lop 
ADD COLUMN ma_code_giam_gia VARCHAR(50) NULL AFTER ma_xac_nhan;

-- Thêm cột ma_code_giam_gia vào bảng dang_ky_thi
ALTER TABLE dang_ky_thi 
ADD COLUMN ma_code_giam_gia VARCHAR(50) NULL AFTER ma_xac_nhan;

-- Tạo index cho tìm kiếm nhanh
CREATE INDEX idx_ma_code_lop ON dang_ky_lop(ma_code_giam_gia);
CREATE INDEX idx_ma_code_thi ON dang_ky_thi(ma_code_giam_gia);


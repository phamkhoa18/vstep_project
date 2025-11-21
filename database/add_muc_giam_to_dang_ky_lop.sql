-- Thêm cột muc_giam vào bảng dang_ky_lop
ALTER TABLE dang_ky_lop 
ADD COLUMN muc_giam BIGINT DEFAULT 0 NOT NULL AFTER so_tien_da_tra;


-- Tạo bảng hoa_don để lưu thông tin hóa đơn PDF
CREATE TABLE IF NOT EXISTS hoa_don (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    so_hoa_don VARCHAR(100) NOT NULL UNIQUE,
    nguoi_dung_id BIGINT NOT NULL,
    loai VARCHAR(20) NOT NULL COMMENT 'lop_on hoặc ca_thi',
    dang_ky_id BIGINT NOT NULL COMMENT 'ID của DangKyLop hoặc DangKyThi',
    file_path VARCHAR(500) NOT NULL COMMENT 'Đường dẫn file PDF',
    file_name VARCHAR(255) NOT NULL COMMENT 'Tên file PDF',
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trang_thai VARCHAR(50) DEFAULT 'Đã tạo',
    INDEX idx_nguoi_dung_id (nguoi_dung_id),
    INDEX idx_loai (loai),
    INDEX idx_dang_ky_id (dang_ky_id),
    INDEX idx_so_hoa_don (so_hoa_don),
    FOREIGN KEY (nguoi_dung_id) REFERENCES nguoi_dung(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Bảng cấu hình giảm giá
CREATE TABLE IF NOT EXISTS config_giam_gia (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    loai VARCHAR(50) NOT NULL COMMENT 'lop_on hoặc ca_thi',
    muc_giam_thi_lai BIGINT NOT NULL DEFAULT 500000 COMMENT 'Mức giảm giá cho thí sinh thi lại (VND)',
    mo_ta TEXT,
    trang_thai VARCHAR(20) DEFAULT 'active' COMMENT 'active, inactive',
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_loai (loai)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng mã code giảm giá
CREATE TABLE IF NOT EXISTS ma_giam_gia (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_code VARCHAR(50) NOT NULL UNIQUE,
    loai VARCHAR(50) NOT NULL COMMENT 'lop_on hoặc ca_thi hoặc all',
    loai_giam VARCHAR(20) NOT NULL DEFAULT 'fixed' COMMENT 'fixed (số tiền cố định) hoặc percent (phần trăm)',
    gia_tri_giam BIGINT NOT NULL COMMENT 'Số tiền giảm (nếu fixed) hoặc phần trăm (nếu percent)',
    gia_tri_toi_da BIGINT NULL COMMENT 'Giá trị giảm tối đa (nếu là percent)',
    so_luong_toi_da INT NULL COMMENT 'Số lượng sử dụng tối đa',
    so_luong_da_su_dung INT DEFAULT 0,
    ngay_bat_dau DATE NULL,
    ngay_ket_thuc DATE NULL,
    trang_thai VARCHAR(20) DEFAULT 'active' COMMENT 'active, inactive, expired',
    mo_ta TEXT,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ma_code (ma_code),
    INDEX idx_trang_thai (trang_thai)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bảng lịch sử sử dụng mã code
CREATE TABLE IF NOT EXISTS lich_su_su_dung_ma (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_giam_gia_id BIGINT NOT NULL,
    nguoi_dung_id BIGINT NOT NULL,
    loai_dang_ky VARCHAR(50) NOT NULL COMMENT 'lop_on hoặc ca_thi',
    dang_ky_id BIGINT NOT NULL COMMENT 'ID của đăng ký lớp hoặc ca thi',
    gia_tri_giam BIGINT NOT NULL,
    ngay_su_dung TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_giam_gia_id) REFERENCES ma_giam_gia(id) ON DELETE CASCADE,
    INDEX idx_ma_giam_gia (ma_giam_gia_id),
    INDEX idx_nguoi_dung (nguoi_dung_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert cấu hình mặc định
INSERT INTO config_giam_gia (loai, muc_giam_thi_lai, mo_ta, trang_thai) VALUES
('ca_thi', 500000, 'Mức giảm giá mặc định cho thí sinh thi lại ca thi', 'active'),
('lop_on', 0, 'Mức giảm giá cho học viên đăng ký lại lớp ôn', 'active')
ON DUPLICATE KEY UPDATE muc_giam_thi_lai = VALUES(muc_giam_thi_lai);


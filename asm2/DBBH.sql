﻿CREATE drop DATABASE DB_Ban_Hang
use DB_Ban_Hang 
CREATE TABLE san_pham (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ma_san_pham VARCHAR(255) ,
        ten_san_pham VARCHAR(255) ,
        trang_thai VARCHAR(50), -- or INT, depending on how you represent status
        ngay_tao DATETIME ,
        ngay_sua DATETIME
        );
        CREATE TABLE mau_sac (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ma_mau VARCHAR(255),
        ten_mau VARCHAR(255),
        trang_thai VARCHAR(50), -- or INT, based on your status representation
        ngay_sua DATETIME,
        ngay_tao DATETIME
        );
        CREATE TABLE size (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ma_size VARCHAR(255),
        ten_size VARCHAR(255),
        trang_thai VARCHAR(50), -- or INT, based on your status representation
        ngay_sua DATETIME,
        ngay_tao DATETIME
        );
        CREATE TABLE danh_muc (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ma_danh_muc VARCHAR(255),
        ten_danh_muc VARCHAR(255),
        trang_thai VARCHAR(50), -- Adjust based on how you plan to represent the status
        ngay_tao DATETIME,
        ngay_sua DATETIME
        );

		INSERT INTO danh_muc (ma_danh_muc, ten_danh_muc, trang_thai, ngay_tao, ngay_sua) VALUES
		('DM002', 'Ga cotton', 'Còn hàng', GETDATE(), GETDATE()),
('DM003', 'Ga nilon', 'Hết hàng', GETDATE(), GETDATE()),
select * from danh_muc

        CREATE TABLE khach_hang (
        id INT IDENTITY(1,1) PRIMARY KEY,
        ho_ten NVARCHAR(255),
        dia_chi NVARCHAR(255),
        sdt VARCHAR(20),
        trang_thai VARCHAR(50), -- Adjust based on how you plan to represent the status
        ngay_tao DATETIME,
        ngay_sua DATETIME
        );
        CREATE TABLE ctsp (
        id INT IDENTITY(1,1) PRIMARY KEY,
        id_sp INT NULL,
        id_mau_sac INT NULL,
        id_size INT NULL,
        gia_ban DECIMAL(18, 2),
        so_luong_ton INT,
        trang_thai VARCHAR(50), -- Adjust based on your representation of status
        ngay_tao DATETIME,
        ngay_sua DATETIME,
        CONSTRAINT fk_sp FOREIGN KEY (id_sp) REFERENCES san_pham(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_mau_sac FOREIGN KEY (id_mau_sac) REFERENCES mau_sac(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_size FOREIGN KEY (id_size) REFERENCES size(id) ON UPDATE CASCADE ON DELETE CASCADE,
        );
        CREATE TABLE hoa_don (
        id INT IDENTITY(1,1) PRIMARY KEY,
        id_khach_hang INT NULL,
        trang_thai VARCHAR(50), -- Adjust based on how you represent the status
        ngay_tao DATETIME,
        ngay_sua DATETIME,
        dia_chi NVARCHAR(255),
        so_dien_thoai VARCHAR(20),
        CONSTRAINT fk_khach_hang FOREIGN KEY (id_khach_hang) REFERENCES khach_hang(id) ON UPDATE CASCADE ON DELETE CASCADE,
        );

        CREATE TABLE hdct (
        id INT IDENTITY(1,1) PRIMARY KEY,
        id_hoa_don INT NULL,
        id_ctsp INT NULL,
        so_luong_mua INT,
        gia_ban DECIMAL(18, 2),
        tong_tien DECIMAL(18, 2),
        trang_thai VARCHAR(50), -- Adjust based on how you represent the status
        ngay_tao DATETIME,
        ngay_sua DATETIME,
        CONSTRAINT fk_hoa_don FOREIGN KEY (id_hoa_don) REFERENCES hoa_don(id) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT fk_ctsp FOREIGN KEY (id_ctsp) REFERENCES ctsp(id) ON UPDATE CASCADE ON DELETE CASCADE,
        );
        ALTER TABLE san_pham
        ADD id_danh_muc INT NULL;

        ALTER TABLE san_pham
        ADD CONSTRAINT fk_san_pham_danh_muc
        FOREIGN KEY (id_danh_muc) REFERENCES danh_muc(id) ON UPDATE CASCADE ON DELETE CASCADE;
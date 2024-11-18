package com.example.asm2.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "san_pham")
public class SanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String ma_san_pham;
    private String ten_san_pham;
    private String trang_thai;
    private Date ngay_tao;
    private Date ngay_sua;
    @ManyToOne
    @JoinColumn(name = "id_danh_muc")
    private DanhMuc danhMuc;
}


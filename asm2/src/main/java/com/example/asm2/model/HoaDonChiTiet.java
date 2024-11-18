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
@Table(name = "hdct")
public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "id_hoa_don")
    private HoaDon hoa_don;
    @ManyToOne
    @JoinColumn(name = "id_ctsp")
    private ChiTietSanPham ctsp;
    private Integer so_luong_mua;
    private Integer gia_ban;
    private Integer tong_tien;
    private String trang_thai;
    private Date ngay_tao;
    private Date ngay_sua;

}

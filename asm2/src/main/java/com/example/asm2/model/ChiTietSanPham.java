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
@Table(name = "ctsp")
public class ChiTietSanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "id_sp")
    private SanPham san_pham;
    @ManyToOne
    @JoinColumn(name = "id_mau_sac")
    private MauSac mau_sac;
    @ManyToOne
    @JoinColumn(name = "id_size")
    private Size size;
    private Integer gia_ban;
    private Integer so_luong_ton;
    private String trang_thai;
    private Date ngay_tao;
    private Date ngay_sua;

}

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
@Table(name = "hoa_don")
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang khach_hang;
    private String trang_thai;
    private Date ngay_tao;
    private Date ngay_sua;
    private String dia_chi;
    private String so_dien_thoai;

}

package com.example.asm2.repository;

import com.example.asm2.model.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface KhachHangRepository extends JpaRepository<KhachHang,Integer> {
    Optional<KhachHang> findBySdt(String sdt);
}

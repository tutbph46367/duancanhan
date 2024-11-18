package com.example.asm2.repository;

import com.example.asm2.model.HoaDonChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HoaDonChiTietRepository extends JpaRepository<HoaDonChiTiet,Integer> {
    @Query("SELECT h FROM HoaDonChiTiet h WHERE h.hoa_don.id = :idhd")
    List<HoaDonChiTiet> getL(Integer idhd);
}

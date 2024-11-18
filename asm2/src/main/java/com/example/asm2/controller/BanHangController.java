package com.example.asm2.controller;

import com.example.asm2.model.*;
import com.example.asm2.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/asm2")
public class BanHangController {
    @Autowired
    SanPhamRepository sanPhamRepository;
    @Autowired
    ChiTietSanPhamRepository chiTietSanPhamRepository;
    @Autowired
    HoaDonChiTietRepository hoaDonChiTietRepository;
    @Autowired
    DanhMucRepository danhMucRepository;
    @Autowired
    HoaDonRepository hoaDonRepository;
    @Autowired
    KhachHangRepository khachHangRepository;
    @Autowired
    MauSacRepository mauSacRepository;
    @Autowired
    SizeRepository sizeRepository;

    private double tinhTongTienGioHang(Integer hoaDonId) {
        double tongTien = 0;
        List<HoaDonChiTiet> listHDCT = hoaDonChiTietRepository.getL(hoaDonId);

        for (HoaDonChiTiet h : listHDCT) {
            tongTien += h.getTong_tien();
        }

        return tongTien;
    }


    @GetMapping("/ban-hang")
    public String BanHang(Model model) {
        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHD", hoaDonRepository.getList());

        return "banhang";
    }


    // Khi tạo hóa đơn, lưu vào session
    @GetMapping("/ban-hang/tao-hoa-don")
    public String TaoHoaDon(String soDT, HttpSession session) {
        Optional<KhachHang> khachHang = khachHangRepository.findBySdt(soDT);

        if (khachHang.isPresent()) {
            HoaDon hoaDon = new HoaDon(null, khachHang.get(), "Cho thanh toan", Date.valueOf(LocalDate.now()), Date.valueOf(LocalDate.now()), null, soDT);
            hoaDonRepository.save(hoaDon);

            // Lưu hóa đơn vào session
            session.setAttribute("hoaDon", hoaDon);

            // Khởi tạo tổng tiền là 0 khi mới tạo hóa đơn
            session.setAttribute("tongTien", 0.0);
        } else {
            HoaDon hoaDon = new HoaDon(null, null, "Cho thanh toan", Date.valueOf(LocalDate.now()), Date.valueOf(LocalDate.now()), null, null);
            hoaDonRepository.save(hoaDon);

            // Lưu hóa đơn vào session
            session.setAttribute("hoaDon", hoaDon);

            // Khởi tạo tổng tiền là 0 khi mới tạo hóa đơn
            session.setAttribute("tongTien", 0.0);
        }

        return "redirect:/asm2/ban-hang";
    }


    // Khi xem hóa đơn, lưu vào session
    @GetMapping("/ban-hang/xem-hoa-don/{id}")
    public String XemHoaDon(@PathVariable("id") Integer id, Model model, HttpSession session) {
        Optional<HoaDon> optionalHoaDon = hoaDonRepository.findById(id);

        if (optionalHoaDon.isPresent()) {
            HoaDon hoaDon = optionalHoaDon.get();
            model.addAttribute("hoaDon", hoaDon);

            // Lưu hóa đơn vào session
            session.setAttribute("hoaDon", hoaDon);

            // Tính tổng tiền và lưu vào session
            double tongTien = tinhTongTienGioHang(hoaDon.getId());
            session.setAttribute("tongTien", tongTien);
        } else {
            model.addAttribute("hoaDon", new HoaDon());
            session.setAttribute("tongTien", 0.0);
        }

        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(id));
        model.addAttribute("listHD", hoaDonRepository.getList());

        return "banhang";
    }

    @PostMapping("/ban-hang/them-vao-gio/{id}")
    public String ThemVaoGio(@PathVariable("id") Integer id,
                             @RequestParam("so_luong_mua") Integer soLuongMua,
                             HttpSession session, Model model) {
        Optional<ChiTietSanPham> optionalCTSP = chiTietSanPhamRepository.findById(id);
        if (optionalCTSP.isPresent()) {
            ChiTietSanPham chiTietSanPham = optionalCTSP.get();

            // Lấy hóa đơn từ session
            HoaDon hoaDon = (HoaDon) session.getAttribute("hoaDon");

            // Kiểm tra nếu hóa đơn tồn tại và số lượng tồn đủ đáp ứng yêu cầu mua
            if (hoaDon != null && chiTietSanPham.getSo_luong_ton() >= soLuongMua) {
                // Cập nhật số lượng tồn
                chiTietSanPham.setSo_luong_ton(chiTietSanPham.getSo_luong_ton() - soLuongMua);
                chiTietSanPhamRepository.save(chiTietSanPham);

                boolean existsInCart = false;

                // Tìm kiếm sản phẩm trong giỏ hàng
                for (HoaDonChiTiet h : hoaDonChiTietRepository.findAll()) {
                    if (h.getCtsp().getId().equals(chiTietSanPham.getId()) && h.getHoa_don().getId().equals(hoaDon.getId())) {
                        h.setSo_luong_mua(h.getSo_luong_mua() + soLuongMua);
                        h.setTong_tien(h.getSo_luong_mua() * h.getGia_ban());
                        hoaDonChiTietRepository.save(h);
                        existsInCart = true;
                        break;
                    }
                }

                // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới vào giỏ
                if (!existsInCart) {
                    HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet(null, hoaDon, chiTietSanPham, soLuongMua, chiTietSanPham.getGia_ban(), soLuongMua * chiTietSanPham.getGia_ban(), null, Date.valueOf(LocalDate.now()), Date.valueOf(LocalDate.now()));
                    hoaDonChiTietRepository.save(hoaDonChiTiet);
                }

                // Cập nhật tổng tiền giỏ hàng
                double tongTien = tinhTongTienGioHang(hoaDon.getId());
                session.setAttribute("tongTien", tongTien);
                session.setAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));
            }
        }

        return "redirect:/asm2/ban-hang";
    }

    @GetMapping("/ban-hang/xoa-san-pham/{id}")
    public String XoaSanPhamGioHang(@PathVariable("id") Integer id, HttpSession session) {
        Optional<HoaDonChiTiet> optionalHDCT = hoaDonChiTietRepository.findById(id);

        if (optionalHDCT.isPresent()) {
            HoaDonChiTiet hoaDonChiTiet = optionalHDCT.get();
            ChiTietSanPham chiTietSanPham = hoaDonChiTiet.getCtsp();

            // Cộng lại số lượng mua vào số lượng tồn của sản phẩm
            chiTietSanPham.setSo_luong_ton(chiTietSanPham.getSo_luong_ton() + hoaDonChiTiet.getSo_luong_mua());
            chiTietSanPhamRepository.save(chiTietSanPham);

            // Xóa sản phẩm khỏi giỏ hàng
            hoaDonChiTietRepository.delete(hoaDonChiTiet);

            // Lấy hóa đơn từ session
            HoaDon hoaDon = (HoaDon) session.getAttribute("hoaDon");

            // Cập nhật tổng tiền giỏ hàng
            double tongTien = tinhTongTienGioHang(hoaDon.getId());
            session.setAttribute("tongTien", tongTien);

            // Cập nhật lại danh sách sản phẩm trong giỏ hàng
            session.setAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));
        }

        return "redirect:/asm2/ban-hang";
    }


    @GetMapping("/ban-hang/tim-khach-hang")
    public String TimKhachHang(@RequestParam("soDT") String soDT, Model model, HttpSession session) {
        Optional<KhachHang> khachHang = khachHangRepository.findBySdt(soDT);
        HoaDon hoaDon = (HoaDon) new HoaDon();

        if (khachHang.isPresent()) {
            // If customer is found, update the session with the customer's information

            hoaDon.setKhach_hang(khachHang.get());
            session.setAttribute("hoaDon", hoaDon);
        } else {
            // If not found, set a message to indicate no customer found
            session.setAttribute("hoaDon", new HoaDon());
            model.addAttribute("message", "Không tìm thấy khách hàng với số điện thoại này.");
        }

        // Update the model with necessary attributes to display
        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));
        model.addAttribute("listHD", hoaDonRepository.getList());

        return "banhang";
    }

    @PostMapping("/ban-hang/thanh-toan")
    public String ThanhToan(@RequestParam("id") Integer hoaDonId, HttpSession session, Model model) {

        Optional<HoaDon> optionalHoaDon = hoaDonRepository.findById(hoaDonId);

        if (optionalHoaDon.isPresent()) {
            HoaDon hoaDon = optionalHoaDon.get();

            // Kiểm tra nếu hóa đơn không có hoặc tổng tiền bằng 0 thì không cho thanh toán
            Double tongTien = (Double) session.getAttribute("tongTien");
            if (hoaDon.getId() == null || tongTien == null || tongTien == 0) {
                model.addAttribute("message", "Không thể thanh toán vì hóa đơn hoặc tổng tiền không hợp lệ.");
                return "redirect:/asm2/ban-hang";
            }

            // Cập nhật trạng thái hóa đơn thành "Đã thanh toán"
            hoaDon.setTrang_thai("Da thanh toan");

            // Cập nhật ngày sửa thành ngày hiện tại
            hoaDon.setNgay_sua(Date.valueOf(LocalDate.now()));

            // Lưu hóa đơn đã cập nhật
            hoaDonRepository.save(hoaDon);

            // Xóa hóa đơn và giỏ hàng khỏi session
            session.removeAttribute("hoaDon");
            session.removeAttribute("tongTien");
            session.removeAttribute("listHDCT");

            model.addAttribute("message", "Thanh toán thành công!");
        } else {
            model.addAttribute("message", "Không tìm thấy hóa đơn.");
        }

        return "redirect:/asm2/ban-hang"; // Chuyển hướng về trang bán hàng
    }

    @GetMapping("/danh-muc")
    public String DanhMuc(Model model) {
        model.addAttribute("listDM", danhMucRepository.findAll());
        return "themdanhmuc";
    }
    @PostMapping("/them-danh-muc")
    public String saveDanhMuc(@ModelAttribute DanhMuc danhMuc ,RedirectAttributes redirectAttributes) {
        danhMuc.setNgay_sua(Date.valueOf(LocalDate.now()));
        danhMuc.setNgay_tao(Date.valueOf(LocalDate.now()));
        danhMucRepository.save(danhMuc);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công thành công");
        return "redirect:/asm2/danh-muc";
    }
    @PostMapping("/upadate/{id}")
    public String update( @PathVariable("id")Integer id,DanhMuc dm) {
        dm.setNgay_sua(Date.valueOf(LocalDate.now()));
        dm.setNgay_tao(Date.valueOf(LocalDate.now()));
        danhMucRepository.save(dm);
        return "redirect:/asm2/danh-muc";
    }
    @GetMapping("/danh-muc/delete/{id}")
    public String delete(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        danhMucRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa công thành công");
        return "redirect:/asm2/danh-muc";
    }
    @GetMapping("/danh-muc/detail/{id}")
    public String editDanhMuc(@PathVariable Integer id, Model model) {
        DanhMuc danhMuc = danhMucRepository.findById(id).orElse(new DanhMuc());
        model.addAttribute("danhMuc", danhMuc);
        model.addAttribute("listDM", danhMucRepository.findAll());
        return "themdanhmuc";
    }


    @GetMapping("/khach-hang")
    public String KhachHang(Model model) {
        model.addAttribute("listKH",khachHangRepository.findAll());
        return "themkhachhang";
    }
    @PostMapping("/them-khach-hang")
    public String saveKhachHang(@ModelAttribute KhachHang khachHang ,RedirectAttributes redirectAttributes) {
        khachHang.setNgay_sua(Date.valueOf(LocalDate.now()));
        khachHang.setNgay_tao(Date.valueOf(LocalDate.now()));
        khachHangRepository.save(khachHang);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công");
        return "redirect:/asm2/khach-hang";
    }
    @PostMapping("/update-kh/{id}")
    public String updatekh( @PathVariable("id")Integer id,KhachHang kh,RedirectAttributes redirectAttributes) {
        kh.setNgay_sua(Date.valueOf(LocalDate.now()));
        kh.setNgay_tao(Date.valueOf(LocalDate.now()));
        khachHangRepository.save(kh);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công");

        return "redirect:/asm2/khach-hang";
    }
    @GetMapping("/khach-hang/delete/{id}")
    public String deletekh(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        khachHangRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công");
        return "redirect:/asm2/khach-hang";
    }
    @GetMapping("/khach-hang/detail/{id}")
    public String editKhachHang(@PathVariable Integer id, Model model) {
        KhachHang khachHang = khachHangRepository.findById(id).orElse(new KhachHang());
        model.addAttribute("khachHang", khachHang);
        model.addAttribute("listKH", khachHangRepository.findAll());
        return "themkhachhang";
    }



    @GetMapping("/mau-sac")
    public String MauSac(Model model) {
        model.addAttribute("listMS",mauSacRepository.findAll());
        return "themmausac";
    }
    @PostMapping("/them-mau-sac")
    public String saveMauSac(@ModelAttribute MauSac mauSac ,RedirectAttributes redirectAttributes) {
        mauSac.setNgay_sua(Date.valueOf(LocalDate.now()));
        mauSac.setNgay_tao(Date.valueOf(LocalDate.now()));
        mauSacRepository.save(mauSac);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công");
        return "redirect:/asm2/mau-sac";
    }
    @PostMapping("/update-ms/{id}")
    public String updatems( @PathVariable("id")Integer id,MauSac ms,RedirectAttributes redirectAttributes) {
        ms.setNgay_sua(Date.valueOf(LocalDate.now()));
        ms.setNgay_tao(Date.valueOf(LocalDate.now()));
        mauSacRepository.save(ms);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công");

        return "redirect:/asm2/mau-sac";
    }
    @GetMapping("/mau-sac/delete/{id}")
    public String deletems(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        mauSacRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công");
        return "redirect:/asm2/mau-sac";
    }
    @GetMapping("/mau-sac/detail/{id}")
    public String editMauSac(@PathVariable Integer id, Model model) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(new MauSac());
        model.addAttribute("mauSac", mauSac);
        model.addAttribute("listMS", mauSacRepository.findAll());
        return "themmausac";
    }

    @GetMapping("/san-pham")
    public String SanPham(Model model) {
        model.addAttribute("listSP",sanPhamRepository.findAll());
        model.addAttribute("listDM",danhMucRepository.findAll());
        return "themsanpham";
    }
    @PostMapping("/them-san-pham")
    public String saveSP(@ModelAttribute SanPham sanPham ,RedirectAttributes redirectAttributes) {
        sanPham.setNgay_sua(Date.valueOf(LocalDate.now()));
        sanPham.setNgay_tao(Date.valueOf(LocalDate.now()));
        sanPhamRepository.save(sanPham);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công");
        return "redirect:/asm2/san-pham";
    }
    @PostMapping("/update-san-pham/{id}")
    public String updateSP( @PathVariable("id")Integer id,SanPham sanPham,RedirectAttributes redirectAttributes) {
        sanPham.setNgay_sua(Date.valueOf(LocalDate.now()));
        sanPham.setNgay_tao(Date.valueOf(LocalDate.now()));
        sanPhamRepository.save(sanPham);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công");
        return "redirect:/asm2/san-pham";
    }
    @GetMapping("/san-pham/delete/{id}")
    public String deleteSP(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        sanPhamRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công");
        return "redirect:/asm2/san-pham";
    }
    @GetMapping("/san-pham/detail/{id}")
    public String editSP(@PathVariable Integer id, Model model) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(new SanPham());
        model.addAttribute("sanPham", sanPham);
        model.addAttribute("listSP", sanPhamRepository.findAll());
        model.addAttribute("listDM",danhMucRepository.findAll());
        return "themsanpham";
    }


    @GetMapping("/spct")
    public String hienthiSPCT(Model model) {
        model.addAttribute("listSPCT",chiTietSanPhamRepository.findAll());
        model.addAttribute("listSP",sanPhamRepository.findAll());
        model.addAttribute("listMS",mauSacRepository.findAll());
        model.addAttribute("listSize",sizeRepository.findAll());
        return "themspct";
    }
    @PostMapping("/them-spct")
    public String addSPCT(ChiTietSanPham chiTietSanPham) {
        chiTietSanPham.setNgay_tao(Date.valueOf(LocalDate.now()));
        chiTietSanPham.setNgay_sua(Date.valueOf(LocalDate.now()));
        chiTietSanPhamRepository.save(chiTietSanPham);
        return "redirect:/asm2/spct";
    }
    @PostMapping("/update-spct/{id}")
    public String updateSpct( @PathVariable("id")Integer id,ChiTietSanPham spct,RedirectAttributes redirectAttributes) {
        spct.setNgay_sua(Date.valueOf(LocalDate.now()));
        spct.setNgay_tao(Date.valueOf(LocalDate.now()));
        chiTietSanPhamRepository.save(spct);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công");
        return "redirect:/asm2/spct";
    }
    @GetMapping("/spct/delete/{id}")
    public String deleteSpct(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        chiTietSanPhamRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công");
        return "redirect:/asm2/spct";
    }
    @GetMapping("/spct/detail/{id}")
    public String editSpct(@PathVariable Integer id, Model model) {
        ChiTietSanPham spct = chiTietSanPhamRepository.findById(id).orElse(new ChiTietSanPham());
        model.addAttribute("spct", spct);
        model.addAttribute("listSPCT", chiTietSanPhamRepository.findAll());
        model.addAttribute("listSP",sanPhamRepository.findAll());
        model.addAttribute("listMS",mauSacRepository.findAll());
        model.addAttribute("listSize",sizeRepository.findAll());
        return "themspct";
    }

    @GetMapping("/size")
    public String Size(Model model) {
        model.addAttribute("listSize",sizeRepository.findAll());
        return "themsize";
    }
    @PostMapping("/them-size")
    public String saveSize(@ModelAttribute Size size ,RedirectAttributes redirectAttributes) {
        size.setNgay_sua(Date.valueOf(LocalDate.now()));
        size.setNgay_tao(Date.valueOf(LocalDate.now()));
        sizeRepository.save(size);
        redirectAttributes.addFlashAttribute("message", "Thêm thành công");
        return "redirect:/asm2/size";
    }
    @PostMapping("/update-size/{id}")
    public String updatesize( @PathVariable("id")Integer id,Size size,RedirectAttributes redirectAttributes) {
        size.setNgay_sua(Date.valueOf(LocalDate.now()));
        size.setNgay_tao(Date.valueOf(LocalDate.now()));
        sizeRepository.save(size);
        redirectAttributes.addFlashAttribute("message", "Sửa thành công");
        return "redirect:/asm2/size";
    }
    @GetMapping("/size/delete/{id}")
    public String deletesize(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        sizeRepository.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa thành công");
        return "redirect:/asm2/size";
    }
    @GetMapping("/size/detail/{id}")
    public String editSize(@PathVariable Integer id, Model model) {
        Size size = sizeRepository.findById(id).orElse(new Size());
        model.addAttribute("size", size);
        model.addAttribute("listSize", sizeRepository.findAll());
        return "themsize";
    }

}

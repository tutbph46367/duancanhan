<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bán hàng</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f0f0f0;
        }

        .container {
            margin-top: 20px;
        }

        .scrollable-table {
            max-height: 250px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            text-align: center;
        }

        .table-section {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<!-- Include menu -->
<jsp:include page="menu.jsp"/>

<div class="container">
    <h1 class="text-center mb-4">Bán hàng</h1>

    <div class="row">
        <!-- Sản phẩm và Giỏ hàng -->
        <div class="col-md-8">
            <div class="table-section">
                <!-- Bảng sản phẩm -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Sản phẩm</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-primary">
                            <tr>
                                <th>STT</th>
                                <th>Mã SP</th>
                                <th>Tên SP</th>
                                <th>Màu Sắc</th>
                                <th>Size</th>
                                <th>Giá SP</th>
                                <th>Số lượng</th>
                                <th>Chọn</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listCTSP}" var="lctsp" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${lctsp.san_pham.ma_san_pham}</td>
                                    <td>${lctsp.san_pham.ten_san_pham}</td>
                                    <td>${lctsp.mau_sac.ten_mau}</td>
                                    <td>${lctsp.size.ten_size}</td>
                                    <td>${lctsp.gia_ban}</td>
                                    <td>${lctsp.so_luong_ton}</td>
                                    <td>
                                        <c:if test="${not empty sessionScope.hoaDon}">
                                            <!-- Form để nhập số lượng và thêm sản phẩm vào giỏ -->
                                            <form action="/asm2/ban-hang/them-vao-gio/${lctsp.id}?idhd=${sessionScope.hoaDon.id}" method="POST" class="form-inline">
                                                <input type="number" name="so_luong_mua" min="1" max="${lctsp.so_luong_ton}" value="1" class="form-control form-control-sm d-inline-block" style="width: 60px;" required>
                                                <button type="submit" class="btn btn-success btn-sm">Chọn</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${empty sessionScope.hoaDon}">
                                            <button class="btn btn-secondary btn-sm" disabled>Chọn</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
                    </div>
                </div>
            </div>

            <div class="table-section">
                <!-- Bảng giỏ hàng -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Giỏ hàng</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-warning">
                            <tr>
                                <th>STT</th>
                                <th>Mã SP</th>
                                <th>Tên SP</th>
                                <th>Giá SP</th>
                                <th>Số lượng mua</th>
                                <th>Tổng tiền</th>
                                <th>Xóa</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listHDCT}" var="lhdct" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${lhdct.ctsp.san_pham.ma_san_pham}</td>
                                    <td>${lhdct.ctsp.san_pham.ten_san_pham}</td>
                                    <td>${lhdct.gia_ban}</td>
                                    <td>${lhdct.so_luong_mua}</td>
                                    <td>${lhdct.tong_tien}</td>
                                    <td>
                                        <a href="/asm2/ban-hang/xoa-san-pham/${lhdct.id}"
                                           class="btn btn-danger btn-sm">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hóa đơn và Thanh toán -->
        <div class="col-md-4">
            <div class="table-section">
                <!-- Bảng hóa đơn -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Hóa đơn</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-info">
                            <tr>
                                <th>STT</th>
                                <th>Mã HD</th>
                                <th>Tên khách</th>
                                <th>Ngày tạo</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listHD}" var="lhd" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${lhd.id}</td>
                                    <td>${lhd.khach_hang.ho_ten}</td>
                                    <td>${lhd.ngay_tao}</td>
                                    <td>${lhd.trang_thai}</td>
                                    <td>
                                        <a href="/asm2/ban-hang/xem-hoa-don/${lhd.id}"
                                           class="btn btn-primary btn-sm">Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                        <a href="/asm2/ban-hang/tao-hoa-don?soDT=${sessionScope.hoaDon.khach_hang.sdt}" class="btn btn-primary mt-3">Tạo hóa đơn mới</a>

                </div>
            </div>

            <!-- Thông tin thanh toán -->
            <div class="card">
                <div class="card-header">
                    <h2 class="h4">Thanh toán</h2>
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger">${message}</div>
                    </c:if>
                    <!-- Tìm kiếm khách hàng -->
                    <form action="/asm2/ban-hang/tim-khach-hang" method="GET" class="mb-3">
                        <div class="mb-3">
                            <label for="soDT" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="soDT" name="soDT" value="${sessionScope.hoaDon.khach_hang.sdt}">
                        </div>
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>

                    <!-- Form thanh toán -->
                    <form action="/asm2/ban-hang/thanh-toan" method="POST">
                        <div class="mb-3">
                            <label for="tenKH" class="form-label">Tên khách hàng</label>
                            <input type="text" class="form-control" id="tenKH" name="tenKH"
                                   value="${sessionScope.hoaDon.khach_hang.ho_ten}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="maHD" class="form-label">Mã Hóa Đơn</label>
                            <input type="text" class="form-control" id="maHD" name="id"
                                   value="${sessionScope.hoaDon.id}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="ngayTao" class="form-label">Ngày Tạo</label>
                            <input type="text" class="form-control" id="ngayTao" name="ngay_tao"
                                   value="${sessionScope.hoaDon.ngay_tao}" readonly>
                        </div>

                        <div class="mb-3">
                            <label for="tongTien" class="form-label">Tổng Tiền</label>
                            <input type="text" class="form-control" id="tongTien" name="tong_tien"
                                   value="${sessionScope.tongTien}" readonly>
                        </div>
                        <button type="submit" class="btn btn-success"
                        ${empty sessionScope.hoaDon.id or sessionScope.tongTien == 0 ? 'disabled' : ''}>
                            Thanh toán
                        </button>


                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

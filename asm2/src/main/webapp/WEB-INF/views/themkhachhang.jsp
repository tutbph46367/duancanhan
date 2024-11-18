<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Khách Hàng</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp" />

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>Thêm Khách Hàng</h2>
        </div>
        <div class="card-body">
            <form action="/asm2/them-khach-hang" method="post">
                <div class="form-group">
                    <label for="ho_ten">Họ Tên Khách Hàng:</label>
                    <input type="text" class="form-control" id="ho_ten" name="ho_ten" placeholder="Nhập họ tên khách hàng" required value="${khachHang.ho_ten}">
                </div>
                <div class="form-group">
                    <label for="dia_chi">Địa Chỉ:</label>
                    <input type="text" class="form-control" id="dia_chi" name="dia_chi" placeholder="Nhập địa chỉ khách hàng" required value="${khachHang.dia_chi}">
                </div>
                <div class="form-group">
                    <label for="sdt">Số Điện Thoại:</label>
                    <input type="text" class="form-control" id="sdt" name="sdt" placeholder="Nhập sđt khách hàng" required value="${khachHang.sdt}">
                </div>

                <div class="form-group">
                    <label for="trang_thai">Trạng Thái:</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="active" name="trang_thai" value="Active" ${khachHang.trang_thai == 'Active' ? 'checked' : ''} checked>
                            <label class="form-check-label" for="active">Active</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="inactive" name="trang_thai" value="Inactive" ${khachHang.trang_thai == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="inactive">Inactive</label>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button formaction="/asm2/them-khach-hang" type="submit" class="btn btn-success">Thêm</button>
                    <button formaction="/asm2/update-kh/${khachHang.id}" type="submit" class="btn btn-success">Sửa</button>
                </div>
            </form>
        </div>
    </div>
    <h4>${message}</h4>


    <div class="mt-5">
        <h3>Danh Sách Khách Hàng</h3>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>STT</th>
                <th>ID</th>
                <th>Họ Tên</th>
                <th>Địa Chỉ</th>
                <th>SĐT</th>
                <th>Trạng Thái</th>
                <th>Ngày Tạo</th>
                <th>Ngày Sửa</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listKH}" var="khachHang" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${khachHang.id}</td>
                    <td>${khachHang.ho_ten}</td>
                    <td>${khachHang.dia_chi}</td>
                    <td>${khachHang.sdt}</td>
                    <td>${khachHang.trang_thai}</td>
                    <td>${khachHang.ngay_tao}</td>
                    <td>${khachHang.ngay_sua}</td>
                    <td>
                        <a href="/asm2/khach-hang/delete/${khachHang.id}" class="btn btn-warning">Delete</button>
                        </a>
                        <a href="/asm2/khach-hang/detail/${khachHang.id}" class="btn btn-danger">Detail</button>
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
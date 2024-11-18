<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Hóa Đơn</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp" />

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>Thêm Hóa Đơn</h2>
        </div>
        <div class="card-body">
            <form action="/asm2/them-san-pham" method="post">
                <div class="form-group">
                    <label for="ma_san_pham">Mã Hóa Đơn:</label>
                    <input type="text" class="form-control" id="ma_san_pham" name="ma_san_pham" placeholder="Nhập mã sản phẩm" required value="${sanPham.ma_san_pham}">
                </div>

                <div class="form-group">
                    <label for="ten_san_pham">Tên Sản Phẩm:</label>
                    <input type="text" class="form-control" id="ten_san_pham" name="ten_san_pham" placeholder="Nhập tên sản phẩm" required value="${sanPham.ten_san_pham}">
                </div>

                <div class="form-group">
                    <label for="trang_thai">Trạng Thái:</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="active" name="trang_thai" value="Active" ${sanPham.trang_thai == 'Active' ? 'checked' : ''} checked>
                            <label class="form-check-label" for="active">Active</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="inactive" name="trang_thai" value="Inactive" ${sanPham.trang_thai == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="inactive">Inactive</label>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button formaction="/asm2/them-san-pham" type="submit" class="btn btn-success">Thêm</button>
                    <button formaction="/asm2/update-san-pham/${sanPham.id}" type="submit" class="btn btn-success">Sửa</button>
                </div>
            </form>
        </div>
    </div>
    <h3>${message}</h3>

    <div class="mt-5">
        <h3>Danh Sách Sản Phẩm</h3>
        <table class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>STT</th>
                <th>ID</th>
                <th>Mã</th>
                <th>Tên</th>
                <th>Trạng Thái</th>
                <th>Ngày Tạo</th>
                <th>Ngày Sửa</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listSP}" var="sanP" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${sanP.id}</td>
                    <td>${sanP.ma_san_pham}</td>
                    <td>${sanP.ten_san_pham}</td>
                    <td>${sanP.trang_thai}</td>
                    <td>${sanP.ngay_tao}</td>
                    <td>${sanP.ngay_sua}</td>
                    <td>
                    <td>
                        <a href="/asm2/san-pham/delete/${sanP.id}" class="btn btn-warning">Delete</a>
                        <a href="/asm2/san-pham/detail/${sanP.id}" class="btn btn-danger">Detail</a>
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
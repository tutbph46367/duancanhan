<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Sản Phẩm</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp"/>

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>Thêm Sản Phẩm Chi Tiết</h2>
        </div>
        <div class="card-body">
            <form action="/asm2/spct/add" method="post">
                <div class="form-group">
                    <label for="ten_san_pham">Tên sản phẩm: </label>
                    <select name="san_pham" id="san_pham" class="form-control">
                        <c:forEach items="${listSP}" var="SP">
                            <option value="${SP.id}" ${spct.san_pham.id == SP.id ? "selected" : ""}>${SP.ten_san_pham}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="ten_mau">Màu sắc: </label>
                    <select name="mau_sac" id="mau_sac" class="form-control">
                        <c:forEach items="${listMS}" var="MS">
                            <option value="${MS.id}" ${spct.mau_sac.id == MS.id ? "selected" : ""}>${MS.ten_mau}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="ten_size">Size: </label>
                    <select name="size" id="size" class="form-control">
                        <c:forEach items="${listSize}" var="listSize">
                            <option value="${listSize.id}" ${spct.size.id == listSize.id ? "selected" : ""}>${listSize.ten_size}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="gia_ban">Giá bán: </label>
                    <input type="number" class="form-control" id="gia_ban" name="gia_ban" placeholder="Nhập giá bán"
                           required value="${spct.gia_ban}" min="1">
                </div>

                <div class="form-group">
                    <label for="so_luong_ton">Số lượng tồn: </label>
                    <input type="number" class="form-control" id="so_luong_ton" name="so_luong_ton"
                           placeholder="Nhập số lượng" required value="${spct.so_luong_ton}">
                </div>

                <div class="form-group">
                    <label for="trang_thai">Trạng Thái: </label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="active" name="trang_thai"
                                   value="Active" ${sanPham.trang_thai == 'Active' ? 'checked' : ''} checked>
                            <label class="form-check-label" for="active">Active</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="inactive" name="trang_thai"
                                   value="Inactive" ${sanPham.trang_thai == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="inactive">Inactive</label>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button formaction="/asm2/them-spct" type="submit" class="btn btn-success">Thêm</button>
                    <button formaction="/asm2/update-spct/${spct.id}" type="submit" class="btn btn-success">Sửa</button>
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
                <th>Tên sản phẩm</th>
                <th>Màu sắc</th>
                <th>Size</th>
                <th>Giá bán</th>
                <th>Số lượng tồn</th>
                <th>Trạng Thái</th>
                <th>Ngày Tạo</th>
                <th>Ngày Sửa</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listSPCT}" var="spct" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${spct.id}</td>
                    <td>${spct.san_pham.ten_san_pham}</td>
                    <td>${spct.mau_sac.ten_mau}</td>
                    <td>${spct.size.ten_size}</td>
                    <td>${spct.gia_ban}</td>
                    <td>${spct.so_luong_ton}</td>
                    <td>${spct.trang_thai}</td>
                    <td>${spct.ngay_tao}</td>
                    <td>${spct.ngay_sua}</td>
                    <td>
                        <a href="/asm2/spct/delete/${spct.id}" class="btn btn-warning">Delete</button>
                        </a>
                        <a href="/asm2/spct/detail/${spct.id}" class="btn btn-danger">Detail</button>
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
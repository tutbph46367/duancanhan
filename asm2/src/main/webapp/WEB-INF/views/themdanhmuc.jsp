<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Danh Mục</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp" />

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>Thêm Danh Mục</h2>
        </div>
        <div class="card-body">
            <form  method="post">
                <div class="form-group">
                    <label for="ma_danh_muc">Mã Danh Mục:</label>
                    <input type="text" class="form-control" id="ma_danh_muc" name="ma_danh_muc" placeholder="Nhập mã danh mục" required value="${danhMuc.ma_danh_muc}">
                </div>

                <div class="form-group">
                    <label for="ten_danh_muc">Tên Danh Mục:</label>
                    <input type="text" class="form-control" id="ten_danh_muc" name="ten_danh_muc" placeholder="Nhập tên danh mục" required value="${danhMuc.ten_danh_muc}">
                </div>

                <div class="form-group">
                    <label for="trang_thai">Trạng Thái:</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="active" name="trang_thai" value="Active" ${danhMuc.trang_thai == 'Active' ? 'checked' : ''} checked>
                            <label class="form-check-label" for="active">Active</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="inactive" name="trang_thai" value="Inactive" ${danhMuc.trang_thai == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="inactive">Inactive</label>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button formaction="/asm2/them-danh-muc" type="submit" class="btn btn-success">Thêm</button>
                    <button formaction="/asm2/upadate/${danhMuc.id}" type="submit" class="btn btn-success">Sửa</button>

                </div>
            </form>
        </div>
    </div>
    <h3>${message}</h3>


    <div class="mt-5">
        <h3>Danh Sách Danh Mục</h3>
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
            <c:forEach items="${listDM}" var="dmuc" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${dmuc.id}</td>
                    <td>${dmuc.ma_danh_muc}</td>
                    <td>${dmuc.ten_danh_muc}</td>
                    <td>${dmuc.trang_thai}</td>
                    <td>${dmuc.ngay_tao}</td>
                    <td>${dmuc.ngay_sua}</td>
                    <td>
                        <a href="/asm2/danh-muc/delete/${dmuc.id}" class="btn btn-warning">Delete</a>
                        <a href="/asm2/danh-muc/detail/${dmuc.id}" class="btn btn-danger">Detail</a>


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

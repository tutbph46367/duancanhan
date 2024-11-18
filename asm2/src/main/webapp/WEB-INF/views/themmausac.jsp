<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Màu Sắc</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp" />

<div class="container mt-5">
    <div class="card">
        <div class="card-header text-center">
            <h2>Thêm Màu Sắc</h2>
        </div>
        <div class="card-body">
            <form action="/asm2/them-mau-sac" method="post">
                <div class="form-group">
                    <label for="ma_mau">Mã Màu Sắc:</label>
                    <input type="text" class="form-control" id="ma_mau" name="ma_mau" placeholder="Nhập mã màu sắc" required value="${mauSac.ma_mau}">
                </div>

                <div class="form-group">
                    <label for="ten_mau">Tên Màu Sắc:</label>
                    <input type="text" class="form-control" id="ten_mau" name="ten_mau" placeholder="Nhập tên màu sắc" required value="${mauSac.ten_mau}">
                </div>

                <div class="form-group">
                    <label for="trang_thai">Trạng Thái:</label>
                    <div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="active" name="trang_thai" value="Active" ${mauSac.trang_thai == 'Active' ? 'checked' : ''} checked>
                            <label class="form-check-label" for="active">Active</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="inactive" name="trang_thai" value="Inactive" ${mauSac.trang_thai == 'Inactive' ? 'checked' : ''}>
                            <label class="form-check-label" for="inactive">Inactive</label>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <button formaction="/asm2/them-mau-sac" type="submit" class="btn btn-success">Thêm</button>
                    <button formaction="/asm2/update-ms/${mauSac.id}" type="submit" class="btn btn-success">Sửa</button>
                </div>
            </form>
        </div>
    </div>
    <h3>${message}</h3>


    <div class="mt-5">
        <h3>Danh Sách Màu Sắc</h3>
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
            <c:forEach items="${listMS}" var="mauSac" varStatus="s">
                <tr>
                    <td>${s.count}</td>
                    <td>${mauSac.id}</td>
                    <td>${mauSac.ma_mau}</td>
                    <td>${mauSac.ten_mau}</td>
                    <td>${mauSac.trang_thai}</td>
                    <td>${mauSac.ngay_tao}</td>
                    <td>${mauSac.ngay_sua}</td>
                    <td>
                        <a href="/asm2/mau-sac/delete/${mauSac.id}" class="btn btn-warning">Delete</button>
                        </a>
                        <a href="/asm2/mau-sac/detail/${mauSac.id}" class="btn btn-danger">Detail</button>
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
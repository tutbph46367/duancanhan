<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    body {
        font-family: Arial, sans-serif;
    }

    .navbar {
        background-color: #3b76d4;
        overflow: hidden;
    }

    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
        font-size: 17px;
    }

    .navbar a:hover {
        background-color: #cf7e7e;
        color: #ecbd10;
    }

    .navbar a.active {
        background-color: #04AA6D;
        color: white;
    }
</style>

<div class="navbar">
    <div><img src="https://hanvico.com.vn/wp-content/uploads/2019/05/logo-vi-tiny.png" alt="Bootstrap" width="95" height="90"
                                 style=" margin-left: 40px;"></div>
    <a href="/asm2/ban-hang" class="active btn btn-danger" type="button">Bán hàng</a>
    <a href="/asm2/danh-muc" class="btn btn-dark">Thêm danh mục</a>
    <a href="/asm2/khach-hang" class="btn btn-dark">Thêm khách hàng</a>
    <a href="/asm2/mau-sac" class="btn btn-dark">Thêm màu sắc</a>
    <a href="/asm2/san-pham" class="btn btn-dark">Thêm sản phẩm</a>
    <a href="/asm2/spct" class="btn btn-dark">Chi tiết sản phẩm</a>
    <a href="/asm2/size" class="btn btn-dark">Thêm kích thước</a>
</div>


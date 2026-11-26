<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h3 class="text-center fw-bold text-primary mb-4">Đăng ký tài khoản</h3>

                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger">${alert}</div>
                    </c:if>

                    <form action="<c:url value='/register'/>" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập *</label>
                            <input type="text" name="username" class="form-control" value="${username}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Email *</label>
                            <input type="email" name="email" class="form-control" value="${email}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="${fullname}">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${phone}">
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Mật khẩu *</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-semibold">Xác nhận mật khẩu *</label>
                                <input type="password" name="confirmPassword" class="form-control" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-semibold">Đăng ký</button>
                    </form>

                    <hr class="my-4">
                    <div class="text-center small">
                        Đã có tài khoản? <a href="<c:url value='/login'/>">Đăng nhập</a>
                        <span class="mx-2">|</span>
                        <a href="<c:url value='/home'/>">Về trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

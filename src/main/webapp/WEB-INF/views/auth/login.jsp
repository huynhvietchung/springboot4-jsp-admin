<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center min-vh-100">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h3 class="text-center fw-bold text-primary mb-4">Đăng nhập hệ thống</h3>

                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success">${successMessage}</div>
                    </c:if>
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger">${alert}</div>
                    </c:if>

                    <form action="<c:url value='/login'/>" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                            <input type="text" name="username" class="form-control"
                                   value="${not empty username ? username : rememberedUsername}"
                                   placeholder="Nhập username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mật khẩu</label>
                            <input type="password" name="password" class="form-control"
                                   placeholder="Nhập mật khẩu" required>
                        </div>
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="remember" name="remember"
                                   ${not empty rememberedUsername ? 'checked' : ''}>
                            <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-semibold">Đăng nhập</button>
                    </form>

                    <hr class="my-4">
                    <div class="text-center small">
                        Chưa có tài khoản? <a href="<c:url value='/register'/>">Đăng ký ngay</a>
                        <span class="mx-2">|</span>
                        <a href="<c:url value='/home'/>">Về trang chủ</a>
                    </div>
                    <div class="mt-3 p-2 bg-light rounded small text-muted">
                        <strong>Tài khoản mẫu:</strong><br>
                        Admin: <code>admin</code> / <code>123456</code><br>
                        User: <code>user</code> / <code>123</code>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

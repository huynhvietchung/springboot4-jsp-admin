<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thông tin cá nhân</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="mb-0 fw-bold text-primary">Hồ sơ cá nhân</h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>

                <form action="<c:url value='/profile'/>" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên đăng nhập</label>
                        <input type="text" class="form-control" value="${user.username}" readonly>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Họ và tên</label>
                        <input type="text" name="fullname" class="form-control" value="${user.fullname}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email</label>
                        <input type="email" name="email" class="form-control" value="${user.email}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control" value="${user.phone}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu mới (để trống nếu không đổi)</label>
                        <input type="password" name="newPassword" class="form-control">
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                        <a href="<c:url value='/home'/>" class="btn btn-secondary">Trang chủ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

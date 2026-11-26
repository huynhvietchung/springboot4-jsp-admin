<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Cập nhật User' : 'Thêm mới User'}</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-md-7">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="mb-0 fw-bold text-primary">
                    ${isEdit ? 'Cập nhật User' : 'Thêm mới User'}
                </h4>
            </div>
            <div class="card-body">
                <c:if test="${not empty alert}">
                    <div class="alert alert-danger">${alert}</div>
                </c:if>

                <form action="<c:url value='/admin/users/save'/>" method="post">
                    <c:if test="${user.id != null}">
                        <input type="hidden" name="id" value="${user.id}">
                    </c:if>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Username *</label>
                            <input type="text" name="username" class="form-control" value="${user.username}"
                                   ${isEdit ? 'readonly' : 'required'}>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">
                                Mật khẩu ${isEdit ? '(để trống nếu giữ nguyên)' : '*'}
                            </label>
                            <input type="password" name="password" class="form-control" ${isEdit ? '' : 'required'}>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" name="fullname" class="form-control" value="${user.fullname}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Email</label>
                            <input type="email" name="email" class="form-control" value="${user.email}">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control" value="${user.phone}">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Vai trò</label>
                            <select name="roleid" class="form-select">
                                <option value="1" ${user.roleid == 1 ? 'selected' : ''}>Admin (1)</option>
                                <option value="2" ${user.roleid == 2 ? 'selected' : ''}>Manager (2)</option>
                                <option value="3" ${user.roleid == null || user.roleid == 3 ? 'selected' : ''}>Customer (3)</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Avatar</label>
                        <input type="text" name="avatar" class="form-control" value="${user.avatar}" placeholder="vd: avatar.png">
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Lưu lại</button>
                        <a href="<c:url value='/admin/users/searchpaginated'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

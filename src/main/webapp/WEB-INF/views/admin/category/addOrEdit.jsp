<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>${isEdit ? 'Cập nhật Category' : 'Thêm mới Category'}</title>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
                <h4 class="mb-0 fw-bold text-primary">
                    ${isEdit ? 'Cập nhật Category' : 'Thêm mới Category'}
                </h4>
            </div>
            <div class="card-body">
                <form action="<c:url value='/admin/categories/save'/>" method="post">
                    <c:if test="${category.id != null}">
                        <input type="hidden" name="id" value="${category.id}">
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên Category *</label>
                        <input type="text" name="name" class="form-control" value="${category.name}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Hình ảnh (tên file / URL)</label>
                        <input type="text" name="images" class="form-control" value="${category.images}" placeholder="vd: ao_nam.png">
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="true" ${category.status == null || category.status ? 'selected' : ''}>Hoạt động</option>
                            <option value="false" ${category.status != null && !category.status ? 'selected' : ''}>Ngừng hoạt động</option>
                        </select>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">Lưu lại</button>
                        <a href="<c:url value='/admin/categories/searchpaginated'/>" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

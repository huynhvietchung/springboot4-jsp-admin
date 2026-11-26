<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Category</title>
</head>
<body>
<div class="card shadow-sm border-0">
    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
        <h4 class="mb-0 fw-bold text-primary">Danh sách Category</h4>
        <a href="<c:url value='/admin/categories/add'/>" class="btn btn-primary btn-sm">+ Thêm Category</a>
    </div>
    <div class="card-body">
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-3 mb-3 align-items-center">
            <div class="col-md-6">
                <form action="<c:url value='/admin/categories/searchpaginated'/>" method="get" class="d-flex gap-2">
                    <input type="text" name="name" id="name" value="${name}" class="form-control" placeholder="Nhập từ khóa để tìm theo tên Category">
                    <input type="hidden" name="size" value="${categoryPage.size}">
                    <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
                    <c:if test="${not empty name}">
                        <a href="<c:url value='/admin/categories/searchpaginated'/>" class="btn btn-outline-secondary">Xóa lọc</a>
                    </c:if>
                </form>
            </div>
            <div class="col-md-6 d-flex justify-content-md-end align-items-center">
                <form action="<c:url value='/admin/categories/searchpaginated'/>" method="get" class="d-flex align-items-center gap-2">
                    <input type="hidden" name="name" value="${name}">
                    <label for="size" class="form-label mb-0 text-nowrap">Số dòng/trang:</label>
                    <select name="size" id="size" class="form-select form-select-sm w-auto" onchange="this.form.submit()">
                        <option ${categoryPage.size == 3 ? 'selected' : ''} value="3">3</option>
                        <option ${categoryPage.size == 5 ? 'selected' : ''} value="5">5</option>
                        <option ${categoryPage.size == 10 ? 'selected' : ''} value="10">10</option>
                        <option ${categoryPage.size == 15 ? 'selected' : ''} value="15">15</option>
                        <option ${categoryPage.size == 20 ? 'selected' : ''} value="20">20</option>
                    </select>
                </form>
            </div>
        </div>

        <c:if test="${!categoryPage.hasContent()}">
            <div class="alert alert-warning mb-0">Không tìm thấy Category nào.</div>
        </c:if>

        <c:if test="${categoryPage.hasContent()}">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th style="width: 70px;">STT</th>
                        <th>ID</th>
                        <th>Hình ảnh</th>
                        <th>Tên Category</th>
                        <th>Trạng thái</th>
                        <th style="width: 160px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${categoryPage.content}" var="cate" varStatus="STT">
                        <tr>
                            <td>${categoryPage.number * categoryPage.size + STT.index + 1}</td>
                            <td>${cate.id}</td>
                            <td><code>${cate.images}</code></td>
                            <td class="fw-semibold">${cate.name}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${cate.status}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Ngừng hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="<c:url value='/admin/categories/edit/${cate.id}'/>" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="<c:url value='/admin/categories/delete/${cate.id}'/>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa Category này?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${categoryPage.totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${categoryPage.first ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${categoryPage.number}'/>">Trước</a>
                        </li>
                        <c:forEach items="${pageNumbers}" var="pageNumber">
                            <li class="page-item ${pageNumber == categoryPage.number + 1 ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${pageNumber}'/>">${pageNumber}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${categoryPage.last ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/categories/searchpaginated?name=${name}&size=${categoryPage.size}&page=${categoryPage.number + 2}'/>">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:if>
    </div>
</div>
</body>
</html>

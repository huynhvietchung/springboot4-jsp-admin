<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý User</title>
</head>
<body>
<div class="card shadow-sm border-0">
    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
        <h4 class="mb-0 fw-bold text-primary">Danh sách User</h4>
        <a href="<c:url value='/admin/users/add'/>" class="btn btn-primary btn-sm">+ Thêm User</a>
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
                <form action="<c:url value='/admin/users/searchpaginated'/>" method="get" class="d-flex gap-2">
                    <input type="text" name="keyword" id="keyword" value="${keyword}" class="form-control"
                           placeholder="Tìm theo username, họ tên hoặc email...">
                    <input type="hidden" name="size" value="${userPage.size}">
                    <button type="submit" class="btn btn-outline-primary">Tìm kiếm</button>
                    <c:if test="${not empty keyword}">
                        <a href="<c:url value='/admin/users/searchpaginated'/>" class="btn btn-outline-secondary">Xóa lọc</a>
                    </c:if>
                </form>
            </div>
            <div class="col-md-6 d-flex justify-content-md-end align-items-center">
                <form action="<c:url value='/admin/users/searchpaginated'/>" method="get" class="d-flex align-items-center gap-2">
                    <input type="hidden" name="keyword" value="${keyword}">
                    <label for="size" class="form-label mb-0 text-nowrap">Số dòng/trang:</label>
                    <select name="size" id="size" class="form-select form-select-sm w-auto" onchange="this.form.submit()">
                        <option ${userPage.size == 3 ? 'selected' : ''} value="3">3</option>
                        <option ${userPage.size == 5 ? 'selected' : ''} value="5">5</option>
                        <option ${userPage.size == 10 ? 'selected' : ''} value="10">10</option>
                        <option ${userPage.size == 15 ? 'selected' : ''} value="15">15</option>
                        <option ${userPage.size == 20 ? 'selected' : ''} value="20">20</option>
                    </select>
                </form>
            </div>
        </div>

        <c:if test="${!userPage.hasContent()}">
            <div class="alert alert-warning mb-0">Không tìm thấy User nào.</div>
        </c:if>

        <c:if test="${userPage.hasContent()}">
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark">
                    <tr>
                        <th style="width: 70px;">STT</th>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>SĐT</th>
                        <th>Vai trò</th>
                        <th>Ngày tạo</th>
                        <th style="width: 160px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${userPage.content}" var="u" varStatus="STT">
                        <tr>
                            <td>${userPage.number * userPage.size + STT.index + 1}</td>
                            <td>${u.id}</td>
                            <td class="fw-semibold">${u.username}</td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>${u.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.roleid == 1}">
                                        <span class="badge bg-danger">Admin</span>
                                    </c:when>
                                    <c:when test="${u.roleid == 2}">
                                        <span class="badge bg-warning text-dark">Manager</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-info text-dark">Customer</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${u.createddate}</td>
                            <td>
                                <a href="<c:url value='/admin/users/edit/${u.id}'/>" class="btn btn-warning btn-sm">Sửa</a>
                                <a href="<c:url value='/admin/users/delete/${u.id}'/>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Bạn có chắc muốn xóa User này?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${userPage.totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${userPage.first ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${userPage.number}'/>">Trước</a>
                        </li>
                        <c:forEach items="${pageNumbers}" var="pageNumber">
                            <li class="page-item ${pageNumber == userPage.number + 1 ? 'active' : ''}">
                                <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${pageNumber}'/>">${pageNumber}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${userPage.last ? 'disabled' : ''}">
                            <a class="page-link" href="<c:url value='/admin/users/searchpaginated?keyword=${keyword}&size=${userPage.size}&page=${userPage.number + 2}'/>">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </c:if>
    </div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ</title>
</head>
<body>
<div class="p-5 mb-4 bg-white rounded-3 shadow-sm border">
    <div class="container-fluid py-3">
        <h1 class="display-6 fw-bold text-primary">Chào mừng đến với Spring Boot 4 + JSP/JSTL</h1>
        <p class="col-md-8 fs-5 text-muted">
            Hệ thống quản lý bán hàng mẫu sử dụng Spring Boot 4, Tomcat Embedded Jasper, JSTL, SiteMesh 3 và Spring Data JPA.
        </p>
        <div class="d-flex gap-2 mt-3">
            <c:choose>
                <c:when test="${sessionScope.currentUser == null}">
                    <a class="btn btn-primary" href="<c:url value='/login'/>">Đăng nhập</a>
                    <a class="btn btn-outline-primary" href="<c:url value='/register'/>">Đăng ký tài khoản</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.currentUser.roleid == 1}">
                        <a class="btn btn-dark" href="<c:url value='/admin/categories/searchpaginated'/>">Vào trang quản trị Category</a>
                        <a class="btn btn-outline-dark" href="<c:url value='/admin/users/searchpaginated'/>">Quản trị User</a>
                    </c:if>
                    <a class="btn btn-outline-danger" href="<c:url value='/logout'/>">Đăng xuất</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>

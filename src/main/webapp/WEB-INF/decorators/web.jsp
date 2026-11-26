<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Spring Boot 4 JSP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<c:url value='/'/>">HCMUTE Shop</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#webNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="webNavbar">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/home'/>">Trang chủ</a>
                </li>
                <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/admin/categories/searchpaginated'/>">Quản trị Admin</a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.currentUser != null}">
                        <li class="nav-item d-flex align-items-center me-3 text-white">
                            Xin chào, <strong class="ms-1">${sessionScope.currentUser.fullname != null ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm" href="<c:url value='/logout'/>">Đăng xuất</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-light btn-sm" href="<c:url value='/login'/>">Đăng nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-light btn-sm text-primary fw-semibold" href="<c:url value='/register'/>">Đăng ký</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<main class="container my-4 flex-grow-1">
    <sitemesh:write property='body'/>
</main>

<footer class="bg-dark text-white text-center py-3 mt-auto">
    <div class="container small">
        Spring Boot 4 + JSP/JSTL + SiteMesh 3 Demo &copy; 2026
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <sitemesh:write property='head'/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold" href="<c:url value='/admin/categories/searchpaginated'/>">Admin Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/categories/searchpaginated'/>">Quản lý Category</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/users/searchpaginated'/>">Quản lý User</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/home'/>">Trang chủ Web</a>
                </li>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:if test="${sessionScope.currentUser != null}">
                    <li class="nav-item d-flex align-items-center me-3 text-light">
                        Admin: <strong class="ms-1">${sessionScope.currentUser.username}</strong>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-danger btn-sm" href="<c:url value='/logout'/>">Đăng xuất</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<main class="container-fluid px-4 my-4 flex-grow-1">
    <sitemesh:write property='body'/>
</main>

<footer class="bg-secondary text-white text-center py-2 mt-auto">
    <div class="container small">
        Admin Panel - Spring Boot 4 &amp; JSP/JSTL
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

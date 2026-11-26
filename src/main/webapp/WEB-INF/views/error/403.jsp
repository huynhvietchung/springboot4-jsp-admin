<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Không có quyền truy cập</title>
</head>
<body>
<div class="alert alert-danger p-4 shadow-sm">
    <h4 class="alert-heading">403 - Truy cập bị từ chối</h4>
    <p>Bạn không có quyền Admin để truy cập trang này.</p>
    <a href="<c:url value='/home'/>" class="btn btn-primary btn-sm">Quay lại trang chủ</a>
</div>
</body>
</html>

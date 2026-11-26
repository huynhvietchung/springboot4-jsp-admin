# Spring Boot 4 + JSP/JSTL + SiteMesh 3 Admin CRUD

Dự án thực hành môn Lập trình Web (HCMUTE) sử dụng **Spring Boot 4.0.0**, **JSP/JSTL**, **SiteMesh 3**, **Spring Data JPA** và **H2 Database**.

## Tính năng đã hoàn thiện
1. **Cấu hình JSP/JSTL & SiteMesh 3 trong Spring Boot 4**:
   - `TomcatJSPConfiguration` & `JSPStaticResourceConfigurer`
   - `CustomSiteMeshFilter` phân tách layout `web.jsp` và `admin.jsp`
   - `CharacterEncodingFilter` hỗ trợ hiển thị tiếng Việt UTF-8
2. **Xác thực & Phân quyền (Register / Login / Logout)**:
   - Đăng ký tài khoản mới (`/register`)
   - Đăng nhập với Session + Cookie ghi nhớ tài khoản (`/login`)
   - Đăng xuất (`/logout`)
   - `AuthInterceptor` bảo vệ các route `/admin/**` (chỉ role Admin `roleid = 1` mới được truy cập)
3. **Admin CRUD có Tìm kiếm & Phân trang**:
   - Quản lý **Category** (`/admin/categories/searchpaginated`): Thêm, Sửa, Xóa, Tìm kiếm theo tên, Phân trang (`page`, `size`)
   - Quản lý **User** (`/admin/users/searchpaginated`): Thêm, Sửa, Xóa, Tìm kiếm theo `username` / `fullname` / `email`, Phân trang (`page`, `size`)

## Tài khoản mẫu (tự động khởi tạo khi chạy)
- **Admin**: `admin` / `123456`
- **Customer**: `user` / `123`

## Cách chạy dự án
```bash
mvn spring-boot:run
```
Truy cập: `http://localhost:8090`

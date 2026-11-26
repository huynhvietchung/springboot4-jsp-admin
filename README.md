# Spring Boot 4 + JSP/JSTL + SiteMesh 3 Admin CRUD

Dự án thực hành môn Lập trình Web (HCMUTE) sử dụng **Spring Boot 4.0.0**, **JSP/JSTL**, **SiteMesh 3**, **Spring Data JPA** và **H2 Database**.

## Tính năng đã hoàn thiện
1. **Cấu hình JSP/JSTL & SiteMesh 3 trong Spring Boot 4**:
   - `TomcatJSPConfiguration` & `JSPStaticResourceConfigurer`
   - `CustomSiteMeshFilter` phân tách layout `web.jsp` và `admin.jsp`
   - `CharacterEncodingFilter` hỗ trợ hiển thị tiếng Việt UTF-8
2. **Xác thực & Phân quyền (Register / Login / Logout / Profile)**:
   - Đăng ký tài khoản mới (`/register`)
   - Đăng nhập với Session + Cookie ghi nhớ tài khoản (`/login`)
   - Đăng xuất (`/logout`)
   - Xem và cập nhật hồ sơ cá nhân (`/profile`)
   - `AuthInterceptor` bảo vệ các route `/admin/**` (chỉ role Admin `roleid = 1` mới được truy cập)
3. **Admin CRUD có Tìm kiếm & Phân trang**:
   - Quản lý **Category** (`/admin/categories/searchpaginated`): Thêm, Sửa, Xóa, Tìm kiếm theo tên, Phân trang (`page`, `size`)
   - Quản lý **User** (`/admin/users/searchpaginated`): Thêm, Sửa, Xóa, Tìm kiếm theo `username` / `fullname` / `email`, Phân trang (`page`, `size`)

## Bảng Endpoints chính
| Đường dẫn | Phương thức | Mô tả | Phân quyền |
|---|---|---|---|
| `/`, `/home` | GET | Trang chủ Web | Công khai |
| `/login` | GET, POST | Đăng nhập (Session & Cookie) | Công khai |
| `/register` | GET, POST | Đăng ký tài khoản mới | Công khai |
| `/logout` | GET | Đăng xuất | Đã đăng nhập |
| `/profile` | GET, POST | Cập nhật thông tin & mật khẩu | Đã đăng nhập |
| `/admin/categories/searchpaginated` | GET | Danh sách Category (tìm kiếm + phân trang) | Admin (`roleid = 1`) |
| `/admin/categories/add`, `/edit/{id}`, `/delete/{id}` | GET, POST | CRUD Category | Admin (`roleid = 1`) |
| `/admin/users/searchpaginated` | GET | Danh sách User (tìm kiếm + phân trang) | Admin (`roleid = 1`) |
| `/admin/users/add`, `/edit/{id}`, `/delete/{id}` | GET, POST | CRUD User | Admin (`roleid = 1`) |

## Tài khoản mẫu (tự động khởi tạo khi chạy)
- **Admin**: `admin` / `123456`
- **Customer**: `user` / `123`

## Cách chạy dự án
```bash
mvn spring-boot:run
```
Truy cập: `http://localhost:8090`

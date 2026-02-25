<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page isELIgnored="false" %>
<%
// Lấy đường dẫn hiện tại, ví dụ: /PT_Online/Thu-vien hoặc /PT_Online/index.jsp
String uri = request.getRequestURI();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hardcore Gym Header</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #f90606;
            --bg-dark: #230f0f;
        }

        body {
            font-family: 'Inter', sans-serif;
        }

        /* Header Glassmorphism */
        .custom-nav {
            background-color: rgba(0, 0, 0, 0.9) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(249, 6, 6, 0.1);
            height: 80px;
        }

        /* Logo */
        .navbar-brand {
            font-weight: 900;
            font-style: italic;
            letter-spacing: -1px;
            text-transform: uppercase;
        }

        /* Menu links */
        .nav-link-custom {
            color: #ffffff;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-link-custom:hover, .nav-link-custom.active {
            color: var(--primary) !important;
        }

        /* Nút Đăng nhập */
        .btn-hardcore {
            background-color: var(--primary);
            color: white;
            border-radius: 50px;
            padding: 8px 25px;
            font-weight: 800;
            font-size: 0.75rem;
            text-transform: uppercase;
            border: none;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-hardcore:hover {
            background-color: #d60505;
            box-shadow: 0 4px 15px rgba(249, 6, 6, 0.3);
            color: white;
        }

        /* User Avatar Style */
        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary);
            transition: 0.3s;
            cursor: pointer;
        }

        .user-avatar:hover {
            box-shadow: 0 0 12px var(--primary);
            transform: scale(1.05);
        }

        /* Dropdown Customization */
        .dropdown-menu-dark {
            background-color: #111;
            border: 1px solid rgba(249, 6, 6, 0.2);
            margin-top: 15px !important;
            border-radius: 8px;
        }

        .dropdown-item {
            font-weight: 600;
            font-size: 0.85rem;
            padding: 10px 20px;
        }

        .dropdown-item:hover {
            background-color: var(--primary);
        }

        .dropdown-toggle::after {
            display: none; /* Ẩn mũi tên mặc định */
        }
        /* Ẩn mũi tên tam giác mặc định của Bootstrap */
        .dropdown-toggle::after {
            display: none !important;
        }

        /* Đảm bảo avatar không có gạch chân khi di chuột vào */
        .dropdown-toggle {
            text-decoration: none !important;
            outline: none !important;
        }
        .dropdown-menu-dark {
            background-color: #111 !important;
            border: 1px solid rgba(249,6,6,0.3) !important;
            border-radius: 10px !important;
            padding: 12px 0 !important;
            min-width: 220px !important;   /* TĂNG WIDTH */
            box-shadow: 0 20px 50px rgba(0,0,0,0.6) !important;
        }

        .dropdown-menu-dark .dropdown-item {
            font-size: 15px !important;    /* TĂNG SIZE */
            font-weight: 600 !important;
            padding: 12px 22px !important; /* TĂNG PADDING */
            line-height: 1.5 !important;
        }

        .dropdown-header {
            font-size: 14px !important;
            padding: 12px 22px !important;
        }

        .dropdown-menu-dark .dropdown-item:hover {
            background-color: #f90606 !important;
            color: #fff !important;
        }
        .dropdown-menu {
            opacity: 1 !important;
            filter: none !important;
        }

    </style>
</head>
<body>

<div class="header-main">
    <nav class="navbar navbar-expand-md custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="<%= request.getContextPath() %>/home">
                <img src = "">


                <span style="color: white;">Smart-<span style="color: var(--primary)">PT</span></span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav mx-auto gap-4">

                    <a class="nav-link-custom <%= (uri.contains("home")) ? "active" : "" %>"
                    href="<%= request.getContextPath() %>/home">Trang chủ</a>

                    <a class="nav-link-custom <%= (uri.contains("/package")) ? "active" : "" %>"
                    href="<%= request.getContextPath() %>/package">Gói tập</a>

                    <a class="nav-link-custom <%= (uri.contains("/library")) ? "active" : "" %>"
                    href="<%= request.getContextPath() %>/library">Thư viện</a>

                    <a class="nav-link-custom <%= (uri.contains("/news")) ? "active" : "" %>"
                    href="<%= request.getContextPath() %>/news">Blog</a>

                    <a class="nav-link-custom" href="${pageContext.request.contextPath}/setup/goal">Thiết lập mục tiêu</a>

                </div>

                <div class="d-flex align-items-center">
                    <%
                    String sessionUser = (String) session.getAttribute("username");

                    if (sessionUser == null) {
                    %>
                    <a href="${pageContext.request.contextPath}/auth?action=login" class="btn-hardcore">Đăng nhập</a>
                    <%
                    } else {
                    %>
                    <div class="dropdown">
                        <a href="#" class="dropdown-toggle" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <img src="https://ui-avatars.com/api/?name=<%= sessionUser %>&background=f90606&color=fff"
                                 alt="Avatar" class="user-avatar">
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow" aria-labelledby="userDropdown">
                            <li><h6 class="dropdown-header text-white-50">Xin chào, <%= sessionUser %>!</h6></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/MySchedule">Lộ trình của tôi</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=changePassword">Đổi mật khẩu</a></li>

                            <% if("ADMIN".equalsIgnoreCase((String)session.getAttribute("role"))) { %>
                            <li><a class="dropdown-item text-warning" href="${pageContext.request.contextPath}/admin/home">Quản trị hệ thống</a></li>
                            <% } %>

                            <li><hr class="dropdown-divider" style="background-color: rgba(255,255,255,0.1)"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                    <%
                    }
                    %>
                </div>
            </div>
        </div>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
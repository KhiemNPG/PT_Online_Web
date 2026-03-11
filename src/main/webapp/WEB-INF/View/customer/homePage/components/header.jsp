<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page isELIgnored="false" %>
<%@ page import="model.training.TrainingDay" %>
<%@ page import="model.training.Exercise" %>
<%@ page import="java.util.List,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<%
// Lấy đường dẫn hiện tại, ví dụ: /PT_Online/Thu-vien hoặc /PT_Online/index.jsp
String uri = request.getRequestURI();
TrainingDay trainingDayToday = (TrainingDay) request.getAttribute("trainingDayToday");
List< Exercise> exerciseListTomorrow = (List< Exercise>) request.getAttribute("exerciseListTomorrow");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hardcore Gym Header</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        :root {
            --primary: #f90606;
            --bg-dark: #230f0f;
        }

        body {
            font-family: 'Inter', sans-serif;
        }

        /* --- PHẦN GIỮ NGUYÊN (NHƯ YÊU CẦU) --- */
        .custom-nav {
            background-color: rgba(0, 0, 0, 0.9) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(249, 6, 6, 0.1);
            height: 80px;
        }

        .navbar-brand {
            font-weight: 900;
            font-style: italic;
            letter-spacing: -1px;
            text-transform: uppercase;
        }

        .navbar-logo {
            height: 50px;
            width: auto;
            object-fit: contain;
            vertical-align: middle;
            filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.1));
            transition: all 0.3s ease;
        }

        .navbar-brand:hover .navbar-logo {
            transform: scale(1.1);
        }

        .brand-text {
            color: white;
            letter-spacing: 0.5px;
            line-height: 1;
        }

        .navbar-brand:hover {
            transform: scale(1.02);
            opacity: 0.9;
        }

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

        .dropdown-menu-dark {
            background-color: #111 !important;
            border: 1px solid rgba(249,6,6,0.3) !important;
            border-radius: 10px !important;
            padding: 12px 0 !important;
            min-width: 220px !important;
            box-shadow: 0 20px 50px rgba(0,0,0,0.6) !important;
        }

        .dropdown-menu-dark .dropdown-item {
            font-size: 15px !important;
            font-weight: 600 !important;
            padding: 12px 22px !important;
            line-height: 1.5 !important;
        }

        .dropdown-header {
            font-size: 14px !important;
            padding: 12px 22px !important;
        }

        .dropdown-menu-dark .dropdown-item:hover {
            background-color: var(--primary) !important;
            color: #fff !important;
        }

        .dropdown-toggle::after {
            display: none !important; /* Xóa triệt để mũi tên mặc định cho mọi dropdown */
        }

        .d-flex.align-items-center.gap-3 {
            display: flex;
            align-items: center;
            gap: 1.2rem;
        }

        /* --- PHẦN SỬA LẠI: CHUÔNG THÔNG BÁO (Cơ chế Click) --- */

        .notification-dropdown {
            position: relative;
            display: inline-block;
        }

        /* Nút bấm (Chuông) */
        .notification-bell {
            position: relative;
            cursor: pointer;
            padding: 5px;
            transition: all 0.3s ease;
        }

        .notification-bell i {
            font-size: 1.35rem;
            color: #fff;
        }

        /* Đổi màu chuông khi mở bảng */
        .notification-bell[aria-expanded="true"] i {
            color: var(--primary);
        }

        /* Chấm đỏ */
        .badge-dot {
            position: absolute;
            top: 2px;
            right: 2px;
            width: 10px;
            height: 10px;
            background-color: var(--primary);
            border-radius: 50%;
            border: 2px solid #000;
        }

        /* Bảng thông báo (Dropdown Menu) */
        .workout-tooltip-box.dropdown-menu {
            /* XÓA: display: none !important; */
            /* XÓA: opacity: 0; */
            background: #111 !important;
            border: 1px solid rgba(249, 6, 6, 0.4) !important;
            border-radius: 12px !important;
            padding: 18px !important;
            width: 300px !important;
            margin-top: 15px !important;
            box-shadow: 0 15px 40px rgba(0,0,0,0.9) !important;

            /* Đảm bảo vị trí chuẩn xác */
            inset: 0px 0px auto auto !important;
            transform: translate(0px, 45px) !important;
        }

        /* Animation khi hiện bảng */
        .workout-tooltip-box.dropdown-menu.show {
            animation: slideDown 0.2s ease-out forwards;
        }

        /* Style nội dung trong bảng */
        .tooltip-header {
            font-size: 11px;
            font-weight: 900;
            color: #fff;
            letter-spacing: 1.2px;
            margin-bottom: 12px;
            text-transform: uppercase;
            display: flex;
            align-items: center;
        }

        .tooltip-divider {
            height: 1px;
            background: rgba(255,255,255,0.1);
            margin: 12px 0;
        }

        .workout-item { margin-bottom: 12px; }
        .ex-name { font-size: 14px; font-weight: 600; color: #eee; }

        .status-label {
            font-size: 9px;
            padding: 2px 8px;
            border-radius: 4px;
            text-transform: uppercase;
            font-weight: 800;
        }
        .complete { background: #28a745; color: #fff; }
        .pending { background: #444; color: #bbb; }

        .tool-note {
            font-size: 11px;
            color: var(--primary);
            margin-top: 4px;
            font-style: italic;
        }

        /* Rung chuông */
        .ring {
            animation: bell-ring 2.5s ease infinite;
        }

        @keyframes bell-ring {
            0%, 100% { transform: rotate(0); }
            5%, 15%, 25% { transform: rotate(15deg); }
            10%, 20% { transform: rotate(-15deg); }
            30% { transform: rotate(0); }
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Fix font-awesome hiển thị chuẩn */
        .fa-bell, .fa-solid, .fas {
            font-family: "Font Awesome 6 Free" !important;
            font-weight: 900 !important;
        }
    </style>
</head>
<body>

<div class="header-main">
    <nav class="navbar navbar-expand-md custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="<%= request.getContextPath() %>/home">
                <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1771925947/8955c440-7287-4779-b81f-ada2c991d02c-removebg-preview_holdqj.png"
                     class="navbar-logo" alt="Logo">
                <span class="brand-text">Smart-<span style="color: var(--primary)">PT</span></span>
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

                    <a class="nav-link-custom" href="${pageContext.request.contextPath}/setup/goal">Thiết lập lộ trình</a>

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

                    <%
                        if (exerciseListTomorrow != null && trainingDayToday != null){
                    %>
                    <div class="d-flex align-items-center gap-3">
                        <div class="notification-dropdown dropdown">
                            <div class="notification-bell ring dropdown-toggle"
                                 id="bellDropdown"
                                 data-bs-toggle="dropdown"
                                 aria-expanded="false"
                                 data-bs-auto-close="outside">

                                <i class="fa-solid fa-bell"></i>
                                <span class="badge-dot"></span>
                            </div>

                            <div class="dropdown-menu dropdown-menu-end workout-tooltip-box shadow" aria-labelledby="bellDropdown">
                                <div class="tooltip-header">
                                    <i class="fa-solid fa-calendar-check me-2"></i>BUỔI TẬP HÔM NAY
                                </div>
                                <div class="tooltip-section">
                                    <div class="workout-item d-flex justify-content-between align-items-center">
                                        <span class="ex-name"><%= trainingDayToday.getWorkoutLabel() %></span>
                                        <%
                                            if (trainingDayToday.isCompleted()){
                                        %>
                                        <span class="status-label complete">Hoàn thành</span>
                                        <%
                                        } else {
                                        %>
                                        <span class="status-label pending">Chưa tập</span>
                                        <%
                                        }
                                        %>
                                    </div>

                                </div>

                                <div class="tooltip-divider"></div>

                                <div class="tooltip-header text-warning">
                                    <i class="fa-solid fa-clock me-2"></i>NGÀY MAI (CHUẨN BỊ)
                                </div>
                                <div class="tooltip-section">
                                    <%
                                    if (exerciseListTomorrow != null){
                                        if (exerciseListTomorrow.get(0).getExerciseId() != 999){
                                        for (Exercise ex : exerciseListTomorrow){
                                    %>
                                    <div class="workout-item">
                                        <div class="ex-name text-white"><%= ex.getExerciseName()%></div>
                                        <div class="tool-note">
                                            <i class="fa-solid fa-gear me-1"></i>Dụng cụ: <%= ex.getEquipmentRequired()%>
                                        </div>
                                    </div>
                                    <%
                                            }
                                        } else {
                                    %>
                                    <div class="rest-day-card text-center my-2">
                                        <div class="ex-icon mb-3">
                                            <i class="fa-solid fa-battery-three-quarters fa-flip-horizontal fa-2xl"
                                               style="color: #28a745; filter: drop-shadow(0 0 5px rgba(40, 167, 69, 0.4));"></i>
                                        </div>

                                        <div class="ex-name rest-text-glow fw-900 mb-1" style="font-size: 0.9rem; text-transform: uppercase;">
                                            Ngày mai: <span style="color: var(--primary)">Rest Day</span>
                                        </div>

                                        <div class="tool-note" style="font-size: 11px; opacity: 0.7;">
                                            <i class="fa-solid fa-mug-hot me-1"></i>
                                            Cơ bắp phát triển khi bạn nghỉ ngơi.
                                        </div>
                                    </div>
                                    <%
                                    }
                                    }
                                    %>
                                </div>
                            </div>
                        </div>
                    <%
                    }
                    %>

                        <div class="dropdown">
                            <a href="#" class="dropdown-toggle d-flex align-items-center" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false" style="text-decoration: none;">
                                <img src="https://ui-avatars.com/api/?name=<%= sessionUser %>&background=f90606&color=fff"
                                     alt="Avatar" class="user-avatar rounded-circle border border-2 border-danger">
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end shadow mt-2" aria-labelledby="userDropdown">
                                <li><h6 class="dropdown-header text-white-50">Xin chào, <%= sessionUser %>!</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ cá nhân</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/MySchedule">Lộ trình của tôi</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/tracking">Theo dõi</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth?action=changePassword">Đổi mật khẩu</a></li>
                                <li><hr class="dropdown-divider" style="background-color: rgba(255,255,255,0.1)"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth?action=logout">Đăng xuất</a></li>
                            </ul>
                        </div>
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
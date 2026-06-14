<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<%
String requestUri = request.getRequestURI();
%>

<style>
    /* Dark Theme Sidebar */
    .bg-admin-sidebar { background-color: #111622; }
    .text-outline-custom { color: #64748b; }

    .nav-item-custom {
        color: #94a3b8;
        text-decoration: none;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 24px;
        border-radius: 12px;
    }

    .nav-item-custom:hover {
        background-color: rgba(255, 255, 255, 0.05);
        color: #f8fafc;
    }

    /* Fix Active State */
    .nav-item-custom.active {
        color: #38bdf8 !important;
        background-color: rgba(56, 189, 248, 0.1) !important;
        font-weight: bold !important;
        border-right: 4px solid #38bdf8 !important;
        border-top-left-radius: 8px !important;
        border-bottom-left-radius: 8px !important;
    }
</style>

<aside class="bg-admin-sidebar border-end border-secondary border-opacity-25 d-flex flex-column py-4 position-fixed start-0 top-0"
       style="width: 260px; height: 100vh; z-index: 1050;">

    <div class="px-4 mb-4 d-flex align-items-center gap-3">
        <div class="rounded-3 d-flex align-items-center justify-content-center"
             style="width: 40px; height: 40px; background-color: rgba(56, 189, 248, 0.15);">
            <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1771925947/8955c440-7287-4779-b81f-ada2c991d02c-removebg-preview_holdqj.png"
                 alt="Logo" style="width: 36px; height: 36px; object-fit: contain;">
        </div>
        <div>
            <h1 class="h5 mb-0 fw-bold text-white lh-tight" style="font-size: 20px;">Smart PT</h1>
            <p class="text-uppercase tracking-wider mb-0 text-outline-custom" style="font-size: 11px; letter-spacing: 0.05em;">Professional Admin</p>
        </div>
    </div>

    <nav class="flex-grow-1 px-2 d-flex flex-column gap-1">
        <a class="nav-item-custom <%= requestUri.endsWith("/admin/dashboard") ? "active" : "" %>"
        href="${pageContext.request.contextPath}/admin/dashboard">
        <span class="material-symbols-outlined">dashboard</span>
        <span>Dashboard</span>
        </a>

        <a class="nav-item-custom <%= requestUri.endsWith("/admin/users") ? "active" : "" %>"
        href="${pageContext.request.contextPath}/admin/users">
        <span class="material-symbols-outlined">group</span>
        <span>Quản lý Học viên</span>
        </a>

        <a class="nav-item-custom <%= requestUri.endsWith("/admin/personal-trainer") ? "active" : "" %>"
        href="${pageContext.request.contextPath}/admin/personal-trainer">
        <span class="material-symbols-outlined">badge</span>
        <span>Quản lý PT</span>
        </a>

        <a class="nav-item-custom <%= requestUri.endsWith("/admin/transactions") ? "active" : "" %>"
        href="${pageContext.request.contextPath}/admin/transactions">
        <span class="material-symbols-outlined">payments</span>
        <span>Xác nhận thanh toán</span>
        </a>

        <a class="nav-item-custom <%= requestUri.endsWith("/admin/revenue") ? "active" : "" %>"
        href="${pageContext.request.contextPath}/admin/revenue">
        <span class="material-symbols-outlined">analytics</span>
        <span>Báo cáo Doanh thu</span>
        </a>
    </nav>

</aside>
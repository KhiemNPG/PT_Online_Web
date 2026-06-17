<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    Object totalObj = request.getAttribute("totalAmount");
    double totalAmount = (totalObj != null) ? (Double) totalObj : 0.0;

    Object totalPersonalTrainerObj = request.getAttribute("personalTrainerList");
    int totalPersonalTrainer = (totalPersonalTrainerObj != null) ? (int) totalPersonalTrainerObj : 0;

    Object totalUserObj = request.getAttribute("userList");
    int totalUser = (totalUserObj != null) ? (int) totalUserObj : 0;

    Object totalAccountProObj = request.getAttribute("totalAccountPro");
    int totalAccountPro = (totalAccountProObj != null) ? (int) totalAccountProObj : 0;

    double conversionRate = (totalUser > 0) ? (double) (totalAccountPro * 100) / totalUser : 0;

    // ✅ Format tiền tệ: 250000.0 → 250.000₫
    DecimalFormat moneyFormat = new DecimalFormat("#,###");
    String totalAmountFormatted = moneyFormat.format(totalAmount) + "₫";
%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>SmartPT - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

    <style>
        :root {
            --bg-main: #0b0f19;
            --bg-surface: #111622;
            --text-muted: #64748b;
            --color-primary: #10b981;
            --color-tech-blue: #38bdf8;
        }

        body { background-color: var(--bg-main); color: #f8fafc; font-family: 'Segoe UI', sans-serif; }

        .bento-card {
            background-color: var(--bg-surface);
            border: 1px solid rgba(100, 116, 139, 0.15);
            border-radius: 1rem;
            padding: 1.25rem;
        }

        .text-muted-custom { color: var(--text-muted); }

        .search-input-custom {
            background-color: #171e2e !important;
            border: 1px solid rgba(100, 116, 139, 0.2) !important;
            color: #ffffff !important;
            border-radius: 50px !important;
            padding-left: 2.75rem !important;
        }

        .search-input-custom::placeholder { color: rgba(100, 116, 139, 0.6); }

        .btn-add-custom {
            background-color: #38bdf8;
            color: #0b0f19;
            font-weight: 700;
            border-radius: 0.75rem;
            border: none;
        }
    </style>
</head>
<body>

<div class="container-fluid p-4" style="padding: 0!important">
    <header class="d-flex justify-content-between align-items-center w-100 pb-4 mb-3 border-bottom border-secondary border-opacity-10" style="backdrop-blur: md;">
        <div class="position-relative w-100" style="max-width: 500px;">
            <span class="material-symbols-outlined position-absolute top-50 translate-middle-y text-muted-custom" style="left: 1rem;">search</span>
            <input class="form-control search-input-custom py-2" placeholder="Tìm kiếm theo tên hoặc số điện thoại..." type="text"/>
        </div>

        <div class="d-flex align-items-center gap-3">
            <button class="btn btn-link position-relative text-muted-custom p-2">
                <span class="material-symbols-outlined">notifications</span>
                <span class="position-absolute bg-danger rounded-circle border border-dark" style="width: 8px; height: 8px; top: 10px; right: 12px;"></span>
            </button>
            <button class="btn btn-link text-muted-custom p-2">
                <span class="material-symbols-outlined">help</span>
            </button>
            <div class="bg-secondary bg-opacity-25" style="width: 1px; height: 24px; margin: 0 8px;"></div>

            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-lg-block">
                    <p class="mb-0 fw-bold text-white small" style="line-height: 1;">Admin Profile</p>
                    <p class="mb-0 text-muted-custom" style="font-size: 10px;">Master Trainer</p>
                </div>
                <img alt="Avatar" class="rounded-circle border border-2 border-info object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA8qR-ak6zwB2MSR1QmF9aivU7sKyg5wma9u9JgTlVnFWeSh4VBcl3MPOhgTsKmb7moLKkWNvfRUtJxw0Jim4kxYE5POtQQ4mZ-BaOAh3DSiZcj2IMH0oar0viZmnpVxlgAZquko5NiUFPTE6AUtV45LCsEhUVwrQNDRFj-4cE5ioqHjJnxwcXofXwRK9wn_sSucK3lqDxKEwI0-FDEMGOPfknyqZnzr1WAkC2abArCfdo2nMTXhSCohkyaOtGWNBzWKCD5iHt4deI" style="width: 40px; height: 40px;"/>
            </div>
        </div>
    </header>

    <div class="mb-4">
        <h2 class="h3 fw-bold text-white">Tổng quan hệ thống</h2>
        <p class="text-muted-custom" style = "font-size: 16px!important">Theo dõi hiệu suất và tăng trưởng thời gian thực.</p>
    </div>

    <div class="row g-3">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card h-100">
                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted-custom small fw-bold">TỔNG DOANH THU</span>
                    <span class="material-symbols-outlined" style="color: var(--color-primary);">payments</span>
                </div>
                <h3 class="fw-bold text-white"><%= totalAmountFormatted %></h3>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card h-100">
                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted-custom small fw-bold">TỔNG HỌC VIÊN</span>
                    <span class="material-symbols-outlined" style="color: var(--color-primary);">person_add</span>
                </div>
                <h3 class="fw-bold text-white"><%= (totalUser > 0) ? totalUser : 0%></h3>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card h-100">
                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted-custom small fw-bold">PT HOẠT ĐỘNG</span>
                    <span class="material-symbols-outlined" style="color: var(--color-primary);">fitness_center</span>
                </div>
                <h3 class="fw-bold text-white"><%= (totalPersonalTrainer > 0) ? totalPersonalTrainer : 0%></h3>
            </div>
        </div>
        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card h-100">
                <div class="d-flex justify-content-between mb-3">
                    <span class="text-muted-custom small fw-bold">TỶ LỆ CHUYỂN ĐỔI</span>
                    <span class="material-symbols-outlined" style="color: var(--color-tech-blue);">auto_graph</span>
                </div>
                <h3 class="fw-bold text-white"><%= String.format("%.1f", conversionRate)%>%</h3>
            </div>
        </div>
    </div>
</div>

</body>
</html>
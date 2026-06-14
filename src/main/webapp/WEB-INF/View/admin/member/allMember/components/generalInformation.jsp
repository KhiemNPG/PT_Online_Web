<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@page import="java.util.List"%>
<%@page import="model.entity.Account"%>
<%
    List< Account> accountCustomerList = (List< Account>) request.getAttribute("customerAccountList");
    int totalAccountPro = (Integer) request.getAttribute("totalAccountPro");

%>
<style>
    /* Hệ thống màu sắc tùy chỉnh theo đúng UI mẫu */
    :root {
        --bg-main: #0b0f19;              /* Nền tối sâu */
        --bg-surface: #111622;           /* Nền thẻ widget */
        --text-muted: #64748b;           /* Chữ phụ, caption */
        --color-primary: #10b981;        /* Xanh ngọc chủ đạo (Học viên Active) */
        --color-tech-blue: #38bdf8;      /* Xanh công nghệ */
    }

    body {
        background-color: var(--bg-main);
        color: #f8fafc;
    }

    /* Bo góc và đổ bóng mượt mà cho Bento Box */
    .bento-card {
        background-color: var(--bg-surface);
        border: 1px solid rgba(100, 116, 139, 0.15);
        border-radius: 1rem;
        padding: 1.25rem;
    }

    /* Gradient đặc biệt cho thẻ mục tiêu tăng trưởng bên phải */
    .bento-gradient {
        background: linear-gradient(135deg, rgba(56, 189, 248, 0.08) 0%, #111622 100%);
        border: 1px solid rgba(56, 189, 248, 0.15);
    }

    .text-muted-custom {
        color: var(--text-muted);
    }

    /* Tinh chỉnh thanh tìm kiếm bo tròn chuẩn UI */
    .search-input-custom {
        background-color: #171e2e !important;
        border: 1px solid rgba(100, 116, 139, 0.2) !important;
        color: #ffffff !important;
        border-radius: 50px !important;
        padding-left: 2.75rem !important;
    }
    .search-input-custom::placeholder {
        color: rgba(100, 116, 139, 0.6);
    }

    /* Tinh chỉnh Dropdown bộ lọc và nút Thêm mới */
    .filter-select {
        background-color: #171e2e;
        border: 1px solid rgba(100, 116, 139, 0.2);
        color: #f8fafc;
        border-radius: 0.75rem;
    }
    .btn-add-custom {
        background-color: #38bdf8;
        color: #0b0f19;
        font-weight: 700;
        border-radius: 0.75rem;
        border: none;
        transition: all 0.2s ease;
    }
    .btn-add-custom:hover {
        background-color: #0ea5e9;
        color: #ffffff;
    }

    /* Vòng tròn tiến độ bằng SVG thuần */
    .progress-ring-circle {
        transition: stroke-dashoffset 0.35s;
        transform: rotate(-90deg);
        transform-origin: 50% 50%;
    }
</style>

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

    <%
        if (accountCustomerList != null){
    %>
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h2 class="h3 mb-1 fw-bold text-white">Quản lý Học viên</h2>
            <p class="text-muted-custom mb-0">Tổng số <%= accountCustomerList.size()%> học viên đang hoạt động trong hệ thống</p>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="position-relative">
                <select class="form-select filter-select pe-5 py-2.5">
                    <option>Tất cả Học viên</option>
                    <option>Học viên Online PRO</option>
                    <option>Học viên thuê PT</option>
                    <option>Học viên Hybrid VIP</option>
                </select>
            </div>
            <button class="btn btn-add-custom px-4 py-2.5 d-flex align-items-center gap-2">
                <span class="material-symbols-outlined fs-5">person_add</span>
                <span>Thêm mới</span>
            </button>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card d-flex flex-column justify-content-between h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted-custom text-uppercase small fw-bold" style="letter-spacing: 0.05em;">Học viên Active</span>
                    <span class="material-symbols-outlined" style="color: var(--color-primary);">trending_up</span>
                </div>
                <div class="mt-4">
                    <h3 class="display-6 fw-bold mb-1" style="color: var(--color-primary);"><%= accountCustomerList.size()%></h3>
                    <p class="text-success small mb-0 d-flex align-items-center gap-1">
                        <span class="material-symbols-outlined fs-6">check_circle</span>
                        Tài khoản đang hoạt động
                    </p>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card d-flex flex-column justify-content-between h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted-custom text-uppercase small fw-bold" style="letter-spacing: 0.05em;">Gói PRO/VIP</span>
                    <span class="material-symbols-outlined text-warning">stars</span>
                </div>
                <div class="mt-4">
                    <h3 class="display-6 fw-bold text-white mb-1"><%= totalAccountPro %></h3>
                    <%
                        double persen = 0;
                        if (totalAccountPro > 0){
                            persen = ((double) totalAccountPro * 100) / accountCustomerList.size();
                        }
                    %>
                    <p class="text-muted-custom small mb-0"><%= String.format("%.1f", persen)%>% Tổng số học viên</p>
                </div>
            </div>
        </div>

        <%
        // 1. Tính toán phần trăm thực tế (Nên tính lại để đảm bảo biến ăn khớp toàn trang)
        double currentPercent = 0;
        if (totalAccountPro > 0 && accountCustomerList != null && !accountCustomerList.isEmpty()){
        currentPercent = ((double) totalAccountPro * 100) / accountCustomerList.size();
        }

        // 2. Tính toán stroke-dashoffset động cho vòng tròn SVG dựa trên % thực tế (Chu vi 251.2)
        // Nếu phần trăm thực tế vượt quá 100% thì giới hạn lại là 100% để vòng tròn không bị lỗi giao diện
        double svgPercent = (currentPercent > 100) ? 100 : currentPercent;
        double strokeDashoffset = 251.2 - (251.2 * svgPercent / 100);
        %>

        <div class="col-12 col-lg-6">
            <div class="bento-card bento-gradient h-100 position-relative overflow-hidden">
                <div class="d-flex justify-content-between align-items-center h-100 position-relative" style="z-index: 2;">
                    <div>
                        <%-- Sửa tiêu đề cho hợp lý với SmartPT --%>
                        <h4 class="text-white fw-bold h5 mb-1">Mục tiêu tài khoản PRO</h4>

                        <%-- Hiển thị câu so sánh trực quan theo ý bạn --%>
                        <p class="text-muted-custom small mb-0" style="max-width: 240px;">
                            Mục tiêu đạt <span class="text-white fw-bold">20%</span> tổng số học viên nâng cấp lên gói PRO.
                        </p>

                        <%-- Thêm một dòng text nhỏ chỉ số lượng thực tế để tăng tính thuyết phục --%>
                        <div class="mt-2 text-white-50 small">
                            Thực tế: <span class="text-info fw-bold"><%= totalAccountPro %></span> / <%= accountCustomerList.size() %> học viên
                        </div>
                    </div>

                    <%-- Vòng tròn tiến độ động hiển thị số phần trăm thực tế --%>
                    <div class="position-relative d-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                        <svg width="100" height="100" class="position-absolute" style="transform: rotate(-90deg);">
                            <circle class="text-secondary text-opacity-10" stroke="currentColor" stroke-width="8" fill="transparent" r="40" cx="50" cy="50"/>
                            <circle class="progress-ring-circle" stroke="#38bdf8" stroke-width="8" fill="transparent" r="40" cx="50" cy="50"
                                    stroke-dasharray="251.2"
                                    stroke-dashoffset="<%= strokeDashoffset %>"/> <%-- Đổ số offset động vào đây --%>
                        </svg>
                        <%-- Hiển thị số % thực tế ở tâm vòng tròn --%>
                        <span class="fw-bold text-white" style="font-size: 18px;"><%= String.format("%.1f", currentPercent) %>%</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%
        } else {
    %>
        <p>null</p>
    <%
        }
    %>

</div>
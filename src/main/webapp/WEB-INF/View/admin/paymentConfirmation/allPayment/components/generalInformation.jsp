<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%
    String totalAmountForDay = (String) request.getAttribute("totalAmountForDay");
        if (totalAmountForDay == null) {
        totalAmountForDay = "0 ₫";
    }

    Object totalPendingTradingObj = request.getAttribute("totalPendingTrading");
    int totalPendingTrading = (totalPendingTradingObj != null) ? (int) totalPendingTradingObj : 0;

    Object totalTransactionObj = request.getAttribute("totalTransaction");
    int totalTransaction = (totalTransactionObj != null) ? (int) totalTransactionObj : 0;

    Object totalSuccessTradingObj = request.getAttribute("totalSuccessTrading");
    int totalSuccessTrading = (totalSuccessTradingObj != null) ? (int) totalSuccessTradingObj : 0;

    double percentTradingCompleted = (double) (totalSuccessTrading * 100) / totalTransaction;
%>
<style>
    /* Biến màu chủ đạo */
    :root {
        --bg-main: #0b0f19;
        --bg-surface: #111622;
        --text-primary: #f8fafc;
        --text-muted: #64748b;
        --color-primary: #38bdf8; /* Màu xanh của bạn */
    }

    body { background-color: var(--bg-main) !important; color: var(--text-primary) !important; font-family: 'Inter', sans-serif; }

    .bento-card {
        background-color: var(--bg-surface);
        border: 1px solid rgba(100, 116, 139, 0.15);
        border-radius: 1rem;
        padding: 1.5rem;
    }

    /* Style cho các nút chuyển Tab */
    .btn-tab {
        color: var(--text-muted);
        border: none;
        background: transparent;
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        font-weight: 500;
    }
    .btn-tab.active {
        background-color: var(--color-primary);
        color: #000;
        font-weight: 700;
    }

    /* Style Icon Box */
    .icon-box {
        width: 48px;
        height: 48px;
        border-radius: 0.75rem;
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(56, 189, 248, 0.1);
        color: var(--color-primary);
    }
    /* --- Header & Search Styling --- */
    .search-input-custom {
        background-color: #171e2e !important;
        border: 1px solid rgba(100, 116, 139, 0.2) !important;
        color: #ffffff !important;
        border-radius: 50px !important;
        padding-left: 2.75rem !important;
        transition: all 0.3s ease;
    }

    .search-input-custom:focus {
        border-color: var(--color-tech-blue) !important;
        box-shadow: 0 0 0 2px rgba(56, 189, 248, 0.2) !important;
    }

    .search-input-custom::placeholder {
        color: rgba(100, 116, 139, 0.6);
    }

    /* Icon button hover effect */
    .btn-link.text-muted-custom {
        transition: color 0.2s ease;
    }

    .btn-link.text-muted-custom:hover {
        color: var(--color-tech-blue) !important;
    }

    /* Admin Profile Avatar Border */
    .border-info {
        border-color: var(--color-tech-blue) !important;
    }

</style>

<div class="container-fluid p-4" style = "padding: 0!important">

    <header class="d-flex justify-content-between align-items-center w-100 pb-4 mb-3 border-bottom border-secondary border-opacity-10" style="backdrop-blur: md;">
        <div class="position-relative w-100" style="max-width: 500px;">
            <span class="material-symbols-outlined position-absolute top-50 translate-middle-y text-muted-custom" style="left: 1rem;">search</span>
            <input class="form-control search-input-custom py-2" placeholder="Tìm kiếm huấn luyện viên, học viên..." type="text"/>
        </div>

        <div class="d-flex align-items-center gap-3">
            <button class="btn btn-link position-relative text-muted-custom p-2">
                <span class="material-symbols-outlined">notifications</span>
                <span class="position-absolute bg-danger rounded-circle border border-dark" style="width: 8px; height: 8px; top: 10px; right: 12px;"></span>
            </button>
            <button class="btn btn-link text-muted-custom p-2">
                <span class="material-symbols-outlined">mail</span>
            </button>
            <div class="bg-secondary bg-opacity-25" style="width: 1px; height: 24px; margin: 0 8px;"></div>

            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-lg-block">
                    <p class="mb-0 fw-bold text-white small" style="line-height: 1;">Admin Profile</p>
                    <p class="mb-0 text-muted-custom" style="font-size: 10px;">SUPER ADMIN</p>
                </div>
                <img alt="Admin Avatar" class="rounded-circle border border-2 border-info object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB90JPBkZ0LCipzTaJVK3FAbZgsPVq21pqaeIYDonCuaJTumyencFmIVqnlEq-LI1HOlGYYgPHeD3ZmUVmT2keHKWuDYwHViKK8T4-55zUi0jYCiEgmFK7C8Qh6IsGaRHfOfAeI0bgLKp6HBdTrbX8SkkIUSOLW0JNr8yr_ZP22JG9jyz_-cDulp-9grLRGulKeQbsWyEgL4JkZgx2SLJ0NiGWtgPiM6fyzF1XKb69FmXTi5zo_3K0nKoLmPNLQyQBYxPU_P9U9q7Q" style="width: 40px; height: 40px;"/>
            </div>
        </div>
    </header>
    <div class="d-flex flex-column flex-md-row align-items-md-end justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-white mb-0" style = "font-size: 25.596px!important;">Xác nhận thanh toán</h2>
            <p style = "color: #64748B !important;" class="text-muted-custom mb-0">Quản lý và phê duyệt các giao dịch tài chính hệ thống</p>
        </div>

        <div class="d-flex gap-2 align-items-center">
            <div class="bg-dark rounded-3 p-1 d-flex" style="background: var(--bg-surface) !important; border: 1px solid rgba(100, 116, 139, 0.15);">
                <button class="btn-tab active">Tất cả</button>
                <button class="btn-tab">Chờ duyệt</button>
                <button class="btn-tab">Hoàn tất</button>
            </div>
            <button class="btn btn-primary d-flex align-items-center gap-2 px-4 fw-bold shadow-none"
                    style="background-color: var(--color-primary); border: none; color: #000;">
                <span class="material-symbols-outlined">download</span> Xuất báo cáo
            </button>
        </div>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-12 col-md-4">
            <div class="bento-card d-flex align-items-center gap-3">
                <div class="icon-box"><span class="material-symbols-outlined">trending_up</span></div>
                <div>
                    <p class="text-muted small mb-0 text-uppercase" style="color: white!important; font-size: 10px; letter-spacing: 1px;">Doanh thu hôm nay</p>
                    <h4 class="fw-bold mb-0"><%= totalAmountForDay%></h4>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="bento-card d-flex align-items-center gap-3">
                <div class="icon-box" style="background: rgba(245, 158, 11, 0.1); color: #f59e0b;"><span class="material-symbols-outlined">pending_actions</span></div>
                <div>
                    <p class="text-muted small mb-0 text-uppercase" style="color: white!important; font-size: 10px; letter-spacing: 1px;">Chờ xử lý</p>
                    <h4 class="fw-bold mb-0"><%= totalPendingTrading%> đơn hàng</h4>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="bento-card d-flex align-items-center gap-3">
                <div class="icon-box" style="background: rgba(16, 185, 129, 0.1); color: #10b981;"><span class="material-symbols-outlined">verified</span></div>
                <div>
                    <p class="text-muted small mb-0 text-uppercase" style="color: white!important; font-size: 10px; letter-spacing: 1px;">Tỷ lệ duyệt thành công</p>
                    <h4 class="fw-bold mb-0"><%= String.format("%.2f", percentTradingCompleted)%>%</h4>
                </div>
            </div>
        </div>
    </div>
</div>
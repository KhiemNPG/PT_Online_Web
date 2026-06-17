<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<header class="d-flex justify-content-between align-items-center w-100 pb-4 mb-4 border-bottom border-secondary border-opacity-10">
    <div class="position-relative w-100" style="max-width: 500px;">
        <span class="material-symbols-outlined position-absolute top-50 translate-middle-y text-muted-custom" style="left: 1rem;">search</span>
        <input class="form-control search-input-custom py-2" placeholder="Tìm kiếm huấn luyện viên, học viên..." type="text"/>
    </div>

    <div class="d-flex align-items-center gap-3">
        <button class="btn btn-link position-relative text-muted-custom p-2">
            <span class="material-symbols-outlined">notifications</span>
            <span class="notification-dot"></span>
        </button>
        <button class="btn btn-link text-muted-custom p-2">
            <span class="material-symbols-outlined">mail</span>
        </button>
        <div class="divider-vertical"></div>

        <div class="d-flex align-items-center gap-3">
            <div class="text-end d-none d-lg-block">
                <p class="mb-0 fw-bold text-white small" style="line-height: 1;">Admin Profile</p>
                <p class="mb-0 text-muted-custom" style="font-size: 10px;">SUPER ADMIN</p>
            </div>
            <img alt="Admin Avatar" class="rounded-circle border border-2 border-info object-cover"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuB90JPBkZ0LCipzTaJVK3FAbZgsPVq21pqaeIYDonCuaJTumyencFmIVqnlEq-LI1HOlGYYgPHeD3ZmUVmT2keHKWuDYwHViKK8T4-55zUi0jYCiEgmFK7C8Qh6IsGaRHfOfAeI0bgLKp6HBdTrbX8SkkIUSOLW0JNr8yr_ZP22JG9jyz_-cDulp-9grLRGulKeQbsWyEgL4JkZgx2SLJ0NiGWtgPiM6fyzF1XKb69FmXTi5zo_3K0nKoLmPNLQyQBYxPU_P9U9q7Q"
                 style="width: 40px; height: 40px;"/>
        </div>
    </div>
</header>

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
    <div>
        <h2 class="text-white fw-bold mb-1" style="font-size: 1.5rem; line-height: 1.2;">
            Báo Cáo Doanh Thu
        </h2>
        <p class="text-muted mb-0" style="color: #64748B!important; font-size: 16px!important;">
            Thống kê và phân tích doanh thu từ các giao dịch thanh toán
        </p>
    </div>

    <div class="d-flex align-items-center gap-3">
        <!-- Date Range Selector -->
        <div class="d-flex align-items-center bg-dark-input border border-secondary border-opacity-20 rounded-3 px-3 py-2 gap-2"
             style="cursor: pointer;"
             data-bs-toggle="dropdown">
            <span class="material-symbols-outlined text-muted" style="font-size: 18px;">calendar_month</span>
            <span class="text-white fw-medium small" style="white-space: nowrap;" id="monthDisplay">Tháng 10/2023</span>
            <span class="material-symbols-outlined text-muted" style="font-size: 18px;">expand_more</span>

            <!-- Dropdown Menu với 12 tháng -->
            <ul class="dropdown-menu dropdown-menu-end border border-secondary border-opacity-20 rounded-3 mt-2 shadow-lg"
                style="min-width: 250px; background-color: var(--bg-surface); max-height: 400px; overflow-y: auto;">
                <li class="px-3 py-2">
                    <small class="text-muted text-uppercase fw-bold" style="font-size: 0.7rem;">Chọn tháng</small>
                </li>
                <li><hr class="dropdown-divider border-secondary border-opacity-20"></li>

                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href=""
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=1&year=2026'; return false;">
                        Tháng 1/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=2&year=2026'; return false;">
                        Tháng 2/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=3&year=2026'; return false;">
                        Tháng 3/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=4&year=2026'; return false;">
                        Tháng 4/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=5&year=2026'; return false;">
                        Tháng 5/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=6&year=2026'; return false;">
                        Tháng 6/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=7&year=2026'; return false;">
                        Tháng 7/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=8&year=2026'; return false;">
                        Tháng 8/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=9&year=2026'; return false;">
                        Tháng 9/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=10&year=2026'; return false;">
                        Tháng 10/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=11&year=2026'; return false;">
                        Tháng 11/2026
                    </a>
                </li>
                <li>
                    <a class="dropdown-item text-white small py-2 px-3" href="#"
                       onclick="window.location.href='${pageContext.request.contextPath}/admin/revenue?month=12&year=2026'; return false;">
                        Tháng 12/2026
                    </a>
                </li>
            </ul>
        </div>

        <!-- Export Button -->
        <button class="btn btn-add-custom px-4 py-2 d-flex align-items-center gap-2" type="button">
            <span class="material-symbols-outlined">download</span>
            <span>Xuất Báo Cáo</span>
        </button>
    </div>
</div>

<script>
    // Highlight tháng hiện tại khi load trang
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        const selectedMonth = urlParams.get('month');
        const selectedYear = urlParams.get('year') || 2026;

        if (selectedMonth) {
            // Update display text
            document.getElementById('monthDisplay').textContent = 'Tháng ' + selectedMonth + '/' + selectedYear;

            // Highlight active month in dropdown
            document.querySelectorAll('.dropdown-item').forEach(item => {
                item.classList.remove('active');
                const onclickAttr = item.getAttribute('onclick');
                if (onclickAttr && onclickAttr.includes('month=' + selectedMonth)) {
                    item.classList.add('active');
                }
            });
        }
    });
</script>

<style>
    /* Additional styles for dropdown */
    .dropdown-menu {
        background-color: var(--bg-surface) !important;
        border: 1px solid var(--border-color-strong) !important;
        border-radius: 0.75rem !important;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.4) !important;
    }

    .dropdown-item {
        color: var(--text-primary) !important;
        transition: all 0.2s ease;
    }

    .dropdown-item:hover {
        background-color: rgba(56, 189, 248, 0.1) !important;
        color: var(--color-tech-blue) !important;
    }

    .dropdown-divider {
        border-color: var(--border-color-strong) !important;
    }

    .bg-dark-input {
        background-color: var(--bg-input) !important;
    }

    .border-secondary {
        border-color: rgba(100, 116, 139, 0.2) !important;
    }

    /* ============================================
           HEADER - THANH TÌM KIẾM & AVATAR
           ============================================ */
        .search-input-custom {
            background-color: var(--bg-input) !important;
            border: 1px solid var(--border-color-strong) !important;
            color: var(--text-primary) !important;
            border-radius: 50px !important;
            padding-left: 2.75rem !important;
        }

        .search-input-custom::placeholder {
            color: rgba(100, 116, 139, 0.6);
        }

        .search-input-custom:focus {
            background-color: var(--bg-input) !important;
            border-color: var(--color-tech-blue) !important;
            color: var(--text-primary) !important;
            box-shadow: 0 0 0 0.2rem rgba(56, 189, 248, 0.25) !important;
        }

        .text-muted-custom {
            color: var(--text-muted);
            transition: color 0.2s ease;
        }

        .text-muted-custom:hover {
            color: var(--text-primary);
        }

        .divider-vertical {
            width: 1px;
            height: 24px;
            background-color: rgba(148, 163, 184, 0.2);
            margin: 0 8px;
        }

        .notification-dot {
            width: 8px;
            height: 8px;
            background-color: var(--color-danger);
            border-radius: 50%;
            position: absolute;
            top: 10px;
            right: 12px;
            border: 2px solid var(--bg-main);
        }
</style>

<style>
    .dropdown-item.active {
        background-color: rgba(56, 189, 248, 0.2) !important;
        color: var(--color-tech-blue) !important;
        font-weight: 600;
    }

    .dropdown-item:hover {
        background-color: rgba(56, 189, 248, 0.1) !important;
        color: var(--color-tech-blue) !important;
    }

    .dropdown-menu {
        background-color: var(--bg-surface) !important;
    }
</style>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="model.payment.PaymentTransaction" %>
<%
// ✅ Lấy dữ liệu từ Servlet
Object totalRevenueBuyProAccountObj = request.getAttribute("totalRevenueBuyProAccount");
double totalRevenueBuyProAccount = (totalRevenueBuyProAccountObj != null) ? (Double) totalRevenueBuyProAccountObj : 0;

Object totalAmountObj = request.getAttribute("totalAmount");
double totalAmount = (totalAmountObj != null) ? (Double) totalAmountObj : 0;

// ✅ Tính tổng doanh thu thuê PT
double totalRevenueBuyRentPT = totalAmount - totalRevenueBuyProAccount;

// ✅ Tổng số giao dịch
Object totalTransactionObj = request.getAttribute("totalTransaction");
int totalTransaction = (totalTransactionObj != null) ? (Integer) totalTransactionObj : 0;

// ✅ Tổng số giao dịch Pro
Object totalTransactionByProAccountObj = request.getAttribute("totalTransactionByProAccount");
int totalTransactionByProAccount = (totalTransactionByProAccountObj != null) ? (Integer) totalTransactionByProAccountObj : 0;

// ✅ Tính phần trăm doanh thu
double percentProRevenue = 0;
double percentRentPTRevenue = 0;
if (totalAmount > 0) {
percentProRevenue = (totalRevenueBuyProAccount / totalAmount) * 100;
percentRentPTRevenue = (totalRevenueBuyRentPT / totalAmount) * 100;
}

// ✅ Tính phần trăm số giao dịch
double percentProTransactions = 0;
if (totalTransaction > 0) {
percentProTransactions = (totalTransactionByProAccount / (double) totalTransaction) * 100;
}

// ✅ Format tiền tệ
DecimalFormat moneyFormat = new DecimalFormat("#,###");
String totalAmountFormatted = moneyFormat.format(totalAmount) + "₫";
String totalRevenueBuyProAccountFormatted = moneyFormat.format(totalRevenueBuyProAccount) + "₫";
String totalRevenueBuyRentPTFormatted = moneyFormat.format(totalRevenueBuyRentPT) + "₫";

// ✅ Format phần trăm
DecimalFormat percentFormat = new DecimalFormat("#.#");
String percentProRevenueFormatted = percentFormat.format(percentProRevenue) + "%";
String percentRentPTRevenueFormatted = percentFormat.format(percentRentPTRevenue) + "%";
String percentProTransactionsFormatted = percentFormat.format(percentProTransactions) + "%";
%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        /* ============================================
           HỆ THỐNG MÀU SẮC ĐỒNG BỘ
           ============================================ */
        :root {
            --bg-main: #0b0f19;
            --bg-surface: #111622;
            --bg-input: #171e2e;
            --border-color: rgba(100, 116, 139, 0.15);
            --border-color-strong: rgba(100, 116, 139, 0.2);
            --border-color-hover: rgba(100, 116, 139, 0.3);
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --text-muted: #64748b;
            --color-primary: #10b981;
            --color-tech-blue: #38bdf8;
            --color-success: #10b981;
            --color-warning: #fbbf24;
            --color-danger: #ef4444;
            --color-purple: #8b5cf6;
        }

        body {
            background-color: var(--bg-main);
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
        }

        .bento-card {
            background-color: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: 1rem;
            padding: 1.5rem;
            transition: all 0.2s ease;
        }

        .bento-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
            border-color: var(--border-color-hover);
        }

        .text-white-50 {
            color: var(--text-secondary) !important;
        }

        .text-muted {
            color: var(--text-muted) !important;
        }

        .stat-label {
            color: var(--text-muted);
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            color: var(--text-primary);
            font-size: 1.875rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .icon-wrapper {
            padding: 0.75rem;
            border-radius: 0.75rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .icon-primary {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--color-primary);
        }

        .icon-tech {
            background-color: rgba(56, 189, 248, 0.1);
            color: var(--color-tech-blue);
        }

        .icon-success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--color-success);
        }

        .icon-warning {
            background-color: rgba(251, 191, 36, 0.1);
            color: var(--color-warning);
        }

        .icon-danger {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--color-danger);
        }

        .icon-purple {
            background-color: rgba(139, 92, 246, 0.1);
            color: var(--color-purple);
        }

        .trend-badge {
            font-size: 0.75rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.25rem 0.5rem;
            border-radius: 50px;
        }

        .trend-up {
            color: var(--color-success);
            background-color: rgba(16, 185, 129, 0.1);
        }

        .trend-down {
            color: var(--color-danger);
            background-color: rgba(239, 68, 68, 0.1);
        }

        .trend-stable {
            color: var(--text-secondary);
            background-color: rgba(148, 163, 184, 0.1);
            font-weight: 600;
        }

        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }

        .progress {
            background-color: rgba(100, 116, 139, 0.2);
            border-radius: 50px;
        }

        .transform-rotate {
            transform: rotate(-90deg);
        }

        .legend-box {
            width: 12px;
            height: 12px;
            border-radius: 2px;
            display: inline-block;
        }

        .space-y-4 > * + * {
            margin-top: 1rem;
        }

        .space-y-3 > * + * {
            margin-top: 0.75rem;
        }

        @media (max-width: 768px) {
            .stat-value {
                font-size: 1.5rem;
            }
            .bento-card {
                padding: 1.25rem;
            }
        }
    </style>
</head>
<body>

<div class="container-fluid p-4" style="padding: 0!important">

    <!-- Charts Section: Top Nguồn Thu + Phân Bổ Giao Dịch -->
    <div class="row g-4 mb-4">

        <!-- Left: Top Nguồn Thu -->
        <div class="col-12 col-lg-6">
            <div class="bento-card">
                <h4 class="text-white fw-bold mb-4" style="font-size: 1.125rem;">
                    <span class="material-symbols-outlined align-middle me-2" style="font-size: 20px;">leaderboard</span>
                    Top Nguồn Thu
                </h4>

                <div class="space-y-4">
                    <!-- Item 1: Gói Pro -->
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-white-50 small fw-medium">Gói Pro</span>
                            <span class="text-white fw-bold small"><%= totalRevenueBuyProAccountFormatted %></span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar"
                                 style="width: <%= percentProRevenueFormatted %>; background-color: var(--color-tech-blue);"></div>
                        </div>
                    </div>

                    <!-- Item 2: Thuê PT -->
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-white-50 small fw-medium">Thuê PT</span>
                            <span class="text-white fw-bold small"><%= totalRevenueBuyRentPTFormatted %></span>
                        </div>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar" role="progressbar"
                                 style="width: <%= percentRentPTRevenueFormatted %>; background-color: var(--color-purple);"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Phân Bổ Giao Dịch (Donut Chart) -->
        <div class="col-12 col-lg-6">
            <div class="bento-card">
                <h4 class="text-white fw-bold mb-3" style="font-size: 1.125rem;">
                    <span class="material-symbols-outlined align-middle me-2" style="font-size: 20px;">donut_large</span>
                    Phân Bổ Giao Dịch
                </h4>

                <div class="d-flex align-items-center gap-4">
                    <!-- Donut Chart SVG -->
                    <div class="position-relative flex-shrink-0">
                        <svg width="140" height="140" viewBox="0 0 36 36" style="transform: rotate(-90deg);">
                            <!-- Background circle -->
                            <circle cx="18" cy="18" r="15.9155" fill="transparent"
                                    stroke="rgba(100, 116, 139, 0.2)"
                                    stroke-width="3.5"></circle>

                            <!-- Segment 1: Gói Pro (dynamic %) -->
                            <circle cx="18" cy="18" r="15.9155" fill="transparent"
                                    stroke="#38bdf8" stroke-width="3.5"
                                    stroke-dasharray="<%= percentProRevenue %>, 100"
                                    stroke-dashoffset="0"
                                    stroke-linecap="round"></circle>

                            <!-- Segment 2: Thuê PT (chỉ vẽ nếu > 0%) -->
                            <% if (percentRentPTRevenue > 0) { %>
                            <circle cx="18" cy="18" r="15.9155" fill="transparent"
                                    stroke="#8b5cf6" stroke-width="3.5"
                                    stroke-dasharray="<%= percentRentPTRevenue %>, 100"
                                    stroke-dashoffset="-<%= percentProRevenue %>"
                                    stroke-linecap="round"></circle>
                            <% } %>
                        </svg>

                        <!-- Center Text -->
                        <div class="position-absolute top-50 start-50 translate-middle text-center" style="transform: translate(-50%, -50%);">
                            <p class="text-white fw-bold mb-0" style="font-size: 1.5rem; line-height: 1;"><%= totalTransaction %></p>
                            <p class="text-muted mb-0" style="font-size: 0.6rem; text-transform: uppercase; letter-spacing: 0.05em;">Tổng lượt</p>
                        </div>
                    </div>

                    <!-- Legend (bên phải) -->
                    <div class="flex-grow-1">
                        <div class="d-flex flex-column gap-2">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="legend-box" style="background-color: #38bdf8;"></span>
                                    <span class="text-white-50 small">Gói Pro</span>
                                </div>
                                <span class="text-white fw-bold small"><%= percentProRevenueFormatted %></span>
                            </div>

                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="legend-box" style="background-color: #8b5cf6;"></span>
                                    <span class="text-white-50 small">Thuê PT</span>
                                </div>
                                <span class="text-white fw-bold small"><%= percentRentPTRevenueFormatted %></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>
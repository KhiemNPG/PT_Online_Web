<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="model.payment.PaymentTransaction" %>
<%
// ✅ Format tiền tệ
DecimalFormat moneyFormat = new DecimalFormat("#,###");

// ✅ Lấy tổng doanh thu (tất cả thời gian)
Object totalAmountObj = request.getAttribute("totalAmount");
double totalAmount = (totalAmountObj != null) ? (Double) totalAmountObj : 0;

// ✅ Lấy tổng giao dịch thành công (tất cả thời gian)
Object totalSuccessTradingObj = request.getAttribute("TotalSuccessTrading");
int totalSuccessTrading = (totalSuccessTradingObj != null) ? (Integer) totalSuccessTradingObj : 0;

Object totalTransactionObj = request.getAttribute("totalTransaction");
int totalTransaction = (totalTransactionObj != null) ? (Integer) totalTransactionObj : 0;

// ✅ Lấy danh sách giao dịch theo tháng/năm (doanh thu)
List< PaymentTransaction> revenueListForMonthAndYear = (List< PaymentTransaction>) request.getAttribute("revenueListForMonthAndYear");
if (revenueListForMonthAndYear == null) {
revenueListForMonthAndYear = new ArrayList<>();
}

// ✅ Tính tổng doanh thu tháng (check null an toàn)
double totalRevenueMonth = 0;
for (PaymentTransaction p : revenueListForMonthAndYear) {
if (p.getAmount() != null) {
totalRevenueMonth += p.getAmount().doubleValue();
}
}

// ✅ Lấy danh sách giao dịch theo tháng/năm (tất cả)
List
< PaymentTransaction> paymentTransactionForMonthAndYear =
    (List
    < PaymentTransaction>) request.getAttribute("paymentTransactionForMonthAndYear");
        if (paymentTransactionForMonthAndYear == null) {
        paymentTransactionForMonthAndYear = new ArrayList<>();
        }

        // ✅ Đếm số giao dịch tháng
        int totalTransactionMonth = paymentTransactionForMonthAndYear.size();

        // ✅ Format tiền cho hiển thị
        String totalAmountFormatted = moneyFormat.format(totalAmount) + "₫";
        String totalRevenueMonthFormatted = moneyFormat.format(totalRevenueMonth) + "₫";
        %>
        <html lang="vi">
        <head>
            <title>Admin Dashboard - PT Online</title>

            <style>
                /* Giữ nguyên CSS của bạn */
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
                    padding: 1.25rem;
                    transition: all 0.2s ease;
                }

                .bento-card:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
                    border-color: var(--border-color-hover);
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

                .trend-badge .material-symbols-outlined {
                    font-size: 14px;
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
                    margin-bottom: 0.25rem;
                }

                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    vertical-align: middle;
                }

                @media (max-width: 768px) {
                    .stat-value {
                        font-size: 1.5rem;
                    }

                    .bento-card {
                        padding: 1rem;
                    }
                }


                .stat-divider {
                    font-size: 1rem;
                    color: var(--text-muted);
                    font-weight: 500;
                    margin: 0 0.25rem;
                }

            </style>
        </head>
        <body>

        <div class="container-fluid p-4" style="padding: 0!important">

            <!-- Stats Cards -->
            <div class="row g-4 mb-4">
                <!-- Card 1: Total Revenue -->
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="bento-card h-100">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="icon-wrapper icon-primary">
                                <span class="material-symbols-outlined">payments</span>
                            </div>
                        </div>
                        <p class="stat-label">Tổng Doanh Thu</p>
                        <h3 class="stat-value"><%= totalAmountFormatted %></h3>
                    </div>
                </div>

                <!-- Card 2: Successful Transactions -->
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="bento-card h-100">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="icon-wrapper icon-success">
                                <span class="material-symbols-outlined">check_circle</span>
                            </div>
                        </div>
                        <p class="stat-label">Giao Dịch Thành Công</p>
                        <h3 class="stat-value">
                            <%= totalSuccessTrading %>
                            <span class="stat-divider">/ <%= totalTransaction %></span>
                        </h3>
                    </div>
                </div>

                <!-- Card 3: Tổng Doanh Thu Tháng Này -->
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="bento-card h-100">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="icon-wrapper icon-tech">
                                <span class="material-symbols-outlined">calendar_month</span>
                            </div>
                        </div>
                        <p class="stat-label">Doanh Thu Tháng Này</p>
                        <h3 class="stat-value"><%= totalRevenueMonthFormatted %></h3>
                    </div>
                </div>

                <!-- Card 4: Tổng Giao Dịch Tháng Này -->
                <div class="col-12 col-md-6 col-lg-3">
                    <div class="bento-card h-100">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="icon-wrapper icon-purple">
                                <span class="material-symbols-outlined">receipt_long</span>
                            </div>
                        </div>
                        <p class="stat-label">Giao Dịch Tháng Này</p>
                        <h3 class="stat-value"><%= totalTransactionMonth %></h3>
                    </div>
                </div>
            </div>
        </div>
        </body>
        </html>
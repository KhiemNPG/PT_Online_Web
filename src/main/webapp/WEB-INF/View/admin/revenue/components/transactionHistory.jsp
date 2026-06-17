<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.payment.PaymentTransaction" %>
<%
    List< PaymentTransaction> paymentTransactionForMonthAndYear = (List< PaymentTransaction>) request.getAttribute("paymentTransactionForMonthAndYear");
        if (paymentTransactionForMonthAndYear == null) {
        paymentTransactionForMonthAndYear = new ArrayList<>();
        }

        // ✅ Format tiền tệ và thời gian
        DecimalFormat moneyFormat = new DecimalFormat("#,###");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm - dd/MM");
        %>
        <html lang="vi">
        <head>
            <style>
                /* Giữ nguyên CSS của bạn */
                :root {
                    --bg-main: #0b0f19;
                    --bg-surface: #111622;
                    --bg-hover: rgba(100, 116, 139, 0.08);
                    --bg-variant: rgba(23, 30, 46, 0.5);
                    --border-color: rgba(100, 116, 139, 0.15);
                    --border-color-strong: rgba(100, 116, 139, 0.2);
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
                    font-size: 14px;
                }

                .bento-card {
                    background-color: var(--bg-surface);
                    border: 1px solid var(--border-color);
                    border-radius: 1rem;
                    padding: 1.5rem;
                    transition: all 0.2s ease;
                }

                .card-header-custom {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding-bottom: 1rem;
                    margin-bottom: 1rem;
                    border-bottom: 1px solid var(--border-color);
                }

                .card-title-custom {
                    color: var(--text-primary);
                    font-size: 1.125rem;
                    font-weight: 700;
                    margin: 0;
                }

                .btn-icon-custom {
                    width: 36px;
                    height: 36px;
                    padding: 0;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    background-color: transparent;
                    border: 1px solid var(--border-color-strong);
                    border-radius: 0.5rem;
                    color: var(--text-secondary);
                    transition: all 0.2s ease;
                }

                .btn-icon-custom:hover {
                    background-color: var(--bg-variant);
                    color: var(--text-primary);
                }

                .btn-icon-custom .material-symbols-outlined {
                    font-size: 18px;
                }

                .table-dark-custom {
                    width: 100%;
                    border-collapse: collapse;
                    margin-bottom: 0;
                }

                .table-dark-custom thead {
                    background-color: var(--bg-variant);
                }

                .table-dark-custom thead th {
                    color: var(--text-muted);
                    font-size: 0.625rem;
                    font-weight: 700;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                    padding: 0.875rem 1rem;
                    border: none;
                    white-space: nowrap;
                }

                .table-dark-custom tbody tr {
                    border-bottom: 1px solid rgba(100, 116, 139, 0.1);
                    transition: background-color 0.2s ease;
                }

                .table-dark-custom tbody tr:hover {
                    background-color: var(--bg-hover);
                }

                .table-dark-custom tbody tr:last-child {
                    border-bottom: none;
                }

                .table-dark-custom td {
                    padding: 1rem;
                    color: var(--text-primary);
                    font-size: 0.875rem;
                    vertical-align: middle;
                    border: none;
                }

                .table-dark-custom td.text-end {
                    text-align: right;
                }

                .order-code {
                    font-variant-numeric: tabular-nums;
                    font-size: 0.75rem;
                    color: var(--text-primary);
                }

                .user-cell {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                .user-avatar-img {
                    width: 32px;
                    height: 32px;
                    border-radius: 50%;
                    object-fit: cover;
                }

                .user-name {
                    font-weight: 600;
                    color: var(--text-primary);
                    font-size: 0.875rem;
                }

                .amount-cell {
                    font-weight: 700;
                    color: var(--color-success);
                    font-variant-numeric: tabular-nums;
                }

                .type-badge {
                    display: inline-block;
                    padding: 0.25rem 0.625rem;
                    border-radius: 0.375rem;
                    font-size: 0.625rem;
                    font-weight: 700;
                    text-transform: uppercase;
                }

                .type-buy-pro {
                    background-color: rgba(56, 189, 248, 0.1);
                    color: var(--color-tech-blue);
                }

                .type-rent-pt {
                    background-color: rgba(139, 92, 246, 0.1);
                    color: var(--color-purple);
                }

                .content-cell {
                    color: var(--text-secondary);
                    max-width: 150px;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                }

                .status-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.375rem;
                    padding: 0.25rem 0.75rem;
                    border-radius: 50px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    border: 1px solid;
                }

                .status-dot {
                    width: 6px;
                    height: 6px;
                    border-radius: 50%;
                    display: inline-block;
                }

                .status-success {
                    background-color: rgba(16, 185, 129, 0.1);
                    color: var(--color-success);
                    border-color: rgba(16, 185, 129, 0.2);
                }

                .status-success .status-dot {
                    background-color: var(--color-success);
                }

                .status-pending {
                    background-color: rgba(251, 191, 36, 0.1);
                    color: var(--color-warning);
                    border-color: rgba(251, 191, 36, 0.2);
                }

                .status-pending .status-dot {
                    background-color: var(--color-warning);
                }

                .status-failed {
                    background-color: rgba(239, 68, 68, 0.1);
                    color: var(--color-danger);
                    border-color: rgba(239, 68, 68, 0.2);
                }

                .status-failed .status-dot {
                    background-color: var(--color-danger);
                }

                .time-cell {
                    color: var(--text-secondary);
                    font-size: 0.875rem;
                }

                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    vertical-align: middle;
                }

                @media (max-width: 768px) {
                    .card-header-custom {
                        flex-direction: column;
                        align-items: flex-start;
                        gap: 1rem;
                    }

                    .table-responsive {
                        overflow-x: auto;
                        -webkit-overflow-scrolling: touch;
                    }
                }

                .table-responsive::-webkit-scrollbar {
                    height: 6px;
                }
                .table-responsive::-webkit-scrollbar-track {
                    background: var(--bg-surface);
                }
                .table-responsive::-webkit-scrollbar-thumb {
                    background: var(--border-color-strong);
                    border-radius: 3px;
                }
            </style>
        </head>
        <body>

        <div class="container-fluid p-4" style="padding: 0!important; margin-top: 2.5%">
            <div class="bento-card" id="transactionCard">

                <!-- Card Header -->
                <div class="card-header-custom">
                    <h4 class="card-title-custom">Lịch Sử Giao Dịch Gần Đây</h4>
                    <div class="d-flex gap-2">
                        <button class="btn-icon-custom" title="Lọc">
                            <span class="material-symbols-outlined">filter_list</span>
                        </button>
                        <button class="btn-icon-custom" title="Làm mới">
                            <span class="material-symbols-outlined">refresh</span>
                        </button>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="table-dark-custom">
                        <thead>
                        <tr>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Mã Đơn</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Học Viên</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Số Tiền</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Loại</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Nội Dung</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Trạng Thái</th>
                            <th scope="col" class="text-center" style="white-space: nowrap;">Thời Gian</th>
                        </tr>
                        </thead>
                        <tbody id="transactionTableBody">
                        <%
                        if (paymentTransactionForMonthAndYear != null && !paymentTransactionForMonthAndYear.isEmpty()) {
                        for (PaymentTransaction p : paymentTransactionForMonthAndYear) {
                        // ✅ Check null an toàn
                        String status = p.getStatus() != null ? p.getStatus() : "";
                        String type = p.getTransactionType() != null ? p.getTransactionType() : "";
                        String userName = (p.getUser() != null && p.getUser().getName() != null)
                        ? p.getUser().getName() : "N/A";

                        // ✅ Format tiền: 250000.00 → 250.000₫
                        String amountFormatted = moneyFormat.format(p.getAmount()) + "₫";

                        // ✅ Format thời gian: 2024-01-15 14:20:30 → 14:20 - 15/01
                        String timeFormatted = p.getCreatedAt() != null
                        ? timeFormat.format(p.getCreatedAt()) : "N/A";
                        %>
                        <tr>
                            <td class="order-code"><%= p.getOrderCode() %></td>
                            <td>
                                <div class="user-cell">
                                    <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAUSv6pvgzme0J7ZsLJ_WhTwl64MUI1cGBjSfgfZnj7_z0VLZxYjtVEthSqEaN692JdmlielrKtz4eqNG-UZOYbtJeiA-o4ACt997pLGuStTd_V3AHM9aG1lsFiF85nNGo-ONqO7wjbxHEsgRsQBKGqcUDZFBgKg6EasiQIiIwfy9iJPniLuD3p3gJy788p3lyUeUe_s2KtLMpNx0qBcDKt8Zd-RQBLPv_1i2gJgc4OgL3H9c6h0JrJUWNVTKc42qDdy5dZ9TtQNbk"
                                         alt="User" class="user-avatar-img">
                                    <span class="user-name"><%= userName %></span>
                                </div>
                            </td>
                            <td class="amount-cell"><%= amountFormatted %></td>
                            <td>
                                <% if ("BUY_PRO".equals(type)) { %>
                                <span class="type-badge type-buy-pro">BUY_PRO</span>
                                <% } else { %>
                                <span class="type-badge type-rent-pt">RENT_PT</span>
                                <% } %>
                            </td>
                            <td class="content-cell"><%= p.getTransferContent() != null ? p.getTransferContent() : ""
                                %>
                            </td>
                            <td class="text-center" style="white-space: nowrap;">
                                <% if ("SUCCESS".equals(status)) { %>
                                <span class="status-badge status-success">
                                <span class="status-dot"></span>
                                Thành công
                            </span>
                                <% } else if ("FAILED".equals(status)) { %>
                                <span class="status-badge status-failed">
                                <span class="status-dot"></span>
                                Thất bại
                            </span>
                                <% } else { %>
                                <span class="status-badge status-pending">
                                <span class="status-dot"></span>
                                Đang chờ
                            </span>
                                <% } %>
                            </td>
                            <td style="white-space: nowrap;" class="text-end time-cell"><%= timeFormatted %></td>
                        </tr>
                        <%
                        }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                Không có giao dịch nào trong tháng này.
                            </td>
                        </tr>
                        <%
                        }
                        %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

        </body>
        </html>
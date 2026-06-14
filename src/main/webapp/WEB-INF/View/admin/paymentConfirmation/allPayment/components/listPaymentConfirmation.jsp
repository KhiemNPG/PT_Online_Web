<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="model.payment.PaymentTransaction" %>
<%
    List< PaymentTransaction> paymentTransactionList = (List< PaymentTransaction>) request.getAttribute("listPaymentTransactionList");
    if (paymentTransactionList == null) {
        paymentTransactionList = new ArrayList<>();
    }
%>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            background-color: #0f172a;
            font-family: 'Inter', sans-serif;
            color: #e2e8f0;
        }

        .page-header {
            background-color: #1e293b;
            padding: 20px 30px;
            border-radius: 12px;
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #f1f5f9;
            margin-bottom: 0;
        }

        .btn-primary-custom {
            background-color: #3b82f6;
            border: none;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 14px;
        }

        .btn-primary-custom:hover {
            background-color: #2563eb;
            color: white;
        }

        .filter-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .filter-label {
            color: #94a3b8;
            font-size: 13px;
        }

        .form-select-dark {
            background-color: #1e293b;
            border: 1px solid #334155;
            color: #e2e8f0;
            font-size: 13px;
            padding: 6px 12px;
            border-radius: 6px;
        }

        .form-select-dark:focus {
            background-color: #1e293b;
            border-color: #3b82f6;
            color: #e2e8f0;
            box-shadow: none;
        }

        .transaction-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
        }

        .transaction-table thead th {
            text-transform: uppercase;
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            padding: 12px 20px;
            text-align: left;
            border: none;
        }

        .transaction-row {
            background-color: #1e293b;
            border: 1px solid #334155;
            border-radius: 12px;
            transition: all 0.2s;
        }

        .transaction-row:hover {
            background-color: #334155;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        }

        .transaction-row td {
            padding: 16px 20px;
            border: none;
            color: #e2e8f0;
            font-size: 14px;
            font-weight: 500;
        }

        .transaction-row td:first-child {
            border-radius: 12px 0 0 12px;
        }

        .transaction-row td:last-child {
            border-radius: 0 12px 12px 0;
        }

        .txn-id {
            color: #3b82f6;
            font-weight: 600;
            font-size: 14px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 14px;
        }

        .user-avatar.green {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        .user-name {
            font-weight: 600;
            color: #f1f5f9;
            font-size: 14px;
        }

        .user-role {
            font-size: 12px;
            color: #94a3b8;
        }

        .order-code {
            font-weight: 500;
            color: #cbd5e1;
        }

        .amount {
            color: #fbbf24;
            font-weight: 600;
            font-size: 15px;
        }

        .type-badge {
            background-color: #0f172a;
            color: #f1f5f9;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .transfer-content {
            color: #94a3b8;
            font-size: 13px;
            font-family: monospace;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-pending {
            background-color: #451a03;
            color: #fbbf24;
        }

        .status-success {
            background-color: #052e16;
            color: #10b981;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            display: inline-block;
        }

        .status-pending .status-dot {
            background-color: #fbbf24;
        }

        .status-success .status-dot {
            background-color: #10b981;
        }

        .action-btn {
            background: none;
            border: none;
            padding: 6px;
            cursor: pointer;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .action-btn:hover {
            background-color: #475569;
        }

        .action-btn.approve {
            color: #10b981;
        }

        .action-btn.reject {
            color: #ef4444;
        }

        .action-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .processed-text {
            color: #94a3b8;
            font-size: 13px;
        }

        .checkbox-custom {
            width: 18px;
            height: 18px;
            border: 2px solid #475569;
            border-radius: 4px;
            cursor: pointer;
            background-color: transparent;
        }

        .checkbox-custom:checked {
            background-color: #3b82f6;
            border-color: #3b82f6;
        }
    </style>
</head>
<body>
<div class="container-fluid py-4 px-4" style = "padding: 0!Important">

    <!-- Transaction Table -->
    <div class="table-responsive">
        <table class="transaction-table" style="border: 1px solid #ffffff; border-radius: 12px;">
            <thead>
            <tr>
                <th scope="col" class="text-center" style="white-space: nowrap;">ID</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Người Gửi</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Mã Đơn</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Số Tiền</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Loại GD</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Nội dung CK</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Trạng thái</th>
                <th scope="col" class="text-center" style="white-space: nowrap;">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <%
            if (paymentTransactionList != null && !paymentTransactionList.isEmpty()) {
            for (PaymentTransaction p : paymentTransactionList) {
            String userName = (p.getUser() != null && p.getUser().getName() != null)
            ? p.getUser().getName() : "Unknown";
            String userInitial = (!userName.isEmpty())
            ? userName.substring(0, 1).toUpperCase() : "?";

            // Check null cho các field khác
            String status = (p.getStatus() != null) ? p.getStatus() : "";
            String amount = (p.getAmount() != null)
            ? String.format("%,.0f₫", p.getAmount().doubleValue()) : "0₫";
            String transferContent = (p.getTransferContent() != null)
            ? p.getTransferContent() : "";
            %>
            <tr class="transaction-row">
                <td>
                    <span class="txn-id"><%= p.getTransactionId() %></span>
                </td>
                <td>
                    <div class="user-info">
                        <div class="user-avatar"><%= userInitial %></div>
                        <div>
                            <div class="user-name"><%= userName %></div>
                        </div>
                    </div>
                </td>
                <td>
                    <span class="order-code"><%= p.getOrderCode() %></span>
                </td>
                <td>
                    <span class="amount"><%= amount %></span>
                </td>
                <td>
                <span class="type-badge">
                    <%= "BUY_PRO".equals(p.getTransactionType()) ? "Nâng cấp PRO" : "Đăng ký PT" %>
                </span>
                </td>
                <td>
                    <span class="transfer-content"><%= (transferContent != "") ? transferContent : "Chưa xác nhận"%></span>
                </td>
                <td>
                    <% if ("PENDING_APPROVAL".equals(status) || "PENDING_TRADING".equals(status)) { %>
                    <span class="status-badge status-pending">
                <span class="status-dot"></span>
                PENDING
            </span>
                    <% } else if ("SUCCESS".equals(status)) { %>
                    <span class="status-badge status-success">
                <span class="status-dot"></span>
                SUCCESS
            </span>
                    <% } else { %>
                    <span class="status-badge">
                <span class="status-dot"></span>
                <%= status %>
            </span>
                    <% } %>
                </td>
                <td class="text-center">
                    <% if ("PENDING_APPROVAL".equals(status) || "PENDING_TRADING".equals(status)) { %>
                    <!-- Form Duyệt -->
                    <form action="${pageContext.request.contextPath}/admin/transactions"
                          method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="transactionId" value="<%= p.getTransactionId() %>">
                        <button type="submit" class="action-btn approve" title="Duyệt"
                                onclick="return confirm('Xác nhận duyệt giao dịch này?');">
                            <i class="bi bi-check-circle-fill fs-5"></i>
                        </button>
                    </form>

                    <!-- Form Từ chối -->
                    <form action="${pageContext.request.contextPath}/admin/transactions"
                          method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="transactionId" value="<%= p.getTransactionId() %>">
                        <button type="submit" class="action-btn reject" title="Từ chối"
                                onclick="return confirm('Bạn có chắc muốn từ chối giao dịch này?');">
                            <i class="bi bi-x-circle-fill fs-5"></i>
                        </button>
                    </form>
                    <% } else { %>
                    <span class="processed-text">Đã xử lý</span>
                    <% } %>
                </td>
            </tr>
            <%
            }
            } else {
            %>
            <tr>
                <td colspan="7" class="text-center text-muted py-4">
                    Không có giao dịch nào!.
                </td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>
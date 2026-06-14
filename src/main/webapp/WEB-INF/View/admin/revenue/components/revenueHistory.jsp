<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="model.payment.PaymentTransaction" %>
<%
List< PaymentTransaction> revenueListForMonthAndYear = (List< PaymentTransaction>) request.getAttribute("revenueListForMonthAndYear");
    if (revenueListForMonthAndYear == null) {
    revenueListForMonthAndYear = new ArrayList<>();
    }
    %>
    <html lang="vi">
    <head>
        <style>
            /* Giữ nguyên CSS của bạn */
            :root {
                --bg-main: #0b0f19;
                --bg-surface: #111622;
                --bg-input: #171e2e;
                --bg-hover: rgba(100, 116, 139, 0.08);
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
                font-size: 14px;
            }

            .bento-card {
                background-color: var(--bg-surface);
                border: 1px solid var(--border-color);
                border-radius: 1rem;
                padding: 1.5rem;
                transition: all 0.2s ease;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .section-title {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--text-primary);
                font-size: 1.125rem;
                font-weight: 700;
                margin: 0;
            }

            .section-title .material-symbols-outlined {
                color: var(--color-tech-blue);
                font-size: 22px;
            }

            .header-actions {
                display: flex;
                flex-wrap: wrap;
                gap: 0.75rem;
                align-items: center;
            }

            .search-wrapper {
                position: relative;
                flex: 1;
                min-width: 200px;
                max-width: 320px;
            }

            .search-wrapper .material-symbols-outlined {
                position: absolute;
                left: 0.75rem;
                top: 50%;
                transform: translateY(-50%);
                color: var(--text-muted);
                font-size: 18px;
                pointer-events: none;
            }

            .search-input {
                width: 100%;
                background-color: rgba(23, 30, 46, 0.5);
                border: 1px solid var(--border-color-strong);
                color: var(--text-primary);
                border-radius: 0.5rem;
                padding: 0.5rem 1rem 0.5rem 2.5rem;
                font-size: 0.875rem;
                transition: all 0.2s ease;
            }

            .search-input::placeholder {
                color: var(--text-muted);
            }

            .search-input:focus {
                outline: none;
                background-color: var(--bg-input);
                border-color: var(--color-tech-blue);
                box-shadow: 0 0 0 0.2rem rgba(56, 189, 248, 0.15);
            }

            .btn-add-revenue {
                background-color: var(--color-tech-blue);
                color: var(--bg-main);
                border: none;
                border-radius: 0.75rem;
                padding: 0.5rem 1rem;
                font-weight: 700;
                font-size: 0.875rem;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                transition: all 0.2s ease;
                white-space: nowrap;
                cursor: pointer;
            }

            .btn-add-revenue:hover {
                background-color: #0ea5e9;
                color: var(--text-primary);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(56, 189, 248, 0.3);
            }

            .btn-add-revenue .material-symbols-outlined {
                font-size: 20px;
            }

            .table-dark-custom {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 0;
            }

            .table-dark-custom thead {
                background-color: rgba(23, 30, 46, 0.5);
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

            .stt-cell {
                font-weight: 700;
                color: var(--text-primary);
                font-variant-numeric: tabular-nums;
            }

            .source-user {
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .user-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 0.75rem;
                flex-shrink: 0;
            }

            .avatar-blue {
                background-color: rgba(56, 189, 248, 0.2);
                color: var(--color-tech-blue);
            }

            .user-info {
                min-width: 0;
            }

            .user-name {
                font-weight: 600;
                color: var(--text-primary);
                font-size: 0.875rem;
                margin-bottom: 0.125rem;
            }

            .user-order {
                font-size: 0.625rem;
                color: var(--text-muted);
                margin: 0;
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

            .amount-cell {
                font-weight: 700;
                color: var(--color-success);
                font-variant-numeric: tabular-nums;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
                padding: 0.25rem 0.625rem;
                border-radius: 50px;
                font-size: 0.625rem;
                font-weight: 600;
                border: 1px solid;
            }

            .status-success {
                background-color: rgba(16, 185, 129, 0.1);
                color: var(--color-success);
                border-color: rgba(16, 185, 129, 0.2);
            }

            .status-pending {
                background-color: rgba(251, 191, 36, 0.1);
                color: var(--color-warning);
                border-color: rgba(251, 191, 36, 0.2);
            }

            .status-failed {
                background-color: rgba(239, 68, 68, 0.1);
                color: var(--color-danger);
                border-color: rgba(239, 68, 68, 0.2);
            }

            .btn-action-view {
                background: none;
                border: none;
                color: var(--text-secondary);
                padding: 0.375rem;
                border-radius: 0.375rem;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }

            .btn-action-view:hover {
                color: var(--color-tech-blue);
                background-color: rgba(56, 189, 248, 0.1);
            }

            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                vertical-align: middle;
            }

            /* Modal Styles */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.75);
                backdrop-filter: blur(4px);
                display: none;
                align-items: center;
                justify-content: center;
                z-index: 9999;
            }

            .modal-overlay.show {
                display: flex;
            }

            .modal-content {
                background-color: var(--bg-surface);
                border: 1px solid var(--border-color);
                border-radius: 1rem;
                width: 90%;
                max-width: 600px;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.25rem 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }

            .modal-title {
                color: var(--text-primary);
                font-size: 1.125rem;
                font-weight: 700;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .modal-title .material-symbols-outlined {
                color: var(--color-tech-blue);
            }

            .btn-close-modal {
                background: none;
                border: none;
                color: var(--text-secondary);
                font-size: 24px;
                cursor: pointer;
                padding: 0;
                line-height: 1;
                transition: color 0.2s;
            }

            .btn-close-modal:hover {
                color: var(--text-primary);
            }

            .modal-body {
                padding: 1.5rem;
            }

            .form-group {
                margin-bottom: 1rem;
            }

            .form-label {
                display: block;
                font-size: 0.75rem;
                font-weight: 600;
                color: var(--text-secondary);
                margin-bottom: 0.375rem;
            }

            .form-label .required {
                color: var(--color-danger);
            }

            .form-control-custom {
                width: 100%;
                background-color: var(--bg-input);
                border: 1px solid var(--border-color-strong);
                color: var(--text-primary);
                border-radius: 0.5rem;
                padding: 0.5rem 0.875rem;
                font-size: 0.875rem;
                transition: all 0.2s ease;
            }

            .form-control-custom::placeholder {
                color: var(--text-muted);
            }

            .form-control-custom:focus {
                outline: none;
                border-color: var(--color-tech-blue);
                box-shadow: 0 0 0 0.2rem rgba(56, 189, 248, 0.15);
            }

            textarea.form-control-custom {
                resize: vertical;
                min-height: 80px;
            }

            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1rem;
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 0.75rem;
                padding: 1.25rem 1.5rem;
                border-top: 1px solid var(--border-color);
            }

            .btn-cancel {
                background-color: transparent;
                border: 1px solid var(--border-color-strong);
                color: var(--text-secondary);
                padding: 0.5rem 1.5rem;
                border-radius: 0.75rem;
                font-weight: 700;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .btn-cancel:hover {
                background-color: var(--bg-input);
                color: var(--text-primary);
            }

            .btn-submit {
                background-color: var(--color-primary);
                border: none;
                color: white;
                padding: 0.5rem 1.5rem;
                border-radius: 0.75rem;
                font-weight: 700;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-submit:hover {
                background-color: #059669;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            }

            @media (max-width: 768px) {
                .form-row {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>

    <div class="container-fluid p-4" style="padding: 0!important;">
        <div class="bento-card">

            <!-- Header Section -->
            <div class="section-header">
                <h4 class="section-title">
                    <span class="material-symbols-outlined">history</span>
                    Lịch Sử Doanh Thu
                </h4>

                <div class="header-actions">
                    <div class="search-wrapper">
                        <span class="material-symbols-outlined">search</span>
                        <input type="text" class="search-input" placeholder="Tìm kiếm...">
                    </div>

                    <button class="btn-add-revenue" type="button" onclick="openModal()">
                        <span class="material-symbols-outlined">add_circle</span>
                        <span>Nhập Doanh Thu</span>
                    </button>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table-dark-custom">
                    <thead>
                    <tr>
                        <th scope="col" class="text-center">STT</th>
                        <th scope="col" class="text-center">Thời Gian</th>
                        <th scope="col" class="text-center">Nguồn Thu</th>
                        <th scope="col" class="text-center">Loại</th>
                        <th scope="col" class="text-center">Số Tiền</th>
                        <th scope="col" class="text-center">Trạng Thái</th>
                        <th scope="col" class="text-center">Thao Tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                    if (revenueListForMonthAndYear != null && !revenueListForMonthAndYear.isEmpty()) {
                    int stt = 1;
                    for (PaymentTransaction p : revenueListForMonthAndYear) {
                    %>
                    <tr>
                        <td class="text-center stt-cell"><%= stt++ %></td>
                        <td class="text-center text-muted"><%= p.getCreatedAt() %></td>
                        <td>
                            <div class="source-user">
                                <div class="user-avatar avatar-blue">
                                    <%= p.getUser() != null && p.getUser().getName() != null ? p.getUser().getName().substring(0, Math.min(2, p.getUser().getName().length())).toUpperCase() : "NV" %>
                                </div>
                                <div class="user-info">
                                    <div class="user-name"><%= p.getUser() != null ? p.getUser().getName() : "N/A" %></div>
                                    <p class="user-order">#<%= p.getOrderCode() %></p>
                                </div>
                            </div>
                        </td>
                        <td class="text-center">
                            <%
                            if ("BUY_PRO".equals(p.getTransactionType())) {
                            %>
                            <span class="type-badge type-buy-pro">BUY_PRO</span>
                            <%
                            } else {
                            %>
                            <span class="type-badge type-rent-pt">RENT_PT</span>
                            <%
                            }
                            %>
                        </td>
                        <td class="text-center amount-cell">+<%= String.format("%,.0f", p.getAmount()) %>₫</td>
                        <td class="text-center">
                            <%
                            String status = p.getStatus();
                            String statusClass = "status-pending";
                            String statusText = "Đang chờ";

                            if ("SUCCESS".equals(status)) {
                            statusClass = "status-success";
                            statusText = "Thành công";
                            } else if ("FAILED".equals(status)) {
                            statusClass = "status-failed";
                            statusText = "Thất bại";
                            }
                            %>
                            <span class="status-badge <%= statusClass %>"><%= statusText %></span>
                        </td>
                        <td class="text-end">
                            <button class="btn-action-view" title="Xem chi tiết">
                                <span class="material-symbols-outlined">visibility</span>
                            </button>
                        </td>
                    </tr>
                    <%
                    }
                    } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            Không có doanh thu nào trong tháng này.
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

    <!-- Modal Nhập Doanh Thu -->
    <div class="modal-overlay" id="addRevenueModal">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <span class="material-symbols-outlined">add_circle</span>
                    Nhập Doanh Thu Mới
                </h5>
                <button class="btn-close-modal" onclick="closeModal()">&times;</button>
            </div>

            <form id="addRevenueForm" action="${pageContext.request.contextPath}/admin/revenue" method="POST">
                <div class="modal-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                User ID <span class="required">*</span>
                            </label>
                            <input type="number" class="form-control-custom" name="userId" required
                                   placeholder="Ví dụ: 1">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                Mã đơn hàng <span class="required">*</span>
                            </label>
                            <input type="number" class="form-control-custom" name="orderCode" required
                                   placeholder="Ví dụ: 123456789">
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">
                                Số tiền (VNĐ) <span class="required">*</span>
                            </label>
                            <input type="number" step="0.01" class="form-control-custom" name="amount" required
                                   placeholder="Ví dụ: 250000">
                        </div>
                        <div class="form-group">
                            <label class="form-label">
                                Loại giao dịch <span class="required">*</span>
                            </label>
                            <select class="form-control-custom" name="transactionType" required>
                                <option value="BUY_PRO">Mua gói Pro</option>
                                <option value="RENT_PT">Thuê PT</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Trạng thái <span class="required">*</span>
                        </label>
                        <select class="form-control-custom" name="status" required>
                            <option value="PENDING_APPROVAL">Chờ duyệt</option>
                            <option value="SUCCESS">Thành công</option>
                            <option value="FAILED">Thất bại</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Tên người gửi <span class="required">*</span>
                        </label>
                        <input type="text" class="form-control-custom" name="senderName" required
                               placeholder="Ví dụ: Nguyễn Văn A">
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            Nội dung chuyển khoản
                        </label>
                        <textarea class="form-control-custom" name="transferContent"
                                  placeholder="Ví dụ: Thanh toan goi Pro thang 1"></textarea>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn-cancel" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="btn-submit">
                        <span class="material-symbols-outlined" style="font-size: 18px;">check</span>
                        Lưu giao dịch
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModal() {
            document.getElementById('addRevenueModal').classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('addRevenueModal').classList.remove('show');
            document.body.style.overflow = 'auto';
            document.getElementById('addRevenueForm').reset();
        }

        // Đóng modal khi click outside
        document.getElementById('addRevenueModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // Đóng modal khi nhấn ESC
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && document.getElementById('addRevenueModal').classList.contains('show')) {
                closeModal();
            }
        });

        // Validate form trước khi submit
        document.getElementById('addRevenueForm').addEventListener('submit', function(e) {
            const userId = document.querySelector('input[name="userId"]').value;
            const orderCode = document.querySelector('input[name="orderCode"]').value;
            const amount = document.querySelector('input[name="amount"]').value;
            const senderName = document.querySelector('input[name="senderName"]').value;

            if (!userId || !orderCode || !amount || !senderName) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return false;
            }

            if (parseFloat(amount) <= 0) {
                e.preventDefault();
                alert('Số tiền phải lớn hơn 0!');
                return false;
            }

            // Confirm trước khi submit
            if (!confirm('Bạn có chắc chắn muốn thêm giao dịch này?')) {
                e.preventDefault();
                return false;
            }
        });
    </script>

    </body>
    </html>
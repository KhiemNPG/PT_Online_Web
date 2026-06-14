<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.User" %>
<%
// Lấy dữ liệu từ Servlet truyền sang
    List< User> userList = (List< User>) request.getAttribute("userList");
    List< Integer> userProList = (List< Integer>) request.getAttribute("userProList");
    int totalCustomers = (userList != null) ? userList.size() : 0;
    %>

    <style>
        /* Custom Tone màu tối cho riêng cấu trúc Bảng */
        .bg-table-container {
            background-color: #111622; /* Màu nền hộp danh sách */
        }
        .table-dark-custom {
            --bs-table-bg: transparent;
            --bs-table-hover-bg: rgba(255, 255, 255, 0.03);
            color: #f8fafc;
            margin-bottom: 0;
        }
        .table-dark-custom thead tr {
            background-color: rgba(23, 30, 46, 0.5);
        }
        .table-dark-custom th {
            color: #64748b;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 0.05em;
            text-transform: uppercase;
            border-bottom: 1px solid rgba(100, 116, 139, 0.2);
            padding: 1rem 1.25rem;
        }
        .table-dark-custom td {
            border-bottom: 1px solid rgba(100, 116, 139, 0.1);
            padding: 1rem 1.25rem;
            vertical-align: middle;
        }

        /* Định dạng avatar chữ viết tắt tên học viên */
        .avatar-text {
            width: 36px;
            height: 36px;
            background-color: #171e2e;
            color: #10b981;
            font-weight: 700;
            font-size: 14px;
        }

        /* Custom các loại Badges (Gói Online, Dịch vụ PT, Trạng thái) */
        .badge-pro {
            background-color: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 12px;
        }
        .badge-free {
            background-color: #171e2e;
            color: #94a3b8;
            border: 1px solid rgba(148, 163, 184, 0.2);
            padding: 0.35rem 0.75rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 12px;
        }
        .badge-pt-active {
            background-color: rgba(16, 185, 129, 0.1);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.2);
            padding: 0.4rem 0.75rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 12px;
        }

        /* Sửa lại cái này để chấm xanh không bị nhảy lên đỉnh box */
        .badge-pt-active .pulse-dot {
            margin-top: -14px; /* Đẩy nhẹ chấm xanh lên để nó canh giữa chữ "PT Active" hàng đầu tiên */
        }

        .badge-status-active {
            display: inline-block;        /* 1. Ép thẻ span có thuộc tính khối khối để nhận padding chuẩn */
            white-space: nowrap;         /* 2. TUYỆT ĐỐI không cho chữ xuống dòng khi thiếu không gian */
            background-color: rgba(16, 185, 129, 0.1);
            color: #10b981;
            border: 1px solid rgba(16, 185, 129, 0.15);
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 12px;
        }

        /* Nháy đèn xung mạch (Pulse Animation) cho nút PT Active */
        .pulse-dot {
            width: 6px;
            height: 6px;
            background-color: #10b981;
            border-radius: 50%;
            display: inline-block;
            animation: pulseEffect 1.5s infinite;
        }
        @keyframes pulseEffect {
            0% { transform: scale(0.9); opacity: 0.6; }
            50% { transform: scale(1.2); opacity: 1; }
            100% { transform: scale(0.9); opacity: 0.6; }
        }

        /* Nút Thao tác "Chi tiết Hồ sơ" */
        .btn-action-custom {
            background-color: #171e2e;
            color: #94a3b8;
            font-weight: 700;
            font-size: 13px;
            border: 1px solid rgba(148, 163, 184, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .btn-action-custom:hover {
            background-color: #38bdf8;
            color: #0b0f19;
            border-color: #38bdf8;
        }

        /* Custom lại phân trang Bootstrap */
        .pagination-custom .page-link {
            background-color: #171e2e;
            border: 1px solid rgba(100, 116, 139, 0.2);
            color: #94a3b8;
            padding: 0.5rem 0.85rem;
            font-size: 14px;
        }
        .pagination-custom .page-item.active .page-link {
            background-color: #38bdf8;
            border-color: #38bdf8;
            color: #0b0f19;
            font-weight: bold;
        }
        .pagination-custom .page-link:hover {
            background-color: rgba(56, 189, 248, 0.1);
            color: #38bdf8;
        }

        .badge-pt-inactive {
            background-color: #171e2e;
            color: #64748b;
            border: 1px solid rgba(100, 116, 139, 0.2);
            padding: 0.4rem 0.75rem;
            border-radius: 8px;
            font-weight: 700;
            font-size: 12px;
        }
    </style>

    <%-- Khối chứa bảng quản lý học viên --%>
    <div class="bg-table-container border border-secondary border-opacity-15 rounded-4 overflow-hidden d-flex flex-column mt-4">
        <div class="table-responsive">
            <table class="table table-hover table-dark-custom align-middle">
                <thead>
                <tr>
                    <th scope="col" class="text-center" style="white-space: nowrap;">ID</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Họ và Tên</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Nhân khẩu học</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Gói Online</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Dịch vụ PT</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Trạng thái</th>
                    <th scope="col" class="text-center" style="white-space: nowrap;">Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <%
                if (userList != null && !userList.isEmpty()) {
                for (User u : userList) {

                String label = "Chưa thiết lập";

                // Xử lý dữ liệu tránh NullPointerException
                String ageDisplay = (u.getAge() != null) ? (u.getAge() + " tuổi") : label;
                String genderDisplay = (u.getGender() != null && !u.getGender().trim().isEmpty()) ? u.getGender() : label;

                // Lấy ký tự đầu làm Avatar tròn
                char firstChar = (u.getName() != null && !u.getName().trim().isEmpty()) ? u.getName().trim().toUpperCase().charAt(0) : 'U';
                %>
                <tr>
                    <td class="text-center">
                        <span class="text-white small font-monospace">SP-<%= u.getUserId() %></span>
                    </td>
                    <td>
                        <div class="d-flex align-items-center gap-3">
                            <div class="avatar-text rounded-circle d-flex align-items-center justify-content-center">
                                <%= firstChar %>
                            </div>
                            <div>
                                <p class="mb-0 fw-bold text-white"><%= u.getName() %></p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <%
                            if (!ageDisplay.equals(label) && !genderDisplay.equals(label) ){
                        %>
                        <p class="mb-0 text-white-50"><%= ageDisplay %>, <%= genderDisplay %></p>
                        <%
                            } else {
                        %>
                        <p class="mb-0 text-white-50"><%= label %></p>
                        <%
                            }
                        %>
                    </td>
                    <td>
                        <% if (userProList != null && userProList.contains(u.getAccountId())) { %>
                        <!-- Tài khoản PRO -->
                        <span class="badge-pro d-inline-flex align-items-center gap-1 text-warning fw-bold">
                        <span class="material-symbols-outlined" style="font-size: 14px;">workspace_premium</span>
                            PRO
                        </span>
                        <% } else { %>
                        <!-- Tài khoản thường -->
                        <span class="badge-regular d-inline-flex align-items-center gap-1 text-secondary">
                        <span class="material-symbols-outlined" style="font-size: 14px;">person</span>
                            Thường
                        </span>
                        <% } %>
                    </td>
                    <td>
                        <span class="badge-pt-inactive d-inline-flex align-items-center gap-2">
                            <span class="material-symbols-outlined" style="font-size: 14px;">person_off</span>
                            <span class="d-inline-block text-start text-nowrap">
                                Chưa đăng ký PT
                                <br>
                                <small class="text-white-50 fw-normal">(0 Buổi)</small>
                            </span>
                        </span>
                    </td>
                    <td>
                        <span class="badge-status-active">Hoạt động</span>
                    </td>
                    <td class="text-end">
                        <button class="btn btn-action-custom">Chi tiết Hồ sơ</button>
                    </td>
                </tr>
                <%
                } // Kết thúc vòng lặp for
                } else {
                %>
                <tr>
                    <td colspan="7" class="text-center text-muted py-4">Không có dữ liệu học viên để hiển thị.</td>
                </tr>
                <%
                }
                %>
                </tbody>
            </table>
        </div>

    </div>
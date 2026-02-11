<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --brand-red: #DC2626;
            --dark-bg: #121212;
            --border-soft: rgba(255, 255, 255, 0.1);
        }

        /* Đổ màu nền cho toàn bộ Section */
        #comparison-section {
            background-color: #121212 !important;
            color: #ffffff !important;
        }

        /* Loại bỏ màu nền trắng mặc định của bảng Bootstrap */
        .custom-table {
            background-color: transparent !important;
            color: #ffffff !important;
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
        }

        /* Ép tất cả các ô (td, th) không có nền và chữ trắng */
        .custom-table th,
        .custom-table td {
            background-color: transparent !important;
            color: #ffffff !important;
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-soft);
            vertical-align: middle;
        }

        /* Header của bảng */
        .custom-table thead th {
            border-bottom: 2px solid var(--border-soft);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 2px;
            font-weight: 700;
        }

        /* Màu đỏ nhấn mạnh cho cột PT AI */
        .text-brand-red {
            color: var(--brand-red) !important;
        }

        /* Căn giữa tiêu đề cột */
        .text-center-col {
            text-align: center;
        }

        /* Loại bỏ viền dòng cuối cùng */
        .custom-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Tên tính năng (Cột 1) xám nhẹ để tạo chiều sâu */
        .feature-name {
            color: rgba(255, 255, 255, 0.6) !important;
            text-transform: uppercase;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
<section class="py-5" id="comparison-section">
    <div class="container">

        <div class="text-center mb-5">
            <h2 class="display-6 fw-bold text-white italic text-uppercase mb-3">
                Tại sao chọn PT AI?
            </h2>
            <p class="text-secondary small text-uppercase ls-widest">Sự khác biệt giữa tương lai và quá khứ</p>
        </div>

        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="table-responsive">
                    <table class="table custom-table">
                        <thead>
                        <tr>
                            <th scope="col" class="feature-name">Tính năng</th>
                            <th scope="col" class="text-center-col">PT Truyền thống</th>
                            <th scope="col" class="text-center-col text-brand-red">PT AI</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="feature-name">Chi phí</td>
                            <td class="text-center-col">5.000.000đ+/tháng</td>
                            <td class="text-center-col">Chỉ từ 19$/tháng</td>
                        </tr>
                        <tr>
                            <td class="feature-name">Khả dụng</td>
                            <td class="text-center-col">Giờ hành chính</td>
                            <td class="text-center-col">24/7 Mọi nơi</td>
                        </tr>
                        <tr>
                            <td class="feature-name">Phản hồi</td>
                            <td class="text-center-col">Chậm/Sau buổi tập</td>
                            <td class="text-center-col">Tức thì (Real-time)</td>
                        </tr>
                        <tr>
                            <td class="feature-name">Dữ liệu</td>
                            <td class="text-center-col">Ghi chép thủ công</td>
                            <td class="text-center-col">Số hóa 100%</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
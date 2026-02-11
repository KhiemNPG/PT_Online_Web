<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

    <style>
        /* Màu nền đen Charcoal */
        .my-gray-background {
            background-color: #121212 !important;
            border: none !important; /* XÓA VIỀN bao quanh section */
        }

        /* Giãn chữ cho label (Hội viên, Bài tập AI...) */
        .ls-widest {
            letter-spacing: 0.2em;
        }

        /* Định dạng con số: MÀU TRẮNG */
        .stat-number {
            font-family: 'Inter', sans-serif;
            color: #ffffff !important; /* Đã sửa thành màu trắng */
            transition: 0.3s;
        }

        /* Khi hover vào khối thì số mới đổi sang màu đỏ */
        .stat-group:hover .stat-number {
            color: #DC2626 !important;
        }

        /* Màu chữ phụ phía dưới (Hội viên, Lịch tập...) */
        .stat-label {
            color: #a0a0a0 !important; /* Màu xám nhạt để nổi bật trên nền đen */
        }
    </style>

</head>
<body>

<section class="py-5 my-gray-background" data-purpose="stats-section">
    <div class="container py-md-4">
        <div class="row g-4 justify-content-center">

            <div class="col-6 col-md-3 text-center stat-group">
                <div class="stat-number display-5 fw-bold mb-2">50.000+</div>
                <p class="stat-label text-uppercase ls-widest small fw-semibold">Hội viên</p>
            </div>

            <div class="col-6 col-md-3 text-center stat-group">
                <div class="stat-number display-5 fw-bold mb-2">1.000+</div>
                <p class="stat-label text-uppercase ls-widest small fw-semibold">Bài tập AI</p>
            </div>

            <div class="col-6 col-md-3 text-center stat-group">
                <div class="stat-number display-5 fw-bold mb-2">98%</div>
                <p class="stat-label text-uppercase ls-widest small fw-semibold">Độ chính xác</p>
            </div>

            <div class="col-6 col-md-3 text-center stat-group">
                <div class="stat-number display-5 fw-bold mb-2">24/7</div>
                <p class="stat-label text-uppercase ls-widest small fw-semibold">Hỗ trợ</p>
            </div>

        </div>
    </div>
</section>

</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* Biến màu sắc */
        :root {
            --brand-red: #DC2626;
            --card-bg: #121212;
        }

        .bg-black { background-color: #000 !important; }

        /* Font và Tiêu đề */
        .fw-900 { font-weight: 900; }
        .italic { font-style: italic; }
        .tracking-tighter { letter-spacing: -1px; }

        /* Thanh gạch chân màu đỏ */
        .brand-line {
            width: 60px;
            height: 4px;
            background-color: var(--brand-red);
        }

        /* Thiết kế Card */
        .feature-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.05);
            transition: all 0.3s ease-in-out;
        }

        /* Hiệu ứng Hover Card */
        .feature-card:hover {
            border-color: var(--brand-red);
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(220, 38, 38, 0.1);
        }

        /* Box Icon */
        .icon-box {
            width: 48px;
            height: 48px;
            color: var(--brand-red);
            transition: transform 0.3s ease;
        }

        .feature-card:hover .icon-box {
            transform: scale(1.15);
        }

        /* Text phụ */
        .small-text {
            font-size: 0.95rem;
            line-height: 1.6;
        }
    </style>

</head>
<body>
<section class="py-5 bg-black" id="features">
    <div class="container py-5">

        <div class="text-center mb-5">
            <h2 class="display-6 fw-900 text-white italic text-uppercase tracking-tighter mb-2">
                Tính Năng Cốt Lõi
            </h2>
            <div class="brand-line mx-auto"></div>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card h-100 p-4">
                    <div class="icon-box mb-4">
                        <svg fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"></path>
                        </svg>
                    </div>
                    <h3 class="h5 fw-bold text-white text-uppercase mb-3">Công nghệ Computer Vision</h3>
                    <p class="text-secondary small-text">Theo dõi chuyển động cơ thể theo thời gian thực, đảm bảo mỗi
                        rep tập đều đạt chuẩn kỹ thuật tuyệt đối.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card h-100 p-4">
                    <div class="icon-box mb-4">
                        <svg fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 14h-2v-4H6v-2h4V7h2v4h4v2h-4v4z"></path>
                        </svg>
                    </div>
                    <h3 class="h5 fw-bold text-white text-uppercase mb-3">Luyện tập Động</h3>
                    <p class="text-secondary small-text">Giáo án tự động thay đổi dựa trên tiến độ thực tế của bạn.
                        Không bao giờ đứng yên một chỗ.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card h-100 p-4">
                    <div class="icon-box mb-4">
                        <svg fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M11 9H9V2H7v7H5V2H3v7c0 2.12 1.66 3.84 3.75 3.97V22h2.5v-9.03C11.34 12.84 13 11.12 13 9V2h-2v7zm5-3v8h2.5v8H21V2c-2.76 0-5 2.24-5 4z"></path>
                        </svg>
                    </div>
                    <h3 class="h5 fw-bold text-white text-uppercase mb-3">Dinh dưỡng Thông minh</h3>
                    <p class="text-secondary small-text">AI tính toán lượng Macro và gợi ý thực đơn tối ưu cho mục tiêu
                        tăng cơ hoặc giảm mỡ của riêng bạn.</p>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
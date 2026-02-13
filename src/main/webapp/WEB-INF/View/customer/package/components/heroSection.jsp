<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* Custom Variables & Base */
        :root {
            --primary-red: #ff0000;
            --dark-bg: #121212;
            --card-bg: #2d1515;
            --card-pro-bg: #3d1a1a;
            --text-gray: #a0a0a0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
        }

        .pricing-section{
            background-color: #230F0F !important;
        }

        .fw-black { font-weight: 900; }
        .italic { font-style: italic; }
        .text-primary-custom { color: var(--primary-red); }
        .text-secondary-custom { color: var(--text-gray); }

        /* Hero Section */
        .hero-section {
            padding: 100px 0 80px;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(18,18,18,0.9) 100%);
        }

        .tracking-tighter { letter-spacing: -2px; }

        /* Pricing Cards */
        .pricing-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 0, 0, 0.1);
            border-radius: 1rem;
            padding: 2.5rem;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .pricing-card:hover {
            transform: translateY(-10px);
        }

        .pricing-card.highlighted {
            background-color: var(--card-pro-bg);
            border: 2px solid var(--primary-red);
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.2);
            transform: scale(1.05);
            z-index: 10;
        }

        /* List Styles */
        .pricing-card ul li {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .pricing-card ul li .material-icons {
            font-size: 1.25rem;
            color: var(--primary-red);
        }

        .disabled-item {
            color: #666;
        }
        .disabled-item .material-icons {
            color: #666 !important;
        }

        /* Buttons */
        .btn-primary-custom {
            background-color: var(--primary-red);
            color: white;
            border: none;
            padding: 1rem;
            letter-spacing: 2px;
        }

        .btn-primary-custom:hover {
            background-color: #cc0000;
            color: white;
        }

        .btn-outline-primary-custom {
            border: 2px solid var(--primary-red);
            color: var(--primary-red);
            padding: 1rem;
            letter-spacing: 2px;
        }

        .btn-outline-primary-custom:hover {
            background-color: var(--primary-red);
            color: white;
        }

        /* Badge */
        .badge-popular {
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background-color: var(--primary-red);
            color: white;
            padding: 4px 15px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 900;
            text-transform: uppercase;
            white-space: nowrap;
        }

        /* Responsive adjustments */
        @media (max-width: 991px) {
            .pricing-card.highlighted {
                transform: scale(1);
                margin: 20px 0;
            }
        }
    </style>

</head>
<body class="bg-dark-custom text-white">

<header class="hero-section text-center">
    <div class="container">
        <h1 class="display-3 fw-black italic text-uppercase tracking-tighter mb-3">
            BẢNG GIÁ <span class="text-primary-custom">HỘI VIÊN</span>
        </h1>
        <p class="lead text-secondary-custom mx-auto" style="max-width: 600px;">
            Chọn vũ khí của bạn. Bắt đầu hành trình lột xác và phá vỡ mọi giới hạn ngay hôm nay.
        </p>
    </div>
</header>

<section class="pricing-section pb-5">
    <div class="container">
        <div class="row g-4 align-items-stretch">

            <div class="col-lg-4">
                <div class="pricing-card h-100">
                    <div class="card-header-custom mb-4">
                        <h3 class="fw-black text-uppercase italic">Cơ bản</h3>
                        <p class="text-secondary-custom small">Dành cho người mới bắt đầu kỷ luật.</p>
                    </div>
                    <div class="price-tag mb-4">
                        <span class="display-4 fw-black">450k</span>
                        <span class="text-secondary-custom fw-bold small">/ THÁNG</span>
                    </div>
                    <ul class="list-unstyled flex-grow-1">
                        <li><span class="material-icons">check_circle</span> Truy cập phòng tập 24/7</li>
                        <li><span class="material-icons">check_circle</span> Tủ đồ cá nhân an toàn</li>
                        <li><span class="material-icons">check_circle</span> Lịch tập cơ bản hàng tháng</li>
                        <li class="disabled-item"><span class="material-icons">radio_button_unchecked</span> Video hướng
                            dẫn kỹ thuật
                        </li>
                    </ul>
                    <button class="btn btn-outline-primary-custom w-100 fw-black mt-4">CHỌN GÓI</button>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="pricing-card highlighted h-100 position-relative">
                    <div class="badge-popular">PHỔ BIẾN NHẤT</div>
                    <div class="card-header-custom mb-4 text-center text-lg-start">
                        <h3 class="fw-black text-uppercase italic text-primary-custom">PRO</h3>
                        <p class="text-light-custom small">Nâng tầm việc tập luyện chuyên nghiệp.</p>
                    </div>
                    <div class="price-tag mb-4 text-center text-lg-start">
                        <span class="display-3 fw-black">850k</span>
                        <span class="text-secondary-custom fw-bold small">/ THÁNG</span>
                    </div>
                    <ul class="list-unstyled flex-grow-1 fw-bold">
                        <li><span class="material-icons text-primary-custom">check_circle</span> Toàn bộ quyền lợi gói
                            Cơ bản
                        </li>
                        <li><span class="material-icons text-primary-custom">check_circle</span> Lịch tập tự động (Smart
                            Plan)
                        </li>
                        <li><span class="material-icons text-primary-custom">check_circle</span> Video hướng dẫn chi
                            tiết
                        </li>
                        <li><span class="material-icons text-primary-custom">check_circle</span> Thống kê tiến độ hàng
                            tuần
                        </li>
                        <li><span class="material-icons text-primary-custom">check_circle</span> Phòng xông hơi &
                            Massage
                        </li>
                    </ul>
                    <button class="btn btn-primary-custom w-100 fw-black mt-4 shadow-lg">CHỌN GÓI NGAY</button>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="pricing-card h-100">
                    <div class="card-header-custom mb-4">
                        <h3 class="fw-black text-uppercase italic">HARDCORE</h3>
                        <p class="text-secondary-custom small">Dành cho những chiến binh thực thụ.</p>
                    </div>
                    <div class="price-tag mb-4">
                        <span class="display-4 fw-black">1.500k</span>
                        <span class="text-secondary-custom fw-bold small">/ THÁNG</span>
                    </div>
                    <ul class="list-unstyled flex-grow-1">
                        <li><span class="material-icons">check_circle</span> Toàn bộ quyền lợi gói PRO</li>
                        <li><span class="material-icons">check_circle</span> Thống kê chuyên sâu AI</li>
                        <li><span class="material-icons">check_circle</span> Hỗ trợ 1:1 từ PT Online</li>
                        <li><span class="material-icons">check_circle</span> Chế độ dinh dưỡng cá nhân</li>
                        <li><span class="material-icons">check_circle</span> Supplements miễn phí mỗi buổi</li>
                    </ul>
                    <button class="btn btn-outline-primary-custom w-100 fw-black mt-4">CHỌN GÓI</button>
                </div>
            </div>

        </div>
    </div>
</section>

</body>
</html>
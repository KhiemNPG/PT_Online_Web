<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --brand-red: #DC2626;
            --dark-bg: #000000;
        }

        /* Tiêu đề & Chữ */
        .text-brand-red { color: var(--brand-red) !important; }
        .italic { font-style: italic; }
        .fw-bold { font-weight: 800 !important; }

        /* Hiệu ứng khung hình Demo */
        .demo-visual-wrapper {
            position: relative;
            padding: 4px;
        }

        .glow-overlay {
            position: absolute;
            inset: -5px;
            background: var(--brand-red);
            opacity: 0.15;
            filter: blur(20px);
            border-radius: 4px;
        }

        .demo-screen {
            position: relative;
            background: #0a0a0a;
            border: 1px solid rgba(220, 38, 38, 0.3);
            overflow: hidden;
            aspect-ratio: 16/9;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .screen-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.4;
            filter: grayscale(100%);
        }

        /* Hiệu ứng System Live Label */
        .system-status {
            position: absolute;
            top: 15px;
            left: 15px;
            background: rgba(0, 0, 0, 0.8);
            color: var(--brand-red);
            border: 1px solid var(--brand-red);
            padding: 4px 10px;
            font-family: monospace;
            font-size: 10px;
            letter-spacing: 1px;
        }

        /* Skeleton Overlay */
        .skeleton-overlay {
            position: absolute;
            inset: 0;
            pointer-events: none;
        }
        .skeleton-overlay svg {
            width: 100%;
            height: 100%;
        }

        /* Custom List với ô vuông đỏ */
        .custom-list li {
            position: relative;
            padding-left: 25px;
            margin-bottom: 15px;
            color: #ffffff;
            text-transform: uppercase;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .custom-list li::before {
            content: "";
            position: absolute;
            left: 0;
            top: 4px;
            width: 8px;
            height: 8px;
            background-color: var(--brand-red);
            box-shadow: 0 0 5px var(--brand-red);
        }

        /* Responsive cho mobile */
        @media (max-width: 991px) {
            .demo-screen { margin-bottom: 30px; }
        }
    </style>
</head>
<body>
<section class="py-5 bg-black" id="demo">
    <div class="container py-5">
        <div class="row align-items-center g-5">

            <div class="col-lg-6">
                <div class="demo-visual-wrapper">
                    <div class="glow-overlay"></div>

                    <div class="demo-screen">
                        <img alt="AI Tracking Demo" class="img-fluid screen-img"
                             src="https://lh3.googleusercontent.com/aida-public/AB6AXuB_XlE8CShX5dH3BAWYNg-BjgvZVlqfKgrGSE7PNiKOdIEjXhaeFd_8rryjGquBesB8Y3BI8TNoIlTavu5ZOfu_-8g_0xKWwzid62lDTCndh2wQpNOV51IeYiUfbeVmvoIVzptGImkeUVETkztyIcFTWb29PbhfclWn47Ii2vX90nufTzS9h1zT4yrweossW1dHRue4ngpMT59W-MI_OLATYny40UcW-ryNHqBHZOoPPkO-BdyZyE2oWM7kSBuDPFdP5sxbaibYIaM"/>

                        <div class="skeleton-overlay">
                            <svg viewBox="0 0 100 100" preserveAspectRatio="none">
                                <circle cx="50" cy="20" r="3" fill="#ff0000"/>
                                <path d="M50 20 L50 50 L30 80 M50 50 L70 80 M50 30 L25 50 M50 30 L75 50"
                                      stroke="#ff0000" stroke-width="1" fill="none" opacity="0.8"/>
                            </svg>
                        </div>

                        <div class="system-status">
                            SYSTEM LIVE: ANALYZING 17 POINTS...
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 ps-lg-5">
                <h2 class="display-5 fw-bold text-white text-uppercase italic mb-4 leading-tight">
                    Sửa tư thế<br>
                    <span class="text-brand-red">Thời gian thực</span>
                </h2>

                <p class="text-secondary mb-5 fs-5 opacity-75">
                    Sử dụng thuật toán học sâu tiên tiến nhất, PT AI phân tích 17 điểm khớp nối trên cơ thể để phát hiện
                    sai lệch chỉ trong 0.03 giây. Ngăn ngừa chấn thương và tối đa hóa hiệu quả tập luyện ngay lập tức.
                </p>

                <ul class="list-unstyled custom-list">
                    <li>Phân tích góc độ xương khớp</li>
                    <li>Cảnh báo bằng giọng nói tức thì</li>
                    <li>Đánh giá chất lượng Rep-by-Rep</li>
                </ul>
            </div>

        </div>
    </div>
</section>
</body>
</html>
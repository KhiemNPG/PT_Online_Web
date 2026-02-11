<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --brand-red: #DC2626;
            --brand-black: #0a0a0a;
        }

        /* Ép font Inter cho toàn bộ trang để tránh lỗi font hệ thống */
        * {
            font-family: 'Inter', sans-serif !important;
        }

        body {
            background-color: var(--brand-black);
            margin: 0;
        }

        #hero {
            position: relative;
            min-height: 100vh;
            display: flex;
            align-items: center;
            color: white;
            overflow: hidden;

            background-color: #313433 !important;
        }

        .hero-grid-overlay {
            position: absolute;
            inset: 0;
            background-image:
                linear-gradient(to right, rgba(220, 38, 38, 0.1) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(220, 38, 38, 0.1) 1px, transparent 1px);
            background-size: 40px 40px;
            z-index: 1;
        }

        .hero-bg-img {
            position: absolute;
            inset: 0; /* Viết tắt của top:0, left:0, right:0, bottom:0 */
            z-index: 0;

        }

        .hero-bg-img img {
            width: 60%;
            height: 100%;

            /* Dùng cover để ảnh to và lấp đầy nền */
            object-fit: cover;
            /* Nếu người mẫu bị lệch đầu hoặc chân, chỉnh ở đây (ví dụ: center top) */
            object-position: center center;
            opacity: 0.3;
            filter: grayscale(100%);
            margin-left: 20%;
        }

        .hero-gradient-mask {
            position: absolute;
            inset: 0;
            background: radial-gradient(circle, transparent 20%, var(--brand-black) 90%);
            z-index: 2;

        }

        .hero-title {
            font-size: clamp(2.5rem, 8vw, 5rem);
            font-weight: 900;
            font-style: italic;
            line-height: 1;
            letter-spacing: -2px;
            text-transform: uppercase;
        }

        .text-red { color: var(--brand-red); }

        .hero-badge {
            border: 1px solid var(--brand-red);
            color: var(--brand-red);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            padding: 6px 14px;
            text-transform: uppercase;
            display: inline-block;
        }

        /* ÉP ĐỘ DÀY CHỮ VÀ KIỂU DÁNG GIỐNG ẢNH 100% */
        .btn-red {
            background-color: #e31e24 !important; /* Màu đỏ rực đặc trưng */
            color: #ffffff !important;
            border: none !important;
            height: 56px !important; /* Chiều cao nút dày dặn hơn */
            padding: 0 45px !important;
            font-family: 'Inter', sans-serif !important;
            font-size: 15px !important;
            font-weight: 900 !important; /* Chữ siêu dày giống ảnh mẫu */
            letter-spacing: 0.5px !important;
            text-transform: uppercase !important;
            border-radius: 0 !important; /* Vuông vức tuyệt đối */
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            text-decoration: none !important;
        }

        .btn-red:hover {
            background-color: #ff2d34 !important;
            box-shadow: 0 0 20px rgba(227, 30, 36, 0.5) !important;
            transform: translateY(-1px);
        }

        .btn-outline-white {
            border: 1px solid rgba(255, 255, 255, 0.3) !important; /* Viền mảnh và mờ */
            color: #ffffff !important;
            background: rgba(255, 255, 255, 0.05) !important; /* Nền trong suốt tối */
            height: 56px !important;
            padding: 0 45px !important;
            font-family: 'Inter', sans-serif !important;
            font-size: 15px !important;
            font-weight: 900 !important; /* Độ dày đồng nhất với nút đỏ */
            letter-spacing: 0.5px !important;
            text-transform: uppercase !important;
            border-radius: 0 !important;
            display: inline-flex !important;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            text-decoration: none !important;
        }

        .btn-outline-white:hover {
            background: rgba(255, 255, 255, 0.15) !important;
            border-color: #ffffff !important;
        }

        /* Khoảng cách giữa 2 nút chuẩn UI */
        .gap-3 {
            gap: 16px !important;
        }
    </style>

</head>
<body>
<section id="hero">
    <div class = "hero-bg-img">
        <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAz1Q2FqXabc_tHlTr2JZ21Ik8PRWib_0KmiiQfdWlOCKI9epX2NTdu7RIi7TKx4wQkQPVLIdTs2-clphB-wEFv9wNnkQ899n9rD59Zy3_gOquFOQw0SWv9HDYbzYwtBasp7XNV8w_hno4sQ-qO3n4V-9XumTyUTpzGuBtDp1IfqiB1T8te0ujPhZeTie01VW2FQKs44zFT76J3-WOKX6rem66SBcDV4DfmZ7F363avcgqcQ5_SKL_Ymqma2NN6Jq5mPlUH3TTMyIk"
             class="img" alt="Background">
    </div>

    <div class="hero-grid-overlay"></div>
    <div class="hero-gradient-mask"></div>

    <div class="container text-center" style="position: relative; z-index: 10;">
        <div class="mb-4">
            <span class="hero-badge">TIÊN PHONG CÔNG NGHỆ FITNESS AI</span>
        </div>

        <h1 class="hero-title mb-4">
            YOUR AI, YOUR BODY,<br>
            <span class="text-red">YOUR RULES.</span>
        </h1>

        <p class="text-secondary mx-auto mb-5" style="max-width: 650px; font-size: 1.1rem; font-weight: 400;">
            Cuộc cách mạng luyện tập với hệ thống AI sửa tư thế theo thời gian thực.
            Chính xác, cá nhân hóa và tối ưu 100%.
        </p>

        <div class="d-flex flex-column flex-sm-row justify-content-center gap-3">
            <button class="btn btn-red">BẮT ĐẦU DÙNG THỬ MIỄN PHÍ</button>
            <button class="btn btn-outline-white">XEM DEMO</button>
        </div>

    </div>
</section>
</body>
</html>
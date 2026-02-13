<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* News Hero Specific Styles */
        .news-hero {
            min-height: 60vh;
            background-color: #000;
        }

        .absolute-fill {
            position: absolute;
            inset: 0;
        }

        .hero-img-grayscale {
            filter: grayscale(100%) brightness(0.4); /* Ảnh trắng đen và dìm sáng xuống */
            opacity: 0.6;
        }

        .hero-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, #000 0%, rgba(0,0,0,0.2) 50%, transparent 100%);
        }

        .news-hero .display-1 {
            font-size: clamp(3rem, 10vw, 6rem); /* Responsive font size */
            letter-spacing: -3px;
            color: #fff;
        }

        .hero-subtitle {
            color: #a1a1aa; /* Zinc-400 */
            letter-spacing: 0.2em;
            font-size: 1.1rem;
        }

        /* Nút bấm kiểu Hardcore */
        .btn-hardcore-large {
            background-color: var(--primary-red);
            color: white;
            padding: 16px 45px;
            font-size: 1.2rem;
            font-weight: 900;
            text-transform: uppercase;
            border: none;
            border-radius: 4px;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .btn-hardcore-large:hover {
            background-color: #d60505;
            color: white;
            transform: scale(1.05);
            box-shadow: 0 0 30px rgba(249, 6, 6, 0.4);
        }

        /* Tracking Tight cho tiêu đề giống thiết kế */
        .tracking-tighter {
            letter-spacing: -0.05em;
        }

        .z-3 { z-index: 3; }
    </style>
</head>
<body>
<section class="news-hero position-relative d-flex align-items-center justify-content-center overflow-hidden">
    <div class="hero-bg-container absolute-fill">
        <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070"
             alt="Hardcore athlete"
             class="hero-img-grayscale w-100 h-100 object-fit-cover">
        <div class="hero-overlay"></div>
    </div>

    <div class="container position-relative z-3 text-center">
        <h2 class="display-1 fw-black italic text-uppercase tracking-tighter mb-3">
            TIN TỨC & <span class="text-primary-custom">KIẾN THỨC</span>
        </h2>
        <p class="hero-subtitle text-zinc-400 fw-medium text-uppercase tracking-wider mb-5">
            Nâng tầm sức mạnh và tri thức chiến binh
        </p>
        <div class="mt-4">
            <button class="btn btn-hardcore-large">
                Khám Phá Ngay
            </button>
        </div>
    </div>
</section>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* CTA Section Styles */
        .cta-banner {
            background-color: #0f0f0f;
            padding: 100px 0;
        }

        .cta-img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.15;
            filter: grayscale(100%);
        }

        .cta-bg-overlay {
            position: absolute;
            inset: 0;
            background: radial-gradient(circle, rgba(255, 26, 26, 0.05) 0%, transparent 70%);
            z-index: 1;
        }

        .underline-offset {
            text-underline-offset: 12px;
            text-decoration-thickness: 5px !important;
        }

        /* Nút Đăng ký (Glow rực rỡ) */
        .btn-cta-red {
            background-color: var(--primary-red);
            color: white;
            border: none;
            padding: 18px 45px;
            font-size: 1.1rem;
            font-weight: 900;
            border-radius: 8px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 40px rgba(255, 26, 26, 0.4);
        }

        .btn-cta-red:hover {
            transform: scale(1.05);
            background-color: #ff0000;
            box-shadow: 0 15px 50px rgba(255, 26, 26, 0.6);
            color: white;
        }

        /* Nút Bảng giá */
        .btn-cta-outline {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.2);
            padding: 18px 45px;
            font-size: 1.1rem;
            font-weight: 900;
            border-radius: 8px;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .btn-cta-outline:hover {
            border-color: white;
            background-color: rgba(255, 255, 255, 0.05);
            color: white;
        }

        /* Stats Styling */
        .stat-number {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--primary-red);
            line-height: 1;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 0.65rem;
            text-transform: uppercase;
            color: #666;
            font-weight: 800;
            letter-spacing: 2px;
        }

        .border-white-10 {
            border-color: rgba(255, 255, 255, 0.1) !important;
        }

        .z-index-10 { z-index: 10; }
    </style>
</head>
<body>
<section class="cta-banner position-relative overflow-hidden border-top border-primary-custom border-3">
    <div class="cta-bg-overlay"></div>
    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070" class="cta-img"
         alt="Training Hard">

    <div class="container position-relative z-index-10 text-center py-5">
        <h2 class="display-4 fw-black italic text-uppercase tracking-tighter mb-4 leading-tight text-white">
            MỞ KHÓA <span class="text-primary-custom text-decoration-underline underline-offset">1000+ BÀI TẬP</span>
            <br>VÀ GIÁO ÁN CHUYÊN NGHIỆP
        </h2>

        <p class="text-secondary-custom fw-bold text-uppercase tracking-widest mb-5 mx-auto opacity-75"
           style="max-width: 750px;">
            Bạn chỉ mới thấy được phần nổi của tảng băng chìm. Đăng ký ngay để truy cập toàn bộ kho tàng kiến thức
            fitness đỉnh cao.
        </p>

        <div class="d-flex flex-column flex-sm-row justify-content-center gap-4 mb-5">
            <button class="btn btn-cta-red">ĐĂNG KÝ MIỄN PHÍ NGAY</button>
            <button class="btn btn-cta-outline">XEM BẢNG GIÁ VIP</button>
        </div>

        <div class="row g-4 pt-5 border-top border-white-10 mt-5">
            <div class="col-6 col-md-3">
                <div class="stat-number">1000+</div>
                <div class="stat-label">Bài tập chi tiết</div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-number">50+</div>
                <div class="stat-label">Lộ trình tập luyện</div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-number">100%</div>
                <div class="stat-label">Video hướng dẫn HD</div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-number">24/7</div>
                <div class="stat-label">Hỗ trợ từ chuyên gia</div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
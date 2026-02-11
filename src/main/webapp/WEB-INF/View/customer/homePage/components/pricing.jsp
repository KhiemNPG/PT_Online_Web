<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --brand-red: #DC2626;
            --card-bg: #121212;
        }

        /* Định dạng chung cho Card */
        .pricing-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 3rem 2rem;
            transition: all 0.3s ease;
            height: 100%;
        }

        /* Gói PRO nổi bật */
        .pricing-card.featured {
            border: 2px solid var(--brand-red);
            transform: scale(1.05); /* To hơn các gói khác */
            box-shadow: 0 0 20px rgba(220, 38, 38, 0.15);
            z-index: 10;
        }

        /* Nhãn "Phổ biến nhất" */
        .badge-featured {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: var(--brand-red);
            color: white;
            padding: 5px 15px;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 1px;
            white-space: nowrap;
        }

        /* Giá tiền */
        .price-tag {
            font-size: 2.5rem;
            font-weight: 800;
            font-family: 'Inter', sans-serif;
        }

        /* Danh sách tính năng */
        .pricing-features li {
            color: #a0a0a0;
            font-size: 0.9rem;
            margin-bottom: 12px;
        }

        .featured .pricing-features li {
            color: #ffffff; /* Chữ sáng hơn ở gói Pro */
        }

        /* Nút bấm mặc định */
        .btn-outline-light {
            border-color: rgba(255, 255, 255, 0.2);
            border-radius: 0;
            transition: 0.3s;
        }
        .btn-outline-light:hover {
            background-color: #ffffff;
            color: #000000;
            border-color: #ffffff;
        }

        /* Nút bấm Đỏ (Pro) */
        .btn-brand-red {
            background-color: var(--brand-red);
            color: white;
            border-radius: 0;
            border: none;
        }
        .btn-brand-red:hover {
            background-color: #b91c1c;
            color: white;
            box-shadow: 0 0 15px rgba(220, 38, 38, 0.5);
        }

        .pricing{
            background-color: #121212 !important;
            color: #ffffff !important;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .pricing-card.featured {
                transform: scale(1); /* Bỏ phóng to trên mobile để tránh đè nhau */
                margin: 20px 0;
            }
        }
    </style>

</head>
<body>
<section class="py-5 bg-black pricing" id="pricing">
    <div class="container py-5 all-pricing">

        <div class="text-center mb-5">
            <h2 class="display-5 fw-900 text-white italic text-uppercase tracking-tighter mb-2">
                Lựa chọn gói tập
            </h2>
            <p class="text-secondary opacity-75">Đầu tư cho bản thân là khoản đầu tư thông minh nhất</p>
        </div>

        <div class="row g-4 align-items-center all-pricing">

            <div class="col-md-4">
                <div class="pricing-card text-center">
                    <h3 class="h5 fw-bold text-white text-uppercase mb-4">Cơ bản</h3>
                    <div class="price-tag text-white mb-4">Miễn phí</div>
                    <ul class="list-unstyled pricing-features mb-5">
                        <li>5 bài tập AI mỗi tháng</li>
                        <li>Theo dõi tiến độ cơ bản</li>
                        <li>Cộng đồng hỗ trợ</li>
                    </ul>
                    <button class="btn btn-outline-light w-100 fw-bold py-3 text-uppercase">Bắt đầu ngay</button>
                </div>
            </div>

            <div class="col-md-4">
                <div class="pricing-card featured text-center position-relative">
                    <div class="badge-featured">PHỔ BIẾN NHẤT</div>
                    <h3 class="h5 fw-bold text-white text-uppercase mb-4">Pro</h3>
                    <div class="price-tag text-white mb-4">19$<span class="fs-6 fw-normal text-secondary">/tháng</span>
                    </div>
                    <ul class="list-unstyled pricing-features mb-5">
                        <li>Không giới hạn bài tập AI</li>
                        <li>Sửa tư thế nâng cao</li>
                        <li>Kế hoạch dinh dưỡng cá nhân</li>
                        <li>Phân tích dữ liệu chuyên sâu</li>
                    </ul>
                    <button class="btn btn-brand-red w-100 fw-bold py-3 text-uppercase">Bắt đầu ngay</button>
                </div>
            </div>

            <div class="col-md-4">
                <div class="pricing-card text-center">
                    <h3 class="h5 fw-bold text-white text-uppercase mb-4">Elite</h3>
                    <div class="price-tag text-white mb-4">49$<span class="fs-6 fw-normal text-secondary">/tháng</span>
                    </div>
                    <ul class="list-unstyled pricing-features mb-5">
                        <li>Mọi tính năng gói Pro</li>
                        <li>Hỗ trợ 1-1 từ chuyên gia</li>
                        <li>Tùy chỉnh giáo án linh hoạt</li>
                        <li>Phụ kiện tracking đi kèm</li>
                    </ul>
                    <button class="btn btn-outline-light w-100 fw-bold py-3 text-uppercase">Bắt đầu ngay</button>
                </div>
            </div>

        </div>
    </div>
</section>
</body>
</html>
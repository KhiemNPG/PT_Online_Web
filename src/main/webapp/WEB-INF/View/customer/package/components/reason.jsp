<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* Styling cho Section Tại sao chọn chúng tôi */
        .image-wrapper {
            height: 550px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .why-choose-us{
            background-color: #230F0F !important;
        }

        .main-img {
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }

        .image-wrapper:hover .main-img {
            transform: scale(1.1);
        }

        .overlay-gradient {
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.4) 40%, transparent 100%);
        }

        .image-content {
            position: absolute;
            bottom: 0;
            left: 0;
            z-index: 2;
        }

        /* Icon Box Styling */
        .icon-box {
            background-color: rgba(255, 26, 26, 0.1); /* Màu đỏ nhạt trong suốt */
            color: var(--primary-red);
            width: 60px;
            height: 60px;
            min-width: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        .icon-box .material-icons {
            font-size: 2rem;
        }

        .line-height-1 {
            line-height: 0.9;
        }

        .tracking-widest {
            letter-spacing: 3px;
        }

        /* Responsive cho Mobile */
        @media (max-width: 768px) {
            .image-wrapper {
                height: 400px;
            }
            .display-5 {
                font-size: 2.2rem;
            }
        }
    </style>
</head>
<body>
<section class="why-choose-us py-5">
    <div class="container py-lg-5">
        <div class="row g-5 align-items-center">

            <div class="col-lg-6">
                <div class="image-wrapper position-relative overflow-hidden rounded-4 shadow-lg">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop"
                         alt="Hardcore Fitness"
                         class="img-fluid w-100 object-fit-cover main-img">

                    <div class="overlay-gradient"></div>

                    <div class="image-content p-4 p-md-5">
                        <p class="text-primary-custom fw-black italic text-uppercase tracking-widest small mb-1">Tinh
                            thần thép</p>
                        <h2 class="display-6 fw-black text-white text-uppercase italic tracking-tighter line-height-1">
                            KHÔNG CÓ GIỚI HẠN <br>NÀO LÀ CUỐI CÙNG
                        </h2>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="ps-lg-4">
                    <h2 class="display-5 fw-black text-uppercase italic tracking-tighter mb-5">
                        TẠI SAO CHỌN <span class="text-primary-custom">HARDCORE GYM?</span>
                    </h2>

                    <div class="features-stack">
                        <div class="feature-item d-flex gap-4 mb-5">
                            <div class="icon-box">
                                <span class="material-icons">insights</span>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-2">Thống kê thông minh</h4>
                                <p class="text-secondary-custom mb-0">Theo dõi từng gram tạ và calorie đốt cháy với hệ
                                    thống AI tiên tiến nhất hiện nay.</p>
                            </div>
                        </div>

                        <div class="feature-item d-flex gap-4 mb-5">
                            <div class="icon-box">
                                <span class="material-icons">play_circle_filled</span>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-2">Thư viện Video 4K</h4>
                                <p class="text-secondary-custom mb-0">Hơn 500 bài tập được hướng dẫn bởi các chuyên gia
                                    IFBB Pro hàng đầu thế giới.</p>
                            </div>
                        </div>

                        <div class="feature-item d-flex gap-4">
                            <div class="icon-box">
                                <span class="material-icons">restaurant</span>
                            </div>
                            <div>
                                <h4 class="fw-bold mb-2">Dinh dưỡng tối ưu</h4>
                                <p class="text-secondary-custom mb-0">Thiết lập thực đơn dựa trên mục tiêu tăng cơ hoặc
                                    giảm mỡ riêng biệt cho từng hội viên.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>
</body>
</html>
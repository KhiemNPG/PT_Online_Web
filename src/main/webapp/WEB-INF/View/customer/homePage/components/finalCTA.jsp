<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --brand-red: #DC2626;
        }

        .final-cta {
            position: relative;
            background-color: #000; /* Nền đen tuyệt đối */
            overflow: hidden;
        }

        /* Ảnh nền làm mờ hẳn xuống để chữ nổi lên */
        .bg-img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.15 !important; /* Giảm độ rõ của ảnh nền */
            z-index: 0;
        }

        .gradient-shade {
            position: absolute;
            inset: 0;
            background: linear-gradient(to right, rgba(0,0,0,0.9), rgba(220,38,38,0.1));
            z-index: 1;
        }

        /* Đảm bảo nội dung nằm trên cùng */
        .z-10 {
            position: relative;
            z-index: 10;
        }

        /* Chỉnh chữ Tiêu đề sáng rực */
        .display-2 {
            color: #ffffff !important;
            font-weight: 900;
            text-shadow: 0 0 20px rgba(0,0,0,0.5); /* Tạo bóng để tách chữ khỏi nền */
        }

        .text-brand-red {
            color: var(--brand-red) !important;
        }

        /* Chỉnh chữ miêu tả: Bỏ mờ, dùng màu trắng sữa hoặc trắng tinh */
        .cta-description {
            color: #ffffff !important; /* Ép màu trắng 100% */
            font-size: 1.25rem;
            letter-spacing: 1px;
            font-weight: 500;
            max-width: 700px;
            margin: 0 auto;
            opacity: 1 !important; /* Đảm bảo không bị mờ */
        }

        /* Nút bấm */
        .btn-cta-red {
            background-color: var(--brand-red) !important;
            color: #fff !important;
            padding: 18px 35px;
            font-weight: 800;
            font-style: italic;
            text-transform: uppercase;
            border-radius: 0;
            font-size: 1.5rem;
            transition: 0.3s;
            box-shadow: 0 0 30px rgba(220, 38, 38, 0.4);
        }

        .btn-cta-red:hover {
            transform: scale(1.05);
            box-shadow: 0 0 50px rgba(220, 38, 38, 0.6);
        }

        .timer-text {
            color: #ffffff !important;
            letter-spacing: 2px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<section class="final-cta relative py-5 overflow-hidden" id="cta-section">
    <div class="cta-background-overlay">
        <img alt="Motivation Background" class="bg-img"
             src="https://lh3.googleusercontent.com/aida-public/AB6AXuDHfgM5TuD216BIghKW7TZJtSUQgrc47BaCwlVF8lkRht2KnXu191ZjheahJWYU2YTzoYMhC1442r4OC4wQR2xpHLOu5WrLFTDuLxCYAQpkAWTE8rEjcZ8wB6j03UdrIg3uFXDESFnoAvIwTrNu6oQoegozHyRK790O-zIdJS9fld0JuPiKJRBkWeJU3noJ65nR7rwuo-v6Fem4sxjmrC5S7lR2VlqVEvP2-ieKoAC0aVlYhdzua-YCkWXSsSBYdHgHrX9jJaAci7E"/>
        <div class="gradient-shade"></div>
    </div>

    <div class="container py-5 relative z-10">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">

                <h2 class="display-2 fw-900 italic text-uppercase text-white tracking-tighter mb-4">
                    Sẵn sàng để <span class="text-brand-red">lột xác?</span>
                </h2>

                <p class="text-white opacity-75 fs-5 text-uppercase tracking-wide mb-5 max-w-xl mx-auto">
                    Đừng trì hoãn thêm một ngày nào nữa. Tương lai của cơ thể bạn bắt đầu từ hôm nay.
                </p>

                <div class="cta-button-wrapper mb-4">
                    <a href="#" class="btn btn-cta-red">
                        Tham gia ngay & Giảm 20% tháng đầu
                    </a>
                </div>

                <div class="text-secondary small text-uppercase fw-bold tracking-widest">
                    Ưu đãi kết thúc sau: <span class="text-white font-mono">12:45:00</span>
                </div>

            </div>
        </div>
    </div>
</section>
</body>
</html>
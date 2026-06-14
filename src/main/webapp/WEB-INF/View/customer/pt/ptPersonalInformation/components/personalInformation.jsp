<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giao diện Coach Trần Quan Huy</title>

    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            font-family: 'Montserrat', sans-serif;
        }

        /* ĐỒNG BỘ ĐỘ RỘNG: Ép về đúng 1140px để thẳng hàng tuyệt đối với widget lịch */
        .profile-container {
            max-width: 1140px;
            margin: 0 auto;
            padding: 0 12px;
        }

        /* Giữ nguyên các thiết lập dẹt bẹt tinh gọn của fen */
        .info-card {
            background-color: #1a1a1a;
            border: 1px solid #2d2d2d;
            border-radius: 12px;
            padding: 25px 35px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .coach-img-wrapper {
            position: relative;
            border-radius: 12px;
            overflow: hidden;
            height: 100%;
            min-height: 380px;
        }

        .coach-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .badge-trainer {
            position: absolute;
            bottom: 15px;
            left: 15px;
            background-color: #e31c25;
            color: #ffffff;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            padding: 5px 12px;
            border-radius: 20px;
            letter-spacing: 1px;
        }

        .coach-name {
            color: #e31c25;
            font-weight: 800;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }

        .coach-slogan {
            color: #a0a0a0;
            font-size: 1.1rem;
            font-style: italic;
            margin-bottom: 0;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
        }
        .stat-number.text-danger-custom { color: #e31c25; }
        .stat-number.text-success-custom { color: #8ae639; }

        .stat-label {
            color: #808080;
            font-size: 0.65rem;
            text-transform: uppercase;
            font-weight: 700;
            margin-top: 2px;
        }

        .divider {
            width: 1px;
            background-color: #333333;
            height: 35px;
            align-self: center;
        }

        .tag-specialty {
            background-color: #2a2a2a;
            border: 1px solid #3d3d3d;
            color: #e0e0e0;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .contact-link {
            color: #a0a0a0;
            text-decoration: none;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .contact-link:hover { color: #e31c25; }

        .coach-bio {
            color: #b0b0b0;
            font-size: 0.9rem;
            line-height: 1.5;
            text-align: justify;
            margin-bottom: 0;
        }

        .btn-message {
            background-color: transparent;
            border: 1px solid #e31c25;
            color: #e31c25;
            padding: 8px 20px;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-message:hover {
            background-color: rgba(227, 28, 37, 0.1);
        }
    </style>
</head>
<body>

<div class="container profile-container" style="margin-top: 1.5px;">
    <div class="row g-4 align-items-stretch">

        <div class="col-12 col-md-4 col-lg-4">
            <div class="coach-img-wrapper">
                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAEIBV9e81e3CkuHigTZXp7QzDd2_GCq3MHTIlyj_fxO-AcOIlLznQgDJ6BSP5Mm_xu50aN42_yQTVr0YRNSTEN40qDSM4nxAh3dLRAckdUmDm_heY3hBepD2wbCRo-Utpqh8sLbdh6AxVRsE7rylNHxm_sGwxOGqBXKn9q9Wf6C0J-8M4rzZGSYuh3gSNTr9vRq8_J2mQetAHjGV1ygEziZFhE-1TAht7iTBkJerSf-bOIclLOXq3s-P3bnpN03_OxXCgrwmryhGc" alt="Nguyen Hoang Nam" class="coach-img">
                <span class="badge-trainer">Master Trainer</span>
            </div>
        </div>

        <div class="col-12 col-md-8 col-lg-8">
            <div class="info-card">

                <div class="mb-3">
                    <h1 class="h3 coach-name">Trần Quan Huy</h1>
                    <p class="coach-slogan">"Khai phá sức mạnh tiềm ẩn trong bạn."</p>
                </div>

                <div class="d-flex align-items-center gap-4 py-2 my-2 border-top border-bottom border-secondary border-opacity-25">
                    <div class="d-flex flex-column">
                        <span class="stat-number text-danger-custom">4+</span>
                        <span class="stat-label">Năm kinh nghiệm</span>
                    </div>
                    <div class="divider"></div>
                    <div class="d-flex flex-column">
                        <span class="stat-number text-danger-custom">20+</span>
                        <span class="stat-label">Học viên thành công</span>
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-2 my-2">
                    <span class="tag-specialty">Tăng cơ chuyên sâu</span>
                    <span class="tag-specialty">Giảm mỡ thần tốc</span>
                </div>

                <div class="d-flex flex-wrap gap-4 my-2">
                    <a href="#" class="contact-link"><i class="bi bi-telephone"></i> Phone/Zalo</a>
                    <a href="#" class="contact-link"><i class="bi bi-envelope"></i> Email</a>
                    <a href="https://www.facebook.com/tr.hy.27797" class="contact-link"><i class="bi bi-facebook"></i> Facebook</a>
                    <a href="#" class="contact-link"><i class="bi bi-instagram"></i> Instagram</a>
                </div>

                <div class="my-2">
                    <p class="coach-bio">
                        Với hơn 4 năm tâm huyết trong ngành fitness, tôi tập trung vào việc xây dựng nền tảng sức mạnh bền vững cho khách hàng. Phương pháp của tôi kết hợp giữa khoa học vận động hiện đại và kỷ luật tập luyện nghiêm ngặt. Cam kết mang lại sự biến đổi toàn diện cả về thể chất lẫn tư duy cho mỗi học viên.
                    </p>
                </div>

                <div class="mt-3">
                    <button class="btn btn-message">
                        <i class="bi bi-chat-left-text"></i> Nhắn tin cho Coach
                    </button>
                </div>

            </div>
        </div>

    </div>
</div>

</body>
</html>
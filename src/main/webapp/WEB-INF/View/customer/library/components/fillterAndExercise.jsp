<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* Filter Buttons */
        .btn-filter {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 50px;
            padding: 8px 24px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.8rem;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .btn-filter:hover, .btn-filter.active {
            background-color: var(--primary-red);
            border-color: var(--primary-red);
            color: white;
        }

        /* Exercise Card */
        .exercise-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
        }

        .exercise-card:hover {
            border-color: rgba(255, 26, 26, 0.5);
            transform: translateY(-5px);
        }

        /* Image Wrapper & Zoom effect */
        .card-img-wrapper {
            position: relative;
            aspect-ratio: 16 / 9;
            overflow: hidden;
            background-color: #1a1a1a;
        }

        .card-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .exercise-card:hover img {
            transform: scale(1.1);
        }

        /* Badge Level */
        .badge-level {
            position: absolute;
            top: 12px;
            left: 12px;
            background-color: var(--primary-red);
            color: white;
            font-size: 10px;
            font-weight: 900;
            padding: 4px 8px;
            border-radius: 4px;
            text-transform: uppercase;
        }

        /* Card Body */
        .card-body-custom {
            padding: 20px;
        }

        .exercise-title {
            font-size: 1.25rem;
            font-weight: 900;
            text-transform: uppercase;
            margin-bottom: 8px;
            transition: color 0.3s;
        }

        .exercise-card:hover .exercise-title {
            color: var(--primary-red);
        }

        .muscle-group {
            color: #888;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }

        .view-detail {
            color: var(--primary-red);
            text-decoration: none;
            font-weight: 800;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Locked State */
        .exercise-card.locked {
            opacity: 0.3;
            filter: blur(1.5px);
            pointer-events: none;
            user-select: none;
        }

        .lock-icon {
            font-size: 3rem;
            color: #444;
        }

        .skeleton-line {
            height: 12px;
            background-color: #333;
            border-radius: 4px;
        }
    </style>
</head>
<body>
<section class="filter-section container mb-5" style = "margin-top: 2%;">
    <div class="d-flex flex-wrap justify-content-center gap-2">
        <button class="btn btn-filter active">Tất cả</button>
        <button class="btn btn-filter">Ngực (Chest)</button>
        <button class="btn btn-filter">Lưng (Back)</button>
        <button class="btn btn-filter">Chân (Legs)</button>
        <button class="btn btn-filter">Vai (Shoulders)</button>
        <button class="btn btn-filter">Tay (Arms)</button>
        <button class="btn btn-filter">Bụng (Abs)</button>
    </div>
</section>

<main class="container pb-5">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-3 row-cols-xl-4 g-4">

        <div class="col">
            <div class="exercise-card group">
                <div class="card-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=2070" alt="Push Up">
                    <span class="badge-level">Cơ Bản</span>
                </div>
                <div class="card-body-custom">
                    <h3 class="exercise-title">Standard Push-up</h3>
                    <p class="muscle-group">Nhóm cơ: Ngực, Vai, Bắp tay sau</p>
                    <a href="#" class="view-detail">
                        XEM CHI TIẾT <span class="material-icons">arrow_forward</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="exercise-card group">
                <div class="card-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070" alt="Deadlift">
                    <span class="badge-level">Nâng Cao</span>
                </div>
                <div class="card-body-custom">
                    <h3 class="exercise-title">Conventional Deadlift</h3>
                    <p class="muscle-group">Nhóm cơ: Toàn thân, Lưng dưới</p>
                    <a href="#" class="view-detail">
                        XEM CHI TIẾT <span class="material-icons">arrow_forward</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="exercise-card group">
                <div class="card-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070" alt="Squat">
                    <span class="badge-level">Phổ biến</span>
                </div>
                <div class="card-body-custom">
                    <h3 class="exercise-title">Barbell Back Squat</h3>
                    <p class="muscle-group">Nhóm cơ: Đùi, Mông, Lõi</p>
                    <a href="#" class="view-detail">
                        XEM CHI TIẾT <span class="material-icons">arrow_forward</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="exercise-card group">
                <div class="card-img-wrapper">
                    <img src="https://images.unsplash.com/photo-1598971639058-fab3c2109d39?q=80&w=2070" alt="Pull up">
                    <span class="badge-level">Thử thách</span>
                </div>
                <div class="card-body-custom">
                    <h3 class="exercise-title">Wide Grip Pull-up</h3>
                    <p class="muscle-group">Nhóm cơ: Xô, Bắp tay trước</p>
                    <a href="#" class="view-detail">
                        XEM CHI TIẾT <span class="material-icons">arrow_forward</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="exercise-card locked">
                <div class="card-img-wrapper d-flex align-items-center justify-content-center">
                    <span class="material-icons lock-icon">lock</span>
                </div>
                <div class="card-body-custom">
                    <div class="skeleton-line w-75"></div>
                    <div class="skeleton-line w-50 mt-2"></div>
                </div>
            </div>
        </div>
    </div>
</main>
</body>
</html>
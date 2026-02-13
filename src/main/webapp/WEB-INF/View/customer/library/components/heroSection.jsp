<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        /* Library Hero Styles */
        .library-hero {
            min-height: 500px;
            background-color: #000;
            padding: 100px 0;
        }

        .relative-z {
            position: relative;
            z-index: 10;
        }

        .hero-bg-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.3; /* Làm mờ ảnh nền */
            filter: grayscale(100%); /* Ảnh đen trắng cho chuyên nghiệp */
        }

        .hero-bg-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to bottom, transparent, var(--dark-bg));
            z-index: 1;
        }

        /* Chữ rỗng (Text Stroke) */
        .text-stroke-custom {
            color: transparent;
            -webkit-text-stroke: 1px rgba(255, 255, 255, 0.5);
        }

        /* Search Bar Styling */
        /* Container bọc ngoài để tạo hiệu ứng đổ bóng lan tỏa */
        .search-container {
            max-width: 800px;
            filter: drop-shadow(0 0 15px rgba(255, 26, 26, 0.1)); /* Đổ bóng nhẹ cho cả cụm */
        }

        .search-input {
            /* Tăng độ đậm của nền và viền */
            background-color: rgba(20, 20, 20, 0.8) !important;
            border: 2px solid rgba(255, 26, 26, 0.4) !important; /* Viền đỏ rõ hơn */
            border-radius: 15px !important;
            padding: 22px 22px 22px 75px !important; /* Tăng padding cho thoáng */
            color: #ffffff !important;
            font-size: 1.25rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px); /* Tạo hiệu ứng kính mờ cho nền */
        }

        /* Hiệu ứng khi nhấn chuột vào (Focus) - Quan trọng nhất để nổi bật */
        .search-input:focus {
            background-color: rgba(30, 10, 10, 0.9) !important;
            border-color: #ff1a1a !important; /* Viền đỏ rực */
            box-shadow: 0 0 25px rgba(255, 26, 26, 0.4) !important; /* Hào quang đỏ tỏa ra */
            outline: none;
            transform: translateY(-2px); /* Nhích nhẹ lên tạo cảm giác nổi khối */
        }

        /* Làm cho Icon kính lúp sáng hơn */
        .search-icon {
            position: absolute;
            left: 25px;
            top: 50%;
            transform: translateY(-50%);
            color: #ff1a1a; /* Đỏ tươi */
            font-size: 2.2rem;
            z-index: 5;
            text-shadow: 0 0 10px rgba(255, 26, 26, 0.5); /* Icon phát sáng */
            transition: all 0.3s ease;
        }

        /* Khi hover vào container thì icon cũng sáng lên */
        .search-container:hover .search-icon {
            color: #ff4d4d;
            transform: translateY(-50%) scale(1.1);
        }

        /* Chỉnh lại màu chữ gợi ý cho dễ đọc hơn tí */
        .search-input::placeholder {
            color: #888;
            font-style: italic;
            opacity: 0.8;
        }
    </style>

</head>
<body>
<header class="library-hero position-relative overflow-hidden d-flex align-items-center">
    <div class="hero-bg-overlay"></div>
    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=2070&auto=format&fit=crop"
         class="hero-bg-img" alt="Gym Background">

    <div class="container relative-z text-center">
        <h1 class="display-1 fw-black italic text-uppercase tracking-tighter mb-4">
            BỨT PHÁ <span class="text-stroke-custom">GIỚI HẠN</span>
        </h1>

        <p class="text-secondary-custom fw-bold text-uppercase tracking-widest mb-5 mx-auto"
           style="max-width: 700px; font-size: 1.1rem;">
            Khám phá hệ thống bài tập chuẩn xác nhất cho mọi mục tiêu hình thể của bạn.
        </p>

        <div class="search-container mx-auto position-relative">
            <span class="material-icons search-icon">search</span>
            <input type="text" class="form-control search-input"
                   placeholder="Tìm kiếm bài tập (ví dụ: Bench Press, Deadlift...)">
        </div>
    </div>
</header>
</body>
</html>
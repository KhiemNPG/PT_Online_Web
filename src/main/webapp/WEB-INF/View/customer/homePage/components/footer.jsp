<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <style>
        :root {
            --primary-red: #f90606;
            --bg-dark: #181111;
            --input-bg: #3a2727;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            color: #ffffff;
            margin: 0;
        }

        /* Hero Section */
        .hero-section {
            padding: 100px 0;
            text-align: center;
        }

        .hero-title {
            font-weight: 900;
            font-size: 3rem;
            letter-spacing: -1px;
            margin-bottom: 1.5rem;
        }

        .text-primary-red {
            color: var(--primary-red);
        }

        .hero-subtitle {
            color: rgba(255, 255, 255, 0.7);
            max-width: 650px;
            margin: 0 auto;
            font-size: 1.1rem;
        }

        /* Footer Styles */
        footer {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 80px;
            padding-bottom: 40px;
        }

        .footer-logo {
            font-weight: 900;
            font-style: italic;
            font-size: 1.5rem;
            text-transform: uppercase;
            letter-spacing: -1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-box {
            background-color: var(--primary-red);
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 4px;
        }

        .footer-heading {
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 1.5rem;
        }

        .footer-link {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
            display: block;
            margin-bottom: 0.75rem;
        }

        .footer-link:hover {
            color: var(--primary-red);
        }

        /* Newsletter Input */
        .form-control-custom {
            background-color: var(--input-bg);
            border: none;
            color: white;
            padding: 12px 15px;
            font-size: 0.9rem;
        }

        .form-control-custom:focus {
            background-color: var(--input-bg);
            color: white;
            box-shadow: 0 0 0 1px var(--primary-red);
        }

        .btn-subscribe {
            background-color: var(--primary-red);
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            padding: 12px;
            border: none;
            width: 100%;
            margin-top: 10px;
            transition: opacity 0.3s;
        }

        .btn-subscribe:hover {
            opacity: 0.9;
            color: white;
        }

        /* Social Icons */
        .social-links a {
            color: rgba(255, 255, 255, 0.4);
            margin-right: 20px;
            transition: color 0.3s;
            text-decoration: none;
        }

        .social-links a:hover {
            color: var(--primary-red);
        }

        .copyright {
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.4);
        }

        .bottom-bar {
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding-top: 30px;
            margin-top: 50px;
        }

        .footer-logo {
            display: flex;
            align-items: center; /* Căn giữa hình và chữ theo chiều dọc */
            gap: 12px;           /* Khoảng cách giữa hình và chữ */
            font-size: 24px;     /* Kích thước chữ PT AI */
            font-weight: bold;
            color: #fff;         /* Màu chữ trắng cho nổi trên nền đen */
        }

        .logo-box img {
            width: 50px;         /* Bạn có thể tùy chỉnh size này */
            height: auto;
            display: block;
            object-fit: contain;
            /* Nếu logo có màu tối, bạn có thể thêm filter để làm sáng nó lên */
            /* filter: brightness(0) invert(1); */
        }

        .text-primary-red {
            color: #ff0000;      /* Màu đỏ đặc trưng của PT AI */
            margin-left: 4px;
        }
    </style>
</head>
<body style="background-color: #000; color: #fff; font-family: 'Inter', sans-serif;">

<section class="py-5" style="background-color: #000;">
    <div class="container">
        <section class="hero-section">
            <h1 class="hero-title">
                Cách mạng hóa quá trình <span class="text-primary-red">tập luyện</span> của bạn
            </h1>
            <p class="hero-subtitle">
                Trải nghiệm huấn luyện viên cá nhân AI thông minh nhất hiện nay. Đạt được mục tiêu nhanh hơn với lộ
                trình cá nhân hóa hoàn toàn.
            </p>
        </section>

        <footer>
            <div class="row gy-5">
                <div class="col-lg-4 col-md-6">
                    <div class="footer-logo mb-3">
                        <div class="logo-box">
                            <img src="https://res.cloudinary.com/dgnyskpc3/image/upload/v1771925947/8955c440-7287-4779-b81f-ada2c991d02c-removebg-preview_holdqj.png" alt="PT AI Logo">
                        </div>
                        <div class="logo-text">
                            PT <span class="text-primary-red">AI</span>
                        </div>
                    </div>
                    <p style="color: rgba(255,255,255,0.6); font-size: 0.85rem; line-height: 1.6;">
                        Tương lai của thể hình. Thay đổi cơ thể bạn với công nghệ huấn luyện AI tiên tiến nhất thế giới.
                    </p>
                </div>

                <div class="col-lg-3 col-md-6 offset-lg-1">
                    <h3 class="footer-heading">Nền tảng</h3>
                    <a href="#" class="footer-link">Tính năng</a>
                    <a href="#" class="footer-link">Công nghệ AI</a>
                    <a href="#" class="footer-link">Lộ trình tập luyện</a>
                    <a href="#" class="footer-link">Bảng giá</a>
                    <a href="#" class="footer-link">Câu chuyện thành công</a>
                </div>

                <div class="col-lg-4 col-md-6">
                    <h3 class="footer-heading">Luôn động lực</h3>
                    <p style="color: rgba(255,255,255,0.6); font-size: 0.85rem;" class="mb-4">
                        Nhận mẹo tập luyện hàng tuần và cập nhật AI mới nhất.
                    </p>
                    <form>
                        <input type="email" class="form-control form-control-custom rounded-3"
                               placeholder="Email của bạn">
                        <button type="submit" class="btn btn-subscribe rounded-3">Đăng ký</button>
                    </form>
                </div>
            </div>

            <div class="row bottom-bar align-items-center">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <div class="social-links">
                        <a href="https://www.facebook.com/share/14TMyZqtpq3/?mibextid=wwXIfr">FB</a>
                        <a href="#">IG</a>
                        <a href="#">YT</a>
                        <a href="#">TK</a>
                    </div>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <p class="copyright mb-0">© 2026 PT AI. Bảo lưu mọi quyền.</p>
                </div>
            </div>
        </footer>
    </div>
</section>

</footer>

</body>
</html>
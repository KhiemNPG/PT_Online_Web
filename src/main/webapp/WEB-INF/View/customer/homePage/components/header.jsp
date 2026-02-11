<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>Header</title>

    <style>
        :root {
            --primary: #f90606;
            --bg-dark: #230f0f;
        }

        body {
            font-family: 'Inter', sans-serif;
        }

        /* Header mờ ảo (Glassmorphism) */
        .custom-nav {
            background-color: rgba(0, 0, 0, 0.9) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(249, 6, 6, 0.1);
            height: 80px;
        }

        /* Logo Hardcore Gym */
        .navbar-brand {
            font-weight: 900;
            font-style: italic;
            letter-spacing: -1px;
            text-transform: uppercase;
        }

        /* Menu links */
        .nav-link-custom {
            color: #ffffff;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            text-decoration: none;
            transition: 0.3s;
        }

        .nav-link-custom:hover, .nav-link-custom.active {
            color: var(--primary) !important;
        }

        /* Nút Đăng nhập */
        .btn-hardcore {
            background-color: var(--primary);
            color: white;
            border-radius: 50px;
            padding: 8px 25px;
            font-weight: 800;
            font-size: 0.75rem;
            text-transform: uppercase;
            border: none;
            transition: 0.3s;
        }

        .btn-hardcore:hover {
            background-color: #d60505;
            box-shadow: 0 4px 15px rgba(249, 6, 6, 0.3);
        }
    </style>
</head>
<body>
<div class="header-main">
    <nav class="navbar navbar-expand-md custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center gap-2" href="#">
                <img src = "">
                <span style="color: white;">HARDCORE<span style="color: var(--primary)">GYM</span></span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav mx-auto gap-4">
                    <a class="nav-link-custom active" href="#">Trang chủ</a>
                    <a class="nav-link-custom" href="#">Thư viện</a>
                    <a class="nav-link-custom" href="#">Gói tập</a>
                    <a class="nav-link-custom" href="#">Tin tức</a>
                </div>

                <div class="d-flex">
                    <button class="btn-hardcore">Đăng nhập</button>
                </div>
            </div>
        </div>
    </nav>
</div>
</body>
</html>
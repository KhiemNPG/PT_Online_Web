<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.PersonalTrainer" %>
<%
    List< PersonalTrainer> personalTrainerList = (List< PersonalTrainer>) request.getAttribute("personalTrainerList");
    %>


    <style>
        :root {
            --elite-red: #ff0000;
            --elite-red-glow: rgba(255, 0, 0, 0.25);
            --glass-white: rgba(255, 255, 255, 0.05);
            --glass-border: rgba(255, 255, 255, 0.1);
            --text-muted: rgba(255, 255, 255, 0.4);
        }

        /* Container bao bọc hệ thống Bento */
        .pt-grid-container {
            font-family: 'Inter', sans-serif;
            background-color: #000;
            color: #fff;
            padding: 40px 0;
        }

        /* Thanh phân cách tiêu đề chuẩn Elite */
        .week-container { display: flex; align-items: center; gap: 20px; margin-bottom: 35px; }
        .week-title { font-size: 1.25rem; font-weight: 700; white-space: nowrap; letter-spacing: -0.5px; text-transform: uppercase; }
        .week-line { flex-grow: 1; height: 1px; background: linear-gradient(90deg, rgba(255, 0, 0, 0.5) 0%, rgba(255, 255, 255, 0) 100%); }

        /* Thẻ Bento Huấn Luyện Viên */
        .pt-workout-card {
            background: var(--glass-white);
            border: 1px solid var(--glass-border);
            border-radius: 1.25rem;
            padding: 1.25rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            transition: 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        /* Hiệu ứng hover rực cháy viền neon */
        .pt-workout-card:hover {
            border: 1px solid var(--elite-red);
            box-shadow: 0 0 20px var(--elite-red-glow);
            transform: scale(1.02);
            background: rgba(255, 0, 0, 0.01);
        }

        /* Khung chứa ảnh chân dung */
        .pt-thumb-container {
            width: 100%;
            height: 220px;
            border-radius: 0.75rem;
            overflow: hidden;
            position: relative;
            background: #111;
            margin-bottom: 0.75rem;
        }
        .pt-thumb-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .pt-workout-card:hover .pt-thumb-container img {
            transform: scale(1.06);
        }

        /* Nhãn dán số năm kinh nghiệm góc ảnh */
        .pt-experience-tag {
            position: absolute;
            top: 12px;
            left: 12px;
            background: var(--elite-red);
            font-size: 0.6rem;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 900;
            z-index: 3;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 8px rgba(255, 0, 0, 0.4);
        }

        /* Thông tin chữ */
        .pt-day-label { font-size: 0.65rem; font-weight: 900; color: #38bdf8; text-transform: uppercase; letter-spacing: 1px; }
        .pt-day-number { font-size: 1.25rem; font-weight: 700; margin-top: 2px; color: #fff; }
        .pt-workout-title { font-size: 0.85rem; font-weight: 800; margin: 0.5rem 0 1rem; min-height: 2.2rem; line-height: 1.3; color: var(--text-muted); }

        /* Hộp thông số Bento phụ */
        .pt-stats-box {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 0.75rem;
            padding: 10px;
            margin-bottom: 1.25rem;
        }
        .pt-stat-item { display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .pt-stat-title { font-size: 0.65rem; font-weight: 800; text-transform: uppercase; color: var(--text-muted); letter-spacing: 0.5px; }
        .pt-stat-value { font-size: 0.85rem; font-weight: 900; color: #fff; margin-top: 2px; }

        /* Nút bấm Đăng ký hành động */
        .btn-start-elite {
            display: block;
            width: 100%;
            box-sizing: border-box;
            background: var(--elite-red);
            color: white !important;
            text-decoration: none !important;
            text-align: center;
            padding: 0.75rem;
            border-radius: 0.75rem;
            font-weight: 900;
            font-size: 0.75rem;
            text-transform: uppercase;
            transition: 0.2s;
            border: none;
            box-shadow: 0 4px 15px rgba(255, 0, 0, 0.2);
            margin-top: auto; /* Ép nút luôn nằm dưới đáy card */
        }
        .btn-start-elite:hover {
            background: #cc0000;
            box-shadow: 0 0 25px var(--elite-red-glow);
            transform: translateY(-1px);
        }

        /* Đèn tín hiệu Zalo hoạt động */
        .pt-zalo-badge {
            font-size: 0.65rem;
            font-weight: 800;
            text-transform: uppercase;
            color: #00ff00;
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 10px;
        }
        .pt-dot-pulse {
            width: 6px;
            height: 6px;
            background-color: #00ff00;
            border-radius: 50%;
            display: inline-block;
            box-shadow: 0 0 8px #00ff00;
        }

        /* Thông báo trống */
        .noSchedule {
            font-weight: 700;
            color: rgba(255, 255, 255, 0.4) !important;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            text-align: center;
            padding: 50px 0;
        }
    </style>

    <div class="container-fluid pt-grid-container px-4">

        <div class="week-container">
            <h2 class="week-title">Đội ngũ Huấn luyện viên Elite</h2>
            <div class="week-line"></div>
        </div>

        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-4">
            <%
            if (personalTrainerList != null && !personalTrainerList.isEmpty()){
            for (PersonalTrainer p: personalTrainerList){
            %>
            <div class="col">
                <div class="pt-workout-card">

                    <div class="pt-thumb-container">
                        <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAu602zr5Gx3stpB9fhsfsIfxzTYiPlU2ol4uaoptF_p99S8TDe5Acy8-c9RN2wR05udU1IOHNvQO_OrMNuRNYGf0iCz0ft_qo8c-xobYevBGcMjwcNteNzcftRgnhRTHuOQmmzlzOzBg4Y6FLZ5y8ekdl7n1uvvESVH_wxbgASqvNUzMKCnil4I6E15ihyXcZKRXr5a1oAjbQZEbfMxXMfq1JaYQPeysdDLHy8ZbhgWVAULimqvtXf_WYAB0mu4iLEe0mrGAjWuvk" alt="Avatar PT">
                        <div class="pt-experience-tag">
                            <%= p.getExperienceYears() %> NĂM KN
                        </div>
                    </div>

                    <div class="pt-day-label font-monospace">MÃ SỐ: PT-<%= p.getPtId() %></div>
                    <div class="pt-day-number text-truncate"><%= p.getName() %></div>
                    <div class="pt-workout-title text-uppercase"><%= p.getTitleLabel() %></div>

                    <div class="pt-zalo-badge">
                        <span class="pt-dot-pulse"></span>
                        <span>ZALO: <%= p.getPhone() %></span>
                    </div>

                    <div class="pt-stats-box">
                        <div class="row g-0 text-center">
                            <div class="col-6 border-end border-secondary border-opacity-10 pt-stat-item">
                                <span class="pt-stat-title">Thành tích</span>
                                <span class="pt-stat-value text-warning d-flex align-items-center gap-1">
                                <span class="material-symbols-outlined text-warning" style="font-size: 14px;">emoji_events</span>
                                <%= p.getSuccessfulStudents() %> HV
                            </span>
                            </div>
                            <div class="col-6 pt-stat-item">
                                <span class="pt-stat-title">Trạng thái</span>
                                <span class="pt-stat-value" style="color: #10b981; font-size: 0.75rem; font-weight: 800; text-transform: uppercase;">
                                Sẵn sàng
                            </span>
                            </div>
                        </div>
                    </div>

                    <a href="javascript:void(0);" class="btn-start-elite">
                        Xem hồ sơ & Đăng ký
                    </a>

                </div>
            </div>
            <%
            }
            } else {
            %>
            <div class="col-12 w-100 text-center py-5">
                <p class="noSchedule">
                    <span class="material-symbols-outlined align-middle me-2" style="font-size: 18px;">error_medallion</span>
                    Hiện tại hệ thống chưa cập nhật dữ liệu Huấn luyện viên nào!
                </p>
            </div>
            <%
            }
            %>
        </div>
    </div>
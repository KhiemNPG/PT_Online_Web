<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.training.Exercise" %> <%-- QUAN TRỌNG: Phải import cái này --%>
<%@ page import="model.training.Video" %>
<%@ page isELIgnored="false" %>
<%
Exercise exercise = (Exercise) request.getAttribute("exercise");
%>
    <style>
        :root {
            --bg-black: #050505;
            --card-bg: rgba(20, 20, 20, 0.7);
            --accent-red: #e61e32;
            --text-gray: #a0a0a0;
            --border-color: rgba(255, 255, 255, 0.08);
        }

        body {
            background-color: var(--bg-black);
            color: #ffffff;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding-bottom: 100px;
        }

        /* --- Video Header Section --- */
        .video-header {
            position: relative;
            height: 60vh;
            background: linear-gradient(to bottom, transparent 60%, var(--bg-black)),
                        url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop') center/cover;
            display: flex;
            align-items: flex-end;
            padding: 40px;
        }

        .close-btn {
            position: absolute;
            top: 30px;
            right: 30px;
            background: rgba(255,255,255,0.1);
            border: none;
            color: white;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            backdrop-filter: blur(10px);
            font-size: 20px;
        }

        .play-main-btn {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80px;
            height: 80px;
            background: var(--accent-red);
            border: none;
            border-radius: 50%;
            color: white;
            font-size: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 40px rgba(230, 30, 50, 0.4);
        }

        .badge-pro {
            background: var(--accent-red);
            font-size: 10px;
            font-weight: 800;
            padding: 4px 8px;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* --- Content Layout --- */
        .section-title {
            border-left: 4px solid var(--accent-red);
            padding-left: 15px;
            font-weight: 800;
            margin-bottom: 30px;
        }

        .step-number {
            color: var(--accent-red);
            font-weight: 900;
            font-size: 1.2rem;
            margin-right: 15px;
        }

        .step-item {
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
        }

        .step-content p {
            color: var(--text-gray);
            font-size: 0.95rem;
            margin: 0;
        }

        /* --- PT Notes Box --- */
        .pt-notes-card {
            background: var(--card-bg);
            border: 1px solid rgba(230, 30, 50, 0.3);
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(10px);
        }

        .pt-title {
            font-weight: 800;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .warning-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .warning-icon {
            color: var(--accent-red);
            font-size: 1.2rem;
        }

        /* --- Floating Action Button --- */
        .ai-float-btn {
            position: fixed;
            bottom: 100px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--accent-red);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 14px;
            box-shadow: 0 0 30px rgba(230, 30, 50, 0.6);
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* --- Bottom Nav --- */
        .bottom-nav {
            position: fixed;
            bottom: 0;
            width: 100%;
            background: rgba(10, 10, 10, 0.95);
            border-top: 1px solid var(--border-color);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
        }

        .progress-text {
            color: #4ade80; /* Green */
            font-size: 0.85rem;
        }

        .next-btn {
            background: #1a1a1a;
            border: 1px solid var(--border-color);
            color: white;
            padding: 8px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .next-btn .arrow {
            background: var(--accent-red);
            width: 24px;
            height: 24px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        /* --- Bottom Navigation Styles --- */
        .bottom-nav {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background: rgba(10, 10, 10, 0.98); /* Nền đen gần như tuyệt đối */
            border-top: 1px solid rgba(255, 255, 255, 0.1); /* Đường kẻ mờ phía trên */
            padding: 12px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 1000;
            backdrop-filter: blur(10px); /* Hiệu ứng mờ hậu cảnh */
        }

        /* Chấm xanh tiến độ */
        .progress-dot {
            width: 10px;
            height: 10px;
            background: #4ade80; /* Màu xanh lá sáng */
            border-radius: 50%;
            box-shadow: 0 0 10px rgba(74, 222, 128, 0.5);
        }

        .progress-text {
            color: #4ade80;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Nút điều hướng bài tiếp theo */
        .next-btn {
            background: #1a1a1a;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            padding: 6px 6px 6px 15px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
        }

        .next-btn:hover {
            background: #252525;
            border-color: rgba(230, 30, 50, 0.5);
        }

        .next-label {
            font-size: 9px;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .next-exercise-name {
            font-weight: 700;
            font-size: 0.9rem;
        }

        /* Ô vuông màu đỏ chứa mũi tên */
        .arrow-box {
            background: #e61e32; /* Màu đỏ chủ đạo */
            width: 28px;
            height: 28px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }

        /* Container cho các bước tập */
        .instruction-container {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        /* Card cho từng bước */
        .step-card {
            background: linear-gradient(90deg, rgba(255,255,255,0.03) 0%, transparent 100%);
            border-left: 2px solid var(--accent-red);
            padding: 15px 20px;
            border-radius: 0 12px 12px 0;
            transition: transform 0.3s ease;
        }

        .step-card:hover {
            transform: translateX(10px);
            background: linear-gradient(90deg, rgba(230, 30, 50, 0.1) 0%, transparent 100%);
        }

        .step-text {
            color: #e0e0e0;
            font-size: 0.95rem;
            line-height: 1.6;
            margin: 0;
        }

        /* Box cho Mẹo tập luyện */
        .tip-box {
            background: rgba(255, 255, 255, 0.05);
            border: 1px dashed rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
            overflow: hidden;
        }

        /* Hiệu ứng vết sáng cho Tip Box */
        .tip-box::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: #4ade80; /* Màu xanh lá cho Tip */
        }

        .tip-icon {
            font-size: 1.5rem;
            filter: drop-shadow(0 0 10px rgba(74, 222, 128, 0.5));
        }

        .tip-content p {
            color: #4ade80;
            font-style: italic;
            font-weight: 500;
        }
    </style>

<header class="video-header" style="padding: 0; overflow: hidden; background: black;">
    <button class="close-btn" style="z-index: 10;" onclick="window.history.back()">✕</button>

    <%
    // Logic xử lý link Youtube từ DB (chuyển sang dạng embed)
    //String youtubeUrl = (exercise.getVideo() != null) ? exercise.getVideo().getUrl() : "";
    String youtubeUrl = "https://www.youtube.com/watch?v=SiJuuAlEZj4";
    String embedUrl = "";
    if (youtubeUrl.contains("v=")) {
    embedUrl = "https://www.youtube.com/embed/" + youtubeUrl.split("v=")[1].split("&")[0];
    } else if (youtubeUrl.contains("youtu.be/")) {
    embedUrl = "https://www.youtube.com/embed/" + youtubeUrl.split("youtu.be/")[1];
    }
    %>

    <% if (!embedUrl.isEmpty()) { %>
    <iframe width="100%" height="100%"
            src="<%= embedUrl %>?autoplay=0&mute=0&rel=0&modestbranding=1"
            title="YouTube video player"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            allowfullscreen
            style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;">
    </iframe>
    <% } else { %>
    <div class="video-placeholder" style="width: 100%; height: 100%; background: url('<%= exercise.getVideo().getThumbnailUrl() %>') center/cover;">
        <button class="play-main-btn">▶</button>
    </div>
    <% } %>

    <div class="header-info" style="position: absolute; bottom: 40px; left: 40px; pointer-events: none; z-index: 5;">
        <span class="badge-pro mb-2 d-inline-block"><%= exercise.getDifficultyLevel() %></span>
        <h1 class="fw-black display-5 m-0"><%= exercise.getExerciseName() %></h1>
    </div>
</header>

<div class="container mt-5">
    <div class="row gx-lg-5">
        <div class="col-lg-6 mb-5">
            <h3 class="section-title">Hướng dẫn kỹ thuật</h3>
            <div class="instruction-container mb-5">
                <%
                String ins = exercise.getInstructions();
                if (ins != null) {
                // Tách theo dấu chấm hoặc chấm phẩy để tạo list
                String[] steps = ins.split("[.;]");
                for (String step : steps) {
                if(!step.trim().isEmpty()) {
                %>
                <div class="step-card">
                    <div class="step-indicator"></div>
                    <p class="step-text"><%= step.trim() %>.</p>
                </div>
                <%
                }
                }
                }
                %>
            </div>

            <h3 class="section-title">Mẹo tập luyện</h3>
            <div class="tip-box">
                <div class="tip-icon">💡</div>
                <div class="tip-content">
                    <p class="mb-0"><%= exercise.getTips() %></p>
                </div>
            </div>
        </div>

        <div class="col-lg-5 offset-lg-1">
            <div class="pt-notes-card">
                <h5 class="pt-title mb-4">
                    <span class="warning-icon">🛡️</span> Lỗi phổ biến
                </h5>

                <%
                String mistakesStr = exercise.getCommonMistakes();
                if (mistakesStr != null && !mistakesStr.isEmpty()) {
                // Tách chuỗi dựa trên dấu chấm phẩy
                String[] mistakesArray = mistakesStr.split(";");
                for (String mistake : mistakesArray) {
                if (!mistake.trim().isEmpty()) { // Kiểm tra để tránh dòng trống
                %>
                <div class="warning-item mb-3">
                    <span class="warning-icon">⚠️</span>
                    <small class="text-light"><%= mistake.trim() %></small>
                </div>
                <%
                }
                }
                } else {
                %>
                <p class="text-secondary small">Không có dữ liệu lỗi phổ biến.</p>
                <% } %>

                <hr class="my-4 opacity-10">
                <p class="fst-italic text-secondary small text-center">
                    "Kỹ thuật chuẩn quan trọng hơn khối lượng tạ. Hãy lắng nghe cơ thể bạn."
                </p>
            </div>
        </div>
    </div>
</div>

<button class="ai-float-btn">
    📷 PHÂN TÍCH TƯ THẾ (AI)
</button>

<footer class="bottom-nav">
    <div class="progress-info d-flex align-items-center gap-2">
        <div class="progress-dot"></div>
        <span class="progress-text">Bạn đã hoàn thành 80% lộ trình hôm nay</span>
    </div>

    <button class="next-btn">
        <div class="text-end me-2">
            <div class="next-label">Tiếp theo</div>
            <div class="next-exercise-name">Leg Extensions</div>
        </div>
        <div class="arrow-box">❯</div>
    </button>
</footer>



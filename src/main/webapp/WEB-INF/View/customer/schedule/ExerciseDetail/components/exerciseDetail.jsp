<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.training.Exercise" %> <%-- QUAN TRỌNG: Phải import cái này --%>
<%@ page import="model.training.Video" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
    String userDayIdStr = request.getParameter("userDayId");
    int userDayId = 0;
    if (userDayIdStr != null && !userDayIdStr.isEmpty()) {
        userDayId = Integer.parseInt(userDayIdStr);
    }
    double percentExercise = 0;
    int currentIndex = 0, nextIdExercise = 0;
    Exercise exercise = (Exercise) request.getAttribute("exercise");
    int lastId = (int) request.getAttribute("lastId");
    boolean isCompleted = (boolean) request.getAttribute("isCompleted");
    List< Exercise> exerciseList = (List< Exercise>) request.getAttribute("exerciseList");
    if (exercise != null && exerciseList != null && !exerciseList.isEmpty()) {
        for (int i = 0; i < exerciseList.size(); i++){
        Exercise ex = exerciseList.get(i);
        if (exercise.getExerciseId() == ex.getExerciseId()){
        currentIndex = i;
        if(currentIndex < exerciseList.size() - 1){
        Exercise ex2 = exerciseList.get(currentIndex + 1);
        nextIdExercise = ex2.getExerciseId();
    } else {
    //Exercise ex2 = exerciseList.get(currentIndex);
        nextIdExercise = -1;
    }
        currentIndex += 1;
        break;
    }

}
if (currentIndex > 0) {
percentExercise = ((double) currentIndex / exerciseList.size()) * 100;
}
}
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

    .progress-info {
        padding: 10px;
        border-radius: 8px;
        transition: background-color 0.3s;
        border: 1px solid transparent;
    }

    .progress-info:hover {
        background-color: #f0fdf4; /* Màu xanh lá nhạt */
        border: 1px solid #22c55e;
    }

    .progress-dot-checkbox i {
        font-size: 1.2rem;
        color: #22c55e;
    }

    .next-btn-final {
        display: inline-flex;
        align-items: center;
        background-color: #0984e3; /* Màu xanh dương thể thao, có thể đổi thành #00b894 (Mint) */
        color: white !important;
        padding: 8px 16px;
        border-radius: 6px;
        text-decoration: none;
        border: none;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        transition: transform 0.2s ease;
    }

    .next-btn-final:hover {
        background-color: #0773c5;
        transform: translateY(-2px);
    }

    .final-content {
        text-align: right;
        line-height: 1.2;
    }

    .final-label {
        font-size: 11px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        opacity: 0.9;
    }

    .final-main-text {
        font-size: 14px;
        font-weight: 600;
        display: block;
    }

    .final-sub-text {
        font-size: 10px;
        opacity: 0.8;
        font-weight: 300;
        display: block;
        margin-top: 2px;
    }

    .my-success-toast-green {
        border-right: 5px solid #05c46b !important;
        box-shadow: 0 0 15px rgba(5, 196, 107, 0.3) !important;
        border-radius: 8px !important;
    }
</style>

<%
    if ( exerciseList == null || exerciseList.isEmpty() || exercise == null){
%>
        <div class="no-schedule-container text-center py-5">
            <div class="no-schedule-icon mb-4">
                <i class="bi bi-calendar-x" style="font-size: 5rem; color: var(--crimson); filter: drop-shadow(0 0 15px rgba(230, 30, 50, 0.4));"></i>
            </div>

            <h2 class="no-schedule-title" style="color: #ffffff; font-weight: 800; letter-spacing: 2px; font-size: 2.2rem; text-transform: uppercase;">
                Không có lịch tập
            </h2>

            <p class="no-schedule-text" style="color: #b0b0b0; font-size: 1.1rem; max-width: 500px; margin: 0 auto 30px; line-height: 1.6;">
                Hiện tại bạn chưa có bài tập nào được sắp xếp cho hôm nay. <br>
                Hãy bắt đầu hành trình chinh phục bản thân bằng cách thiết lập mục tiêu mới!
            </p>

            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn-elite-outline"
                   style="display: inline-block; padding: 12px 35px; border: 2px solid #ffffff; color: #ffffff; text-decoration: none; font-weight: bold; border-radius: 50px; transition: 0.3s; text-transform: uppercase;">
                    Quay về trang chủ
                </a>
            </div>
        </div>
<%
    } else {
%>
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

<a href="${pageContext.request.contextPath}/UpLoadVideo" class="ai-float-btn" style="text-decoration: none; display: inline-block;">
    📷 PHÂN TÍCH TƯ THẾ (AI)
</a>


<footer class="bottom-nav">
    <%
    if (isCompleted == false) {
    // Trường hợp chưa hoàn thành và là bài tập cuối cùng
    if (exercise != null && exercise.getExerciseId() == lastId) {
    %>
    <div class="progress-info d-flex align-items-center gap-2"
         id="finish-session-btn"
         style="cursor: pointer;"
         onclick="confirmCompletion()">
        <div class="progress-dot-checkbox">
            <i class="bi bi-circle" id="check-icon" style="font-size: 1.2rem; color: #0fbcf9;"></i>
        </div>
        <span class="progress-text">
            Bạn đã xong <%= percentExercise %>% buổi tập?
            <strong style="color: #0fbcf9;">Nhấn vào đây để xác nhận hoàn thành</strong>
        </span>
    </div>
    <%
    } else {
    // Trường hợp chưa hoàn thành nhưng chưa đến bài cuối
    %>
    <div class="progress-info d-flex align-items-center gap-2">
        <div class="progress-dot" style="background-color: #ffd32a;"></div>
        <span class="progress-text">Bạn đã hoàn thành <%= percentExercise %>% lộ trình hôm nay</span>
    </div>
    <%
    }
    } else {
    // TRƯỜNG HỢP ĐÃ PHÁ ĐẢO (isCompleted == true)
    %>
    <div class="progress-info d-flex align-items-center gap-2">
        <div class="progress-dot-checkbox">
            <i class="bi bi-check-circle-fill" style="font-size: 1.2rem; color: #05c46b;"></i>
        </div>
        <span class="progress-text" style="color: #05c46b; font-weight: bold;">
            🔥 Đã phá đảo lộ trình hôm nay! (100%)
        </span>
    </div>
    <%
    }
    %>

    <% if (nextIdExercise != -1) { %>
    <a href="${pageContext.request.contextPath}/ExerciseDetail?id=<%= nextIdExercise %>&userDayId=<%= userDayId%>" class="next-btn" style="text-decoration: none; display: flex; align-items: center;">
        <div class="text-end me-2">
            <div class="next-label" style="font-size: 0.8rem; color: #6c757d;">Tiếp theo</div>
            <div class="next-exercise-name" style="font-weight: bold; color: white;">
                <%= (exerciseList.get(currentIndex).getExerciseName()) %>
            </div>
        </div>
        <div class="arrow-box">❯</div>
    </a>
    <% } else { %>
    <div class="next-btn-final">
        <div class="final-content">
            <span class="final-label">Về đích 🔥</span>
            <span class="final-main-text">Bài cuối rồi, cố lên!</span>
        </div>
        <div style="font-size: 20px; margin-left: 12px;">💪</div>
    </div>
    <% }
    }%>
</footer>

<script>
    function confirmCompletion() {
        // Lấy cái div nút bấm ra để xử lý
        const btnContainer = document.getElementById('finish-session-btn');

        // [FIX 1]: Kiểm tra nếu đã hoàn thành hoặc đang xử lý thì thoát luôn
        if (btnContainer.classList.contains('is-finished')) return;

        Swal.fire({
            title: 'Hoàn thành buổi tập?',
            text: 'Hệ thống sẽ ghi nhận nỗ lực của bạn hôm nay!',
            icon: 'question',
            iconColor: '#0fbcf9',
            background: '#1e272e',
            color: '#ffffff',
            showCancelButton: true,
            confirmButtonColor: '#0fbcf9',
            cancelButtonColor: '#3d3d3d',
            confirmButtonText: 'Xác nhận xong!',
            cancelButtonText: 'Chưa, tập tiếp',
            backdrop: `rgba(0,0,0,0.8)`
        }).then((result) => {
            if (result.isConfirmed) {

                // [FIX 2]: Dán nhãn và khóa tương tác ngay lập tức khi vừa bấm Xác nhận
                btnContainer.classList.add('is-finished');
                btnContainer.style.pointerEvents = 'none';
                btnContainer.style.opacity = '0.7';

                // Bước 1: Hiện trạng thái đang xử lý (Loading)
                Swal.fire({
                    title: 'Đang lưu tiến độ...',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    },
                    background: '#1e272e',
                    color: '#ffffff'
                });

                // Bước 2: Chuẩn bị dữ liệu
                const params = new URLSearchParams();
                params.append('userDayId', '<%= userDayId %>');
                // Check null/empty cho list để tránh lỗi JSP
                <% if (exerciseList != null && !exerciseList.isEmpty()) { %>
                    params.append('id', '<%= exerciseList.get(exerciseList.size() - 1).getExerciseId() %>');
                <% } %>

                // Bước 3: Gửi POST đến Servlet
                fetch('ExerciseDetail', {
                    method: 'POST',
                    body: params,
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                })
                .then(response => {
                    if (response.ok) {
                        // 1. Cập nhật icon và chữ trên giao diện
                        const icon = document.getElementById('check-icon');
                        if(icon) {
                            icon.className = 'bi bi-check-circle-fill me-2';
                            icon.style.color = "#05c46b";
                        }
                        const text = document.querySelector('.progress-text');
                        if(text) {
                            text.style.color = "#05c46b";
                            text.innerHTML = "🔥 Đã phá đảo lộ trình hôm nay!";
                        }

                        // 2. Cấu hình Toast nhỏ gọn góc trên bên phải
                        const Toast = Swal.mixin({
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 2500,
                            timerProgressBar: true,
                            background: '#121212',
                            color: '#ffffff',
                            iconColor: '#05c46b',
                            customClass: {
                                popup: 'my-success-toast-green'
                            },
                            showClass: {
                                popup: 'animate__animated animate__fadeInRight'
                            },
                            hideClass: {
                                popup: 'animate__animated animate__fadeOutRight'
                            }
                        });

                        Toast.fire({
                            icon: 'success',
                            title: '<span style="font-weight:700; text-transform:uppercase; letter-spacing:1px;">Tuyệt vời!</span>',
                            html: '<span style="font-size:13px; color:#bbb;">Hệ thống đã ghi nhận nỗ lực của bạn.</span>'
                        });

                    } else {
                        throw new Error('Update failed');
                    }
                })
                .catch(error => {
                    // [FIX 3]: Nếu lỗi, gỡ nhãn để người dùng có thể bấm thử lại
                    btnContainer.classList.remove('is-finished');
                    btnContainer.style.pointerEvents = 'auto';
                    btnContainer.style.opacity = '1';

                    Swal.fire({
                        title: 'Lỗi!',
                        text: 'Không thể cập nhật Database. Vui lòng thử lại.',
                        icon: 'error',
                        background: '#1e272e',
                        color: '#ffffff'
                    });
                });
            }
        })
    }
</script>



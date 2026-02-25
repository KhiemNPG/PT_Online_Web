<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ page import="java.util.List" %>
<%@ page import="model.training.Exercise" %>
<%@ page import="model.training.TrainingWorkoutExercise" %>
<%
        String idParam = request.getParameter("id");
        Object idAttr = request.getAttribute("userDayId");

        int userDayIdTemp = -1;

        if (idAttr != null) {
        userDayIdTemp = Integer.parseInt(idAttr.toString());
        } else if (idParam != null) {
        userDayIdTemp = Integer.parseInt(idParam);
        }

    List<Exercise> exerciseList = (List) request.getAttribute("exerciseList");
    List<TrainingWorkoutExercise> trainingWorkoutExerciseList = (List) request.getAttribute("trainingWorkoutExerciseList");
        %>
        <style>
            :root {
                --bg-dark: #0a0a0a;
                --sidebar-bg: #121212;
                --crimson: #e61e32;
                --glass: rgba(255, 255, 255, 0.05);
                --glass-border: rgba(255, 255, 255, 0.1);
            }

            body {
                background-color: var(--bg-dark);
                color: white;
                font-family: 'Inter', sans-serif;
                height: 100vh;
                margin: 0;
            }

            /* Sidebar */
            .sidebar {
                background-color: var(--sidebar-bg);
                border-right: 1px solid var(--glass-border);
                height: 100vh;
                overflow-y: auto; /* Cho phép cuộn dọc */

                /* Ẩn thanh cuộn cho Chrome, Safari và Opera */
                -webkit-overflow-scrolling: touch;
            }

            .exercise-card {
                background: var(--glass);
                border: 1px solid var(--glass-border);
                border-radius: 15px;
                padding: 15px;
                margin-bottom: 15px;
                transition: 0.3s;
                cursor: pointer;
                display: flex;
                align-items: center;
            }

            .sidebar::-webkit-scrollbar {
            display: none; /* Chrome, Safari, Opera */
            }

            /* Ẩn thanh cuộn cho IE, Edge và Firefox */
            .sidebar {
                -ms-overflow-style: none;  /* IE và Edge */
                scrollbar-width: none;  /* Firefox */
            }

            .exercise-card.active-status {
                border-color: var(--crimson);
                box-shadow: 0 0 20px rgba(230, 30, 50, 0.2);
                background: rgba(255, 255, 255, 0.1);
            }

            .thumb-box {
                width: 60px;
                height: 60px;
                background: #222;
                border-radius: 8px;
                margin-right: 15px;
                object-fit: cover;
            }

            /* Main Content */
            .video-section {
                padding: 40px;
                display: flex;
                flex-direction: column;
                height: 100vh;
            }

            .video-container {
                flex-grow: 1;
                background: #111;
                border-radius: 30px;
                position: relative;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid var(--glass-border);
                background-size: cover;
                background-position: center;
            }

            .video-overlay-text {
                position: absolute;
                bottom: 30px;
                left: 40px;
                text-align: left;
            }

            .play-btn {
                width: 90px;
                height: 90px;
                background: var(--crimson);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                border: none;
                color: white;
                font-size: 30px;
                box-shadow: 0 0 50px rgba(230, 30, 50, 0.5);
                transition: 0.3s;
                z-index: 10;
            }

            .btn-start {
                background-color: var(--crimson);
                color: white;
                border: none;
                width: 100%;
                padding: 20px;
                border-radius: 15px;
                font-weight: 900;
                font-size: 1.5rem;
                letter-spacing: 2px;
                margin-top: 30px;
                text-transform: uppercase;
                box-shadow: 0 10px 30px rgba(230, 30, 50, 0.3);
            }
        </style>

        <div class="container-fluid p-0">
            <div class="row g-0">
                <aside class="col-md-3 sidebar p-4">
                    <h4 class="fw-bold mb-4">Bài tập hôm nay</h4>

                    <%
                    if (exerciseList != null) {
                    for (int i = 0; i < exerciseList.size(); i++) {
                    Exercise ex = exerciseList.get(i);

                    // Lấy dữ liệu bài tập
                    String exName = (ex.getExerciseName() != null) ? ex.getExerciseName() : "Không tên";

                    // FIX: Sử dụng getPrimaryMuscle() thay vì getMuscleGroup()
                    String exMuscle = (ex.getPrimaryMuscle() != null) ? ex.getPrimaryMuscle() : "Đang cập nhật";

                    String videoUrl = (ex.getVideo() != null) ? ex.getVideo().getUrl() : "";
                    String thumbUrl = (ex.getVideo() != null) ? ex.getVideo().getThumbnailUrl() : "";

                    // Trạng thái hoàn thành
                    boolean isDone = false;
                    if(trainingWorkoutExerciseList != null && i < trainingWorkoutExerciseList.size()){
                    isDone = trainingWorkoutExerciseList.get(i).isFinished();
                    }

                    // Biến CSS class để tránh lỗi "cannot be resolved"
                    String statusClass = isDone ? "active-status" : "";
                    %>

                    <div class="exercise-card <%= statusClass %>"
                         data-id="<%= ex.getExerciseId() %>"
                         data-name="<%= exName %>"
                         data-muscle="<%= exMuscle %>"
                         data-video="<%= videoUrl %>"
                         data-thumb="<%= thumbUrl %>">

                        <img class="thumb-box" src="<%= thumbUrl %>" alt="<%= exName %>">

                        <div>
                            <div class="fw-bold text-uppercase small"><%= exName %></div>
                            <div class="text-secondary small">
                                <%= ex.getDefaultSets() %> hiệp x <%= ex.getDefaultReps() %> lần
                            </div>
                        </div>
                    </div>

                    <%
                    }
                    }
                    %>
                </aside>

                <main class="col-md-9 video-section">
                    <div class="video-container" id="videoContainer" style="background-image: linear-gradient(to top, rgba(0,0,0,0.8), transparent);">
                        <button class="play-btn">▶</button>

                        <div class="video-overlay-text">
                            <h1 id="mainExName" class="display-5 fw-bold text-uppercase m-0">Chọn bài tập</h1>
                            <p id="mainExMuscle" class="text-secondary fs-5">Hãy chọn bài tập để xem chi tiết</p>
                        </div>
                    </div>

                    <a id="btnStartLink" href="javascript:void(0);">
                        <button class="btn-start" id="btnStart">Bắt đầu ngay</button>
                    </a>
                </main>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const cards = document.querySelectorAll('.exercise-card');
                const btnStartLink = document.getElementById('btnStartLink');

                // Lấy userDayId từ JSP ném vào JS
                const userDayId = "<%= userDayIdTemp %>";

                cards.forEach(card => {
                    card.addEventListener('click', function() {
                        // 1. Lấy exerciseId từ card
                        const exerciseId = this.getAttribute('data-id');

                        // 2. Cập nhật các thông tin khác (Name, Muscle, Thumb...) như cũ
                        const name = this.getAttribute('data-name');
                        const muscle = this.getAttribute('data-muscle');
                        const thumb = this.getAttribute('data-thumb');

                        document.getElementById('mainExName').innerText = name;
                        document.getElementById('mainExMuscle').innerText = muscle;
                        document.getElementById('videoContainer').style.backgroundImage =
                            `linear-gradient(to top, rgba(0,0,0,0.9), transparent), url('${thumb}')`;

                        // 3. Cập nhật URL cho nút Bắt đầu ngay
                        // Thay 'your-url' bằng đường dẫn controller của bro
                        btnStartLink.href = `ExerciseDetail?id=${exerciseId}&userDayId=${userDayId}`;

                        // Highlight card
                        cards.forEach(c => c.style.borderColor = "rgba(255, 255, 255, 0.1)");
                        this.style.borderColor = "#e61e32";
                    });
                });
            });
        </script>
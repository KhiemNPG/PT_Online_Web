<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.training.TrainingSchedule"%>
<%@page import="model.tracking.MasterScheduleDetail"%>
<%@page import="model.tracking.Progress"%>
<%@page import="model.training.TrainingDay"%>
<%@ page import="java.util.List,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<%@ page isELIgnored="false" %>

<%
List< TrainingSchedule> TrainingScheduleList = (List< TrainingSchedule>) request.getAttribute("TrainingSchedule");
List< TrainingDay> trainingDayList = (List< TrainingDay>) request.getAttribute("trainingDayList");
MasterScheduleDetail masterScheduleDetail = (MasterScheduleDetail) request.getAttribute("masterScheduleDetail");
String nameSchedule = (String) request.getAttribute("NameSchedule");
Progress progress = (Progress) request.getAttribute("progress");
int weekIndex = -1, userDayId = 0, workoutStreak = 0;
LocalDate firstDate = null;
String workoutName = "", dayType = "";
boolean isCompleted = false;

// KIỂM TRA NẾU CHƯA CÓ LỘ TRÌNH
if (TrainingScheduleList == null || TrainingScheduleList.isEmpty()) {
%>
<style>
    :root { --primary-red: #f90606; --dark-bg: #0a0a0a; --card-bg: rgba(255, 255, 255, 0.05); --border-color: rgba(255, 255, 255, 0.1); --text-gray: rgba(255, 255, 255, 0.6); }
    body { background-color: var(--dark-bg); font-family: 'Inter', sans-serif; color: #ffffff; }
    .card-custom { background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 1.25rem; padding: 1.5rem; backdrop-filter: blur(15px); }
    .btn-primary-custom { background: var(--primary-red); color: white; border: none; padding: 12px 25px; border-radius: 10px; font-weight: 900; text-transform: uppercase; text-decoration: none; display: inline-flex; align-items: center; gap: 10px; transition: 0.3s; box-shadow: 0 5px 15px rgba(249, 6, 6, 0.3); }
    .italic { font-style: italic; } .fw-black { font-weight: 900; }
</style>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,400,0,0" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<div class="container ">
    <div class="col-12 text-center py-5">
        <div class="card-custom" style="border: 1px dashed var(--border-color); background: rgba(255,255,255,0.02);">
            <div class="">
                <span class="material-symbols-outlined" style="font-size: 4rem; color: var(--text-gray); opacity: 0.3;">fitness_center</span>
                <h3 class="h4 fw-black text-uppercase italic mt-3">Chưa tìm thấy lộ trình</h3>
                <p class="text-secondary mx-auto mb-4" style="max-width: 400px;">
                    Có vẻ như bạn chưa thiết lập mục tiêu luyện tập. Hãy để AI giúp bạn xây dựng lộ trình cá nhân hóa ngay bây giờ.
                </p>
                <div class="d-flex justify-content-center">
                    <a href="${pageContext.request.contextPath}/setup/goal" class="btn-primary-custom">
                        <span>THIẾT LẬP LỘ TRÌNH NGAY</span>
                        <span class="material-symbols-outlined">rocket_launch</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<%
} else {
// NẾU CÓ LỘ TRÌNH -> CHẠY LOGIC XỬ LÝ
if (trainingDayList != null && !trainingDayList.isEmpty()) {
LocalDate today = LocalDate.now();
if (trainingDayList.get(0).getScheduledDate() != null) {
firstDate = trainingDayList.get(0).getScheduledDate().toLocalDateTime().toLocalDate();
if (today.isBefore(firstDate)) {
weekIndex = 0;
} else {
for (TrainingDay trainingDay : trainingDayList) {
if (trainingDay.getScheduledDate() != null) {
LocalDate startDate = trainingDay.getScheduledDate().toLocalDateTime().toLocalDate();
if (today.isEqual(startDate)) {
weekIndex = trainingDay.getWeekIndex();
workoutName = trainingDay.getWorkoutLabel();
isCompleted = trainingDay.isCompleted();
userDayId = trainingDay.getMasterDayId();
dayType = trainingDay.getDayType();
if (trainingDay.isCompleted()) workoutStreak++;
}
if (trainingDay.isCompleted() && today.isBefore(startDate)){
workoutStreak++;
} else {
// logic streak của bro
}
}
}
}
}
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ - Lộ Trình Tập Luyện</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,400,0,0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-red: #f90606;
            --dark-bg: #0a0a0a;
            --card-bg: rgba(255, 255, 255, 0.05);
            --border-color: rgba(255, 255, 255, 0.1);
            --text-gray: rgba(255, 255, 255, 0.6);
            --success-green: #00ff88;
        }
        body { background-color: var(--dark-bg); font-family: 'Inter', sans-serif; color: #ffffff; overflow-x: hidden; }
        .italic { font-style: italic; }
        .fw-black { font-weight: 900; }
        .text-primary { color: var(--primary-red) !important; }
        .card-custom { background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 1.25rem; padding: 1.5rem; backdrop-filter: blur(15px); margin-bottom: 1.5rem; transition: all 0.3s ease; }
        .timeline-container { position: relative; padding-left: 3rem; margin-top: 2rem; }
        .timeline-container::before { content: ""; position: absolute; left: 11px; top: 0; bottom: 0; width: 3px; background: linear-gradient(to bottom, var(--primary-red) 0%, rgba(249, 6, 6, 0.3) 40%, rgba(255, 255, 255, 0.05) 100%); z-index: 0; }
        .timeline-item { position: relative; margin-bottom: 2.5rem; z-index: 1; }
        .timeline-dot { position: absolute; left: -52px; top: 12px; width: 32px; height: 32px; border-radius: 50%; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease; background: #1a1a1a; border: 2px solid #333; z-index: 100 !important; pointer-events: auto; }
        .item-active .timeline-dot { background: var(--primary-red); border: 3px solid #ffffff; box-shadow: 0 0 20px var(--primary-red); animation: pulse-red 2s infinite; }
        .item-active .card-custom { border: 1px solid var(--primary-red); background: rgba(249, 6, 6, 0.08); box-shadow: 0 0 25px rgba(249, 6, 6, 0.15); }
        @keyframes pulse-red { 0% { box-shadow: 0 0 10px var(--primary-red); scale: 1; } 50% { box-shadow: 0 0 25px var(--primary-red); scale: 1.1; } 100% { box-shadow: 0 0 10px var(--primary-red); scale: 1; } }
        .item-completed { opacity: 0.75; }
        .item-completed .timeline-dot { background: var(--success-green); border: 3px solid #064e3b; box-shadow: 0 0 15px rgba(0, 255, 136, 0.4); }
        .item-completed .card-custom { border: 1px solid rgba(0, 255, 136, 0.2); position: relative; overflow: hidden; }
        .item-completed .card-custom::after { content: "DONE"; position: absolute; top: 10px; right: -15px; background: rgba(0, 255, 136, 0.15); color: var(--success-green); font-size: 9px; font-weight: 900; padding: 2px 20px; transform: rotate(45deg); letter-spacing: 1px; }
        .badge-status { padding: 4px 10px; border-radius: 6px; font-size: 10px; font-weight: 800; text-transform: uppercase; }
        .progress-container { width: 100%; height: 8px; background: rgba(255, 255, 255, 0.1) !important; border-radius: 10px; overflow: hidden; display: block; }
        .progress-bar-custom { height: 100% !important; background: var(--elite-red, #ff3131); border-radius: 10px; transition: width 0.8s cubic-bezier(0.4, 0, 0.2, 1); display: block !important; box-shadow: 0 0 8px rgba(255, 49, 49, 0.3); }
        .stat-box { background: rgba(255, 255, 255, 0.03); border: 1px solid var(--border-color); padding: 10px; border-radius: 10px; }
        .btn-view-detail { background: rgba(255, 255, 255, 0.1); border: 1px solid var(--border-color); color: white; padding: 5px 12px; border-radius: 6px; font-size: 11px; text-decoration: none; font-weight: bold; transition: 0.2s; }
        .btn-view-detail:hover { background: white; color: black; }
        .btn-primary-custom { background: var(--primary-red); color: white; border: none; padding: 12px; border-radius: 10px; font-weight: 900; text-transform: uppercase; width: 100%; transition: 0.3s; box-shadow: 0 5px 15px rgba(249, 6, 6, 0.3); }
        .btn-rest-day { display: flex; justify-content: space-between; align-items: center; width: 100%; padding: 12px 20px; border-radius: 10px; background-color: #f8f9fa; border: 1.5px dashed #d1d5db; color: #6b7280; }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row">
        <%-- CỘT TRÁI (8) --%>
        <div class="col-lg-8">
            <div class="card-custom">
                <div class="d-flex justify-content-between align-items-end mb-3">
                    <div>
                        <h2 class="h5 fw-black text-uppercase italic m-0">Lộ Trình Tổng Thể</h2>
                        <p class="text-secondary small m-0">Đang thực hiện: <%= nameSchedule != null ? nameSchedule : "Khởi tạo" %></p>
                    </div>
                    <div class="text-end">
                        <%
                        int displayPercent = 0;
                        if (progress != null && masterScheduleDetail != null && masterScheduleDetail.getTotalPlannedWorkouts() > 0) {
                        double rawPercent = ((double) progress.getCompletedWorkouts() / masterScheduleDetail.getTotalPlannedWorkouts()) * 100;
                        displayPercent = (int) Math.round(rawPercent);
                        }
                        %>
                        <div class="h3 fw-black text-primary m-0 italic"><%= displayPercent %>%</div>
                        <div class="text-uppercase small opacity-50" style="font-size: 10px;">Tiến độ</div>
                    </div>
                </div>
                <div class="progress-container">
                    <div class="progress-bar-custom" style="width: <%= displayPercent %>%;"></div>
                </div>
            </div>

            <div class="timeline-container">
                <% if (TrainingScheduleList != null) {
                for (TrainingSchedule ts : TrainingScheduleList) {
                String status = (ts.getStatus() != null) ? ts.getStatus().toLowerCase() : "pending";
                %>
                <div class="timeline-item item-<%= status %>">
                    <div class="timeline-dot">
                        <% if(status.equalsIgnoreCase("completed")) { %>
                        <span class="material-symbols-outlined" style="font-size:14px; color:white;">check</span>
                        <% } else if(status.equalsIgnoreCase("active")) { %>
                        <div style="width:8px; height:8px; background:white; border-radius:50%"></div>
                        <% } else { %>
                        <span class="material-symbols-outlined" style="font-size:14px; color:white;">lock</span>
                        <% } %>
                    </div>
                    <div class="card-custom">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <span class="badge-status <%= status.equalsIgnoreCase("active") ? "text-white" : "text-secondary" %>" style="<%= status.equalsIgnoreCase("active") ? "background: var(--primary-red)" : "background: rgba(255,255,255,0.1)" %>">
                            <%= status.equalsIgnoreCase("active") ? "Đang thực hiện" : status %>
                            </span>
                            <a href="MyTrainingDay?id=<%= ts.getMasterScheduleId() %>" class="btn-view-detail">
                                CHI TIẾT <span class="material-symbols-outlined" style="font-size: 12px; vertical-align: middle;">arrow_forward</span>
                            </a>
                        </div>
                        <h4 class="h5 fw-black italic text-uppercase mb-2"><%= ts.getName() %></h4>
                        <% if(status.equals("active")) { %>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between small mb-1">
                                <span class="text-primary fw-bold" style="font-size: 10px;">TIẾN ĐỘ GIAI ĐOẠN</span>
                                <span class="fw-bold" style="font-size: 10px;"><%= weekIndex%>/ <%= ts.getTotalWeeks()%></span>
                            </div>
                            <% int displayPercent2 = (int) Math.round(((double) weekIndex / ts.getTotalWeeks()) * 100); %>
                            <div class="progress-container mini">
                                <div class="progress-bar-custom" style="width: <%= displayPercent2%>%"></div>
                            </div>
                        </div>
                        <% } %>
                        <div class="row g-2">
                            <div class="col-6">
                                <div class="stat-box">
                                    <label class="d-block text-secondary" style="font-size: 9px; text-transform: uppercase;">Mục tiêu</label>
                                    <%
                                    String goal = "";
                                    if (ts.getGoal().equalsIgnoreCase("GIAM_MO")) goal = "Giảm mỡ";
                                    else if (ts.getGoal().equalsIgnoreCase("TANG_CO")) goal = "Tăng cơ";
                                    else if (ts.getGoal().equalsIgnoreCase("DUY_TRI")) goal = "Săn chắc";
                                    %>
                                    <span class="small fw-bold"><%= goal %></span>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="stat-box">
                                    <label class="d-block text-secondary" style="font-size: 9px; text-transform: uppercase;">Cấp độ</label>
                                    <span class="small fw-bold text-uppercase"><%= ts.getFitnessLevel() %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } } %>
            </div>
        </div>

        <%-- CỘT PHẢI (4) --%>
        <div class="col-lg-4">
            <div class="card-custom">
                <h3 class="text-primary h6 fw-bold text-uppercase mb-4">Chỉ số sức khỏe</h3>
                <div class="row g-3">
                    <div class="col-6">
                        <div class="stat-box">
                            <label style="font-size: 9px; color: var(--text-gray);">CÂN NẶNG</label>
                            <div class="h5 fw-black m-0">75.4 <small>KG</small></div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="stat-box">
                            <label style="font-size: 9px; color: var(--text-gray);">CHUỖI TẬP</label>
                            <div class="h5 fw-black m-0"><%= workoutStreak%> <small> DAYS</small></div>
                        </div>
                    </div>
                </div>
            </div>

            <% if (weekIndex == 0) { %>
            <div class="card-custom" style="border-left: 4px solid #6c757d;">
                <h3 class="text-secondary h6 fw-bold text-uppercase mb-3">Lịch tập sắp tới</h3>
                <h4 class="h5 fw-black italic text-uppercase text-muted">Chưa đến ngày tập</h4>
                <% if (firstDate != null) { %><p class="text-secondary small mb-4">Dự kiến: <%= firstDate%></p><% } %>
                <button class="d-flex justify-content-between align-items-center w-100" style="background: rgba(0, 0, 0, 0.05); border: 1px dashed #adb5bd; color: #6c757d; padding: 12px 20px; border-radius: 8px; font-weight: 700; letter-spacing: 1px; cursor: not-allowed;">
                    <span style="font-size: 0.9rem;">CHƯA TỚI NGÀY TẬP</span>
                    <span class="material-symbols-outlined" style="font-size: 20px; opacity: 0.6;">schedule</span>
                </button>
            </div>
            <% } else { %>
            <div class="card-custom" style="border-left: 4px solid var(--primary-red);">
                <h3 class="text-primary h6 fw-bold text-uppercase mb-3">Buổi tập tiếp theo</h3>
                <h4 class="h5 fw-black italic text-uppercase"><%= workoutName%></h4>
                <%
                String statusClass = isCompleted ? "text-success" : "text-danger";
                String statusText = isCompleted ? "Đã hoàn thành" : "Chưa hoàn thành";
                if (dayType.equalsIgnoreCase("Rest")) {
                %>
                <div class="btn-rest-day">
                    <div class="d-flex align-items-center">
                        <span class="material-symbols-outlined me-2">spa</span>
                        <span>NGHỈ NGƠI PHỤC HỒI</span>
                    </div>
                    <span class="rest-subtext" style="font-size: 11px; font-weight: 600; text-transform: uppercase; background: #ffffff; color: #94a3b8; padding: 2px 8px; border-radius: 6px; border: 1px solid #e5e7eb;">Day Off</span>
                </div>
                <% } else { %>
                <p class="small mb-4 text-secondary">Hôm nay • <span class="<%= statusClass %> fw-bold"><%= statusText %></span></p>
                <a href="${pageContext.request.contextPath}/Exercises?id=<%= userDayId %>" class="btn-primary-custom d-flex justify-content-between align-items-center text-decoration-none" style="width: 100%;">
                    <span>BẮT ĐẦU TẬP</span>
                    <span class="material-symbols-outlined">play_circle</span>
                </a>
                <% } %>
            </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
<%
} // Đóng ngoặc khối else (Trường hợp có lộ trình)
%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.tracking.UserSchedule" %>
<%@ page import="model.tracking.Progress" %>

<%
    List<UserSchedule> schedules =
            (List<UserSchedule>) request.getAttribute("schedules");

    List<Progress> progressList =
            (List<Progress>) request.getAttribute("progressList");

    Map<Integer, Progress> progressMap = new HashMap<>();

    if(progressList != null){
        for(Progress p : progressList){
            progressMap.put(p.getUserScheduleId(), p);
        }
    }

    int completedCount = 0;
    double totalHours = 0;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    if (schedules != null) {

        for (UserSchedule s : schedules) {

            if ("Completed".equalsIgnoreCase(s.getStatus()))
                completedCount++;

            Progress p = progressMap.get(s.getUserScheduleId());

            if (p != null) {
                int completedWorkouts = p.getCompletedWorkouts();
                totalHours += completedWorkouts; // 1 workout = 1 giờ
            }
        }

        // Sort Active lên trước
        Collections.sort(schedules, (a,b) -> {
            boolean aActive = "Active".equalsIgnoreCase(a.getStatus());
            boolean bActive = "Active".equalsIgnoreCase(b.getStatus());
            if(aActive && !bActive) return -1;
            if(!aActive && bActive) return 1;
            return 0;
        });
    }
%>

<style>
    .wrapper{
        padding:60px 120px;
    }

    .header-top{
        display:flex;
        justify-content:space-between;
        align-items:center;
        margin-bottom:50px;
    }

    .header-title h1{
        font-size:42px;
        font-weight:900;
    }

    .header-title p{
        color:#aaa;
        margin-top:8px;
    }

    .btn-new{
        background:#3a2323;
        padding:12px 20px;
        border-radius:12px;
        color:#fff;
        text-decoration:none;
    }

    .stats{
        display:grid;
        grid-template-columns:repeat(3,1fr);
        gap:25px;
        margin-bottom:60px;
    }

    .stat{
        background:#1b1111;
        padding:30px;
        border-radius:22px;
        display:flex;
        justify-content:space-between;
        align-items:center;
        box-shadow:0 0 0 1px rgba(255,255,255,0.05);
    }

    .stat-left small{
        color:#aaa;
        font-size:14px;
    }

    .stat-left h2{
        font-size:36px;
        margin-top:6px;
    }

    .stat-left span{
        font-size:14px;
        font-weight:600;
    }

    .stat-icon{
        font-size:28px;
        opacity:0.3;
    }

    .cards{
        display:grid;
        grid-template-columns:repeat(3,1fr);
        gap:35px;
    }

    .card{
        position:relative;
        height:460px;
        border-radius:28px;
        overflow:hidden;
        background:#111;
        box-shadow:0 10px 40px rgba(0,0,0,0.5);
        transition:0.4s;
    }

    .card:hover{
        transform:translateY(-8px);
    }

    .card-image{
        position:absolute;
        inset:0;
        width:100%;
        height:100%;
        object-fit:cover;
    }

    .card::after{
        content:"";
        position:absolute;
        inset:0;
        background:linear-gradient(
                to top,
                rgba(0,0,0,0.95) 10%,
                rgba(0,0,0,0.6) 40%,
                rgba(0,0,0,0.2) 70%,
                rgba(0,0,0,0.1) 100%
        );
    }

    .badge{
        position:absolute;
        top:20px;
        left:20px;
        padding:8px 16px;
        border-radius:25px;
        font-size:12px;
        font-weight:700;
        z-index:3;
    }

    .badge-active{ background:#ff2c2c; }
    .badge-completed{ background:#00c853; }

    .card-content{
        position:absolute;
        bottom:0;
        padding:35px;
        width:100%;
        z-index:3;
    }

    .card-content h3{
        font-size:24px;
        margin-bottom:12px;
        color:#ffffff;
        font-weight:800;
        text-shadow:0 2px 10px rgba(0,0,0,0.8);
    }

    .card-content small{
        display:block;
        color:#ddd;
        margin-bottom:6px;
    }

    .btn-main{
        margin-top:18px;
        display:block;
        text-align:center;
        padding:14px;
        border-radius:16px;
        background:#ff1a1a;
        text-decoration:none;
        color:#fff;
        font-weight:600;
        transition:0.3s;
    }

    .btn-main:hover{
        background:#d60000;
    }
</style>

<div class="wrapper">

    <div class="header-top">
        <div class="header-title">
            <h1>Lộ trình Tập luyện</h1>
            <p>Theo dõi tiến độ, duy trì kỷ luật và chinh phục giới hạn mỗi ngày.</p>
        </div>
    </div>

    <div class="stats">

        <!-- Tổng giờ tập -->
        <div class="stat">
            <div class="stat-left">
                <small>Tổng giờ tập</small>
                <h2><%= String.format("%.0f", totalHours) %></h2>
                <span style="color:#ff2c2c;">giờ</span>
            </div>
            <div class="stat-icon text-danger">
                <i class="bi bi-clock-fill"></i>
            </div>
        </div>

        <!-- Đã hoàn thành -->
        <div class="stat">
            <div class="stat-left">
                <small>Đã hoàn thành</small>
                <h2><%= completedCount %></h2>
                <span style="color:#00c853;">xuất sắc</span>
            </div>
            <div class="stat-icon text-success">
                <i class="bi bi-check-circle-fill"></i>
            </div>
        </div>

        <!-- Tổng lộ trình -->
        <div class="stat">
            <div class="stat-left">
                <small>Tổng lộ trình</small>
                <h2><%= schedules != null ? schedules.size() : 0 %></h2>
                <span>chương trình</span>
            </div>
            <div class="stat-icon text-info">
                <i class="bi bi-collection-fill"></i>
            </div>
        </div>

    </div>

    <div class="cards">

        <% if(schedules != null){
            for(UserSchedule s : schedules){

                String goalCode = s.getGoal();
                String goalText = goalCode;
                String imageUrl;

                if("GIAM_CAN".equalsIgnoreCase(goalCode) || "GIAM_MO".equalsIgnoreCase(goalCode)){
                    goalText = "Giảm cân";
                    imageUrl = "https://images.unsplash.com/photo-1599058917212-d750089bc07e";
                }
                else if("TANG_CO".equalsIgnoreCase(goalCode)){
                    goalText = "Tăng cơ";
                    imageUrl = "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61";
                }
                else if("DUY_TRI".equalsIgnoreCase(goalCode)){
                    goalText = "Duy trì";
                    imageUrl = "https://images.unsplash.com/photo-1554284126-aa88f22d8b74";
                }
                else{
                    imageUrl = "https://images.unsplash.com/photo-1517836357463-d25dfeac3438";
                }

                boolean isActive = "Active".equalsIgnoreCase(s.getStatus());

                String startDate = "";
                if(s.getStartDate()!=null)
                    startDate = sdf.format(s.getStartDate());

                String endDate = "";
                Progress p = progressMap.get(s.getUserScheduleId());

                if(!isActive && p!=null && p.getLastUpdate()!=null){
                    endDate = sdf.format(p.getLastUpdate());
                }
        %>

        <div class="card">

            <img src="<%= imageUrl %>" class="card-image">

            <div class="badge <%= isActive?"badge-active":"badge-completed" %>">
                <%= isActive?"ĐANG TẬP":"HOÀN THÀNH" %>
            </div>

            <div class="card-content">

                <h3><%= s.getName() %></h3>

                <small>Mục tiêu: <%= goalText %></small>
                <small>Ngày bắt đầu: <%= startDate %></small>

                <% if(!isActive && !endDate.equals("")){ %>
                <small>Ngày kết thúc: <%= endDate %></small>
                <% } %>

                <a class="btn-main"
                   href="<%= request.getContextPath() %>/tracking?userScheduleId=<%= s.getUserScheduleId() %>">
                    <%= isActive?"Xem tiến trình":"Xem chi tiết" %>
                </a>

            </div>

        </div>

        <% } } %>

    </div>

</div>
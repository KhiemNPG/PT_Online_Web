<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.tracking.MasterScheduleDetail" %>
<%@ page import="model.tracking.Progress" %>
<%@ page import="model.tracking.UserSchedule" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="model.entity.User" %>

<%
  MasterScheduleDetail detail =
          (MasterScheduleDetail) request.getAttribute("detail");

  Progress progress =
          (Progress) request.getAttribute("progress");

  UserSchedule selectedSchedule =
          (UserSchedule) request.getAttribute("selectedSchedule");

  int percent = 0;
  int completed = 0;
  int skipped = 0;
  double calories = 0;

  if (detail != null && progress != null) {
    int total = detail.getTotalPlannedWorkouts();
    completed = progress.getCompletedWorkouts();
    skipped = progress.getSkippedWorkouts();
    calories = progress.getTotalCaloriesBurned();

    if (total > 0) {
      percent = (int) ((double) completed / total * 100);
    }
  }

  DecimalFormat df = new DecimalFormat("#,###");
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

  String userScheduleId = request.getParameter("userScheduleId");
  String status = progress != null ? progress.getStatus() : null;
  Double finalWeight = progress != null ? progress.getFinalWeight() : null;

  UserDAO userDAO = new UserDAO();
  Integer accountId = (Integer) session.getAttribute("accountId");
  User userProfile = null;
  Double profileWeight = null;

  if(accountId != null){
    userProfile = userDAO.findByAccountId(accountId);
    if(userProfile != null){
      profileWeight = userProfile.getWeight();
    }
  }

  String scheduleName = "";
  String goalText = "";

  if(selectedSchedule != null){

    scheduleName = selectedSchedule.getName();
    String goalCode = selectedSchedule.getGoal();

    if("GIAM_CAN".equalsIgnoreCase(goalCode) ||
            "GIAM_MO".equalsIgnoreCase(goalCode)){
      goalText = "Giảm cân";
    }
    else if("TANG_CO".equalsIgnoreCase(goalCode)){
      goalText = "Tăng cơ";
    }
    else if("DUY_TRI".equalsIgnoreCase(goalCode)){
      goalText = "Duy trì";
    }
    else{
      goalText = goalCode;
    }
  }

  String displayStatus = "N/A";
  if(progress != null && progress.getStatus() != null){
    if("COMPLETED".equalsIgnoreCase(progress.getStatus())){
      displayStatus = "Hoàn thành";
    }else if("IN PROGRESS".equalsIgnoreCase(progress.getStatus())) {
      displayStatus = "Chưa hoàn thành";
    }else {
      displayStatus = progress.getStatus();
    }
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Tracking Dashboard</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

  <style>
    :root{
      --bg:#0f172a;
      --card:rgba(255,255,255,0.06);
      --border:rgba(255,255,255,0.08);
      --primary:#ff3b3b;
      --green:#22c55e;
      --orange:#f97316;
      --text-muted:#94a3b8;
    }

    *{box-sizing:border-box;}

    body{
      margin:0;
      font-family:'Inter',sans-serif;
      background:linear-gradient(135deg,#0f172a,#111827);
      color:#ffffff;
    }

    .wrapper{
      max-width:1400px;
      margin:auto;
      padding:60px 30px;
    }

    .header-flex{
      display:flex;
      justify-content:space-between;
      align-items:center;
    }

    .title{
      font-size:42px;
      font-weight:900;
    }

    .subtitle{
      color:var(--text-muted);
      margin-top:8px;
    }

    .btn-back{
      background:white;
      color:black;
      padding:12px 24px;
      border-radius:40px;
      border:none;
      cursor:pointer;
      font-weight:700;
    }

    .grid{
      display:grid;
      grid-template-columns:2fr 1fr;
      gap:30px;
    }

    .card{
      background:var(--card);
      border:1px solid var(--border);
      border-radius:25px;
      padding:30px;
    }

    .section-title{
      font-size:20px;
      font-weight:700;
      margin-bottom:25px;
    }

    .info-grid{
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
      gap:20px;
    }

    .info-box{
      background:rgba(255,255,255,0.04);
      padding:25px;
      border-radius:18px;
      text-align:center;
    }

    .progress-area{
      display:flex;
      gap:40px;
      align-items:center;
    }

    .donut{
      width:240px;
      height:240px;
      border-radius:50%;
      background:
              conic-gradient(var(--primary) 0% <%= percent %>%, #1f2937 <%= percent %>% 100%);
      display:flex;
      align-items:center;
      justify-content:center;
      position:relative;
    }

    .donut::before{
      content:"";
      width:170px;
      height:170px;
      background:#0f172a;
      border-radius:50%;
      position:absolute;
    }

    .percent{
      font-size:55px;
      font-weight:900;
      position:relative;
    }

    .mini-box{
      background:rgba(255,255,255,0.04);
      padding:18px 22px;
      border-radius:16px;
      margin-bottom:15px;
      display:flex;
      justify-content:space-between;
    }

    .green{color:var(--green);}
    .orange{color:var(--orange);}
    .red{color:#ef4444;}

    .history-row{
      display:flex;
      justify-content:space-between;
      margin-bottom:15px;
    }

    .next-title{
      font-size:13px;
      color:var(--text-muted);
      margin-bottom:10px;
    }

    .btn-light{
      background:white;
      color:black;
      padding:12px;
      border-radius:40px;
      border:none;
      cursor:pointer;
      font-weight:600;
    }

    .card,
    .card * {
      color: #ffffff !important;
    }

    .mini-box div:first-child {
      color: #e2e8f0 !important;
    }

    .green { color: #22c55e !important; }
    .red { color: #ef4444 !important; }
    .orange { color: #f97316 !important; }
    /* ===== FIX INPUT NUMBER ===== */
    input[type="number"]{
      width:100%;
      padding:12px;
      border-radius:12px;
      border:1px solid #ddd;
      background:#ffffff !important;
      color:#000000 !important;
      font-size:16px;
      outline:none;
    }

    input[type="number"]:focus{
      border-color:#ff3b3b;
      box-shadow:0 0 0 2px rgba(255,59,59,0.2);
    }
    /* ===== FIX NÚT LƯU KẾT QUẢ CHỮ TRẮNG ===== */
    .btn-light{
      background:#ff3b3b !important;
      color:#0a0a0a !important;
      padding:12px 24px;
      border-radius:40px;
      border:none;
      cursor:pointer;
      font-weight:600;
    }

    .btn-light:hover{
      opacity:0.9;
    }
  </style>
</head>

<body>

<div class="wrapper">

  <div class="header-flex">
    <div>
      <div class="title">
        <%= scheduleName %>
      </div>
      <div class="subtitle">
        Mục tiêu:
        <span style="color:#ff3b3b;font-weight:700;">
            <%= goalText %>
        </span>
      </div>
    </div>

    <button onclick="history.back()" class="btn-back">
      ← Quay lại
    </button>
  </div>

  <br><br>

  <div class="grid">

    <div>
      <div class="card">
        <div class="section-title">Thông tin lộ trình</div>

        <% if(detail!=null){ %>
        <div class="info-grid">
          <div class="info-box">
            <h3><%= detail.getTotalPlannedWorkouts() %></h3>
            <small>TỔNG BUỔI</small>
          </div>
          <div class="info-box">
            <h3><%= df.format(detail.getTotalPlannedCalories()) %></h3>
            <small>TỔNG CALO</small>
          </div>
          <div class="info-box">
            <h3><%= detail.getTotalPlannedMinutes() %></h3>
            <small>PHÚT TẬP</small>
          </div>
          <div class="info-box">
            <h3><%= detail.getEstimatedWeightLoss() %> kg</h3>
            <small>GIẢM CÂN</small>
          </div>
        </div>
        <% } %>
      </div>

      <div class="card" style="margin-top:30px;">
        <div class="section-title">Tiến độ của bạn</div>

        <div class="progress-area">
          <div class="donut">
            <div class="percent"><%= percent %>%</div>
          </div>

          <div style="flex:1">
            <div class="mini-box">
              <div>Hoàn thành</div>
              <div class="green"><%= completed %> buổi</div>
            </div>

            <div class="mini-box">
              <div>Bỏ lỡ</div>
              <div class="red"><%= skipped %> buổi</div>
            </div>

            <div class="mini-box">
              <div>Calories đã đốt</div>
              <div class="orange"><%= df.format(calories) %> kcal</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div>

      <div class="card">
        <div class="section-title">Lịch sử gần đây</div>

        <div class="history-row">
          <span>Cập nhật cuối</span>
          <span><%= progress!=null && progress.getLastUpdate()!=null ?
                  sdf.format(progress.getLastUpdate()) : "Chưa có" %></span>
        </div>

        <div class="history-row">
          <span>Trạng thái</span>
          <span class="green"><%= displayStatus %></span>
        </div>
      </div>

      <div class="card" style="margin-top:25px;">

        <% if("COMPLETED".equalsIgnoreCase(status)){ %>

        <div class="next-title">KẾT QUẢ SAU KHI HOÀN THÀNH</div>

        <% if(finalWeight != null && profileWeight != null){
          double diff = finalWeight - profileWeight; %>

        <div>
          Cân nặng sau lộ trình:
          <span class="green"><%= finalWeight %> kg</span>
        </div>

        <div style="margin-top:10px;font-weight:600;">
          <% if(diff < 0){ %>
          <span class="green">🎉 Bạn đã giảm <%= Math.abs(diff) %> kg</span>
          <% } else if(diff > 0){ %>
          <span class="red">🎉 Bạn đã tăng <%= diff %> kg</span>
          <% } else { %>
          Không thay đổi cân nặng.
          <% } %>
        </div>

        <% } else { %>

        <div style="margin:15px 0;">
          <label>Nhập cân nặng hiện tại (kg)</label>
          <input type="number" id="weightInput" step="0.1"
                 style="width:100%;margin-top:8px;padding:12px;">
        </div>

        <button onclick="saveWeight()" class="btn-light">Lưu kết quả</button>
        <div id="resultBox" style="margin-top:15px;"></div>

        <% } %>

        <% } else { %>

        <div class="next-title">Chưa hoàn thành lộ trình</div>

        <% } %>

      </div>
    </div>

  </div>
</div>

<script>
  function saveWeight(){

    const weightInput = document.getElementById("weightInput");
    const saveButton  = document.querySelector(".btn-light");
    const resultBox   = document.getElementById("resultBox");

    const weight = weightInput.value;

    if(!weight){
      resultBox.innerHTML = "<span style='color:red'>Vui lòng nhập cân nặng.</span>";
      return;
    }

    fetch("<%=request.getContextPath()%>/updateWeight",{
      method:"POST",
      headers:{"Content-Type":"application/x-www-form-urlencoded"},
      body:"currentWeight="+weight+"&userScheduleId=<%=userScheduleId%>"
    })
            .then(res=>res.json())
            .then(data=>{

              if(data.success){

                let message = "";

                if(data.type === "increase"){
                  message = "🎉 Bạn đã tăng " + data.diff + " kg";
                }
                else if(data.type === "decrease"){
                  message = "🎉 Bạn đã giảm " + data.diff + " kg";
                }
                else{
                  message = "Không thay đổi cân nặng.";
                }

                resultBox.innerHTML =
                        "<span style='font-weight:600'>" + message + "</span>";

                // ===== DISABLE INPUT & BUTTON =====
                weightInput.disabled = true;
                saveButton.disabled  = true;

                weightInput.style.opacity = "0.6";
                saveButton.style.opacity  = "0.6";
                saveButton.style.cursor   = "not-allowed";

              }else{
                resultBox.innerHTML="<span style='color:red'>"+data.message+"</span>";
              }

            });
  }
</script>

</body>
</html>
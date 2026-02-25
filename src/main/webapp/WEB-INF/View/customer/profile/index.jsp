<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Hồ sơ Người dùng | Hardcore Gym</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>

    <style>
        :root{
            --primary:#f90606;
            --bg-dark:#230f0f;
            --neutral-dark:#1a0a0a;
            --neutral-card:#2d1616;

            --text-dark:#e5e7eb;

            --slate-300:#cbd5e1;
            --slate-400:#94a3b8;
            --slate-500:#64748b;
            --slate-600:#475569;
            --slate-700:#334155;

            --radius-lg:16px;
            --shadow: 0 10px 30px rgba(0,0,0,.25);
        }

        *{ box-sizing:border-box; }
        html,body{ height:100%; }
        body{
            margin:0;
            font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            background: var(--bg-dark);
            color: var(--text-dark);
            min-height:100vh;
        }

        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #230f0f; }
        ::-webkit-scrollbar-thumb { background: #f90606; border-radius: 4px; }
        ::-webkit-scrollbar-thumb:hover { background: #cc0505; }

        .container{
            max-width: 1024px;
            margin: 0 auto;
            padding: 32px 16px;
        }

        /* Toast */
        .toast{
            position: fixed;
            top: 16px;
            right: 16px;
            z-index: 9999;
            padding: 12px 14px;
            border-radius: 12px;
            font-weight: 900;
            letter-spacing: .08em;
            text-transform: uppercase;
            font-size: 12px;
            border: 1px solid rgba(249,6,6,.25);
            backdrop-filter: blur(10px);
        }
        .toast-success{
            background: rgba(34,197,94,.12);
            color: #86efac;
        }
        .toast-error{
            background: rgba(249,6,6,.12);
            color: #fca5a5;
        }

        /* Back button */
        .back-btn{
            display:inline-flex;
            align-items:center;
            gap:6px;
            border:1px solid rgba(249,6,6,.25);
            background:transparent;
            color:var(--slate-300);
            padding:6px 12px;
            border-radius:8px;
            font-weight:700;
            font-size:12px;
            cursor:pointer;
            transition:.2s;
        }
        .back-btn:hover{
            background:rgba(249,6,6,.15);
            color:#fff;
        }
        .back-btn .material-icons{
            font-size:16px;
        }

        /* Header */
        .header-card{
            display:flex;
            gap:22px;
            align-items:center;
            padding:22px;
            border-radius:24px;
            border:1px solid rgba(249,6,6,.1);
            background:rgba(45,22,22,.4);
        }

        .avatar-ring{
            width:88px;
            height:88px;
            border-radius:50%;
            border:3px solid var(--primary);
            padding:3px;
            overflow:hidden;
        }
        .avatar-ring img{
            width:100%;
            height:100%;
            object-fit:cover;
            border-radius:50%;
        }

        .title{
            margin:0;
            font-size:22px;
            font-weight:900;
        }
        .sub{
            margin-top:6px;
            color:var(--slate-400);
            font-size:13px;
        }

        .badge{
            display:inline-block;
            margin-top:10px;
            padding:6px 12px;
            border-radius:9999px;
            background:rgba(249,6,6,.2);
            border:1px solid var(--primary);
            color:var(--primary);
            font-size:11px;
            font-weight:900;
            text-transform:uppercase;
        }

        /* Layout */
        .main{
            display:grid;
            grid-template-columns:1fr;
            gap:22px;
            margin-top:22px;
        }
        @media(min-width:1024px){
            .main{ grid-template-columns:2fr 1fr; }
        }

        .card{
            padding:22px;
            border-radius:var(--radius-lg);
            background:rgba(45,22,22,.2);
            border:1px solid rgba(249,6,6,.06);
        }

        .section-title{
            display:flex;
            gap:10px;
            align-items:center;
            font-weight:900;
            font-size:18px;
            margin-bottom:18px;
        }
        .accent-bar{
            width:8px;
            height:22px;
            background:var(--primary);
            border-radius:9999px;
        }

        .grid{
            display:grid;
            gap:16px;
        }
        @media(min-width:768px){
            .grid{ grid-template-columns:1fr 1fr; }
            .span-2{ grid-column:1 / -1; }
        }

        .label{
            font-size:11px;
            font-weight:900;
            color:var(--slate-400);
            text-transform:uppercase;
        }
        .input,.select{
            width:100%;
            padding:12px 14px;
            border-radius:10px;
            border:1px solid rgba(249,6,6,.2);
            background:var(--neutral-dark);
            color:#fff;
        }

        .actions{
            margin-top:16px;
            display:flex;
            gap:12px;
            justify-content:flex-end;
        }

        .btn{
            border-radius:10px;
            padding:12px 18px;
            font-weight:900;
            font-size:12px;
            text-transform:uppercase;
            cursor:pointer;
        }
        .btn-ghost{
            background:transparent;
            color:var(--slate-400);
            border:0;
        }
        .btn-primary{
            background:var(--primary);
            color:#fff;
            border:0;
        }

        .aside-card{
            padding:22px;
            border-radius:var(--radius-lg);
            background:rgba(45,22,22,1);
            border:1px solid rgba(249,6,6,.2);
        }
        .bmi-radio{
            padding:8px 14px;
            border-radius:999px;
            border:1px solid rgba(249,6,6,.3);
            font-size:12px;
            font-weight:800;
            cursor:pointer;
            color:var(--slate-400);
            transition:.2s;
            user-select:none;
        }

        .bmi-radio input{
            display:none;
        }

        .bmi-radio.active{
            background:rgba(249,6,6,.2);
            border:1px solid #f90606;
            color:#fff;
            box-shadow:0 0 12px rgba(249,6,6,.3);
        }

    </style>
</head>

<body>
<%
    String success = (String) session.getAttribute("success");
    String errorSession = (String) session.getAttribute("error");
    if(success!=null) session.removeAttribute("success");
    if(errorSession!=null) session.removeAttribute("error");

    String sessionUser = (String) session.getAttribute("username");
    if(sessionUser==null) sessionUser="User";
%>

<% if(success!=null){ %>
<div class="toast toast-success"><%= success %></div>
<% } %>
<% if(errorSession!=null){ %>
<div class="toast toast-error"><%= errorSession %></div>
<% } %>
<c:set var="standard" value="${bmiStandard}" />
<div class="container">
    <a href="<%= request.getContextPath() %>/home"
       class="back-btn"
       style="text-decoration:none;">
        <span class="material-icons">arrow_back</span> Quay lại
    </a>


    <div class="header-card" style="margin-top:12px;">
        <div class="avatar-ring">
            <img src="https://ui-avatars.com/api/?name=<%= java.net.URLEncoder.encode(sessionUser,"UTF-8") %>&background=f90606&color=fff">
        </div>
        <div>
            <h1 class="title">${empty user.name ? "CHƯA ĐẶT TÊN" : user.name}</h1>
            <p class="sub">Cập nhật thông tin để hệ thống đề xuất lộ trình tập phù hợp</p>
            <div class="badge">
                <c:choose>
                    <c:when test="${user.fitnessLevel == 'Beginner'}">
                        Người mới bắt đầu
                    </c:when>
                    <c:when test="${user.fitnessLevel == 'Intermediate'}">
                        Trung cấp
                    </c:when>
                    <c:when test="${user.fitnessLevel == 'Advanced'}">
                        Trình độ cao
                    </c:when>
                    <c:otherwise>
                        Người mới bắt đầu
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <main class="main">

        <section class="card">
            <h2 class="section-title">
                <span class="accent-bar"></span> Thông tin cá nhân
            </h2>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <div class="grid">
                    <div class="span-2">
                        <label class="label">Họ và tên</label>
                        <input class="input" name="name" value="${user.name}" required>
                    </div>

                    <div>
                        <label class="label">Giới tính</label>
                        <select class="select" name="gender">
                            <option value="">-- Chọn --</option>
                            <option value="Nam" ${user.gender=='Nam'?'selected':''}>Nam</option>
                            <option value="Nữ" ${user.gender=='Nữ'?'selected':''}>Nữ</option>
                            <option value="Khác" ${user.gender=='Khác'?'selected':''}>Khác</option>
                        </select>
                    </div>

                    <div>
                        <label class="label">Trình độ</label>
                        <select class="select" name="fitnessLevel">
                            <option value="">-- Chọn --</option>
                            <option value="Beginner" ${user.fitnessLevel=='Beginner'?'selected':''}>Người mới bắt đầu</option>
                            <option value="Intermediate" ${user.fitnessLevel=='Intermediate'?'selected':''}>Trung cấp</option>
                            <option value="Advanced" ${user.fitnessLevel=='Advanced'?'selected':''}>Trình độ cao</option>
                        </select>
                    </div>

                    <div>
                        <label class="label">Tuổi</label>
                        <input class="input"
                               name="age"
                               type="number"
                               min="2"
                               max="120"
                               step="1"
                               required
                               value="${user.age}">
                    </div>

                    <div>
                        <label class="label">Chiều cao (cm)</label>
                        <input class="input"
                               name="height"
                               type="number"
                               min="30"
                               max="300"
                               step="0.1"
                               required
                               value="${user.height}">
                    </div>

                    <div>
                        <label class="label">Cân nặng (kg)</label>
                        <input class="input"
                               name="weight"
                               type="number"
                               min="2"
                               max="500"
                               step="0.1"
                               required
                               value="${user.weight}">
                    </div>
                </div>

                <div class="actions">
                    <button type="reset" class="btn btn-ghost">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </section>

        <!-- RIGHT -->
        <aside class="aside-card">
            <h3 class="label">Chỉ số BMI</h3>

            <!-- CHỌN CHUẨN -->
            <form method="get"
                  action="${pageContext.request.contextPath}/profile"
                  style="margin-bottom:15px;">

                <div style="display:flex;gap:12px;">

                    <label class="bmi-radio ${standard=='ASIA'?'active':''}">
                        <input type="radio" name="bmiStandard" value="ASIA"
                        ${standard=='ASIA'?'checked':''}
                               onchange="this.form.submit()">
                        Chuẩn Châu Á
                    </label>

                    <label class="bmi-radio ${standard=='WHO'?'active':''}">
                        <input type="radio" name="bmiStandard" value="WHO"
                        ${standard=='WHO'?'checked':''}
                               onchange="this.form.submit()">
                        Chuẩn Quốc tế
                    </label>

                </div>

            </form>

            <!-- HIỂN THỊ BMI -->
            <c:if test="${not empty user.bmi}">

                <div style="font-size:34px;
                        font-weight:900;
                        color:${user.bmiColor};
                        margin:10px 0;">
                        ${user.bmi}
                </div>

                <div style="font-weight:700;
                        font-size:14px;
                        color:${user.bmiColor};">
                        ${user.getBmiStatus(standard)}
                </div>

                <!-- PROGRESS BAR -->
                <div style="margin-top:15px;
                    background:#1a0a0a;
                    height:10px;
                    border-radius:10px;
                    overflow:hidden;">

                    <div style="height:100%;
                            width:${user.bmiPercent}%;
                            background:${user.bmiColor};
                            transition:0.5s;">
                    </div>
                </div>

                <!-- TƯ VẤN -->
                <div style="margin-top:15px;
                    font-size:13px;
                    color:#94a3b8;
                    line-height:1.6;">
                        ${user.getBmiAdvice(standard)}
                </div>

                <!-- CẢNH BÁO -->
                <c:if test="${user.bmi >= 30}">
                    <div style="margin-top:15px;
                        padding:12px;
                        border-radius:12px;
                        background:rgba(239,68,68,0.15);
                        color:#f87171;
                        font-weight:600;">
                        ⚠ Nguy cơ tim mạch và huyết áp cao. Hãy cải thiện chế độ ăn và tập luyện ngay.
                    </div>
                </c:if>

            </c:if>

            <c:if test="${empty user.bmi}">
                <p style="font-size:13px;color:var(--slate-500);">
                    Điền chiều cao và cân nặng để hệ thống tính BMI.
                </p>
            </c:if>

        </aside>


    </main>

</div>
</body>
</html>

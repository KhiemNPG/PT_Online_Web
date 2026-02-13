<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi" class="theme-dark">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thiết lập | CorePower</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

    <style>
        :root{
            --primary:#f90606;
            --bg-dark:#120505;
            --card-dark:#1a0a0a;
            --text:#f2f2f2;
            --muted:rgba(255,255,255,.70);
            --border:rgba(249,6,6,.12);
            --radius:16px;
            --input:#1b0b0b;
        }

        *{box-sizing:border-box}
        html,body{height:100%}

        body{
            margin:0;
            font-family:Inter,sans-serif;
            background:var(--bg-dark);
            color:var(--text);
            display:flex;
            min-height:100vh;
            font-size:15px;
        }

        a{ text-decoration:none; }

        /* Sidebar */
        .sidebar{
            width:320px;
            padding:26px;
            border-right:1px solid var(--border);
            background:rgba(0,0,0,.30);
            display:none;
            flex-direction:column;
            gap:18px;
        }
        @media(min-width:1024px){.sidebar{display:flex}}
        .brand{
            font-weight:900;
            font-style:italic;
            letter-spacing:-.06em;
            text-transform:uppercase;
            color:var(--primary);
            font-size:22px;
        }

        .steps{display:flex;flex-direction:column;gap:16px;flex:1}
        .step{display:flex;align-items:center;gap:12px;opacity:.55;transition:.15s}
        .step.active{opacity:1}
        .dot{
            width:38px;height:38px;
            border-radius:999px;
            display:flex;align-items:center;justify-content:center;
            font-weight:900;font-size:14px;
            border:1px solid rgba(255,255,255,.10);
            background:rgba(255,255,255,.03)
        }
        .step.active .dot{border-color:rgba(249,6,6,.55);box-shadow:0 0 0 4px rgba(249,6,6,.15)}
        .s-title{font-weight:900;font-size:14px}
        .s-sub{font-size:12.5px;color:var(--muted);margin-top:2px}

        /* Progress box */
        .status{
            margin-top:auto;
            padding:16px;
            border-radius:14px;
            border:1px solid rgba(249,6,6,.12);
            background:rgba(249,6,6,.05)
        }
        .status .t1{font-size:11px;letter-spacing:.12em;text-transform:uppercase;font-weight:900;color:var(--primary);margin:0 0 6px}
        .status .t2{margin:0;font-size:14px;opacity:.9;font-weight:800}
        .bar{margin-top:10px;height:7px;border-radius:999px;overflow:hidden;background:rgba(249,6,6,.20)}
        .bar>div{height:100%;width:0%;background:var(--primary);transition:width .2s ease}

        /* Main */
        .main{
            flex:1;
            padding:22px;
            display:flex;
            justify-content:center;
        }
        @media(min-width:1024px){.main{padding:34px 44px;align-items:center}}
        .container{width:100%;max-width:920px}

        .header{margin-bottom:18px}
        .title{
            margin:0 0 8px;
            font-size:32px;
            line-height:1.12;
            font-weight:900;
            font-style:italic;
            letter-spacing:-.05em;
            text-transform:uppercase
        }
        @media(min-width:768px){.title{font-size:38px}}
        .accent{color:var(--primary)}
        .subtitle{
            margin:0;
            max-width:760px;
            font-size:14.5px;
            line-height:1.7;
            color:var(--muted)
        }

        /* Panels */
        .panel{
            margin-top:16px;
            border:1px solid rgba(255,255,255,.06);
            background:rgba(255,255,255,.02);
            border-radius:var(--radius);
            padding:22px;
            display:none;
        }
        .panel.active{display:block}
        .panel h4{
            margin:0 0 14px;
            font-size:13px;
            letter-spacing:.14em;
            text-transform:uppercase;
            color:var(--muted);
            font-weight:900;
        }

        /* cards grid */
        .goal-grid{display:grid;grid-template-columns:1fr;gap:14px}
        @media(min-width:768px){.goal-grid{grid-template-columns:1fr 1fr}}

        .card{
            position:relative;
            border-radius:var(--radius);
            padding:18px;
            text-align:left;
            border:1px solid rgba(255,255,255,.06);
            background:var(--card-dark);
            cursor:pointer;
            transition:.18s;
            display:flex;gap:14px;align-items:flex-start;
        }
        .card:hover{border-color:rgba(249,6,6,.45);background:rgba(249,6,6,.05);transform:translateY(-1px)}
        .card.selected{box-shadow:0 0 18px rgba(249,6,6,.40);border:2px solid var(--primary);background:rgba(249,6,6,.06);transform:none}

        .icon-box{
            flex:0 0 48px;
            width:48px;height:48px;
            border-radius:14px;
            display:flex;align-items:center;justify-content:center;
            background:rgba(249,6,6,.10)
        }
        .card.selected .icon-box{background:var(--primary)}
        .icon{font-size:24px;color:var(--primary)}
        .card.selected .icon{color:#fff}

        .card h3{
            margin:0 0 6px;
            font-size:16px;
            font-weight:700;
            color:#ffffff;
        }
        .card p{margin:0;font-size:14px;line-height:1.6;color:var(--muted)}

        .checkmark{position:absolute;top:12px;right:12px;display:none;color:var(--primary)}
        .card.selected .checkmark{display:block}

        /* form controls */
        .field label{
            display:block;
            font-size:14px;
            color:var(--muted);
            margin:0 0 8px;
            font-weight:900
        }
        .control, select.control, textarea.control{
            width:100%;
            padding:14px 14px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.10);
            background:var(--input);
            color:var(--text);
            outline:none;
            font-size:16px;
        }
        .hint{margin-top:8px;font-size:13px;color:rgba(255,255,255,.55);line-height:1.4}

        /* chip list (joint) */
        .chip-wrap{display:flex;flex-wrap:wrap;gap:12px}
        .chip{
            display:inline-flex;
            align-items:center;
            gap:10px;
            padding:12px 16px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,.12);
            background:rgba(255,255,255,.03);
            cursor:pointer;
            font-size:15px;
            user-select:none;
        }
        .chip input{ transform:scale(1.15); }

        /* actions */
        .actions{
            display:flex;
            gap:14px;
            justify-content:space-between;
            align-items:center;
            margin-top:18px;
            padding-top:18px;
            border-top:1px solid rgba(249,6,6,.12)
        }

        .btn{
            border:none;
            border-radius:14px;
            padding:14px 18px;
            background:var(--primary);
            color:#fff;
            cursor:pointer;

            font-family: Inter, sans-serif;
            font-weight:700;
            font-style: normal;
            text-transform:none;
            letter-spacing:0;

            box-shadow:0 12px 24px rgba(249,6,6,.22);
            min-width:200px;
            font-size:15px;
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            transition:.15s;
            appearance:none;
            -webkit-appearance:none;
        }

        .btn.secondary{
            background:transparent;
            border:1px solid rgba(255,255,255,.14);
            box-shadow:none;
            color:var(--text);
        }

        a.btn, a.btn:link, a.btn:visited, a.btn:hover, a.btn:active{
            text-decoration:none !important;
            color:inherit;
        }

        .btn:hover{filter:brightness(.95);transform:translateY(-1px)}
        .btn:active{transform:scale(.98)}
        .btn[disabled]{opacity:.45;cursor:not-allowed;transform:none;filter:none}

        /* toast */
        .toast{
            position:fixed;top:16px;right:16px;z-index:9999;
            padding:12px 14px;border-radius:14px;
            border:1px solid rgba(255,255,255,.10);
            background:rgba(0,0,0,.55);backdrop-filter:blur(10px);
            max-width:360px;font-weight:800;font-size:14px
        }
        .toast .small{display:block;font-size:12px;opacity:.75;margin-top:4px;font-weight:600}
        .toast.success{border-color:rgba(0,255,170,.25)}
        .toast.error{border-color:rgba(255,60,60,.25)}
    </style>
</head>

<body>
<aside class="sidebar">
    <div class="brand">COREPOWER</div>

    <div class="steps" id="stepList">
        <div class="step active" data-step-indicator="1">
            <div class="dot">1</div>
            <div><div class="s-title">Mục tiêu</div><div class="s-sub">Chọn goal</div></div>
        </div>

        <div class="step" data-step-indicator="2">
            <div class="dot">2</div>
            <div><div class="s-title">Độ tuổi</div><div class="s-sub">Chọn 1 khoảng</div></div>
        </div>

        <div class="step" data-step-indicator="3">
            <div class="dot">3</div>
            <div><div class="s-title">Giới tính</div><div class="s-sub">Chọn 1 mục</div></div>
        </div>

        <div class="step" data-step-indicator="4">
            <div class="dot">4</div>
            <div><div class="s-title">Vấn đề khớp</div><div class="s-sub">Chọn 1 vị trí</div></div>
        </div>

        <div class="step" data-step-indicator="5">
            <div class="dot">5</div>
            <div><div class="s-title">Thời gian tập</div><div class="s-sub">Chọn thời gian rảnh</div></div>
        </div>

        <div class="step" data-step-indicator="6">
            <div class="dot">6</div>
            <div><div class="s-title">Ngày bắt đầu</div><div class="s-sub">Chọn 1 ngày</div></div>
        </div>
        <div class="step" data-step-indicator="7">
            <div class="dot">7</div>
            <div><div class="s-title">Tổng kết</div><div class="s-sub">Xác nhận lộ trình</div></div>
        </div>
    </div>

    <div class="status">
        <p class="t1">Tiến độ</p>
        <p class="t2"><span id="doneCount">0</span>/<span id="totalCount">0</span> mục • <span id="percentText">0%</span></p>
        <div class="bar"><div id="percentBar"></div></div>
    </div>
</aside>

<main class="main">
    <%
        Object success = request.getAttribute("success");
        Object error = request.getAttribute("error");

        boolean lockCreate = false;
        if (error != null) {
            String errText = String.valueOf(error);
            if (errText.contains("chưa hoàn thành")) lockCreate = true;
        }

        if (success != null) {
    %>
    <div class="toast success" id="toast">
        <span><%= success %></span>
        <span class="small">Thông tin đã được lưu.</span>
    </div>
    <%
    } else if (error != null) {
    %>
    <div class="toast error" id="toast">
        <span><%= error %></span>
        <span class="small">Vui lòng thử lại.</span>
    </div>
    <%
        }
    %>

    <div class="container">
        <header class="header">
            <h2 class="title">Thiết lập <span class="accent">mục tiêu</span></h2>
            <p class="subtitle">Tiến độ tính theo từng mục (mỗi bước = 1 mục).</p>
        </header>

        <%
            model.entity.TrainingRequirement tr =
                    (model.entity.TrainingRequirement) request.getAttribute("trainingRequirement");
            model.entity.HealthProfile hp =
                    (model.entity.HealthProfile) request.getAttribute("healthProfile");

            String currentGoal = (tr != null && tr.getGoal() != null) ? tr.getGoal() : "";
            String currentAvailableTime = (tr != null && tr.getAvailableTime() != null) ? tr.getAvailableTime() : "";
            String currentPreferredDays = (tr != null && tr.getPreferredDays() != null) ? tr.getPreferredDays() : "";

            String currentAgeRange = (hp != null && hp.getAgeRange() != null) ? hp.getAgeRange() : "";
            String currentGender   = (hp != null && hp.getGender() != null) ? hp.getGender() : "";
            String currentJoint    = (hp != null && hp.getJointIssues() != null) ? hp.getJointIssues() : "";
        %>

        <form method="post" action="${pageContext.request.contextPath}/setup/goal" id="wizardForm">

            <input type="hidden" name="goal" id="goalInput" value="<%= currentGoal %>">
            <input type="hidden" name="ageRange" id="ageRangeInput" value="<%= currentAgeRange %>">
            <input type="hidden" name="gender" id="genderInput" value="<%= currentGender %>">

            <!-- STEP 1 -->
            <section class="panel active" data-step="1">
                <h4>Bước 1: Chọn mục tiêu</h4>

                <div class="goal-grid">
                    <button class="card <%= "GIAM_MO".equals(currentGoal) ? "selected" : "" %>" type="button" data-goal="GIAM_MO">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">local_fire_department</span></div>
                        <div><h3>Giảm mỡ</h3><p>Ưu tiên đốt mỡ, cardio, thâm hụt calo.</p></div>
                    </button>

                    <button class="card <%= "TANG_CO".equals(currentGoal) ? "selected" : "" %>" type="button" data-goal="TANG_CO">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">fitness_center</span></div>
                        <div><h3>Tăng cơ</h3><p>Phì đại cơ, tăng sức mạnh.</p></div>
                    </button>

                    <button class="card <%= "DUY_TRI".equals(currentGoal) ? "selected" : "" %>" type="button" data-goal="DUY_TRI">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">balance</span></div>
                        <div><h3>Duy trì</h3><p>Giữ dáng, cải thiện thể lực tổng thể.</p></div>
                    </button>

                    <button class="card <%= "SUC_BEN".equals(currentGoal) ? "selected" : "" %>" type="button" data-goal="SUC_BEN">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">speed</span></div>
                        <div><h3>Sức bền</h3><p>Ưu tiên tim mạch, tăng thể lực.</p></div>
                    </button>
                </div>

                <div class="actions">
                    <a class="btn secondary" href="${pageContext.request.contextPath}/home">Quay lại trang chủ</a>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <!-- STEP 2 -->
            <section class="panel" data-step="2">
                <h4>Bước 2: Chọn khung tuổi</h4>

                <div class="goal-grid">
                    <button class="card <%= "18-24".equals(currentAgeRange) ? "selected" : "" %>" type="button" data-age="18-24">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">cake</span></div>
                        <div><h3>18–24</h3><p>Nhóm tuổi trẻ, dễ thích nghi.</p></div>
                    </button>

                    <button class="card <%= "25-34".equals(currentAgeRange) ? "selected" : "" %>" type="button" data-age="25-34">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">timeline</span></div>
                        <div><h3>25–34</h3><p>Cân bằng công việc & tập luyện.</p></div>
                    </button>

                    <button class="card <%= "35-44".equals(currentAgeRange) ? "selected" : "" %>" type="button" data-age="35-44">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">health_and_safety</span></div>
                        <div><h3>35–44</h3><p>Ưu tiên bền vững & an toàn khớp.</p></div>
                    </button>

                    <button class="card <%= "45+".equals(currentAgeRange) ? "selected" : "" %>" type="button" data-age="45+">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">favorite</span></div>
                        <div><h3>45+</h3><p>Ưu tiên sức khỏe & phục hồi.</p></div>
                    </button>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <!-- STEP 3 -->
            <section class="panel" data-step="3">
                <h4>Bước 3: Chọn giới tính</h4>

                <div class="goal-grid">
                    <button class="card <%= "Nam".equals(currentGender) ? "selected" : "" %>" type="button" data-gender="Nam">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">man</span></div>
                        <div><h3>Nam</h3><p>Cá nhân hoá theo thể trạng.</p></div>
                    </button>

                    <button class="card <%= "Nữ".equals(currentGender) ? "selected" : "" %>" type="button" data-gender="Nữ">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">woman</span></div>
                        <div><h3>Nữ</h3><p>Cá nhân hoá theo thể trạng.</p></div>
                    </button>

                    <button class="card <%= "Khác".equals(currentGender) ? "selected" : "" %>" type="button" data-gender="Khác">
                        <span class="material-icons checkmark">check_circle</span>
                        <div class="icon-box"><span class="material-icons icon">diversity_3</span></div>
                        <div><h3>Khác</h3><p>Cá nhân hoá theo thể trạng.</p></div>
                    </button>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <!-- STEP 4 -->
            <section class="panel" data-step="4">
                <h4>Bước 4: Vấn đề khớp</h4>

                <div class="field">
                    <label>Chọn vị trí đang có vấn đề (hoặc chọn “Không”) <span style="color:var(--primary)">*</span></label>
                    <div class="hint" style="margin-bottom:10px;">Chỉ chọn 1 mục.</div>

                    <div class="chip-wrap">
                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Không" data-track required
                                <%= ("".equals(currentJoint) || "Không".equals(currentJoint)) ? "checked" : "" %>>
                            Không
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Cột sống Cổ (Cervical Spine)" data-track
                                <%= "Cột sống Cổ (Cervical Spine)".equals(currentJoint) ? "checked" : "" %>>
                            Cột sống Cổ (Cervical Spine)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Cột sống Lưng trên (Upper Back/Thoracic)" data-track
                                <%= "Cột sống Lưng trên (Upper Back/Thoracic)".equals(currentJoint) ? "checked" : "" %>>
                            Cột sống Lưng trên (Upper Back/Thoracic)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Cột sống Lưng dưới (Lower Back/Lumbar)" data-track
                                <%= "Cột sống Lưng dưới (Lower Back/Lumbar)".equals(currentJoint) ? "checked" : "" %>>
                            Cột sống Lưng dưới (Lower Back/Lumbar)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Vai (Shoulder)" data-track
                                <%= "Khớp Vai (Shoulder)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Vai (Shoulder)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Khuỷu tay (Elbow)" data-track
                                <%= "Khớp Khuỷu tay (Elbow)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Khuỷu tay (Elbow)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Cổ tay (Wrist)" data-track
                                <%= "Khớp Cổ tay (Wrist)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Cổ tay (Wrist)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Háng & Xương chậu (Hip & Pelvis)" data-track
                                <%= "Khớp Háng & Xương chậu (Hip & Pelvis)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Háng & Xương chậu (Hip & Pelvis)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Gối (Knee)" data-track
                                <%= "Khớp Gối (Knee)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Gối (Knee)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Khớp Cổ chân (Ankle)" data-track
                                <%= "Khớp Cổ chân (Ankle)".equals(currentJoint) ? "checked" : "" %>>
                            Khớp Cổ chân (Ankle)
                        </label>

                        <label class="chip">
                            <input type="radio" name="jointIssues" value="Bàn chân & Ngón chân (Foot & Toes)" data-track
                                <%= "Bàn chân & Ngón chân (Foot & Toes)".equals(currentJoint) ? "checked" : "" %>>
                            Bàn chân & Ngón chân (Foot & Toes)
                        </label>
                    </div>

                    <div class="hint">Thông tin này giúp hệ thống tránh bài tập gây đau/khó chịu ở khu vực đó.</div>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <!-- STEP 5 -->
            <section class="panel" data-step="5">
                <h4>Bước 5: Thời gian rảnh để tập</h4>

                <div class="field">
                    <label>Thời gian rảnh để tập <span style="color:var(--primary)">*</span></label>
                    <select class="control" name="availableTime" id="availableTime" data-track required>
                        <option value="">-- Chọn --</option>
                        <option value="15-30p" <%= "15-30p".equals(currentAvailableTime) ? "selected" : "" %>>15–30 phút</option>
                        <option value="30-45p" <%= "30-45p".equals(currentAvailableTime) ? "selected" : "" %>>30–45 phút</option>
                        <option value="45-60p" <%= "45-60p".equals(currentAvailableTime) ? "selected" : "" %>>45–60 phút</option>
                        <option value="60p+"   <%= "60p+".equals(currentAvailableTime) ? "selected" : "" %>>60 phút trở lên</option>
                    </select>
                    <div class="hint">Chọn mức thời gian bạn có thể dành cho mỗi buổi tập.</div>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <section class="panel" data-step="6">
                <h4>Bước 6: Ngày bắt đầu</h4>

                <div class="field" style="margin-top:12px;">
                    <label>Ngày muốn tập <span style="color:var(--primary)">*</span></label>
                    <div class="hint" style="margin-bottom:10px;">Chọn 1 ngày bạn sẽ bắt đầu.</div>

                    <div class="chip-wrap">
                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T2" data-track required
                                <%= "T2".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 2
                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T3" data-track required
                                <%= "T3".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 3
                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T4" data-track required
                                <%= "T4".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 4

                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T5" data-track required
                                <%= "T5".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 5

                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T6" data-track required
                                <%= "T6".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 6

                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="T7" data-track required
                                <%= "T7".equals(currentPreferredDays) ? "checked" : "" %>> Thứ 7

                        </label>

                        <label class="chip">
                            <input type="radio" name="preferredDays" value="CN" data-track required
                                <%= "CN".equals(currentPreferredDays) ? "checked" : "" %>> Chủ Nhật
                        </label>
                    </div>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="button" data-next <%= lockCreate ? "disabled" : "" %>>Tiếp tục</button>
                </div>
            </section>

            <!-- STEP 7 -->
            <section class="panel" data-step="7">
                <h4>Bước 7: Tổng kết lộ trình</h4>

                <div style="line-height:1.9">
                    <p><strong>Mục tiêu:</strong> <span id="summaryGoal"></span></p>
                    <p><strong>Khung tuổi:</strong> <span id="summaryAge"></span></p>
                    <p><strong>Giới tính:</strong> <span id="summaryGender"></span></p>
                    <p><strong>Vấn đề khớp:</strong> <span id="summaryJoint"></span></p>
                    <p><strong>Thời gian tập:</strong> <span id="summaryTime"></span></p>
                    <p><strong>Ngày bắt đầu:</strong> <span id="summaryDay"></span></p>
                </div>

                <div style="margin-top:20px">
                    <label style="cursor:pointer">
                        <input type="checkbox" id="confirmCheck">
                        Đây là toàn bộ lộ trình mục tiêu của bạn đã lựa chọn.
                        Nếu chưa đúng bạn có thể quay lại chỉnh sửa.
                        Sau khi xác nhận, bạn phải hoàn thành lộ trình này trước khi tạo mới.
                    </label>
                </div>

                <div class="actions">
                    <button class="btn secondary" type="button" data-prev>Quay lại</button>
                    <button class="btn" type="submit" id="confirmSubmit" disabled>Xác nhận & Hoàn tất</button>
                </div>
            </section>


        </form>
    </div>
    <script>
        (function () {

            const panels = Array.from(document.querySelectorAll(".panel[data-step]"));
            const stepIndicators = Array.from(document.querySelectorAll(".step[data-step-indicator]"));
            const nextBtns = document.querySelectorAll("[data-next]");
            const prevBtns = document.querySelectorAll("[data-prev]");

            const goalCards = document.querySelectorAll(".card[data-goal]");
            const goalInput = document.getElementById("goalInput");

            const ageInput = document.getElementById("ageRangeInput");
            const ageCards = document.querySelectorAll(".card[data-age]");

            const genderInput = document.getElementById("genderInput");
            const genderCards = document.querySelectorAll(".card[data-gender]");

            const form = document.getElementById("wizardForm");

            const totalCountEl = document.getElementById("totalCount");
            const doneCountEl = document.getElementById("doneCount");
            const percentTextEl = document.getElementById("percentText");
            const percentBarEl = document.getElementById("percentBar");

            const confirmCheck = document.getElementById("confirmCheck");
            const confirmSubmit = document.getElementById("confirmSubmit");

            const LOCK_CREATE = <%= lockCreate ? "true" : "false" %>;

            let currentStep = 1;
            let wizardUnlocked = false;

            function hasText(v){
                return (v || "").trim().length > 0;
            }

            function computeProgress(){
                const total = 6;
                let done = 0;

                if (hasText(goalInput.value)) done++;
                if (hasText(ageInput.value)) done++;
                if (hasText(genderInput.value)) done++;

                const jointChecked = document.querySelector("input[name='jointIssues']:checked");
                if (jointChecked) done++;

                const av = document.getElementById("availableTime");
                if (av && hasText(av.value)) done++;

                const day = document.querySelector("input[name='preferredDays']:checked");
                if (day) done++;

                const percent = Math.round((done / total) * 100);

                totalCountEl.textContent = total;
                doneCountEl.textContent = done;
                percentTextEl.textContent = percent + "%";
                percentBarEl.style.width = percent + "%";
            }

            function renderStep(step){
                currentStep = step;

                panels.forEach(p =>
                    p.classList.toggle("active", Number(p.dataset.step) === step)
                );

                stepIndicators.forEach(s =>
                    s.classList.toggle("active", Number(s.dataset.stepIndicator) === step)
                );

                if(step === 7){
                    wizardUnlocked = true;
                    updateSummary();
                }

                computeProgress();
                window.scrollTo({ top: 0, behavior: "smooth" });
            }

            function validateStep(step){

                if (LOCK_CREATE) return false;

                if (step === 1 && !hasText(goalInput.value)){
                    alert("Bước 1: Bạn hãy chọn mục tiêu.");
                    return false;
                }

                if (step === 2 && !hasText(ageInput.value)){
                    alert("Bước 2: Bạn hãy chọn khung tuổi.");
                    return false;
                }

                if (step === 3 && !hasText(genderInput.value)){
                    alert("Bước 3: Bạn hãy chọn giới tính.");
                    return false;
                }

                if (step === 4){
                    const jointChecked = document.querySelector("input[name='jointIssues']:checked");
                    if (!jointChecked){
                        alert("Bước 4: Bạn hãy chọn 1 vị trí khớp (hoặc chọn Không).");
                        return false;
                    }
                }

                if (step === 5){
                    const av = document.getElementById("availableTime");
                    if (!av || !hasText(av.value)){
                        alert("Bước 5: Bạn cần chọn thời gian rảnh để tập.");
                        return false;
                    }
                }

                if (step === 6){
                    const day = document.querySelector("input[name='preferredDays']:checked");
                    if (!day){
                        alert("Bước 6: Bạn cần chọn 1 ngày bắt đầu tập.");
                        return false;
                    }
                }

                return true;
            }

            // NEXT BUTTON
            nextBtns.forEach(btn => {
                btn.addEventListener("click", () => {

                    if (LOCK_CREATE){
                        alert("Bạn đang có mục tiêu chưa hoàn thành.");
                        return;
                    }

                    // Nếu đang ở bước 6 nhưng chưa đủ → vẫn cho vào step 7 để xem
                    if (!validateStep(currentStep)){
                        if (currentStep === 6){
                            renderStep(7);
                        }
                        return;
                    }

                    renderStep(Math.min(7, currentStep + 1));
                });
            });

            // PREV BUTTON
            prevBtns.forEach(btn => {
                btn.addEventListener("click", () =>
                    renderStep(Math.max(1, currentStep - 1))
                );
            });

            // SIDEBAR CLICK (chỉ khi unlock)
            stepIndicators.forEach(indicator => {
                indicator.addEventListener("click", function(){
                    if (!wizardUnlocked) return;

                    const targetStep = Number(this.dataset.stepIndicator);
                    renderStep(targetStep);
                });
            });

            // SELECT GOAL
            goalCards.forEach(card =>
                card.addEventListener("click", () => {
                    if (LOCK_CREATE) return;
                    goalInput.value = card.dataset.goal;
                    goalCards.forEach(c =>
                        c.classList.toggle("selected", c.dataset.goal === card.dataset.goal)
                    );
                    computeProgress();
                })
            );

            // SELECT AGE
            ageCards.forEach(card =>
                card.addEventListener("click", () => {
                    if (LOCK_CREATE) return;
                    ageInput.value = card.dataset.age;
                    ageCards.forEach(c =>
                        c.classList.toggle("selected", c.dataset.age === card.dataset.age)
                    );
                    computeProgress();
                })
            );

            // SELECT GENDER
            genderCards.forEach(card =>
                card.addEventListener("click", () => {
                    if (LOCK_CREATE) return;
                    genderInput.value = card.dataset.gender;
                    genderCards.forEach(c =>
                        c.classList.toggle("selected", c.dataset.gender === card.dataset.gender)
                    );
                    computeProgress();
                })
            );

            function updateSummary(){

                const goalMap = {
                    "GIAM_MO": "Giảm mỡ",
                    "TANG_CO": "Tăng cơ",
                    "DUY_TRI": "Duy trì",
                    "SUC_BEN": "Sức bền"
                };

                document.getElementById("summaryGoal").textContent =
                    goalMap[goalInput.value] || "";

                document.getElementById("summaryAge").textContent = ageInput.value;
                document.getElementById("summaryGender").textContent = genderInput.value;

                const joint = document.querySelector("input[name='jointIssues']:checked");
                document.getElementById("summaryJoint").textContent =
                    joint ? joint.value : "";

                const timeSelect = document.getElementById("availableTime");
                document.getElementById("summaryTime").textContent =
                    timeSelect.options[timeSelect.selectedIndex].text;

                const day = document.querySelector("input[name='preferredDays']:checked");

                const dayMap = {
                    "T2": "Thứ 2",
                    "T3": "Thứ 3",
                    "T4": "Thứ 4",
                    "T5": "Thứ 5",
                    "T6": "Thứ 6",
                    "T7": "Thứ 7",
                    "CN": "Chủ nhật"
                };

                document.getElementById("summaryDay").textContent =
                    day ? dayMap[day.value] : "";
            }

            // CONFIRM CHECK
            if(confirmCheck){
                confirmCheck.addEventListener("change", function(){
                    confirmSubmit.disabled = !this.checked;
                });
            }

            // RESET AFTER SUBMIT
            function resetWizard(){
                form.reset();

                goalInput.value = "";
                ageInput.value = "";
                genderInput.value = "";

                goalCards.forEach(c => c.classList.remove("selected"));
                ageCards.forEach(c => c.classList.remove("selected"));
                genderCards.forEach(c => c.classList.remove("selected"));

                wizardUnlocked = false;
                renderStep(1);
                computeProgress();
            }

            form.addEventListener("submit", function(e){

                if (LOCK_CREATE){
                    e.preventDefault();
                    alert("Bạn đang có mục tiêu chưa hoàn thành.");
                    return;
                }

                if (!validateStep(6)){
                    e.preventDefault();
                    return;
                }

                setTimeout(resetWizard, 500);
            });

            renderStep(1);
            computeProgress();

        })();
    </script>

</main>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đổi mật khẩu | Hardcore Gym</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

  <style>
    :root{
      --primary:#f90606;
      --bg-dark:#0a0a0a;
      --neutral-dark:#1a1a1a;
      --neutral-border:#2d2d2d;

      --input: rgba(10,10,10,0.50);
      --border-soft: var(--neutral-border);

      --shadow-neon-red: 0 0 15px -3px rgba(249, 6, 6, 0.4), 0 0 6px -2px rgba(249, 6, 6, 0.2);
      --shadow-neon-red-strong: 0 0 25px -5px rgba(249, 6, 6, 0.6);
    }

    *{ box-sizing:border-box; }
    html, body{ height:100%; }
    body{
      margin:0;
      font-family:Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
      min-height:100vh;
      background-image: radial-gradient(circle at center, #230f0f 0%, #0a0a0a 100%);
      color:#fff;
      display:flex;
      align-items:center;
      justify-content:center;
      position:relative;
      overflow:hidden;
    }

    .grain-overlay{
      position:fixed; inset:0; pointer-events:none;
      background-image:url("https://lh3.googleusercontent.com/aida-public/AB6AXuCIONejYpi__NCu7OAqBPd380VyXsr_I6rrU2JAqtLnB-EVWc96E08Y-0F6w3h20VV8FTJxdMbVrxGkq1gxSy_4Bk0bV58ioLBVihhgOch7YdCxSD8LWc9OzPFXlAIzdlsdfb0KytoqlVGxctdeH8j1Cx5C5U2_M_aYCmlTxFzUM6FuH2_dNqvoc-2pAKYSkhbuk4xouUyAgR9rduVhIkTuH8U78qWHtv54vHlr80WNbflmz5Jk-ia4vXNV9PZCrQ8qiHPLI_Iomw");
      opacity:0.03;
      z-index:0;
    }

    .glow-blob{
      position:absolute;
      width:40%;
      height:40%;
      background: rgba(249, 6, 6, 0.05);
      filter: blur(120px);
      border-radius:9999px;
      z-index:0;
    }
    .glow-blob.top-left{ top:-10%; left:-10%; }
    .glow-blob.bottom-right{ bottom:-10%; right:-10%; }

    main{
      position:relative;
      z-index:10;
      width:100%;
      max-width:520px;
      padding:0 24px;
    }

    .hero{ text-align:center; margin-bottom:26px; }
    .logo-wrap{ display:inline-flex; align-items:center; justify-content:center; margin-bottom:14px; }
    .logo{
      width:48px; height:48px; background:var(--primary);
      border-radius:12px; display:flex; align-items:center; justify-content:center;
      transform: rotate(3deg);
      box-shadow: var(--shadow-neon-red);
    }
    .logo .material-icons{ font-size:32px; color:#fff; }
    .title{
      margin:0;
      font-size:36px;
      font-weight:900;
      letter-spacing:-0.04em;
      text-transform:uppercase;
      font-style:italic;
      line-height:1.05;
    }
    .title .accent{ color:var(--primary); }
    .subtitle{
      margin:8px 0 0;
      font-size:12px;
      font-weight:600;
      letter-spacing:0.18em;
      text-transform:uppercase;
      color: rgba(255,255,255,0.40);
    }

    .card{
      background: rgba(26,26,26,0.80);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
      border: 1px solid var(--neutral-border);
      padding:32px;
      border-radius:24px;
      box-shadow: 0 25px 50px -12px rgba(0,0,0,0.55);
    }

    .notice{
      margin:0 0 18px 0;
      padding:12px 14px;
      border-radius:14px;
      background: rgba(0,0,0,0.25);
      color: rgba(255,255,255,0.92);
      font-size:12px;
      line-height:1.35;
      border: 1px solid rgba(255,255,255,0.14);
    }
    .notice.error{ border-color: rgba(249,6,6,0.35); }
    .notice.success{ border-color: rgba(0,255,160,0.35); }

    form{ display:block; }
    .space-y-6 > * + *{ margin-top:24px; }

    .field{ display:block; }
    .field-label{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;

      font-size:11px;
      font-weight:800;
      letter-spacing:0.12em;
      text-transform:uppercase;
      color: rgba(255,255,255,0.60);
      margin-left:4px;
      margin-bottom:8px;
    }
    .hint{
      font-size:10px;
      font-weight:800;
      letter-spacing:0.10em;
      text-transform:uppercase;
      color: rgba(255,255,255,0.30);
      white-space:nowrap;
    }

    .input-wrap{ position:relative; }
    .input-icon{
      position:absolute;
      left:16px;
      top:50%;
      transform:translateY(-50%);
      font-size:20px;
      color: rgba(255,255,255,0.30);
      transition: color .2s ease;
      pointer-events:none;
    }

    .toggle{
      position:absolute;
      right:10px;
      top:50%;
      transform:translateY(-50%);
      width:42px;
      height:42px;
      border:none;
      background:transparent;
      cursor:pointer;
      color: rgba(255,255,255,0.30);
      border-radius:12px;
      display:flex;
      align-items:center;
      justify-content:center;
      transition: background .2s ease, color .2s ease;
    }
    .toggle:hover{
      background: rgba(255,255,255,0.06);
      color: rgba(255,255,255,0.75);
    }
    .toggle .material-icons{ font-size:20px; line-height:1; }

    .input{
      width:100%;
      padding:16px 52px 16px 48px;
      border-radius:12px;
      border:1px solid var(--neutral-border);
      background: rgba(10,10,10,0.50);
      color:#fff;
      font-size:14px;
      font-weight:500;
      outline:none;
      transition: border-color .2s ease, box-shadow .2s ease;
    }
    .input::placeholder{ color: rgba(255,255,255,0.20); }
    .input:focus{
      border-color: var(--primary);
      box-shadow: 0 0 10px rgba(249, 6, 6, 0.3);
    }
    .input-wrap:focus-within .input-icon{ color: var(--primary); }

    .btn{
      width:100%;
      border:none;
      cursor:pointer;
      background: var(--primary);
      color:#fff;
      font-weight:900;
      padding:16px;
      border-radius:12px;
      box-shadow: var(--shadow-neon-red);
      text-transform:uppercase;
      letter-spacing:0.18em;
      display:flex;
      align-items:center;
      justify-content:center;
      gap:8px;
      transition: filter .2s ease, box-shadow .2s ease, transform .08s ease;
    }
    .btn:hover{
      filter: brightness(0.95);
      box-shadow: var(--shadow-neon-red-strong);
    }
    .btn:active{ transform: scale(0.98); }
    .btn .material-icons{ font-size:20px; transition: transform .2s ease; }
    .btn:hover .material-icons{ transform: translateX(4px); }

    .footer-row{
      margin-top:18px;
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
      flex-wrap:wrap;
    }
    .link{
      font-size:11px;
      font-weight:800;
      text-transform:uppercase;
      letter-spacing:-0.02em;
      color:#fff;
      text-decoration: underline;
      text-decoration-color: rgba(249,6,6,0.30);
      text-underline-offset:4px;
      transition: color .2s ease;
      white-space:nowrap;
    }
    .link:hover{ color: var(--primary); }

    .mini-note{
      font-size:11px;
      font-weight:600;
      color: rgba(255,255,255,0.35);
    }

    input:-webkit-autofill,
    input:-webkit-autofill:hover,
    input:-webkit-autofill:focus,
    input:-webkit-autofill:active {
      -webkit-text-fill-color: #fff !important;
      -webkit-box-shadow: 0 0 0px 1000px rgba(10,10,10,0.50) inset !important;
      box-shadow: 0 0 0px 1000px rgba(10,10,10,0.50) inset !important;
      border: 1px solid var(--neutral-border) !important;
      caret-color: #fff !important;
      transition: background-color 999999s ease-in-out 0s;
    }
    input:-webkit-autofill:focus{
      border-color: var(--primary) !important;
      box-shadow: 0 0 0 1px var(--primary), 0 0 0px 1000px rgba(10,10,10,0.50) inset !important;
    }
  </style>
</head>

<body>
<div class="grain-overlay"></div>
<div class="glow-blob top-left"></div>
<div class="glow-blob bottom-right"></div>

<%
  String error = (String) request.getAttribute("error");
  String success = (String) request.getAttribute("success");
%>

<main>
  <div class="hero">
    <div class="logo-wrap">
      <div class="logo">
        <span class="material-icons">lock_reset</span>
      </div>
    </div>

    <h1 class="title">Đổi<span class="accent">Mật khẩu</span></h1>
    <p class="subtitle">Bảo mật tài khoản</p>
  </div>

  <div class="card">

    <% if (error != null && !error.trim().isEmpty()) { %>
    <div class="notice error"><%= error %></div>
    <% } %>

    <% if (success != null && !success.trim().isEmpty()) { %>
    <div class="notice success"><%= success %></div>
    <% } %>

    <form method="post" action="${pageContext.request.contextPath}/auth?action=changePassword" class="space-y-6" autocomplete="on">
      <div class="field">
        <div class="field-label">
          <span>Mật khẩu hiện tại</span>
        </div>
        <div class="input-wrap">
          <span class="material-icons input-icon">lock</span>
          <input id="currentPassword" name="currentPassword" class="input" type="password" placeholder="Nhập mật khẩu hiện tại" required autocomplete="current-password" />
          <button type="button" class="toggle" data-toggle="currentPassword" aria-label="Hiện/ẩn mật khẩu hiện tại">
            <span class="material-icons">visibility</span>
          </button>
        </div>
      </div>

      <div class="field">
        <div class="field-label">
          <span>Mật khẩu mới</span>
          <span class="hint">tối thiểu 8 ký tự</span>
        </div>
        <div class="input-wrap">
          <span class="material-icons input-icon">enhanced_encryption</span>
          <input id="newPassword" name="newPassword" class="input" type="password" placeholder="Nhập mật khẩu mới" required autocomplete="new-password" minlength="8" />
          <button type="button" class="toggle" data-toggle="newPassword" aria-label="Hiện/ẩn mật khẩu mới">
            <span class="material-icons">visibility</span>
          </button>
        </div>
      </div>

      <div class="field">
        <div class="field-label">
          <span>Xác nhận mật khẩu mới</span>
        </div>
        <div class="input-wrap">
          <span class="material-icons input-icon">verified_user</span>
          <input id="confirmPassword" name="confirmPassword" class="input" type="password" placeholder="Nhập lại mật khẩu mới" required autocomplete="new-password" minlength="8" />
          <button type="button" class="toggle" data-toggle="confirmPassword" aria-label="Hiện/ẩn xác nhận mật khẩu">
            <span class="material-icons">visibility</span>
          </button>
        </div>
      </div>

      <button class="btn" type="submit">
        Đổi mật khẩu
        <span class="material-icons">bolt</span>
      </button>

      <div class="footer-row">
        <a class="link" href="${pageContext.request.contextPath}/profile">← Về trang Profile</a>
        <span class="mini-note">Tip: đừng dùng lại mật khẩu cũ</span>
      </div>
    </form>

  </div>
</main>

<script>
  document.querySelectorAll(".toggle").forEach(btn => {
    btn.addEventListener("click", () => {
      const id = btn.getAttribute("data-toggle");
      const input = document.getElementById(id);
      const icon = btn.querySelector(".material-icons");
      const isPw = input.type === "password";
      input.type = isPw ? "text" : "password";
      icon.textContent = isPw ? "visibility_off" : "visibility";
      input.focus();
      const len = input.value.length;
      try { input.setSelectionRange(len, len); } catch(e) {}
    });
  });
</script>
</body>
</html>

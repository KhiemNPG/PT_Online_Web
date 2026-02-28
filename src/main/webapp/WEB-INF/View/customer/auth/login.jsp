<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="vi">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đăng nhập Hardcore Gym</title>

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
    html, body { height:100%; }
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
      opacity:0.03; z-index:0;
    }

    .glow-blob{
      position:absolute; width:40%; height:40%;
      background: rgba(249, 6, 6, 0.05);
      filter: blur(120px);
      border-radius:9999px;
      z-index:0;
    }
    .glow-blob.top-left{ top:-10%; left:-10%; }
    .glow-blob.bottom-right{ bottom:-10%; right:-10%; }

    main{ position:relative; z-index:10; width:100%; max-width:440px; padding:0 24px; }

    .hero{ text-align:center; margin-bottom:40px; }
    .logo-wrap{ display:inline-flex; align-items:center; justify-content:center; margin-bottom:16px; }
    .logo{
      width:48px; height:48px; background:var(--primary);
      border-radius:12px; display:flex; align-items:center; justify-content:center;
      transform: rotate(3deg); box-shadow: var(--shadow-neon-red);
    }
    .logo .material-icons{ font-size:32px; color:#fff; }
    .title{
      margin:0; font-size:40px; font-weight:900; letter-spacing:-0.04em;
      text-transform:uppercase; font-style:italic; line-height:1.05;
    }
    .title .accent{ color:var(--primary); }
    .subtitle{
      margin:8px 0 0; font-size:12px; font-weight:600; letter-spacing:0.18em;
      text-transform:uppercase; color: rgba(255,255,255,0.40);
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

    form{ display:block; }
    .space-y-6 > * + *{ margin-top:24px; }

    .field{ display:block; }
    .field-label{
      display:block; font-size:11px; font-weight:800; letter-spacing:0.12em;
      text-transform:uppercase; color: rgba(255,255,255,0.60);
      margin-left:4px; margin-bottom:8px;
    }

    .input-wrap{ position:relative; }
    .input-icon{
      position:absolute; left:16px; top:50%;
      transform:translateY(-50%); font-size:20px;
      color: rgba(255,255,255,0.30);
      transition: color .2s ease; pointer-events:none;
    }

    .toggle{
      position:absolute; right:10px; top:50%; transform:translateY(-50%);
      width:42px; height:42px; border:none; background:transparent; cursor:pointer;
      color: rgba(255,255,255,0.30); border-radius:12px;
      display:flex; align-items:center; justify-content:center;
      transition: background .2s ease, color .2s ease;
    }
    .toggle:hover{ background: rgba(255,255,255,0.06); color: rgba(255,255,255,0.75); }
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
    .input:focus{ border-color: var(--primary); box-shadow: 0 0 10px rgba(249, 6, 6, 0.3); }
    .input-wrap:focus-within .input-icon{ color: var(--primary); }

    .row-between{
      display:flex; justify-content:space-between; align-items:center;
      margin-left:4px; margin-bottom:8px; gap:12px;
    }
    .forgot{
      font-size:11px; font-weight:800; text-transform:uppercase; letter-spacing:-0.02em;
      color: var(--primary); text-decoration: underline; text-underline-offset: 3px;
      transition: color .2s ease; white-space:nowrap;
    }
    .forgot:hover{ color: rgba(249,6,6,0.80); }

    .remember{
      display:flex; align-items:center; gap:8px; user-select:none;
    }
    .remember input[type="checkbox"]{
      width:16px; height:16px; border-radius:4px;
      border:1px solid var(--neutral-border);
      background: var(--bg-dark);
      accent-color: var(--primary);
    }
    .remember label{
      font-size:14px; font-weight:500; color: rgba(255,255,255,0.50);
    }

    .btn{
      width:100%; border:none; cursor:pointer; background: var(--primary); color:#fff;
      font-weight:900; padding:16px; border-radius:12px; box-shadow: var(--shadow-neon-red);
      text-transform:uppercase; letter-spacing:0.18em; display:flex;
      align-items:center; justify-content:center; gap:8px;
      transition: filter .2s ease, box-shadow .2s ease, transform .08s ease;
    }
    .btn:hover{ filter: brightness(0.95); box-shadow: var(--shadow-neon-red-strong); }
    .btn:active{ transform: scale(0.98); }
    .btn .material-icons{ font-size:20px; transition: transform .2s ease; }
    .btn:hover .material-icons{ transform: translateX(4px); }

    .card-footer{
      margin-top:32px; padding-top:24px; border-top:1px solid var(--neutral-border);
      text-align:center;
    }
    .card-footer p{ margin:0; font-size:14px; font-weight:500; color: rgba(255,255,255,0.40); }
    .card-footer a{
      color:#fff; font-weight:800; margin-left:4px; text-decoration: underline;
      text-decoration-color: rgba(249,6,6,0.30); text-underline-offset:4px; transition: color .2s ease;
    }
    .card-footer a:hover{ color: var(--primary); }

    .side-text{
      position:fixed; top:0; bottom:0; width:128px; display:none;
      align-items:center; justify-content:center; opacity:0.10;
      pointer-events:none; z-index:0;
    }
    .side-text.left{ left:0; }
    .side-text.right{ right:0; }
    .side-text span{ font-weight:900; font-size:96px; color:#fff; writing-mode: vertical-rl; }
    .side-text.left span{ transform: rotate(180deg); }
    @media (min-width:1280px){ .side-text{ display:flex; } }

    ::selection{ background: var(--primary); color: var(--bg-dark); }

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
  String msg = request.getParameter("msg");
  String error = (String) request.getAttribute("error");

  String oldUser = (String) request.getAttribute("username");
  if (oldUser == null) oldUser = request.getParameter("username");
  if (oldUser == null) {
    Object rememberedUser = request.getAttribute("rememberedUser");
    if (rememberedUser != null) oldUser = rememberedUser.toString();
  }

  boolean rememberChecked = false;
  Object rememberAttr = request.getAttribute("rememberChecked");
  if (rememberAttr instanceof Boolean) rememberChecked = (Boolean) rememberAttr;
%>

<main>
  <div class="hero">
    <div class="logo-wrap">
      <div class="logo">
        <span class="material-icons">fitness_center</span>
      </div>
    </div>

    <h1 class="title">Smart-<span class="accent">PT</span></h1>
    <p class="subtitle">Bản lĩnh chiến binh</p>
  </div>

  <div class="card">

    <%
      if ("register_success".equals(msg)) {
    %>
    <div style="margin:0 0 18px 0; padding:12px 14px; border-radius:14px;
                border:1px solid rgba(0,255,160,0.35);
                background: rgba(0,0,0,0.25);
                color: rgba(255,255,255,0.92);
                font-size:12px; line-height:1.35;">
      Đăng ký thành công! Vui lòng đăng nhập
    </div>
    <%
      }

      if ("reset_success".equals(msg)) {
    %>
    <div style="margin:0 0 18px 0; padding:12px 14px; border-radius:14px;
                border:1px solid rgba(0,255,160,0.35);
                background: rgba(0,0,0,0.25);
                color: rgba(255,255,255,0.92);
                font-size:12px; line-height:1.35;">
      Đặt lại mật khẩu thành công! Vui lòng đăng nhập
    </div>
    <%
      }

      if (error != null && !error.trim().isEmpty()) {
    %>
    <div style="margin:0 0 18px 0; padding:12px 14px; border-radius:14px;
                border:1px solid rgba(249,6,6,0.35);
                background: rgba(0,0,0,0.25);
                color: rgba(255,255,255,0.92);
                font-size:12px; line-height:1.35;">
      <%= error %>
    </div>
    <%
      }
    %>

    <form id="loginForm"
          method="post"
          action="${pageContext.request.contextPath}/auth?action=login"
          class="space-y-6"
          autocomplete="on">

      <div class="field">
        <label class="field-label" for="username">Tên đăng nhập</label>
        <div class="input-wrap">
          <span class="material-icons input-icon">person</span>

          <input
                  id="username"
                  name="username"
                  class="input"
                  type="text"
                  placeholder="Nhập tài khoản của bạn"
                  required
                  autocomplete="username"
                  value="<%= (oldUser != null ? oldUser : "") %>"
                  autofocus
          />
        </div>
      </div>

      <div class="field">
        <div class="row-between">
          <label class="field-label" for="password" style="margin:0;">Mật khẩu</label>
          <a class="forgot" href="${pageContext.request.contextPath}/auth?action=forgotPassword">Quên mật khẩu?</a>
        </div>

        <div class="input-wrap">
          <span class="material-icons input-icon">lock</span>

          <input
                  id="password"
                  name="password"
                  class="input"
                  type="password"
                  placeholder="••••••••"
                  required
                  autocomplete="current-password"
          />

          <button type="button" class="toggle" id="togglePw" aria-label="Hiện/ẩn mật khẩu">
            <span class="material-icons" id="pwEyeIcon">visibility</span>
          </button>
        </div>
      </div>

      <div class="remember">
        <input id="remember" name="remember" type="checkbox" <%= (rememberChecked ? "checked" : "") %> />
        <label for="remember">Ghi nhớ đăng nhập</label>
      </div>

      <button class="btn" type="submit">
        Đăng nhập
        <span class="material-icons">bolt</span>
      </button>
    </form>

    <div class="card-footer">
      <p>
        Bạn chưa có tài khoản?
        <a href="${pageContext.request.contextPath}/auth?action=register">Đăng ký ngay</a>
      </p>
    </div>
  </div>
</main>

<div class="side-text left"><span>SỨC MẠNH</span></div>
<div class="side-text right"><span>ĐẲNG CẤP</span></div>

<script>
  const pw = document.getElementById("password");
  const togglePw = document.getElementById("togglePw");
  const pwEyeIcon = document.getElementById("pwEyeIcon");

  function toggleVisibility(input, iconEl){
    const isPassword = input.type === "password";
    input.type = isPassword ? "text" : "password";
    iconEl.textContent = isPassword ? "visibility_off" : "visibility";
    input.focus();
    const len = input.value.length;
    try { input.setSelectionRange(len, len); } catch(e) {}
  }

  togglePw.addEventListener("click", () => toggleVisibility(pw, pwEyeIcon));
</script>
</body>
</html>

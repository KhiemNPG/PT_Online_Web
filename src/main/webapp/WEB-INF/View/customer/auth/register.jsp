<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đăng ký Tài khoản | Hardcore Gym</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

  <style>
    :root{
      --primary:#f90606;
      --bg:#0c0202;
      --input:#2a1010;

      --white:#fff;
      --border-soft: rgba(255,255,255,0.10);
      --text-60: rgba(255,255,255,0.60);
      --text-50: rgba(255,255,255,0.50);
      --text-40: rgba(255,255,255,0.40);
      --text-30: rgba(255,255,255,0.30);
    }

    *{ box-sizing:border-box; }
    html, body{ height:100%; }

    body{
      margin:0;
      font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
      background: var(--bg);
      color: var(--white);
      min-height:100vh;

      display:flex;
      align-items:center;
      justify-content:center;

      position:relative;
      overflow:hidden;
      padding:24px 0;
    }

    .bg-mesh{
      position:absolute;
      inset:0;
      z-index:0;
      opacity:0.50;
      background-image:
              radial-gradient(at 0% 0%, rgba(249, 6, 6, 0.15) 0, transparent 50%),
              radial-gradient(at 100% 100%, rgba(249, 6, 6, 0.10) 0, transparent 50%);
    }

    .bg-photo{
      position:absolute;
      inset:0;
      z-index:0;
      pointer-events:none;
      opacity:0.20;
    }
    .bg-photo img{
      width:100%;
      height:100%;
      object-fit:cover;
      filter: grayscale(1);
      mix-blend-mode: overlay;
      display:block;
    }

    main{
      position:relative;
      z-index:10;
      width:100%;
      max-width:438px;
      padding:32px 16px;
      margin:auto;
    }

    .card{
      background: rgba(26, 8, 8, 0.80);
      backdrop-filter: blur(24px);
      -webkit-backdrop-filter: blur(24px);
      border: 1px solid rgba(249, 6, 6, 0.30);
      border-radius:22px;
      padding:23px 40px;
      box-shadow:
              0 25px 50px -12px rgba(0,0,0,0.50),
              0 0 20px rgba(249, 6, 6, 0.10);
    }

    .header{
      text-align:center;
      margin-bottom:18px;
    }
    .badge{
      width:56px;
      height:56px;
      background: var(--primary);
      border-radius:12px;
      display:inline-flex;
      align-items:center;
      justify-content:center;
      margin-bottom:14px;
      box-shadow: 0 10px 25px rgba(249,6,6,0.20);
    }
    .badge .material-icons{
      font-size:34px;
      color:#fff;
    }

    h1{
      margin:0 0 6px 0;
      font-size:28px;
      font-weight:900;
      letter-spacing:-0.04em;
      text-transform:uppercase;
      line-height:1.1;
    }
    .tagline{
      margin:0;
      font-size:12px;
      font-weight:500;
      color: var(--text-60);
    }

    form{ margin:0; }
    .space-y-5 > * + *{ margin-top:14px; }

    .field{
      position:relative;
      margin-bottom:4px;
    }

    .field .icon{
      position:absolute;
      left:14px;
      top:0;
      height:44px;
      display:flex;
      align-items:center;
      justify-content:center;
      font-size:18px;
      color: var(--text-40);
      pointer-events:none;
      line-height:1;
      width:18px;
    }

    /* nút mắt bên phải */
    .field .toggle{
      position:absolute;
      right:10px;
      top:0;
      height:44px;
      width:44px;
      display:flex;
      align-items:center;
      justify-content:center;
      border:none;
      background:transparent;
      cursor:pointer;
      color: var(--text-40);
      border-radius:12px;
      transition: background .2s ease, color .2s ease;
    }
    .field .toggle:hover{
      background: rgba(255,255,255,0.06);
      color: rgba(255,255,255,0.78);
    }
    .field .toggle .material-icons{
      font-size:20px;
      line-height:1;
    }

    input[type="text"],
    input[type="password"]{
      width:100%;
      height:44px;
      background: var(--input);
      border: 1px solid var(--border-soft);
      border-radius:14px;
      padding:0 52px 0 42px; /* ✅ chừa chỗ icon mắt bên phải */
      color:#fff;
      font-size:13px;
      outline:none;
      transition: border-color .2s ease, box-shadow .2s ease;
    }
    input::placeholder{ color: var(--text-30); }
    input:focus{
      border-color: var(--primary);
      box-shadow: 0 0 0 1px var(--primary);
    }

    .hint{
      margin-top:6px;
      font-size:11px;
      color: var(--text-50);
      line-height:1.35;
      padding-left:4px;
    }
    .hint.ok{ color: rgba(0,255,160,0.75); }
    .hint.bad{ color: rgba(249,6,6,0.85); }

    .strength{
      margin-top:8px;
      height:8px;
      border-radius:999px;
      background: rgba(255,255,255,0.08);
      overflow:hidden;
    }
    .strength > div{
      height:100%;
      width:0%;
      border-radius:999px;
      background: var(--primary);
      transition: width .18s ease;
    }

    .terms{
      display:flex;
      align-items:flex-start;
      gap:10px;
      padding:6px 2px;
    }
    .terms input{
      margin-top:2px;
      width:15px;
      height:15px;
      border-radius:6px;
      accent-color: var(--primary);
      cursor:pointer;
    }
    .terms label{
      font-size:12px;
      color: var(--text-50);
      line-height:1.35;
    }

    .btn-primary{
      width:100%;
      border:none;
      cursor:pointer;
      background: var(--primary);
      color:#fff;
      font-weight:900;
      padding:13px;
      border-radius:14px;
      text-transform:uppercase;
      letter-spacing:0.18em;
      font-size:12px;

      display:flex;
      align-items:center;
      justify-content:center;
      gap:8px;

      box-shadow:0 12px 30px rgba(249,6,6,0.20);
      transition: transform .2s ease, background .2s ease;
      margin-top:6px;
    }
    .btn-primary:hover{
      background:#c80505;
      transform: scale(1.02);
    }
    .btn-primary .material-icons{ font-size:18px; }

    .alert{
      border-radius:14px;
      padding:10px 12px;
      font-size:12px;
      line-height:1.35;
      margin: 0 0 14px 0;
      border:1px solid rgba(249,6,6,0.35);
      background: rgba(0,0,0,0.25);
      color: rgba(255,255,255,0.92);
    }

    .bottom{
      margin-top:16px;
      text-align:center;
    }
    .bottom p{
      margin:0;
      font-size:13px;
      color: rgba(255,255,255,0.40);
    }
    .bottom a{
      color: var(--primary);
      font-weight:800;
      margin-left:6px;
      text-decoration:none;
    }
    .bottom a:hover{
      text-decoration: underline;
      text-underline-offset:4px;
    }

    @media (max-width:420px){
      main{ max-width:360px; padding:24px 12px; }
      .card{ padding:20px; border-radius:20px; }
      h1{ font-size:24px; }
    }

    ::selection{ background: var(--primary); color:#0a0a0a; }

    input:-webkit-autofill,
    input:-webkit-autofill:hover,
    input:-webkit-autofill:focus,
    input:-webkit-autofill:active {
      -webkit-text-fill-color: #fff !important;
      -webkit-box-shadow: 0 0 0px 1000px var(--input) inset !important;
      box-shadow: 0 0 0px 1000px var(--input) inset !important;
      border: 1px solid var(--border-soft) !important;
      caret-color: #fff !important;
      transition: background-color 999999s ease-in-out 0s;
    }
    input:-webkit-autofill:focus{
      border-color: var(--primary) !important;
      box-shadow: 0 0 0 1px var(--primary), 0 0 0px 1000px var(--input) inset !important;
    }
  </style>
</head>

<body>
<div class="bg-mesh"></div>
<div class="bg-photo">
  <img
          src="https://lh3.googleusercontent.com/aida-public/AB6AXuDNgcbs7TdDDpERP0P5YV8f7letzxBcla6p5nC8VXNPZMC1em8upni-A_6HxGA1D7fUddNFj69Im7wnPTr57LAl4zcU45cslictTDdKkc7lDfbDaifHRh8TNL9SFmiCgsGk8zPlo_ViQCst5dWFtr5sRSxCoaJlUoYC-it9gkANRiSRVU3RES9dmiRoFUqJql6_BSRfeC239mH3USzgdmigQUJ9k84b94wkL45lHpQAUrWJBUk7qQPCWYCvagQ7eyrqet148EbuBA"
          alt="Gym background"
  />
</div>

<%
  String error = (String) request.getAttribute("error");
  String oldUsername = (String) request.getAttribute("oldUsername");
  String paramUsername = request.getParameter("username");

  String usernameValue = "";
  if (oldUsername != null && !oldUsername.trim().isEmpty()) {
    usernameValue = oldUsername;
  } else if (paramUsername != null && !paramUsername.trim().isEmpty()) {
    usernameValue = paramUsername;
  }
%>

<main>
  <div class="card">
    <div class="header">
      <div class="badge"><span class="material-icons">fitness_center</span></div>
      <h1>Đăng ký Tài khoản</h1>
      <p class="tagline">RÈN LUYỆN BẢN THÂN TẠI NGÔI ĐỀN THÉP</p>
    </div>

    <%
      if (error != null && !error.trim().isEmpty()) {
    %>
    <div class="alert"><%= error %></div>
    <%
      }
    %>

    <form id="registerForm"
          method="post"
          action="${pageContext.request.contextPath}/auth?action=register"
          class="space-y-5">

      <div class="field">
        <span class="material-icons icon">person_outline</span>
        <input
                name="username"
                type="text"
                placeholder="Tên đăng nhập"
                required
                value="<%= usernameValue %>"
                autocomplete="username"
        />
      </div>

      <div class="field">
        <span class="material-icons icon">lock_outline</span>

        <input
                id="password"
                name="password"
                type="password"
                placeholder="Mật khẩu"
                required
                minlength="8"
                autocomplete="new-password"
                pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=\[\]{};':\\|,.<>\/?-]).{8,}$"
                title="Mật khẩu phải ≥ 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt."
        />

        <button type="button" class="toggle" id="togglePw" aria-label="Hiện/ẩn mật khẩu">
          <span class="material-icons" id="pwEyeIcon">visibility</span>
        </button>

        <div id="pwHint" class="hint">Mật khẩu ≥ 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt.</div>
        <div class="strength"><div id="pwBar"></div></div>
      </div>

      <div class="field">
        <span class="material-icons icon">verified_user</span>

        <input
                id="confirm"
                name="confirm"
                type="password"
                placeholder="Xác nhận mật khẩu"
                required
                autocomplete="new-password"
        />

        <button type="button" class="toggle" id="toggleCf" aria-label="Hiện/ẩn xác nhận mật khẩu">
          <span class="material-icons" id="cfEyeIcon">visibility</span>
        </button>

        <div id="cfHint" class="hint">Nhập lại mật khẩu cho khớp.</div>
      </div>

      <div class="terms">
        <input id="terms" name="terms" type="checkbox" required />
        <label for="terms">
          Tôi đồng ý với Điều khoản dịch vụ và Chính sách bảo mật
        </label>
      </div>

      <button class="btn-primary" type="submit">
        Đăng ký ngay <span class="material-icons">bolt</span>
      </button>
    </form>

    <div class="bottom">
      <p>
        Đã là thành viên?
        <a href="${pageContext.request.contextPath}/auth?action=login">Đăng nhập tại đây</a>
      </p>
    </div>
  </div>
</main>

<script>
  function hasLower(s){ return /[a-z]/.test(s); }
  function hasUpper(s){ return /[A-Z]/.test(s); }
  function hasNumber(s){ return /\d/.test(s); }
  function hasSpecial(s){ return /[^A-Za-z\d]/.test(s); }
  function hasLen(s){ return (s || "").length >= 8; }

  function strengthPercent(pw){
    let score = 0;
    if (hasLen(pw)) score++;
    if (hasLower(pw)) score++;
    if (hasUpper(pw)) score++;
    if (hasNumber(pw)) score++;
    if (hasSpecial(pw)) score++;
    return Math.round((score/5)*100);
  }

  const form = document.getElementById("registerForm");
  const pw = document.getElementById("password");
  const cf = document.getElementById("confirm");
  const pwHint = document.getElementById("pwHint");
  const cfHint = document.getElementById("cfHint");
  const pwBar = document.getElementById("pwBar");

  const togglePw = document.getElementById("togglePw");
  const pwEyeIcon = document.getElementById("pwEyeIcon");
  const toggleCf = document.getElementById("toggleCf");
  const cfEyeIcon = document.getElementById("cfEyeIcon");

  function toggleVisibility(input, iconEl){
    const isPassword = input.type === "password";
    input.type = isPassword ? "text" : "password";
    iconEl.textContent = isPassword ? "visibility_off" : "visibility";
    input.focus();
    const len = input.value.length;
    input.setSelectionRange(len, len);
  }

  togglePw.addEventListener("click", () => toggleVisibility(pw, pwEyeIcon));
  toggleCf.addEventListener("click", () => toggleVisibility(cf, cfEyeIcon));

  function renderPasswordState(){
    const v = pw.value || "";
    const ok = hasLen(v) && hasLower(v) && hasUpper(v) && hasNumber(v) && hasSpecial(v);

    pwBar.style.width = strengthPercent(v) + "%";

    if (!v){
      pwHint.className = "hint";
      pwHint.textContent = "Mật khẩu ≥ 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt";
      return false;
    }

    if (ok){
      pwHint.className = "hint ok";
      pwHint.textContent = "Mật khẩu đạt yêu cầu";
      return true;
    } else {
      pwHint.className = "hint bad";
      pwHint.textContent = "Chưa đạt: cần ≥ 8 ký tự + hoa + thường + số + ký tự đặc biệt";
      return false;
    }
  }

  function renderConfirmState(){
    const a = pw.value || "";
    const b = cf.value || "";
    if (!b){
      cfHint.className = "hint";
      cfHint.textContent = "Nhập lại mật khẩu cho khớp.";
      return false;
    }
    if (a === b){
      cfHint.className = "hint ok";
      cfHint.textContent = "Mật khẩu khớp";
      return true;
    } else {
      cfHint.className = "hint bad";
      cfHint.textContent = "Mật khẩu không khớp";
      return false;
    }
  }

  pw.addEventListener("input", () => { renderPasswordState(); renderConfirmState(); });
  cf.addEventListener("input", renderConfirmState);

  form.addEventListener("submit", function(e){
    const okPw = renderPasswordState();
    const okCf = renderConfirmState();
    if(!okPw || !okCf){
      e.preventDefault();
      (okPw ? cf : pw).focus();
    }
  });
</script>
</body>
</html>

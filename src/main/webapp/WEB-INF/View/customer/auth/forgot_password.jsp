<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quên mật khẩu | Smart PT</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

    <style>
        :root{
            --primary:#f90606;
            --bg-dark:#0a0a0a;
            --neutral-border:#2d2d2d;
            --shadow-neon-red: 0 0 15px -3px rgba(249, 6, 6, 0.4), 0 0 6px -2px rgba(249, 6, 6, 0.2);
            --shadow-neon-red-strong: 0 0 25px -5px rgba(249, 6, 6, 0.6);
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:Inter;
            min-height:100vh;
            background-image: radial-gradient(circle at center, #230f0f 0%, #0a0a0a 100%);
            color:#fff;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        main{
            width:100%;
            max-width:520px;
            padding:0 24px;
        }
        .hero{text-align:center;margin-bottom:26px;}
        .logo{
            width:48px;
            height:48px;
            background:var(--primary);
            border-radius:12px;
            display:flex;
            align-items:center;
            justify-content:center;
            margin:auto;
        }
        .logo .material-icons{
            font-size:32px;
            color:white;
        }
        .title{
            font-size:34px;
            font-weight:900;
            text-transform:uppercase;
        }
        .title .accent{
            color:var(--primary);
        }
        .subtitle{
            font-size:12px;
            opacity:.6;
        }
        .card{
            background:rgba(26,26,26,0.8);
            border:1px solid var(--neutral-border);
            padding:32px;
            border-radius:24px;
        }
        .notice{
            margin-bottom:18px;
            padding:12px;
            border-radius:14px;
            background:rgba(0,0,0,0.25);
            font-size:12px;
        }
        .notice.error{
            border:1px solid rgba(249,6,6,0.35);
        }
        .space-y-6 > * + *{ margin-top:24px; }

        .field-label{
            font-size:11px;
            font-weight:800;
            text-transform:uppercase;
            opacity:.7;
        }
        .input-wrap{ position:relative; }
        .input-icon{
            position:absolute;
            left:16px;
            top:50%;
            transform:translateY(-50%);
            opacity:.3;
        }
        .input{
            width:100%;
            padding:16px 52px 16px 48px;
            border-radius:12px;
            border:1px solid var(--neutral-border);
            background:#111;
            color:white;
        }
        .toggle{
            position:absolute;
            right:10px;
            top:50%;
            transform:translateY(-50%);
            background:none;
            border:none;
            color:white;
            cursor:pointer;
        }
        .btn{
            width:100%;
            background:var(--primary);
            border:none;
            color:white;
            padding:16px;
            border-radius:12px;
            font-weight:900;
            cursor:pointer;
        }
        .hint{
            font-size:11px;
            opacity:.7;
            margin-top:6px;
        }
        .strength{
            height:8px;
            background:#222;
            border-radius:999px;
            margin-top:8px;
            overflow:hidden;
        }
        .strength div{
            height:100%;
            width:0%;
            background:var(--primary);
            transition:.2s;
        }
        .otp-container{
            display:flex;
            gap:10px;
            justify-content:center;
        }
        .otp-input{

            width:50px;
            height:55px;
            text-align:center;
            font-size:20px;
            border-radius:10px;
            border:1px solid var(--neutral-border);
            background:#111;
            color:white;
        }
        .otp-container{
            display:flex;
            gap:10px;
            justify-content:center;
            margin-top:10px;
        }
        .otp-input{
            width:50px;
            height:55px;
            text-align:center;
            font-size:20px;
            border-radius:10px;
            border:1px solid var(--neutral-border);
            background:#111;
            color:white;
            outline:none;
        }
        .otp-input:focus{
            border-color:var(--primary);
            box-shadow:0 0 6px rgba(249,6,6,0.6);
        }
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
            color:#fff;
            text-decoration: underline;
            text-decoration-color: rgba(249,6,6,0.30);
            text-underline-offset:4px;
            transition: color .2s ease;
        }
        .link:hover{
            color: var(--primary);
        }
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
<%
    String error = (String) request.getAttribute("error");
    String step = (String) request.getAttribute("step");
    if(step == null) step = "email";
%>
<main>
    <div class="hero">
        <div class="logo">
            <span class="material-icons">lock_reset</span>
        </div>
        <h1 class="title">Quên<span class="accent">Mật khẩu</span></h1>
        <p class="subtitle">Đặt lại mật khẩu</p>
    </div>

    <div class="card">
        <% if(error!=null){ %>
        <div class="notice error"><%=error%></div>
        <% } %>
        <% if("email".equals(step)){ %>
        <form method="post"
              action="${pageContext.request.contextPath}/auth?action=forgotPassword"
              class="space-y-6">
            <div>
                <label class="field-label">Email</label>
                <div class="input-wrap">
                    <span class="material-icons input-icon">mail</span>
                    <input
                            class="input"
                            type="email"
                            name="email"
                            placeholder="Nhập email đăng ký"
                            required>
                </div>
            </div>
            <button class="btn">
                Gửi mã OTP
            </button>
            <div class="footer-row">
                <a class="link"
                   href="${pageContext.request.contextPath}/auth?action=login">
                    ← Quay lại đăng nhập
                </a>
            </div>
        </form>
        <% } %>


        <% if("otp".equals(step)){ %>
        <form method="post"
              action="${pageContext.request.contextPath}/auth?action=verifyOtp"
              class="space-y-6">
            <div>
                <label class="field-label">Nhập OTP</label>
                <div class="otp-container">
                    <input type="text" maxlength="1" class="otp-input">
                    <input type="text" maxlength="1" class="otp-input">
                    <input type="text" maxlength="1" class="otp-input">
                    <input type="text" maxlength="1" class="otp-input">
                    <input type="text" maxlength="1" class="otp-input">
                    <input type="text" maxlength="1" class="otp-input">
                </div>
                <input type="hidden" name="otp" id="otpValue">
            </div>
            <button class="btn">
                Xác nhận OTP
            </button>
            <div class="hint" id="otpTimer">
                Bạn có thể gửi lại OTP sau 05:00
            </div>
            <a id="resendOtp"
               style="display:none"
               class="link"
               href="${pageContext.request.contextPath}/auth?action=forgotPassword">
                Gửi lại OTP
            </a>
        </form>
        <% } %>


        <% if("reset".equals(step)){ %>
        <form method="post"
              action="${pageContext.request.contextPath}/auth?action=resetPassword"
              class="space-y-6">
            <div>
                <label class="field-label">Mật khẩu mới</label>
                <div class="input-wrap">
                    <span class="material-icons input-icon">enhanced_encryption</span>
                    <input id="newPassword"
                           name="newPassword"
                           class="input"
                           type="password"
                           placeholder="Nhập mật khẩu mới"
                           required minlength="8">
                    <button type="button" class="toggle" data-toggle="newPassword">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
                <div id="pwHint" class="hint">
                    Mật khẩu ≥ 8 ký tự
                </div>
                <div class="strength">
                    <div id="pwBar"></div>
                </div>
            </div>
            <div>
                <label class="field-label">Xác nhận mật khẩu</label>
                <div class="input-wrap">
                    <span class="material-icons input-icon">verified_user</span>
                    <input id="confirmPassword"
                           name="confirmPassword"
                           class="input"
                           type="password"
                           placeholder="Nhập lại mật khẩu"
                           required minlength="8">
                    <button type="button" class="toggle" data-toggle="confirmPassword">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
                <div id="cfHint" class="hint">
                    Nhập lại mật khẩu cho khớp
                </div>
            </div>
            <button class="btn">
                Đặt lại mật khẩu
            </button>
        </form>
        <% } %>
    </div>
</main>

<script>
    const pw = document.getElementById("newPassword")
    const cf = document.getElementById("confirmPassword")
    if(pw && cf){
        const bar = document.getElementById("pwBar")
        const hint = document.getElementById("pwHint")
        const cfHint = document.getElementById("cfHint")
        function strongPassword(v){
            return (
                v.length >= 8 &&
                /[A-Z]/.test(v) &&
                /[a-z]/.test(v) &&
                /\d/.test(v) &&
                /[^A-Za-z0-9]/.test(v)
            )
        }
        pw.oninput = () => {
            let v = pw.value
            let score = 0
            if(v.length>=8) score++
            if(/[A-Z]/.test(v)) score++
            if(/[a-z]/.test(v)) score++
            if(/[0-9]/.test(v)) score++
            if(/[^A-Za-z0-9]/.test(v)) score++
            bar.style.width = (score*20) + "%"
            if(strongPassword(v)){
                hint.className="hint ok"
                hint.innerText="Mật khẩu đạt yêu cầu"
            }else{
                hint.className="hint bad"
                hint.innerText="Phải có: ≥8 ký tự, chữ hoa, chữ thường, số và ký tự đặc biệt"
            }
        }
        cf.oninput = () => {
            if(cf.value === pw.value){
                cfHint.className="hint ok"
                cfHint.innerText="Mật khẩu khớp"
            }else{
                cfHint.className="hint bad"
                cfHint.innerText="Mật khẩu không khớp"
            }
        }
        const resetForm = document.querySelector("form[action*='resetPassword']")
        if(resetForm){
            resetForm.onsubmit = function(e){
                if(!strongPassword(pw.value)){
                    hint.className="hint bad"
                    hint.innerText="Mật khẩu phải có chữ hoa, chữ thường, số và ký tự đặc biệt"
                    e.preventDefault()
                    return
                }
                if(pw.value !== cf.value){
                    cfHint.className="hint bad"
                    cfHint.innerText="Mật khẩu xác nhận không khớp"
                    e.preventDefault()
                }
            }
        }
    }
    const otpInputs = document.querySelectorAll(".otp-input")
    if(otpInputs.length){
        otpInputs.forEach((input,index)=>{
            input.addEventListener("input",()=>{
                input.value = input.value.replace(/[^0-9]/g,'')
                if(input.value.length === 1 && index < otpInputs.length-1){
                    otpInputs[index+1].focus()
                }
            })
            input.addEventListener("keydown",(e)=>{

                if(e.key==="Backspace" && !input.value && index>0){
                    otpInputs[index-1].focus()
                }
            })
            input.addEventListener("paste",(e)=>{
                e.preventDefault()
                const pasteData = (e.clipboardData || window.clipboardData)
                    .getData("text")
                    .trim()
                if(!/^\d{6}$/.test(pasteData)) return
                const digits = pasteData.split("")
                otpInputs.forEach((box,i)=>{
                    box.value = digits[i] || ""
                })
                otpInputs[Math.min(digits.length,5)].focus()
            })
        })
        const otpForm = document.querySelector("form[action*='verifyOtp']")
        if(otpForm){
            otpForm.addEventListener("submit",function(){
                let otp=""
                otpInputs.forEach(i => otp += i.value)
                document.getElementById("otpValue").value = otp
            })
        }
    }
    const timer = document.getElementById("otpTimer")
    const resend = document.getElementById("resendOtp")
    if(timer){
        let time = 300
        const interval = setInterval(()=>{
            let m = Math.floor(time/60)
            let s = time%60
            timer.innerText =
                "Bạn có thể gửi lại OTP sau "
                +(m<10?"0"+m:m)+":"
                +(s<10?"0"+s:s)
            time--
            if(time < 0){
                clearInterval(interval)
                timer.style.display="none"
                if(resend) resend.style.display="inline"
            }
        },1000)
    }
    document.querySelectorAll(".toggle").forEach(btn => {
        btn.addEventListener("click", () => {
            const id = btn.getAttribute("data-toggle")
            const input = document.getElementById(id)
            const icon = btn.querySelector(".material-icons")
            if (!input) return
            if (input.type === "password") {
                input.type = "text"
                icon.textContent = "visibility_off"
            } else {
                input.type = "password"
                icon.textContent = "visibility"
            }
        })
    })
</script>
</body>
</html>
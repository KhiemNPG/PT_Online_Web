<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

    <style>
        .toast-custom{
            position:fixed;
            top:90px;
            right:24px;
            z-index:999999;
            padding:16px 18px;
            border-radius:14px;
            background:rgba(0,0,0,.9);
            color:#fff;
            font-weight:700;
            box-shadow:0 8px 20px rgba(0,0,0,.4);
            animation:fadeIn .3s ease;
            transition:opacity .3s ease, transform .3s ease;
        }

        .toast-custom .small{
            display:block;
            font-size:12px;
            margin-top:6px;
            opacity:.8;
        }

        @keyframes fadeIn{
            from{opacity:0; transform:translateY(-10px);}
            to{opacity:1; transform:translateY(0);}
        }
    </style>
</head>

<body>

<%
    Boolean goalSuccess = (Boolean) request.getAttribute("goalSuccess");
    Boolean profileIncomplete = (Boolean) request.getAttribute("profileIncomplete");

    if (goalSuccess != null && goalSuccess) {
%>

<div class="toast-custom" id="goalToast">
    Chúc mừng! Bạn đã thiết lập lộ trình của bạn xong

    <% if (profileIncomplete != null && profileIncomplete) { %>
    <span class="small" style="color:#facc15;">
        Vui lòng nhập đầy đủ thông tin chi tiết ở profile của bạn
            </span>
    <% } %>
</div>

<script>
    setTimeout(() => {
        const toast = document.getElementById("goalToast");
        if (toast) {
            toast.style.opacity = "0";
            toast.style.transform = "translateY(-10px)";
            setTimeout(() => toast.remove(), 300);
        }
    }, 5000);
</script>

<%
    }
%>

<jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/heroSection.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/statistics.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/coreFeatures.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/bmiGuest.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/comparison.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/technologyDemo.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/pricing.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/finalCTA.jsp"/>
<jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>

</body>
</html>
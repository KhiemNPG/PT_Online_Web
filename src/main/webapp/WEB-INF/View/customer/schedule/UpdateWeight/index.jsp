<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elite Dashboard</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            background:#000;
            color:#fff;
            font-family:'Inter',sans-serif;
        }

        /* Layout full height */
        .layout-wrapper{
            min-height:100vh;
            display:flex;
            flex-direction:column;
        }

        .layout-content{
            flex:1;
            width:100%;
        }
    </style>
</head>

<body>

<div class="layout-wrapper">
    <jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>
    <div class="layout-content">
        <jsp:include page="/WEB-INF/View/customer/schedule/UpdateWeight/components/tracking.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>

</div>
</body>
</html>
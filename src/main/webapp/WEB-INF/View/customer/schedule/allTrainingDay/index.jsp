
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elite Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" rel="stylesheet">

    <style>
        body { background-color: #000; color: #fff; font-family: 'Inter', sans-serif; overflow-x: hidden; }
        /* Để CSS dùng chung ở đây hoặc tạo file style.css riêng */
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>

    <jsp:include page="/WEB-INF/View/customer/schedule/allTrainingDay/components/headerDashboard.jsp"/>

    <jsp:include page="/WEB-INF/View/customer/schedule/allTrainingDay/components/trainingDayDetail.jsp"/>

    <jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>
</body>
</html>
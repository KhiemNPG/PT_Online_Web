<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/heroSection.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/statistics.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/coreFeatures.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/bmiGuest.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/comparison.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/technologyDemo.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/package/components/heroSection.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/finalCTA.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">

</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/package/components/heroSection.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/package/components/reason.jsp"/>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>
</body>
</html>
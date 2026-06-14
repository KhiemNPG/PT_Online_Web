<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>

    </style>
</head>
<body>

<div class="admin-layout-wrapper">

    <jsp:include page="/WEB-INF/View/admin/dashboard.jsp"/>

    <main class="admin-main-content" style="margin-left: 270px; max-width: calc(100% - 280px); padding: 1%">

        <jsp:include page="/WEB-INF/View/admin/general/components/generalInformation.jsp"/>

        <div class="row g-4 mt-1">
            <div class="col-12 col-lg-8">
                <jsp:include page="/WEB-INF/View/admin/general/components/ranking.jsp"/>
            </div>

            <div class="col-12 col-lg-4">
                <jsp:include page="/WEB-INF/View/admin/general/components/chart.jsp"/>
            </div>
        </div>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách giao dịch - Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>

    </style>
</head>
<body>

<div class="admin-layout-wrapper">

    <jsp:include page="/WEB-INF/View/admin/dashboard.jsp"/>

    <main class="admin-main-content" style="margin-left: 270px; max-width: calc(100% - 280px); padding: 1%">

        <jsp:include page="/WEB-INF/View/admin/paymentConfirmation/allPayment/components/generalInformation.jsp"/>

        <jsp:include page="/WEB-INF/View/admin/paymentConfirmation/allPayment/components/listPaymentConfirmation.jsp"/>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
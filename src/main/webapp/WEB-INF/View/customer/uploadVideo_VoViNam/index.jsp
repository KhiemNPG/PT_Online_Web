<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa lỗi động tác Vo Vi Nam</title>
    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/pose/pose.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@mediapipe/drawing_utils/drawing_utils.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <style>
        body { background-color: #000; color: #fff; font-family: 'Inter', sans-serif; overflow-x: hidden; }
        /* Để CSS dùng chung ở đây hoặc tạo file style.css riêng */
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>

<jsp:include page="/WEB-INF/View/customer/uploadVideo_VoViNam/components/formUpload.jsp"/>

<jsp:include page="/WEB-INF/View/customer/homePage/components/footer.jsp"/>
</body>
</html>
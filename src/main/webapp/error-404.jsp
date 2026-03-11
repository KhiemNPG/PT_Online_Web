<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Trang không tồn tại!</title>
    <style>
        body { text-align: center; font-family: sans-serif; padding-top: 50px; }
        .error-code { font-size: 100px; color: #ff6b6b; margin: 0; }
        .btn-home { text-decoration: none; background: #3498db; color: white; padding: 10px 20px; border-radius: 5px; }
    </style>
</head>
<body>
<h1 class="error-code">404</h1>
<h2>Oops! Trang bạn tìm kiếm hiện không có sẵn.</h2>
<p>Có vẻ như link bạn vừa sửa hoặc nhập tay không đúng rồi.</p>
<br>
<a href="${pageContext.request.contextPath}/home" class="btn-home">Quay về trang chủ</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String currentDate = (String) request.getAttribute("currentDate");
    %>
<style>
    body {
        background-color: #000; /* Nền đen sâu */
        font-family: 'Inter', sans-serif;
        color: white;

    }

    /* Tiêu đề chính cực đậm */
    .title-main {
        font-weight: 900;
        font-size: 3rem;
        letter-spacing: -1px;
        text-transform: uppercase;
    }

    /* Dòng chào hỏi mờ */
    .subtitle-chaomung {
        color: rgba(255, 255, 255, 0.5);
        font-size: 1.1rem;
    }

    /* Hiệu ứng thẻ kính mờ (Glassmorphism) */
    .glass-card {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 16px;
        padding: 12px 24px;
        display: inline-flex;
        align-items: center;
    }

    /* Chấm đỏ phát sáng */
    .status-dot-active {
        width: 10px;
        height: 10px;
        background-color: #ff0000;
        border-radius: 50%;
        display: inline-block;
        box-shadow: 0 0 10px rgba(255, 0, 0, 0.8);
        margin-right: 8px;
    }

    /* Chấm xám nghỉ ngơi */
    .status-dot-idle {
        width: 10px;
        height: 10px;
        background-color: rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        display: inline-block;
        margin-right: 8px;
    }

    .status-text {
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: rgba(255, 255, 255, 0.7);
    }

    .divider {
        width: 1px;
        height: 20px;
        background-color: rgba(255, 255, 255, 0.1);
        margin: 0 20px;
    }

    .header-status-text-tt {
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: rgba(255, 255, 255, 0.7);
    font-style: normal !important; /* Ép không cho nghiêng */
}
</style>
<div class="container-fluid">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-4">

        <div>
            <h1 class="title-main m-0"><%= currentDate %></h1>
            <p class="subtitle-chaomung mt-2">Chào mừng bạn trở lại. Hãy cùng bắt đầu công việc hôm nay.</p>
        </div>

        <div class="glass-card">
            <div class="d-flex align-items-center">
                <span class="status-dot-active"></span>
                <span class="header-status-text-tt">Tập luyện</span>
            </div>

            <div class="divider"></div>

            <div class="d-flex align-items-center">
                <span class="status-dot-idle"></span>
                <span class="header-status-text-tt">Nghỉ ngơi</span>
            </div>
        </div>

    </div>
</div>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.PersonalTrainer" %>
<%
List< PersonalTrainer> personalTrainerList = (List< PersonalTrainer>) request.getAttribute("personalTrainerList");
    %>

    <!-- Nhúng font Inter và Icon Google Symbols nếu trang layout chính chưa có -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <style>
        :root {
            --elite-red: #ff0000;
            --elite-red-glow: rgba(255, 0, 0, 0.25);
            --glass-white: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.08);
            --text-muted: #94a3b8;
        }

        /* Định dạng bọc lưới Bento */
        .pt-grid-container {
            font-family: 'Inter', sans-serif;
            background-color: #000000;
            padding: 20px 0;
        }

        /* Đường chia khu vực phong cách Elite */
        .section-divider-container { display: flex; align-items: center; gap: 20px; margin: 20px 0 35px; }
        .section-title { font-size: 1.4rem; font-weight: 900; white-space: nowrap; letter-spacing: -0.5px; text-transform: uppercase; color: #ffffff; }
        .section-line { flex-grow: 1; height: 1px; background: linear-gradient(90deg, rgba(255, 0, 0, 0.6) 0%, rgba(255, 255, 255, 0) 100%); }

        /* Thẻ PT Bento Box */
        .pt-bento-card {
            background: var(--glass-white);
            border: 1px solid var(--glass-border);
            border-radius: 1.25rem;
            padding: 1.5rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        /* Hiệu ứng hover phát sáng viền đỏ cực ngầu */
        .pt-bento-card:hover {
            border-color: var(--elite-red);
            box-shadow: 0 0 25px var(--elite-red-glow);
            transform: translateY(-4px);
            background: rgba(255, 0, 0, 0.01);
        }

        /* Container bao ảnh chân dung của PT */
        .pt-avatar-frame {
            width: 100%;
            height: 200px;
            border-radius: 0.85rem;
            overflow: hidden;
            position: relative;
            background: #11141d;
            margin-bottom: 1.25rem;
            border: 1px solid rgba(255, 255, 255, 0.03);
        }
        .pt-avatar-frame img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .pt-bento-card:hover .pt-avatar-frame img {
            transform: scale(1.05);
        }

        /* Badge năm kinh nghiệm đè lên góc ảnh giống hệ thống cũ */
        .experience-tag {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(0, 0, 0, 0.75);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.1);
            color: #ffffff;
            font-size: 0.65rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Tên PT & Chuyên môn */
        .pt-name { font-size: 1.15rem; font-weight: 800; color: #ffffff; margin-bottom: 0.25rem; letter-spacing: -0.3px; }
        .pt-specialty { font-size: 0.65rem; font-weight: 900; color: var(--elite-red); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 1rem; }

        /* Chỉ số thành tích hàng ngang */
        .pt-stats-row {
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.03);
            border-radius: 0.75rem;
            padding: 0.75rem;
            margin-bottom: 1.25rem;
        }
        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .stat-label { font-size: 0.6rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 2px; }
        .stat-value { font-size: 0.9rem; font-weight: 800; color: #ffffff; display: flex; align-items: center; gap: 3px; }

        /* Nút bấm hành động chuyển trang chi tiết */
        .btn-elite-profile {
            display: block;
            width: 100%;
            box-sizing: border-box;
            background: var(--elite-red);
            color: #ffffff !important;
            text-decoration: none !important;
            text-align: center;
            padding: 0.8rem;
            border-radius: 0.75rem;
            font-weight: 900;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.2s ease;
            border: none;
            box-shadow: 0 4px 12px rgba(255, 0, 0, 0.2);
            margin-top: auto; /* Đẩy nút xuống đáy card để các ô đều nhau */
        }
        .btn-elite-profile:hover {
            background: #cc0000;
            box-shadow: 0 0 20px var(--elite-red-glow);
            transform: scale(1.01);
        }

        /* Trạng thái trống */
        .empty-pt-message {
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            text-align: center;
            padding: 40px 0;
        }
    </style>

    <div class="container-fluid pt-grid-container px-4">

        <!-- Thanh tiêu đề thiết kế phân dòng dứt khoát -->
        <div class="section-divider-container">
            <h2 class="section-title">Đội ngũ huấn luyện viên chuyên nghiệp</h2>
            <div class="section-line"></div>
        </div>

        <!-- Lưới danh bạ thẻ PT dạng 4 cột trên PC, tự co giãn trên Mobile -->
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-4">
            <%
            if (personalTrainerList != null && !personalTrainerList.isEmpty()){
            for (PersonalTrainer p: personalTrainerList){
            %>
            <div class="col">
                <div class="pt-bento-card">

                    <!-- Khung ảnh bọc thẻ trải nghiệm -->
                    <div class="pt-avatar-frame">
                        <!-- Ảnh đại diện PT cứng cáp -->
                        <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuAu602zr5Gx3stpB9fhsfsIfxzTYiPlU2ol4uaoptF_p99S8TDe5Acy8-c9RN2wR05udU1IOHNvQO_OrMNuRNYGf0iCz0ft_qo8c-xobYevBGcMjwcNteNzcftRgnhRTHuOQmmzlzOzBg4Y6FLZ5y8ekdl7n1uvvESVH_wxbgASqvNUzMKCnil4I6E15ihyXcZKRXr5a1oAjbQZEbfMxXMfq1JaYQPeysdDLHy8ZbhgWVAULimqvtXf_WYAB0mu4iLEe0mrGAjWuvk" alt="<%= p.getName() %>">

                        <!-- Nhãn số năm kinh nghiệm dán góc -->
                        <div class="experience-tag">
                            <%= p.getExperienceYears() %> Năm KN
                        </div>
                    </div>

                    <!-- Tên danh tính và Danh hiệu chuyên môn chính -->
                    <h3 class="pt-name text-truncate"><%= p.getName() %></h3>
                    <div class="pt-specialty"><%= p.getTitleLabel() %></div>

                    <!-- Khối Bento phụ: Chứa các thông số uy tín cốt lõi -->
                    <div class="pt-stats-row">
                        <div class="row g-0 text-center">
                            <!-- Cột thành tích học viên -->
                            <div class="col-6 border-end border-secondary border-opacity-10 stat-item">
                                <span class="stat-label">Thành tích</span>
                                <span class="stat-value text-warning">
                                <span class="material-symbols-outlined text-warning" style="font-size: 16px;">emoji_events</span>
                                <%= p.getSuccessfulStudents() %> HV
                            </span>
                            </div>
                            <!-- Cột mã số số hiệu nội bộ -->
                            <div class="col-6 stat-item">
                                <span class="stat-label">Mã số PT</span>
                                <span class="stat-value font-monospace" style="font-size: 13px; color: #38bdf8;">
                                PT-<%= p.getPtId() %>
                            </span>
                            </div>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/PT_Detail" class="btn-elite-profile">

                        Xem hồ sơ & Đăng ký

                    </a>

                </div>
            </div>
            <%
            }
            } else {
            %>
            <!-- Trạng thái phòng vệ hệ thống khi trống danh sách -->
            <div class="col-12 w-100 text-center py-5">
                <p class="empty-pt-message">
                    <span class="material-symbols-outlined align-middle me-2">history_toggle_off</span>
                    Hiện tại hệ thống chưa cập nhật dữ liệu Huấn luyện viên nào!
                </p>
            </div>
            <%
            }
            %>
        </div>
    </div>
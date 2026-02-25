<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>

    body{
        background:#0f0f0f;
        color:#f5f5f5;
        font-family:'Segoe UI',sans-serif;
        margin:0;
    }

    /* ================= HERO ================= */

    .blog-hero{
        position:relative;
        height:520px;
        display:flex;
        align-items:center;
        justify-content:center;
        text-align:center;
        overflow:hidden;
    }

    .hero-bg{
        position:absolute;
        inset:0;
        background:url('https://images.unsplash.com/photo-1599058917212-d750089bc07e') center/cover no-repeat;
        filter:blur(2px) brightness(0.6);
        transform:scale(1.1);
    }

    .hero-overlay{
        position:absolute;
        inset:0;
        background:rgba(0,0,0,0.35);
    }

    .hero-content{
        position:relative;
        z-index:2;
        max-width:900px;
        padding:20px;
    }

    .hero-badge{
        display:inline-block;
        background:#f90606;
        padding:6px 16px;
        border-radius:30px;
        font-size:12px;
        font-weight:700;
        letter-spacing:1px;
        margin-bottom:25px;
    }

    .hero-title{
        font-size:48px;
        font-weight:900;
        line-height:1.2;
    }

    .hero-title span{
        color:#f90606;
    }

    .hero-desc{
        margin-top:20px;
        color:#ddd;
        font-size:18px;
    }

    /* ================= MAIN ================= */

    .blog-wrapper{
        max-width:1150px;
        margin:auto;
        padding:15px 20px;
    }

    .layout{
        display:grid;
        grid-template-columns:3fr 1.2fr;
        gap:60px;
    }

    /* ================= CONTENT ================= */

    .content{
        font-size:18px;
        line-height:1.9;
    }

    .content h2{
        font-size:30px;
        margin-top:70px;
        margin-bottom:20px;
        font-weight:800;
        border-left:5px solid #f90606;
        padding-left:15px;
    }

    .content h3{
        font-size:22px;
        margin-top:40px;
        font-weight:700;
        color:#ffffff;
    }

    .content p{
        color:#d0d0d0;
        margin-bottom:20px;
    }

    .content ul{
        margin:20px 0 30px 25px;
    }

    .content li{
        margin-bottom:10px;
    }

    .quote-box{
        background:#161616;
        border-left:4px solid #f90606;
        padding:25px;
        margin:50px 0;
        font-style:italic;
        border-radius:8px;
    }

    /* ================= BACK BUTTON ================= */

    .back-btn{
        display:inline-block;
        margin-top:60px;
        padding:14px 30px;
        background:#f90606;
        border-radius:8px;
        text-decoration:none;
        color:#fff;
        font-weight:700;
        transition:0.3s;
    }

    .back-btn:hover{
        background:#c00404;
    }

    /* ================= SIDEBAR ================= */

    .sidebar-card{
        background:#161616;
        padding:30px;
        border-radius:12px;
        margin-bottom:40px;
    }

    .sidebar-title{
        font-size:18px;
        font-weight:800;
        margin-bottom:20px;
        border-bottom:1px solid #222;
        padding-bottom:10px;
    }

    .sidebar-card ul{
        padding-left:20px;
    }

    .sidebar-card li{
        margin-bottom:12px;
        font-size:15px;
        color:#bbbbbb;
    }

    .related-item img{
        width:80px;
        height:65px;
        object-fit:cover;
        border-radius:8px;
    }

    @media(max-width:992px){
        .layout{
            grid-template-columns:1fr;
        }
        .hero-title{
            font-size:32px;
        }
    }

</style>
<div class="blog-hero">
    <div class="hero-bg"></div>
    <div class="hero-overlay"></div>

    <div class="hero-content">
        <span class="hero-badge">KIẾN THỨC TẬP LUYỆN</span>
        <h1 class="hero-title">
            Dumbbell <span>RDL</span>: Kỹ Thuật & Lợi Ích
        </h1>
        <p class="hero-desc">
            Tăng sức mạnh cơ mông – gân kheo – cải thiện tư thế và phòng ngừa chấn thương hiệu quả.
        </p>
    </div>
</div>

<div class="blog-wrapper">
    <div class="layout">

        <div class="content">

            <h2>Dumbbell Romanian Deadlift (RDL) là gì?</h2>

            <p>Dumbbell Romanian Deadlift (RDL) là một bài tập compound tuyệt vời, tập trung chủ yếu vào các cơ ở phía sau chân và mông. Nó khác biệt với deadlift truyền thống ở chỗ trọng lượng được giữ trong quá trình hạ xuống, tạo ra sự căng kéo liên tục cho các cơ liên quan. Bài tập này không chỉ giúp tăng cường sức mạnh mà còn cải thiện sự linh hoạt và ổn định của cơ thể.</p>

            <h2>Cơ chế hoạt động của Dumbbell RDL</h2>

            <p>Để thực hiện đúng kỹ thuật Dumbbell RDL, người tập cần duy trì một tư thế thẳng lưng suốt quá trình thực hiện. Bắt đầu bằng việc đứng thẳng, hai chân rộng bằng vai và cầm một hoặc hai quả tạ đơn trong tay.</p>

            <p>Từ từ gập người về phía trước ở hông, giữ cho lưng thẳng và mông hướng về phía sau. Khi hạ thấp người xuống, cảm nhận sự căng kéo ở phần sau đùi và mông. Mục tiêu là hạ tạ xuống đến khi cơ thể gần như song song với mặt đất nhưng không để lưng bị cong. Sau đó, dùng sức của chân và mông để trở lại tư thế ban đầu.</p>

            <p>Sự chuyển động chính của bài tập là ở khớp hông, không phải ở lưng. Việc giữ lưng thẳng là yếu tố then chốt để tránh chấn thương.</p>

            <h2>Các nhóm cơ chính được tác động</h2>

            <ul>
                <li><strong>Cơ mông lớn (Gluteus Maximus):</strong> Chịu trách nhiệm chính cho động tác duỗi hông.</li>
                <li><strong>Cơ gân kheo (Hamstrings):</strong> Kiểm soát tốc độ hạ tạ và hỗ trợ duỗi hông.</li>
                <li><strong>Cơ lưng dưới (Erector Spinae):</strong> Giữ ổn định cột sống.</li>
                <li><strong>Cơ lõi (Core Muscles):</strong> Ổn định thân người và kiểm soát chuyển động.</li>
            </ul>

            <h2>Lợi ích sức khỏe của Dumbbell RDL</h2>

            <ul>
                <li>Tăng cường sức mạnh và sức bền cơ mông – gân kheo.</li>
                <li>Cải thiện sự linh hoạt của hông và lưng dưới.</li>
                <li>Ngăn ngừa chấn thương khớp gối và hông.</li>
                <li>Cải thiện tư thế và giảm nguy cơ đau lưng.</li>
                <li>Phát triển cơ mông săn chắc và cân đối.</li>
            </ul>

            <div class="quote-box">
                “RDL đúng kỹ thuật không chỉ giúp bạn mạnh hơn – mà còn giúp bạn vận động tốt hơn trong cuộc sống hằng ngày.”
            </div>

            <h2>Bắt đầu tập Dumbbell RDL: Kỹ thuật chuẩn và tránh chấn thương</h2>

            <h3>Chuẩn bị</h3>
            <ul>
                <li>Chọn mức tạ phù hợp (ưu tiên nhẹ nếu mới tập).</li>
                <li>Khởi động kỹ khớp hông, gối và lưng dưới.</li>
                <li>Đảm bảo không gian tập an toàn.</li>
            </ul>

            <h3>Thực hiện bài tập</h3>
            <ul>
                <li>Đứng thẳng, hai chân rộng bằng vai.</li>
                <li>Giữ lưng thẳng suốt quá trình.</li>
                <li>Hạ người bằng cách đẩy hông ra sau.</li>
                <li>Giữ tạ sát chân.</li>
                <li>Dừng khi cảm nhận căng gân kheo.</li>
                <li>Dùng lực mông – gân kheo đẩy người lên.</li>
            </ul>

            <h3>Các lỗi thường gặp</h3>
            <ul>
                <li>Lưng cong quá mức.</li>
                <li>Khóa khớp gối.</li>
                <li>Dùng lực thân trên thay vì chân.</li>
                <li>Tạ quá nặng.</li>
            </ul>

            <h2>Nâng cao hiệu quả tập luyện RDL</h2>

            <h3>Biến thể cho người mới</h3>
            <ul>
                <li>Dumbbell RDL nhẹ</li>
                <li>Kettlebell RDL</li>
                <li>Barbell RDL nhẹ</li>
            </ul>

            <h3>Biến thể nâng cao</h3>
            <ul>
                <li>Single-leg RDL</li>
                <li>Deficit RDL</li>
                <li>Banded RDL</li>
            </ul>

            <h3>Điều chỉnh theo trình độ</h3>
            <ul>
                <li>Người mới: 2–3 hiệp, 8–12 reps</li>
                <li>Trung cấp: 3–4 hiệp, 8–12 reps</li>
                <li>Nâng cao: Tăng tạ, thêm biến thể một chân</li>
            </ul>

            <h2>Xây dựng chương trình tập Dumbbell RDL</h2>

            <h3>Tần suất</h3>
            <p>1–3 buổi mỗi tuần tùy trình độ.</p>

            <h3>Số hiệp</h3>
            <p>3–4 hiệp mỗi buổi tập.</p>

            <h3>Số lần lặp</h3>
            <p>6–12 reps tùy mục tiêu sức mạnh hay hypertrophy.</p>

            <h3>Ví dụ chương trình</h3>
            <ul>
                <li>Squats: 3x10</li>
                <li>Dumbbell RDL: 3x10-12</li>
                <li>Hip Thrusts: 3x12</li>
                <li>Lunges: 3x10 mỗi chân</li>
                <li>Planks: 3 hiệp 30–60 giây</li>
            </ul>

            <h2>So sánh Dumbbell RDL với các biến thể Deadlift khác</h2>

            <h3>So với Barbell Deadlift</h3>
            <p>Barbell cho phép nâng nặng hơn nhưng yêu cầu kỹ thuật cao hơn. Dumbbell RDL an toàn và ổn định hơn cho người mới.</p>

            <h3>So với Trap Bar Deadlift</h3>
            <p>Trap Bar giữ tư thế thẳng đứng hơn, giảm áp lực lưng. Dumbbell RDL tập trung nhiều hơn vào gân kheo.</p>

            <h3>So với Single-Leg RDL</h3>
            <p>Single-Leg cải thiện thăng bằng và sửa lệch cơ nhưng khó hơn.</p>

            <h3>Ưu điểm</h3>
            <ul>
                <li>Tác động mạnh vào mông – gân kheo</li>
                <li>Cải thiện ổn định</li>
                <li>Giảm áp lực lưng dưới</li>
                <li>Phù hợp người mới</li>
            </ul>

            <h3>Nhược điểm</h3>
            <ul>
                <li>Giới hạn mức tạ</li>
                <li>Khó tăng sức mạnh tuyệt đối so với barbell</li>
            </ul>

            <a href="<%=request.getContextPath()%>/news?blog.jsp" class="back-btn">← Quay lại Blog</a>

        </div>

        <div>

            <div class="sidebar-card">
                <div class="sidebar-title">MỤC LỤC BÀI VIẾT</div>
                <ul>
                    <li>Dumbbell RDL là gì?</li>
                    <li>Cơ chế hoạt động</li>
                    <li>Nhóm cơ tác động</li>
                    <li>Lợi ích sức khỏe</li>
                    <li>Kỹ thuật chuẩn</li>
                    <li>Biến thể & nâng cao</li>
                    <li>Chương trình tập luyện</li>
                    <li>So sánh với Deadlift khác</li>
                </ul>
            </div>
        </div>

    </div>
</div>
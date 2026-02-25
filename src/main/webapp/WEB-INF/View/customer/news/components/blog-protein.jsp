<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>

    body{
        background:#0f0f0f;
        color:#f5f5f5;
        font-family:'Segoe UI',sans-serif;
        margin:0;
    }

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
        background:url('https://images.unsplash.com/photo-1600891964599-f61ba0e24092') center/cover no-repeat;
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
        <span class="hero-badge">KIẾN THỨC DINH DƯỠNG</span>
        <h1 class="hero-title">
            Thực Phẩm Giàu <span>Protein</span> Cho Gym Top 10 Lựa Chọn Tuyệt Vời
        </h1>
        <p class="hero-desc">
            Tối ưu tăng cơ, phục hồi nhanh và nâng cao hiệu suất tập luyện.
        </p>
    </div>
</div>

<div class="blog-wrapper">
    <div class="layout">

        <div class="content">

            <h2>Protein Cần Thiết Cho Gym: Hiểu Rõ Vai Trò và Lợi Ích</h2>

            <p>Protein đóng vai trò nền tảng trong quá trình tập luyện thể hình. Nó không chỉ là nguồn cung cấp năng lượng mà còn là thành phần cấu tạo thiết yếu cho việc xây dựng và phục hồi cơ bắp. Hiểu rõ về vai trò và lợi ích của protein sẽ giúp người tập gym tối ưu hóa hiệu quả tập luyện và đạt được mục tiêu của mình.</p>

            <h3>Vai Trò Của Protein Trong Cơ Thể Người Tập Gym</h3>

            <p>Protein là một đa sinh tố, nghĩa là nó chứa tất cả các axit amin cần thiết cho cơ thể. Trong bối cảnh tập luyện, protein đảm nhận nhiều chức năng quan trọng:</p>

            <ul>
                <li><strong>Xây dựng và phục hồi cơ bắp:</strong> Khi tập luyện, các sợi cơ bị tổn thương. Protein cung cấp các axit amin cần thiết để sửa chữa những tổn thương này và xây dựng các sợi cơ mới, giúp cơ bắp phát triển.</li>
                <li><strong>Tạo ra hormone tăng trưởng:</strong> Một số axit amin trong protein tham gia vào quá trình sản xuất hormone tăng trưởng.</li>
                <li><strong>Hỗ trợ chức năng miễn dịch:</strong> Protein là thành phần của các tế bào miễn dịch.</li>
                <li><strong>Cung cấp năng lượng:</strong> Protein có thể được sử dụng để tạo năng lượng khi cần thiết.</li>
                <li><strong>Duy trì khối lượng cơ bắp:</strong> Giúp ngăn ngừa mất cơ khi giảm cân.</li>
            </ul>

            <h3>Lợi Ích Cụ Thể Của Việc Bổ Sung Protein</h3>

            <ul>
                <li>Tăng cường khả năng phục hồi sau tập luyện.</li>
                <li>Thúc đẩy sự phát triển cơ bắp.</li>
                <li>Hỗ trợ giảm cân hiệu quả.</li>
                <li>Cải thiện hiệu suất tập luyện.</li>
                <li>Tăng cường sức khỏe tổng thể.</li>
            </ul>

            <h2>Nguồn Protein Tuyệt Vời Cho Gym</h2>

            <p>Dưới đây là top 10 lựa chọn tuyệt vời:</p>

            <ul>
                <li>Ức gà</li>
                <li>Cá hồi</li>
                <li>Trứng</li>
                <li>Thịt bò nạc</li>
                <li>Đậu phụ</li>
                <li>Các loại đậu</li>
                <li>Hạnh nhân</li>
                <li>Sữa chua Hy Lạp</li>
                <li>Whey / Casein</li>
                <li>Hạt chia</li>
            </ul>

            <h2>Hướng Dẫn Tính Lượng Protein</h2>

            <ul>
                <li>Duy trì: 1.0 – 1.2g/kg</li>
                <li>Tăng cơ: 1.6 – 2.2g/kg</li>
                <li>Giảm mỡ: 1.6 – 2.2g/kg</li>
            </ul>

            <div class="quote-box">
                “Muốn cơ phát triển – hãy tối ưu protein trước khi nghĩ đến supplement.”
            </div>

            <h2>Tối Ưu Hóa Việc Tiêu Thụ Protein</h2>

            <ul>
                <li>Phân bổ đều trong ngày</li>
                <li>Bổ sung sau tập 30–60 phút</li>
                <li>Uống đủ nước</li>
                <li>Kết hợp carbohydrate</li>
                <li>Không lạm dụng supplement</li>
            </ul>

            <a href="<%=request.getContextPath()%>/news?blog.jsp" class="back-btn">← Quay lại Blog</a>

        </div>


        <div>

            <div class="sidebar-card">
                <div class="sidebar-title">MỤC LỤC BÀI VIẾT</div>
                <ul>
                    <li>Protein và vai trò</li>
                    <li>Lợi ích khi bổ sung</li>
                    <li>Top thực phẩm</li>
                    <li>Cách tính lượng protein</li>
                    <li>Tối ưu hóa tiêu thụ</li>
                </ul>
            </div>

        </div>

    </div>
</div>
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
        background:url('https://images.unsplash.com/photo-1546069901-ba9599a7e63c') center/cover no-repeat;
        filter:blur(2px) brightness(0.6);
        transform:scale(1.1);
    }

    .hero-overlay{
        position:absolute;
        inset:0;
        background:rgba(0,0,0,0.4);
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
    }

    .content p{
        color:#d0d0d0;
        margin-bottom:20px;
    }

    .content ul{
        margin:20px 0 30px 25px;
    }

    .content img{
        width:100%;
        border-radius:12px;
        margin:30px 0;
        transition:0.4s;
    }

    .content img:hover{
        transform:scale(1.02);
    }

    .quote-box{
        background:#161616;
        border-left:4px solid #f90606;
        padding:25px;
        margin:50px 0;
        font-style:italic;
        border-radius:8px;
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

    @media(max-width:992px){
        .layout{
            grid-template-columns:1fr;
        }
        .hero-title{
            font-size:32px;
        }
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
</style>


<!-- HERO -->
<div class="blog-hero">
    <div class="hero-bg"></div>
    <div class="hero-overlay"></div>
    <div class="hero-content">
        <span class="hero-badge">DINH DƯỠNG TĂNG CÂN</span>
        <h1 class="hero-title">
            Kế Hoạch Thực Đơn <span>3000 Calo</span> Cho Người Mới
        </h1>
        <p class="hero-desc">
            Hướng dẫn chi tiết từ nền tảng dinh dưỡng đến thực đơn mẫu 1 tuần giúp tăng cân sạch và hiệu quả.
        </p>
    </div>
</div>


<div class="blog-wrapper">
    <div class="layout">

        <div class="content">

            <h2>Nền Tảng Dinh Dưỡng Căn Bản Cho Chương Trình 3000 Calo</h2>
            <p>Để tăng cân hiệu quả, bạn không chỉ cần ăn nhiều mà cần ăn đúng. 3000 calo/ngày phải đi kèm với cân bằng protein – carb – fat hợp lý để tăng cơ thay vì tăng mỡ.</p>

            <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061">

            <h3>Nhu Cầu Calo & Macro</h3>
            <ul>
                <li>Protein: 1.6–2.2g/kg cân nặng</li>
                <li>Carb: 4–5g/kg cân nặng</li>
                <li>Fat: 0.8–1g/kg cân nặng</li>
            </ul>

            <div class="quote-box">
                "Tăng cân sạch là tăng cơ – không phải tăng mỡ."
            </div>

            <h2>Các Nhóm Thực Phẩm Nên Ưu Tiên</h2>
            <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836">

            <ul>
                <li>Protein: Thịt gà, bò, cá, trứng, sữa</li>
                <li>Carb: Gạo, khoai lang, yến mạch</li>
                <li>Fat tốt: Bơ, hạt, dầu oliu</li>
                <li>Rau xanh & trái cây</li>
            </ul>

            <h2>Ví Dụ Thực Đơn 1 Ngày 3000 Calo</h2>

            <ul>
                <li>Bữa sáng (700 calo): Trứng + bánh mì nguyên cám + sữa</li>
                <li>Bữa phụ (300 calo): Yến mạch + hạt</li>
                <li>Bữa trưa (900 calo): Thịt bò + cơm + rau</li>
                <li>Bữa phụ chiều (300 calo): Sữa chua + trái cây</li>
                <li>Bữa tối (800 calo): Cá hồi + khoai lang + salad</li>
            </ul>

            <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c">

            <h2>Kỹ Thuật Ăn Uống Hiệu Quả</h2>

            <ul>
                <li>Chia 5-6 bữa/ngày</li>
                <li>Ưu tiên protein mỗi bữa</li>
                <li>Uống 2-3L nước/ngày</li>
                <li>Ăn sau tập 30-60 phút</li>
            </ul>

            <h2>Theo Dõi & Điều Chỉnh</h2>
            <p>Theo dõi cân nặng mỗi tuần. Nếu không tăng sau 2 tuần, tăng thêm 200-300 calo/ngày.</p>

            <img src="https://images.unsplash.com/photo-1556911220-bff31c812dba">

            <a href="<%=request.getContextPath()%>/news?blog.jsp" class="back-btn">← Quay lại Blog</a>

        </div>


        <div>
            <div class="sidebar-card">
                <div class="sidebar-title">MỤC LỤC</div>
                <ul>
                    <li>Nền tảng 3000 calo</li>
                    <li>Macro & Khoáng chất</li>
                    <li>Nhóm thực phẩm</li>
                    <li>Thực đơn mẫu</li>
                    <li>Kỹ thuật ăn uống</li>
                    <li>Theo dõi & điều chỉnh</li>
                </ul>
            </div>
        </div>

    </div>
</div>
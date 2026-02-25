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
        background:url('https://images.unsplash.com/photo-1605296867304-46d5465a13f1') center/cover no-repeat;
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

    .content li{
        margin-bottom:10px;
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
            Whey <span>Protein</span>: Lựa Chọn Tốt, Giá Hời
        </h1>
        <p class="hero-desc">
            Hướng dẫn đầy đủ về thành phần, phân loại, giá cả và cách sử dụng whey protein hiệu quả tại Việt Nam.
        </p>
    </div>
</div>

<div class="blog-wrapper">
    <div class="layout">

        <div class="content">

            <h2>Whey Protein là gì?</h2>
            <p>Whey protein là một loại protein được chiết xuất từ sữa trong quá trình sản xuất phô mai. Đây là nguồn protein hoàn chỉnh vì chứa đầy đủ các axit amin thiết yếu.</p>

            <img src="https://images.unsplash.com/photo-1579758629938-03607ccdbaba">

            <h2>Thành phần & Công dụng</h2>
            <ul>
                <li>Xây dựng cơ bắp</li>
                <li>Phục hồi nhanh sau tập</li>
                <li>Kiểm soát cân nặng</li>
                <li>Bổ sung protein tiện lợi</li>
            </ul>

            <div class="quote-box">
                "Whey protein là lựa chọn dinh dưỡng thông minh cho người tập luyện và cả người bận rộn."
            </div>

            <h2>Các loại Whey Protein phổ biến</h2>

            <img src="https://images.unsplash.com/photo-1605296867424-35fc25c9212a">

            <h3>WPC</h3>
            <p>Giá rẻ, protein 70-80%, phù hợp người mới.</p>

            <h3>WPI</h3>
            <p>Protein trên 90%, ít lactose, hấp thụ nhanh.</p>

            <h3>WPH</h3>
            <p>Hấp thụ cực nhanh, phục hồi tối ưu.</p>

            <h2>So sánh giá Whey tại Việt Nam</h2>
            <ul>
                <li>Dưới 500.000đ/kg – Phân khúc phổ thông</li>
                <li>500.000 – 1.200.000đ/kg – Tầm trung</li>
                <li>Trên 1.200.000đ/kg – Cao cấp</li>
            </ul>

            <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438">

            <h2>Cách sử dụng hiệu quả</h2>
            <ul>
                <li>20-30g sau tập</li>
                <li>Uống buổi sáng nếu thiếu protein</li>
                <li>Kết hợp chế độ ăn cân bằng</li>
            </ul>

            <h2>Thương hiệu nổi bật</h2>
            <ul>
                <li>Optimum Nutrition</li>
                <li>Dymatize</li>
                <li>MuscleTech</li>
                <li>BSc</li>
                <li>Isopure</li>
            </ul>

            <a href="<%=request.getContextPath()%>/news?blog.jsp" class="back-btn">← Quay lại Blog</a>

        </div>


        <div>

            <div class="sidebar-card">
                <div class="sidebar-title">MỤC LỤC</div>
                <ul>
                    <li>Whey là gì?</li>
                    <li>Thành phần</li>
                    <li>Các loại whey</li>
                    <li>So sánh giá</li>
                    <li>Cách dùng</li>
                    <li>Thương hiệu</li>
                </ul>
            </div>

        </div>

    </div>
</div>
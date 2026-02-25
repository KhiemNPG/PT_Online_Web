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
    background:url('https://images.unsplash.com/photo-1523362628745-0c100150b504') center/cover no-repeat;
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
    <span class="hero-badge">SỨC KHỎE & LỐI SỐNG</span>
    <h1 class="hero-title">
      Uống Nước <span>Đủ Lượng</span>: Tại Sao Quan Trọng?
    </h1>
    <p class="hero-desc">
      Hiểu rõ vai trò của nước và cách tối ưu hóa lượng nước uống mỗi ngày để cải thiện sức khỏe toàn diện.
    </p>
  </div>
</div>

<div class="blog-wrapper">
  <div class="layout">

    <div class="content">

      <h2>Nền Tảng Về Chức Năng: Tại Sao Nước Lại Quan Trọng?</h2>

      <p>Nước là yếu tố nền tảng của mọi chức năng sinh học trong cơ thể. Từ vận chuyển chất dinh dưỡng, điều hòa nhiệt độ đến đào thải độc tố – tất cả đều phụ thuộc vào nước.</p>

      <img src="https://images.unsplash.com/photo-1524594154908-eddc3b3b7e1f">

      <h3>Thành Phần Cơ Bản Của Cơ Thể</h3>
      <p>Cơ thể người chứa khoảng 55–78% là nước. Mọi quá trình trao đổi chất đều diễn ra trong môi trường có nước.</p>

      <h3>Chức Năng Sinh Học Quan Trọng</h3>
      <ul>
        <li>Điều hòa nhiệt độ</li>
        <li>Vận chuyển oxy và dưỡng chất</li>
        <li>Hỗ trợ tiêu hóa</li>
        <li>Đào thải chất thải qua thận</li>
        <li>Bôi trơn khớp</li>
        <li>Bảo vệ cơ quan nội tạng</li>
      </ul>

      <div class="quote-box">
        “Chỉ mất 2% nước cơ thể cũng có thể làm giảm hiệu suất nhận thức và thể chất.”
      </div>

      <h2>Dấu Hiệu Thiếu Hụt Nước</h2>
      <ul>
        <li>Khát nước</li>
        <li>Nước tiểu sẫm màu</li>
        <li>Đau đầu</li>
        <li>Chóng mặt</li>
        <li>Mệt mỏi</li>
        <li>Da khô</li>
      </ul>

      <img src="https://images.unsplash.com/photo-1502741338009-cac2772e18bc">

      <h2>Lượng Nước Cần Thiết Hàng Ngày</h2>
      <p>Người trưởng thành nên uống khoảng 2–3 lít nước/ngày. Người vận động nhiều hoặc sống ở khí hậu nóng cần nhiều hơn.</p>

      <h2>Cơ Chế Hoạt Động: Nước Tham Gia Sinh Lý</h2>
      <p>Nước hoạt động như dung môi cho các phản ứng hóa học, duy trì thể tích máu và hỗ trợ hệ tuần hoàn hoạt động hiệu quả.</p>

      <h2>Lợi Ích Bất Ngờ Của Việc Uống Đủ Nước</h2>
      <ul>
        <li>Cải thiện trí nhớ & tập trung</li>
        <li>Giảm nguy cơ sỏi thận</li>
        <li>Hỗ trợ tim mạch</li>
        <li>Làm đẹp da</li>
        <li>Tăng hiệu suất tập luyện</li>
      </ul>

      <img src="https://images.unsplash.com/photo-1498837167922-ddd27525d352">

      <h2>Ứng Dụng Thực Tế: Tối Ưu Hóa Lượng Nước</h2>
      <ul>
        <li>Uống nước ngay sau khi thức dậy</li>
        <li>Chia nhỏ lượng nước trong ngày</li>
        <li>Mang theo bình nước</li>
        <li>Ăn thực phẩm giàu nước (dưa hấu, dưa leo)</li>
        <li>Theo dõi màu nước tiểu</li>
      </ul>

      <h2>Những Sai Lầm Thường Gặp</h2>
      <ul>
        <li>Đợi khát mới uống</li>
        <li>Uống quá nhanh</li>
        <li>Chỉ uống 1 lần nhiều nước</li>
        <li>Lạm dụng nước ngọt & caffeine</li>
      </ul>

      <h2>Mẹo Uống Nước Thông Minh</h2>
      <ul>
        <li>Đặt nhắc nhở mỗi 1 giờ</li>
        <li>Uống 1 ly trước mỗi bữa ăn</li>
        <li>Kết hợp trà thảo mộc</li>
        <li>Bổ sung nước khi tập luyện</li>
        <li>Lắng nghe cơ thể</li>
      </ul>

      <a href="<%=request.getContextPath()%>/news?blog.jsp" class="back-btn">← Quay lại Blog</a>

    </div>

    <div>
      <div class="sidebar-card">
        <div class="sidebar-title">MỤC LỤC BÀI VIẾT</div>
        <ul>
          <li>Vai trò của nước</li>
          <li>Dấu hiệu thiếu nước</li>
          <li>Lượng nước cần uống</li>
          <li>Lợi ích sức khỏe</li>
          <li>Sai lầm khi uống nước</li>
          <li>Mẹo tối ưu hóa</li>
        </ul>
      </div>
    </div>

  </div>
</div>
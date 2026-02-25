<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .knowledge-page {
        padding: 60px 0;
    }

    .knowledge-container {
        width: 100%;
        max-width: 1200px; /* đổi thành đúng max-width header bạn đang dùng nếu cần */
        margin: 0 auto;
        padding: 0 20px;
    }

    /* HERO */
    .kp-hero {
        display: flex;
        flex-wrap: wrap;
        border-radius: 20px;
        overflow: hidden;
        margin-bottom: 60px;
        background: #1a1313;
    }

    .kp-hero-image {
        flex: 1 1 60%;
        min-height: 450px;
    }

    .kp-hero-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .kp-hero-content {
        flex: 1 1 40%;
        padding: 50px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        color: #fff;
    }

    .kp-badge {
        background: #f90606;
        color: #fff;
        padding: 6px 16px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 20px;

        display: inline-flex;   /* quan trọng */
        align-items: center;
        width: fit-content;     /* quan trọng */
    }

    .kp-hero-content h2 {
        font-size: 30px;
        margin-bottom: 20px;
    }

    .kp-hero-content p {
        color: #bdbdbd;
        margin-bottom: 25px;
    }

    .kp-hero-content button {
        background: #f90606;
        border: none;
        padding: 14px 26px;
        border-radius: 12px;
        font-weight: 700;
        cursor: pointer;
    }

    /* SEARCH */
    .kp-search-block {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 50px;
    }

    .kp-search-input {
        flex: 0 0 420px;     /* chiều rộng cố định */
        padding: 14px 18px;
        border-radius: 12px;
        border: none;
        background: #1a1313;
        color: #fff;
    }

    .kp-category-list {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;     /* nếu màn nhỏ sẽ tự xuống dòng */
    }

    .kp-category-list button {
        padding: 8px 18px;
        border-radius: 30px;
        border: none;
        background: #1a1313;
        color: #aaa;
        cursor: pointer;
        white-space: nowrap;
    }

    .kp-category-list button.active,
    .kp-category-list button:hover {
        background: #f90606;
        color: #fff;
    }

    /* GRID */
    .kp-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 30px;
    }

    .kp-card {
        background: #1a1313;
        border-radius: 18px;
        overflow: hidden;
        transition: 0.3s;
    }

    .kp-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 0 20px rgba(249,6,6,0.25);
    }

    .kp-card-image {
        height: 220px;
    }

    .kp-card-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .kp-card-body {
        padding: 25px;
        color: #fff;
    }

    .kp-card-body h3 {
        margin-bottom: 12px;
    }

    .kp-card-body p {
        color: #aaa;
        font-size: 14px;
        margin-bottom: 15px;
    }

    .kp-read-more {
        color: #f90606;
        font-weight: 700;
        font-size: 13px;
    }

    /* Responsive */
    @media (max-width: 992px) {
        .kp-hero {
            flex-direction: column;
        }

        .kp-hero-content {
            padding: 35px;
        }
    }
    .kp-card-link {
        text-decoration: none;
        color: inherit;
        display: block;
    }

    .kp-card-link:hover .kp-card {
        transform: translateY(-5px);
    }
    @media (max-width: 992px) {
        .kp-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 600px) {
        .kp-grid {
            grid-template-columns: 1fr;
        }
    }
</style>
<%
    String detail = request.getParameter("detail");
%>

<%-- ================= DETAIL SECTION ================= --%>
<% if ("eatclean".equals(detail)) { %>

<jsp:include page="blog-eat-clean.jsp" />

<% } else if ("rdl".equals(detail)) { %>

<jsp:include page="/WEB-INF/View/customer/news/components/blog-rdl.jsp" />

<% } else if ("protein".equals(detail)) { %>

<jsp:include page="/WEB-INF/View/customer/news/components/blog-protein.jsp" />

<% } else if ("whey".equals(detail)) { %>

<jsp:include page="/WEB-INF/View/customer/news/components/blog-whey.jsp" />

<% } else if ("water".equals(detail)) { %>

<jsp:include page="/WEB-INF/View/customer/news/components/blog-water.jsp" />

<% } else { %>

<section class="knowledge-page">

    <div class="knowledge-container">

        <!-- HERO NỔI BẬT -->
        <div class="kp-hero">
            <div class="kp-hero-image">
                <img src="https://images.unsplash.com/photo-1579722820308-d74e571900a9" alt="">
            </div>

            <div class="kp-hero-content">
                <span class="kp-badge">BÀI VIẾT NỔI BẬT</span>
                <h2>Whey Protein: Lựa Chọn Tốt, Giá Hời</h2>
                <p>Tìm Hiểu Cơ Bản Về Whey Protein: Thành Phần, Công Dụng & Loại Hình.</p>

                <a href="<%=request.getContextPath()%>/news?detail=whey">
                    <button>ĐỌC NGAY</button>
                </a>
            </div>
        </div>

        <!-- SEARCH + CATEGORY -->
        <div class="kp-search-block">
            <input type="text" id="searchInput"
                   placeholder="Tìm kiếm bài viết kiến thức..."
                   class="kp-search-input">

            <div class="kp-category-list">
                <button class="active" data-category="all">Tất cả</button>
                <button data-category="nutrition">Dinh dưỡng</button>
                <button data-category="training">Kỹ thuật tập</button>
                <button data-category="lifestyle">Lối sống</button>
                <button data-category="review">Review Thực Phẩm</button>
            </div>
        </div>

        <!-- GRID -->
        <div class="kp-grid" id="blogGrid">

            <!-- WHEY -->
            <a href="<%=request.getContextPath()%>/news?detail=whey"
               class="kp-card-link"
               data-title="whey protein review"
               data-category="review">

                <div class="kp-card">
                    <div class="kp-card-image">
                        <img src="https://images.unsplash.com/photo-1579722820308-d74e571900a9" alt="">
                    </div>
                    <div class="kp-card-body">
                        <h3>Whey Protein: Lựa Chọn Tốt, Giá Hời</h3>
                        <p>Tìm Hiểu Cơ Bản Về Whey Protein: Thành Phần, Công Dụng & Loại Hình</p>
                        <span class="kp-read-more">XEM TIẾP</span>
                    </div>
                </div>
            </a>

            <!-- DEADLIFT -->
            <a href="<%=request.getContextPath()%>/news?detail=rdl"
               class="kp-card-link"
               data-title="dDumbbell RDL: huong dan"
               data-category="training">

                <div class="kp-card">
                    <div class="kp-card-image">
                        <img src="https://images.unsplash.com/photo-1583454110551-21f2fa2afe61" alt="">
                    </div>
                    <div class="kp-card-body">
                        <h3>Dumbbell RDL: Kỹ Thuật & Lợi Ích</h3>
                        <p>Dumbbell RDL: Tập Đúng Kỹ Thuật, Khỏe Lưng Săn Mông</p>
                        <span class="kp-read-more">XEM TIẾP</span>
                    </div>
                </div>
            </a>

            <!-- EAT CLEAN -->
            <a href="<%=request.getContextPath()%>/news?detail=eatclean"
               class="kp-card-link"
               data-title="eat clean bulking dinh dưỡng"
               data-category="nutrition">

                <div class="kp-card">
                    <div class="kp-card-image">
                        <img src="https://images.unsplash.com/photo-1546069901-ba9599a7e63c" alt="">
                    </div>
                    <div class="kp-card-body">
                        <h3>
                            Thực Đơn 3000 Calo Cho Người Mới</h3>
                        <p>Lộ trình tăng cân khoa học: Từ nền tảng dinh dưỡng đến thực đơn 1 tuần</p>
                        <span class="kp-read-more">XEM TIẾP</span>
                    </div>
                </div>
            </a>

            <!-- PROTEIN -->
            <a href="<%=request.getContextPath()%>/news?detail=protein"
               class="kp-card-link"
               data-title="protein thực phẩm gym"
               data-category="nutrition">

                <div class="kp-card">
                    <div class="kp-card-image">
                        <img src="https://images.unsplash.com/photo-1600891964599-f61ba0e24092" alt="">
                    </div>
                    <div class="kp-card-body">
                        <h3>Thực phẩm giàu Protein cho Gym</h3>
                        <p>Top 10 nguồn protein giúp tăng cơ nhanh và phục hồi tốt.</p>
                        <span class="kp-read-more">XEM TIẾP</span>
                    </div>
                </div>
            </a>
            <!-- WATER -->
            <a href="<%=request.getContextPath()%>/news?detail=water"
               class="kp-card-link"
               data-title="water loi ich"
               data-category="lifestyle">

                <div class="kp-card">
                    <div class="kp-card-image">
                        <img src="https://images.unsplash.com/photo-1523362628745-0c100150b504" alt="">
                    </div>
                    <div class="kp-card-body">
                        <h3>Uống Nước Đủ Lượng: Tại Sao Quan Trọng?</h3>
                        <p>Nước và sức khỏe: Cách uống nước đúng để tối ưu hiệu suất tập luyện.</p>
                        <span class="kp-read-more">XEM TIẾP</span>
                    </div>
                </div>
            </a>

        </div>
    </div>

</section>
<% } %>
<script>
    const searchInput = document.getElementById("searchInput");
    const cards = document.querySelectorAll(".kp-card-link");
    const categoryButtons = document.querySelectorAll(".kp-category-list button");

    let currentCategory = "all";

    searchInput.addEventListener("input", filterBlogs);

    categoryButtons.forEach(btn => {
        btn.addEventListener("click", function () {

            categoryButtons.forEach(b => b.classList.remove("active"));
            this.classList.add("active");

            currentCategory = this.dataset.category;
            filterBlogs();
        });
    });

    function filterBlogs() {
        const keyword = searchInput.value.toLowerCase();

        cards.forEach(card => {
            const title = card.dataset.title;
            const category = card.dataset.category;

            const matchKeyword = title.includes(keyword);
            const matchCategory = currentCategory === "all" || category === currentCategory;

            card.style.display = (matchKeyword && matchCategory) ? "block" : "none";
        });
    }
</script>
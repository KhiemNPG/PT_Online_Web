<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@page import="java.util.List"%>
<%@page import="model.entity.PersonalTrainer"%>
<%
    int totalPT = 0, activePT = 0;
    double aveEx = 0;
    List< PersonalTrainer> personalTrainerList = (List< PersonalTrainer>) request.getAttribute("personalTrainerList");
    if (personalTrainerList != null && !personalTrainerList.isEmpty() ){
        totalPT = personalTrainerList.size();
        for (PersonalTrainer p : personalTrainerList){
            if ( p.isActive() == true){
                activePT++;
            }
            if (p.getExperienceYears() != null) {
                aveEx += p.getExperienceYears();
            }
        }
        if (totalPT > 0) {
            aveEx = aveEx / totalPT;
        }
    }

    String aveExFormatted = "";
    if (aveEx > 0) {
    if (aveEx == Math.floor(aveEx)) {
        aveExFormatted = String.format("%d", (int) aveEx);
    } else {
        aveExFormatted = String.format("%.1f", aveEx);
        }
    } else {
        aveExFormatted = "0";
    }
%>

<style>
    /* Hệ thống màu sắc tùy chỉnh đồng bộ 100% theo đúng UI mẫu của trang Học viên */
    :root {
        --bg-main: #0b0f19;              /* Nền tối sâu */
        --bg-surface: #111622;           /* Nền thẻ widget */
        --text-muted: #64748b;           /* Chữ phụ, caption */
        --color-primary: #10b981;        /* Xanh ngọc chủ đạo */
        --color-tech-blue: #38bdf8;      /* Xanh công nghệ */
    }

    body {
        background-color: var(--bg-main);
        color: #f8fafc;
    }

    /* Bo góc và đổ bóng mượt mà cho Bento Box */
    .bento-card {
        background-color: var(--bg-surface);
        border: 1px solid rgba(100, 116, 139, 0.15);
        border-radius: 1rem;
        padding: 1.25rem;
    }

    /* Gradient đặc biệt cho các thẻ mục tiêu phát triển bên phải */
    .bento-gradient {
        background: linear-gradient(135deg, rgba(56, 189, 248, 0.08) 0%, #111622 100%);
        border: 1px solid rgba(56, 189, 248, 0.15);
    }

    .text-muted-custom {
        color: var(--text-muted);
    }

    /* Tinh chỉnh thanh tìm kiếm bo tròn chuẩn UI */
    .search-input-custom {
        background-color: #171e2e !important;
        border: 1px solid rgba(100, 116, 139, 0.2) !important;
        color: #ffffff !important;
        border-radius: 50px !important;
        padding-left: 2.75rem !important;
    }
    .search-input-custom::placeholder {
        color: rgba(100, 116, 139, 0.6);
    }

    /* Tinh chỉnh Dropdown bộ lọc và nút Thêm mới */
    .filter-select {
        background-color: #171e2e;
        border: 1px solid rgba(100, 116, 139, 0.2);
        color: #f8fafc;
        border-radius: 0.75rem;
    }
    .btn-add-custom {
        background-color: #38bdf8;
        color: #0b0f19;
        font-weight: 700;
        border-radius: 0.75rem;
        border: none;
        transition: all 0.2s ease;
    }
    .btn-add-custom:hover {
        background-color: #0ea5e9;
        color: #ffffff;
    }

    /* Vòng tròn tiến độ bằng SVG thuần */
    .progress-ring-circle {
        transition: stroke-dashoffset 0.35s;
        transform: rotate(-90deg);
        transform-origin: 50% 50%;
    }
</style>

<div class="container-fluid p-4" style="padding: 0!important">

    <header class="d-flex justify-content-between align-items-center w-100 pb-4 mb-3 border-bottom border-secondary border-opacity-10" style="backdrop-blur: md;">
        <div class="position-relative w-100" style="max-width: 500px;">
            <span class="material-symbols-outlined position-absolute top-50 translate-middle-y text-muted-custom" style="left: 1rem;">search</span>
            <input class="form-control search-input-custom py-2" placeholder="Tìm kiếm huấn luyện viên, học viên..." type="text"/>
        </div>

        <div class="d-flex align-items-center gap-3">
            <button class="btn btn-link position-relative text-muted-custom p-2">
                <span class="material-symbols-outlined">notifications</span>
                <span class="position-absolute bg-danger rounded-circle border border-dark" style="width: 8px; height: 8px; top: 10px; right: 12px;"></span>
            </button>
            <button class="btn btn-link text-muted-custom p-2">
                <span class="material-symbols-outlined">mail</span>
            </button>
            <div class="bg-secondary bg-opacity-25" style="width: 1px; height: 24px; margin: 0 8px;"></div>

            <div class="d-flex align-items-center gap-3">
                <div class="text-end d-none d-lg-block">
                    <p class="mb-0 fw-bold text-white small" style="line-height: 1;">Admin Profile</p>
                    <p class="mb-0 text-muted-custom" style="font-size: 10px;">SUPER ADMIN</p>
                </div>
                <img alt="Admin Avatar" class="rounded-circle border border-2 border-info object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuB90JPBkZ0LCipzTaJVK3FAbZgsPVq21pqaeIYDonCuaJTumyencFmIVqnlEq-LI1HOlGYYgPHeD3ZmUVmT2keHKWuDYwHViKK8T4-55zUi0jYCiEgmFK7C8Qh6IsGaRHfOfAeI0bgLKp6HBdTrbX8SkkIUSOLW0JNr8yr_ZP22JG9jyz_-cDulp-9grLRGulKeQbsWyEgL4JkZgx2SLJ0NiGWtgPiM6fyzF1XKb69FmXTi5zo_3K0nKoLmPNLQyQBYxPU_P9U9q7Q" style="width: 40px; height: 40px;"/>
            </div>
        </div>
    </header>

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
            <h2 class="h3 mb-1 fw-bold text-white">Quản lý Huấn luyện viên</h2>
            <p class="text-muted-custom mb-0" style = "color: #64748B!important">Danh sách và hiệu suất của tất cả PT trên hệ thống</p>
        </div>
        <div class="d-flex align-items-center gap-3">
            <div class="position-relative">
                <select class="form-select filter-select pe-5 py-2.5">
                    <option>Tất cả chức danh</option>
                    <option>Master Coach</option>
                    <option>Senior PT</option>
                    <option>Junior PT</option>
                </select>
            </div>
            <button type="button" id="btnOpenAddPT" class="btn btn-add-custom px-4 py-2.5 d-flex align-items-center gap-2">
                <span class="material-symbols-outlined fs-5">add</span>
                <span>Thêm mới</span>
            </button>
        </div>
    </div>

    <div class="row g-3">

        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card d-flex flex-column justify-content-between h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted-custom text-uppercase small fw-bold" style="letter-spacing: 0.05em;">Tổng số PT</span>
                    <span class="text-success small fw-bold" style="font-size: 11px;">+4 THÁNG NÀY</span>
                </div>
                <div class="mt-4">
                    <h3 class="display-6 fw-bold mb-1" style="color: var(--color-tech-blue);"><%= totalPT%></h3>
                    <p class="text-muted-custom small mb-0">
                        <span class="text-success fw-bold"><%= activePT%></span> Đang hoạt động
                    </p>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-6 col-lg-3">
            <div class="bento-card d-flex flex-column justify-content-between h-100">
                <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted-custom text-uppercase small fw-bold" style="letter-spacing: 0.05em;">Kinh nghiệm</span>
                    <span class="text-muted-custom small" style="font-size: 11px;">Trung bình</span>
                </div>
                <div class="mt-4">
                    <h3 class="display-6 fw-bold text-white mb-1"><%= aveExFormatted%> <span class="fs-5 fw-normal text-muted-custom">Năm</span></h3>
                    <div class="progress mt-2" style="height: 5px; background-color: #1f293d;">
                        <%
                        // Tính phần trăm dựa trên mốc tối đa là 10 năm
                        double percentEx = (aveEx / 10.0) * 100;
                        if (percentEx > 100) percentEx = 100; // Bảo vệ nếu số năm vượt quá 10 thì vẫn đầy thanh chứ không tràn
                        %>
                        <div class="progress-bar bg-warning" role="progressbar" style="width: <%= percentEx %>%;"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-lg-6">
            <div class="bento-card bento-gradient h-100 position-relative overflow-hidden">
                <div class="d-flex justify-content-between align-items-center h-100 position-relative" style="z-index: 2;">
                    <div>
                        <h4 class="text-white fw-bold h5 mb-1">Tỷ lệ PT hoàn thành</h4>
                        <p class="text-muted-custom small mb-0" style="max-width: 240px;">
                            Tỷ lệ hoàn thành công việc và tương tác học viên với học viên hiện tại.
                        </p>
                        <a href="#" class="btn btn-link text-info p-0 mt-3 d-flex align-items-center gap-1 small fw-bold text-decoration-none" style="color: var(--color-tech-blue) !important;">
                            Xem báo cáo chi tiết
                            <span class="material-symbols-outlined" style="font-size: 14px;">arrow_forward</span>
                        </a>
                    </div>

                    <div class="position-relative d-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                        <svg width="100" height="100" class="position-absolute">
                            <circle class="text-secondary text-opacity-10" stroke="currentColor" stroke-width="8" fill="transparent" r="40" cx="50" cy="50"/>
                            <circle class="progress-ring-circle" stroke="#10b981" stroke-width="8" fill="transparent" r="40" cx="50" cy="50"
                                    stroke-dasharray="251.2"
                                    stroke-dashoffset="0"/>
                        </svg>
                        <span class="fw-bold text-white" style="font-size: 18px;">100%</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- 2. Cấu trúc Popup Modal -->
<div id="addPTModal" class="custom-modal-overlay">
    <div class="custom-modal-content">
        <!-- Header -->
        <div class="custom-modal-header">
            <h5 class="text-white fw-bold m-0">
                <span class="material-symbols-outlined align-middle me-2">fitness_center</span>
                Thêm Huấn Luyện Viên Mới
            </h5>
            <button type="button" class="btn-close-custom" id="btnCloseModal">&times;</button>
        </div>

        <!-- Body chứa Form -->
        <div class="custom-modal-body">
            <form id="formAddPT" action="${pageContext.request.contextPath}/admin/personal-trainer?action=add" method="POST">

                <!-- Section 1: Thông tin cơ bản -->
                <div class="mb-4">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">person</span>
                        Thông tin cơ bản
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control bg-dark-input text-white"
                                   name="ptName" required placeholder="Trần Quan Huy">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Chức danh (Title)</label>
                            <input type="text" class="form-control bg-dark-input text-white"
                                   name="title" value="MASTER TRAINER" placeholder="MASTER TRAINER">
                            <small class="text-white-50" style="font-size: 11px;">Nhãn hiển thị dưới ảnh đại diện</small>
                        </div>
                        <div class="col-12">
                            <label class="form-label text-white-50 small fw-bold">Slogan</label>
                            <input type="text" class="form-control bg-dark-input text-white"
                                   name="slogan" placeholder="Khai phá sức mạnh tiềm ẩn trong bạn.">
                        </div>
                    </div>
                </div>

                <!-- Section 2: Kinh nghiệm & Thành tích -->
                <div class="mb-4">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">military_tech</span>
                        Kinh nghiệm & Thành tích
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Năm kinh nghiệm</label>
                            <input type="number" class="form-control bg-dark-input text-white"
                                   name="experienceYears" min="0" max="50" placeholder="4">
                            <small class="text-white-50" style="font-size: 11px;">Hiển thị: "4+ NĂM KINH NGHIỆM"</small>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Học viên thành công</label>
                            <input type="number" class="form-control bg-dark-input text-white"
                                   name="successfulStudents" min="0" placeholder="20">
                            <small class="text-white-50" style="font-size: 11px;">Hiển thị: "20+ HỌC VIÊN THÀNH CÔNG"</small>
                        </div>
                        <div class="col-12">
                            <label class="form-label text-white-50 small fw-bold">Tags (phân cách bằng dấu phẩy)</label>
                            <input type="text" class="form-control bg-dark-input text-white"
                                   name="tags" placeholder="Giảm cân, Tăng cơ, Yoga, HIIT">
                            <small class="text-white-50" style="font-size: 11px;">Dùng để lọc và hiển thị chuyên môn</small>
                        </div>
                    </div>
                </div>

                <!-- Section 3: Tiểu sử -->
                <div class="mb-4">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">description</span>
                        Tiểu sử
                    </h6>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label text-white-50 small fw-bold">Bio (Mô tả chi tiết)</label>
                            <textarea class="form-control bg-dark-input text-white"
                                      name="bio" rows="4"
                                      placeholder="Với hơn 4 năm tâm huyết trong lĩnh vực fitness..."></textarea>
                            <small class="text-white-50" style="font-size: 11px;">Tối đa 1000 ký tự</small>
                        </div>
                    </div>
                </div>

                <!-- Section 4: Ảnh đại diện -->
                <div class="mb-4">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">image</span>
                        Ảnh đại diện
                    </h6>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label text-white-50 small fw-bold">URL ảnh đại diện</label>
                            <input type="url" class="form-control bg-dark-input text-white"
                                   name="avatarUrl" placeholder="https://example.com/avatar.jpg">
                        </div>
                        <div class="col-12">
                            <label class="form-label text-white-50 small fw-bold">Hoặc upload file ảnh</label>
                            <input type="file" class="form-control bg-dark-input text-white"
                                   name="avatarFile" accept="image/*">
                            <small class="text-white-50" style="font-size: 11px;">Hỗ trợ: JPG, PNG, WEBP (Tối đa 5MB)</small>
                        </div>
                    </div>
                </div>

                <!-- Section 5: Thông tin liên hệ -->
                <div class="mb-4">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">contact_phone</span>
                        Thông tin liên hệ
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Số điện thoại / Zalo <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control bg-dark-input text-white"
                                   name="phoneZalo" required placeholder="0901234567">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control bg-dark-input text-white"
                                   name="email" required placeholder="pt@example.com">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">
                                <span class="material-symbols-outlined align-middle" style="font-size: 14px;">facebook</span>
                                Facebook URL
                            </label>
                            <input type="url" class="form-control bg-dark-input text-white"
                                   name="facebookUrl" placeholder="https://facebook.com/...">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">
                                <span class="material-symbols-outlined align-middle" style="font-size: 14px;">instagram</span>
                                Instagram URL
                            </label>
                            <input type="url" class="form-control bg-dark-input text-white"
                                   name="instagramUrl" placeholder="https://instagram.com/...">
                        </div>
                    </div>
                </div>

                <!-- Section 6: Trạng thái -->
                <div class="mb-2">
                    <h6 class="text-info fw-bold mb-3 border-bottom border-secondary border-opacity-25 pb-2">
                        <span class="material-symbols-outlined align-middle" style="font-size: 18px;">toggle_on</span>
                        Trạng thái
                    </h6>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Trạng thái hoạt động</label>
                            <select class="form-select bg-dark-input text-white" name="isActive">
                                <option value="1" selected>Đang hoạt động</option>
                                <option value="0">Tạm ngưng</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-white-50 small fw-bold">Account ID (nếu có)</label>
                            <input type="number" class="form-control bg-dark-input text-white"
                                   name="accountId" placeholder="Để trống nếu chưa có">
                            <small class="text-white-50" style="font-size: 11px;">Liên kết với tài khoản hệ thống</small>
                        </div>
                    </div>
                </div>

            </form>
        </div>

        <!-- Footer -->
        <div class="custom-modal-footer">
            <button type="button" class="btn btn-secondary px-4" id="btnCancelModal">
                <span class="material-symbols-outlined align-middle" style="font-size: 16px;">close</span>
                Hủy
            </button>
            <button type="submit" form="formAddPT" class="btn btn-success px-4">
                <span class="material-symbols-outlined align-middle" style="font-size: 16px;">check</span>
                Thêm PT
            </button>
        </div>
    </div>
</div>

<!-- CSS cho Modal -->
<style>
    /* Overlay che mờ nền */
    .custom-modal-overlay {
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.75);
        backdrop-filter: blur(4px);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .custom-modal-overlay.show {
        display: flex;
        opacity: 1;
    }

    /* Khung Modal */
    .custom-modal-content {
        background-color: #111622;
        border: 1px solid rgba(100, 116, 139, 0.2);
        border-radius: 12px;
        width: 90%;
        max-width: 800px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5);
        transform: translateY(-20px);
        transition: transform 0.3s ease;
    }

    .custom-modal-overlay.show .custom-modal-content {
        transform: translateY(0);
    }

    /* Header */
    .custom-modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1.25rem 1.5rem;
        border-bottom: 1px solid rgba(100, 116, 139, 0.2);
        background-color: rgba(23, 30, 46, 0.5);
        border-radius: 12px 12px 0 0;
        position: sticky;
        top: 0;
        z-index: 10;
    }

    .btn-close-custom {
        background: none; border: none;
        color: #94a3b8; font-size: 28px;
        cursor: pointer; line-height: 1;
        transition: color 0.2s;
    }
    .btn-close-custom:hover { color: #f8fafc; }

    /* Body & Footer */
    .custom-modal-body { padding: 1.5rem; }
    .custom-modal-footer {
        display: flex; justify-content: flex-end; gap: 12px;
        padding: 1.25rem 1.5rem;
        border-top: 1px solid rgba(100, 116, 139, 0.2);
        background-color: rgba(23, 30, 46, 0.3);
        border-radius: 0 0 12px 12px;
        position: sticky;
        bottom: 0;
    }

    /* Input Dark Theme */
    .bg-dark-input {
        background-color: #171e2e !important;
        border-color: rgba(100, 116, 139, 0.3) !important;
        color: #f8fafc !important;
    }
    .bg-dark-input:focus {
        background-color: #1e293b !important;
        border-color: #38bdf8 !important;
        box-shadow: 0 0 0 0.2rem rgba(56, 189, 248, 0.25) !important;
        color: #f8fafc !important;
    }
    .bg-dark-input::placeholder {
        color: #64748b !important;
    }

    /* Form label */
    .form-label {
        margin-bottom: 0.4rem;
    }

    /* Nút submit */
    .btn-success {
        background-color: #10b981 !important;
        border-color: #10b981 !important;
        color: white !important;
    }
    .btn-success:hover {
        background-color: #059669 !important;
        border-color: #059669 !important;
    }

    /* Scrollbar custom */
    .custom-modal-content::-webkit-scrollbar {
        width: 8px;
    }
    .custom-modal-content::-webkit-scrollbar-track {
        background: #0f172a;
    }
    .custom-modal-content::-webkit-scrollbar-thumb {
        background: #334155;
        border-radius: 4px;
    }
    .custom-modal-content::-webkit-scrollbar-thumb:hover {
        background: #475569;
    }
</style>

<%-- Thông báo kết quả --%>
<%
String msg = request.getParameter("msg");
String error = request.getParameter("error");
%>

<% if ("added".equals(msg)) { %>
<div class="alert alert-success alert-dismissible fade show" role="alert"
     style="background-color: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); color: #10b981; border-radius: 12px; margin-bottom: 1.5rem;">
    <div class="d-flex align-items-center gap-2">
        <span class="material-symbols-outlined">check_circle</span>
        <strong>Thêm huấn luyện viên thành công!</strong>
    </div>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } else if (error != null) { %>
<div class="alert alert-danger alert-dismissible fade show" role="alert"
     style="background-color: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #ef4444; border-radius: 12px; margin-bottom: 1.5rem;">
    <div class="d-flex align-items-center gap-2">
        <span class="material-symbols-outlined">error</span>
        <strong>
            <%
            String errorMsg = "Có lỗi xảy ra!";
            switch (error) {
            case "name_required": errorMsg = "Vui lòng nhập họ tên!"; break;
            case "phone_required": errorMsg = "Vui lòng nhập số điện thoại!"; break;
            case "email_required": errorMsg = "Vui lòng nhập email!"; break;
            case "add_failed": errorMsg = "Thêm thất bại, vui lòng thử lại!"; break;
            case "server_error": errorMsg = "Lỗi server!"; break;
            }
            %>
            <%= errorMsg %>
        </strong>
    </div>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>

<!-- JavaScript điều khiển Modal -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const btnOpen = document.getElementById('btnOpenAddPT');
        const modal = document.getElementById('addPTModal');
        const btnClose = document.getElementById('btnCloseModal');
        const btnCancel = document.getElementById('btnCancelModal');
        const form = document.getElementById('formAddPT');

        function openModal() {
            modal.style.display = 'flex';
            setTimeout(() => {
                modal.classList.add('show');
            }, 10);
            document.body.style.overflow = 'hidden';
            form.reset();
            // Reset title về giá trị mặc định
            const titleInput = form.querySelector('input[name="title"]');
            if (titleInput) titleInput.value = 'MASTER TRAINER';
            // Reset isActive về 1
            const isActiveSelect = form.querySelector('select[name="isActive"]');
            if (isActiveSelect) isActiveSelect.value = '1';
        }

        function closeModal() {
            modal.classList.remove('show');
            setTimeout(() => {
                modal.style.display = 'none';
            }, 300);
            document.body.style.overflow = 'auto';
        }

        btnOpen.addEventListener('click', openModal);
        btnClose.addEventListener('click', closeModal);
        btnCancel.addEventListener('click', closeModal);

        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeModal();
            }
        });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && modal.classList.contains('show')) {
                closeModal();
            }
        });

        // Validate form trước khi submit
        form.addEventListener('submit', function(e) {
            const ptName = form.querySelector('input[name="ptName"]').value.trim();
            const phoneZalo = form.querySelector('input[name="phoneZalo"]').value.trim();
            const email = form.querySelector('input[name="email"]').value.trim();

            if (!ptName || !phoneZalo || !email) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return false;
            }

            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ!');
                return false;
            }

            // Validate phone format
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phoneZalo.replace(/\s/g, ''))) {
                e.preventDefault();
                alert('Số điện thoại không hợp lệ!');
                return false;
            }
        });
    });
</script>
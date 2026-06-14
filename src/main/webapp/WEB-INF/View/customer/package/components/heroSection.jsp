<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gói tập</title>

    <style>
        /* Custom Variables & Base */
        :root {
            --primary-red: #ff0000;
            --dark-bg: #121212;
            --card-bg: #2d1515;
            --card-pro-bg: #3d1a1a;
            --text-gray: #a0a0a0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--dark-bg);
        }

        .pricing-section{
            background-color: #230F0F !important;
        }

        .fw-black { font-weight: 900; }
        .italic { font-style: italic; }
        .text-primary-custom { color: var(--primary-red); }
        .text-secondary-custom { color: var(--text-gray); }

        /* Hero Section */
        .hero-section {
            padding: 100px 0 80px;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(18,18,18,0.9) 100%);
        }

        .tracking-tighter { letter-spacing: -2px; }

        /* Pricing Cards */
        .pricing-card {
            background-color: var(--card-bg);
            border: 1px solid rgba(255, 0, 0, 0.1);
            border-radius: 1rem;
            padding: 2.5rem;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .pricing-card:hover {
            transform: translateY(-10px);
        }

        .pricing-card.highlighted {
            background-color: var(--card-pro-bg);
            border: 2px solid var(--primary-red);
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.2);
            transform: scale(1.05);
            z-index: 10;
        }

        /* List Styles */
        .pricing-card ul li {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .pricing-card ul li .material-icons {
            font-size: 1.25rem;
            color: var(--primary-red);
        }

        .disabled-item {
            color: #666;
        }
        .disabled-item .material-icons {
            color: #666 !important;
        }

        /* Buttons */
        .btn-primary-custom {
            background-color: var(--primary-red);
            color: white;
            border: none;
            padding: 1rem;
            letter-spacing: 2px;
        }

        .btn-primary-custom:hover {
            background-color: #cc0000;
            color: white;
        }

        .btn-outline-primary-custom {
            border: 2px solid var(--primary-red);
            color: var(--primary-red);
            padding: 1rem;
            letter-spacing: 2px;
        }

        .btn-outline-primary-custom:hover {
            background-color: var(--primary-red);
            color: white;
        }

        /* Badge */
        .badge-popular {
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background-color: var(--primary-red);
            color: white;
            padding: 4px 15px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 900;
            text-transform: uppercase;
            white-space: nowrap;
        }

        /* Responsive adjustments */
        @media (max-width: 991px) {
            .pricing-card.highlighted {
                transform: scale(1);
                margin: 20px 0;
            }
        }
    </style>

</head>
<body class="bg-dark-custom text-white">

<header class="hero-section text-center">
    <div class="container">
        <h1 class="display-3 fw-black italic text-uppercase tracking-tighter mb-3">
            BẢNG GIÁ <span class="text-primary-custom">HỘI VIÊN</span>
        </h1>
        <p class="lead text-secondary-custom mx-auto" style="max-width: 600px;">
            Chọn vũ khí của bạn. Bắt đầu hành trình lột xác và phá vỡ mọi giới hạn ngay hôm nay.
        </p>
    </div>
</header>

<section class="pricing-section pb-5">
    <div class="container">
        <div class="row g-4 align-items-center justify-content-center">

            <div class="col-lg-4 col-md-6">
                <div class="pricing-card">
                    <div class="card-header-custom mb-4 text-center">
                        <h3 class="fw-black text-uppercase italic m-0">Cơ bản</h3>
                        <p class="text-secondary-custom small mt-1 mb-0">Dành cho người mới bắt đầu kỷ luật.</p>
                    </div>
                    <div class="price-tag mb-4 text-center">
                        <span class="display-4 fw-black">Miễn phí</span>
                    </div>

                    <ul class="list-unstyled mx-auto mb-5" style="max-width: 290px;">
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>3 Video sửa lỗi tư thế AI/tháng</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Giáo án huấn luyện linh hoạt</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Lịch theo dõi tiến độ cơ bản</span>
                        </li>
                    </ul>
                    <a href="${pageContext.request.contextPath}/setup/goal"
                       class="btn btn-outline-primary-custom w-100 fw-black text-center d-block text-decoration-none">
                        THIẾT LẬP LỘ TRÌNH
                    </a>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="pricing-card highlighted position-relative">
                    <div class="badge-popular">PHỔ BIẾN NHẤT</div>
                    <div class="card-header-custom mb-4 text-center">
                        <h3 class="fw-black text-uppercase italic text-primary-custom m-0">PRO</h3>
                        <p class="text-secondary-custom small mt-1 mb-0">Nâng tầm việc tập luyện chuyên nghiệp.</p>
                    </div>
                    <div class="price-tag mb-4 text-center">
                        <span class="display-3 fw-black">10$</span>
                        <span class="text-secondary-custom fw-bold small">/ THÁNG</span>
                    </div>

                    <ul class="list-unstyled mx-auto mb-5 fw-bold" style="max-width: 290px;">
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Bao gồm toàn bộ gói Cơ bản</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Sửa lỗi Video AI không giới hạn</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Trợ lý Dinh dưỡng AI hỗ trợ 24/7</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Quét món ăn & Lưu Calo tự động</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 2C6.48 2 2 6.48 2 12C2 17.52 6.48 22 12 22C17.52 22 22 17.52 22 12C22 6.48 17.52 2 12 2ZM10 17L5 12L6.41 10.59L10 14.17L17.59 6.58L19 8L10 17Z"
                                      fill="#ff0000"/>
                            </svg>
                            <span>Dời lịch tập linh hoạt (2 lần/tuần)</span>
                        </li>
                    </ul>
                    <button type="button" onclick="startPaymentFlow()"
                            class="btn btn-primary-custom w-100 fw-black shadow-lg">
                        CHỌN GÓI NGAY
                    </button>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="pricing-card opacity-50" style="border: 1px dashed rgba(255, 255, 255, 0.2);">
                    <div class="card-header-custom mb-4 text-center">
                        <h3 class="fw-black text-uppercase italic m-0" style="color: #6c757d;">Elite</h3>
                        <p class="text-secondary-custom small mt-1 mb-0" style="color: #6c757d !important;">Dành cho
                            những chiến binh thực thụ.</p>
                    </div>
                    <div class="price-tag mb-4 text-center">
                        <span class="display-4 fw-black" style="color: #6c757d;">Sắp ra mắt</span>
                    </div>

                    <ul class="list-unstyled mx-auto mb-5" style="max-width: 280px; color: #6c757d;">
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M6 2V8H6.01L10 12L6 16H6.01V22H18V16H18.01L14 12L18 8H18.01V2M16 20H8V16.5L12 12.5L16 16.5V20ZM12 11.5L8 7.5V4H16V7.5L12 11.5Z"
                                      fill="#6c757d"/>
                            </svg>
                            <span>Chế độ huấn luyện 1-1 chuyên sâu</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M6 2V8H6.01L10 12L6 16H6.01V22H18V16H18.01L14 12L18 8H18.01V2M16 20H8V16.5L12 12.5L16 16.5V20ZM12 11.5L8 7.5V4H16V7.5L12 11.5Z"
                                      fill="#6c757d"/>
                            </svg>
                            <span>Đồng bộ thiết bị Tracking thông minh</span>
                        </li>
                        <li>
                            <svg class="pricing-icon" width="18" height="18" viewBox="0 0 24 24" fill="none"
                                 xmlns="http://www.w3.org/2000/svg">
                                <path d="M6 2V8H6.01L10 12L6 16H6.01V22H18V16H18.01L14 12L18 8H18.01V2M16 20H8V16.5L12 12.5L16 16.5V20ZM12 11.5L8 7.5V4H16V7.5L12 11.5Z"
                                      fill="#6c757d"/>
                            </svg>
                            <span>Đặc quyền VIP & Dời lịch tự do 100%</span>
                        </li>
                    </ul>
                    <button class="btn btn-outline-secondary w-100 fw-black disabled"
                            style="padding: 1rem; letter-spacing: 2px; border-radius: 8px;" disabled>ĐANG PHÁT TRIỂN
                    </button>
                </div>
            </div>

        </div>
    </div>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <style>
        .modal-bento {
            background-color: #0b0f19 !important;
            border: 1px solid rgba(255, 255, 255, 0.08) !important;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
        }
        .bento-info-box {
            background-color: #121824;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        .bento-form-box {
            background-color: rgba(23, 30, 46, 0.6);
            border: 1px solid rgba(255, 0, 0, 0.15);
        }
        /* Sửa màu label sáng lên để không bị chìm */
        .text-label-custom {
            color: #cbd5e1 !important; /* Màu xám trắng rất rõ trên nền tối */
            font-weight: 600;
        }
        .input-custom-dark {
            background-color: #121824 !important;
            border: 1px solid rgba(255, 255, 255, 0.15) !important;
            color: #ffffff !important;
            padding: 0.65rem 0.75rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        .input-custom-dark:focus {
            border-color: #ff0000 !important;
            box-shadow: 0 0 0 2px rgba(255, 0, 0, 0.2) !important;
        }
        .input-custom-dark::placeholder {
            color: #475569 !important; /* Màu chữ gợi ý vừa phải */
        }
        .qr-container {
            background: #ffffff;
            padding: 12px;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(255, 255, 255, 0.1);
            display: inline-block;
        }
        .btn-submit-premium {
            background-color: #ff0000;
            color: #ffffff;
            font-weight: 800;
            letter-spacing: 0.5px;
            transition: all 0.2s ease;
            border: none;
        }
        .btn-submit-premium:hover {
            background-color: #cc0000;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(255, 0, 0, 0.4);
        }
    </style>

    <div class="modal fade" id="payosModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="payosModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modal-bento rounded-4 text-white">

                <div class="modal-header border-0 pb-0 pt-4 px-4">
                    <div class="d-flex align-items-center gap-2">
                        <span class="material-symbols-outlined text-danger fs-4">workspace_premium</span>
                        <h5 class="modal-title fw-black text-uppercase italic tracking-tight" id="payosModalLabel">Nâng cấp tài khoản PRO</h5>
                    </div>
                    <button type="button" class="btn-close btn-close-white opacity-50" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body px-4 py-4">
                    <div class="text-center mb-4">
                        <p style="white-space: nowrap; font-size: 13px; letter-spacing: 0.3px;" class="text-light small mb-3 opacity-75">Quét mã bằng ứng dụng Ngân hàng hoặc Ví điện tử để chuyển khoản</p>
                        <div class="qr-container mb-2">
                            <img src = "https://res.cloudinary.com/dgnyskpc3/image/upload/v1780156021/b8931a430272832cda63_ok5op5.jpg" id="payosQrImage" src="" alt="Mã quét QR Ngân Hàng" style="width: 190px; height: 190px;" class="rounded-2">
                        </div>
                    </div>

                    <div class="bento-info-box p-3 rounded-3 mb-3">
                        <div class="mb-2.5 d-flex justify-content-between align-items-center">
                            <span class="text-label-custom small">Số tiền cần thanh toán</span>
                            <span id="payosAmount" class="fw-black text-danger fs-5">250,000 đ</span>
                        </div>
                        <div class="pt-2.5 border-top border-secondary border-opacity-10 d-flex justify-content-between align-items-center">
                            <span class="text-label-custom small">Nội dung chuyển khoản mẫu</span>
                            <span id="payosContent" class="fw-bold text-white font-monospace text-uppercase" style="font-size: 13px; letter-spacing: 0.5px;">---</span>
                        </div>
                    </div>

                    <div class="bento-form-box p-3 rounded-3">
                        <div class="d-flex align-items-center gap-2 text-warning mb-3">
                            <span class="material-symbols-outlined fs-5">verified_user</span>
                            <span class="small fw-bold text-uppercase italic">Xác nhận giao dịch thủ công</span>
                        </div>

                        <input type="hidden" id="submitOrderId" value="">

                        <div class="mb-3">
                            <label class="text-label-custom small mb-1.5">Tên tài khoản người chuyển <span class="text-danger">*</span></label>
                            <input type="text" id="senderName" class="form-control form-control-sm input-custom-dark" placeholder="VÍ DỤ: TRAN QUAN HUY" style="text-transform: uppercase;" required>
                        </div>
                        <div class="mb-1">
                            <label class="text-label-custom small mb-1.5">Nội dung thực tế bạn đã ghi trên App <span class="text-danger">*</span></label>
                            <input type="text" id="senderContent" class="form-control form-control-sm input-custom-dark" placeholder="Nhập chính xác nội dung bạn vừa ghi trên app" required>
                        </div>
                    </div>
                </div>

                <div class="modal-footer border-0 pt-0 pb-4 px-4">
                    <button type="button" onclick="submitPaymentApproval()" class="btn btn-submit-premium w-100 rounded-3 py-2.5 text-uppercase">
                        <span id="btnSubmitText">Gửi yêu cầu kích hoạt ngay</span>
                        <span id="btnSubmitSpinner" class="spinner-border spinner-border-sm ms-2 d-none" role="status"></span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        var paymentModalInstance = null;

        // 🔥 Inject trực tiếp từ JSP, không cần thẻ <input> nữa
        var globalContextPath = '<%= request.getContextPath() %>';

        console.log(">>> Context Path:", globalContextPath);

        function startPaymentFlow() {
            const url = globalContextPath + '/payment/create-order?action=create&package=pro';
            console.log(">>> Đang gọi API tới:", url); // In ra URL đang gọi

            fetch(url, {
                method: 'POST'
            })
            .then(response => {
                // 🔥 QUAN TRỌNG: Kiểm tra mã lỗi HTTP (404, 500...) trước khi parse JSON
                if (!response.ok) {
                    return response.text().then(text => {
                        // Cắt bớt text cho ngắn để dễ đọc
                        throw new Error("Server báo lỗi HTTP " + response.status + ": " + text.substring(0, 150));
                    });
                }
                return response.json();
            })
            .then(data => {
                if (!data.success && data.requiresLogin) {
                    window.location.href = globalContextPath + '/auth?action=login';
                    return;
                }

                if(data.success) {
                    document.getElementById('payosAmount').innerText = Number(data.amount).toLocaleString('vi-VN') + " đ";
                    document.getElementById('payosContent').innerText = data.description;
                    document.getElementById('submitOrderId').value = data.orderId;

                    document.getElementById('senderName').value = "";
                    document.getElementById('senderContent').value = "";

                    const modalElement = document.getElementById('payosModal');
                    paymentModalInstance = bootstrap.Modal.getOrCreateInstance(modalElement); // Gán vào biến để lát hide được
                    paymentModalInstance.show();
                } else {
                    alert("Lỗi nghiệp vụ: " + data.message);
                }
            })
            .catch(error => {
                console.error('🔥 CHI TIẾT LỖI:', error);
                // 🔥 Hiển thị chi tiết lỗi ra alert thay vì chỉ báo "Lỗi hệ thống"
                alert("Lỗi kết nối! Chi tiết: \n" + error.message);
            });
        }
    </script>

    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="liveToast" class="toast align-items-center text-white border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div id="toastMessage" class="toast-body"></div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <script>
        /**
         * Hiển thị thông báo Toast
         * @param {string} message - Nội dung thông báo
         * @param {boolean} isSuccess - true: màu xanh (thành công), false: màu đỏ (lỗi)
         */
        function showToast(message, isSuccess) {
            const toastEl = document.getElementById('liveToast');
            const toastBody = document.getElementById('toastMessage');

            // Cấu hình style và nội dung
            toastEl.style.backgroundColor = isSuccess ? "#198754" : "#dc3545";
            toastBody.textContent = message;

            // Khởi tạo và hiển thị
            const toast = bootstrap.Toast.getOrCreateInstance(toastEl);
            toast.show();
        }

        /**
         * Xử lý xác nhận thanh toán
         */
        async function submitPaymentApproval() {
            const orderId = document.getElementById('submitOrderId').value;
            const senderName = document.getElementById('senderName').value.trim();
            const senderContent = document.getElementById('senderContent').value.trim();
            const spinner = document.getElementById('btnSubmitSpinner');

            // Kiểm tra dữ liệu đầu vào
            if (!senderName || !senderContent) {
                showToast("Vui lòng nhập đầy đủ thông tin thanh toán!", false);
                return;
            }

            // Hiển thị trạng thái đang xử lý
            spinner.classList.remove('d-none');

            try {
                const response = await fetch(`${globalContextPath}/payment/create-order?action=confirm`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({
                        orderId: orderId,
                        senderName: senderName,
                        senderContent: senderContent
                    })
                });

                if (!response.ok) throw new Error('Network error');

                const data = await response.json();

                if (data.success) {
                    showToast("Gửi yêu cầu thành công!", true);
                    paymentModalInstance?.hide();
                } else {
                    showToast(data.message || "Giao dịch không thành công!", false);
                }
            } catch (err) {
                console.error("Payment error:", err);
                showToast("Lỗi kết nối máy chủ, vui lòng thử lại sau!", false);
            } finally {
                // Luôn ẩn spinner dù thành công hay thất bại
                spinner.classList.add('d-none');
            }
        }
    </script>
</section>
</body>

</html>
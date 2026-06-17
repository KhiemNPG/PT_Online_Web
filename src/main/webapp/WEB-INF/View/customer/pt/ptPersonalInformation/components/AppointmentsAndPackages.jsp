<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartPT - Thuê PT</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-main: #090b11;         /* Tối sâu hơn, tạo cảm giác không gian chìm */
            --surface: #121622;         /* Nền Bento box chính */
            --surface-card: #181f32;    /* Nền của các ô lịch, nút giờ */
            --surface-hover: #222b45;
            --primary: #ff1f29;         /* Đỏ Neon rực rỡ mang tính hành động cao */
            --primary-glow: rgba(255, 31, 41, 0.35);
            --cyan-neon: #00f2fe;       /* Màu nhấn cho ngày hiện tại */
            --cyan-glow: rgba(0, 242, 254, 0.25);
            --text-main: #f3f4f6;
            --text-sub: #6b7280;        /* Thấp tông hơn chút để phân cấp thông tin */
            --border-color: rgba(255, 255, 255, 0.06);
            --border-glow: rgba(255, 255, 255, 0.12);
        }

        body {
            background-color: var(--bg-main);
            color: var(--text-main);
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            -webkit-font-smoothing: antialiased;
            letter-spacing: -0.2px;
        }

        /* Tiêu đề phần chính */
        .section-title {
            font-size: 1.1rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            background: linear-gradient(90deg, #fff, var(--text-sub));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* --- CONTAINER BENTO BOX CHÍNH --- */
        .booking-container {
            background: var(--surface) !important;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 32px !important;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6),
                        inset 0 1px 0 rgba(255, 255, 255, 0.05); /* Viền sáng nhẹ cạnh trên */
            backdrop-filter: blur(10px);
        }

        /* Grid 7 cột */
        .row-cols-7 {
            display: flex;
            flex-wrap: wrap;
            margin-right: -6px;
            margin-left: -6px;
        }
        .row-cols-7 > .col {
            flex: 0 0 14.2857%;
            max-width: 14.2857%;
            padding-right: 6px;
            padding-left: 6px;
        }

        /* Tiêu đề Thứ */
        .calendar-weekday {
            color: var(--text-sub) !important;
            font-size: 0.75rem !important;
            font-weight: 700 !important;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding-bottom: 12px;
        }

        /* THẺ Ô NGÀY BENTO */
        .day-node {
            background-color: var(--surface-card) !important;
            border: 1px solid var(--border-color) !important;
            border-radius: 12px;
            padding: 14px 0;
            cursor: pointer;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 54px;
            position: relative;
            user-select: none;
            color: var(--text-main) !important;
            font-weight: 600 !important;
            font-size: 0.95rem !important;
        }

        .day-node span {
            color: var(--text-main) !important;
            font-weight: 600 !important;
            transition: color 0.2s;
        }

        /* Hover ngày hợp lệ */
        .day-node:hover:not(.disabled) {
            border-color: var(--primary) !important;
            background-color: rgba(255, 31, 41, 0.1) !important;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }

        /* Trạng thái ngày đang chọn (Active) */
        .day-node.active {
            background: var(--primary) !important;
            border-color: var(--primary) !important;
            box-shadow: 0 0 20px var(--primary-glow), 0 4px 10px rgba(255, 31, 41, 0.2) !important;
            transform: scale(1.02);
        }
        .day-node.active span {
            color: #ffffff !important;
            font-weight: 800 !important;
        }

        /* Trạng thái ngày hôm nay (Today) */
        .day-node.today {
            border: 1.5px solid var(--cyan-neon) !important;
            background-color: rgba(0, 242, 254, 0.05) !important;
            box-shadow: inset 0 0 8px rgba(0, 242, 254, 0.1);
        }
        .day-node.today span {
            color: var(--cyan-neon) !important;
            font-weight: 700 !important;
        }

        /* Kết hợp hôm nay + đang được chọn luôn */
        .day-node.today.active {
            background: var(--primary) !important;
            border-color: var(--primary) !important;
        }
        .day-node.today.active span {
            color: #ffffff !important;
        }

        /* Ô trống / Quá khứ bị khóa */
        .day-node.disabled {
            background-color: rgba(255, 255, 255, 0.01) !important;
            border: 1px solid rgba(255, 255, 255, 0.02) !important;
            cursor: not-allowed;
            transform: none !important;
            box-shadow: none !important;
        }
        .day-node.disabled span {
            color: #374151 !important; /* Màu tối chìm hẳn xuống nền */
            font-weight: 400 !important;
        }

        /* --- NÚT GIỜ TRỐNG --- */
        .time-slot-group-title {
            font-size: 0.72rem;
            color: var(--cyan-neon) !important;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            opacity: 0.9;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .time-slot-btn {
            background-color: var(--surface-card);
            border: 1px solid rgba(255, 31, 41, 0.25);
            color: #ff5a60;
            font-size: 0.85rem;
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        }
        .time-slot-btn:hover:not(:disabled) {
            background-color: rgba(255, 31, 41, 0.15);
            border-color: var(--primary);
            color: #ffffff;
            transform: translateY(-1px);
        }
        .time-slot-btn.selected {
            background-color: #ffffff !important;
            border-color: #ffffff !important;
            color: #000000 !important;
            font-weight: 700;
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.4), 0 4px 12px rgba(0,0,0,0.3);
            transform: scale(1.03);
        }
        .time-slot-btn:disabled {
            background-color: rgba(255, 255, 255, 0.02);
            border-color: rgba(255, 255, 255, 0.04);
            color: #374151;
            cursor: not-allowed;
            box-shadow: none;
        }

        /* --- NÚT SUBMIT ĐẶT LỊCH QUYẾT LIỆT --- */
        .btn-cta-submit {
            background: linear-gradient(135deg, #ff1f29, #b90710);
            color: white;
            border: none;
            width: 100%;
            padding: 16px 0;
            font-size: 0.95rem;
            font-weight: 700;
            border-radius: 12px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            box-shadow: 0 6px 25px rgba(255, 31, 41, 0.3);
            transition: all 0.25s ease;
        }
        .btn-cta-submit:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(255, 31, 41, 0.55);
            filter: brightness(1.1);
        }
        .btn-cta-submit:active:not(:disabled) {
            transform: translateY(0);
        }
        .btn-cta-submit:disabled {
            background: #1c2230;
            color: #4b5563;
            border: 1px solid rgba(255, 255, 255, 0.03);
            box-shadow: none;
            cursor: not-allowed;
        }

        /* Chú thích màu sắc lịch phía dưới */
        .legend-text {
            font-size: 0.78rem;
            color: var(--text-sub);
            font-weight: 500;
        }

        /* Custom nút mũi tên tháng */
        .btn-month-nav {
            background-color: var(--surface-card);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            transition: all 0.2s;
            border-radius: 8px;
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .btn-month-nav:hover {
            background-color: var(--surface-hover);
            border-color: var(--text-sub);
            color: #fff;
        }

        /* Tinh chỉnh scrollbar cho vùng chứa giờ nếu quá dài */
        #slots-body-area {
            max-height: 320px;
            overflow-y: auto;
            padding-right: 4px;
        }
        #slots-body-area::-webkit-scrollbar {
            width: 4px;
        }
        #slots-body-area::-webkit-scrollbar-thumb {
            background: var(--border-color);
            border-radius: 4px;
        }
    </style>
</head>

<body>

<div class="container my-5" style="max-width: 1140px;">

    <div class="mb-4 d-flex align-items-center gap-2">
        <i class="bi bi-calendar2-heart text-danger fs-5"></i>
        <h2 class="m-0 section-title">Lịch Hẹn & Khung Giờ Trống</h2>
    </div>

    <div class="booking-container mb-4 text-white">
        <div class="row g-5">

            <div class="col-12 col-md-6">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="fw-bold fs-5 text-white" id="calendar-month-year" style="letter-spacing: -0.3px;">Tháng 12, 2024</span>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn-month-nav" id="btn-prev-month">
                            <i class="bi bi-chevron-left"></i>
                        </button>
                        <button type="button" class="btn-month-nav" id="btn-next-month">
                            <i class="bi bi-chevron-right"></i>
                        </button>
                    </div>
                </div>

                <div class="row row-cols-7 text-center mb-2">
                    <div class="col calendar-weekday">CN</div>
                    <div class="col calendar-weekday">T2</div>
                    <div class="col calendar-weekday">T3</div>
                    <div class="col calendar-weekday">T4</div>
                    <div class="col calendar-weekday">T5</div>
                    <div class="col calendar-weekday">T6</div>
                    <div class="col calendar-weekday">T7</div>
                </div>

                <div class="row row-cols-7 g-2 text-center" id="calendar-days"></div>

                <div class="d-flex flex-wrap gap-3 mt-4 pt-3 border-top border-secondary border-opacity-10 legend-text">
                    <div class="d-flex align-items-center gap-2">
                        <span class="d-inline-block rounded-circle" style="width:8px; height:8px; background-color: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1);"></span> Quá khứ / Khóa
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="d-inline-block rounded-circle" style="width:8px; height:8px; background-color: rgba(0, 242, 254, 0.2); border: 1px solid var(--cyan-neon);"></span> Ngày hiện tại
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <span class="d-inline-block rounded-1" style="width:8px; height:8px; background-color: var(--primary);"></span> Đang chọn
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6 border-start border-secondary border-opacity-10 ps-md-5 d-flex flex-column" id="time-slots-container">
                <h3 class="fs-6 fw-bold mb-4 text-white text-uppercase" style="letter-spacing: 1px; opacity: 0.9;">Khung Giờ Trống</h3>

                <div class="flex-grow-1" id="slots-body-area">
                    <p class="text-muted" style="font-size: 13px; font-style: italic;">Vui lòng chọn một ngày bên lịch để hiển thị giờ làm việc.</p>
                </div>

                <form action="${pageContext.request.contextPath}/confirm-booking" method="POST" class="mt-4">
                    <input type="hidden" id="selectedDateInput" name="selectedDate" value="">
                    <input type="hidden" id="selectedAvailabilityId" name="availabilityId" value="">
                    <button type="submit" class="btn-cta-submit" id="btnSubmitBooking" disabled>
                        Xác Nhận Đặt Lịch Ngay
                    </button>
                </form>
            </div>

        </div>
    </div>

</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let currentDate = new Date(2026, 5, 1);
        let selectedDate = null;

        // Các thành phần DOM từ giao diện
        const monthYearLabel = document.getElementById("calendar-month-year");
        const calendarDaysContainer = document.getElementById("calendar-days");
        const btnPrev = document.getElementById("btn-prev-month");
        const btnNext = document.getElementById("btn-next-month");
        const selectedDateInput = document.getElementById("selectedDateInput");
        const slotsBodyArea = document.getElementById("slots-body-area");
        const submitBtn = document.getElementById("btnSubmitBooking");
        const availabilityInput = document.getElementById("selectedAvailabilityId");

        // Hàm hỗ trợ bốc ptId an toàn, không lo bị mất khi chuyển tháng
        function getPtId() {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get('ptId') || "${ptDetail.ptId}" || "2"; // Mặc định là 2 nếu null
        }

        // 1. HÀM DỰNG BỘ LỊCH BENTO (ĐÃ SỬA LỖI THỤT LỀ THEO THỨ)
        function renderCalendar(dateObj) {
            calendarDaysContainer.innerHTML = "";

            let year = dateObj.getFullYear();
            let month = dateObj.getMonth();

            monthYearLabel.innerText = `Tháng ${month + 1}, ${year}`;

            // Lấy thứ của ngày đầu tiên trong tháng (0: Chủ Nhật, 1: Thứ 2, ..., 6: Thứ 7)
            let firstDayIndex = new Date(year, month, 1).getDay();
            let totalDays = new Date(year, month + 1, 0).getDate();

            let today = new Date();
            today.setHours(0, 0, 0, 0);

            // FIX: Vì cột đầu tiên của ông là CN, nên số ô trống cần thụt lề CHÍNH XÁC bằng firstDayIndex
            for (let i = 0; i < firstDayIndex; i++) {
                let emptyCol = document.createElement("div");
                emptyCol.className = "col";
                let emptyNode = document.createElement("div");
                emptyNode.className = "day-node disabled";
                emptyNode.innerHTML = `<span></span>`;
                emptyCol.appendChild(emptyNode);
                calendarDaysContainer.appendChild(emptyCol);
            }

            // Dựng các ô ngày thực tế trong tháng
            for (let day = 1; day <= totalDays; day++) {
                let col = document.createElement("div");
                col.className = "col";

                let dayNode = document.createElement("div");
                dayNode.className = "day-node";
                dayNode.innerHTML = `<span>${day}</span>`;

                let meshMonth = String(month + 1).padStart(2, '0');
                let meshDay = String(day).padStart(2, '0');
                let dateString = `${year}-${meshMonth}-${meshDay}`;
                dayNode.setAttribute("data-date", dateString);

                let thisDate = new Date(year, month, day);
                thisDate.setHours(0, 0, 0, 0);

                if (thisDate.getTime() === today.getTime()) {
                    dayNode.classList.add("today");
                }

                if (thisDate < today) {
                    dayNode.classList.add("disabled");
                } else {
                    dayNode.addEventListener("click", function () {
                        document.querySelector(".day-node.active")?.classList.remove("active");
                        this.classList.add("active");

                        selectedDate = this.getAttribute("data-date");
                        selectedDateInput.value = selectedDate;

                        submitBtn.disabled = true;
                        availabilityInput.value = "";

                        // Gọi hàm AJAX lấy dữ liệu giờ
                        fetchTimeSlots(selectedDate);
                    });
                }

                if (selectedDate === dateString) {
                    dayNode.classList.add("active");
                }

                col.appendChild(dayNode);
                calendarDaysContainer.appendChild(col);
            }
        }

        // 2. HÀM AJAX GỌI SANG SERVLET LẤY GIỜ
        function fetchTimeSlots(dateStr) {
            slotsBodyArea.innerHTML = `
                <div class="text-center py-5">
                    <div class="spinner-border text-danger spinner-border-sm mb-2"></div>
                    <div class="text-muted fs-7" style="font-size: 13px;">Đang tải khung giờ...</div>
                </div>`;

            let ptId = getPtId();

            // FIX TẠI ĐÂY: Thay vì dùng window.location.pathname bấp bênh,
            // Hãy dùng đường dẫn tuyệt đối trỏ thẳng về URL Pattern của Servlet (Ví dụ: /PT_Detail)
            // Ông kiểm tra xem cái @WebServlet("/...") ở đầu file Servlet của ông tên là gì thì điền vào đây nhé
            let servletPath = "${pageContext.request.contextPath}/PT_Detail";

            let url = servletPath + "?ptId=" + ptId + "&date=" + dateStr;
            console.log("Đang gọi AJAX đến URL tuyệt đối: " + url);

            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Mã lỗi hệ thống: " + response.status);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Dữ liệu DB trả về:", data);
                    renderTimeSlotsMarkup(data);
                })
                .catch(error => {
                    console.error("Lỗi AJAX:", error);
                    slotsBodyArea.innerHTML = `
                        <div class="text-center py-4">
                            <i class="bi bi-exclamation-triangle text-warning fs-4 mb-2 d-block"></i>
                            <p class="text-muted" style="font-size: 13px;">
                                Không thể kết nối hoặc chưa có ca trực.<br>
                                <span class="text-danger font-monospace" style="font-size: 11px;">(${error.message})</span>
                            </p>
                        </div>`;
                });
        }

        // 3. HÀM ĐỔ NÚT BẤM KHUNG GIỜ LÊN GIAO DIỆN
        function renderTimeSlotsMarkup(slots) {
            if (!slots || slots.length === 0) {
                slotsBodyArea.innerHTML = `
                    <div class="text-center py-4">
                        <i class="bi bi-calendar-x text-muted fs-4 mb-2 d-block"></i>
                        <p class="text-muted" style="font-size: 13px; font-style: italic;">Huấn luyện viên không có lịch trống vào ngày này.</p>
                    </div>`;
                return;
            }

            let htmlHTML = `<div class="d-flex flex-column gap-4">`;

            let shifts = {
                "SÁNG (MORNING)": [],
                "CHIỀU (AFTERNOON)": [],
                "TỐI (EVENING)": []
            };

            slots.forEach(slot => {
                let shiftKey = slot.shiftName ? slot.shiftName.toUpperCase() : "SÁNG (MORNING)";
                if (shiftKey.includes("SÁNG") || shiftKey.includes("MORNING")) {
                    shifts["SÁNG (MORNING)"].push(slot);
                } else if (shiftKey.includes("CHIỀU") || shiftKey.includes("AFTERNOON")) {
                    shifts["CHIỀU (AFTERNOON)"].push(slot);
                } else if (shiftKey.includes("TỐI") || shiftKey.includes("EVENING")) {
                    shifts["TỐI (EVENING)"].push(slot);
                } else {
                    shifts["SÁNG (MORNING)"].push(slot);
                }
            });

            for (let shiftName in shifts) {
                if (shifts[shiftName].length > 0) {
                    htmlHTML += `<div>
                        <div class="pack-sub mb-2 font-monospace">
                            <i class="bi bi-clock-history"></i> ${shiftName}
                        </div>
                        <div class="d-flex flex-wrap gap-2">`;

                    shifts[shiftName].forEach(slot => {
                        let disabledAttr = slot.status === 'Booked' ? 'disabled' : '';
                        htmlHTML += `
                            <button type="button" class="time-slot-btn" data-id="${slot.availabilityId}" ${disabledAttr}>
                                ${slot.startTime} - ${slot.endTime}
                            </button>`;
                    });

                    htmlHTML += `</div></div>`;
                }
            }
            htmlHTML += `</div>`;
            slotsBodyArea.innerHTML = htmlHTML;

            initTimeSlotButtons();
        }

        // 4. HÀM LẮNG NGHE SỰ KIỆN KHI BẤM CHỌN GIỜ
        function initTimeSlotButtons() {
            const slotBtns = slotsBodyArea.querySelectorAll(".time-slot-btn");
            slotBtns.forEach(btn => {
                btn.addEventListener("click", function () {
                    slotsBodyArea.querySelector(".time-slot-btn.selected")?.classList.remove("selected");
                    this.classList.add("selected");

                    availabilityInput.value = this.getAttribute("data-id");
                    submitBtn.disabled = false;
                });
            });
        }

        // Điều hướng nút bấm Tháng Trước / Tháng Sau
        btnPrev.addEventListener("click", function () {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar(currentDate);
            slotsBodyArea.innerHTML = `<p class="text-muted fs-7 text-center py-4">Vui lòng chọn một ngày bên lịch để hiển thị giờ làm việc.</p>`;
        });

        btnNext.addEventListener("click", function () {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar(currentDate);
            slotsBodyArea.innerHTML = `<p class="text-muted fs-7 text-center py-4">Vui lòng chọn một ngày bên lịch để hiển thị giờ làm việc.</p>`;
        });

        // Khởi chạy bộ lịch lần đầu
        renderCalendar(currentDate);
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<%@ page import="model.training.TrainingDay" %>
<%@ page isELIgnored="false" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>

<%
        // Fix lỗi Generics bằng cách thêm khoảng trắng sau dấu <
        List< TrainingDay> trainingDayList = (List) request.getAttribute("trainingDayList");
        String jointIssues = (String) request.getAttribute("healthProfile");
        String preferredDay = (String) request.getAttribute("trainingRequirement");
        Object uIdObj = request.getAttribute("userIdServlet");
        int userIdServlet = (uIdObj != null) ? (int) uIdObj : 0;

        Object sIdObj = request.getAttribute("userScheduleId");
        int userScheduleId = (sIdObj != null) ? (int) sIdObj : 0;
        //LocalDate today = LocalDate.now();
        LocalDate today = LocalDate.of(2026, 04, 23);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM");


            String[] dayNames = {
                "Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"
            };

            String[] shortDays = {"CN", "T2", "T3", "T4", "T5", "T6", "T7"};

            int startDayOffset = 0;
        if (trainingDayList != null && !trainingDayList.isEmpty() ){
            for (int i = 0; i < shortDays.length; i++) {
                if (shortDays[i].equalsIgnoreCase(preferredDay)) {
                    startDayOffset = i;
                    break;
                }
            }
        }
%>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;900&display=swap');
    :root {
        --elite-red: #ff0000; --elite-red-glow: rgba(255, 0, 0, 0.3);
        --glass-white: rgba(255, 255, 255, 0.05); --glass-border: rgba(255, 255, 255, 0.1);
        --text-muted: rgba(255, 255, 255, 0.4);
    }
    body { background-color: #000; color: #fff; font-family: 'Inter', sans-serif; -webkit-font-smoothing: antialiased; }

    .week-container { display: flex; align-items: center; gap: 20px; margin: 40px 0 20px; }
    .week-title { font-size: 1.25rem; font-weight: 700; white-space: nowrap; letter-spacing: -0.5px; }
    .week-line { flex-grow: 1; height: 1px; background: linear-gradient(90deg, rgba(255, 0, 0, 0.5) 0%, rgba(255, 255, 255, 0) 100%); }

    @media (min-width: 1200px) { .row-cols-xl-7 > * { flex: 0 0 auto; width: 14.285714%; } }

    .workout-card {
        background: var(--glass-white); border: 1px solid var(--glass-border);
        border-radius: 1.25rem; padding: 1.25rem; height: 100%;
        display: flex; flex-direction: column; transition: 0.3s; position: relative;
    }
    .status-today { border: 1px solid var(--elite-red); box-shadow: 0 0 20px var(--elite-red-glow); transform: scale(1.02); z-index: 2; background: rgba(255, 0, 0, 0.02); }
    .today-tag { position: absolute; top: -12px; left: 50%; transform: translateX(-50%); background: var(--elite-red); font-size: 0.6rem; padding: 3px 12px; border-radius: 20px; font-weight: 900; z-index: 3; text-transform: uppercase; }

    .day-label { font-size: 0.65rem; font-weight: 900; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; }
    .day-number { font-size: 1.2rem; font-weight: 700; margin-top: 2px; }
    .workout-title { font-size: 0.85rem; font-weight: 800; margin: 1rem 0; min-height: 2.5rem; line-height: 1.25; }

    .thumb-container { width: 100%; height: 80px; border-radius: 0.75rem; overflow: hidden; position: relative; background: #111; margin-bottom: 0.75rem; }
    .thumb-container img { width: 100%; height: 100%; object-fit: cover; }
    .grayscale { filter: grayscale(1); opacity: 0.3; }

    .workout-time { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); display: flex; align-items: center; gap: 4px; text-transform: uppercase; }
    .btn-start-elite {
    display: block;            /* Quan trọng: Để thẻ a chiếm hết chiều ngang và nhận padding */
    width: 100%;               /* Giữ nguyên độ rộng 100% */
    box-sizing: border-box;    /* Đảm bảo padding không làm tràn khung */

    background: var(--elite-red);
    color: white;              /* Màu chữ trắng */
    text-decoration: none;     /* Bỏ gạch chân mặc định của link */
    text-align: center;        /* Căn giữa chữ */

    padding: 0.75rem;
    border-radius: 0.75rem;
    font-weight: 900;
    font-size: 0.7rem;
    text-transform: uppercase;
    transition: 0.2s;
    border: none;              /* Vẫn giữ để đề phòng trình duyệt cũ */
}

    .btn-start-elite:hover {
        background: #cc0000;
        color: white;              /* Đảm bảo khi hover chữ vẫn trắng */
    }
    .status-text { font-size: 0.65rem; font-weight: 800; text-transform: uppercase; color: var(--elite-red); font-style: italic; }

    .noSchedule {
    font-weight: 700; /* Nhớ chữ 't' ở cuối nhé bro */
    color: rgba(255, 255, 255, 0.4) !important; /* Đừng để trắng tinh, để mờ mờ nhìn nó mới ra chất Elite */
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 0.75rem;
    }

    .status-completed {

        background: rgba(40, 167, 69, 0.08);
        opacity: 1; /* Để 1 cho rõ nét */

        /* Tăng cường độ màu đổ bóng lên 0.4 hoặc 0.6 */
        box-shadow: 0 0 15px rgba(40, 167, 69, 0.4),
                    0 0 5px rgba(40, 167, 69, 0.2);

        transition: all 0.3s ease;
    }

    /* Thêm dòng này: chỉnh con số tùy ý bạn */
    display: inline-block; /* Đảm bảo width có tác dụng nếu nó là thẻ span/a */
    }

    /* Biểu tượng check cho ngày hoàn thành */
    .text-success-elite {
        color: #00ff00;
        filter: drop-shadow(0 0 5px rgba(0, 255, 0, 0.5));
    }

    /* Container chính */
    .workout-options {
        display: flex;
        align-items: center;
    }

    /* Nút 3 chấm */
    .options-btn {
        background: transparent;
        border: none;
        padding: 0 4px; /* Thu hẹp padding để sát icon hơn */
        cursor: pointer;
        line-height: 1;
    }

    .options-btn:hover {
        color: #fff;
    }

    /* Menu Dropdown */
    .options-dropdown {
        position: absolute;
        right: 0;
        top: 25px; /* Điều chỉnh lại độ cao đổ xuống */
        background: rgba(20, 20, 20, 0.98);
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 10px;
        width: 200px;
        display: none;
        z-index: 1001;
        box-shadow: 0 8px 25px rgba(0,0,0,0.9);
    }

    /* Khi menu mở */
    .options-dropdown.show {
        display: block;
        animation: fadeIn 0.2s ease-out;
    }

    /* Item trong menu */
    .dropdown-item {
        padding: 10px 15px;
        color: rgba(255,255,255,0.8);
        text-decoration: none;
        display: flex;
        align-items: center;
        font-size: 0.8rem;
        font-weight: 600;
        transition: 0.2s;
        }

    .dropdown-item i {
        width: 20px;
        margin-right: 10px;
        font-size: 0.85rem;
        color: var(--elite-red); /* Màu đỏ đặc trưng cho icon */
    }

    .dropdown-item:hover {
        background: rgba(255, 255, 255, 0.05);
        color: #fff;
        padding-left: 18px; /* Hiệu ứng đẩy nhẹ khi hover */
    }

    /* Đường gạch ngang chia tách */
    .dropdown-divider {
        height: 1px;
        background: rgba(255, 255, 255, 0.05);
        margin: 4px 0;
    }

    /* Màu đỏ cho nút Bỏ qua */
    .text-danger {
        color: #ff4d4d !important;
    }

    /* Hiệu ứng hiện ra */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .status-icons {
        height: 24px; /* Giữ khung cố định để không bị nhảy khi đổi icon */
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .options-btn i {
        color: #ffffff !important;
        font-size: 1.1rem;
        text-shadow: 0 0 5px rgba(0,0,0,0.5); /* Thêm bóng để nổi bật hơn trên ảnh */
    }

    .options-btn:hover i {
        opacity: 1 !important;
        transform: scale(1.1);
    }

    .dropdown-header {
        padding: 8px 15px;
        font-size: 0.65rem;
        font-weight: 900;
        color: var(--text-muted);
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .ribbon-wrapper {
        position: absolute;
        top: 0;
        right: 0;
        width: 80px;      /* Độ rộng vừa đủ để chứa dải chéo */
        height: 80px;     /* Độ cao vừa đủ */
        overflow: hidden; /* Cắt phần thừa của ribbon tại đây */
        z-index: 1;       /* Nằm dưới tag Hôm Nay */
    }

        /* Đảm bảo div cha có position: relative và overflow: hidden */
        .done-ribbon {
            position: absolute;
            top: 1px;
            right: -40px; /* Đẩy ra ngoài một chút để khi xoay nó khớp vào góc */
            background: #28a745; /* Màu xanh lá (thành công) hoặc var(--elite-red) nếu muốn tông đỏ */
            color: white;
            padding: 5px 35px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            transform: rotate(45deg); /* Xoay chéo 45 độ */
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            z-index: 10;
            letter-spacing: 1px;
        }

    .modal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0; top: 0;
        width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.85); /* Tối đậm hơn */
        backdrop-filter: blur(8px);
    }

    /* Nội dung Popup - Thiết kế góc cạnh, đổ bóng khối */
    .modal-content {
        background: #1a1a1a; /* Đen xám đặc trưng của các app Fitness */
        margin: 8% auto;
        padding: 35px;
        width: 90%;
        max-width: 450px;
        border-radius: 4px; /* Góc ít bo hơn để tạo vẻ cứng cáp */
        border: 1px solid #333;
        position: relative;
        box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        color: #eee;
        font-family: 'Oswald', 'Roboto Condensed', sans-serif; /* Font chữ mạnh mẽ */
    }

    /* Tiêu đề - Viết hoa toàn bộ cho gắt */
    .modal-content h3 {
        margin: 0 0 25px 0;
        font-size: 22px;
        text-transform: uppercase;
        letter-spacing: 1px;
        color: #fff;
        border-left: 4px solid #00d4ff; /* Vạch màu nhấn */
        padding-left: 15px;
    }

    /* Box trạng thái hiện tại - Cảm giác "Warning" */
    .current-status {
        background: #252525;
        padding: 15px;
        border-radius: 4px;
        border: 1px solid #333;
        margin-bottom: 25px;
    }
    .current-status label {
        font-size: 11px;
        color: #888;
        text-transform: uppercase;
        display: block;
        margin-bottom: 5px;
    }
    .current-status strong {
        font-size: 18px;
        color: #00d4ff; /* Màu xanh neon mạnh mẽ */
        text-shadow: 0 0 10px rgba(0, 212, 255, 0.3);
    }

    /* Dropdown - Thiết kế chìm vào nền */
    .injury-select {
        width: 100%;
        padding: 14px;
        border: 1px solid #444;
        border-radius: 4px;
        font-size: 15px;
        color: #fff;
        background-color: #0f0f0f;
        outline: none;
        appearance: none;
        cursor: pointer;
        background-image: url("data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%2300d4ff%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E");
        background-repeat: no-repeat;
        background-position: right 15px top 50%;
        background-size: 12px;
    }
    .injury-select:focus {
        border-color: #00d4ff;
        box-shadow: 0 0 8px rgba(0, 212, 255, 0.2);
    }

    /* Option groups màu tối */
    select option, optgroup {
        background: #1a1a1a;
        color: #fff;
    }

    /* Nhóm nút bấm bùng nổ */
    .btn-group {
        display: flex;
        justify-content: flex-end;
        gap: 15px;
        margin-top: 35px;
    }
    .btn-save {
        background: #00d4ff;
        color: #000;
        border: none;
        padding: 12px 28px;
        border-radius: 2px;
        font-weight: 800;
        text-transform: uppercase;
        cursor: pointer;
        transition: 0.2s;
        box-shadow: 0 4px 15px rgba(0, 212, 255, 0.3);
    }
    .btn-save:hover {
        background: #fff;
        transform: scale(1.05);
    }

    .btn-cancel {
        background: transparent;
        color: #888;
        border: 1px solid #444;
        padding: 12px 20px;
        border-radius: 2px;
        text-transform: uppercase;
        font-size: 12px;
        cursor: pointer;
    }
    .btn-cancel:hover {
        color: #fff;
        border-color: #666;
    }

    /* Nút đóng X */
    .close-modal {
        position: absolute;
        right: 20px;
        top: 15px;
        color: #555;
        transition: 0.3s;
    }
    .close-modal:hover { color: #ff4d4d; }

    /* Tùy chỉnh riêng cho Toast của bạn */
    .my-success-toast {
        border-right: 5px solid #ff4d4d !important; /* Vạch đỏ bên phải */
        box-shadow: 0 0 15px rgba(255, 77, 77, 0.4) !important; /* Hiệu ứng Neon */
        font-family: 'Segoe UI', Roboto, sans-serif;
        border-radius: 8px !important;
    }

    /* Hiệu ứng trượt vào dứt khoát */
    .swal2-show {
        animation: swal2-show 0.4s ease-out !important;
    }

    /* Khi ở chế độ dời lịch, toàn bộ các card trong tuần đó đều hiện rõ */
    .training-week-row.rearrange-active .workout-card {
        opacity: 1 !important;
        filter: none !important;
        transition: all 0.3s ease;
        border: 1px solid #333; /* Viền nhẹ cho các ô bình thường trong tuần */
    }

    .container-fluid:has(.rearrange-active) .training-week-row:not(.rearrange-active) {
        opacity: 0.2; /* Làm mờ các tuần khác */
        filter: blur(1px); /* Thêm chút hiệu ứng mờ cho ảo diệu */
        pointer-events: none; /* Không cho click vào các tuần đang mờ */
        transition: all 0.4s ease;
    }

    /* Riêng ô ĐƯỢC CHỌN để dời: Highlight đặc biệt */
    .workout-card.selected-to-move {
        border: 2px solid #ff4d4d !important;
        box-shadow: 0 0 20px rgba(255, 77, 77, 0.6) !important;
        transform: scale(1.02);
        z-index: 10;
        position: relative;
    }

    /* Hiệu ứng khi kéo (Ghost) */
    .sortable-ghost {
        opacity: 0.3 !important;
        border: 2px dashed #ff4d4d !important;
    }

    /* Làm cho tuần đang sắp xếp nổi bật hẳn lên */
    .training-week-row.rearrange-active {
        position: relative;
        z-index: 1000;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 12px;
        box-shadow: 0 0 40px rgba(0, 0, 0, 0.8);
        padding: 10px; /* Tạo khoảng cách nhẹ để nhìn tách biệt */
        transform: scale(1.01); /* Phóng lớn nhẹ để tạo cảm giác "nổi lên" */
        transition: all 0.3s ease;
    }

    /* Container chứa nút */
        .bar-buttons {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        /* NÚT HỦY BỎ: Loại bỏ border, dùng màu text mờ, hover mới sáng lên */
        .btn-cancel-rearrange {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #888;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            transition: 0.3s;
        }

        .btn-cancel-rearrange:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border-color: rgba(255, 255, 255, 0.3);
        }

        /* Thêm một gạch chân nhỏ khi hover cho nút Hủy */
        .btn-cancel-rearrange::after {
            content: '';
            position: absolute;
            bottom: 5px;
            left: 0;
            width: 0;
            height: 1px;
            background: #fff;
            transition: width 0.3s ease;
        }
        .btn-cancel-rearrange:hover::after {
            width: 100%;
        }

        /* NÚT XÁC NHẬN LƯU: Làm cho nó rực rỡ hơn với Shadow Neon */
        .btn-save-rearrange {
            background: #ff4d4d; /* Màu đỏ Elite của bạn */
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            font-weight: 800;
            text-transform: uppercase;
            font-size: 0.8rem;
            box-shadow: 0 4px 15px rgba(255, 77, 77, 0.3);
            transition: 0.3s;
        }

        .btn-save-rearrange:hover {
           background: #ff1a1a;
            box-shadow: 0 0 25px rgba(255, 77, 77, 0.6);
            transform: scale(1.03);
        }

        .btn-save-rearrange:active {
            transform: translateY(0);
        }
</style>

<div class="container-fluid py-10 bg-black" >
    <%
    if (trainingDayList != null && !trainingDayList.isEmpty()) {
    // Lấy ngày bắt đầu từ DB của bản ghi đầu tiên làm mốc (Ngày 25/02 như bro nói)
    TrainingDay firstDay = trainingDayList.get(0);
    LocalDate startDate = (firstDay.getScheduledDate() != null) ? firstDay.getScheduledDate().toLocalDateTime().toLocalDate() : today;

    for (int i = 0; i < trainingDayList.size(); i++) {
    TrainingDay td = trainingDayList.get(i);
    if (td == null) continue;

    // FIX NGÀY: Tăng dần ngày dựa trên DayIndex
    // Nếu DayIndex là 1, 2, 3... thì (1-1)=0 ngày cộng thêm, (2-1)=1 ngày cộng thêm...
    LocalDate cardDate = startDate.plusDays(td.getDayIndex() - 1);

    String workoutLabel = (td.getWorkoutLabel() != null) ? td.getWorkoutLabel() : "";
    String dayType = (td.getDayType() != null) ? td.getDayType() : "";
    boolean isRestDay = "Rest".equalsIgnoreCase(dayType) || "Nghỉ ngơi".equalsIgnoreCase(workoutLabel);

    // FIX THỨ TỰ: Nếu DayIndex % 7 == 1 là Thứ 2 (Đầu tuần)
    boolean isStartOfWeek = (td.getDayIndex() % 7 == 1);

    if (isStartOfWeek) {
    if (i != 0) { %> </div> <% } %>

<div class="week-container">
    <h3 class="week-title">
        TUẦN <%= td.getWeekIndex() %>:
        <%= cardDate.format(fmt) %> - <%= cardDate.plusDays(6).format(fmt) %>
    </h3>
    <div class="week-line"></div>
</div>

<div class="row g-3 row-cols-1 row-cols-md-3 row-cols-lg-4 row-cols-xl-7 training-week-row">
    <%
    }

    // Logic CSS Class
    String sClass = "workout-card";
    if (td.isCompleted()) sClass += " status-completed";
    else if (today.isEqual(cardDate)) sClass += " status-today";
    else if (today.isAfter(cardDate)) sClass += " status-missed";
    else sClass += " status-upcoming";
    if (isRestDay) sClass += " status-rest";

    // FIX THỨ: Map DayIndex vào mảng dayNames
    // Ví dụ DayIndex = 1 => 1 % 7 = 1 (Thứ 2), DayIndex = 7 => 7 % 7 = 0 (Chủ Nhật)
    int dIdx = (td.getDayIndex() - 1 + startDayOffset) % 7;
    String textDanger = "text-danger";
    String empty = "";
    %>
    <div class="col">
        <div class="<%= sClass %>" data-id = "<%= td.getMasterDayId()%>" style="position: relative;">

            <% if (today.isEqual(cardDate)) { %>
            <div class="today-tag">HÔM NAY</div>
            <% } %>

            <%
                if ( td.isCompleted() && !td.getDayType().equalsIgnoreCase("Rest")){
            %>
            <div class="ribbon-wrapper">
                <div class="done-ribbon">DONE</div>
            </div>
            <%
                }
            %>

            <div class="card-header d-flex justify-content-between p-0 border-0 bg-transparent">
                <div>
                    <div class="day-label <%= (dIdx == 0) ? textDanger : empty %>">
                        <%= dayNames[dIdx] %>
                    </div>
                    <div class="day-number">
                        <%= cardDate.format(fmt) %>
                    </div>
                </div>
                <div class="d-flex align-items-center position-relative">
                    <div class="status-icons me-2"> <% if (td.isCompleted()) { %>
                        <i class="bi bi-check-circle-fill text-danger" style="font-size: 1.1rem;"></i>
                        <% } else if (today.isEqual(cardDate)) { %>
                        <i class="bi bi-stopwatch-fill text-danger" style="font-size: 1.1rem; filter: drop-shadow(0 0 5px var(--elite-red-glow));"></i>
                        <% } %>
                    </div>

                    <div class="workout-options">
                        <button class="options-btn" onclick="toggleDropdown(this, event)" type="button">
                            <i class="fas fa-ellipsis-v" style="font-size: 0.9rem; opacity: 0.7;"></i>
                        </button>

                        <div class="options-dropdown">
                            <div class="dropdown-header">Thao tác</div>
                            <a href="javascript:void(0);"
                               class="dropdown-item"
                               onclick="enableRearrangeMode(event, <%= td.getDayIndex() %>); return false;">
                                <i class="fas fa-calendar-alt"></i> Dời lịch tập
                            </a>
                            <a href="javascript:void(0)" class="dropdown-item" onclick="openInjuryModal()"><i class="fa fa-medkit"></i> Cập nhật chấn thương</a>
                            <a href="#" class="dropdown-item"><i class="fas fa-sticky-note"></i> Ghi chú</a>
                            <div class="dropdown-divider"></div>
                            <a href="#" class="dropdown-item text-danger"><i class="fas fa-ban"></i> Bỏ qua buổi này</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-body px-0 py-3">
                <% if (isRestDay) { %>
                <div class="text-center py-4">
                    <i class="bi bi-moon-stars fs-1 opacity-25"></i>
                    <div class="day-label mt-2">NGHỈ NGƠI</div>
                </div>
                <% } else { %>
                <h5 class="workout-title <%= today.isEqual(cardDate) ? textDanger : empty %>">
                    <%= workoutLabel %>
                </h5>
                <%
                    String grayscale = "grayscale";
                %>
                <div class="thumb-container <%= today.isAfter(cardDate) ? grayscale : empty %>">
                <img src="https://images.unsplash.com/photo-1434608519344-49d77a699e1d?w=300" alt="workout">
            </div>
            <div class="workout-time mt-2">
                <i class="bi bi-clock"></i> 90 PHÚT
            </div>
            <% } %>
        </div>

        <div class="card-footer px-0 border-0 bg-transparent mt-auto">
            <% if (td.isCompleted()) { %>
            <span class="status-text">ĐÃ XONG</span>
            <% } else if (today.isEqual(cardDate) && !isRestDay) { %>
            <a href="${pageContext.request.contextPath}/Exercises?id=<%=td.getMasterDayId()%>" class="btn-start-elite">
                BẮT ĐẦU TẬP
            </a>
            <% } else if (today.isBefore(cardDate)) { %>
            <span class="status-text opacity-25">SẮP TỚI</span>
            <% } else if (today.isAfter(cardDate) && !isRestDay) { %>
            <span class="status-text opacity-25">TRỄ LỊCH</span>
            <% } %>
        </div>
    </div>
</div>
<%
} // Kết thúc for
%>
<%
} else {
%>
<div style = "color: white" class="text-center py-5 noSchedule">
    Không có lịch tập hiện khả dụng.
</div>
<%
}
%>
</div>

<div id="injuryModal" class="modal" style="display: none; position: fixed; z-index: 9999; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.85); backdrop-filter: blur(8px); overflow-y: hidden;">
    <div class="modal-content" style="background: #1a1a1a; margin: 8% auto; padding: 30px; width: 90%; max-width: 450px; border-radius: 8px; border: 1px solid #333; position: relative; box-shadow: 0 20px 50px rgba(0,0,0,0.5); color: #eee; font-family: 'Segoe UI', sans-serif;">

        <span class="close-modal" style="position: absolute; right: 20px; top: 15px; cursor: pointer; font-size: 24px; color: #555; transition: 0.3s;">&times;</span>

        <form id="injuryForm">
            <h3 style="margin-top: 0; margin-bottom: 25px; color: #fff; display: flex; align-items: center; gap: 12px; text-transform: uppercase; letter-spacing: 1px; border-left: 4px solid #ff4d4d; padding-left: 15px;">
                <i class="fas fa-user-injured" style="color: #ff4d4d;"></i> Tình trạng chấn thương
            </h3>

            <div style="background: #252525; padding: 15px; border-radius: 6px; border: 1px solid #333; margin-bottom: 25px;">
                <span style="font-size: 11px; color: #888; display: block; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">Vùng đang được ghi nhận chấn thương</span>
                <%
                    if (jointIssues != null){
                        if (jointIssues.equalsIgnoreCase("Khong") ){
                            jointIssues = "Không chấn thương";
                        } else
                        if (jointIssues.equalsIgnoreCase("Co") ){
                            jointIssues = "Chấn thương vùng cổ";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Lung") ){
                            jointIssues = "Chấn thương vùng Lưng";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Vai") ){
                            jointIssues = "Chấn thương vùng Vai";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Tay") ){
                            jointIssues = "Chấn thương vùng Tay";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Hang") ){
                            jointIssues = "Chấn thương vùng Háng";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Goi") ){
                            jointIssues = "Chấn thương vùng Gối";
                        }
                        else
                            if (jointIssues.equalsIgnoreCase("Chan") ){
                            jointIssues = "Chấn thương vùng Chân";
                        }
                    }
                %>
                <strong style="font-size: 16px; color: #ff4d4d; text-shadow: 0 0 10px rgba(255, 77, 77, 0.2);"><%= jointIssues%></strong>
            </div>

            <div class="field" style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 10px; font-weight: 600; color: #bbb; font-size: 14px;">Chọn vị trí mới:</label>
                <select name="jointIssues" style="width: 100%; padding: 12px; border-radius: 6px; border: 1px solid #444; font-size: 15px; outline: none; cursor: pointer; background: #0f0f0f; color: #fff; appearance: none; background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23ff4d4d%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E'); background-repeat: no-repeat; background-position: right 15px top 50%; background-size: 12px;">
                    <option value="Khong" style="background: #1a1a1a;">--- Không có chấn thương ---</option>

                    <optgroup label="Cột sống" style="background: #1a1a1a; color: #888;">
                        <option value="Co" style="color: #fff;">Cột sống Cổ (Cervical Spine)</option>
                        <option value="Lung" style="color: #fff;">Cột sống Lưng trên (Upper Back/Thoracic)</option>
                        <option value="Lung" style="color: #fff;">Cột sống Lưng dưới (Lower Back/Lumbar)</option>
                    </optgroup>

                    <optgroup label="Chi trên (Tay)" style="background: #1a1a1a; color: #888;">
                        <option value="Vai" style="color: #fff;">Khớp Vai (Shoulder)</option>
                        <option value="Tay" style="color: #fff;">Khớp Khuỷu tay (Elbow)</option>
                        <option value="Tay" style="color: #fff;">Khớp Cổ tay (Wrist)</option>
                    </optgroup>

                    <optgroup label="Chi dưới (Chân)" style="background: #1a1a1a; color: #888;">
                        <option value="Hang" style="color: #fff;">Khớp Háng & Xương chậu (Hip & Pelvis)</option>
                        <option value="Goi" style="color: #fff;">Khớp Gối (Knee)</option>
                        <option value="Chan" style="color: #fff;">Khớp Cổ chân (Ankle)</option>
                        <option value="Chan" style="color: #fff;">Bàn chân & Ngón chân (Foot & Toes)</option>
                    </optgroup>
                </select>
                <small style="color: #666; display: block; margin-top: 10px; font-style: italic; font-size: 12px;">
                    * Hệ thống sẽ tự động điều chỉnh giáo án dựa trên lựa chọn này.
                </small>
            </div>

            <div class="actions" style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 35px;">
                <button class="btn secondary close-btn" type="button" style="padding: 10px 22px; border-radius: 4px; border: 1px solid #444; background: transparent; color: #888; cursor: pointer; text-transform: uppercase; font-size: 12px; font-weight: 600; transition: 0.3s;">Hủy bỏ</button>
                <button class="btn" type="submit" style="padding: 10px 22px; border-radius: 4px; border: none; background: #ff4d4d; color: #fff; font-weight: 700; cursor: pointer; text-transform: uppercase; font-size: 12px; box-shadow: 0 4px 15px rgba(255, 77, 77, 0.3); transition: 0.3s;">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<style>
    .rearrange-bar {
        position: fixed;
        bottom: -100px; /* Ẩn đi mặc định */
        left: 0;
        width: 100%;
        background: rgba(20, 20, 20, 0.95);
        backdrop-filter: blur(15px);
        border-top: 2px solid #ff4d4d;
        padding: 20px 0;
        z-index: 9999;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        box-shadow: 0 -10px 30px rgba(0,0,0,0.5);
    }

    .rearrange-bar.active {
        bottom: 0; /* Hiện lên */
    }

    .bar-info { font-weight: 600; font-size: 0.9rem; color: #eee; }

    .btn-save-rearrange {
        background: #ff4d4d;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 4px;
        font-weight: 800;
        margin-left: 15px;
        cursor: pointer;
        text-transform: uppercase;
    }

    .btn-cancel-rearrange {
        background: transparent;
        color: #888;
        border: 1px solid #444;
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
        text-transform: uppercase;
    }

    body.rearrange-mode-active {
        padding-bottom: 100px;
    }
</style>

<div id="rearrange-action-bar" class="rearrange-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="bar-info">
            <i class="fas fa-info-circle me-2"></i>
            <span>Đang ở chế độ dời lịch. Kéo thả các buổi tập để thay đổi.</span>
        </div>
        <div class="bar-buttons">
            <button class="btn-cancel-rearrange" onclick="cancelRearrange()">
                Hủy bỏ thay đổi
            </button>
            <button class="btn-save-rearrange" onclick="confirmSave()">
                <i class="fas fa-check-circle me-2"></i> XÁC NHẬN LƯU
            </button>
        </div>
    </div>
</div>

<script>
    function toggleDropdown(btn, e) {
    // Ngăn chặn sự kiện click lan ra ngoài (giúp menu không bị đóng ngay khi vừa mở)
    e.stopPropagation();

    const container = btn.closest('.workout-options');
    const dropdown = container.querySelector('.options-dropdown');

    // Đóng tất cả các menu khác đang mở trên trang
    document.querySelectorAll('.options-dropdown').forEach(el => {
        if (el !== dropdown) el.classList.remove('show');
    });

    // Bật/Tắt menu hiện tại
    dropdown.classList.toggle('show');
    }

    // Lắng nghe cú click trên toàn bộ màn hình
    window.addEventListener('click', function(e) {
        // Tìm tất và đóng tất cả dropdown nếu cú click không nằm trong menu
        document.querySelectorAll('.options-dropdown').forEach(dropdown => {
            // Nếu menu đang mở VÀ vị trí bấm KHÔNG nằm trong menu đó
            if (dropdown.classList.contains('show') && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });
    });

    // Hàm mở Modal
    function openInjuryModal() {
        // 1. Đóng tất cả các dropdown đang mở
        document.querySelectorAll('.options-dropdown').forEach(el => {
            el.classList.remove('show');
        });

        // 2. Mở Modal chấn thương
        const modal = document.getElementById('injuryModal');
        if (modal) {
            modal.style.display = 'block';
        }
    }

    // Hàm mở Modal (Gọi từ menu 3 chấm)
    function openInjuryModal() {
        document.querySelectorAll('.options-dropdown').forEach(el => el.classList.remove('show'));
        const modal = document.getElementById('injuryModal');
        if (modal) modal.style.display = 'flex'; // Dùng flex để căn giữa nếu bạn đã sửa CSS
    }

    // Gom tất cả sự kiện Click vào đây để tránh ghi đè
    window.addEventListener('click', function(event) {
        const modal = document.getElementById('injuryModal');
        const dropdowns = document.querySelectorAll('.options-dropdown');


        // Đóng Modal khi click ra ngoài vùng nội dung
        if (event.target === modal) {
            modal.style.display = "none";
        }

        // Đóng Dropdown khi click ra ngoài
        dropdowns.forEach(dropdown => {
            if (dropdown.classList.contains('show') && !dropdown.contains(event.target) && !event.target.closest('.options-btn')) {
                dropdown.classList.remove('show');
            }
        });
    });

    // Đóng Modal bằng nút
    document.querySelectorAll('.close-modal, .close-btn').forEach(btn => {
        btn.onclick = function() {
            document.getElementById('injuryModal').style.display = 'none';
        }
    });

    // Xử lý Submit Form
    document.getElementById('injuryForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        const selectedValue = formData.get('jointIssues');
        const userIdServlet = <%= request.getAttribute("userIdServlet") != null ? request.getAttribute("userIdServlet") : 0 %>;

        // KIỂM TRA QUAN TRỌNG: userIdServlet phải có giá trị
        if (typeof userIdServlet === 'undefined' || userIdServlet === null) {
            console.error("Biến userIdServlet chưa được định nghĩa!");
            alert("Lỗi hệ thống: Không tìm thấy ID người dùng.");
            return;
        }

        fetch('MyTrainingDay', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                'action': 'updateInjury',
                'jointIssues': selectedValue,
                'userId': userIdServlet
            })
        })
        .then(response => {
            if (response.ok) {
                // 1. Đóng modal
                const modal = document.getElementById('injuryModal');
                if (modal) modal.style.display = 'none';

                // 2. Lưu trạng thái "vừa cập nhật xong" vào trình duyệt
                sessionStorage.setItem('updateSuccess', 'true');

                // 3. Reload trang ngay lập tức
                location.reload();
            } else {
                Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Không thể lưu.' });
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("Lỗi kết nối mạng!");
        });
    });

    //Hiện thông báo cập nhật chấn thương
    window.addEventListener('load', function() {
        if (sessionStorage.getItem('updateSuccess') === 'true') {

            const Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
                background: '#121212', // Đen sâu hơn
                color: '#ffffff',
                iconColor: '#ff4d4d',
                customClass: {
                    popup: 'my-success-toast' // Áp dụng CSS ở trên
                },
                // Hiệu ứng xuất hiện/biến mất cực mượt
                showClass: {
                    popup: 'animate__animated animate__fadeInRight'
                },
                hideClass: {
                    popup: 'animate__animated animate__fadeOutRight'
                }
            });

            Toast.fire({
                icon: 'success',
                title: '<span style="font-weight:700; text-transform:uppercase; letter-spacing:1px;">Đã cập nhật!</span>',
                html: '<span style="font-size:13px; color:#bbb;">Hệ thống đã ghi nhận tình trạng mới.</span>'
            });

            sessionStorage.removeItem('updateSuccess');
        }
    });
    //Hiện thông báo cập nhật chấn thương
</script>

<script>
    let pendingUpdateData = [];
    let originalHTML = "";
    let activeWeekContainer = null;

    // 1. Khởi tạo Sortable
    function initSortable(container) {
        if (typeof Sortable !== 'undefined') {
            if (container.sortable) container.sortable.destroy();

            container.sortable = new Sortable(container, {
                animation: 250,
                draggable: ".col",
                ghostClass: "sortable-ghost",
                onStart: function() { document.body.style.cursor = 'grabbing'; },
                onEnd: function (evt) {
                    document.body.style.cursor = 'default';
                    const cards = container.querySelectorAll('[data-id]');
                    // Lấy lại danh sách ID theo thứ tự mới trên giao diện
                    pendingUpdateData = Array.from(cards).map((card, index) => ({
                        id: card.getAttribute('data-id'),
                        newPosition: index // 0 đến 6
                    }));
                }
            });
        }
    }

    // 2. Bật chế độ dời lịch
    function enableRearrangeMode(event, dayIndex) {
        const clickedEl = event.currentTarget || event.target;
        const dropdown = clickedEl.closest('.options-dropdown');
        if (dropdown) dropdown.classList.remove('show');

        const weekContainer = clickedEl.closest('.training-week-row');
        if (!weekContainer) return;

        if (weekContainer.classList.contains('rearrange-active')) return;

        // Lưu trạng thái gốc để Hủy
        activeWeekContainer = weekContainer;
        originalHTML = weekContainer.innerHTML;

        document.getElementById('rearrange-action-bar').classList.add('active');
        weekContainer.classList.add('rearrange-active');

        // Highlight ô được chọn
        const allCols = weekContainer.querySelectorAll('.col');
        let localIndex = (dayIndex - 1) % 7;
        allCols.forEach((col, idx) => {
            const card = col.querySelector('[data-id]');
            if (card) {
                card.classList.remove('selected-to-move');
                if (idx === localIndex) card.classList.add('selected-to-move');
            }
        });

        initSortable(weekContainer);
        weekContainer.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }

    // 3. Hàm Hủy (Reset DOM)
    function cancelRearrange() {
        if (activeWeekContainer && originalHTML !== "") {
            activeWeekContainer.innerHTML = originalHTML;
            if (activeWeekContainer.sortable) {
                activeWeekContainer.sortable.destroy();
                activeWeekContainer.sortable = null;
            }
            finishRearrange();

            // Reset dữ liệu
            originalHTML = "";
            activeWeekContainer = null;
            pendingUpdateData = [];

            Swal.fire({
                toast: true,
                position: 'top-end',
                icon: 'info',
                title: 'Đã hủy thay đổi',
                showConfirmButton: false,
                timer: 1500,
                background: '#1a1a1a',
                color: '#fff'
            });
        }
    }

    // 4. Đóng thanh công cụ
    function finishRearrange() {
        const actionBar = document.getElementById('rearrange-action-bar');
        if (actionBar) actionBar.classList.remove('active');
        document.querySelectorAll('.training-week-row').forEach(row => {
            row.classList.remove('rearrange-active');
        });
    }

    // 5. Xác nhận lưu
    function confirmSave() {
        if (pendingUpdateData.length === 0) {
            Swal.fire({
                icon: 'info',
                title: 'Chưa có thay đổi nào',
                background: '#1a1a1a',
                color: '#fff',
                confirmButtonColor: '#ff4d4d'
            }).then(() => {
                cancelRearrange();
            });
            return;
        }

        Swal.fire({
            title: 'ĐANG CẬP NHẬT...',
            html: 'Vui lòng chờ trong giây lát',
            allowOutsideClick: false,
            didOpen: () => { Swal.showLoading(); },
            background: '#1a1a1a',
            color: '#fff'
        });

        saveToDatabase(pendingUpdateData);
    }

    // 6. Gửi dữ liệu về Servlet
    function saveToDatabase(data) {
        // Chú ý: Đảm bảo biến Java userIdServlet được truyền đúng vào đây
        const userId = <%= request.getAttribute("userIdServlet") != null ? request.getAttribute("userIdServlet") : 0 %>;
        const userScheduleId = <%= userScheduleId %>;

        fetch('MyTrainingDay', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                action: 'updateSchedule',
                userId: userId,
                newSchedule: data,
                userScheduleId: userScheduleId
            })
        })
        .then(res => res.json())
        .then(resData => {
            if(resData.status === 'success') {
                Swal.fire({
                    icon: 'success',
                    title: 'THÀNH CÔNG!',
                    timer: 1500,
                    showConfirmButton: false,
                    background: '#1a1a1a',
                    color: '#fff'
                });
                setTimeout(() => { location.reload(); }, 1500);
            } else {
                throw new Error();
            }
        })
        .catch(err => {
            Swal.fire({
                icon: 'error',
                title: 'THẤT BẠI',
                text: 'Lỗi kết nối server!',
                background: '#1a1a1a',
                color: '#fff'
            });
        });
    }
</script>
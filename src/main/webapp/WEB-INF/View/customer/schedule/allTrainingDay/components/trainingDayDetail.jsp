<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.time.LocalDate,java.time.format.DateTimeFormatter" %>
<%@ page import="model.training.TrainingDay" %>
<%@ page isELIgnored="false" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%
        // Fix lỗi Generics bằng cách thêm khoảng trắng sau dấu <
        List< TrainingDay> trainingDayList = (List) request.getAttribute("trainingDayList");
        //LocalDate today = LocalDate.now();
        LocalDate today = LocalDate.of(2026, 2, 26);
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM");

        String[] dayNames = {
        "Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"
        };
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
        width: 170px;
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

</style>

<div class="container-fluid py-10 bg-black">
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

<div class="row g-3 row-cols-1 row-cols-md-3 row-cols-lg-4 row-cols-xl-7">
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
    int dIdx = td.getDayIndex() % 7;
    String textDanger = "text-danger";
    String empty = "";
    %>
    <div class="col">
        <div class="<%= sClass %>" style="position: relative;">

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
                        <button class="options-btn" onclick="toggleDropdown(this)" type="button">
                            <i class="fas fa-ellipsis-v" style="font-size: 0.9rem; opacity: 0.7;"></i>
                        </button>

                        <div class="options-dropdown">
                            <div class="dropdown-header">Thao tác</div>
                            <a href="#" class="dropdown-item"><i class="fas fa-calendar-alt"></i> Dời lịch tập</a>
                            <a href="#" class="dropdown-item"><i class="fas fa-sync-alt"></i> Đổi bài tập</a>
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
<div class="text-center py-5 noSchedule">
    Không có lịch tập hiện khả dụng.
</div>
<%
}
%>
</div>

<script>
    function toggleDropdown(btn) {
    // Tìm dropdown nằm trong cùng một container với cái nút vừa bấm
    const container = btn.closest('.workout-options');
    const dropdown = container.querySelector('.options-dropdown');

    // Đóng tất cả các dropdown khác đang mở trên màn hình
    document.querySelectorAll('.options-dropdown').forEach(el => {
    if (el !== dropdown) el.classList.remove('show');
    });

    // Bật/Tắt menu hiện tại
    dropdown.classList.toggle('show');
    }

    // Click ra ngoài thì đóng menu
    window.onclick = function(event) {
    // Nếu click không phải vào nút 3 chấm hoặc icon bên trong nút đó
    if (!event.target.closest('.options-btn')) {
    document.querySelectorAll('.options-dropdown').forEach(el => {
    el.classList.remove('show');
    });
    }
    }
</script>
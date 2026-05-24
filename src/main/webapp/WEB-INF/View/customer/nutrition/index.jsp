<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ultra AI Nutrition - SMART PT</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800;900&family=Share+Tech+Mono&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        :root {
            --bg-main: #000000;
            --bg-panel: #111111;
            --border-color: #222222;
            --accent-red: #ff003c;
            --accent-cyan: #00f0ff;
            --text-main: #f0f0f0;
            --text-muted: #888;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-main) !important;
            color: var(--text-main) !important;
            margin: 0;
            padding: 0;
        }

        .nutrition-wrapper {
            background-color: var(--bg-main);
            min-height: 100vh;
            color: var(--text-main);
        }

        /* Override bootstrap text-muted for dark mode */
        .text-muted {
            color: #aaaaaa !important;
        }
        
        .tech-font {
            font-family: 'Share Tech Mono', monospace;
            text-transform: uppercase;
        }

        .header-title {
            font-weight: 900;
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        /* Panels */
        .cyber-panel {
            background-color: var(--bg-panel);
            border: 1px solid var(--border-color);
            padding: 20px;
            position: relative;
            margin-bottom: 20px;
        }

        .panel-title {
            font-weight: 900;
            font-size: 1.1rem;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .status-badge {
            font-size: 0.7rem;
            padding: 3px 8px;
            border: 1px solid var(--accent-red);
            color: var(--accent-red);
            border-radius: 4px;
            margin-left: auto;
        }

        /* Vision Scanner Container */
        .scanner-container {
            position: relative;
            width: 100%;
            height: 400px;
            background-color: #0a0a0a;
            border: 1px solid var(--border-color);
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .scanner-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            opacity: 0.6;
            transition: opacity 0.3s;
        }

        /* Cyber Corners */
        .scanner-container::before, .scanner-container::after {
            content: '';
            position: absolute;
            width: 30px; height: 30px;
            border-color: var(--accent-red);
            border-style: solid;
            z-index: 10;
        }
        .scanner-container::before { top: 10px; left: 10px; border-width: 2px 0 0 2px; }
        .scanner-container::after { bottom: 10px; right: 10px; border-width: 0 2px 2px 0; }

        /* The Laser Line */
        .laser-line {
            position: absolute;
            left: 0; right: 0; top: 0;
            height: 2px;
            background: var(--accent-red);
            box-shadow: 0 0 15px 3px rgba(255, 0, 60, 0.7);
            display: none;
            z-index: 20;
        }

        .scanning .laser-line {
            display: block;
            animation: scan 2s linear infinite alternate;
        }

        .scanning img {
            opacity: 1;
        }

        @keyframes scan {
            0% { top: 0%; }
            100% { top: 100%; }
        }

        .accuracy-box {
            position: absolute;
            bottom: 20px; left: 20px;
            border: 1px solid var(--accent-cyan);
            background: rgba(0,0,0,0.7);
            padding: 5px 10px;
            z-index: 15;
            display: none;
        }
        .accuracy-box .title { font-size: 0.6rem; color: var(--accent-cyan); }
        .accuracy-box .value { font-size: 1.5rem; font-weight: 900; color: #fff; }

        /* Input Controls */
        .input-group-cyber {
            display: flex;
            background: #222;
            border: 1px solid var(--border-color);
            padding: 5px;
        }
        .input-group-cyber input[type="text"] {
            background: transparent;
            border: none;
            color: white;
            flex-grow: 1;
            padding: 10px;
            outline: none;
        }
        .btn-cyber {
            background: transparent;
            border: 1px solid var(--border-color);
            color: white;
            width: 45px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: 0.3s;
        }
        .btn-cyber:hover { background: #333; }
        .btn-cyber-primary {
            background: var(--accent-red);
            border-color: var(--accent-red);
            font-weight: 900;
        }
        .btn-cyber-primary:hover { background: #d00030; }

        /* Detection List */
        .detected-item {
            display: flex; justify-content: space-between;
            padding: 12px;
            border: 1px solid var(--border-color);
            margin-bottom: 8px;
            background: #111;
        }
        .detected-item .name { font-weight: 600; }
        .detected-item .weight { color: var(--accent-cyan); font-weight: 900; }

        /* Macro Stats */
        .macro-row {
            display: flex; justify-content: space-between; text-align: center;
            margin: 20px 0;
        }
        .macro-col { flex: 1; border-right: 1px solid var(--border-color); }
        .macro-col:last-child { border-right: none; }
        .macro-val { font-size: 1.8rem; font-weight: 900; margin-bottom: 5px; }
        .macro-label { font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase; }

        /* Insight Box */
        .insight-box {
            border-left: 3px solid var(--accent-red);
            background: rgba(255, 0, 60, 0.05);
            padding: 15px;
            margin-top: 20px;
            font-size: 0.9rem;
            font-style: italic;
        }

        /* Right Panel Mocks */
        .progress-cyber {
            height: 6px; background: #333; margin: 10px 0;
        }
        .progress-bar-cyber {
            height: 100%; background: #ff5e00; width: 0%;
        }
        .insight-item {
            display: flex; gap: 15px; margin-bottom: 20px;
        }
        .insight-item i { color: var(--accent-red); font-size: 1.2rem; }
        
        .circle-progress-container {
            display: flex; justify-content: space-around;
            padding: 20px; background: var(--bg-panel); border: 1px solid var(--border-color);
        }

        /* Suggestion Box */
        .suggestion-box {
            display: flex; background: #111; border: 1px solid var(--border-color); padding: 15px; gap: 15px; margin-top: 20px;
            align-items: center;
        }
        .suggestion-img {
            width: 120px; height: 120px; object-fit: cover; border-radius: 8px; border: 1px solid var(--accent-cyan);
        }
        .suggestion-content { flex: 1; }
        .btn-suggest {
            background: transparent; border: 1px solid var(--accent-cyan); color: var(--accent-cyan);
            padding: 8px 15px; text-transform: uppercase; font-size: 0.8rem; letter-spacing: 1px; transition: 0.3s;
        }
        .btn-suggest:hover { background: var(--accent-cyan); color: #000; }

    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/View/customer/homePage/components/header.jsp"/>

    <div class="nutrition-wrapper">
        <div class="container-fluid px-md-5 py-4">
            
            <!-- Header -->
            <div class="mb-4">
                <h1 class="header-title text-white">Trung tâm dinh dưỡng Ultra AI</h1>
                <p>Phân tích thực phẩm bằng thị giác máy tính thế hệ mới.</p>
            </div>

        <% if (request.getAttribute("isPro") != null && (Boolean) request.getAttribute("isPro")) { %>
        <div class="row">
            <!-- LEFT COLUMN: AI VISION SCANNER -->
            <div class="col-lg-7">
                <div class="cyber-panel">
                    <div class="panel-title text-danger">
                        <i class="fa-solid fa-eye"></i> AI VISION SCANNER V4.0
                        <span class="status-badge tech-font" id="scanStatus">[ STANDBY ]</span>
                    </div>

                    <!-- Scanner Box -->
                    <div class="scanner-container" id="scannerBox">
                        <button id="btnClearImage" class="btn btn-sm btn-danger position-absolute" style="top: 10px; right: 10px; z-index: 30; display: none;" onclick="clearImage()" title="Xóa ảnh">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                        <div class="laser-line"></div>
                        <img id="foodImagePreview" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22600%22%20height%3D%22400%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20600%20400%22%20preserveAspectRatio%3D%22none%22%3E%3Crect%20width%3D%22600%22%20height%3D%22400%22%20fill%3D%22%230a0a0a%22%2F%3E%3Ctext%20x%3D%22300%22%20y%3D%22200%22%20fill%3D%22%23333333%22%20font-family%3D%22sans-serif%22%20font-size%3D%2220%22%20font-weight%3D%22bold%22%20text-anchor%3D%22middle%22%3EUPLOAD%20IMAGE%20TO%20SCAN%3C%2Ftext%3E%3C%2Fsvg%3E" alt="Food Scan">
                        
                        <div class="accuracy-box" id="accuracyBox">
                            <div class="title tech-font">ĐỘ CHÍNH XÁC NHẬN DIỆN</div>
                            <div class="value tech-font">98% <span style="font-size:0.8rem; color:var(--accent-red)">HIGH</span></div>
                        </div>
                        <div class="position-absolute bottom-0 w-100 text-center pb-1" style="font-size: 0.65rem; color: var(--accent-red); background: rgba(0,0,0,0.6); z-index: 15;">
                            *Lưu ý: Phân tích ảnh có thể không chính xác đối với nguyên liệu bị ẩn bên trong.
                        </div>
                    </div>

                    <!-- Input Controls -->
                    <div class="input-group-cyber mb-4">
                        <input type="text" id="foodInput" placeholder="Hoặc nhập chữ/ghi âm: 1 tô phở bò...">
                        <button class="btn-cyber" id="btnVoice" title="Ghi âm"><i class="fa-solid fa-microphone"></i></button>
                        <button class="btn-cyber" onclick="document.getElementById('imageInput').click()" title="Chọn ảnh"><i class="fa-solid fa-image"></i></button>
                        <input type="file" id="imageInput" accept="image/*" style="display: none;" onchange="previewImage(event)">
                        <button class="btn-cyber btn-cyber-primary" style="width: 80px;" onclick="analyzeFood()"><i class="fa-solid fa-bolt"></i></button>
                    </div>

                    <div id="aiResults" style="display: none; animation: fadeIn 0.5s;">
                        <!-- AI DETECTED -->
                        <div class="tech-font mb-2" style="font-size: 0.8rem;">■ AI DETECTED</div>
                        <div id="detectedFoodsList">
                            <!-- JS will populate this -->
                        </div>

                        <!-- NUTRITION ANALYSIS -->
                        <div class="tech-font mb-2 mt-4" style="font-size: 0.8rem;">■ NUTRITION ANALYSIS</div>
                        <div class="macro-row tech-font">
                            <div class="macro-col">
                                <div class="macro-val" id="resCalories">0</div>
                                <div class="macro-label">KCAL</div>
                            </div>
                            <div class="macro-col">
                                <div class="macro-val" id="resProtein">0<span style="font-size:1rem">g</span></div>
                                <div class="macro-label">PROTEIN</div>
                            </div>
                            <div class="macro-col">
                                <div class="macro-val" id="resCarbs">0<span style="font-size:1rem">g</span></div>
                                <div class="macro-label">CARBS</div>
                            </div>
                            <div class="macro-col">
                                <div class="macro-val" id="resFat">0<span style="font-size:1rem">g</span></div>
                                <div class="macro-label">FATS</div>
                            </div>
                        </div>

                        <!-- AI INSIGHT -->
                        <div class="insight-box">
                            <div class="text-danger mb-1 fw-bold"><i class="fa-solid fa-fingerprint"></i> AI INSIGHT</div>
                            <div id="resInsight" style="color: #ddd;">"Đang chờ phân tích..."</div>
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <button class="btn w-100 fw-bold py-3 rounded-0 text-white" id="btnEaten" style="background-color: var(--accent-red); border:none; transition: 0.3s;" onclick="markAsEaten()">
                                <i class="fa-solid fa-utensils me-2"></i> BẠN ĐÃ ĂN CHƯA?
                            </button>
                            <button class="btn fw-bold py-3 rounded-0 text-white" id="btnUndoEaten" style="background-color: #555; border:none; transition: 0.3s; display: none; width: 60px;" onclick="undoEaten()" title="Xóa món ăn vừa lưu">
                                <i class="fa-solid fa-rotate-left"></i>
                            </button>
                        </div>
                        <div id="eatWarning" class="text-danger tech-font mt-2 text-center fw-bold" style="display: none; font-size: 0.9rem;">
                            <i class="fa-solid fa-triangle-exclamation"></i> CẢNH BÁO: VƯỢT QUÁ LƯỢNG CALO CẦN NẠP!
                        </div>
                    </div>
                </div>
            </div>

            <!-- RIGHT COLUMN: DASHBOARD MOCKS -->
            <div class="col-lg-5">
                <!-- TỔNG QUAN HÔM NAY -->
                <div class="cyber-panel">
                    <div class="panel-title text-info d-flex align-items-center mb-4">
                        <i class="fa-solid fa-chart-simple me-2"></i> TỔNG QUAN HÔM NAY
                        <div class="ms-auto d-flex gap-2">
                            <select id="mealTimeSelect" class="form-select form-select-sm text-white tech-font" style="background-color: #111; border: 1px solid var(--accent-cyan); width: 100px;">
                                <option value="Sáng">Sáng</option>
                                <option value="Trưa">Trưa</option>
                                <option value="Chiều">Chiều</option>
                                <option value="Tối">Tối</option>
                                <option value="Ăn Vặt">Ăn Vặt</option>
                            </select>
                            <button class="btn btn-sm tech-font text-warning" style="border: 1px solid var(--accent-cyan); background: transparent; white-space: nowrap;" onclick="openSavedMealsModal()">
                                <i class="fa-solid fa-bookmark"></i> ĐÃ LƯU
                            </button>
                            <button class="btn btn-sm tech-font text-info" style="border: 1px solid var(--border-color); background: transparent; white-space: nowrap;" onclick="openHistoryModal()">
                                <i class="fa-solid fa-list-ul"></i> LỊCH SỬ
                            </button>
                        </div>
                    </div>

                    <div class="d-flex align-items-baseline mb-1">
                        <h2 class="fw-bold mb-0 me-2" style="font-size:2.5rem;" id="currentCaloriesDisplay">0</h2>
                        <span>/ <%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %> KCAL</span>
                    </div>
                    <div class="progress-cyber">
                        <div class="progress-bar-cyber" id="mainProgressBar"></div>
                    </div>
                    <div class="d-flex justify-content-between tech-font text-muted mt-1" style="font-size: 0.7rem;">
                        <span class="text-info" id="remainingCaloriesDisplay">CÒN LẠI <%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %> KCAL</span>
                        <span id="percentGoalDisplay">0% MỤC TIÊU</span>
                    </div>
                    <div id="exceedWarningBox" class="text-danger fw-bold tech-font text-center mt-2" style="display: none; font-size: 0.85rem; padding: 5px; border: 1px dashed var(--accent-red); background-color: rgba(249, 6, 6, 0.1);">
                        <i class="fa-solid fa-triangle-exclamation"></i> VƯỢT QUÁ LƯỢNG CALO MỤC TIÊU!
                    </div>

                    <div class="row mt-4">
                        <div class="col-6">
                            <div class="border border-secondary p-3 text-center">
                                <div style="font-size:0.7rem">PROTEIN</div>
                                <div class="fw-bold text-danger fs-4">140g</div>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="border border-secondary p-3 text-center">
                                <div style="font-size:0.7rem">NƯỚC</div>
                                <div class="fw-bold text-info fs-4">1.2L</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- AI DAILY INSIGHT -->
                <div class="cyber-panel">
                    <div class="panel-title text-info">
                        <i class="fa-solid fa-circle-info"></i> AI DAILY INSIGHT
                    </div>
                    
                    <div class="insight-item">
                        <i class="fa-solid fa-triangle-exclamation"></i>
                        <div>
                            <div class="fw-bold text-white" style="font-size:0.9rem;">CHỈ SỐ CHẤT XƠ THẤP</div>
                            <div style="font-size:0.8rem;">Bạn chỉ mới đạt 40% mục tiêu chất xơ hôm nay. Hãy thêm rau xanh vào bữa tiếp theo.</div>
                        </div>
                    </div>

                    <div class="insight-item">
                        <i class="fa-solid fa-droplet text-info"></i>
                        <div>
                            <div class="fw-bold text-white" style="font-size:0.9rem;">UỐNG THÊM NƯỚC</div>
                            <div style="font-size:0.8rem;">Dữ liệu cho thấy bạn chưa uống nước trong 3 giờ qua. Cơ thể cần thêm 800ml để tối ưu trao đổi chất.</div>
                        </div>
                    </div>

                    <div class="text-center tech-font text-info mt-4" style="font-size:0.7rem;">
                        [ SYSTEM MONITORING ACTIVE ]
                    </div>
                </div>

                <!-- GỢI Ý THỰC ĐƠN AI -->
                <div class="cyber-panel mt-4">
                    <div class="panel-title text-warning">
                        <i class="fa-solid fa-utensils"></i> GỢI Ý THỰC ĐƠN AI
                        <button class="btn-suggest ms-auto tech-font" onclick="suggestMeal()" id="btnSuggest">
                            <i class="fa-solid fa-rotate"></i> NHẬN GỢI Ý MỚI
                        </button>
                    </div>

                    <div id="suggestLoading" style="display: none; text-align: center; padding: 20px;">
                        <i class="fa-solid fa-circle-notch fa-spin text-warning fs-3 mb-2"></i>
                        <div class="tech-font text-warning" style="font-size: 0.8rem;">ĐANG TẠO THỰC ĐƠN...</div>
                    </div>

                    <div id="suggestBoxContainer" style="display: none; margin-top: 20px;">
                        <!-- JS sẽ đổ danh sách món ăn vào đây -->
                    </div>
                    
                    <div id="suggestPrompt" style="font-size: 0.9rem;">
                        Bấm "Nhận gợi ý mới" để AI tính toán thực đơn dựa trên mục tiêu tập luyện của bạn.
                    </div>
                </div>
            </div>
        </div>
        <% } else { %>
        <!-- MÀN HÌNH KHÓA PAYWALL -->
        <div class="row justify-content-center text-center mt-5">
            <div class="col-md-8">
                <div class="cyber-panel py-5" style="border-color: var(--accent-red); box-shadow: 0 0 20px rgba(255,0,0,0.2);">
                    <i class="fa-solid fa-lock text-danger mb-4" style="font-size: 5rem; text-shadow: 0 0 15px rgba(255,0,0,0.5);"></i>
                    <h2 style="letter-spacing: 2px;">TÍNH NĂNG ĐỘC QUYỀN GÓI PRO</h2>
                    <p style="font-size: 1.1rem; line-height: 1.6;">Bạn cần nâng cấp lên Gói PRO để sử dụng Trợ lý AI Dinh Dưỡng, Quét Thực Phẩm Bằng Thị Giác Máy Tính và Tự Động Thiết Kế Thực Đơn.</p>
                    <a href="<%= request.getContextPath() %>/package" class="btn btn-danger btn-lg px-5 fw-bold" style="letter-spacing: 2px; text-transform: uppercase;">
                        <i class="fa-solid fa-bolt me-2"></i>NÂNG CẤP NGAY
                    </a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
    </div>

    <!-- Recipe Modal -->
    <div class="modal fade" id="recipeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="background-color: var(--bg-panel); border: 1px solid var(--accent-cyan); color: var(--text-main);">
                <div class="modal-header border-bottom border-secondary">
                    <h5 class="modal-title tech-font" id="recipeModalTitle" style="color: var(--accent-cyan);">CÁCH LÀM</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="recipeModalBody" style="white-space: pre-line; line-height: 1.6;"></div>
                </div>
            </div>
        </div>
    </div>

    <!-- History Modal -->
    <div class="modal fade" id="historyModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="background-color: var(--bg-panel); border: 1px solid var(--accent-red); color: var(--text-main);">
                <div class="modal-header border-bottom border-secondary">
                    <h5 class="modal-title tech-font text-danger" style="color: var(--accent-red);">LỊCH SỬ ĂN UỐNG HÔM NAY</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="historyListContainer">
                        <!-- History items will be inserted here -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Saved Meals Modal -->
    <div class="modal fade" id="savedMealsModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content" style="background-color: var(--bg-panel); border: 1px solid var(--accent-cyan); color: var(--text-main);">
                <div class="modal-header border-bottom border-secondary">
                    <h5 class="modal-title tech-font text-warning"><i class="fa-solid fa-bookmark"></i> MỤC ĐÃ LƯU</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="savedMealsListContainer">
                        <!-- Saved items will be inserted here -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Error Notification Toast -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1050">
        <div id="errorToast" class="toast border border-danger" role="alert" aria-live="assertive" aria-atomic="true" style="background-color: #111; color: #fff;">
            <div class="toast-header border-bottom border-danger" style="background-color: #222; color: var(--accent-red);">
                <i class="fa-solid fa-triangle-exclamation me-2"></i>
                <strong class="me-auto" style="font-family: 'Share Tech Mono', monospace, sans-serif;">HỆ THỐNG CẢNH BÁO</strong>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body fw-bold text-danger" id="errorToastMessage">
                <!-- Message will be populated by JS -->
            </div>
        </div>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        
        // Daily Reset Logic is now handled by the backend (only returns today's history)
        let currentAnalyzedCalories = 0;
        let dailyHistory = [];
        let savedMeals = [];
        let suggestedMealsList = [];
        let historyModalInstance = null;
        let savedMealsModalInstance = null;
        let recipeModalInstance = null;

        document.addEventListener('DOMContentLoaded', () => {
            fetchData();
            
            // Handle Modal Overlays
            document.getElementById('recipeModal').addEventListener('hidden.bs.modal', function () {
                if (document.body.getAttribute('data-recipe-source') === 'savedMeals') {
                    if (savedMealsModalInstance) savedMealsModalInstance.show();
                    document.body.removeAttribute('data-recipe-source');
                }
            });
        });

        async function fetchData() {
            try {
                const resHist = await fetch(contextPath + '/nutrition-data?type=history');
                const dataHist = await resHist.json();
                if (dataHist.status === 'success') dailyHistory = dataHist.data;

                const resSaved = await fetch(contextPath + '/nutrition-data?type=saved');
                const dataSaved = await resSaved.json();
                if (dataSaved.status === 'success') savedMeals = dataSaved.data;

                recalculateTotal();
            } catch (e) { console.error("Error fetching data", e); }
        }

        function showErrorToast(msg) {
            document.getElementById('errorToastMessage').innerText = msg;
            if (typeof bootstrap !== 'undefined') {
                const toast = new bootstrap.Toast(document.getElementById('errorToast'), { delay: 5000 });
                toast.show();
            } else {
                document.getElementById('errorToast').style.display = 'block';
                setTimeout(() => { document.getElementById('errorToast').style.display = 'none'; }, 5000);
            }
        }

        function recalculateTotal() {
            let total = 0;
            dailyHistory.forEach(item => total += parseFloat(item.calories));
            document.getElementById('currentCaloriesDisplay').innerText = Math.round(total);
            updateProgressUI(total);
        }

        function renderHistoryList() {
            const container = document.getElementById('historyListContainer');
            if (dailyHistory.length === 0) {
                container.innerHTML = '<div class="text-center text-muted p-4">Chưa có món ăn nào được lưu hôm nay.</div>';
            } else {
                container.innerHTML = dailyHistory.map(item => `
                    <div class="d-flex justify-content-between align-items-center mb-2 p-3 rounded" style="background: #111; border: 1px solid var(--border-color);">
                        <div>
                            <div class="fw-bold text-white">
                                <span class="badge" style="background-color: var(--accent-cyan); color: #000; margin-right: 5px;">${item.mealTime || 'Khác'}</span> 
                                ${item.mealName}
                            </div>
                            <div class="text-info tech-font mt-1" style="font-size: 0.9rem;">${item.calories} kcal</div>
                        </div>
                        <button class="btn btn-sm btn-outline-danger" onclick="deleteHistoryItem(${item.id})"><i class="fa-solid fa-trash"></i></button>
                    </div>
                `).join('');
            }
        }

        function openHistoryModal() {
            renderHistoryList();
            if(typeof bootstrap !== 'undefined') {
                if (!historyModalInstance) {
                    historyModalInstance = new bootstrap.Modal(document.getElementById('historyModal'));
                }
                historyModalInstance.show();
            } else {
                document.getElementById('historyModal').style.display = 'block';
                document.getElementById('historyModal').classList.add('show');
            }
        }
        
        async function deleteHistoryItem(id) {
            try {
                const formData = new FormData();
                formData.append('action', 'deleteHistory');
                formData.append('id', id);
                
                const res = await fetch(contextPath + '/nutrition-data', { method: 'POST', body: formData });
                const data = await res.json();
                if (data.status === 'success') {
                    const itemToDelete = dailyHistory.find(item => item.id === id);
                    dailyHistory = dailyHistory.filter(item => item.id !== id);
                    recalculateTotal();
                    renderHistoryList();
                    
                    if (document.getElementById('btnUndoEaten') && document.getElementById('btnUndoEaten').dataset.id == id) {
                        document.getElementById('btnEaten').disabled = false;
                        document.getElementById('btnEaten').innerHTML = '<i class="fa-solid fa-utensils me-2"></i> BẠN ĐÃ ĂN CHƯA?';
                        document.getElementById('btnUndoEaten').style.display = 'none';
                        document.getElementById('btnUndoEaten').dataset.id = "";
                    }

                    if (itemToDelete && itemToDelete.suggestIdx !== undefined && itemToDelete.suggestIdx !== null) {
                        const btnSuggest = document.getElementById('btnSuggestEaten_' + itemToDelete.suggestIdx);
                        if (btnSuggest) {
                            btnSuggest.innerHTML = '<i class="fa-solid fa-bookmark"></i> LƯU MÓN ĂN';
                            btnSuggest.disabled = false;
                            btnSuggest.style.background = 'var(--accent-red)';
                        }
                    }
                }
            } catch (e) { console.error(e); }
        }
        
        function renderSavedMealsList() {
            const container = document.getElementById('savedMealsListContainer');
            if (savedMeals.length === 0) {
                container.innerHTML = '<div class="text-center text-muted p-4">Chưa có món ăn nào được lưu.</div>';
            } else {
                container.innerHTML = savedMeals.map(item => `
                    <div class="d-flex align-items-center mb-2 p-3 rounded" style="background: #111; border: 1px solid var(--border-color); gap: 15px;">
                        <img src="${item.imgSrc || 'https://via.placeholder.com/60'}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 5px; border: 1px solid var(--accent-cyan);">
                        <div class="flex-grow-1">
                            <div class="fw-bold text-white">${item.mealName}</div>
                            <div class="text-info tech-font mt-1" style="font-size: 0.9rem;">${item.calories} kcal</div>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-sm btn-outline-info" onclick="openRecipeFromSaved(${item.id})" title="Cách Làm"><i class="fa-solid fa-book-open"></i></button>
                            <button class="btn btn-sm btn-danger fw-bold" onclick="markSavedMealAsEaten(${item.id})"><i class="fa-solid fa-utensils"></i> ĐÃ ĂN</button>
                            <button class="btn btn-sm btn-outline-secondary" onclick="deleteSavedMeal(${item.id})" title="Xóa"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </div>
                `).join('');
            }
        }

        function openSavedMealsModal() {
            renderSavedMealsList();
            if(typeof bootstrap !== 'undefined') {
                if (!savedMealsModalInstance) {
                    savedMealsModalInstance = new bootstrap.Modal(document.getElementById('savedMealsModal'));
                }
                savedMealsModalInstance.show();
            } else {
                document.getElementById('savedMealsModal').style.display = 'block';
                document.getElementById('savedMealsModal').classList.add('show');
            }
        }

        async function deleteSavedMeal(id) {
            try {
                const formData = new FormData();
                formData.append('action', 'deleteSaved');
                formData.append('id', id);
                
                const res = await fetch(contextPath + '/nutrition-data', { method: 'POST', body: formData });
                const data = await res.json();
                if (data.status === 'success') {
                    const itemToDelete = savedMeals.find(item => item.id === id);
                    savedMeals = savedMeals.filter(item => item.id !== id);
                    renderSavedMealsList();
                    
                    if (itemToDelete && itemToDelete.suggestIdx !== undefined && itemToDelete.suggestIdx !== null) {
                        const btnSuggest = document.getElementById('btnSuggestEaten_' + itemToDelete.suggestIdx);
                        if (btnSuggest) {
                            btnSuggest.innerHTML = '<i class="fa-solid fa-bookmark"></i> LƯU MÓN ĂN';
                            btnSuggest.disabled = false;
                            btnSuggest.style.background = 'var(--accent-red)';
                        }
                    }
                }
            } catch (e) { console.error(e); }
        }

        function openRecipeFromSaved(id) {
            const item = savedMeals.find(i => i.id === id);
            if (item) {
                document.getElementById('recipeModalTitle').innerText = (item.mealName || "CÁCH LÀM").toUpperCase();
                document.getElementById('recipeModalBody').innerText = item.recipe || "Không có hướng dẫn chi tiết cho món ăn này.";
                if(typeof bootstrap !== 'undefined') {
                    if (savedMealsModalInstance) savedMealsModalInstance.hide();
                    document.body.setAttribute('data-recipe-source', 'savedMeals');
                    
                    if (!recipeModalInstance) {
                        recipeModalInstance = new bootstrap.Modal(document.getElementById('recipeModal'));
                    }
                    recipeModalInstance.show();
                }
            }
        }

        async function markSavedMealAsEaten(id) {
            const item = savedMeals.find(i => i.id === id);
            if (!item) return;

            const targetCalories = parseFloat(<%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %>);
            const currentCaloriesTotal = parseFloat(document.getElementById('currentCaloriesDisplay').innerText) || 0;

            if (currentCaloriesTotal + parseFloat(item.calories) > targetCalories) {
                showErrorToast("Món ăn này sẽ làm bạn vượt quá lượng Calo mục tiêu! Hãy cân nhắc lại.");
                return;
            }

            const mealTime = document.getElementById('mealTimeSelect').value;
            const countSameMealTime = dailyHistory.filter(h => h.mealTime === mealTime).length;
            const limit = (mealTime === 'Ăn Vặt') ? 3 : 1;
            if (countSameMealTime >= limit) {
                showErrorToast(`Bạn đã lưu tối đa ${limit} món cho buổi ${mealTime}! Vui lòng chọn buổi khác ở TỔNG QUAN.`);
                return;
            }

            try {
                // Add to History
                const formData = new FormData();
                formData.append('action', 'addHistory');
                formData.append('mealName', item.mealName);
                formData.append('calories', item.calories);
                formData.append('mealTime', mealTime);
                if (item.suggestIdx !== undefined && item.suggestIdx !== null) {
                    formData.append('suggestIdx', item.suggestIdx);
                }
                
                const res = await fetch(contextPath + '/nutrition-data', { method: 'POST', body: formData });
                const data = await res.json();
                
                if (data.status === 'success') {
                    dailyHistory.push(data.data);
                    recalculateTotal();
                    deleteSavedMeal(id);
                }
            } catch (e) { console.error(e); }
        }
        
        function openRecipe(idx) {
            const meal = suggestedMealsList[idx];
            if (meal) {
                document.getElementById('recipeModalTitle').innerText = (meal.mealName || "CÁCH LÀM").toUpperCase();
                document.getElementById('recipeModalBody').innerText = meal.recipe || "Không có hướng dẫn chi tiết cho món ăn này.";
                if(typeof bootstrap !== 'undefined') {
                    if (!recipeModalInstance) {
                        recipeModalInstance = new bootstrap.Modal(document.getElementById('recipeModal'));
                    }
                    recipeModalInstance.show();
                } else {
                    document.getElementById('recipeModal').style.display = 'block';
                    document.getElementById('recipeModal').classList.add('show');
                }
            }
        }

        async function addSuggestedMeal(idx, btnElement, imgSrc) {
            const meal = suggestedMealsList[idx];
            if (meal) {
                try {
                    const formData = new FormData();
                    formData.append('action', 'addSaved');
                    formData.append('mealName', meal.mealName || "Món ăn gợi ý");
                    formData.append('calories', meal.calories || 0);
                    formData.append('recipe', meal.recipe || "");
                    formData.append('imgSrc', imgSrc);
                    formData.append('suggestIdx', idx);
                    
                    const res = await fetch(contextPath + '/nutrition-data', { method: 'POST', body: formData });
                    const data = await res.json();
                    
                    if (data.status === 'success') {
                        savedMeals.push(data.data);
                        
                        btnElement.innerHTML = '<i class="fa-solid fa-check"></i> ĐÃ LƯU VÀO KHO';
                        btnElement.disabled = true;
                        btnElement.classList.remove('bg-danger');
                        btnElement.style.background = '#555';
                    }
                } catch (e) { console.error(e); }
            }
        }

        // --- VOICE INPUT ---
        const btnVoice = document.getElementById('btnVoice');
        const foodInput = document.getElementById('foodInput');

        if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
            const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            const recognition = new SpeechRecognition();
            recognition.lang = 'vi-VN';
            recognition.interimResults = false;

            recognition.onstart = function() {
                btnVoice.innerHTML = '<i class="fa-solid fa-microphone text-danger fa-fade"></i>';
                foodInput.placeholder = "[ ĐANG NGHE... ]";
            };

            recognition.onresult = function(event) {
                foodInput.value = event.results[0][0].transcript;
            };

            recognition.onerror = function(event) {
                showErrorToast("Lỗi ghi âm: Vui lòng cho phép sử dụng Micro hoặc thử lại sau!");
                btnVoice.innerHTML = '<i class="fa-solid fa-microphone"></i>';
                foodInput.placeholder = "Hoặc nhập chữ/ghi âm: 1 tô phở bò...";
            };

            recognition.onend = function() {
                btnVoice.innerHTML = '<i class="fa-solid fa-microphone"></i>';
                foodInput.placeholder = "Hoặc nhập chữ/ghi âm: 1 tô phở bò...";
            };

            btnVoice.addEventListener('click', () => recognition.start());
        }

        // --- IMAGE PREVIEW ---
        let selectedFile = null;
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                selectedFile = file;
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('foodImagePreview').src = e.target.result;
                    document.getElementById('foodImagePreview').style.opacity = '1';
                    document.getElementById('btnClearImage').style.display = 'block';
                }
                reader.readAsDataURL(file);
            }
        }

        function clearImage() {
            selectedFile = null;
            document.getElementById('imageInput').value = "";
            document.getElementById('foodImagePreview').src = "data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22600%22%20height%3D%22400%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20600%20400%22%20preserveAspectRatio%3D%22none%22%3E%3Crect%20width%3D%22600%22%20height%3D%22400%22%20fill%3D%22%230a0a0a%22%2F%3E%3Ctext%20x%3D%22300%22%20y%3D%22200%22%20fill%3D%22%23333333%22%20font-family%3D%22sans-serif%22%20font-size%3D%2220%22%20font-weight%3D%22bold%22%20text-anchor%3D%22middle%22%3EUPLOAD%20IMAGE%20TO%20SCAN%3C%2Ftext%3E%3C%2Fsvg%3E";
            document.getElementById('foodImagePreview').style.opacity = '0.6';
            document.getElementById('btnClearImage').style.display = 'none';
        }

        // --- ANALYZE ---
        async function analyzeFood() {
            const textPrompt = foodInput.value.trim();
            if (!textPrompt && !selectedFile) {
                alert("Vui lòng nhập tên món hoặc chọn ảnh!");
                return;
            }

            // Start scanning animation
            const scannerBox = document.getElementById('scannerBox');
            const statusBadge = document.getElementById('scanStatus');
            
            if (selectedFile) {
                scannerBox.classList.add('scanning');
                statusBadge.innerText = "[ SCANNING DATA... ]";
            } else {
                statusBadge.innerText = "[ PROCESSING TEXT... ]";
            }
            
            statusBadge.style.color = "var(--accent-cyan)";
            statusBadge.style.borderColor = "var(--accent-cyan)";
            
            document.getElementById('aiResults').style.display = 'none';
            document.getElementById('accuracyBox').style.display = 'none';

            try {
                const formData = new FormData();
                formData.append('textPrompt', textPrompt);
                if (selectedFile) formData.append('image', selectedFile);

                const response = await fetch(contextPath + '/nutrition-ai', { method: 'POST', body: formData });

                if (response.ok) {
                    const data = await response.json(); // {foods: [{name, weight}], calories, protein, carbs, fat, insight}
                    
                    // Render detected list
                    const listContainer = document.getElementById('detectedFoodsList');
                    listContainer.innerHTML = '';
                    if (data.foods && Array.isArray(data.foods)) {
                        data.foods.forEach(f => {
                            listContainer.innerHTML += `
                                <div class="detected-item tech-font">
                                    <span class="name">${f.name}</span>
                                    <span class="weight">${f.weight}</span>
                                </div>
                            `;
                        });
                    }

                    document.getElementById('resCalories').innerText = data.calories || "0";
                    currentAnalyzedCalories = parseFloat(data.calories) || 0;
                    document.getElementById('resProtein').innerHTML = (data.protein || "0") + '<span style="font-size:1rem">g</span>';
                    document.getElementById('resCarbs').innerHTML = (data.carbs || "0") + '<span style="font-size:1rem">g</span>';
                    document.getElementById('resFat').innerHTML = (data.fat || "0") + '<span style="font-size:1rem">g</span>';
                    document.getElementById('resInsight').innerText = `"${data.insight || 'Phân tích hoàn tất.'}"`;

                    const targetCalories = parseFloat(<%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %>);
                    const currentCaloriesTotal = parseFloat(document.getElementById('currentCaloriesDisplay').innerText) || 0;
                    const remainingCalories = targetCalories - currentCaloriesTotal;
                    
                    if (currentAnalyzedCalories > remainingCalories) {
                        document.getElementById('resCalories').style.color = 'var(--accent-red)';
                        document.getElementById('eatWarning').style.display = 'block';
                    } else {
                        document.getElementById('resCalories').style.color = '';
                        document.getElementById('eatWarning').style.display = 'none';
                    }
                    
                    document.getElementById('btnEaten').disabled = false;
                    document.getElementById('btnEaten').innerHTML = '<i class="fa-solid fa-utensils me-2"></i> BẠN ĐÃ ĂN CHƯA?';
                    document.getElementById('btnUndoEaten').style.display = 'none';

                    document.getElementById('aiResults').style.display = 'block';
                    if (selectedFile) {
                        document.getElementById('accuracyBox').style.display = 'block';
                    } else {
                        document.getElementById('accuracyBox').style.display = 'none';
                    }

                } else {
                    alert("Lỗi server!");
                }
            } catch (e) {
                console.error(e);
                alert("Có lỗi: " + e.message);
            } finally {
                // Stop scanning
                scannerBox.classList.remove('scanning');
                statusBadge.innerText = "[ LIVE ANALYSIS ]";
                statusBadge.style.color = "var(--accent-red)";
                statusBadge.style.borderColor = "var(--accent-red)";
            }
        }

        async function markAsEaten() {
            const targetCalories = parseFloat(<%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %>);
            const currentCaloriesTotal = parseFloat(document.getElementById('currentCaloriesDisplay').innerText) || 0;

            if (currentCaloriesTotal + currentAnalyzedCalories > targetCalories) {
                showErrorToast("Món ăn này sẽ làm bạn vượt quá lượng Calo mục tiêu! Hãy cân nhắc lại.");
                return;
            }

            const mealTime = document.getElementById('mealTimeSelect').value;
            
            // Check limits per mealTime
            const countSameMealTime = dailyHistory.filter(h => h.mealTime === mealTime).length;
            const limit = (mealTime === 'Ăn Vặt') ? 3 : 1;
            if (countSameMealTime >= limit) {
                showErrorToast(`Bạn đã lưu tối đa ${limit} món cho buổi ${mealTime}! Vui lòng chọn buổi khác ở TỔNG QUAN hoặc xóa bớt món cũ.`);
                return;
            }

            let mealName = "";
            let items = document.querySelectorAll('#detectedFoodsList .name');
            if (items.length > 0) {
                mealName = Array.from(items).map(i => i.innerText).join(', ');
            } else {
                mealName = "Món ăn phân tích tự động";
            }
            
            try {
                const formData = new FormData();
                formData.append('action', 'addHistory');
                formData.append('mealName', mealName);
                formData.append('calories', currentAnalyzedCalories);
                formData.append('mealTime', mealTime);
                
                const res = await fetch(contextPath + '/nutrition-data', { method: 'POST', body: formData });
                const data = await res.json();
                
                if (data.status === 'success') {
                    dailyHistory.push(data.data);
                    recalculateTotal();
                    
                    document.getElementById('btnEaten').disabled = true;
                    document.getElementById('btnEaten').innerHTML = '<i class="fa-solid fa-check me-2"></i> ĐÃ LƯU';
                    document.getElementById('btnUndoEaten').style.display = 'block';
                    document.getElementById('btnUndoEaten').dataset.id = data.data.id;
                }
            } catch (e) { console.error(e); }
        }

        function undoEaten() {
            const id = document.getElementById('btnUndoEaten').dataset.id;
            if (id) {
                deleteHistoryItem(id);
            }
        }

        function updateProgressUI(currentTotal) {
            const targetCalories = parseFloat(<%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %>);
            let remaining = targetCalories - currentTotal;
            if (remaining < 0) remaining = 0;
            
            let percent = (currentTotal / targetCalories) * 100;
            if (percent > 100) percent = 100;
            
            const progressBar = document.getElementById('mainProgressBar');
            progressBar.style.width = percent + '%';
            
            if (currentTotal > targetCalories) {
                progressBar.style.backgroundColor = 'var(--accent-red)';
                progressBar.style.boxShadow = '0 0 10px var(--accent-red)';
                document.getElementById('exceedWarningBox').style.display = 'block';
                document.getElementById('currentCaloriesDisplay').style.color = 'var(--accent-red)';
            } else {
                progressBar.style.backgroundColor = 'var(--accent-cyan)';
                progressBar.style.boxShadow = '0 0 10px var(--accent-cyan)';
                document.getElementById('exceedWarningBox').style.display = 'none';
                document.getElementById('currentCaloriesDisplay').style.color = 'white';
            }

            document.getElementById('remainingCaloriesDisplay').innerText = 'CÒN LẠI ' + Math.round(remaining) + ' KCAL';
            document.getElementById('percentGoalDisplay').innerText = Math.round(percent) + '% MỤC TIÊU';
        }

        // --- SUGGEST MEAL ---
        async function suggestMeal() {
            document.getElementById('suggestBoxContainer').style.display = 'none';
            document.getElementById('suggestPrompt').style.display = 'none';
            document.getElementById('suggestLoading').style.display = 'block';
            document.getElementById('btnSuggest').disabled = true;

            try {
                const formData = new FormData();
                formData.append('action', 'suggest');
                
                const targetCalories = parseFloat(<%= request.getAttribute("targetCalories") != null ? request.getAttribute("targetCalories") : 2400 %>);
                const currentCaloriesTotal = parseFloat(document.getElementById('currentCaloriesDisplay').innerText) || 0;
                let remaining = targetCalories - currentCaloriesTotal;
                if (remaining < 0) remaining = 0;
                formData.append('remainingCalories', Math.round(remaining));

                const response = await fetch(contextPath + '/nutrition-ai', { method: 'POST', body: formData });

                if (response.ok) {
                    const data = await response.json();
                    
                    let suggestHtml = '';
                    if (data.meals && data.meals.length > 0) {
                        suggestedMealsList = data.meals;
                        data.meals.forEach((meal, idx) => {
                            const keyword = meal.imageKeyword || "healthy delicious fitness meal";
                            const encodedKeyword = encodeURIComponent(keyword + " food meal");
                            const imgSrc = "https://tse2.mm.bing.net/th?q=" + encodedKeyword + "&w=400&h=400&c=7&rs=1&p=0";
                            
                            suggestHtml += `
                                <div class="suggestion-box mb-3" style="display: flex; flex-direction: column; background: #111; border: 1px solid var(--border-color); padding: 15px;">
                                    <div style="display: flex; gap: 15px; align-items: center;">
                                        <img src="${imgSrc}" class="suggestion-img" alt="Meal" style="width: 120px; height: 120px; object-fit: cover; border-radius: 8px; border: 1px solid var(--accent-cyan);">
                                        <div class="suggestion-content" style="flex: 1;">
                                            <h5 class="fw-bold mb-1 text-warning" style="text-transform: uppercase;">${meal.mealName || "Lỗi AI"}</h5>
                                            <div class="tech-font text-muted mb-2" style="font-size: 0.8rem;">
                                                <span class="text-danger">P: ${meal.protein || "0"}g</span> | 
                                                <span class="text-info">C: ${meal.calories || "0"} kcal</span>
                                            </div>
                                            <div style="font-size: 0.85rem; color: #bbb; line-height: 1.4;">${meal.reason || "Không có lý do."}</div>
                                        </div>
                                    </div>
                                    <div class="d-flex gap-2 mt-3 w-100">
                                        <button class="btn btn-sm text-info fw-bold flex-grow-1" style="border: 1px solid var(--accent-cyan); background: transparent;" onclick="openRecipe(${idx})">
                                            <i class="fa-solid fa-book-open"></i> CÁCH LÀM
                                        </button>
                                        <button class="btn btn-sm fw-bold flex-grow-1 text-white" id="btnSuggestEaten_${idx}" style="background: var(--accent-red); border: none;" onclick="addSuggestedMeal(${idx}, this, '${imgSrc}')">
                                            <i class="fa-solid fa-bookmark"></i> LƯU MÓN ĂN
                                        </button>
                                    </div>
                                </div>
                            `;
                        });
                    }
                    
                    document.getElementById('suggestBoxContainer').innerHTML = suggestHtml;
                    document.getElementById('suggestLoading').style.display = 'none';
                    document.getElementById('suggestBoxContainer').style.display = 'block';
                }
            } catch (e) {
                console.error(e);
                alert("Có lỗi xảy ra khi lấy gợi ý.");
                document.getElementById('suggestLoading').style.display = 'none';
                document.getElementById('suggestPrompt').style.display = 'block';
            } finally {
                document.getElementById('btnSuggest').disabled = false;
            }
        }
    </script>
</body>
</html>

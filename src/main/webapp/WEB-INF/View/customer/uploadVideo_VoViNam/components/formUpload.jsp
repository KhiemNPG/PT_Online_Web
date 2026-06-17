<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Inter', system-ui, -apple-system, sans-serif; margin: 0; }
    .header-title { font-weight: 800; letter-spacing: -0.5px; color: #ffffff; }

    /* Card & Container */
    .custom-card { background-color: #161616; border: 1px solid #2a2a2a; border-radius: 12px; padding: 20px; margin-bottom: 20px; }

    /* Upload Zone */
    .upload-zone { border: 2px dashed #333; border-radius: 10px; padding: 40px 20px; text-align: center; cursor: pointer; transition: 0.3s; background: #111; }
    .upload-zone:hover { border-color: #0dcaf0; background: #1a1a1a; }
    .icon-circle { width: 60px; height: 60px; background: #222; color: #0dcaf0; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; }

    /* AI Video Display */
    .analysis-container { position: relative; width: 100%; background: #000; border-radius: 8px; overflow: hidden; }
    #output_canvas { display: block; width: 100%; height: auto; }
    .ai-status-tag { position: absolute; top: 15px; left: 15px; background: rgba(0,0,0,0.8); padding: 8px 12px; border-radius: 6px; font-size: 13px; display: flex; align-items: center; gap: 8px; z-index: 10; }

    /* Form Elements */
    .custom-input { background-color: #0a0a0a !important; border: 1px solid #333 !important; color: white !important; width: 100%; padding: 12px; border-radius: 8px; margin: 10px 0; }
    .btn-info-custom { background-color: #0dcaf0; color: #000; border: none; border-radius: 8px; padding: 15px; font-weight: bold; width: 100%; cursor: pointer; transition: 0.3s; }
    .btn-info-custom:hover { background-color: #0bc2e9; transform: translateY(-2px); }

    /* History Styles */
    .history-item-box { padding: 12px; border-radius: 8px; background: #1a1a1a; transition: 0.3s; border: 1px solid transparent; display: flex; gap: 15px; margin-bottom: 12px; }
    .history-item-box:hover { background: #222; border-color: #333; transform: translateX(5px); }
    .thumb-wrapper { position: relative; width: 80px; height: 60px; flex-shrink: 0; }
    .thumb-wrapper img { width: 100%; height: 100%; object-fit: cover; border-radius: 4px; }
    .status-badge { position: absolute; top: -5px; left: -5px; font-size: 9px; padding: 2px 6px; border-radius: 4px; font-weight: bold; text-transform: uppercase; z-index: 5; }
    .waiting { background: #ffc107; color: #000; }
    .viewed { background: #0dcaf0; color: #000; }

    @keyframes pulse { 0% { opacity: 0.4; } 50% { opacity: 1; } 100% { opacity: 0.4; } }

    #speech_bubble:after {
        content: '';
        position: absolute;
        top: -15px;
        left: 50%;
        margin-left: -15px;
        border-width: 0 15px 15px;
        border-style: solid;
        border-color: #f8f9fa transparent;
        display: block; width: 0;
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/@mediapipe/pose/pose.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@mediapipe/drawing_utils/drawing_utils.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@mediapipe/camera_utils/camera_utils.js"></script>

<div class="container" style="max-width: 1200px; margin: 0 auto; padding: 40px 20px;">
    <div class="row mb-4">
        <h1 class="header-title mb-1">SMART PT - VOVINAM ANALYSIS</h1>
        <p style="color: #888;">Hệ thống tự động bù trừ góc nhìn để check đòn tay gần/xa chính xác.</p>
    </div>

    <div style="display: grid; grid-template-columns: 1.8fr 1.2fr; gap: 25px;">
        <div class="left-column">
            <div class="custom-card">
                <select class="custom-input" id="exercise_type">
                    <option value="vovinam_punch_1">Đấm thẳng (Lối 1)</option>
                </select>
                <button class="btn-info-custom" id="submit_btn" style="margin-top: 10px;">GỬI CLIP PHÂN TÍCH</button>
            </div>

            <div class="custom-card" id="upload_section">
                <div class="upload-zone" onclick="document.getElementById('video_upload').click()">
                    <div class="icon-circle"><span class="material-symbols-outlined">video_camera_back</span></div>
                    <h3>Chọn video tập luyện</h3>
                    <input type="file" id="video_upload" accept="video/*" style="display:none">
                </div>
            </div>

            <div class="custom-card" id="analysis_section" style="display:none;">
                <div class="analysis-container">
                    <canvas id="output_canvas"></canvas>
                    <div class="ai-status-tag">
                        <div style="width: 8px; height: 8px; background: #0dcaf0; border-radius: 50%; animation: pulse 1.5s infinite;"></div>
                        <span id="analysis_text" style="color: #0dcaf0;">Khởi tạo hệ thống...</span>
                    </div>
                </div>
                <video id="input_video" style="display:none;" muted playsinline></video>
                <div style="display: flex; justify-content: space-between; margin-top: 15px;">
                    <button onclick="location.reload()" style="background:none; border:1px solid #444; color:#888; cursor:pointer; padding:8px 15px; border-radius:6px;">Chọn lại</button>
                    <span id="final_score" style="font-weight: bold;"></span>
                </div>
            </div>
        </div>

        <div class="right-column">
            <div class="custom-card">
                <h5 class="header-title" style="margin-bottom:20px;">LỊCH SỬ TẢI LÊN</h5>
                <div id="history_list"></div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. Cấu hình ngưỡng (Bù trừ góc nhìn cho SmartPT)
    const PUNCH_THRESHOLDS = {
        near: { target: 160, safe_min: 150 },
        far:  { target: 145, safe_min: 135 }
    };

    const EXERCISE_CONFIG = {
        'vovinam_punch_1': {
            checks: [
                {
                    id: 'arm_extension', type: 'angle', l: 'Độ thẳng tay',
                    stand: 115,
                    msg_min: 'Tay đấm chưa đủ thẳng! Hãy duỗi hết tay.',
                },
                {
                    id: 'punch_height', type: 'y_diff', l: 'Độ cao đòn',
                    max_diff: 0.05,
                    msg_high: 'Tay quá CAO! Hạ thấp ngang vai.',
                    msg_low: 'Tay quá THẤP! Nâng tay ngang vai.'
                }
            ]
        }
    };

    // 2. Biến quản lý trạng thái
    let warningList = new Set();
    let capturedThumbnail = null;
    let punchStatus = {
        left: { isPunching: false, reachedTarget: false, reachedHeight: false, tempErrorAngle: false, tempErrorHeight: null },
        right: { isPunching: false, reachedTarget: false, reachedHeight: false, tempErrorAngle: false, tempErrorHeight: null }
    };

    let pose;
    const v = document.getElementById('input_video');
    const c = document.getElementById('output_canvas');
    const ctx = c.getContext('2d');

    // 3. Các hàm bổ trợ
    function getAngle2D(A, B, C) {
        let radians = Math.atan2(C.y - B.y, C.x - B.x) - Math.atan2(A.y - B.y, A.x - B.x);
        let angle = Math.abs(radians * 180.0 / Math.PI);
        if (angle > 180.0) angle = 360 - angle;
        return angle;
    }

    async function processFrame() {
        if (!v.paused && !v.ended) {
            await pose.send({image: v});
            if ('requestVideoFrameCallback' in v) {
                v.requestVideoFrameCallback(processFrame);
            } else {
                requestAnimationFrame(processFrame);
            }
        }
    }

    function speak(text) {
        if ('speechSynthesis' in window) {
            window.speechSynthesis.cancel(); // Dừng câu cũ nếu đang nói
            const msg = new SpeechSynthesisUtterance(text);
            msg.lang = 'vi-VN'; // Giọng tiếng Việt
            window.speechSynthesis.speak(msg);
        }
    }

function onPoseResults(res) {
    if (!res.poseLandmarks) return;
    ctx.save();
    ctx.clearRect(0, 0, c.width, c.height);
    ctx.drawImage(res.image, 0, 0, c.width, c.height);

    if (v.currentTime > 0.5 && !capturedThumbnail) {
        capturedThumbnail = c.toDataURL('image/jpeg', 0.5);
    }

    if (window.drawConnectors) {
        drawConnectors(ctx, res.poseLandmarks, POSE_CONNECTIONS, {color: '#0dcaf0', lineWidth: 2});
        drawLandmarks(ctx, res.poseLandmarks, {color: '#fff', radius: 2});
    }

    const landmarks = res.poseLandmarks;
    const leftS = landmarks[11], rightS = landmarks[12];

    // --- LOGIC TRUNG ĐIỂM VAI (CHỐNG LỆCH) ---
    const shoulderY = (leftS.y + rightS.y) / 2 - 0.025;

    const bodySide = (leftS.visibility > rightS.visibility) ? 'left' : 'right';
    const leftDistX = Math.abs(landmarks[15].x - landmarks[11].x);
    const rightDistX = Math.abs(landmarks[16].x - landmarks[12].x);
    const activeHand = (leftDistX > rightDistX) ? 'left' : 'right';
    const pIdx = activeHand === 'left' ? {s:11, e:13, w:15} : {s:12, e:14, w:16};

    const config = EXERCISE_CONFIG['vovinam_punch_1'];
    let info = [`Check: ${activeHand.toUpperCase()}`];
    let state = punchStatus[activeHand];

    // Khởi tạo bộ đếm bền vững nếu chưa có
    if (state.countHigh === undefined) { state.countHigh = 0; state.countLow = 0; }

    const A = landmarks[pIdx.s], B = landmarks[pIdx.e], C = landmarks[pIdx.w];
    if (!A || !B || !C) return;

    const ang = getAngle2D(A, B, C);

    // --- LOGIC CHU KỲ (Xác nhận lỗi khi thu tay) ---
    if (ang < config.checks[0].stand) {
        if (state.isPunching) {
            if (state.reachedTarget) {
                // CHỐT LỖI CUỐI CÙNG: So sánh bộ đếm frame
                // Nếu số frame CAO nhiều hơn THẤP và đạt ngưỡng tối thiểu (ví dụ > 3 frame)
                if (state.countHigh > state.countLow && state.countHigh > 3) {
                    warningList.add(config.checks[1].msg_high);
                } else if (state.countLow > state.countHigh && state.countLow > 3) {
                    warningList.add(config.checks[1].msg_low);
                }
            } else {
                if (state.tempErrorAngle) {
                    warningList.add(config.checks[0].msg_min);
                }
            }

            // RESET TRẠNG THÁI CHO CÚ ĐẤM KẾ TIẾP
            state.isPunching = false;
            state.reachedTarget = false;
            state.reachedHeight = false;
            state.tempErrorAngle = false;
            state.tempErrorHeight = null;
            state.countHigh = 0; // Reset đếm
            state.countLow = 0;  // Reset đếm
        }
        info.push(`<span style="color:#888;">TRẠNG THÁI: THỦ</span>`);
    } else {
        state.isPunching = true;
        const thres = (activeHand === bodySide) ? PUNCH_THRESHOLDS.near : PUNCH_THRESHOLDS.far;

        // 1. Check Độ thẳng (Giữ nguyên nhãn của Khiêm)
        let colAng = '#ffffff', txtAng = "ĐANG VƯƠN";
        if (ang >= thres.target) {
            state.reachedTarget = true;
            state.tempErrorAngle = false;
            warningList.delete(config.checks[0].msg_min);
            colAng = '#0df05b'; txtAng = "THẲNG";
        } else if (ang < thres.safe_min) {
            if (!state.reachedTarget) state.tempErrorAngle = true;
            colAng = '#ff4757'; txtAng = "CONG";
        }
        info.push(`<span style="color:${colAng};">Độ thẳng: ${Math.round(ang)}° (${txtAng})</span>`);

        // 2. Check Độ cao (Sử dụng mốc shoulderY để tính diffY)
        const diffY = C.y - shoulderY;
        let colH = '#ffffff', txtH = "ĐANG ĐẤM";

        if (Math.abs(diffY) > config.checks[1].max_diff) {
            colH = '#ff4757';
            state.reachedHeight = false;
            if (diffY < 0) {
                txtH = "CAO";
                state.countHigh++; // Tăng đếm thay vì gán trực tiếp
                state.tempErrorHeight = config.checks[1].msg_high;
            } else {
                txtH = "THẤP";
                state.countLow++;  // Tăng đếm thay vì gán trực tiếp
                state.tempErrorHeight = config.checks[1].msg_low;
            }
        } else {
            state.reachedHeight = true;
            state.tempErrorHeight = null;
            colH = '#0df05b'; txtH = "CHUẨN";
            // Khi chuẩn thì không tăng đếm, giúp "pha loãng" các frame nhiễu
        }
        info.push(`<span style="color:${colH};">Độ cao: ${txtH}</span>`);
    }

    document.getElementById('analysis_text').innerHTML = info.join(' | ');
    ctx.restore();
}

    // 4. Khởi chạy và Event Listeners
    window.onload = async () => {
        pose = new Pose({locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/pose/${file}`});
        pose.setOptions({ modelComplexity: 1, smoothLandmarks: true, minDetectionConfidence: 0.5 });
        pose.onResults(onPoseResults);

        document.getElementById('video_upload').onchange = (e) => {
            const file = e.target.files[0];
            if (file) {
                warningList.clear();
                capturedThumbnail = null;
                document.getElementById('final_score').innerText = "";
                v.src = URL.createObjectURL(file);
                document.getElementById('upload_section').style.display = 'none';
                document.getElementById('analysis_section').style.display = 'block';
                v.onloadedmetadata = () => {
                    c.width = v.videoWidth;
                    c.height = v.videoHeight;
                    v.currentTime = 0;
                    v.play();
                };
            }
        };

        v.addEventListener('play', processFrame);

        v.addEventListener('ended', () => {
            const fs = document.getElementById('final_score');
            if (warningList.size > 0) {
                fs.innerText = "⚠️ KẾT QUẢ: " + Array.from(warningList)[0];
                fs.style.color = "#ff4757";
            } else {
                fs.innerText = "✅ HOÀN HẢO: CÁC ĐÒN ĐẤM ĐÃ ĐẠT CHUẨN!";
                fs.style.color = "#0df05b";
            }
        });

        // Xử lý nút gửi dữ liệu tới Servlet
        document.getElementById('submit_btn').onclick = function() {
    if (!v.src) return alert("Vui lòng chọn video!");

    const payload = {
        type: document.getElementById('exercise_type').value,
        warnings: Array.from(warningList),
        thumb: capturedThumbnail
    };

    fetch('UpLoadVideo_VoViNam', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                // 1. Hiển thị nhận xét lên màn hình
                const box = document.getElementById('final_score');
                if(box) box.innerText = "AI nhận xét: " + data.message;

                // 2. PHÁT TIẾNG NÓI TẠI ĐÂY
                speak(data.message);
            }
        })
        .catch(err => alert("Lỗi kết nối Servlet: " + err.message));
    };
    };
</script>
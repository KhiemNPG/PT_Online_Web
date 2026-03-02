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
        <h1 class="header-title mb-1">GỬI CLIP TẬP LUYỆN</h1>
        <p style="color: #888;">Hệ thống AI sẽ tự động phân tích khung xương và check lỗi an toàn.</p>
    </div>

    <div style="display: grid; grid-template-columns: 1.8fr 1.2fr; gap: 25px;">
        <div class="left-column">

            <div class="custom-card">
                <h5 style="margin-top:0; display: flex; align-items: center; gap: 10px;">
                    <span class="material-symbols-outlined text-info" style="font-size: 20px;">analytics</span> LOẠI BÀI TẬP
                </h5>
                <select class="custom-input" id="exercise_type">
                    <option value="bicep_curl">Dumbbell Bicep Curl (Check biên độ & Vung vai)</option>
                    <option value="squat">Back Squat </option>
                    <option value="deadlift">Deadlift (Check Hông & Lưng)</option>
                    <option value="bench">Bench Press (Check biên độ tay)</option>
                    <option value="push_up">Push Up (Check Độ sâu & Thẳng lưng)</option>
                </select>

                <button class="btn-info-custom" id="submit_btn" style="margin-top: 10px;">GỬI CLIP PHÂN TÍCH</button>
            </div>

            <div class="custom-card" id="upload_section">
                <div class="upload-zone" onclick="document.getElementById('video_upload').click()">
                    <div class="icon-circle">
                        <span class="material-symbols-outlined">video_camera_back</span>
                    </div>
                    <h3>Chọn video tập luyện</h3>
                    <p style="color: #666; font-size: 0.9rem;">Hỗ trợ MP4, MOV (AI sẽ check lỗi kỹ thuật)</p>
                    <input type="file" id="video_upload" accept="video/*" style="display:none">
                </div>
            </div>

            <div class="custom-card" id="analysis_section" style="display:none;">
                <div class="analysis-container">
                    <canvas id="output_canvas"></canvas>
                    <div class="ai-status-tag">
                        <div style="width: 8px; height: 8px; background: #0dcaf0; border-radius: 50%; animation: pulse 1.5s infinite;"></div>
                        <span id="analysis_text" style="color: #0dcaf0;">Đang khởi tạo AI...</span>
                    </div>
                </div>
                <video id="input_video" style="display:none;" muted playsinline></video>
                <div style="display: flex; justify-content: space-between; margin-top: 15px;">
                    <button onclick="location.reload()" style="background:none; border:1px solid #444; color:#888; cursor:pointer; padding:8px 15px; border-radius:6px; font-size: 0.8rem;">Chọn lại video</button>
                    <span id="final_score" style="color: #0dcaf0; font-weight: bold;"></span>
                </div>
            </div>


        </div>

        <div class="right-column">
            <div class="custom-card">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h5 class="header-title" style="margin:0; font-size: 1.1rem;">LỊCH SỬ TẢI LÊN</h5>
                    <a href="#" style="color: #0dcaf0; text-decoration: none; font-size: 0.8rem;">Xem tất cả</a>
                </div>

                <div id="history_list">
                    <div class="history-item-box">
                        <div class="thumb-wrapper">
                            <div class="status-badge waiting">Chờ duyệt</div>
                            <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=150&h=100&fit=crop">
                        </div>
                        <div style="flex-grow: 1;">
                            <h6 style="margin: 0 0 5px 0; color: #fff;">Back Squat</h6>
                            <div style="color: #666; font-size: 0.75rem;">Hôm nay, 14:20</div>
                            <div style="margin-top: 5px;"><span style="color: #0dcaf0; font-size: 0.75rem; border: 1px solid #0dcaf0; padding: 1px 4px; border-radius: 3px;">AI: Đạt độ sâu</span></div>
                        </div>
                    </div>

                    <div class="history-item-box">
                        <div class="thumb-wrapper">
                            <div class="status-badge viewed">Đã xem</div>
                            <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=150&h=100&fit=crop">
                        </div>
                        <div style="flex-grow: 1;">
                            <h6 style="margin: 0 0 5px 0; color: #fff;">Deadlift Form</h6>
                            <div style="color: #666; font-size: 0.75rem;">12/02/2026</div>
                            <div style="margin-top: 5px; color: #888; font-size: 0.75rem; display: flex; align-items: center; gap: 4px;">
                                <span class="material-symbols-outlined" style="font-size: 14px;">chat</span> 1 phản hồi
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 1. Cấu hình bài tập
    const EXERCISE_CONFIG = {
        'squat': {
            checks: [
                // 1. Kiểm tra Gối (Độ sâu)
                {
                    p: [24, 26, 28], l: 'Gối', target: 100, t: 'min', is_trigger: true,
                    safe_min: 60,
                    msg_min: 'Gối gập quá sâu! Hãy dừng lại khi đùi song song với sàn để bảo vệ khớp.',
                    msg_target: 'Xuống thêm chút nữa! Hãy hạ thấp mông để đạt đủ biên độ tập luyện.'
                },

                // 2. Kiểm tra Lưng (Độ nghiêng)
                {
                    p: [12, 24, 26], l: 'Lưng', safe_min: 65, safe_max: 95, t: 'live',
                    msg_min: 'Lưng đổ quá sâu! Hãy ngẩng đầu và đẩy ngực về phía trước để lưng thẳng hơn.',
                    msg_max: 'Lưng quá đứng! Hãy đẩy mông ra sau và hạ thấp trọng tâm khi xuống.'
                },

                // 3. Kiểm tra Độ rộng gối (Check chụm gối)
                {
                    type: 'distance_ratio', p: [23, 24, 25, 26], l: 'Độ rộng gối',
                    min_ratio: 0.8, max_ratio: 1.4, t: 'live',
                    msg_min: 'Gối hơi hẹp! Hãy gồng cơ mông và đẩy đầu gối ra ngoài theo hướng mũi chân.',
                    msg_max: 'Gối mở quá rộng! Hãy khép bớt lại để lực dồn vào đùi tốt hơn.'
                },

                // 4. Kiểm tra Độ cân bằng chân (Check đứng lệch)
                {
                    type: 'distance_ratio', p: [23, 24, 27, 28], l: 'Độ cân bằng chân',
                    check_type: 'vertical_diff', max_ratio: 0.1, t: 'live',
                    msg_max: 'Chân bị lệch! Hãy điều chỉnh lại vị trí đặt chân, tránh đứng chân trước chân sau.'
                }
            ]
        },
        'push_up': {
            checks: [
                { p: [12, 14, 16], l: 'Độ sâu tay', target: 75, t: 'min' },
                { p: [12, 24, 28], l: 'Đường thẳng lưng', safe_min: 160, t: 'live', msg: 'Đừng để võng lưng!' },
                { type: 'distance_ratio', p: [11, 12, 13, 14], l: 'Độ rộng tay', min_ratio: 1.2, max_ratio: 1.8, t: 'live', msg_min: 'Tay quá hẹp!', msg_max: 'Tay quá rộng!' },
                { type: 'distance_ratio', p: [23, 24, 27, 28], l: 'Độ rộng chân', min_ratio: 0.5, max_ratio: 1.2, t: 'live', msg_min: 'Mở rộng chân ra!', msg_max: 'Khép bớt chân lại!' }
            ]
        }
    };

    // 2. Khai báo biến toàn cục
    let resultsStore = {};
    let warningList = new Set();
    let pose;
    let capturedThumbnail = null;

    const v = document.getElementById('input_video');
    const c = document.getElementById('output_canvas');
    const ctx = c.getContext('2d');

    // Hàm tính góc
    function getAngle(A, B, C) {
        let rel = Math.atan2(C.y - B.y, C.x - B.x) - Math.atan2(A.y - B.y, A.x - B.x);
        let ang = Math.abs(rel * 180 / Math.PI);
        return ang > 180 ? 360 - ang : ang;
    }

    // Hàm đọc văn bản (TTS)
    function speak(text) {
        if ('speechSynthesis' in window) {
            // 1. Hủy các câu đang đọc dở để tránh bị chồng âm
            window.speechSynthesis.cancel();

            const msg = new SpeechSynthesisUtterance();
            msg.text = text;
            msg.lang = 'vi-VN'; // Ngôn ngữ mặc định

            // 2. Lấy danh sách tất cả các giọng nói máy hỗ trợ
            const voices = window.speechSynthesis.getVoices();

            // 3. Lọc ra các giọng Tiếng Việt
            const viVoices = voices.filter(v => v.lang.includes('vi'));

            if (viVoices.length > 0) {
                /**
                 * CHỈNH GIỌNG Ở ĐÂY:
                 * viVoices[0]: Thường là giọng mặc định (Nữ)
                 * viVoices[1]: Giọng thứ 2 (nếu máy có giọng Nam hoặc giọng của hãng khác)
                 */
                msg.voice = viVoices[1] || viVoices[0];
            }

            // 4. Các thông số phụ để giọng hay hơn
            msg.rate = 0.8;  // Tốc độ (0.8 - 1.0 là vừa nghe)
            msg.pitch = 1.0; // Cao độ (1.0 là chuẩn, >1.0 là giọng cao, <1.0 là giọng trầm)
            msg.volume = 1;  // Âm lượng (0 đến 1)

            window.speechSynthesis.speak(msg);
        }
    }

    // MẸO: Đảm bảo danh sách giọng được load sẵn khi vừa vào trang
    window.speechSynthesis.onvoiceschanged = () => {
        window.speechSynthesis.getVoices();
    };

    // 3. Xử lý kết quả từ MediaPipe
    function onPoseResults(res) {
        if (!res.poseLandmarks) return;
        ctx.save();
        ctx.clearRect(0, 0, c.width, c.height);
        ctx.drawImage(res.image, 0, 0, c.width, c.height);

        if (window.drawConnectors && window.POSE_CONNECTIONS) {
            drawConnectors(ctx, res.poseLandmarks, POSE_CONNECTIONS, {color: '#0dcaf0', lineWidth: 2});
            drawLandmarks(ctx, res.poseLandmarks, {color: '#fff', radius: 2});
        }

        const type = document.getElementById('exercise_type').value;
        const config = EXERCISE_CONFIG[type];
        if (!config) return;

        let info = [];
        config.checks.forEach((chk, i) => {
            let col = '#ffffff';
            let status = "";

            if (chk.type === 'distance_ratio') {
                const p1 = res.poseLandmarks[chk.p[0]], p2 = res.poseLandmarks[chk.p[1]];
                const p3 = res.poseLandmarks[chk.p[2]], p4 = res.poseLandmarks[chk.p[3]];
                if (p1 && p2 && p3 && p4) {
                    const getDist = (a, b) => Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
                    const baseW = getDist(p1, p2);
                    let targetVal = chk.check_type === 'vertical_diff' ? Math.abs(p3.y - p4.y) : getDist(p3, p4);
                    const ratio = targetVal / baseW;
                    col = '#0df05b';
                    if (chk.min_ratio && ratio < chk.min_ratio) {
                        col = '#ff4757'; status = " (HẸP)"; warningList.add(chk.msg_min);
                    } else if (chk.max_ratio && ratio > chk.max_ratio) {
                        col = '#ff4757'; status = " (RỘNG)"; warningList.add(chk.msg_max);
                    }
                    info.push(`<span style="color:${col};">${chk.l}: ${ratio.toFixed(2)}x${status}</span>`);
                }
            } else {
                const A = res.poseLandmarks[chk.p[0]], B = res.poseLandmarks[chk.p[1]], C = res.poseLandmarks[chk.p[2]];
                if (A && B && C && B.visibility > 0.5) {
                    const ang = getAngle(A, B, C);
                    resultsStore[i] = ang;
                    if (chk.safe_min !== undefined && ang < chk.safe_min) {
                        col = '#ff4757'; status = " (THẤP)"; warningList.add(chk.msg_min);
                    } else if (chk.target !== undefined) {
                        const reached = chk.t === 'min' ? (ang <= chk.target) : (ang >= chk.target);
                        col = reached ? '#0df05b' : '#ffffff';
                    }
                    info.push(`<span style="color:${col};">${chk.l}: ${Math.round(ang)}°</span>`);
                }
            }
        });
        document.getElementById('analysis_text').innerHTML = info.join(' | ');
        if (v.currentTime > 1 && !capturedThumbnail) capturedThumbnail = c.toDataURL('image/jpeg');
        ctx.restore();
    }

    // 4. Khởi chạy
    window.onload = async () => {
        pose = new Pose({locateFile: (file) => `https://cdn.jsdelivr.net/npm/@mediapipe/pose/${file}`});
        pose.setOptions({ modelComplexity: 1, smoothLandmarks: true, minDetectionConfidence: 0.5 });
        pose.onResults(onPoseResults);

        document.getElementById('video_upload').addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                warningList.clear();
                capturedThumbnail = null;
                v.src = URL.createObjectURL(file);
                document.getElementById('upload_section').style.display = 'none';
                document.getElementById('analysis_section').style.display = 'block';
                v.onloadedmetadata = () => {
                    c.width = v.videoWidth; c.height = v.videoHeight;
                    v.play();
                };
            }
        });

        async function runAI() {
            if (!v.paused && !v.ended) {
                await pose.send({image: v});
                requestAnimationFrame(runAI);
            }
        }
        v.addEventListener('play', runAI);
        v.addEventListener('ended', () => {
            document.getElementById('final_score').innerText = warningList.size > 0 ? "⚠️ CẦN CHÚ Ý!" : "✅ HOÀN HẢO!";
        });

        // NÚT GỬI DATA
        document.getElementById('submit_btn').onclick = function() {
            if (!v.src) return alert("Vui lòng chọn video!");

            const finalData = {
                type: document.getElementById('exercise_type').value,
                warnings: Array.from(warningList),
                results: resultsStore,
                thumb: capturedThumbnail
            };

            fetch('UpLoadVideo', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(finalData)
            })
            .then(res => res.json())
            .then(data => {
            if (data.status === 'success') {
                // Cập nhật text vào một div có id là 'final_comment' trên giao diện
                const commentBox = document.getElementById('final_comment');
                if(commentBox) {
                    commentBox.innerText = data.message;
                    commentBox.style.color = "#0df05b"; // Cho màu xanh cho đẹp
                }

                // Gọi hàm đọc
                speak(data.message);
            }
        })
            .catch(err => alert("Lỗi kết nối Server!"));
        };
    };
</script>
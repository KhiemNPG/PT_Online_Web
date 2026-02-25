<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BMI Section</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body{background:#0f0f0f;font-family:Arial,sans-serif;}
        .bmi-section{padding:100px 0;}
        .bmi-title{font-size:48px;font-weight:900;font-style:italic;text-transform:uppercase;color:white;}
        .bmi-title span{color:#f90606;text-shadow:0 0 20px rgba(249,6,6,.6);}
        .bmi-desc{color:#aaa;margin:20px 0 40px;max-width:500px;}
        .feature{display:flex;gap:15px;margin-bottom:25px;color:white;}
        .icon-box{width:45px;height:45px;background:rgba(249,6,6,.1);border-radius:10px;display:flex;align-items:center;justify-content:center;}
        .icon-box i{color:#f90606;font-size:20px;}

        .bmi-card{background:#1c1c1c;padding:40px;border-radius:20px;box-shadow:0 0 30px rgba(249,6,6,.15);color:white;}
        .bmi-card label{font-size:12px;color:#aaa;text-transform:uppercase;margin-bottom:6px;}
        .bmi-card input,.bmi-card select{
            width:100%;padding:14px;border-radius:14px;border:1px solid #333;
            background:#111;color:white;font-size:16px;font-weight:bold;
        }
        .bmi-card input:focus,.bmi-card select:focus{
            outline:none;border-color:#f90606;box-shadow:0 0 8px rgba(249,6,6,.4);
        }

        .btn-bmi{width:100%;margin-top:25px;padding:16px;border-radius:16px;background:#f90606;border:none;color:white;font-weight:900;}
        .btn-bmi:hover{background:#c10505;}

        .result-box{margin-top:40px;border-top:1px solid #333;padding-top:30px;}
        .result-top{display:flex;justify-content:space-between;align-items:center;}
        .result-top h3{font-size:32px;font-style:italic;}
        .badge-custom{padding:6px 18px;border-radius:50px;font-size:12px;font-weight:900;text-transform:uppercase;}
        .result-text{color:#bbb;margin:20px 0;}
        .btn-white{display:block;text-align:center;background:white;color:black;padding:14px;border-radius:16px;font-weight:900;text-decoration:none;}
        .btn-white:hover{background:#ddd;}
    </style>
</head>

<body>

<section class="bmi-section">
    <div class="container">
        <div class="row align-items-center g-5">

            <!-- LEFT -->
            <div class="col-lg-6">
                <h2 class="bmi-title">
                    KIỂM TRA <br><span>THỂ TRẠNG</span> CỦA BẠN
                </h2>

                <p class="bmi-desc">
                    Chỉ số BMI (Body Mass Index) là bước đầu tiên để hiểu rõ cơ thể mình.
                    Hãy nhập thông số để nhận ngay đánh giá sơ bộ và lời khuyên tập luyện chuyên sâu.
                </p>

                <div class="feature">
                    <div class="icon-box">
                        <i class="bi bi-graph-up"></i>
                    </div>
                    <div>
                        <h6>Phân tích chuẩn xác</h6>
                        <small>Dựa trên tiêu chuẩn quốc tế về chỉ số khối cơ thể.</small>
                    </div>
                </div>

                <div class="feature">
                    <div class="icon-box">
                        <i class="bi bi-lightning-fill"></i>
                    </div>
                    <div>
                        <h6>Kết quả tức thì</h6>
                        <small>Nhận lộ trình tập luyện đề xuất ngay sau khi tính toán.</small>
                    </div>
                </div>
            </div>

            <!-- RIGHT -->
            <div class="col-lg-6">
                <div class="bmi-card">

                    <div class="row g-3">

                        <div class="col-6">
                            <label>Tuổi</label>
                            <input id="age"
                                   type="number"
                                   min="2"
                                   max="120"
                                   step="1"
                                   oninput="this.value = this.value.replace(/[^0-9]/g,'')">
                        </div>

                        <div class="col-6">
                            <label>Chuẩn tính</label>
                            <select id="standard">
                                <option value="ASIA">Châu Á</option>
                                <option value="WHO">Quốc tế (WHO)</option>
                            </select>
                        </div>

                        <div class="col-6">
                            <label>Chiều cao (cm)</label>
                            <input id="height"
                                   type="number"
                                   step="0.1"
                                   min="30"
                                   max="300">
                        </div>

                        <div class="col-6">
                            <label>Cân nặng (kg)</label>
                            <input id="weight"
                                   type="number"
                                   step="0.1"
                                   min="2"
                                   max="500">
                        </div>

                    </div>

                    <button onclick="calculateBMI()" class="btn-bmi">
                        TÍNH TOÁN BMI
                    </button>

                    <div id="errorBox" class="alert alert-danger mt-3 d-none"></div>

                    <div id="resultSection" class="result-box d-none">

                        <div class="result-top">
                            <div>
                                <small>KẾT QUẢ CỦA BẠN</small>
                                <h3 id="bmiValue">BMI: --</h3>
                            </div>
                            <span id="bmiBadge" class="badge-custom">--</span>
                        </div>

                        <p id="bmiAdvice" class="result-text"></p>

                        <a href="${pageContext.request.contextPath}/goal-check" class="btn-white">
                            NHẬN LỘ TRÌNH TẬP LUYỆN PHÙ HỢP →
                        </a>

                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<script>
    function calculateBMI(){

        let age=parseInt(document.getElementById("age").value);
        let height=parseFloat(document.getElementById("height").value);
        let weight=parseFloat(document.getElementById("weight").value);
        let standard=document.getElementById("standard").value;

        let errorBox=document.getElementById("errorBox");
        let resultSection=document.getElementById("resultSection");

// reset UI
        errorBox.classList.add("d-none");
        resultSection.classList.add("d-none");

// ===== VALIDATE =====

        if(isNaN(height) || isNaN(weight)){
            showError("Vui lòng nhập chiều cao và cân nặng.");
            return;
        }

        if(height < 30 || height > 300){
            showError("Chiều cao phải từ 30 - 300 cm.");
            return;
        }

        if(weight < 2 || weight > 500){
            showError("Cân nặng phải từ 2 - 500 kg.");
            return;
        }

        if(!isNaN(age)){
            if(age < 2 || age > 120){
                showError("Tuổi phải từ 2 - 120.");
                return;
            }
        }

// ===== TÍNH BMI =====
        let bmi=weight/((height/100)*(height/100));
        bmi=Math.round(bmi*100)/100;

        let status="";
        let advice="";
        let badge=document.getElementById("bmiBadge");

// ===== TRẺ EM =====
        if(!isNaN(age) && age>=2 && age<=18){

            if(bmi<14){
                status="Thiếu cân (Trẻ em)";
                advice="Trẻ đang thiếu cân. Nên bổ sung dinh dưỡng đầy đủ, tăng đạm và tham khảo ý kiến bác sĩ nếu cần.";
            }
            else if(bmi<17){
                status="Cân nặng bình thường (Trẻ em)";
                advice="Cân nặng phù hợp với độ tuổi. Duy trì chế độ ăn cân bằng và vận động thường xuyên.";
            }
            else if(bmi<19){
                status="Thừa cân (Trẻ em)";
                advice="Có dấu hiệu thừa cân. Nên hạn chế đồ ngọt, nước ngọt và tăng vận động thể chất.";
            }
            else{
                status="Béo phì (Trẻ em)";
                advice="Trẻ có nguy cơ béo phì. Nên xây dựng chế độ dinh dưỡng hợp lý và theo dõi tăng trưởng định kỳ.";
            }

        }
        else{

            if(standard==="WHO"){

                if(bmi<18.5){
                    status="Thiếu cân";
                    advice="Bạn đang thiếu cân. Nên tăng protein và tập sức mạnh để cải thiện thể trạng.";
                }
                else if(bmi<25){
                    status="Bình thường";
                    advice="Chỉ số tốt. Hãy duy trì lối sống lành mạnh và tập luyện đều đặn.";
                }
                else if(bmi<30){
                    status="Thừa cân";
                    advice="Bạn đang thừa cân. Nên tăng cardio và kiểm soát calo.";
                }
                else if(bmi<35){
                    status="Béo phì độ I";
                    advice="Béo phì độ I. Cần kế hoạch giảm cân rõ ràng.";
                }
                else if(bmi<40){
                    status="Béo phì độ II";
                    advice="Béo phì độ II. Nên theo dõi sức khỏe định kỳ.";
                }
                else{
                    status="Béo phì độ III";
                    advice="Béo phì độ III. Khuyến nghị tham khảo chuyên gia y tế.";
                }

            }
            else{

                if(bmi<18.5){
                    status="Thiếu cân";
                    advice="Bạn đang thiếu cân. Nên bổ sung dinh dưỡng và tập tạ nhẹ.";
                }
                else if(bmi<23){
                    status="Bình thường";
                    advice="Chỉ số lý tưởng theo chuẩn Châu Á.";
                }
                else if(bmi<25){
                    status="Thừa cân";
                    advice="Bạn bắt đầu thừa cân. Hạn chế tinh bột xấu.";
                }
                else if(bmi<30){
                    status="Béo phì độ I";
                    advice="Béo phì độ I. Cần tăng cardio và kiểm soát calo.";
                }
                else if(bmi<40){
                    status="Béo phì độ II";
                    advice="Béo phì độ II. Nên xây dựng kế hoạch giảm cân nghiêm túc.";
                }
                else{
                    status="Béo phì độ III";
                    advice="Béo phì độ III. Cần tư vấn chuyên gia.";
                }

            }

        }

// ===== SET MÀU THEO JAVA =====
        let color="#64748b";
        if(bmi<18.5) color="#3b82f6";
        else if(bmi<23) color="#22c55e";
        else if(bmi<25) color="#facc15";
        else if(bmi<30) color="#f97316";
        else color="#ef4444";

        badge.innerText=status;
        badge.style.background=color+"20";
        badge.style.color=color;
        badge.style.border="1px solid "+color;

        document.getElementById("bmiValue").innerText="BMI: "+bmi;
        document.getElementById("bmiAdvice").innerText=advice;

        resultSection.classList.remove("d-none");
    }

    function showError(message){
        let errorBox=document.getElementById("errorBox");
        errorBox.innerText=message;
        errorBox.classList.remove("d-none");
    }
</script>
</body>
</html>

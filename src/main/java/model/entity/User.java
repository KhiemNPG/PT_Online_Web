package model.entity;

public class User {

    private int userId;
    private int accountId;
    private String name;
    private Integer age;
    private String gender;
    private Double height;   // cm
    private Double weight;   // kg
    private String fitnessLevel;

    public User() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public Double getHeight() { return height; }
    public void setHeight(Double height) { this.height = height; }

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public String getFitnessLevel() { return fitnessLevel; }
    public void setFitnessLevel(String fitnessLevel) { this.fitnessLevel = fitnessLevel; }

    public Double getBmi() {

        if (height == null || weight == null) return null;

        if (height <= 0 || weight <= 0) return null;

        double h = height / 100.0;
        double bmi = weight / (h * h);

        return Math.round(bmi * 100.0) / 100.0;
    }


    public String getBmiStatus(String standard) {

        Double bmi = getBmi();
        if (bmi == null) return null;

        // ===== TRẺ EM 2–18 =====
        if (age != null && age >= 2 && age <= 18) {

            if (bmi < 14) return "Thiếu cân (Trẻ em)";
            else if (bmi < 17) return "Cân nặng bình thường (Trẻ em)";
            else if (bmi < 19) return "Thừa cân (Trẻ em)";
            else return "Béo phì (Trẻ em)";
        }


        if ("WHO".equalsIgnoreCase(standard)) {

            if (bmi < 18.5) return "Thiếu cân";
            else if (bmi < 25) return "Bình thường";
            else if (bmi < 30) return "Thừa cân";
            else if (bmi < 35) return "Béo phì độ I";
            else if (bmi < 40) return "Béo phì độ II";
            else return "Béo phì độ III";

        } else {

            if (bmi < 18.5) return "Thiếu cân";
            else if (bmi < 23) return "Bình thường";
            else if (bmi < 25) return "Thừa cân";
            else if (bmi < 30) return "Béo phì độ I";
            else if (bmi < 40) return "Béo phì độ II";
            else return "Béo phì độ III";
        }
    }

    public String getBmiAdvice(String standard) {

        Double bmi = getBmi();
        if (bmi == null) return null;

        if (age != null && age >= 2 && age <= 18) {

            if (bmi < 14)
                return "Trẻ đang thiếu cân. Nên bổ sung dinh dưỡng đầy đủ, tăng đạm và tham khảo ý kiến bác sĩ nếu cần.";

            else if (bmi < 17)
                return "Cân nặng phù hợp với độ tuổi. Duy trì chế độ ăn cân bằng và vận động thường xuyên.";

            else if (bmi < 19)
                return "Có dấu hiệu thừa cân. Nên hạn chế đồ ngọt, nước ngọt và tăng vận động thể chất.";

            else
                return "Trẻ có nguy cơ béo phì. Nên xây dựng chế độ dinh dưỡng hợp lý và theo dõi tăng trưởng định kỳ.";
        }


        if ("WHO".equalsIgnoreCase(standard)) {

            if (bmi < 18.5)
                return "Bạn đang thiếu cân. Nên tăng protein và tập sức mạnh để cải thiện thể trạng.";

            else if (bmi < 25)
                return "Chỉ số tốt. Hãy duy trì lối sống lành mạnh và tập luyện đều đặn.";

            else if (bmi < 30)
                return "Bạn đang thừa cân. Nên tăng cardio và kiểm soát calo.";

            else if (bmi < 35)
                return "Béo phì độ I. Cần kế hoạch giảm cân rõ ràng.";

            else if (bmi < 40)
                return "Béo phì độ II. Nên theo dõi sức khỏe định kỳ.";

            else
                return "Béo phì độ III. Khuyến nghị tham khảo chuyên gia y tế.";

        } else {

            if (bmi < 18.5)
                return "Bạn đang thiếu cân. Nên bổ sung dinh dưỡng và tập tạ nhẹ.";

            else if (bmi < 23)
                return "Chỉ số lý tưởng theo chuẩn Châu Á.";

            else if (bmi < 25)
                return "Bạn bắt đầu thừa cân. Hạn chế tinh bột xấu.";

            else if (bmi < 30)
                return "Béo phì độ I. Cần tăng cardio và kiểm soát calo.";

            else if (bmi < 40)
                return "Béo phì độ II. Nên xây dựng kế hoạch giảm cân nghiêm túc.";

            else
                return "Béo phì độ III. Cần tư vấn chuyên gia.";
        }
    }


    public String getBmiColor() {

        Double bmi = getBmi();
        if (bmi == null) return "#64748b";

        if (bmi < 18.5) return "#3b82f6";
        else if (bmi < 23) return "#22c55e";
        else if (bmi < 25) return "#facc15";
        else if (bmi < 30) return "#f97316";
        else return "#ef4444";
    }


    public int getBmiPercent() {

        Double bmi = getBmi();
        if (bmi == null) return 0;

        double percent = (bmi / 40.0) * 100.0;
        if (percent > 100) percent = 100;
        if (percent < 0) percent = 0;

        return (int) percent;
    }

    // ================== CONSTRUCTOR ==================

    public User(int userId, int accountId, String name, Integer age,
                String gender, Double height, Double weight,
                String fitnessLevel) {

        this.userId = userId;
        this.accountId = accountId;
        this.name = name;
        this.age = age;
        this.gender = gender;
        this.height = height;
        this.weight = weight;
        this.fitnessLevel = fitnessLevel;
    }
}

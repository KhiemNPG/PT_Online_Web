package dao;

import model.training.TrainingDay;
import model.training.TrainingSchedule;
import utils.DBContext;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TrainingScheduleDAO extends DBContext {

    public TrainingSchedule getOneTrainingScheduleFromTemplate(String goal, String gender, String ageRange) {
        String sql = "SELECT * FROM MasterSchedule WHERE goal=? AND gender=? AND ageRange=?";

        // Nhét thẳng vào đây, không cần biến bên ngoài, không cần .close()
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, goal);
            ps.setString(2, gender);
            ps.setString(3, ageRange);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TrainingSchedule(
                            rs.getInt("masterScheduleId"),
                            rs.getString("name"),
                            goal, "kHONG", gender, ageRange,
                            rs.getInt("totalWeeks"),
                            "Không"
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createTrainingSchedule(TrainingSchedule trainingSchedule, int userId) {
        // 1. Giữ nguyên câu SQL
        String sql = "INSERT INTO UserSchedule (userId, name, goal, fitnessLevel, gender, ageRange, totalWeeks, masterScheduleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        // 2. THÊM Statement.RETURN_GENERATED_KEYS ở đây
        try (PreparedStatement stmtProduct = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            stmtProduct.setInt(1, userId);
            stmtProduct.setString(2, trainingSchedule.getName());
            stmtProduct.setString(3, trainingSchedule.getGoal());
            stmtProduct.setString(4, trainingSchedule.getFitnessLevel());
            stmtProduct.setString(5, trainingSchedule.getGender());
            stmtProduct.setString(6, trainingSchedule.getAgeRange());
            stmtProduct.setInt(7, trainingSchedule.getTotalWeeks());
            stmtProduct.setInt(8, trainingSchedule.getMasterScheduleId());

            int affectedRows = stmtProduct.executeUpdate();

            // 3. Nếu chèn thành công, lấy ID ra
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmtProduct.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Trả về ID vừa tạo (ví dụ: 10, 11, 12...)
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu có lỗi
    }

    public List<TrainingSchedule> getAllTrainingSchedule(int userId) {
        List<TrainingSchedule> trainingScheduleList = new ArrayList<>();
        // 1. Thêm status vào câu lệnh SQL
        String sql = "SELECT * "
                + "FROM UserSchedule "
                + "WHERE userId = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo object và gán dữ liệu
                    TrainingSchedule ts = new TrainingSchedule(
                            rs.getInt("userScheduleId"),
                            rs.getString("name"),
                            rs.getString("goal"),
                            rs.getString("fitnessLevel"),
                            rs.getString("gender"),
                            rs.getString("ageRange"),
                            rs.getInt("totalWeeks"),
                            rs.getString("status"),
                            rs.getInt("masterScheduleId")
                    );

                    trainingScheduleList.add(ts);
                }
            }
        } catch (SQLException e) {
            // Thay vì chỉ in message, hãy in stack trace để biết lỗi ở dòng nào
            e.printStackTrace();
        }
        return trainingScheduleList;
    }

}
